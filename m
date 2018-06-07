From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 13:24:23 +0200
Subject: [PATCH] blktrace: display failfast and driver-specific flags
In-Reply-To: <20180607083009.41793-1-hare@suse.de>
References: <20180607083009.41793-1-hare@suse.de>
Message-ID: <20180607112423.GB10742@lst.de>

Good idea to display the flags, but the characters aren't really
very self-describing.  Should we prefix each with an f maybe?
