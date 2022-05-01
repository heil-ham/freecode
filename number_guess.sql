--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: data; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.data (
    username character varying(20),
    best_game integer,
    games_played integer
);


ALTER TABLE public.data OWNER TO freecodecamp;

--
-- Data for Name: data; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.data VALUES ('user_1651403074270', 41, 2);
INSERT INTO public.data VALUES ('user_1651403074271', 2, 5);
INSERT INTO public.data VALUES ('user_1651403086229', 17, 2);
INSERT INTO public.data VALUES ('user_1651403086230', 22, 5);
INSERT INTO public.data VALUES ('adikontol', 7, 3);
INSERT INTO public.data VALUES ('joko', 10, 2);
INSERT INTO public.data VALUES ('user_1651402891433', 29, 2);
INSERT INTO public.data VALUES ('user_1651402891434', 19, 5);
INSERT INTO public.data VALUES ('user_1651402917614', 18, 2);
INSERT INTO public.data VALUES ('user_1651402917615', 14, 5);
INSERT INTO public.data VALUES ('user_1651402925267', 41, 2);
INSERT INTO public.data VALUES ('user_1651402925268', 16, 5);
INSERT INTO public.data VALUES ('user_1651403012433', 47, 2);
INSERT INTO public.data VALUES ('user_1651403012434', 4, 5);
INSERT INTO public.data VALUES ('user_1651403016561', 16, 2);
INSERT INTO public.data VALUES ('user_1651403016562', 20, 5);


--
-- PostgreSQL database dump complete
--

