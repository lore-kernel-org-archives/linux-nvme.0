From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:41:05 +0200
Subject: [PATCH 2/4] nvmet: ANA transition timeout handling
In-Reply-To: <20180607153155.76452888@pentland.suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-3-hare@suse.de> <20180607120745.GB11938@lst.de>
 <20180607153155.76452888@pentland.suse.de>
Message-ID: <20180607134105.GA15459@lst.de>

On Thu, Jun 07, 2018@03:31:55PM +0200, Hannes Reinecke wrote:
> But we would _require_ userspace interaction to facilitate correct
> operation. And with a purely manual configuration on the target any
> ANATT value becomes meaningless as we have no way of enforcing it.

?  The whole change state is entirely optional.  For 90% of the
users you'll never enter it.  And when you need it, we need to
control when to enter and exit it.  The timer is of absolutely
no use.
