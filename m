From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 30 Oct 2018 20:27:28 +0000
Subject: [PATCH v2 3/4] nvme-core: cache controller attributes
In-Reply-To: <20181030174344.20171-4-sagi@grimberg.me>
References: <20181030174344.20171-1-sagi@grimberg.me>
 <20181030174344.20171-4-sagi@grimberg.me>
Message-ID: <FFDE5CAD-F13D-4C46-85DA-7347A96C528B@wdc.com>

Can we have a commit log line length till 72 ? can be done at the time of applying patch.

Looks good.
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

?On 10/30/18, 10:43 AM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    We get the controller attributes in identify, cache
    them as we'll need them for traffic based keep alive
    support.
    
    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
    ---
     drivers/nvme/host/core.c | 1 +
     drivers/nvme/host/nvme.h | 1 +
     2 files changed, 2 insertions(+)
    
    diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
    index 65c42448e904..ef609239c9c5 100644
    --- a/drivers/nvme/host/core.c
    +++ b/drivers/nvme/host/core.c
    @@ -2409,6 +2409,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
     	ctrl->sgls = le32_to_cpu(id->sgls);
     	ctrl->kas = le16_to_cpu(id->kas);
     	ctrl->max_namespaces = le32_to_cpu(id->mnan);
    +	ctrl->ctratt = le32_to_cpu(id->ctratt);
     
     	if (id->rtd3e) {
     		/* us -> s */
    diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
    index 9fefba039d1e..4dd7535caf1b 100644
    --- a/drivers/nvme/host/nvme.h
    +++ b/drivers/nvme/host/nvme.h
    @@ -193,6 +193,7 @@ struct nvme_ctrl {
     	u8 apsta;
     	u32 oaes;
     	u32 aen_result;
    +	u32 ctratt;
     	unsigned int shutdown_timeout;
     	unsigned int kato;
     	bool subsystem;
    -- 
    2.17.1
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
