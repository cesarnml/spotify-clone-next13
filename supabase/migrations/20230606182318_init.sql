CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION handle_new_user();


create type "public"."pricing_plan_interval" as enum ('day', 'week', 'month', 'year');

create type "public"."pricing_type" as enum ('one_time', 'recurring');

create type "public"."subscription_status" as enum ('trialing', 'active', 'canceled', 'incomplete', 'incomplete_expired', 'past_due', 'unpaid');

create table "public"."customers" (
    "id" uuid not null,
    "stripe_customer_id" text
);


alter table "public"."customers" enable row level security;

create table "public"."liked_songs" (
    "user_id" uuid not null,
    "created_at" timestamp with time zone default now(),
    "song_id" uuid not null
);


alter table "public"."liked_songs" enable row level security;

create table "public"."prices" (
    "id" text not null,
    "product_id" text,
    "active" boolean,
    "description" text,
    "unit_amount" bigint,
    "currency" text,
    "type" pricing_type,
    "interval" pricing_plan_interval,
    "interval_count" integer,
    "trial_period_days" integer,
    "metadata" jsonb
);


alter table "public"."prices" enable row level security;

create table "public"."products" (
    "id" text not null,
    "active" boolean,
    "name" text,
    "description" text,
    "image" text,
    "metadata" jsonb
);


alter table "public"."products" enable row level security;

create table "public"."songs" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone default now(),
    "title" text default ''::text,
    "song_path" text default ''::text,
    "image_path" text default ''::text,
    "author" text default ''::text,
    "user_id" uuid
);


alter table "public"."songs" enable row level security;

create table "public"."subscriptions" (
    "id" text not null,
    "user_id" uuid not null,
    "status" subscription_status,
    "metadata" jsonb,
    "price_id" text,
    "quantity" integer,
    "cancel_at_period_end" boolean,
    "created" timestamp with time zone not null default timezone('utc'::text, now()),
    "current_period_start" timestamp with time zone not null default timezone('utc'::text, now()),
    "current_period_end" timestamp with time zone not null default timezone('utc'::text, now()),
    "ended_at" timestamp with time zone default timezone('utc'::text, now()),
    "cancel_at" timestamp with time zone default timezone('utc'::text, now()),
    "canceled_at" timestamp with time zone default timezone('utc'::text, now()),
    "trial_start" timestamp with time zone default timezone('utc'::text, now()),
    "trial_end" timestamp with time zone default timezone('utc'::text, now())
);


alter table "public"."subscriptions" enable row level security;

create table "public"."users" (
    "id" uuid not null,
    "full_name" text,
    "avatar_url" text,
    "billing_address" jsonb,
    "payment_method" jsonb
);


alter table "public"."users" enable row level security;

CREATE UNIQUE INDEX customers_pkey ON public.customers USING btree (id);

CREATE UNIQUE INDEX liked_songs_pkey ON public.liked_songs USING btree (user_id, song_id);

CREATE UNIQUE INDEX prices_pkey ON public.prices USING btree (id);

CREATE UNIQUE INDEX products_pkey ON public.products USING btree (id);

CREATE UNIQUE INDEX songs_pkey ON public.songs USING btree (id);

CREATE UNIQUE INDEX subscriptions_pkey ON public.subscriptions USING btree (id);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

alter table "public"."customers" add constraint "customers_pkey" PRIMARY KEY using index "customers_pkey";

alter table "public"."liked_songs" add constraint "liked_songs_pkey" PRIMARY KEY using index "liked_songs_pkey";

alter table "public"."prices" add constraint "prices_pkey" PRIMARY KEY using index "prices_pkey";

alter table "public"."products" add constraint "products_pkey" PRIMARY KEY using index "products_pkey";

alter table "public"."songs" add constraint "songs_pkey" PRIMARY KEY using index "songs_pkey";

alter table "public"."subscriptions" add constraint "subscriptions_pkey" PRIMARY KEY using index "subscriptions_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."customers" add constraint "customers_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) not valid;

alter table "public"."customers" validate constraint "customers_id_fkey";

alter table "public"."liked_songs" add constraint "liked_songs_song_id_fkey" FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE not valid;

alter table "public"."liked_songs" validate constraint "liked_songs_song_id_fkey";

alter table "public"."liked_songs" add constraint "liked_songs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."liked_songs" validate constraint "liked_songs_user_id_fkey";

alter table "public"."prices" add constraint "prices_currency_check" CHECK ((char_length(currency) = 3)) not valid;

alter table "public"."prices" validate constraint "prices_currency_check";

alter table "public"."prices" add constraint "prices_product_id_fkey" FOREIGN KEY (product_id) REFERENCES products(id) not valid;

alter table "public"."prices" validate constraint "prices_product_id_fkey";

alter table "public"."songs" add constraint "songs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE not valid;

alter table "public"."songs" validate constraint "songs_user_id_fkey";

alter table "public"."subscriptions" add constraint "subscriptions_price_id_fkey" FOREIGN KEY (price_id) REFERENCES prices(id) not valid;

alter table "public"."subscriptions" validate constraint "subscriptions_price_id_fkey";

alter table "public"."subscriptions" add constraint "subscriptions_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."subscriptions" validate constraint "subscriptions_user_id_fkey";

alter table "public"."users" add constraint "users_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) not valid;

alter table "public"."users" validate constraint "users_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_new_user()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
  begin
    insert into public.users (id, full_name, avatar_url)
    values (new.id, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
    return new;
  end;
$function$
;

create policy "Enable delete for users based on user_id"
on "public"."liked_songs"
as permissive
for delete
to public
using ((auth.uid() = user_id));


create policy "Enable insert for authenticated users only"
on "public"."liked_songs"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for all users"
on "public"."liked_songs"
as permissive
for select
to public
using (true);


create policy "Allow public read-only access."
on "public"."prices"
as permissive
for select
to public
using (true);


create policy "Allow public read-only access."
on "public"."products"
as permissive
for select
to public
using (true);


create policy "Enable insert for authenticated users only"
on "public"."songs"
as permissive
for insert
to authenticated
with check (true);


create policy "Enable read access for all users"
on "public"."songs"
as permissive
for select
to public
using (true);


create policy "Can only view own subs data."
on "public"."subscriptions"
as permissive
for select
to public
using ((auth.uid() = user_id));


create policy "Can update own user data."
on "public"."users"
as permissive
for update
to public
using ((auth.uid() = id));


create policy "Can view own user data."
on "public"."users"
as permissive
for select
to public
using ((auth.uid() = id));



create policy "allow_all 1ffg0oo_0"
on "storage"."objects"
as permissive
for select
to public
using ((bucket_id = 'images'::text));


create policy "allow_all 1ffg0oo_1"
on "storage"."objects"
as permissive
for insert
to public
with check ((bucket_id = 'images'::text));


create policy "allow_all 1ffg0oo_2"
on "storage"."objects"
as permissive
for update
to public
using ((bucket_id = 'images'::text));


create policy "allow_all 1ffg0oo_3"
on "storage"."objects"
as permissive
for delete
to public
using ((bucket_id = 'images'::text));


create policy "allow_all 1t9jwe_0"
on "storage"."objects"
as permissive
for insert
to public
with check ((bucket_id = 'songs'::text));


create policy "allow_all 1t9jwe_1"
on "storage"."objects"
as permissive
for select
to public
using ((bucket_id = 'songs'::text));


create policy "allow_all 1t9jwe_2"
on "storage"."objects"
as permissive
for update
to public
using ((bucket_id = 'songs'::text));


create policy "allow_all 1t9jwe_3"
on "storage"."objects"
as permissive
for delete
to public
using ((bucket_id = 'songs'::text));




