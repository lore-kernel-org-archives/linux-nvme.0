From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 30 Oct 2018 20:36:09 +0000
Subject: [PATCH v2 1/1] nvmet: debug namespace noiob boundary emulation
In-Reply-To: <20181030175729.25011-1-sagi@grimberg.me>
References: <20181030175729.25011-1-sagi@grimberg.me>
Message-ID: <3BBB5129-4CB4-4E21-9636-5CBFAFADD498@wdc.com>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>.

?On 10/30/18, 10:57 AM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    Useful to exercise the host driver to noiob support without
    having device that actually require it. name it with a debug
    prefix such that it is clear that its a debug feature.
    
    Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
    ---
     drivers/nvme/target/admin-cmd.c |  2 ++
     drivers/nvme/target/configfs.c  | 30 ++++++++++++++++++++++++++++++
     drivers/nvme/target/nvmet.h     |  1 +
     3 files changed, 33 insertions(+)
    
    diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
    index 3554cb4c6387..7e187815e0ea 100644
    --- a/drivers/nvme/target/admin-cmd.c
    +++ b/drivers/nvme/target/admin-cmd.c
    @@ -427,6 +427,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
     
     	id->lbaf[0].ds = ns->blksize_shift;
     
    +	id->noiob = cpu_to_le16(ns->noiob);
    +
     	if (ns->readonly)
     		id->nsattr |= (1 << 0);
     	nvmet_put_namespace(ns);
    diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
    index 46d0a0bc630b..c85f6977548a 100644
    --- a/drivers/nvme/target/configfs.c
    +++ b/drivers/nvme/target/configfs.c
    @@ -555,6 +555,35 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
     
     CONFIGFS_ATTR(nvmet_ns_, buffered_io);
     
    +static ssize_t nvmet_ns_debug_chunk_sectors_show(struct config_item *item,
    +		char *page)
    +{
    +	return sprintf(page, "%u\n", to_nvmet_ns(item)->noiob);
    +}
    +
    +static ssize_t nvmet_ns_debug_chunk_sectors_store(struct config_item *item,
    +		const char *page, size_t count)
    +{
    +	struct nvmet_ns *ns = to_nvmet_ns(item);
    +	u16 noiob;
    +
    +	if (kstrtou16(page, 0, &noiob))
    +		return -EINVAL;
    +
    +	mutex_lock(&ns->subsys->lock);
    +	if (ns->enabled) {
    +		pr_err("disable ns before setting chunk_sectors\n");
    +		mutex_unlock(&ns->subsys->lock);
    +		return -EINVAL;
    +	}
    +
    +	ns->noiob = noiob;
    +	mutex_unlock(&ns->subsys->lock);
    +	return count;
    +}
    +
    +CONFIGFS_ATTR(nvmet_ns_, debug_chunk_sectors);
    +
     static struct configfs_attribute *nvmet_ns_attrs[] = {
     	&nvmet_ns_attr_device_path,
     	&nvmet_ns_attr_device_nguid,
    @@ -562,6 +591,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
     	&nvmet_ns_attr_ana_grpid,
     	&nvmet_ns_attr_enable,
     	&nvmet_ns_attr_buffered_io,
    +	&nvmet_ns_attr_debug_chunk_sectors,
     	NULL,
     };
     
    diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
    index 10c96d43868d..cb8b93c83c5b 100644
    --- a/drivers/nvme/target/nvmet.h
    +++ b/drivers/nvme/target/nvmet.h
    @@ -67,6 +67,7 @@ struct nvmet_ns {
     	u8			nguid[16];
     	uuid_t			uuid;
     	u32			anagrpid;
    +	u16			noiob;
     
     	bool			buffered_io;
     	bool			enabled;
    -- 
    2.17.1
    
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
