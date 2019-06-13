From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 12 Jun 2019 21:53:29 -0400
Subject: [PATCH v2 3/3] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <20190610210612.103952-4-bvanassche@acm.org> (Bart Van Assche's
 message of "Mon, 10 Jun 2019 14:06:12 -0700")
References: <20190610210612.103952-1-bvanassche@acm.org>
 <20190610210612.103952-4-bvanassche@acm.org>
Message-ID: <yq15zpa2que.fsf@oracle.com>


Bart,

> +	nawupf = (1 + ns->ctrl->subsys->awupf) * bs;
> +	if (id->nsfeat & (1 << 1))
> +		nawupf = (1 + id->nawupf) * bs;

This tripped me up a bit. I would have preferred an else statement and
maybe a clarifying comment to make it obvious whether the value comes
from the controller or the namespace.

Also, unlike awupf, nawupf is not a 0-based value (0 means "use awupf"
and not 1 logical block).

And finally, I think it's confusing that you use nawupf for the variable
name post modification. In terms of naming, I think you'd be better off
to do s/nawupf/phys_bs/ or atomic_bs. And then rename your existing
phys_bs variable to io_min to match the existing block layer usage.

So something like:

        /* Use reported namespace write atomicity */
	if (id->nsfeat & (1 << 1) && id->nawupf != 0)
           phys_bs = id->nawupf * bs;
        else /* Fall back to reported controller write atomicity */
           phys_bs = (1 + ns->ctrl->subsys->awupf) * bs;

[...]

-- 
Martin K. Petersen	Oracle Linux Engineering
