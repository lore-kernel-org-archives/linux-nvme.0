From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 22 May 2017 11:51:27 -0700
Subject: [PATCH v2] nvme-rdma: support devices with queue size < 32
In-Reply-To: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
Message-ID: <20170522185127.GA27542@infradead.org>

I've hand applies this once with a few formatting tweaks now that
I got the ACK from Sagi.  ?'d love to see if someone could figure
out how we could move the improved atomic + ilog version into the
rdma core somehow.
