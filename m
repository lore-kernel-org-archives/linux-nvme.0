From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Jun 2017 08:52:55 +0200
Subject: [PATCH v1 7/7] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <d7170a45381be21b7d0da629406a063db62aaa42.1496237370.git.jthumshirn@suse.de>
References: <cover.1496237370.git.jthumshirn@suse.de>
 <d7170a45381be21b7d0da629406a063db62aaa42.1496237370.git.jthumshirn@suse.de>
Message-ID: <20170601065255.GG16778@lst.de>

On Wed, May 31, 2017@03:32:17PM +0200, Johannes Thumshirn wrote:
> Allow overriding the announced NVMe Version of a via configfs.
> 
> This is particularly helpful when debugging new features for the host
> or target side without bumping the hard coded version (as the target
> might not be fully compliant to the announced version yet).

It is.  Just bump to 1.3, please as Identify 3h is the only mandatory
change: http://nvmexpress.org/changes/
