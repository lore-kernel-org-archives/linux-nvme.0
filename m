From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 09:54:15 +0200
Subject: [PATCH 1/3] nvmet: identify controller: improve standard
 compliance
In-Reply-To: <20170713222533.30794-2-mwilck@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713222533.30794-2-mwilck@suse.com>
Message-ID: <20170714075415.GB17877@lst.de>

Can you add your copy_and_pad helper to include/linux/kernel.h?
I'll also need it for the nvme host multipath support.
