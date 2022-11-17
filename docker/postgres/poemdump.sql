-- PostgreSQL database dump
--

-- Dumped from database version 13.8
-- Dumped by pg_dump version 13.8

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: accounts_account; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.accounts_account (
    id bigint NOT NULL,
    password character varying(128) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone_number character varying(50) NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone NOT NULL,
    is_admin boolean NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superadmin boolean NOT NULL
);


ALTER TABLE public.accounts_account OWNER TO iko;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO iko;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO iko;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO iko;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO iko;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO iko;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO iko;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO iko;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO iko;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO iko;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO iko;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO iko;

--
-- Name: poem_author; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.poem_author (
    id bigint NOT NULL,
    first_name character varying(20) NOT NULL,
    last_name character varying(20) NOT NULL,
    slug character varying(20) NOT NULL
);


ALTER TABLE public.poem_author OWNER TO iko;

--
-- Name: poem_author_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.poem_author ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.poem_author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: poem_holiday; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.poem_holiday (
    id bigint NOT NULL,
    name character varying(30) NOT NULL,
    description text NOT NULL,
    slug character varying(30) NOT NULL
);


ALTER TABLE public.poem_holiday OWNER TO iko;

--
-- Name: poem_holiday_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.poem_holiday ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.poem_holiday_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: poem_poem; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.poem_poem (
    id bigint NOT NULL,
    title character varying(50) NOT NULL,
    text text NOT NULL,
    is_published boolean NOT NULL,
    avg_rating double precision NOT NULL,
    number_rating integer NOT NULL,
    holiday_id bigint NOT NULL,
    user_id integer NOT NULL,
    author_id bigint NOT NULL,
    time_create timestamp with time zone,
    time_update timestamp with time zone
);


ALTER TABLE public.poem_poem OWNER TO iko;

--
-- Name: poem_poem_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.poem_poem ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.poem_poem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: poem_review; Type: TABLE; Schema: public; Owner: iko
--

CREATE TABLE public.poem_review (
    id bigint NOT NULL,
    rating integer NOT NULL,
    description character varying(200),
    active boolean NOT NULL,
    created timestamp with time zone NOT NULL,
    update timestamp with time zone NOT NULL,
    poem_id bigint NOT NULL,
    review_user_id integer NOT NULL,
    CONSTRAINT poem_review_rating_check CHECK ((rating >= 0))
);


ALTER TABLE public.poem_review OWNER TO iko;

--
-- Name: poem_review_id_seq; Type: SEQUENCE; Schema: public; Owner: iko
--

ALTER TABLE public.poem_review ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.poem_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: accounts_account; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.accounts_account (id, password, first_name, last_name, username, email, phone_number, date_joined, last_login, is_admin, is_staff, is_active, is_superadmin) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add Автор	7	add_author
26	Can change Автор	7	change_author
27	Can delete Автор	7	delete_author
28	Can view Автор	7	view_author
29	Can add holiday	8	add_holiday
30	Can change holiday	8	change_holiday
31	Can delete holiday	8	delete_holiday
32	Can view holiday	8	view_holiday
33	Can add poem	9	add_poem
34	Can change poem	9	change_poem
35	Can delete poem	9	delete_poem
36	Can view poem	9	view_poem
37	Can add review	10	add_review
38	Can change review	10	change_review
39	Can delete review	10	delete_review
40	Can view review	10	view_review
41	Can add Token	11	add_token
42	Can change Token	11	change_token
43	Can delete Token	11	delete_token
44	Can view Token	11	view_token
45	Can add token	12	add_tokenproxy
46	Can change token	12	change_tokenproxy
47	Can delete token	12	delete_tokenproxy
48	Can view token	12	view_tokenproxy
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$390000$YwqA2fzxKkhm0vnLZMwwJZ$cSGm1RapMetu2xVQNq5gvDVbsu9m152UQWx7RLn5Dj4=	\N	f	iko10				f	t	2022-11-04 16:58:29.868553+00
3	pbkdf2_sha256$390000$mb6AExrjjkBZc4PDJNwmIl$KCDpNJ4cC/p9R9oFflb1Xow4dXrO0aIji9Aup5WI+ow=	\N	f	iko				f	t	2022-11-04 17:01:16.925536+00
1	pbkdf2_sha256$390000$7DeTKg4RQSA0zUiJOI77eT$KBh05mFQmvOpS0U5wy4oVRW/Gi8hJWBNitszAh88uRc=	2022-11-05 13:23:45.553205+00	t	admin			i.korotkevitch@gmail.com	t	t	2022-11-04 15:30:23.904008+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-11-04 15:36:03.014629+00	1	День рождения	1	[{"added": {}}]	8	1
2	2022-11-04 17:37:45.648334+00	1	День рождения	2	[{"changed": {"fields": ["\\u041f\\u0440\\u0430\\u0437\\u0434\\u043d\\u0438\\u043a"]}}]	8	1
3	2022-11-05 13:40:04.230702+00	1	Серяков	1	[{"added": {}}]	7	1
4	2022-11-05 13:40:35.697334+00	2	Мышковец	1	[{"added": {}}]	7	1
5	2022-11-05 13:41:05.899425+00	3	Степанова	1	[{"added": {}}]	7	1
6	2022-11-05 13:42:27.265886+00	1	Тебе еще... ну… сто не скоро	1	[{"added": {}}]	9	1
7	2022-11-05 13:42:59.541534+00	2	Ты именинник не обычный	1	[{"added": {}}]	9	1
8	2022-11-05 13:43:29.784463+00	3	Едва открыв сегодня очи	1	[{"added": {}}]	9	1
9	2022-11-05 13:43:58.56612+00	4	Ты старше стал на год - ну, что же	1	[{"added": {}}]	9	1
10	2022-11-05 13:44:25.764029+00	5	Всем дням рождения особо	1	[{"added": {}}]	9	1
11	2022-11-05 13:45:02.310932+00	6	Сегодня повод есть блестящий	1	[{"added": {}}]	9	1
12	2022-11-05 13:45:36.934528+00	7	Все лучшее - за днем рождения	1	[{"added": {}}]	9	1
13	2022-11-05 13:46:15.951459+00	8	Сегодня праздник не обычный	1	[{"added": {}}]	9	1
14	2022-11-05 13:46:46.356812+00	9	Хоть дни рожденья быстротечны	1	[{"added": {}}]	9	1
15	2022-11-05 13:47:19.599611+00	10	Сегодня праздник самый лучший	1	[{"added": {}}]	9	1
16	2022-11-05 15:32:23.489726+00	5	4 | Сегодня праздник не обычный | admin	1	[{"added": {}}]	10	1
17	2022-11-05 15:32:51.406772+00	5	4 | Сегодня праздник не обычный | admin	2	[{"changed": {"fields": ["\\u041e\\u0442\\u0437\\u044b\\u0432"]}}]	10	1
18	2022-11-05 15:33:13.907819+00	6	2 | Всем дням рождения особо | iko10	1	[{"added": {}}]	10	1
19	2022-11-05 15:38:50.456079+00	7	2 | Всем дням рождения особо | iko	1	[{"added": {}}]	10	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	poem	author
8	poem	holiday
9	poem	poem
10	poem	review
11	authtoken	token
12	authtoken	tokenproxy
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-11-04 15:23:16.717563+00
2	auth	0001_initial	2022-11-04 15:23:16.869392+00
3	admin	0001_initial	2022-11-04 15:23:16.913886+00
4	admin	0002_logentry_remove_auto_add	2022-11-04 15:23:16.932346+00
5	admin	0003_logentry_add_action_flag_choices	2022-11-04 15:23:16.95134+00
6	contenttypes	0002_remove_content_type_name	2022-11-04 15:23:16.997679+00
7	auth	0002_alter_permission_name_max_length	2022-11-04 15:23:17.021754+00
8	auth	0003_alter_user_email_max_length	2022-11-04 15:23:17.034075+00
9	auth	0004_alter_user_username_opts	2022-11-04 15:23:17.067512+00
10	auth	0005_alter_user_last_login_null	2022-11-04 15:23:17.081567+00
11	auth	0006_require_contenttypes_0002	2022-11-04 15:23:17.085129+00
12	auth	0007_alter_validators_add_error_messages	2022-11-04 15:23:17.100217+00
13	auth	0008_alter_user_username_max_length	2022-11-04 15:23:17.119394+00
14	auth	0009_alter_user_last_name_max_length	2022-11-04 15:23:17.167869+00
15	auth	0010_alter_group_name_max_length	2022-11-04 15:23:17.184154+00
16	auth	0011_update_proxy_permissions	2022-11-04 15:23:17.200385+00
17	auth	0012_alter_user_first_name_max_length	2022-11-04 15:23:17.213716+00
18	authtoken	0001_initial	2022-11-04 15:23:17.30174+00
19	authtoken	0002_auto_20160226_1747	2022-11-04 15:23:17.367681+00
20	authtoken	0003_tokenproxy	2022-11-04 15:23:17.372565+00
21	poem	0001_initial	2022-11-04 15:23:17.561106+00
22	poem	0002_alter_poem_avg_rating_alter_poem_number_rating	2022-11-04 15:23:17.592916+00
23	poem	0003_poem_author_alter_poem_user	2022-11-04 15:23:17.726584+00
24	poem	0004_remove_poem_time_create_remove_poem_time_update	2022-11-04 15:23:17.757337+00
25	poem	0005_poem_time_create_poem_time_update	2022-11-04 15:23:17.871329+00
26	sessions	0001_initial	2022-11-04 15:23:17.89028+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
mct2amtdno4j63l27y3vcaqqt11brnpz	.eJxVjDkOwjAUBe_iGlnxHlPS5wzWXwwOIFuKkwpxd4iUAto3M-8lEmxrSVvPS5pZnIUSp98NgR657oDvUG9NUqvrMqPcFXnQLqfG-Xk53L-DAr18a-tdHpVXBgM55yIgMZN10bD3FodgYaRwZdBI2mY1AEVvjNKRPeoYxPsD24I3ow:1or0yV:VJQXZI-OrqNJ77NGAaFyw9cIjvmGPgyKogInXlaZnos	2022-11-18 17:59:27.779066+00
2chbc2meaudlg0mohenvzh2uz3wp57yz	.eJxVjDkOwjAUBe_iGlnxHlPS5wzWXwwOIFuKkwpxd4iUAto3M-8lEmxrSVvPS5pZnIUSp98NgR657oDvUG9NUqvrMqPcFXnQLqfG-Xk53L-DAr18a-tdHpVXBgM55yIgMZN10bD3FodgYaRwZdBI2mY1AEVvjNKRPeoYxPsD24I3ow:1orJ9F:CZIUkYjRXOE7dYLs9GXRC2uv35X1g5qUsP2Y6mCnRTw	2022-11-19 13:23:45.556964+00
\.


--
-- Data for Name: poem_author; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.poem_author (id, first_name, last_name, slug) FROM stdin;
1	Валерий	Серяков	seryakov
2	Денис	Мышковец	myshkovec
3	Тамара	Степанова	stepanova
\.


--
-- Data for Name: poem_holiday; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.poem_holiday (id, name, description, slug) FROM stdin;
1	День рождения		den-rozhdeniya
\.


--
-- Data for Name: poem_poem; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.poem_poem (id, title, text, is_published, avg_rating, number_rating, holiday_id, user_id, author_id, time_create, time_update) FROM stdin;
1	Тебе еще... ну… сто не скоро	Тебе еще... ну… сто не скоро. \r\nЕще кипит младая кровь! \r\nЕще свернуть готов ты горы. \r\nИ правду резануть не в бровь.	t	0	0	1	1	1	2022-11-05 13:42:27.260704+00	2022-11-05 13:42:27.260726+00
2	Ты именинник не обычный	Ты именинник не обычный: \r\nТы добр, умен... да просто крут. \r\nТебе сегодня громко, зычно \r\nВсе "happy birthday" пропоют.	t	0	0	1	3	2	2022-11-05 13:42:59.538977+00	2022-11-05 13:42:59.539+00
3	Едва открыв сегодня очи	Едва открыв сегодня очи, \r\nЗатем - съедая бутерброд, \r\nЯ понимал... нет, знал я точно: \r\nВ твой день рожденья повезет.	t	0	0	1	2	3	2022-11-05 13:43:29.781257+00	2022-11-05 13:43:29.781303+00
8	Сегодня праздник не обычный	Сегодня праздник не обычный: \r\nМилы, любезны все вокруг. \r\nПоставят торт и громко, зычно \r\nПро "happy birthday" пропоют.	t	0	0	1	3	2	2022-11-05 13:46:15.948911+00	2022-11-05 13:46:15.948935+00
9	Хоть дни рожденья быстротечны	Хоть дни рожденья быстротечны, \r\nИ между ними целый год, \r\nНо в честь тебя зажгутся свечи \r\nИ будет съеден лучший торт.	t	0	0	1	2	3	2022-11-05 13:46:46.354148+00	2022-11-05 13:46:46.354183+00
10	Сегодня праздник самый лучший	Сегодня праздник самый лучший. \r\nЖаль, новый только через год... \r\nЗвонят друзья, пылают уши, \r\nИ по фигуре плачет торт.	t	0	0	1	1	1	2022-11-05 13:47:19.597077+00	2022-11-05 13:47:19.597105+00
7	Все лучшее - за днем рождения	Все лучшее - за днем рождения. \r\nЖелаю  радостных вестей! \r\nПусть будет лучшим отношение \r\nЦены побед к числу друзей!	t	4	1	1	1	1	2022-11-05 13:45:36.93202+00	2022-11-05 15:19:53.327556+00
6	Сегодня повод есть блестящий	Сегодня повод есть блестящий \r\nПоздравить с праздником таким!.. \r\nВедь ты - мужчина настоящий \r\nС крутым характером мужским.	t	1	1	1	2	3	2022-11-05 13:45:02.307263+00	2022-11-05 15:21:22.561383+00
5	Всем дням рождения особо	Всем дням рождения особо \r\nОтведена по жизни роль. \r\nТы - именинная особа: \r\nЕго величество король.	t	5	1	1	3	2	2022-11-05 13:44:25.75746+00	2022-11-05 15:21:49.368669+00
4	Ты старше стал на год - ну, что же	Ты старше стал на год - ну, что же? \r\nТы только сердцем не старей. \r\nМы не становимся моложе, \r\nНо мы становимся мудрей.	t	2.5	2	1	1	1	2022-11-05 13:43:58.562584+00	2022-11-05 15:42:12.582681+00
\.


--
-- Data for Name: poem_review; Type: TABLE DATA; Schema: public; Owner: iko
--

COPY public.poem_review (id, rating, description, active, created, update, poem_id, review_user_id) FROM stdin;
1	4	Классные стихи	t	2022-11-05 15:19:53.331755+00	2022-11-05 15:19:53.33177+00	7	1
2	1	Хорошие стихи	t	2022-11-05 15:21:22.564512+00	2022-11-05 15:21:22.564528+00	6	1
3	5	Интересные стихи	t	2022-11-05 15:21:49.372856+00	2022-11-05 15:21:49.37288+00	5	1
4	3	Средние стихи	t	2022-11-05 15:22:54.25841+00	2022-11-05 15:22:54.258425+00	4	1
5	4	Хорошие, но не отличные.	t	2022-11-05 15:32:23.484306+00	2022-11-05 15:32:51.398817+00	8	1
6	2	Не очень.	t	2022-11-05 15:33:13.905552+00	2022-11-05 15:33:13.905581+00	5	2
7	2	Не понравилось.	t	2022-11-05 15:38:50.453512+00	2022-11-05 15:38:50.453537+00	5	3
8	2	Не понравились	t	2022-11-05 15:42:12.586034+00	2022-11-05 15:42:12.586057+00	4	3
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 48, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 3, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 19, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 12, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 26, true);


--
-- Name: poem_author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.poem_author_id_seq', 3, true);


--
-- Name: poem_holiday_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.poem_holiday_id_seq', 1, true);


--
-- Name: poem_poem_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.poem_poem_id_seq', 10, true);


--
-- Name: poem_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: iko
--

SELECT pg_catalog.setval('public.poem_review_id_seq', 8, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: poem_author poem_author_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_author
    ADD CONSTRAINT poem_author_pkey PRIMARY KEY (id);


--
-- Name: poem_author poem_author_slug_key; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_author
    ADD CONSTRAINT poem_author_slug_key UNIQUE (slug);


--
-- Name: poem_holiday poem_holiday_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_holiday
    ADD CONSTRAINT poem_holiday_pkey PRIMARY KEY (id);


--
-- Name: poem_holiday poem_holiday_slug_key; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_holiday
    ADD CONSTRAINT poem_holiday_slug_key UNIQUE (slug);


--
-- Name: poem_poem poem_poem_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_poem
    ADD CONSTRAINT poem_poem_pkey PRIMARY KEY (id);


--
-- Name: poem_review poem_review_pkey; Type: CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_review
    ADD CONSTRAINT poem_review_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: poem_author_slug_6e72163c_like; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX poem_author_slug_6e72163c_like ON public.poem_author USING btree (slug varchar_pattern_ops);


--
-- Name: poem_holiday_slug_13f48b96_like; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX poem_holiday_slug_13f48b96_like ON public.poem_holiday USING btree (slug varchar_pattern_ops);


--
-- Name: poem_poem_author_id_9ec78470; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX poem_poem_author_id_9ec78470 ON public.poem_poem USING btree (author_id);


--
-- Name: poem_poem_holiday_id_606e78ae; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX poem_poem_holiday_id_606e78ae ON public.poem_poem USING btree (holiday_id);


--
-- Name: poem_poem_user_id_2a3bf052; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX poem_poem_user_id_2a3bf052 ON public.poem_poem USING btree (user_id);


--
-- Name: poem_review_poem_id_35249e81; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX poem_review_poem_id_35249e81 ON public.poem_review USING btree (poem_id);


--
-- Name: poem_review_review_user_id_4ff0379e; Type: INDEX; Schema: public; Owner: iko
--

CREATE INDEX poem_review_review_user_id_4ff0379e ON public.poem_review USING btree (review_user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: poem_poem poem_poem_author_id_9ec78470_fk_poem_author_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_poem
    ADD CONSTRAINT poem_poem_author_id_9ec78470_fk_poem_author_id FOREIGN KEY (author_id) REFERENCES public.poem_author(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: poem_poem poem_poem_holiday_id_606e78ae_fk_poem_holiday_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_poem
    ADD CONSTRAINT poem_poem_holiday_id_606e78ae_fk_poem_holiday_id FOREIGN KEY (holiday_id) REFERENCES public.poem_holiday(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: poem_poem poem_poem_user_id_2a3bf052_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_poem
    ADD CONSTRAINT poem_poem_user_id_2a3bf052_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: poem_review poem_review_poem_id_35249e81_fk_poem_poem_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_review
    ADD CONSTRAINT poem_review_poem_id_35249e81_fk_poem_poem_id FOREIGN KEY (poem_id) REFERENCES public.poem_poem(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: poem_review poem_review_review_user_id_4ff0379e_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: iko
--

ALTER TABLE ONLY public.poem_review
    ADD CONSTRAINT poem_review_review_user_id_4ff0379e_fk_auth_user_id FOREIGN KEY (review_user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--
