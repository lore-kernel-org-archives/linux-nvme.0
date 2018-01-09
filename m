From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue,  9 Jan 2018 16:20:43 +0100
Subject: [PATCH] nvme: initialize hostid uuid in nvmf_host_default to not leak
 kernel memory
Message-ID: <20180109152043.30422-1-jthumshirn@suse.de>

Alexander reports:
  according to KMSAN (and common sense as well) the following code in
  drivers/nvme/host/fabrics.c
  (http://elixir.free-electrons.com/linux/latest/source/drivers/nvme/host/fabrics.c#L68):

    72         host = kmalloc(sizeof(*host), GFP_KERNEL);
    73         if (!host)
    74                 return NULL;
    75
    76         kref_init(&host->ref);
    77         snprintf(host->nqn, NVMF_NQN_SIZE,
    78                 "nqn.2014-08.org.nvmexpress:uuid:%pUb", &host->id);

  uses uninitialized heap memory to generate the unique id for the NVMF host.
  If I'm understanding correctly, it can be then passed to the
  userspace, so the contents of the uninitialized chunk may potentially
  leak.
  If the specification doesn't rely on this UID to be random or unique,
  I suggest using kzalloc() here, otherwise it might be a good idea to
  use a real RNG.

this assumption is correct so initialize the host->id using uuid_gen() as
it was done before commit 6bfe04255d5e ("nvme: add hostid token to fabric
options").

Fixes: 6bfe04255d5e ("nvme: add hostid token to fabric options")
Reported-by: Alexander Potapenko <glider at google.com>
Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

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
2.13.6
