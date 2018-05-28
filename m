From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:20:39 +0200
Subject: [PATCH] nvme: re-enable clean shutdown
In-Reply-To: <78db23fc-6bf6-68b5-a298-6a44b0ece5ca@broadcom.com>
References: <20180525090524.58845-1-hare@suse.de>
 <78db23fc-6bf6-68b5-a298-6a44b0ece5ca@broadcom.com>
Message-ID: <20180528072039.GA5618@lst.de>

On Fri, May 25, 2018@08:53:36AM -0700, James Smart wrote:
> yep. sounds good.
>
> -- james
>
> Reviewed-by:? James Smart? <james.smart at broadcom.com>

Can you run this through your fc tet rig to make sure nothing breaks?
I'd rather get a little more testing on hairy code like this.
