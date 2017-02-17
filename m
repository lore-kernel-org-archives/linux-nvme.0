From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Feb 2017 13:59:37 +0100
Subject: OPAL fixups
Message-ID: <20170217125941.14319-1-hch@lst.de>

Hi all,

this contains a few more OPAL-related fixups.  It tones down warnings a bit,
allocates the OPAL-?pecific data structure in a separate dynamic allocation,
checks for support of Security Send/Receive in NVMe before using them,
and makes sure we re-discovery the security capabilities after each reset.
