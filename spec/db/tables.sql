DROP TABLE
  tweeter.`profiles`,
  tweeter.`preferences`,
  tweeter.`blocks`,
  tweeter.`mutes`,
  tweeter.`retweet_mutes`,
  tweeter.`follows`,
  tweeter.`likes`,
  tweeter.`retweets`,
  tweeter.`bookmarks`,
  tweeter.`tweets`,
  tweeter.`users`;
CREATE TABLE tweeter.users (
  internal_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  screen_name VARCHAR(32) UNIQUE NOT NULL,
  name VARCHAR(64),
  icon_uri CHAR(44),
  pw_hash CHAR(60) NOT NULL,
  is_private TINYINT(1) NOT NULL DEFAULT 0
);
CREATE TABLE tweeter.profiles (
  user_id BIGINT NOT NULL PRIMARY KEY,
  profile VARCHAR(140),
  place VARCHAR(64),
  header_uri CHAR(44),
  CONSTRAINT fk_profiles_user_id
  FOREIGN KEY (user_id)
  REFERENCES tweeter.users (internal_id)
  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.preferences (
  user_id BIGINT NOT NULL PRIMARY KEY,
  language_id SMALLINT UNSIGNED NOT NULL DEFAULT 0,
  colormode TINYINT UNSIGNED NOT NULL DEFAULT 0,
  CONSTRAINT fk_preferences_user_id
  FOREIGN KEY (user_id)
  REFERENCES tweeter.users (internal_id)
  ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.blocks (
  user_id BIGINT NOT NULL,
  blocked_id BIGINT NOT NULL,
  PRIMARY KEY (user_id, blocked_id),
  CONSTRAINT fk_blocks_user_id
    FOREIGN KEY (user_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_blocks_blocked_id
    FOREIGN KEY (blocked_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.mutes (
  user_id BIGINT NOT NULL,
  muted_id BIGINT NOT NULL,
  PRIMARY KEY (user_id, muted_id),
  CONSTRAINT fk_mutes_user_id
    FOREIGN KEY (user_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_mutes_muted_id
    FOREIGN KEY (muted_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.retweet_mutes (
  user_id BIGINT NOT NULL,
  muted_id BIGINT NOT NULL,
  PRIMARY KEY (user_id, muted_id),
  CONSTRAINT fk_retweet_mutes_user_id
    FOREIGN KEY (user_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_retweet_mutes_muted_id
    FOREIGN KEY (muted_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.follows (
  following_id BIGINT NOT NULL,
  followed_id BIGINT NOT NULL,
  followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (following_id, followed_id),
  CONSTRAINT fk_follows_following_id
    FOREIGN KEY (following_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_follows_followed_id
    FOREIGN KEY (followed_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.tweets (
  tweet_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNIQUE NOT NULL,
  tweeted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  content VARCHAR(140) NOT NULL,
  reply_to BIGINT,
  reply_category TINYINT NOT NULL DEFAULT 0,
  image1_uri char(44),
  image2_uri char(44),
  image3_uri char(44),
  image4_uri char(44),
  CONSTRAINT fk_tweets_user_id
    FOREIGN KEY (user_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT fk_tweets_reply_to
    FOREIGN KEY (reply_to)
    REFERENCES tweeter.tweets (tweet_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.likes (
  tweet_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tweet_id, user_id),
  CONSTRAINT fk_likes_tweet_id
    FOREIGN KEY (tweet_id)
    REFERENCES tweeter.tweets (tweet_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_likes_user_id
    FOREIGN KEY (user_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.retweets (
  tweet_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  retweeted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (tweet_id, user_id),
  CONSTRAINT fk_retweets_tweet_id
    FOREIGN KEY (tweet_id)
    REFERENCES tweeter.tweets (tweet_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_retweets_user_id
    FOREIGN KEY (user_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE tweeter.bookmarks (
  tweet_id BIGINT NOT NULL,
  user_id BIGINT NOT NULL,
  bookmarked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  category TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (tweet_id, user_id),
  CONSTRAINT fk_tweet_id
    FOREIGN KEY (tweet_id)
    REFERENCES tweeter.tweets (tweet_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_user_id
    FOREIGN KEY (user_id)
    REFERENCES tweeter.users (internal_id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
