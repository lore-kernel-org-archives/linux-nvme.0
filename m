From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 12 Feb 2018 10:17:53 +0800
Subject: [PATCH 4/9] nvme-pci: quiesce IO queues prior to disabling device
 HMB accesses
In-Reply-To: <bf278273-ec7c-e711-b82a-215d45dbe739@grimberg.me>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>
 <bf278273-ec7c-e711-b82a-215d45dbe739@grimberg.me>
Message-ID: <d523fe54-b16e-6dc1-6a01-9c301f603b5a@oracle.com>

Hi Sagi

Thanks for your kindly reminding.

On 02/11/2018 07:19 PM, Sagi Grimberg wrote:
> 
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 6fe7af0..00cffed 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -2186,7 +2186,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>> ????? if (!dead) {
>> ????????? if (shutdown)
>> ????????????? nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
>> +??? }
>> +??? nvme_stop_queues(&dev->ctrl);
> 
> Nit, extra newline before nvme_stop_queues would be nice.
> 

Yes, I will change this next version.

> Other than that, looks good,
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=http-3A__lists.infradead.org_mailman_listinfo_linux-2Dnvme&d=DwICAg&c=RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI_JnE&r=7WdAxUBeiTUTCy8v-7zXyr4qk7sx26ATvfo6QSTvZyQ&m=YyTE_X1Vl7LP-4IDkvFIPtRdBfnPAeiULK6MVj1Qfy4&s=0q3njAGASSRaQZEYLRXwJmUjYJRweNTVwoqR9mbHWTs&e=
> 
