From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Jul 2019 22:02:37 +1000
Subject: [PATCH v2 2/3] nvme-pci: Add support for variable IO SQ element
 size
In-Reply-To: <20190717115145.GB10495@minwoo-desktop>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
 <20190717004527.30363-2-benh@kernel.crashing.org>
 <20190717115145.GB10495@minwoo-desktop>
Message-ID: <2cc90b8cfa935e345ec2b185b087f1859a040176.camel@kernel.crashing.org>

On Wed, 2019-07-17@20:51 +0900, Minwoo Im wrote:
> -	struct nvme_command *sq_cmds;
> > +	void *sq_cmds;
> 
> It would be great if it can remain the existing data type for the
> SQEs...  But I'm fine with this also.
> 
> It looks good to me.

I changed it on purpose so we aren't tempted to index the array, since
that's not always valid.

Cheers,
Ben.
