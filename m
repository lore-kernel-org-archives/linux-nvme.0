From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 20 Jun 2018 09:00:53 -0500
Subject: [PATCH v5 2/2] nvmet-rdma: support max(16KB, PAGE_SIZE) inline
 data
In-Reply-To: <4257d109-38f3-7f21-2e84-ae327d76959a@mellanox.com>
References: <cover.1529435395.git.swise@opengridcomputing.com>
 <c68cc2e51bad4f5f3a708dbfae40b876c9f8f999.1529435395.git.swise@opengridcomputing.com>
 <4257d109-38f3-7f21-2e84-ae327d76959a@mellanox.com>
Message-ID: <9b514008-45ff-4529-deb1-34053f2773e6@opengridcomputing.com>



On 6/19/2018 5:28 PM, Max Gurtovoy wrote:
>
>
> On 6/18/2018 9:22 PM, Steve Wise wrote:
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
>> index 3880357..941a574 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -238,14 +238,14 @@ static void nvmet_execute_identify_ctrl(struct
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
>> index d3f3b3e..2e556f6 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -218,6 +218,35 @@ static ssize_t nvmet_addr_trsvcid_store(struct
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
>
> minor fix for the error print:
> "Cannot modify inline_data_size while enabled" or "Cannot modify
> inline_data_size while port enabled"
>

Thanks, I left out the "while".? But I'll use your second suggestion as
it is more clear.


Steve.
