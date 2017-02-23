From: jsmart2021@gmail.com (James Smart)
Date: Thu, 23 Feb 2017 07:51:35 -0800
Subject: [PATCH] lpfc: add missing Kconfig NVME dependencies
In-Reply-To: <20170223100938.GA20495@infradead.org>
References: <58adba5f.BoP49Cv2S5zD9ZuD%jsmart2021@gmail.com>
 <20170223100938.GA20495@infradead.org>
Message-ID: <523a2eb4-7d02-9ec8-8e81-9d1112cdc98e@gmail.com>

On 2/23/2017 2:09 AM, Christoph Hellwig wrote:
> On Wed, Feb 22, 2017@08:20:47AM -0800, James Smart wrote:
>> add missing Kconfig NVME dependencies
>>
>> Can't believe I missed posting this
> Oh.  I'm not sure everyone is happy having to drag in the whole
> nvme and nvme target stack when building lpfc.  Is there a way
> to make nvme optional?  And in the future scsi as well?

yes - I'll work on doing that.  Scsi is a little further off as the fc 
transport has to be dealt with - moved out from under scsi and put above 
scsi and nvme in the device tree.  The transport is where the hooks for 
adapter mgmt are right now.

-- james
