-- База данных: Музыкальный сервис

-- Очищаем существующие таблицы
DROP TABLE IF EXISTS compilation_tracks CASCADE;
DROP TABLE IF EXISTS artist_albums CASCADE;
DROP TABLE IF EXISTS artist_genres CASCADE;
DROP TABLE IF EXISTS tracks CASCADE;
DROP TABLE IF EXISTS compilations CASCADE;
DROP TABLE IF EXISTS albums CASCADE;
DROP TABLE IF EXISTS artists CASCADE;
DROP TABLE IF EXISTS genres CASCADE;

-- Создаем таблицы
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER
);

CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER NOT NULL,
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE
);

CREATE TABLE compilations (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER
);

CREATE TABLE artist_genres (
    artist_id INTEGER REFERENCES artists(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, genre_id)
);

CREATE TABLE artist_albums (
    artist_id INTEGER REFERENCES artists(id) ON DELETE CASCADE,
    album_id INTEGER REFERENCES albums(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, album_id)
);

CREATE TABLE compilation_tracks (
    compilation_id INTEGER REFERENCES compilations(id) ON DELETE CASCADE,
    track_id INTEGER REFERENCES tracks(id) ON DELETE CASCADE,
    PRIMARY KEY (compilation_id, track_id)
);

-- Создаем индексы
CREATE INDEX idx_tracks_album_id ON tracks(album_id);
CREATE INDEX idx_artist_genres_artist_id ON artist_genres(artist_id);
CREATE INDEX idx_artist_genres_genre_id ON artist_genres(genre_id);
CREATE INDEX idx_artist_albums_artist_id ON artist_albums(artist_id);
CREATE INDEX idx_artist_albums_album_id ON artist_albums(album_id);
CREATE INDEX idx_compilation_tracks_compilation_id ON compilation_tracks(compilation_id);
CREATE INDEX idx_compilation_tracks_track_id ON compilation_tracks(track_id);