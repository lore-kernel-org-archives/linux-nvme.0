From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 9 Jan 2018 15:37:37 +0100
Subject: Uninitialized memory used to generate nqn in nvmf_host_default()
In-Reply-To: <CAG_fn=XLt4z3-UWYxg3YWb-ZcXGqJOfMXj-JaRR5gT0mJqV0OQ@mail.gmail.com>
References: <CAG_fn=XLt4z3-UWYxg3YWb-ZcXGqJOfMXj-JaRR5gT0mJqV0OQ@mail.gmail.com>
Message-ID: <20180109143737.gcijn76ldiekzklk@linux-x5ow.site>

On Tue, Jan 09, 2018@03:07:44PM +0100, Alexander Potapenko wrote:
> Hi Christoph, Keith,
> 
> according to KMSAN (and common sense as well) the following code in
> drivers/nvme/host/fabrics.c
> (http://elixir.free-electrons.com/linux/latest/source/drivers/nvme/host/fabrics.c#L68):
> 
>   72         host = kmalloc(sizeof(*host), GFP_KERNEL);
>   73         if (!host)
>   74                 return NULL;
>   75
>   76         kref_init(&host->ref);
>   77         snprintf(host->nqn, NVMF_NQN_SIZE,
>   78                 "nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
> 
> uses uninitialized heap memory to generate the unique id for the NVMF host.
> If I'm understanding correctly, it can be then passed to the
> userspace, so the contents of the uninitialized chunk may potentially
> leak.
> If the specification doesn't rely on this UID to be random or unique,
> I suggest using kzalloc() here, otherwise it might be a good idea to
> use a real RNG.
> 
> Is my reasoning correct?

Actually it should be something like this (untested):

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 76b4fe6816a0..894c2ccb3891 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -74,6 +74,7 @@ static struct nvmf_host *nvmf_host_default(void)
 		return NULL;
 
 	kref_init(&host->ref);
+	uuid_gen(&host->id);
 	snprintf(host->nqn, NVMF_NQN_SIZE,
 		"nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);
 


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
