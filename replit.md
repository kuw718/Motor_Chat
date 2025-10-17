# Motor Chat - Rails Application

## Overview
Motor Chat is a Ruby on Rails community platform for car enthusiasts. It allows users to share photos, join groups, post comments, and connect with other car lovers. The application is built in Japanese and includes features for user authentication (both customers and admins), social interactions, and group management.

## Recent Changes
**Date: October 17, 2025**
- Applied TMPDIR fix for Bundler deployment issues (world-writable workspace directory)
- Updated deployment configuration to use dedicated `/tmp/bundle_tmp` directory
- Updated `bin/dev-server` script to include TMPDIR configuration

**Date: October 6, 2025**
- Initial setup for Replit environment
- Updated Ruby version from 3.1.2 to 3.2.2 to match available Replit modules
- Configured Puma web server to run on port 5000 with 0.0.0.0 binding (required for Replit)
- Added `bin/dev-server` script to handle environment variable cleanup and server startup
- Configured `NODE_OPTIONS="--openssl-legacy-provider"` for Webpack compatibility with Node.js 20+
- Compiled Webpacker assets successfully
- Created and migrated SQLite3 development database
- Configured deployment settings for production

## Project Architecture

### Technology Stack
- **Framework**: Ruby on Rails 6.1.7
- **Ruby Version**: 3.2.2
- **Database**: SQLite3 (development), MySQL2 (production)
- **Authentication**: Devise
- **Frontend**: 
  - Webpacker 5.4.4
  - Bootstrap 4.6.2
  - jQuery 3.7.1
  - Turbolinks
- **Web Server**: Puma 3.12.6

### Key Components
- **User Management**: Two types of users (Customers and Admins) with Devise authentication
- **Social Features**: Posts, comments, favorites, follows/followers, groups
- **Content**: Post images with Active Storage support
- **Image Processing**: Using image_processing gem

### Database Schema
Key models include:
- `Customer` (users with Devise)
- `Admin` (administrators with Devise)
- `PostImage` (user posts)
- `PostComment` (comments on posts)
- `Favorite` (likes/favorites)
- `Group` (community groups)
- `GroupCustomer` (group membership)
- `JoinRequest` (group join requests)
- `Relationship` (follow/follower relationships)
- `Post` (group posts)

## Development Setup

### Environment Configuration
The application requires specific environment variable handling because Replit provides PostgreSQL variables by default, but this app uses SQLite3 in development:

- `TMPDIR=/tmp/bundle_tmp` is set to avoid Bundler security issues with world-writable directories
- `DATABASE_URL` must be unset to use database.yml configuration
- PostgreSQL-related variables (PGHOST, PGPORT, etc.) are unset in the startup script
- `NODE_OPTIONS="--openssl-legacy-provider"` is required for Webpack compatibility

### Starting the Development Server
The server is configured to run automatically via the "Rails Server" workflow, which executes:
```bash
bin/dev-server
```

This script:
1. Creates and sets TMPDIR to a dedicated directory (`/tmp/bundle_tmp`) for Bundler
2. Unsets PostgreSQL-related environment variables
3. Sets NODE_OPTIONS for legacy OpenSSL support
4. Starts Rails server on 0.0.0.0:5000

### Important Configuration Files
- `config/puma.rb`: Configured to bind to 0.0.0.0:5000 for Replit compatibility
- `config/environments/development.rb`: Already has `config.hosts.clear` for proxy support
- `config/database.yml`: Uses SQLite3 for development, MySQL2 for production
- `bin/dev-server`: Custom startup script for Replit environment

## Deployment
The application is configured for VM deployment with:
- Build step: Creates TMPDIR, installs gems (excluding dev/test), and precompiles assets
- Run step: Creates TMPDIR, runs migrations, and starts Puma server
- Production uses MySQL2 database (configured via ENV variables)
- TMPDIR is set to `/tmp/bundle_tmp` to resolve Bundler security issues with world-writable directories

## Known Issues
- Webpacker compilation shows deprecation warnings for Bootstrap SCSS (non-critical)
- Node.js requires legacy OpenSSL provider flag for webpack 4 compatibility
- npm packages have 121 vulnerabilities (inherited from older dependencies)

## User Notes
The application is fully functional and displays in Japanese. It requires user authentication to access most features. There are sign-up links for both customers and administrators on the login page.
