-- PostgreSQL database dump
-- Dumped from database version 12
-- Dumped by pg_dump version 12

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

DROP DATABASE IF EXISTS universe;
CREATE DATABASE universe;

\c universe

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

-- 
-- TABLE: galaxy
-- 
CREATE TABLE public.galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_type TEXT NOT NULL,
    distance_from_earth_kly NUMERIC,
    has_black_hole BOOLEAN NOT NULL,
	age INT,
	is_active BOOLEAN,
	navigation BOOLEAN,
	diameter INT,
	description TEXT
);

-- 
-- TABLE: star
-- 
CREATE TABLE public.star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    galaxy_id INT NOT NULL REFERENCES public.galaxy(galaxy_id),
    age_in_millions_of_years INT,
    is_spherical BOOLEAN NOT NULL,
	is_active BOOLEAN,
	navigation BOOLEAN,
	diameter INT,
	description TEXT
);

-- 
-- TABLE: planet_types (5th table requirement)
-- 
CREATE TABLE public.planet_types (
    planet_type_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
	age INT,
	is_active BOOLEAN,
	navigation BOOLEAN,
	diameter INT
);

-- 
-- TABLE: planet
-- 
CREATE TABLE public.planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    star_id INT NOT NULL REFERENCES public.star(star_id),
    planet_type_id INT REFERENCES public.planet_types(planet_type_id),
    has_life BOOLEAN NOT NULL,
    distance_from_earth NUMERIC,
	age INT,
	is_active BOOLEAN,
	navigation BOOLEAN,
	diameter INT,
	description TEXT
);

-- 
-- TABLE: moon
-- 
CREATE TABLE public.moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    planet_id INT NOT NULL REFERENCES public.planet(planet_id),
    radius_km INT,
    is_spherical BOOLEAN NOT NULL,
	age INT,
	is_active BOOLEAN,
	navigation BOOLEAN,
	diameter INT,
	description TEXT
);


-- 
-- DATA FOR: galaxy (Minimum 6 rows)
-- 
INSERT INTO public.galaxy (name, galaxy_type, distance_from_earth_kly, has_black_hole) VALUES
('Milky Way', 'Barred Spiral', 0.0, true),
('Andromeda', 'Spiral', 2537.0, true),
('Triangulum', 'Spiral', 2736.0, false),
('Sombrero', 'Lenticular', 31100.0, true),
('Whirlpool', 'Spiral', 23100.0, true),
('Pinwheel', 'Spiral', 21000.0, true);

-- 
-- DATA FOR: star (Minimum 6 rows)
-- 
INSERT INTO public.star (name, galaxy_id, age_in_millions_of_years, is_spherical) VALUES
('Sun', 1, 4600, true),
('Sirius', 1, 300, true),
('Alpha Centauri A', 1, 5300, true),
('Betelgeuse', 1, 10, false),
('Rigel', 1, 8, true),
('Mayall II', 2, 12000, true);

-- 
-- DATA FOR: planet_types (Minimum 3 rows)
-- 
INSERT INTO public.planet_types (name, description) VALUES
('Terrestrial', 'Primarily composed of silicate rocks or metals.'),
('Gas Giant', 'A large planet composed mostly of gases, such as hydrogen and helium.'),
('Ice Giant', 'A massive planet with heavier elements like oxygen, carbon, nitrogen, and sulfur.');

-- 
-- DATA FOR: planet (Minimum 12 rows)
-- 
INSERT INTO public.planet (name, star_id, planet_type_id, has_life, distance_from_earth) VALUES
('Earth', 1, 1, true, 0),
('Mars', 1, 1, false, 0.000008),
('Jupiter', 1, 2, false, 0.000066),
('Saturn', 1, 2, false, 0.00013),
('Venus', 1, 1, false, 0.000004),
('Mercury', 1, 1, false, 0.000009),
('Uranus', 1, 3, false, 0.00028),
('Neptune', 1, 3, false, 0.00046),
('Proxima Centauri b', 3, 1, false, 4.24),
('Sirius b', 2, 1, false, 8.6),
('Betelgeuse b', 4, 2, false, 642.0),
('Rigel b', 5, 2, false, 860.0);

-- 
-- DATA FOR: moon (Minimum 20 rows)
-- 
INSERT INTO public.moon (name, planet_id, radius_km, is_spherical) VALUES
('Moon', 1, 1737, true),
('Phobos', 2, 11, false),
('Deimos', 2, 6, false),
('Io', 3, 1821, true),
('Europa', 3, 1560, true),
('Ganymede', 3, 2634, true),
('Callisto', 3, 2410, true),
('Mimas', 4, 198, true),
('Enceladus', 4, 252, true),
('Tethys', 4, 531, true),
('Dione', 4, 561, true),
('Rhea', 4, 763, true),
('Titan', 4, 2574, true),
('Iapetus', 4, 734, true),
('Miranda', 7, 235, true),
('Ariel', 7, 578, true),
('Umbriel', 7, 584, true),
('Titania', 7, 788, true),
('Oberon', 7, 761, true),
('Triton', 8, 1353, true);

-- End of dump