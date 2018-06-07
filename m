From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 7 Jun 2018 14:53:06 -0500
Subject: [PATCH v4 3/3] nvmet-rdma: support max(16KB, PAGE_SIZE) inline
 data
In-Reply-To: <b6cf134e-eec7-d375-d040-37f9dde11535@grimberg.me>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <051c25edb1b0c0aa84b8195a95bdd3eb30d710f5.1528219321.git.swise@opengridcomputing.com>
 <b6cf134e-eec7-d375-d040-37f9dde11535@grimberg.me>
Message-ID: <33d0dd62-3dea-3b3b-6959-9c4b86a7252e@opengridcomputing.com>



On 6/6/2018 4:24 AM, Sagi Grimberg wrote:
>
>
> On 06/05/2018 08:16 PM, Steve Wise wrote:
>> The patch enables inline data sizes using up to 4 recv sges, and capping
>> the size at 16KB or at least 1 page size.? So on a 4K page system, up to
>> 16KB is supported, and for a 64K page system 1 page of 64KB is
>> supported.
>>
>> We avoid > 0 order page allocations for the inline buffers by using
>> multiple recv sges, one for each page.? If the device cannot support
>> the configured inline data size due to lack of enough recv sges, then
>> log a warning and reduce the inline size.
>>
>> Add a new configfs port attribute, called param_inline_data_size,
>> to allow configuring the size of inline data for a given nvmf port.
>> The maximum size allowed is still enforced by nvmet-rdma with
>> NVMET_RDMA_MAX_INLINE_DATA_SIZE, which is now max(16KB, PAGE_SIZE).
>> And the default size, if not specified via configfs, is still PAGE_SIZE.
>> This preserves the existing behavior, but allows larger inline sizes
>> for small page systems.? If the configured inline data size exceeds
>> NVMET_RDMA_MAX_INLINE_DATA_SIZE, a warning is logged and the size is
>> reduced.? If param_inline_data_size is set to 0, then inline data is
>> disabled for that nvmf port.
>>
>> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
>> ---
>> ? drivers/nvme/target/admin-cmd.c |?? 4 +-
>> ? drivers/nvme/target/configfs.c? |? 31 +++++++
>> ? drivers/nvme/target/core.c????? |?? 4 +
>> ? drivers/nvme/target/discovery.c |?? 2 +-
>> ? drivers/nvme/target/nvmet.h???? |?? 2 +-
>> ? drivers/nvme/target/rdma.c????? | 174
>> ++++++++++++++++++++++++++++++----------
>> ? 6 files changed, 172 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c
>> b/drivers/nvme/target/admin-cmd.c
>> index 5e0e9fc..a9e3223 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -247,14 +247,14 @@ static void nvmet_execute_identify_ctrl(struct
>> nvmet_req *req)
>> ????? id->sgls = cpu_to_le32(1 << 0);??? /* we always support SGLs */
>> ????? if (ctrl->ops->has_keyed_sgls)
>> ????????? id->sgls |= cpu_to_le32(1 << 2);
>> -??? if (ctrl->ops->sqe_inline_size)
>> +??? if (req->port->inline_data_size)
>> ????????? id->sgls |= cpu_to_le32(1 << 20);
>> ? ????? strcpy(id->subnqn, ctrl->subsys->subsysnqn);
>> ? ????? /* Max command capsule size is sqe + single page of
>> in-capsule data */
>> ????? id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
>> -????????????????? ctrl->ops->sqe_inline_size) / 16);
>> +????????????????? req->port->inline_data_size) / 16);
>> ????? /* Max response capsule size is cqe */
>> ????? id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
>> ? diff --git a/drivers/nvme/target/configfs.c
>> b/drivers/nvme/target/configfs.c
>> index ad9ff27..9867783 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -214,6 +214,35 @@ static ssize_t nvmet_addr_trsvcid_store(struct
>> config_item *item,
>> ? ? CONFIGFS_ATTR(nvmet_, addr_trsvcid);
>> ? +static ssize_t nvmet_param_inline_data_size_show(struct
>> config_item *item,
>> +??????? char *page)
>> +{
>> +??? struct nvmet_port *port = to_nvmet_port(item);
>> +
>> +??? return snprintf(page, PAGE_SIZE, "%d\n", port->inline_data_size);
>> +}
>> +
>> +static ssize_t nvmet_param_inline_data_size_store(struct config_item
>> *item,
>> +??????? const char *page, size_t count)
>> +{
>> +??? struct nvmet_port *port = to_nvmet_port(item);
>> +??? int ret;
>> +
>> +??? if (port->enabled) {
>> +??????? pr_err("Cannot modify inline_data_size enabled\n");
>> +??????? pr_err("Disable the port before modifying\n");
>> +??????? return -EACCES;
>> +??? }
>> +??? ret = kstrtoint(page, 0, &port->inline_data_size);
>> +??? if (ret) {
>> +??????? pr_err("Invalid value '%s' for inline_data_size\n", page);
>> +??????? return -EINVAL;
>> +??? }
>> +??? return count;
>> +}
>> +
>> +CONFIGFS_ATTR(nvmet_, param_inline_data_size);
>> +
>> ? static ssize_t nvmet_addr_trtype_show(struct config_item *item,
>> ????????? char *page)
>> ? {
>> @@ -870,6 +899,7 @@ static void nvmet_port_release(struct config_item
>> *item)
>> ????? &nvmet_attr_addr_traddr,
>> ????? &nvmet_attr_addr_trsvcid,
>> ????? &nvmet_attr_addr_trtype,
>> +??? &nvmet_attr_param_inline_data_size,
>> ????? NULL,
>> ? };
>> ? @@ -899,6 +929,7 @@ static struct config_group
>> *nvmet_ports_make(struct config_group *group,
>> ????? INIT_LIST_HEAD(&port->entry);
>> ????? INIT_LIST_HEAD(&port->subsystems);
>> ????? INIT_LIST_HEAD(&port->referrals);
>> +??? port->inline_data_size = -1;??? /* < 0 == let the transport
>> choose */
>
> Why not init to 0?
>

-1 means "transport chooses the size"
0 means "no inline data"



>> ? ????? port->disc_addr.portid = cpu_to_le16(portid);
>> ????? config_group_init_type_name(&port->group, name, &nvmet_port_type);
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index e95424f..695ec17 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -189,6 +189,10 @@ int nvmet_enable_port(struct nvmet_port *port)
>> ????????? return ret;
>> ????? }
>> ? +??? /* If the transport didn't set inline_data_size, then disable
>> it. */
>> +??? if (port->inline_data_size < 0)
>> +??????? port->inline_data_size = 0;
>> +
>> ????? port->enabled = true;
>> ????? return 0;
>> ? }
>> diff --git a/drivers/nvme/target/discovery.c
>> b/drivers/nvme/target/discovery.c
>> index 231e04e..fc2e675 100644
>> --- a/drivers/nvme/target/discovery.c
>> +++ b/drivers/nvme/target/discovery.c
>> @@ -171,7 +171,7 @@ static void
>> nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
>> ????? id->sgls = cpu_to_le32(1 << 0);??? /* we always support SGLs */
>> ????? if (ctrl->ops->has_keyed_sgls)
>> ????????? id->sgls |= cpu_to_le32(1 << 2);
>> -??? if (ctrl->ops->sqe_inline_size)
>> +??? if (req->port->inline_data_size)
>> ????????? id->sgls |= cpu_to_le32(1 << 20);
>> ? ????? strcpy(id->subnqn, ctrl->subsys->subsysnqn);
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 15fd84a..db29e45 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -98,6 +98,7 @@ struct nvmet_port {
>> ????? struct list_head??????? referrals;
>> ????? void??????????????? *priv;
>> ????? bool??????????????? enabled;
>> +??? int??????????????? inline_data_size;
>> ? };
>> ? ? static inline struct nvmet_port *to_nvmet_port(struct config_item
>> *item)
>> @@ -202,7 +203,6 @@ struct nvmet_subsys_link {
>> ? struct nvmet_fabrics_ops {
>> ????? struct module *owner;
>> ????? unsigned int type;
>> -??? unsigned int sqe_inline_size;
>> ????? unsigned int msdbd;
>> ????? bool has_keyed_sgls : 1;
>> ????? void (*queue_response)(struct nvmet_req *req);
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 52e0c5d..eb5f1b0 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -33,16 +33,17 @@
>> ? #include "nvmet.h"
>> ? ? /*
>> - * We allow up to a page of inline data to go with the SQE
>> + * We allow at least 1 page, up to 4 SGEs, and up to 16KB of inline
>> data
>> ?? */
>> -#define NVMET_RDMA_INLINE_DATA_SIZE??? PAGE_SIZE
>> +#define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE??? PAGE_SIZE
>> +#define NVMET_RDMA_MAX_INLINE_SGE??????? 4
>> +#define NVMET_RDMA_MAX_INLINE_DATA_SIZE??????? max_t(int, SZ_16K,
>> PAGE_SIZE)
>> ? ? struct nvmet_rdma_cmd {
>> -??? struct ib_sge??????? sge[2];
>> +??? struct ib_sge??????? sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
>> ????? struct ib_cqe??????? cqe;
>> ????? struct ib_recv_wr??? wr;
>> -??? struct scatterlist??? inline_sg;
>> -??? struct page??????? *inline_page;
>> +??? struct scatterlist??? inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
>> ????? struct nvme_command???? *nvme_cmd;
>> ????? struct nvmet_rdma_queue??? *queue;
>> ? };
>> @@ -116,6 +117,8 @@ struct nvmet_rdma_device {
>> ????? size_t??????????? srq_size;
>> ????? struct kref??????? ref;
>> ????? struct list_head??? entry;
>> +??? int??????????? inline_data_size;
>> +??? int??????????? inline_page_count;
>> ? };
>> ? ? static bool nvmet_rdma_use_srq;
>> @@ -138,6 +141,11 @@ struct nvmet_rdma_device {
>> ? ? static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>> ? +static int num_pages(int len)
>> +{
>> +??? return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
>> +}
>
> get_order()?
>

We don't want the order, like 1, 2, 4, 8.? We want, for example, 12KB to

be 3 pages, not 4.

Steve.
