# docker-beef

Docker implementation of BeEF Browser Exploitation Framework using Alpine Linux image base.

https://github.com/beefproject/beef

If you are viewing this on docker hub, clone the full repo at https://github.com/isaudits/docker-beef
to get the launcher scripts and alias files described below.

## Usage
Override environment variables for ip addresses, credentials, etc with .env file.

Pull:

    docker pull isaudits/beef

or Build:

    ./build.sh
    
Run:

    docker run -it --rm isaudits/beef
    
or
    
    ./beef.sh


--------------------------------------------------------------------------------

Copyright 2018

Matthew C. Jones, CPA, CISA, OSCP, CCFE

IS Audits & Consulting, LLC - <http://www.isaudits.com/>

TJS Deemer Dana LLP - <http://www.tjsdd.com/>

--------------------------------------------------------------------------------

Except as otherwise specified:

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation, either version 3 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program. If not, see <http://www.gnu.org/licenses/>.