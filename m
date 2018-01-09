From: keith.busch@intel.com (Keith Busch)
Date: Tue, 9 Jan 2018 09:42:52 -0700
Subject: [PATCH] nvme: initialize hostid uuid in nvmf_host_default to not
 leak kernel memory
In-Reply-To: <20180109152043.30422-1-jthumshirn@suse.de>
References: <20180109152043.30422-1-jthumshirn@suse.de>
Message-ID: <20180109164252.GD15154@localhost.localdomain>

On Tue, Jan 09, 2018@04:20:43PM +0100, Johannes Thumshirn wrote:
> Alexander reports:
>   according to KMSAN (and common sense as well) the following code in
>   drivers/nvme/host/fabrics.c
>   (http://elixir.free-electrons.com/linux/latest/source/drivers/nvme/host/fabrics.c#L68):
> 
>     72         host = kmalloc(sizeof(*host), GFP_KERNEL);
>     73         if (!host)
>     74                 return NULL;
>     75
>     76         kref_init(&host->ref);
>     77         snprintf(host->nqn, NVMF_NQN_SIZE,
>     78                 "nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
> 
>   uses uninitialized heap memory to generate the unique id for the NVMF host.
>   If I'm understanding correctly, it can be then passed to the
>   userspace, so the contents of the uninitialized chunk may potentially
>   leak.
>   If the specification doesn't rely on this UID to be random or unique,
>   I suggest using kzalloc() here, otherwise it might be a good idea to
>   use a real RNG.
> 
> this assumption is correct so initialize the host->id using uuid_gen() as
> it was done before commit 6bfe04255d5e ("nvme: add hostid token to fabric
> options").
> 
> Fixes: 6bfe04255d5e ("nvme: add hostid token to fabric options")
> Reported-by: Alexander Potapenko <glider at google.com>
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>

Thanks for the report and the fix. It'd still be good to use the kzalloc
variant in addition to this.

Reviewed-by: Keith Busch <keith.busch at intel.com>
