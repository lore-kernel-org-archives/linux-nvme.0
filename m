From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 15 Aug 2019 09:59:39 -0600
Subject: [PATCH v7 01/14] nvme-core: introduce nvme_ctrl_get_by_path()
In-Reply-To: <563baec2-61f6-5705-d751-1eee75370e66@mellanox.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-2-logang@deltatee.com>
 <563baec2-61f6-5705-d751-1eee75370e66@mellanox.com>
Message-ID: <3dc99450-bd6d-b994-4b4c-1af225565c2f@deltatee.com>



On 2019-08-15 5:46 a.m., Max Gurtovoy wrote:
> 
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
>> nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
>> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
>> It makes use of filp_open() to open the file and uses the private
>> data to obtain a pointer to the struct nvme_ctrl. If the fops of the
>> file do not match, -EINVAL is returned.
>>
>> The purpose of this function is to support NVMe-OF target passthru.
>>
>> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
>> ---
>> ? drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
>> ? drivers/nvme/host/nvme.h |? 2 ++
>> ? 2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index e6ee6f2a3da6..f72334f34a30 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2817,6 +2817,30 @@ static const struct file_operations
>> nvme_dev_fops = {
>> ????? .compat_ioctl??? = nvme_dev_ioctl,
>> ? };
>> ? +struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
>> +{
>> +??? struct nvme_ctrl *ctrl;
>> +??? struct file *f;
>> +
>> +??? f = filp_open(path, O_RDWR, 0);
>> +??? if (IS_ERR(f))
>> +??????? return ERR_CAST(f);
>> +
>> +??? if (f->f_op != &nvme_dev_fops) {
>> +??????? ctrl = ERR_PTR(-EINVAL);
>> +??????? goto out_close;
>> +??? }
> 
> Logan,
> 
> this means that the PT is for nvme-pci and also nvme-fabrics as well.
> 
> Is this the intention ? or we want to restrict it to pci only.

Yes, in theory, someone could passthru an nvme-fabrics controller or
they could passthru a passthru'd passthru'd nvme-fabrics controller.
This probably isn't a good idea but I don't know that we need to
specifically reject it. If you think we should I could figure out a way
to filter by pci controllers only.

Logan
