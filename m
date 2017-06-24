From: hch@lst.de (Christoph Hellwig)
Date: Sat, 24 Jun 2017 09:17:01 +0200
Subject: Booting from NVMe over Fabrics
In-Reply-To: <20170622130600.GK5670@linux-x5ow.site>
References: <20170622130600.GK5670@linux-x5ow.site>
Message-ID: <20170624071701.GC14580@lst.de>

As long as you don't have weird hardware offloads (which seems rather
pointless) there is nothing interesting in booting NVMe - yes you'll
need NVMe-cli, and a working RDMA setup.  But that's not any different
than SRP or iSER, or NFS over RDMA, so we the distros should do the
same for NVMe that they do for those technolog?es.
