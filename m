From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 14 Jun 2017 12:56:10 -0300
Subject: [PATCH v1] nvme: Using uevents to notify userspace on AERs.
In-Reply-To: <1496744428-3240-1-git-send-email-zouming.zouming@huawei.com>
References: <1496744428-3240-1-git-send-email-zouming.zouming@huawei.com>
Message-ID: <536875e3-d06c-9151-ecc5-80a8eaaacda7@linux.vnet.ibm.com>

Very nice Zou! We did try to improve async events notification in the
past, on driver. But sending notifications to userspace, like this
patch, was suggested and it's indeed a better option.

So, thanks for this. I have two question (second is on code):

a) Do you have (or are planning) some sort of userspace client to
process/"listen" these events?

b) Below, on code.

Cheers,


Guilherme



On 06/06/2017 07:20 AM, Zou Ming wrote:
> From: Zou <zouming.zouming at huawei.com>
> 
> Uevents is a common mechanism for notifying the user state of the kernel. The
> current patch implements the notification of asynchronous event information to
> the user via the uevents interface when asynchronous events are received in
> the kernel.
> 
> An example of the uevents generated as captured by udevadm monitor is shown below.
> UDEV  [187882.295881] change   /devices/virtual/nvme-fabrics/ctl/nvme0 (nvme)
> ACTION=change
> DEVNAME=/dev/nvme0
> DEVPATH=/devices/virtual/nvme-fabrics/ctl/nvme0
> MAJOR=242
> MINOR=0
> NVME_AEN_INFO=0
> NVME_AEN_LOGPAGE=0
> NVME_AEN_SEQNUM=1
> NVME_AEN_TYPE=AEN_ERROR_STATUS
> SEQNUM=3547
> SUBSYSTEM=nvme
> USEC_INITIALIZED=7882294991
> 
> Signed-off-by: Zou Ming <zouming.zouming at huawei.com>
> ---
>  drivers/nvme/host/Kconfig       |   6 ++
>  drivers/nvme/host/Makefile      |   3 +-
>  drivers/nvme/host/core.c        |  54 ++++++++++-
>  drivers/nvme/host/nvme-uevent.c | 202 ++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/nvme-uevent.h |  58 ++++++++++++
>  drivers/nvme/host/nvme.h        |  10 ++
>  6 files changed, 330 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/nvme/host/nvme-uevent.c
>  create mode 100644 drivers/nvme/host/nvme-uevent.h
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 90745a6..a772db7 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -25,6 +25,12 @@ config BLK_DEV_NVME_SCSI
>  	  emulation to provide stable device names for mount by id, like
>  	  some OpenSuSE and SLES versions.
> 
> +config NVME_UEVENT
> +	bool "nvme uevents"
> +	depends on NVME_CORE
> +	---help---
> +	Generate udev events for nvme asynchronous events.
> +
>  config NVME_FABRICS
>  	tristate
> 
> diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
> index f1a7d94..bfab9dc 100644
> --- a/drivers/nvme/host/Makefile
> +++ b/drivers/nvme/host/Makefile
> @@ -6,7 +6,8 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
> 
>  nvme-core-y				:= core.o
>  nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
> -nvme-core-$(CONFIG_NVM)			+= lightnvm.o
> +nvme-core-$(CONFIG_NVM)					+= lightnvm.o
> +nvme-core-$(CONFIG_NVME_UEVENT)			+= nvme-uevent.o
> 
>  nvme-y					+= pci.o
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a609264..e5b1827 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -32,6 +32,7 @@
> 
>  #include "nvme.h"
>  #include "fabrics.h"
> +#include "nvme-uevent.h"
> 
>  #define NVME_MINORS		(1U << MINORBITS)
> 
> @@ -70,6 +71,36 @@
> 
>  static struct class *nvme_class;
> 
> +uint32_t nvme_next_uevent_seq(struct nvme_ctrl *ctrl)
> +{
> +	return atomic_add_return(1, &ctrl->uevent_seq);
> +}
> +
> +void nvme_uevent_add(struct nvme_ctrl *ctrl, struct list_head *elist)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&ctrl->uevent_lock, flags);
> +	list_add(elist, &ctrl->uevent_list);
> +	spin_unlock_irqrestore(&ctrl->uevent_lock, flags);
> +}
> +
> +static DEFINE_MUTEX(_nvme_event_lock);
> +static void trigger_event(struct work_struct *work)
> +{
> +	unsigned long flags;
> +	LIST_HEAD(uevents);
> +	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, trigger_event_work);
> +
> +	mutex_lock(&_nvme_event_lock);
> +	spin_lock_irqsave(&ctrl->uevent_lock, flags);
> +	list_splice_init(&ctrl->uevent_list, &uevents);
> +	spin_unlock_irqrestore(&ctrl->uevent_lock, flags);
> +
> +	nvme_send_uevents(&uevents, &ctrl->device->kobj);
> +	mutex_unlock(&_nvme_event_lock);
> +}
> +
>  static int nvme_error_status(struct request *req)
>  {
>  	switch (nvme_req(req)->status & 0x7ff) {
> @@ -2292,13 +2323,19 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  	if (done)
>  		return;
> 
> -	switch (result & 0xff07) {
> +	switch (result & 0xffff07) {

My question is why you changed this? The old mask was wrong?

Thanks!
