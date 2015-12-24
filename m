From: hch@lst.de (Christoph Hellwig)
Date: Thu, 24 Dec 2015 12:08:31 +0100
Subject: [PATCH 1/3] nvme: synchronize access to ctrl->namespaces
In-Reply-To: <567BCA91.9090709@dev.mellanox.co.il>
References: <1450952155-8693-1-git-send-email-hch@lst.de>
 <1450952155-8693-2-git-send-email-hch@lst.de>
 <567BCA91.9090709@dev.mellanox.co.il>
Message-ID: <20151224110831.GA15268@lst.de>

On Thu, Dec 24, 2015@12:36:01PM +0200, Sagi Grimberg wrote:
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index b82bbea..e4a6868 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>
> Umm, I submitted a patch to move these to the core (which you reviewed
> :)). I've not seen any negative feedback on it so far.
>
> Jens, are you planning on taking it? and if you do,
> Christoph, would you mind rebasing a top of it?

I'm fine with rebasing.  Those were the last accesses to the namespace
list outside the core driver anyway.
