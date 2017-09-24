From: hch@lst.de (Christoph Hellwig)
Date: Sun, 24 Sep 2017 16:56:05 +0200
Subject: [PATCH rfc] nvme-cli: NVMf auto discovery systemd service
In-Reply-To: <1506258095-15916-1-git-send-email-sagi@grimberg.me>
References: <1506258095-15916-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170924145605.GB14806@lst.de>

This looks reasoanable to me, although I'm really not the expert
for systemd stuff.

Does it handle the case where /etc/nvme/discovery.conf is non-existent
(yes, you created in the specfile, but not everyone uses rpms).

> We can also add some documentation into discovery.conf to help
> the user add discovery endpoints.

That would be great for the default one, e.g. some example RDMA
and FC configfs.
