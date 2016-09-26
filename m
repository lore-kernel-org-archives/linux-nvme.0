From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Sep 2016 15:15:44 -0700
Subject: nvme-cli won't build
In-Reply-To: <026701d21843$3f68bd70$be3a3850$@opengridcomputing.com>
References: <026701d21843$3f68bd70$be3a3850$@opengridcomputing.com>
Message-ID: <20160926221544.GA6978@infradead.org>

On Mon, Sep 26, 2016@05:13:45PM -0500, Steve Wise wrote:
> Anybody know what's up here?  I've got linux-4.8-rc8 kernel built/installed and
> the latest nvme-cli pulled, but nvme-cli fails to build.

Looks like your Linux headers are missing it.  It should be fairly easy
to avoid the need for it, let me see if I can do that.
