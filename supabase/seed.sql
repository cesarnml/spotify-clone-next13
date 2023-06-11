
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES ('00000000-0000-0000-0000-000000000000', 'c2943212-1068-4384-b2cb-31d54d3cdd09', '{"action":"user_signedup","actor_id":"97f5fa31-44b9-467f-8add-018a62166d66","actor_name":"Cesar Napoleon Mejia Leiva","actor_username":"cmejia@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"github"}}', '2023-06-11 16:49:10.907554+00', '');

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at") VALUES ('00000000-0000-0000-0000-000000000000', '97f5fa31-44b9-467f-8add-018a62166d66', 'authenticated', 'authenticated', 'cmejia@gmail.com', '', '2023-06-11 16:49:10.90881+00', NULL, '', NULL, '', NULL, '', '', NULL, '2023-06-11 16:49:12.09854+00', '{"provider": "github", "providers": ["github"]}', '{"iss": "https://api.github.com", "sub": "26180499", "name": "Cesar Napoleon Mejia Leiva", "email": "cmejia@gmail.com", "full_name": "Cesar Napoleon Mejia Leiva", "user_name": "cesarnml", "avatar_url": "https://avatars.githubusercontent.com/u/26180499?v=4", "provider_id": "26180499", "email_verified": true, "preferred_username": "cesarnml"}', NULL, '2023-06-11 16:49:10.898577+00', '2023-06-11 16:49:12.105728+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL);

INSERT INTO "auth"."identities" ("id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at") VALUES ('26180499', '97f5fa31-44b9-467f-8add-018a62166d66', '{"iss": "https://api.github.com", "sub": "26180499", "name": "Cesar Napoleon Mejia Leiva", "email": "cmejia@gmail.com", "full_name": "Cesar Napoleon Mejia Leiva", "user_name": "cesarnml", "avatar_url": "https://avatars.githubusercontent.com/u/26180499?v=4", "provider_id": "26180499", "email_verified": true, "preferred_username": "cesarnml"}', 'github', '2023-06-11 16:49:10.905592+00', '2023-06-11 16:49:10.905627+00', '2023-06-11 16:49:10.905627+00');

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after") VALUES ('299c8f7b-8636-4b2e-ae85-9950f9c0a626', '97f5fa31-44b9-467f-8add-018a62166d66', '2023-06-11 16:49:12.098607+00', '2023-06-11 16:49:12.098607+00', NULL, 'aal1', NULL);

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES ('299c8f7b-8636-4b2e-ae85-9950f9c0a626', '2023-06-11 16:49:12.108482+00', '2023-06-11 16:49:12.108482+00', 'oauth', '9759d597-9789-48f3-8536-fa90e5905932');

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES ('00000000-0000-0000-0000-000000000000', 1, 'qHFS7tGeNr4Xu39qdnNFTA', '97f5fa31-44b9-467f-8add-018a62166d66', false, '2023-06-11 16:49:12.101622+00', '2023-06-11 16:49:12.101622+00', NULL, '299c8f7b-8636-4b2e-ae85-9950f9c0a626');

INSERT INTO "public"."users" ("id", "full_name", "avatar_url", "billing_address", "payment_method") VALUES ('97f5fa31-44b9-467f-8add-018a62166d66', 'Cesar Napoleon Mejia Leiva', 'https://avatars.githubusercontent.com/u/26180499?v=4', NULL, NULL);

INSERT INTO "public"."songs" ("id", "created_at", "title", "song_path", "image_path", "author", "user_id") VALUES ('61d78755-38f3-46be-8064-b11388d549fe', '2023-06-11 16:52:44.489995+00', 'Title', 'song-Title-lirnyoom', 'image-Title-lirnyoom', 'Authro', '97f5fa31-44b9-467f-8add-018a62166d66');

INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types") VALUES ('songs', 'songs', NULL, '2023-06-11 16:51:58.124233+00', '2023-06-11 16:51:58.124233+00', true, false, NULL, NULL);
INSERT INTO "storage"."buckets" ("id", "name", "owner", "created_at", "updated_at", "public", "avif_autodetection", "file_size_limit", "allowed_mime_types") VALUES ('images', 'images', NULL, '2023-06-11 16:52:06.204716+00', '2023-06-11 16:52:06.204716+00', true, false, NULL, NULL);

INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version") VALUES ('b20ae1f5-cd12-4a70-8bb8-3a5d92f34194', 'songs', 'song-Title-lirnyoom', '97f5fa31-44b9-467f-8add-018a62166d66', '2023-06-11 16:52:44.440664+00', '2023-06-11 16:52:44.440664+00', '2023-06-11 16:52:44.440664+00', '{"eTag": "\"0f0806859347bc451abf28315ac8071d\"", "size": 2710037, "mimetype": "audio/mpeg", "cacheControl": "max-age=3600", "lastModified": "2023-06-11T16:52:44.406Z", "contentLength": 2710037, "httpStatusCode": 200}', '27edf074-8481-432b-9ea8-29c261349f79');
INSERT INTO "storage"."objects" ("id", "bucket_id", "name", "owner", "created_at", "updated_at", "last_accessed_at", "metadata", "version") VALUES ('1af0076d-6fb5-4f75-ac3e-4590f01bde46', 'images', 'image-Title-lirnyoom', '97f5fa31-44b9-467f-8add-018a62166d66', '2023-06-11 16:52:44.474789+00', '2023-06-11 16:52:44.474789+00', '2023-06-11 16:52:44.474789+00', '{"eTag": "\"e338ed6ff7a55a7ae7a619409fff35e5\"", "size": 40429, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2023-06-11T16:52:44.472Z", "contentLength": 40429, "httpStatusCode": 200}', 'e0ea5798-5985-42e7-91eb-c8f3c43eff96');

INSERT INTO "supabase_migrations"."schema_migrations" ("version") VALUES ('20230606182318');

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 1, true);

SELECT pg_catalog.setval('"supabase_functions"."hooks_id_seq"', 1, false);

RESET ALL;
