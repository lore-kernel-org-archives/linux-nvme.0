From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Oct 2015 19:24:19 +0000 (UTC)
Subject: [PATCH v2] NVMe:Expose model attribute in sysfs
In-Reply-To: <20151004223222.GA4280@localhost.localdomain>
References: <20151004223222.GA4280@localhost.localdomain>
Message-ID: <alpine.LNX.2.00.1510051924020.23840@localhost.lm.intel.com>

On Sun, 4 Oct 2015, Sujith Pandel wrote:
> Hi,
>>> nvme driver does not show the model attribute of disk in sysfs.
>>> nvme_dev already has this attribute populated during nvme_dev_add().
>>> Group model and other the device attributes as an attribute group
>>> and create sysfs files for the group using sysfs_create_group().
>>
>> Any updates on this? Can this be considered for inclusion?
>
> Any thoughts/feedback on this?

Looks good to me, thanks.

Reviewed-by: Keith Busch <keith.busch at intel.com>
