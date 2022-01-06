BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "accounts_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	bigint NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "accounts_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "accounts_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(150) NOT NULL,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"is_email_verified"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	bigint NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "social_auth_association" (
	"id"	integer NOT NULL,
	"server_url"	varchar(255) NOT NULL,
	"handle"	varchar(255) NOT NULL,
	"secret"	varchar(255) NOT NULL,
	"issued"	integer NOT NULL,
	"lifetime"	integer NOT NULL,
	"assoc_type"	varchar(64) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "social_auth_nonce" (
	"id"	integer NOT NULL,
	"server_url"	varchar(255) NOT NULL,
	"timestamp"	integer NOT NULL,
	"salt"	varchar(65) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "social_auth_code" (
	"id"	integer NOT NULL,
	"email"	varchar(254) NOT NULL,
	"code"	varchar(32) NOT NULL,
	"verified"	bool NOT NULL,
	"timestamp"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "social_auth_partial" (
	"id"	integer NOT NULL,
	"token"	varchar(32) NOT NULL,
	"next_step"	smallint unsigned NOT NULL CHECK("next_step" >= 0),
	"backend"	varchar(32) NOT NULL,
	"data"	text NOT NULL,
	"timestamp"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "social_auth_usersocialauth" (
	"id"	integer NOT NULL,
	"provider"	varchar(32) NOT NULL,
	"extra_data"	text NOT NULL,
	"user_id"	bigint NOT NULL,
	"created"	datetime NOT NULL,
	"modified"	datetime NOT NULL,
	"uid"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_hotelreview" (
	"id"	integer NOT NULL,
	"name"	varchar(20) NOT NULL,
	"date"	datetime NOT NULL,
	"hotelName"	varchar(100),
	"review"	text NOT NULL,
	"rating"	smallint unsigned CHECK("rating" >= 0),
	"user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_hotelreservation" (
	"id"	integer NOT NULL,
	"user_name"	varchar(20) NOT NULL,
	"user_email"	varchar(30) NOT NULL,
	"user_phone"	varchar(20) NOT NULL,
	"checkin_date"	varchar(20) NOT NULL,
	"checkout_date"	varchar(20) NOT NULL,
	"hotel_name"	varchar(20) NOT NULL,
	"room_number"	varchar(20) NOT NULL,
	"room_type"	varchar(20) NOT NULL,
	"user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_roommodel" (
	"id"	integer NOT NULL,
	"roomtype"	varchar(20) NOT NULL,
	"beds"	varchar(20) NOT NULL,
	"baths"	varchar(20) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"guests"	integer NOT NULL,
	"amenities"	text NOT NULL,
	"facilities"	text NOT NULL,
	"room_Img1"	varchar(100),
	"room_Img2"	varchar(100),
	"room_Img3"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "main_place" (
	"id"	integer NOT NULL,
	"name"	varchar(50) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"description"	text NOT NULL,
	"route"	text NOT NULL,
	"map_link"	text NOT NULL,
	"place_Img1"	varchar(100),
	"place_Img2"	varchar(100),
	"place_Img3"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "main_resturantinfo" (
	"id"	integer NOT NULL,
	"name"	varchar(300) NOT NULL,
	"slug"	varchar(50) NOT NULL,
	"address"	text NOT NULL,
	"description"	text NOT NULL,
	"menu"	text NOT NULL,
	"website"	varchar(500) NOT NULL,
	"res_img"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "main_placereview" (
	"id"	integer NOT NULL,
	"name"	varchar(20) NOT NULL,
	"date"	datetime NOT NULL,
	"review"	text NOT NULL,
	"rating"	smallint unsigned CHECK("rating" >= 0),
	"user_id"	bigint NOT NULL,
	"placeName"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_resturantreview" (
	"id"	integer NOT NULL,
	"name"	varchar(20) NOT NULL,
	"date"	datetime NOT NULL,
	"review"	text NOT NULL,
	"rating"	smallint unsigned CHECK("rating" >= 0),
	"user_id"	bigint NOT NULL,
	"resturantName"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "admin_interface_theme" (
	"id"	integer NOT NULL,
	"name"	varchar(50) NOT NULL UNIQUE,
	"active"	bool NOT NULL,
	"title"	varchar(50) NOT NULL,
	"title_visible"	bool NOT NULL,
	"logo"	varchar(100) NOT NULL,
	"logo_visible"	bool NOT NULL,
	"css_header_background_color"	varchar(10) NOT NULL,
	"css_header_text_color"	varchar(10) NOT NULL,
	"css_header_link_color"	varchar(10) NOT NULL,
	"css_header_link_hover_color"	varchar(10) NOT NULL,
	"css_module_background_color"	varchar(10) NOT NULL,
	"css_module_text_color"	varchar(10) NOT NULL,
	"css_module_link_color"	varchar(10) NOT NULL,
	"css_module_link_hover_color"	varchar(10) NOT NULL,
	"css_module_rounded_corners"	bool NOT NULL,
	"css_generic_link_color"	varchar(10) NOT NULL,
	"css_generic_link_hover_color"	varchar(10) NOT NULL,
	"css_save_button_background_color"	varchar(10) NOT NULL,
	"css_save_button_background_hover_color"	varchar(10) NOT NULL,
	"css_save_button_text_color"	varchar(10) NOT NULL,
	"css_delete_button_background_color"	varchar(10) NOT NULL,
	"css_delete_button_background_hover_color"	varchar(10) NOT NULL,
	"css_delete_button_text_color"	varchar(10) NOT NULL,
	"list_filter_dropdown"	bool NOT NULL,
	"related_modal_active"	bool NOT NULL,
	"related_modal_background_color"	varchar(10) NOT NULL,
	"related_modal_rounded_corners"	bool NOT NULL,
	"logo_color"	varchar(10) NOT NULL,
	"title_color"	varchar(10) NOT NULL,
	"recent_actions_visible"	bool NOT NULL,
	"favicon"	varchar(100) NOT NULL,
	"related_modal_background_opacity"	varchar(5) NOT NULL,
	"env_name"	varchar(50) NOT NULL,
	"env_color"	varchar(10) NOT NULL,
	"env_visible_in_header"	bool NOT NULL,
	"env_visible_in_favicon"	bool NOT NULL,
	"related_modal_close_button_visible"	bool NOT NULL,
	"language_chooser_active"	bool NOT NULL,
	"language_chooser_display"	varchar(10) NOT NULL,
	"list_filter_sticky"	bool NOT NULL,
	"form_pagination_sticky"	bool NOT NULL,
	"form_submit_sticky"	bool NOT NULL,
	"css_module_background_selected_color"	varchar(10) NOT NULL,
	"css_module_link_selected_color"	varchar(10) NOT NULL,
	"logo_max_height"	smallint unsigned NOT NULL CHECK("logo_max_height" >= 0),
	"logo_max_width"	smallint unsigned NOT NULL CHECK("logo_max_width" >= 0),
	"foldable_apps"	bool NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "main_chat" (
	"id"	integer NOT NULL,
	"chat"	varchar(300),
	"date"	datetime NOT NULL,
	"from_user_id"	bigint NOT NULL,
	"to_user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("from_user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("to_user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_chatforummessages" (
	"id"	integer NOT NULL,
	"message"	varchar(300),
	"date"	datetime NOT NULL,
	"message_user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("message_user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_wishlist" (
	"id"	integer NOT NULL,
	"date"	datetime NOT NULL,
	"user_id"	bigint NOT NULL,
	"PlaceName"	varchar(100) UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_userblog" (
	"id"	integer NOT NULL,
	"Title"	varchar(300),
	"text"	text NOT NULL,
	"place_Img1"	varchar(100),
	"user_id"	bigint NOT NULL,
	"date"	datetime,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_appreview" (
	"id"	integer NOT NULL,
	"comment"	text NOT NULL,
	"rate"	integer NOT NULL,
	"date"	datetime NOT NULL,
	"user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "main_userprofile" (
	"id"	integer NOT NULL,
	"user_name"	varchar(300),
	"user_phone"	varchar(20),
	"user_address"	varchar(20),
	"date"	datetime NOT NULL,
	"bio"	varchar(300),
	"user_id"	bigint UNIQUE,
	"user_image"	varchar(100),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2021-11-11 21:28:12.745453');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (2,'contenttypes','0002_remove_content_type_name','2021-11-11 21:28:12.770460');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (3,'auth','0001_initial','2021-11-11 21:28:12.801466');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (4,'auth','0002_alter_permission_name_max_length','2021-11-11 21:28:12.816470');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (5,'auth','0003_alter_user_email_max_length','2021-11-11 21:28:12.828472');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (6,'auth','0004_alter_user_username_opts','2021-11-11 21:28:12.840475');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (7,'auth','0005_alter_user_last_login_null','2021-11-11 21:28:12.854478');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (8,'auth','0006_require_contenttypes_0002','2021-11-11 21:28:12.863480');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (9,'auth','0007_alter_validators_add_error_messages','2021-11-11 21:28:12.873482');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (10,'auth','0008_alter_user_username_max_length','2021-11-11 21:28:12.885485');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (11,'auth','0009_alter_user_last_name_max_length','2021-11-11 21:28:12.896487');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (12,'auth','0010_alter_group_name_max_length','2021-11-11 21:28:12.909490');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (13,'auth','0011_update_proxy_permissions','2021-11-11 21:28:12.921493');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (14,'auth','0012_alter_user_first_name_max_length','2021-11-11 21:28:12.934496');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (15,'accounts','0001_initial','2021-11-11 21:28:12.958502');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (16,'accounts','0002_user_is_email_verified','2021-11-11 21:28:12.973505');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (17,'admin','0001_initial','2021-11-11 21:28:12.996510');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (18,'admin','0002_logentry_remove_auto_add','2021-11-11 21:28:13.013514');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (19,'admin','0003_logentry_add_action_flag_choices','2021-11-11 21:28:13.032518');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (20,'main','0001_initial','2021-11-11 21:28:13.050522');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (21,'main','0002_balaka','2021-11-11 21:28:13.063525');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (22,'main','0003_alter_balaka_rate','2021-11-11 21:28:13.076530');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (23,'main','0004_balaka_user','2021-11-11 21:28:13.096534');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (24,'main','0005_alter_balaka_name','2021-11-11 21:28:13.114537');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (25,'main','0006_alter_balaka_name','2021-11-11 21:28:13.133541');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (26,'main','0007_auto_20210905_1641','2021-11-11 21:28:13.161547');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (27,'main','0008_rename_usernoti_article_user','2021-11-11 21:28:13.180552');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (28,'main','0009_auto_20210906_2040','2021-11-11 21:28:13.213559');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (29,'main','0010_auto_20211111_2253','2021-11-11 21:28:13.232563');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (30,'sessions','0001_initial','2021-11-11 21:28:13.251567');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (31,'default','0001_initial','2021-11-11 21:28:13.286576');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (32,'social_auth','0001_initial','2021-11-11 21:28:13.293577');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (33,'default','0002_add_related_name','2021-11-11 21:28:13.306580');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (34,'social_auth','0002_add_related_name','2021-11-11 21:28:13.308581');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (35,'default','0003_alter_email_max_length','2021-11-11 21:28:13.320583');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (36,'social_auth','0003_alter_email_max_length','2021-11-11 21:28:13.320583');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (37,'default','0004_auto_20160423_0400','2021-11-11 21:28:13.338587');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (38,'social_auth','0004_auto_20160423_0400','2021-11-11 21:28:13.338587');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (39,'social_auth','0005_auto_20160727_2333','2021-11-11 21:28:13.349591');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (40,'social_django','0006_partial','2021-11-11 21:28:13.366594');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (41,'social_django','0007_code_timestamp','2021-11-11 21:28:13.380597');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (42,'social_django','0008_partial_timestamp','2021-11-11 21:28:13.395600');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (43,'social_django','0009_auto_20191118_0520','2021-11-11 21:28:13.420606');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (44,'social_django','0010_uid_db_index','2021-11-11 21:28:13.439610');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (45,'social_django','0002_add_related_name','2021-11-11 21:28:13.449613');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (46,'social_django','0004_auto_20160423_0400','2021-11-11 21:28:13.456614');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (47,'social_django','0003_alter_email_max_length','2021-11-11 21:28:13.463616');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (48,'social_django','0005_auto_20160727_2333','2021-11-11 21:28:13.471620');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (49,'social_django','0001_initial','2021-11-11 21:28:13.478619');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (50,'admin_interface','0001_initial','2021-11-15 20:25:09.901898');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (51,'admin_interface','0002_add_related_modal','2021-11-15 20:25:09.937907');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (52,'admin_interface','0003_add_logo_color','2021-11-15 20:25:09.960912');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (53,'admin_interface','0004_rename_title_color','2021-11-15 20:25:09.972915');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (54,'admin_interface','0005_add_recent_actions_visible','2021-11-15 20:25:09.986918');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (55,'admin_interface','0006_bytes_to_str','2021-11-15 20:25:10.135952');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (56,'admin_interface','0007_add_favicon','2021-11-15 20:25:10.150955');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (57,'admin_interface','0008_change_related_modal_background_opacity_type','2021-11-15 20:25:10.174961');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (58,'admin_interface','0009_add_enviroment','2021-11-15 20:25:10.196967');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (59,'admin_interface','0010_add_localization','2021-11-15 20:25:10.218971');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (60,'admin_interface','0011_add_environment_options','2021-11-15 20:25:10.255979');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (61,'admin_interface','0012_update_verbose_names','2021-11-15 20:25:10.271985');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (62,'admin_interface','0013_add_related_modal_close_button','2021-11-15 20:25:10.288987');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (63,'admin_interface','0014_name_unique','2021-11-15 20:25:10.305991');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (64,'admin_interface','0015_add_language_chooser_active','2021-11-15 20:25:10.321995');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (65,'admin_interface','0016_add_language_chooser_display','2021-11-15 20:25:10.336998');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (66,'admin_interface','0017_change_list_filter_dropdown','2021-11-15 20:25:10.354002');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (67,'admin_interface','0018_theme_list_filter_sticky','2021-11-15 20:25:10.369006');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (68,'admin_interface','0019_add_form_sticky','2021-11-15 20:25:10.392012');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (69,'admin_interface','0020_module_selected_colors','2021-11-15 20:25:10.434020');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (70,'admin_interface','0021_file_extension_validator','2021-11-15 20:25:10.451024');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (71,'admin_interface','0022_add_logo_max_width_and_height','2021-11-15 20:25:10.474029');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (72,'main','0011_hotelreview','2021-12-17 10:49:40.503802');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (73,'main','0012_resturantreview','2021-12-17 21:12:42.983730');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (74,'main','0013_hotelreservation','2021-12-18 21:48:10.210743');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (75,'main','0014_placereview','2021-12-19 14:43:29.522350');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (76,'main','0015_roommodel','2021-12-20 18:10:24.725626');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (77,'main','0002_delete_place','2021-12-21 12:00:47.729353');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (78,'main','0003_place','2021-12-21 12:01:06.954694');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (79,'main','0004_auto_20211221_2355','2021-12-21 17:55:44.675786');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (80,'main','0005_auto_20211224_1700','2021-12-24 11:00:23.223300');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (81,'main','0006_alter_userprofile_user_image','2021-12-24 20:51:17.793174');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (82,'admin_interface','0023_theme_foldable_apps','2021-12-27 17:54:14.279696');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (83,'admin_interface','0024_remove_theme_css','2021-12-27 17:54:14.300763');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (84,'main','0007_chat','2021-12-27 21:49:54.701690');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (85,'main','0008_chatforummessages','2021-12-27 21:49:54.729784');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (86,'main','0009_wishlist','2021-12-28 11:53:29.381225');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (87,'main','0010_delete_wishlist','2021-12-28 11:55:06.123246');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (88,'main','0011_wishlist','2021-12-28 11:55:15.145127');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (89,'main','0012_alter_wishlist_placename','2021-12-28 12:32:03.580022');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (90,'main','0013_userblog','2021-12-29 18:38:13.589284');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (91,'main','0014_alter_userblog_title','2021-12-29 18:39:28.081171');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (92,'main','0015_alter_userblog_date','2021-12-29 20:09:47.392098');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (93,'main','0016_alter_userblog_title','2021-12-29 20:23:47.468429');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (94,'main','0017_appreview','2022-01-01 09:06:55.097861');
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (95,'main','0018_alter_userprofile_user_image','2022-01-01 09:06:55.125953');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (2,'auth','permission');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (3,'auth','group');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (4,'contenttypes','contenttype');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (5,'sessions','session');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (6,'accounts','user');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (7,'social_django','association');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (8,'social_django','code');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (9,'social_django','nonce');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (10,'social_django','usersocialauth');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (11,'social_django','partial');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (12,'admin_interface','theme');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (13,'main','hotelreview');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (14,'main','resturantreview');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (15,'main','hotelreservation');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (16,'main','placereview');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (17,'main','roommodel');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (18,'main','place');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (19,'main','resturantinfo');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (20,'main','userprofile');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (21,'main','chatforummessages');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (22,'main','chat');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (23,'main','wishlist');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (24,'main','userblog');
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (25,'main','appreview');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (13,4,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (14,4,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (15,4,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (16,4,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (17,5,'add_session','Can add session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (18,5,'change_session','Can change session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (19,5,'delete_session','Can delete session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (20,5,'view_session','Can view session');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (21,6,'add_user','Can add user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (22,6,'change_user','Can change user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (23,6,'delete_user','Can delete user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (24,6,'view_user','Can view user');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (25,7,'add_association','Can add association');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (26,7,'change_association','Can change association');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (27,7,'delete_association','Can delete association');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (28,7,'view_association','Can view association');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (29,8,'add_code','Can add code');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (30,8,'change_code','Can change code');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (31,8,'delete_code','Can delete code');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (32,8,'view_code','Can view code');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (33,9,'add_nonce','Can add nonce');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (34,9,'change_nonce','Can change nonce');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (35,9,'delete_nonce','Can delete nonce');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (36,9,'view_nonce','Can view nonce');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (37,10,'add_usersocialauth','Can add user social auth');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (38,10,'change_usersocialauth','Can change user social auth');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (39,10,'delete_usersocialauth','Can delete user social auth');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (40,10,'view_usersocialauth','Can view user social auth');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (41,11,'add_partial','Can add partial');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (42,11,'change_partial','Can change partial');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (43,11,'delete_partial','Can delete partial');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (44,11,'view_partial','Can view partial');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (45,12,'add_theme','Can add Theme');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (46,12,'change_theme','Can change Theme');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (47,12,'delete_theme','Can delete Theme');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (48,12,'view_theme','Can view Theme');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (49,13,'add_hotelreview','Can add hotel review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (50,13,'change_hotelreview','Can change hotel review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (51,13,'delete_hotelreview','Can delete hotel review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (52,13,'view_hotelreview','Can view hotel review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (53,14,'add_resturantreview','Can add resturant review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (54,14,'change_resturantreview','Can change resturant review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (55,14,'delete_resturantreview','Can delete resturant review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (56,14,'view_resturantreview','Can view resturant review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (57,15,'add_hotelreservation','Can add hotel reservation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (58,15,'change_hotelreservation','Can change hotel reservation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (59,15,'delete_hotelreservation','Can delete hotel reservation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (60,15,'view_hotelreservation','Can view hotel reservation');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (61,16,'add_placereview','Can add place review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (62,16,'change_placereview','Can change place review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (63,16,'delete_placereview','Can delete place review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (64,16,'view_placereview','Can view place review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (65,17,'add_roommodel','Can add room model');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (66,17,'change_roommodel','Can change room model');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (67,17,'delete_roommodel','Can delete room model');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (68,17,'view_roommodel','Can view room model');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (69,18,'add_place','Can add place');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (70,18,'change_place','Can change place');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (71,18,'delete_place','Can delete place');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (72,18,'view_place','Can view place');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (73,19,'add_resturantinfo','Can add resturant info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (74,19,'change_resturantinfo','Can change resturant info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (75,19,'delete_resturantinfo','Can delete resturant info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (76,19,'view_resturantinfo','Can view resturant info');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (77,20,'add_userprofile','Can add user profile');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (78,20,'change_userprofile','Can change user profile');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (79,20,'delete_userprofile','Can delete user profile');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (80,20,'view_userprofile','Can view user profile');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (81,21,'add_chatforummessages','Can add chat forum messages');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (82,21,'change_chatforummessages','Can change chat forum messages');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (83,21,'delete_chatforummessages','Can delete chat forum messages');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (84,21,'view_chatforummessages','Can view chat forum messages');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (85,22,'add_chat','Can add chat');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (86,22,'change_chat','Can change chat');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (87,22,'delete_chat','Can delete chat');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (88,22,'view_chat','Can view chat');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (89,23,'add_wishlist','Can add wishlist');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (90,23,'change_wishlist','Can change wishlist');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (91,23,'delete_wishlist','Can delete wishlist');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (92,23,'view_wishlist','Can view wishlist');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (93,24,'add_userblog','Can add user blog');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (94,24,'change_userblog','Can change user blog');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (95,24,'delete_userblog','Can delete user blog');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (96,24,'view_userblog','Can view user blog');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (97,25,'add_appreview','Can add app review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (98,25,'change_appreview','Can change app review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (99,25,'delete_appreview','Can delete app review');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (100,25,'view_appreview','Can view app review');
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (1,'pbkdf2_sha256$260000$1qhkm8lvgVQD4hpNoODKv9$ZkQZres3OFlNoUfA58eU5GUE/ynhq6Y6QxrvuxBhcf8=',NULL,0,'hasibtest','','','hasibarrafiulfahim@gmail.com',0,1,'2021-11-11 21:28:49.497777',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (2,'pbkdf2_sha256$260000$YuynXzo9QBadD63PddBgzg$GPDH1mGnfHKHbwn1/X1dyVwOB+68xpqgX3dq9JYNVUM=',NULL,0,'hasibtest2','','','hasibarrafiulfahim2@gmail.com',0,1,'2021-11-11 21:29:53.005160',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (3,'pbkdf2_sha256$260000$Euwgwz3BCD4Onny0rMRsOz$qgH0Cit7du7X6uZhDawpk+0P1lQ6EF75OqwxDEYfNLg=',NULL,0,'hasibtestrr','','','hasibarrafirrulfahim@gmail.com',0,1,'2021-11-11 21:33:50.185876',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (4,'pbkdf2_sha256$260000$9T4SaOWOzwHIMo8XCgzf87$uHK1PJm+ClkVE/ChILghoFQgFK5hNYdhzg9GWR/1+PE=','2021-11-11 21:40:44.041295',0,'fahim','','','fahad.com66@gmail.com',0,1,'2021-11-11 21:39:01.606098',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (5,'pbkdf2_sha256$260000$fHXYUWubEFTdD5lk46jnkE$1KCYk+IBFd/47rjmen7KPG+Uc+8LxCxkOhWl+dpoMxc=','2022-01-04 17:47:29.695916',1,'admin','','','admin@gmail.com',1,1,'2021-11-11 21:41:20.980662',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (6,'pbkdf2_sha256$260000$B3m9UObPxfKanga33HJtRC$bMa0ko4XSOy1Tw8YfCDPxHIqalthmIomFwkx0D2G7TM=',NULL,0,'fahadtrtfgy','','','fahad.com664544@gmail.com',0,1,'2021-11-12 10:08:38.553508',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (7,'pbkdf2_sha256$260000$Chx6TAY4Lgdq3jxWlzMbwK$iKNujnZrGlBHMS4CGkbN8G4ZxJhjKcmtaJuUy15oe1Q=','2022-01-04 17:43:26.222447',0,'adminff','','','rashikbuksh71@gmail.com',0,1,'2021-11-12 10:10:44.993007',1);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (8,'pbkdf2_sha256$260000$N0d6W2JZjf0b3pBmvliZrr$yD4ycwXB5b8wqEy7BIDwfq9s6Wf/FWukfYLxSV4PRA4=','2021-12-17 10:58:14.553354',0,'fahad','','','fahadulislam112@gmail.com',0,1,'2021-11-12 10:26:39.129126',1);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (10,'pbkdf2_sha256$260000$Sy0WMwtQPjAqxPsCyT2ZwA$cz003M88oJm/2XND+pWlGaaqgoS+VlHZAAQNGVA49wM=','2021-11-12 10:55:48.267966',0,'rashik','','','rashikbuksh@gmail.com',0,1,'2021-11-12 10:45:41.958245',1);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (11,'!EO6iL3x5U34WsevzyLTM2u7NLo3FmJ1kfVo06yQT','2021-12-26 12:39:15.064415',0,'fahad.com66.fk','Fahim','','fahad.com66.fk@gmail.com',0,1,'2021-11-14 16:17:29.488046',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (12,'!x8P2Tn4g9TPWVV9PYl6IxrgKolTiyQD7EKLimhGy','2021-12-01 15:18:24.874479',0,'fahadulislam.user','Fahad','Islam','fahadulislam.user@gmail.com',0,1,'2021-12-01 12:19:10.004001',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (13,'!pXomE1fUclEjOgog8GHByIJFhaKsCxMTFRdvh5K8','2021-12-01 12:20:02.492560',0,'fahadulislam112','Fahadul','Islam','fahadulislam112@gmail.com',0,1,'2021-12-01 12:20:02.431726',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (14,'!AqSNLYesFG8pxfUkKvthZq7o0ZPaX1czstG3bvh7','2022-01-02 16:04:37.711724',0,'rashikbuksh','Rashik Buksh','Rafsan','rashikbuksh@gmail.com',0,1,'2021-12-20 21:42:40.471868',0);
INSERT INTO "accounts_user" ("id","password","last_login","is_superuser","username","first_name","last_name","email","is_staff","is_active","date_joined","is_email_verified") VALUES (15,'!a7AVLjvS4xr0c6yaHjdcKizGYIDRWhdu9wOgYLAc','2021-12-27 21:50:07.298346',0,'2018-3-60-088','Rashik','Buksh Rafsan','2018-3-60-088@std.ewubd.edu',0,1,'2021-12-27 21:50:07.238644',0);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (1,'2021-11-15 20:26:42.288098','2','Green Travel','[{"added": {}}]',12,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (2,'2021-11-15 20:26:54.573895','2','Green Travel','[]',12,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (3,'2021-11-15 20:27:42.655293','2','Green Travel','[{"changed": {"fields": ["Logo"]}}]',12,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (4,'2021-11-15 20:28:31.507399','2','Green Travel','[{"changed": {"fields": ["Logo"]}}]',12,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (5,'2021-11-15 20:29:15.706981','2','Green Travel','[{"changed": {"fields": ["Logo"]}}]',12,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (6,'2021-11-15 20:32:07.183975','2','Green Travel','[{"changed": {"fields": ["Logo"]}}]',12,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (7,'2021-11-15 20:32:25.137721','2','Green Travel','[{"changed": {"fields": ["Favicon"]}}]',12,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (8,'2021-11-15 21:47:25.216481','1','Django','[]',12,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (9,'2021-12-17 21:15:17.870785','1','Rashik','[{"added": {}}]',14,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (10,'2021-12-18 21:50:03.799739','1','HotelReservation object (1)','[{"added": {}}]',15,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (11,'2021-12-19 14:44:22.959942','1','Scorpion Squad','[{"added": {}}]',16,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (12,'2021-12-20 18:25:02.962980','1','RoomModel object (1)','[{"added": {}}]',17,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (13,'2021-12-20 18:26:25.524097','2','RoomModel object (2)','[{"added": {}}]',17,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (14,'2021-12-20 18:31:09.823578','2','RoomModel object (2)','[{"changed": {"fields": ["Room Img1", "Room Img2", "Room Img3"]}}]',17,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (15,'2021-12-20 18:31:14.731892','1','RoomModel object (1)','[{"changed": {"fields": ["Room Img1", "Room Img2", "Room Img3"]}}]',17,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (16,'2021-12-20 18:31:35.544256','2','RoomModel object (2)','[{"changed": {"fields": ["Room Img1", "Room Img2", "Room Img3"]}}]',17,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (17,'2021-12-20 18:32:18.673968','1','RoomModel object (1)','[{"changed": {"fields": ["Room Img1", "Room Img2", "Room Img3"]}}]',17,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (18,'2021-12-20 19:06:17.577758','4','ffffff','[]',13,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (19,'2021-12-20 19:07:28.006442','7','ggh','[{"added": {}}]',13,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (20,'2021-12-20 19:13:18.219722','7','ggh','[{"changed": {"fields": ["HotelName"]}}]',13,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (21,'2021-12-20 19:13:34.693982','4','ffffff','[{"changed": {"fields": ["HotelName"]}}]',13,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (22,'2021-12-20 19:13:57.151434','1','Fahim','[{"changed": {"fields": ["HotelName"]}}]',13,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (23,'2021-12-21 12:05:07.109118','1','Place object (1)','[{"added": {}}]',18,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (24,'2021-12-21 12:12:28.924811','1','Scorpion Squad','[{"changed": {"fields": ["PlaceName"]}}]',16,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (25,'2021-12-21 12:12:47.034902','3','Scorpion Squad','[{"added": {}}]',16,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (26,'2021-12-21 12:15:12.952882','4','Scorpion Squad','[{"added": {}}]',16,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (27,'2021-12-21 18:19:44.970705','1','ResturantInfo object (1)','[{"added": {}}]',19,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (28,'2021-12-21 18:29:05.811394','1','ResturantInfo object (1)','[]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (29,'2021-12-21 18:44:24.365969','1','ResturantInfo object (1)','[]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (30,'2021-12-21 19:22:13.214946','2','ResturantInfo object (2)','[{"added": {}}]',19,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (31,'2021-12-21 20:13:14.999339','1','ResturantInfo object (1)','[{"changed": {"fields": ["Menu"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (32,'2021-12-21 20:13:26.856040','1','ResturantInfo object (1)','[{"changed": {"fields": ["Menu"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (33,'2021-12-21 20:14:41.635275','1','ResturantInfo object (1)','[{"changed": {"fields": ["Menu"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (34,'2021-12-21 20:14:56.852206','2','ResturantInfo object (2)','[]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (35,'2021-12-21 20:15:42.870901','2','ResturantInfo object (2)','[{"changed": {"fields": ["Menu"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (36,'2021-12-21 20:15:58.655220','2','ResturantInfo object (2)','[{"changed": {"fields": ["Menu"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (37,'2021-12-21 20:16:08.702321','2','ResturantInfo object (2)','[{"changed": {"fields": ["Menu"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (38,'2021-12-21 20:16:25.573371','2','ResturantInfo object (2)','[{"changed": {"fields": ["Menu"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (39,'2021-12-21 20:16:58.056512','2','ResturantInfo object (2)','[{"changed": {"fields": ["Description"]}}]',19,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (40,'2021-12-24 11:04:32.624357','9','rashikbuksh71@gmail.com','',6,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (41,'2021-12-24 11:08:34.161736','1','userProfile object (1)','[{"added": {}}]',20,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (42,'2021-12-24 12:12:29.906567','1','userProfile object (1)','[{"changed": {"fields": ["User name"]}}]',20,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (43,'2021-12-24 20:45:45.623681','2','userProfile object (2)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (44,'2021-12-24 20:47:24.479650','3','userProfile object (3)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (45,'2021-12-24 20:51:32.416913','4','userProfile object (4)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (46,'2021-12-24 20:52:20.802791','5','userProfile object (5)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (47,'2021-12-24 20:58:50.841949','6','userProfile object (6)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (48,'2021-12-24 21:02:39.976910','7','userProfile object (7)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (49,'2021-12-24 21:14:19.956614','8','userProfile object (8)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (50,'2021-12-24 21:18:37.207492','9','userProfile object (9)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (51,'2021-12-24 21:45:51.463535','10','userProfile object (10)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (52,'2021-12-24 21:48:39.359570','11','userProfile object (11)','[{"changed": {"fields": ["User image"]}}]',20,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (53,'2021-12-25 20:34:08.155210','11','userProfile object (11)','[{"changed": {"fields": ["User name"]}}]',20,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (54,'2021-12-25 21:20:00.500892','11','userProfile object (11)','[{"changed": {"fields": ["Bio", "User image"]}}]',20,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (55,'2021-12-25 21:55:31.963493','11','userProfile object (11)','[{"changed": {"fields": ["User image"]}}]',20,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (56,'2021-12-26 12:03:38.112059','11','userProfile object (11)','[{"changed": {"fields": ["User image"]}}]',20,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (57,'2021-12-26 12:32:47.941982','12','userProfile object (12)','[{"added": {}}]',20,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (58,'2021-12-28 11:55:59.302855','1','wishlist object (1)','[{"added": {}}]',23,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (59,'2021-12-28 12:07:38.354701','2','wishlist object (2)','[{"added": {}}]',23,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (60,'2021-12-28 12:07:43.783922','3','wishlist object (3)','[{"added": {}}]',23,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (61,'2021-12-28 12:07:51.312628','4','wishlist object (4)','[{"added": {}}]',23,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (62,'2021-12-28 12:12:18.889350','5','wishlist object (5)','[{"added": {}}]',23,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (63,'2021-12-28 12:30:52.875612','9','wishlist object (9)','',23,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (64,'2021-12-29 12:32:47.670688','23','HotelReservation object (23)','',15,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (65,'2021-12-29 12:32:47.678691','22','HotelReservation object (22)','',15,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (66,'2021-12-29 18:41:18.579713','1','userBlog object (1)','[{"added": {}}]',24,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (67,'2021-12-29 19:00:50.358962','2','userBlog object (2)','[{"added": {}}]',24,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (68,'2021-12-29 19:36:28.286095','3','userBlog object (3)','',24,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (69,'2021-12-29 19:39:09.533148','4','userBlog object (4)','',24,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (70,'2021-12-29 20:04:31.979659','7','userBlog object (7)','[{"added": {}}]',24,5,1);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (71,'2021-12-29 20:12:08.218994','7','userBlog object (7)','',24,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (72,'2021-12-29 20:26:27.511193','1','userProfile object (1)','',20,5,3);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (73,'2021-12-29 20:26:53.601608','13','userProfile object (13)','[{"changed": {"fields": ["User image"]}}]',20,5,2);
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (74,'2022-01-02 16:04:28.943430','15','userProfile object (15)','',20,5,3);
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('bfi9rca9iezu68b9rt82bq92q38x2sdh','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1mmirK:FZdR52lQX8j0sOBrAbxi_fB4-UscdPg8I8UXWsRPsGU','2021-11-29 20:45:46.244699');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('9ksi9fwxbhcgcul0t84yps81i4p70r7m','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1mmjDs:e8GTQQ6YTevjrRSVm94S1ffHC8YYTpvlcdH4d0X1wdo','2021-11-29 21:09:04.288519');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('x8v901hjnes31tj4dq8rcl1p7aiaywre','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1mmjGD:xupBV-ubT4f9MFqnzKkSJwl10qs9jcTWxji0sW8beTU','2021-11-29 21:11:29.560090');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('yjl7m64xykvgb07p6vbytiaw8ogl7j0n','.eJxVkEGLwjAQhf9LzmsxaayNN2GhF6EHwZW9hGRm0maNDZgq7sr-d1v1YE8zvOF77zE31sTYBJpFc-5boVNvemIr9nfcNJf2ultUh61C6z-PX_CNVW1_gpf73y37YHok9DnRSXscEJ5PRWvgQN14SRG8CRriibKXmrJnblY9Rr0e06d8a1I7wMCtU2ohJRYyNw5oToSWlwUvJIDN0dmCnDBzsUQu7bCWKLAsBVcOFKrB9JX_sA4m9TrExndvBSc_YP93L69e9Q:1msOag:zrp1MVsV-su5ICU1UqkE0leY6lWJIKo0vkr4nPJdBIk','2021-12-15 12:20:02.503533');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('iod65jpvel2t9kfemobw8bfthb4obwch','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1msXJU:wFAUoUlt9YDKoXUY3MNbtzXg0Yii94JNN9y2KOXauIY','2021-12-15 21:38:52.199048');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('fe315ve358csitf1sgu4swigaj18itez','.eJxVjDsOwjAQRO_iGlk2iZNdSnrOYK131ziAHCmfCnF3EikFFNPMezNvE2ldSlxnneIg5mLAnH67RPzUugN5UL2Plse6TEOyu2IPOtvbKPq6Hu7fQaG5bOvQOaaQEXt0ohkEWszQhy3sWbQTcjmcoW1QGy8BMza9Iw8ZPCev5vMF7FQ4Bw:1msjd0:u71QdmPEi5CrPRGtN9qm66-kh-DIglUG_ZMvqf7uSrM','2021-12-16 10:47:50.833915');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('4ecnizuvszdx0fojlak21yfcz7quqqep','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1myAoJ:fVV5yAqQrpgZLgmgn-HYJ8f-bSM2WbDX1ilqgIUqeI4','2021-12-31 10:49:59.087961');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('vp7dlmb8ikbyddjzavgp675fhquwmnxw','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1myqie:gp6b3cfiUAaTzBrjiQdlBhLuc2iKhCIsFRKOdf_aF0w','2022-01-02 07:34:56.578356');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('lcyytw0z37452cae4gmzxik7hfqkkz3h','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1myxQ1:wPmzlnaGA2RfrLPHqtD1d6WY-mi6r2SNVW7hbkumNMo','2022-01-02 14:44:09.999011');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('oxoqfoiu9n9ozxnaifryhz5zrixfgzd8','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1mzN9Z:1fNzyASooPxv3hMjURdpuDzDRQ1ER0MIjdQJ620SRsk','2022-01-03 18:12:53.037019');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('hi2qugn0terki9qtr49rvgf7l9aw3d2r','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1mzNJS:dfUCY3kdeQcxlMSnF_d3sHoDTfcW1hEgIUtzpLleLhU','2022-01-03 18:23:06.695862');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('o3br19kil31798s7xc0yexgniwxi4otb','.eJxVjDsOwjAQBe_iGlm2119Kes4QrddeHECOlE-FuDtESgHtm5n3EgNuaxu2pc7DWMRZBHH63TLSo_YdlDv22yRp6us8Zrkr8qCLvE6lPi-H-3fQcGnf2qcQk2bKJjnPGVBB8kjMwTkAIF-hkmFrdWStoQZG45QKZDEWl4J4fwDcszeL:1mzQAQ:UlKFdtceUSCJ_Y80t88FQ2QcqDahTZNn5KvMaqbxLS4','2022-01-03 21:25:58.707135');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('8a16we4htzuztr96ddh7yt0akhboga5h','.eJxVjDsOwjAQBe_iGlm2119Kes4QrddeHECOlE-FuDtESgHtm5n3EgNuaxu2pc7DWMRZBHH63TLSo_YdlDv22yRp6us8Zrkr8qCLvE6lPi-H-3fQcGnf2qcQk2bKJjnPGVBB8kjMwTkAIF-hkmFrdWStoQZG45QKZDEWl4J4fwDcszeL:1mzQM0:dIfq6w4yGV2GhvcnIfwzKUSEUVrxlpKskNzTfoxoUpc','2022-01-03 21:37:56.867279');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('q9ovj4bcng72mpds7bijptehxd405ivr','.eJxVkMsKwjAQRf8lay1JmtrEnQuR6kIQRVyFSTJ9YGnQRBDFf7dVF3Y1cId7zjBPUnlftTj1cIs11yFCRDIna-M7qw57t3wwdwpmF_2mKRQ7XtI7S4sjmRA9NPQt4FU3rq8wMQ4N2DN2wyZ420Crrb9i8ktD8vUmq8_YLgb7uF9DqAcsKiapo1JZLpmgjKoUKVDIjcxLyspMZHxmbVbKHC03BgXvg6zMnVECoIf-_B90CyHq1ldN93fg6Afk9QbLZVyK:1mzQaL:PEkCvl8SS3aUskBjfHAqNLGMGXOu_n78sNMGd-PC0x0','2022-01-03 21:52:45.867588');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('cslxbq6wa3k9vli13gop2cmz15vs2qdq','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1mzdlC:-dzP3JtFllUtd1fez1HS9f2kRDDa9_QiQk9a_Pq2NwE','2022-01-04 11:56:50.226683');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('4mnfeovype18qcn7bpz106tr9x1sygc3','.eJxVkMsOgjAQRf-layVtKbS4k5i400hi1FUzlOERCI20utD474K6kNUkZ3LuncyTVNZWHS4t3HzNtfPgkaxIlrXnazZEw0mEO8BYPi6He-oPxz7d1CqPyYLoydA3h4NuilFhbA5zMC3208ZZ00CnjR0w-FEXfHuD7Wfs11P73K_B1aMsCsFlYqjEROXMlEyqmIdUqAhkAYpRhrxUkkOEJaUKihGFcaKiklMqQjqG_vo_0R04rztbNf3fgbMfkNcbe4hbeQ:1n1Snz:4jw9CAydHiofMycTvSLMnkQkPbp6v6jWbmDZOfGncbU','2022-01-09 12:39:15.075418');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('2r6g2t5bqc1impy23mgagsep5o0woq93','.eJxVkLFugzAQht_Fc4tsx2C7WyY6pEVVO7STdTYHpjFYwjDQqu9eSDKE6aT_9H_f6X5JG2Mb8DHCPHlu0gQTkifyU_Reffv3D6lfP21fCXh7GcLpWc1LOXwtkjwQszXMnHA0Xb1WmNiHFtwZh22TousgGBdHzG5pyq7erLyM6rjZ930PyW9Y1EzRmirtuGKCMqoPSIGCtEo2lDW5yHnhXN4oiY5bi4KvQd7I2moBsEJv_gs6QJpMiG033B24-wH5-wfoTFyy:1n1uEy:hZsBTIjM-tPVxh4alVjvTfaygjphkYRC_AyyAEtwxvY','2022-01-10 17:56:56.034388');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('kkahziuf2sbi6sjz5vmdne4h4qrtehsw','.eJxVkDEPwiAQhf8LszalLa24dTAODpq4qAs54KCNKEmhcTD-d6k62OmSd_e993JPYr23DpcextgVIkSISNYkurg77Ph4PTyU3Wy2DC7O0vY22HM3HO2JLIiYCDEGHESvE0LZXJSgrnifNsGrHpxQfsDsp4bsm5ttP2PfTulzvoPQJZiXla50yRGpMroBw2tmasNzyU0tKVPYVE2RV4VBCayg6bxkSeZU5rBiOpn-8j_WDkIUztv-_ldw9gPyegPAnV3c:1n1xsd:jK2O82H21HTa9HgIAfo6YTyJvlr0VLFD-w94DNrkn6g','2022-01-10 21:50:07.307378');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('8wt31kq696tvm3b30mw8ycqwckvgxd7z','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1n1xxG:y_DeX_BmFyNqH8w8FBuswIJMQeG8bE-UHoTWPGIwZKQ','2022-01-10 21:54:54.721842');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('d2r2wn6f81its191got1d2u0glvi334x','.eJxVjDsOwjAQBe_iGlm2119Kes4QrddeHECOlE-FuDtESgHtm5n3EgNuaxu2pc7DWMRZBHH63TLSo_YdlDv22yRp6us8Zrkr8qCLvE6lPi-H-3fQcGnf2qcQk2bKJjnPGVBB8kjMwTkAIF-hkmFrdWStoQZG45QKZDEWl4J4fwDcszeL:1n2JFd:Gb02c_JlWRRbjHtaeE6uVb4MM_HbtyCUXII3ZSRn_TU','2022-01-11 20:39:17.328710');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('sxp5rkvxwro79is8h1anpr9lpixkbgrm','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1n2dqT:CDw47ZWdQkGorQyHCjX99HjoNwlS1Q2UH3h2iz_Ge_k','2022-01-12 18:38:41.087023');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('ssgk8vj0u2dknv9qu5mskjtfolrqt4dv','.eJxVjDsOwjAQBe_iGlm2119Kes4QrddeHECOlE-FuDtESgHtm5n3EgNuaxu2pc7DWMRZBHH63TLSo_YdlDv22yRp6us8Zrkr8qCLvE6lPi-H-3fQcGnf2qcQk2bKJjnPGVBB8kjMwTkAIF-hkmFrdWStoQZG45QKZDEWl4J4fwDcszeL:1n2vzs:vVsQ3J3rCNciTPLzoPB7_VHHUiwJj0ubpaaVTfqNUYs','2022-01-13 14:01:36.645334');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('fswfc9laatqgh0tjj5qvqo35ysjnm68v','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1n4UzF:VP2v3FWRVnQ6BZEeYK-3qEa1NsUFYnmTh4vnEdZtiPc','2022-01-17 21:35:25.530223');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('7edhxi3dyiva169ctwjkjt0mzemxtapi','.eJxVjDsOwjAQBe_iGlm2119Kes4QrddeHECOlE-FuDtESgHtm5n3EgNuaxu2pc7DWMRZBHH63TLSo_YdlDv22yRp6us8Zrkr8qCLvE6lPi-H-3fQcGnf2qcQk2bKJjnPGVBB8kjMwTkAIF-hkmFrdWStoQZG45QKZDEWl4J4fwDcszeL:1n4nZt:UmYig2QyA0dgu0F25NPWVJU7izPRGNgY-NpZIC6LV58','2022-01-18 17:26:29.858131');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('sh7qpmpj9hvxjh0wtren5ov2fz49igcn','.eJxVjDsOwyAQBe9CHSGD-ZiU6X0GtCxscBKBZOwqyt2DJRdJ-2bmvZmHfct-b2n1S2RXptnldwuAz1QOEB9Q7pVjLdu6BH4o_KSNzzWm1-10_w4ytNxrkIgG1TjgoKUhmpwLejJAUie0btTaGmmsJUgikhKkko2ddi-CGgX7fAHmJzfx:1n4nuD:fGbhm88ZSgVxOChrjiZGofKIAYvn9NUdT9TGt8Cppm4','2022-01-18 17:47:29.704916');
INSERT INTO "social_auth_usersocialauth" ("id","provider","extra_data","user_id","created","modified","uid") VALUES (2,'google-oauth2','{"auth_time": 1640522355, "expires": 3599, "token_type": "Bearer", "access_token": "ya29.a0ARrdaM8xPWxfVeI3hY_VUpyViJQksvHeMdfRO6atjCS4rqSnVoLHcQrRWsl2p44XzSclvFt52E4ABeGmiXrzk8TDt6zjqdwAU2diWHaRAhK_TFWRTMmNAjRNOtI5toqEqrXybBMCcKApaVWVPpnC3HDHROP_"}',11,'2021-11-14 16:17:29.498048','2021-12-26 12:39:15.036409','fahad.com66.fk@gmail.com');
INSERT INTO "social_auth_usersocialauth" ("id","provider","extra_data","user_id","created","modified","uid") VALUES (3,'google-oauth2','{"auth_time": 1638371904, "expires": 3599, "token_type": "Bearer", "access_token": "ya29.a0ARrdaM_0c-lHXpxcj79PQHHNfuHI8eSaJWtRVrbgKclJnWImeUtVfQsuHu5jz6ctVK0DfGj-DR6R5FZ4v0wcRi3ED9SiMvvfundtRV3ZbQYW4VVHTatQzdfnfuM0cMI_IAibOkD9P4Zi3AzUtlGE9TkkhfWj"}',12,'2021-12-01 12:19:10.013970','2021-12-01 15:18:24.832529','fahadulislam.user@gmail.com');
INSERT INTO "social_auth_usersocialauth" ("id","provider","extra_data","user_id","created","modified","uid") VALUES (4,'google-oauth2','{"auth_time": 1638361202, "expires": 3599, "token_type": "Bearer", "access_token": "ya29.a0ARrdaM_Pc6mqtIZ7toqNyftOisrcEbTjCNst8gqFFRSGAwU8k_MqhDBESUYk2LpVydEUUwi9fBNhmOh0LXaMCLrO1yUIxJsHI-rITfgK-LwFUy7rUpTsGn3qcBaIGEks7qSBAnr-5dgd1-rQr50Oe6yc0MwCLA"}',13,'2021-12-01 12:20:02.442695','2021-12-01 12:20:02.452668','fahadulislam112@gmail.com');
INSERT INTO "social_auth_usersocialauth" ("id","provider","extra_data","user_id","created","modified","uid") VALUES (5,'google-oauth2','{"auth_time": 1641139477, "expires": 3599, "token_type": "Bearer", "access_token": "ya29.a0ARrdaM-2TYBpq4S6xv14EB8-qmWOeH_GnjEJJqiMCA0Nrx9YVfejGyyC08QUZnye2CpBEIDkXUtB4yiMqqh11dyMIs50u5h8a9PSynthFQvU22o1ws2xG2TXFhkM1OLHsk6T7Ug0SXxDbwh2QROYt0uKOvYfOw"}',14,'2021-12-20 21:42:40.481901','2022-01-02 16:04:37.685131','rashikbuksh@gmail.com');
INSERT INTO "social_auth_usersocialauth" ("id","provider","extra_data","user_id","created","modified","uid") VALUES (6,'google-oauth2','{"auth_time": 1640641807, "expires": 3599, "token_type": "Bearer", "access_token": "ya29.a0ARrdaM8Ni9T-oWtdpGQ_uEszOMbJ-6sW3mawPB64EeCAhIAW9Q0sNJAQAWyb_7yTdcGJtim8y5t1saan5u6m80gAIk7sQfzmT71h277dd6OOlZAmuHz_YZSOBJoAS9thCoR8FjL7X-pKojcMmBrrWlzVJ32I"}',15,'2021-12-27 21:50:07.249184','2021-12-27 21:50:07.258215','2018-3-60-088@std.ewubd.edu');
INSERT INTO "main_hotelreview" ("id","name","date","hotelName","review","rating","user_id") VALUES (1,'Fahim','2021-12-17 11:03:16.132434','Pan_Pacific_Sonargoan','ggwp',10,8);
INSERT INTO "main_hotelreview" ("id","name","date","hotelName","review","rating","user_id") VALUES (4,'ffffff','2021-12-17 12:08:58.185169','Radisson_Blu','fffffffffff',2,5);
INSERT INTO "main_hotelreview" ("id","name","date","hotelName","review","rating","user_id") VALUES (7,'ggh','2021-12-20 19:07:28.005443','Radisson_Blu','bjhbi',4,8);
INSERT INTO "main_hotelreview" ("id","name","date","hotelName","review","rating","user_id") VALUES (10,'fqf','2021-12-20 20:01:02.700806','Radisson_Blu','fqfwqf',2,5);
INSERT INTO "main_hotelreview" ("id","name","date","hotelName","review","rating","user_id") VALUES (13,'Rashik','2021-12-20 22:19:15.742885','Radisson_Blu','Very good Hotel. I loved it here. Staffs were friendly and helpful. Nice Rooms and Environment.',10,14);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (1,'gg','gg','gg','gg','gg','gg','gg','gg',8);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (2,'ff','ff','gg','2021-12-16','2021-12-16','Hotel De Meridian','3','King Size',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (3,'','','','','','Pan Pacific Sonargoan','1','Single Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (4,'ff','ff','gg','2021-12-16','2021-12-16','Hotel De Meridian','3','King Size',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (5,'ff','ff','gg','2021-12-16','2021-12-16','Hotel De Meridian','3','King Size',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (6,'Fahim','fahad.com','01794','2021-12-09','2021-12-14','Hotel De Meridian','3','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (7,'Fahim','fahad.com','01794','2021-12-09','2021-12-14','Hotel De Meridian','3','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (8,'Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-07','2021-12-10','Hotel De Meridian','3','Double Bed',7);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (9,'Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-07','2021-12-10','Hotel De Meridian','3','Double Bed',7);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (10,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-14','2021-12-15','Radisson Blu','2','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (11,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-14','2021-12-15','Radisson Blu','2','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (12,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-16','2021-12-18','Radisson Blu','3','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (13,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-16','2021-12-18','Radisson Blu','3','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (14,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-16','2021-12-17','Radisson Blu','2','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (15,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-16','2021-12-17','Radisson Blu','2','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (16,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-16','2021-12-17','Radisson Blu','2','Double Bed',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (17,'Rashik','rashikbuksh@gmail.com','01684545111','2021-12-30','2022-01-04','Pan Pacific Sonargoan','1','Single Bed',14);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (18,'Rashik','rashikbuksh@gmail.com','01684545111','2021-12-29','2022-01-03','Pan Pacific Sonargoan','1','Single Bed',14);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (19,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-16','2021-12-23','Radisson Blu','2','Family Size',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (20,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-16','2021-12-23','Radisson Blu','2','Family Size',5);
INSERT INTO "main_hotelreservation" ("id","user_name","user_email","user_phone","checkin_date","checkout_date","hotel_name","room_number","room_type","user_id") VALUES (21,'Hasib Ar Rafiul Fahim','fahad.com66.fk@gmail.com','+8801794798101','2021-12-15','2021-12-17','Radisson Blu','3','King Size',7);
INSERT INTO "main_roommodel" ("id","roomtype","beds","baths","slug","guests","amenities","facilities","room_Img1","room_Img2","room_Img3") VALUES (1,'Single, Double, Suit','2','1','Pan_Pacific_Sonargoan',4,'Offering city views, our comfortable Standard Room features convenient amenities to offer you a pleasant stay.','Our Deluxe Room is a relaxing space for you to unwind with its city and pool views as well as a selection of cable television channels. Our Premier Room makes for the perfect urban oasis with its great views, an ensuite bathroom and a well-equipped work area.','16256-113891-f65416902_3xl.webp','16256-113891-f65416908_3xl.webp','16256-113891-f65416992_3xl.webp');
INSERT INTO "main_roommodel" ("id","roomtype","beds","baths","slug","guests","amenities","facilities","room_Img1","room_Img2","room_Img3") VALUES (2,'Single, Double, Suit','2','1','Radisson_Blu',2,'These standard rooms come with one king or two double beds, elegant linens, and comfortable armchairs. In the mornings, brew yourself a cup of coffee with the coffeemaker as you get ready for the day. If you need to, set up your laptop at the work desk and check email using free Wi-Fi. At the end of the day, you can relax with the soothing rain shower in the spacious bathroom, and then stream your favorite show on the TV with mirror casting before heading to bed. Other amenities include a wardrobe, double-glazed windows, and an in-room safe to secure your valuables.','These standard rooms come with one king or two double beds, elegant linens, and comfortable armchairs. In the mornings, brew yourself a cup of coffee with the coffeemaker as you get ready for the day. If you need to, set up your laptop at the work desk and check email using free Wi-Fi. At the end of the day, you can relax with the soothing rain shower in the spacious bathroom, and then stream your favorite show on the TV with mirror casting before heading to bed. Other amenities include a wardrobe, double-glazed windows, and an in-room safe to secure your valuables. For an extended stay or for extra space, choose one of our Suites. These spacious surroundings include a separate living area and a bedroom with either two double beds or  one king bed  for ultimate comfort and privacy. You can chat with friends or colleagues in the living area and then retire to the separate bedroom for a quiet night’s sleep. In addition to all standard amenities, our Suites include a free deep sleep pillow spray and turndown service every evening.','ppdac-02-deluxe-room-hero-1.jpg','ppdac-03-premier-hero-1.png','ppdac-05-Junior-Suite-hero-1.jpg');
INSERT INTO "main_place" ("id","name","slug","description","route","map_link","place_Img1","place_Img2","place_Img3") VALUES (1,'Cox''s Bazar','Cox_Bazar','Cox''s Bazar (Bengali: কক্সবাজার, romanized: Kaksabājāra; pronounced [kɔksbadʒaɾ]) is a city, fishing port, tourism centre, and district headquarters in southeastern Bangladesh. It is famous mostly for its long natural sandy beach. It is located 150 km (93 mi) south of the city of Chittagong. Cox''s Bazar is also known by the name Panowa, which translates literally as "yellow flower". Another old name was "Palongkee". It has the longest sea beach in the world.

The modern Cox''s Bazar derives its name from Captain Hiram Cox, an officer of the British East India Company, a Superintendent of Palongkee outpost. To commemorate his role in refugee rehabilitation work, a market was established and named after him.

The city covers an area of 23.4 km2 (9.0 sq mi) with 27 mahallas and 9 wards and as of 2011 had a population of 265,500.[1] Cox''s Bazar is connected by road and air with Chittagong.[2][3]','Dhaka - Cumilla - Feni - Chittagong - Cox Bazar','https://goo.gl/maps/KvVReqXoVY3WAg7MA','Coxs_Bazar_Sunset_28SQfCw.jpg','photo-1587302525159-2363f54affd4_IApX6Fw.jpg','photo-1608958435020-e8a7109ba809_d1mv15r.jpg');
INSERT INTO "main_resturantinfo" ("id","name","slug","address","description","menu","website","res_img") VALUES (1,'Istanbul Restaurant','Istanbul_Restaurant','Istanbul Restaurant Dhaka
Level-6, House-10, Road-53, Gulshan Circle-2,
Top of Weavers,
Dhaka 1212, Bangladesh.','Authentic Turkish Kebab & Sweet
Home Delivery & Takeaway Available.
OPEN FOR DINING Everyday 10 AM to 10 PM.
Phone : +88-01771-000-000
Email : istanbul.gulshan@gmail.com

Home Delivery
For home delivery, please call:
Hotline: 01771-000000 / 01618-688823/29
Tel: 02-9858448','À LA CARTE Menu :
 TURKISH APPETIZER & SALAD
, CONTINENTAL APPETIZER & SALAD
, SOUP
, MAIN COURSE
, RICE
, TURKISH BREAD
, PASTA
, VEGETARIAN
, BARBEQUE BEEF
, BARBEQUE CHICKEN
, BARBEQUE LAMB
, STEAK
, TURKISH GREAT PIZZA
, SHARING PLATTER
, ISTANBUL DESIGNER DRINK
, SWEET ENDING','https://www.istanbulrestaurantbd.com/','Istanbul-Restaurant-Dhaka-Open-Everyday.jpg');
INSERT INTO "main_resturantinfo" ("id","name","slug","address","description","menu","website","res_img") VALUES (2,'The Dining Lounge','The_Dining_Lounge','The Dining Lounge
373/b, 3rd floor, Shotodol Rose Heights, khilgaon Taltola,
Dhaka, Bangladesh.
Phone : 01976-239619','Multi-cuisine specialized pizza restaurant in Dhaka 
&
Services :

Walk-Ins Welcome,
Takes Reservations,
Take Out,
Outdoor Seating,
Waiter Service,
Good For Groups and Kids,
Catering service,
Delivery service,','Specialties :
Breakfast, Lunch, Dinner, Drinks and Coffee &

Cuisine : Multi-Cuisine
American, Italian, Thai & Chinese.
Authentic Chicago Style Deep Dish Pizza
BBQ, Italian / NY crust pizza and more.','https://www.facebook.com/TheDiningLounge/','The-Dining-Lounge.jpg');
INSERT INTO "main_placereview" ("id","name","date","review","rating","user_id","placeName") VALUES (1,'Scorpion Squad','2021-12-19 14:44:22.957941','fyggfj',4,7,'Cox_Bazar');
INSERT INTO "main_placereview" ("id","name","date","review","rating","user_id","placeName") VALUES (3,'Scorpion Squad','2021-12-21 12:12:47.033902','dwwqadwadw',5,6,'Cox_Bazar');
INSERT INTO "main_placereview" ("id","name","date","review","rating","user_id","placeName") VALUES (4,'Scorpion Squad','2021-12-21 12:15:12.950881','dqadqwdqwdqwadw',1,3,'Dhaka');
INSERT INTO "main_placereview" ("id","name","date","review","rating","user_id","placeName") VALUES (7,'Rashik','2021-12-21 12:26:51.681171','Very Good.',10,5,'Cumilla');
INSERT INTO "main_placereview" ("id","name","date","review","rating","user_id","placeName") VALUES (8,'Rashik','2021-12-21 12:27:44.879932','Good',7,5,'Dhaka');
INSERT INTO "main_resturantreview" ("id","name","date","review","rating","user_id","resturantName") VALUES (2,'ggwp','2021-12-17 21:27:54.512554','dadadadad',4,7,'Chillox');
INSERT INTO "main_resturantreview" ("id","name","date","review","rating","user_id","resturantName") VALUES (6,'Rashik','2021-12-21 20:18:45.315296','good',7,5,'Istanbul_Restaurant');
INSERT INTO "admin_interface_theme" ("id","name","active","title","title_visible","logo","logo_visible","css_header_background_color","css_header_text_color","css_header_link_color","css_header_link_hover_color","css_module_background_color","css_module_text_color","css_module_link_color","css_module_link_hover_color","css_module_rounded_corners","css_generic_link_color","css_generic_link_hover_color","css_save_button_background_color","css_save_button_background_hover_color","css_save_button_text_color","css_delete_button_background_color","css_delete_button_background_hover_color","css_delete_button_text_color","list_filter_dropdown","related_modal_active","related_modal_background_color","related_modal_rounded_corners","logo_color","title_color","recent_actions_visible","favicon","related_modal_background_opacity","env_name","env_color","env_visible_in_header","env_visible_in_favicon","related_modal_close_button_visible","language_chooser_active","language_chooser_display","list_filter_sticky","form_pagination_sticky","form_submit_sticky","css_module_background_selected_color","css_module_link_selected_color","logo_max_height","logo_max_width","foldable_apps") VALUES (1,'Django',0,'Django administration',1,'',1,'#0C4B33','#44B78B','#FFFFFF','#C9F0DD','#44B78B','#FFFFFF','#FFFFFF','#C9F0DD',1,'#0C3C26','#156641','#0C4B33','#0C3C26','#FFFFFF','#BA2121','#A41515','#FFFFFF',1,1,'#000000',1,'#FFFFFF','#F5DD5D',1,'','0.3','','#E74C3C',1,1,1,1,'code',1,0,0,'#FFFFCC','#FFFFFF',100,400,1);
INSERT INTO "admin_interface_theme" ("id","name","active","title","title_visible","logo","logo_visible","css_header_background_color","css_header_text_color","css_header_link_color","css_header_link_hover_color","css_module_background_color","css_module_text_color","css_module_link_color","css_module_link_hover_color","css_module_rounded_corners","css_generic_link_color","css_generic_link_hover_color","css_save_button_background_color","css_save_button_background_hover_color","css_save_button_text_color","css_delete_button_background_color","css_delete_button_background_hover_color","css_delete_button_text_color","list_filter_dropdown","related_modal_active","related_modal_background_color","related_modal_rounded_corners","logo_color","title_color","recent_actions_visible","favicon","related_modal_background_opacity","env_name","env_color","env_visible_in_header","env_visible_in_favicon","related_modal_close_button_visible","language_chooser_active","language_chooser_display","list_filter_sticky","form_pagination_sticky","form_submit_sticky","css_module_background_selected_color","css_module_link_selected_color","logo_max_height","logo_max_width","foldable_apps") VALUES (2,'Green Travel',1,'Green Travel',1,'admin-interface/logo/logo-social.jpg',1,'#0C4B33','#44B78B','#FFFFFF','#C9F0DD','#44B78B','#FFFFFF','#FFFFFF','#C9F0DD',1,'#0C3C26','#156641','#0C4B33','#0C3C26','#FFFFFF','#BA2121','#A41515','#FFFFFF',1,1,'#000000',1,'#FFFFFF','#F5DD5D',1,'admin-interface/favicon/logo-social.jpg','0.3','Green Travel','#E74C3C',1,1,1,1,'code',1,0,0,'#FFFFCC','#FFFFFF',100,400,1);
INSERT INTO "main_chat" ("id","chat","date","from_user_id","to_user_id") VALUES (1,'hello','2021-12-27 21:55:13.706433',7,5);
INSERT INTO "main_chat" ("id","chat","date","from_user_id","to_user_id") VALUES (2,'hi','2021-12-27 21:55:23.796703',5,7);
INSERT INTO "main_chat" ("id","chat","date","from_user_id","to_user_id") VALUES (3,'hello test','2021-12-29 11:27:49.360680',7,5);
INSERT INTO "main_chat" ("id","chat","date","from_user_id","to_user_id") VALUES (4,'Hello','2022-01-04 13:42:57.876238',5,1);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (1,'Hello','2021-12-27 21:55:47.201616',7);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (2,'hi','2021-12-27 21:56:01.854912',5);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (3,'wassap?','2021-12-27 21:56:11.663118',7);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (4,'good','2021-12-27 21:56:14.912423',5);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (5,'gg','2021-12-27 21:58:42.729594',7);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (6,'yo boy','2021-12-27 21:58:54.014561',5);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (7,'ok','2022-01-03 20:20:08.321434',14);
INSERT INTO "main_chatforummessages" ("id","message","date","message_user_id") VALUES (8,'gg','2022-01-03 20:48:17.813144',14);
INSERT INTO "main_wishlist" ("id","date","user_id","PlaceName") VALUES (3,'2021-12-28 12:07:43.782922',5,'Sylhet');
INSERT INTO "main_wishlist" ("id","date","user_id","PlaceName") VALUES (6,'2021-12-28 12:19:51.159158',5,'Gazipur');
INSERT INTO "main_wishlist" ("id","date","user_id","PlaceName") VALUES (8,'2021-12-28 12:25:51.531283',5,'Cox_Bazar');
INSERT INTO "main_wishlist" ("id","date","user_id","PlaceName") VALUES (11,'2022-01-04 14:50:05.434167',5,'Cumilla');
INSERT INTO "main_userblog" ("id","Title","text","place_Img1","user_id","date") VALUES (8,'gg','wp','cox-blog_a69SxJF.jpg',5,'2021-12-29 20:13:16.029906');
INSERT INTO "main_userblog" ("id","Title","text","place_Img1","user_id","date") VALUES (9,'Test2','bad','Dhaka_jzloD4F.jpg',5,'2021-12-29 20:24:07.010854');
INSERT INTO "main_userblog" ("id","Title","text","place_Img1","user_id","date") VALUES (11,'test','dwdwad','',7,'2022-01-04 17:44:32.237905');
INSERT INTO "main_userblog" ("id","Title","text","place_Img1","user_id","date") VALUES (12,'ergegerg','','',7,'2022-01-04 17:46:32.745137');
INSERT INTO "main_appreview" ("id","comment","rate","date","user_id") VALUES (1,'Good',5,'2022-01-01 09:07:11.602440',7);
INSERT INTO "main_userprofile" ("id","user_name","user_phone","user_address","date","bio","user_id","user_image") VALUES (11,'Rashik Buksh','01709305072','Dhaka, Bangladesh','2021-12-24 21:46:03.843329','Gamer',5,'media/IMG_4720_wiyK6M0.jpg');
INSERT INTO "main_userprofile" ("id","user_name","user_phone","user_address","date","bio","user_id","user_image") VALUES (12,'Rashik Buksh','01464645','Dhaka, Bangladesh','2021-12-26 12:32:47.937981','Eldian Rebel Faction',10,'media/buksh_4MWJDtq.jpg');
INSERT INTO "main_userprofile" ("id","user_name","user_phone","user_address","date","bio","user_id","user_image") VALUES (13,'Hasib Ar Rafiul Fahim','01794798101','Dhaka, Bangladesh','2021-12-26 12:39:32.523336','Metaphysically retarded',11,'media/dp_5Y3vM6E.jpg');
INSERT INTO "main_userprofile" ("id","user_name","user_phone","user_address","date","bio","user_id","user_image") VALUES (14,'rashikbuksh','01684545111','Dhaka, Bangladesh','2022-01-02 13:20:04.235263','Programmer',7,'media/IMG_4722_egMM6fQ.jpg');
INSERT INTO "main_userprofile" ("id","user_name","user_phone","user_address","date","bio","user_id","user_image") VALUES (16,'RBR','01684545111','Dhaka, Bangladesh','2022-01-02 16:04:50.691166','Programmer',14,'media/IMG_4720_dI7BEjM.jpg');
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "accounts_user_groups_user_id_group_id_59c0b32f_uniq" ON "accounts_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_groups_user_id_52b62117" ON "accounts_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_groups_group_id_bd11a704" ON "accounts_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "accounts_user_user_permissions_user_id_permission_id_2ab516c2_uniq" ON "accounts_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_user_permissions_user_id_e4f0a161" ON "accounts_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_user_permissions_permission_id_113bb443" ON "accounts_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE UNIQUE INDEX IF NOT EXISTS "social_auth_nonce_server_url_timestamp_salt_f6284463_uniq" ON "social_auth_nonce" (
	"server_url",
	"timestamp",
	"salt"
);
CREATE UNIQUE INDEX IF NOT EXISTS "social_auth_association_server_url_handle_078befa2_uniq" ON "social_auth_association" (
	"server_url",
	"handle"
);
CREATE UNIQUE INDEX IF NOT EXISTS "social_auth_code_email_code_801b2d02_uniq" ON "social_auth_code" (
	"email",
	"code"
);
CREATE INDEX IF NOT EXISTS "social_auth_code_code_a2393167" ON "social_auth_code" (
	"code"
);
CREATE INDEX IF NOT EXISTS "social_auth_code_timestamp_176b341f" ON "social_auth_code" (
	"timestamp"
);
CREATE INDEX IF NOT EXISTS "social_auth_partial_token_3017fea3" ON "social_auth_partial" (
	"token"
);
CREATE INDEX IF NOT EXISTS "social_auth_partial_timestamp_50f2119f" ON "social_auth_partial" (
	"timestamp"
);
CREATE UNIQUE INDEX IF NOT EXISTS "social_auth_usersocialauth_provider_uid_e6b5e668_uniq" ON "social_auth_usersocialauth" (
	"provider",
	"uid"
);
CREATE INDEX IF NOT EXISTS "social_auth_usersocialauth_user_id_17d28448" ON "social_auth_usersocialauth" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "social_auth_usersocialauth_uid_796e51dc" ON "social_auth_usersocialauth" (
	"uid"
);
CREATE INDEX IF NOT EXISTS "main_hotelreview_user_id_722b00a1" ON "main_hotelreview" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "main_hotelreservation_user_id_71854f53" ON "main_hotelreservation" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "main_roommodel_slug_d7336076" ON "main_roommodel" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "main_place_slug_ea306f42" ON "main_place" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "main_resturantinfo_slug_b09fa819" ON "main_resturantinfo" (
	"slug"
);
CREATE INDEX IF NOT EXISTS "main_placereview_user_id_739f0c2f" ON "main_placereview" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "main_resturantreview_user_id_8ac6fd5c" ON "main_resturantreview" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "main_chat_from_user_id_0904c56d" ON "main_chat" (
	"from_user_id"
);
CREATE INDEX IF NOT EXISTS "main_chat_to_user_id_5149039a" ON "main_chat" (
	"to_user_id"
);
CREATE INDEX IF NOT EXISTS "main_chatforummessages_message_user_id_33bf74b4" ON "main_chatforummessages" (
	"message_user_id"
);
CREATE INDEX IF NOT EXISTS "main_wishlist_user_id_c5890d9b" ON "main_wishlist" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "main_userblog_user_id_ab749c51" ON "main_userblog" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "main_appreview_user_id_b9b459ee" ON "main_appreview" (
	"user_id"
);
COMMIT;
