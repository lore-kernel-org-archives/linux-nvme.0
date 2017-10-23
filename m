From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Oct 2017 16:31:42 +0200
Subject: [PATCH 1/5] nvme-core: Make nvme_init/uninit_ctrl
 setup/teardown symmetric
In-Reply-To: <d1e113b8-1f76-1084-b075-a32d484287d8@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
 <1508324864-23087-2-git-send-email-sagi@grimberg.me>
 <20171019152910.GA24808@lst.de>
 <0a081ffc-5a3d-6b52-7257-18e39034ce93@grimberg.me>
 <d1e113b8-1f76-1084-b075-a32d484287d8@grimberg.me>
Message-ID: <20171023143142.GA25448@lst.de>

On Sun, Oct 22, 2017@02:11:47PM +0300, Sagi Grimberg wrote:
>>> This totally conflicts with my refcount / device rework in the
>>> mpath patchset..
>>
>> I know...
>>
>> Do you want me to rebase on top of your next round of patches?
>
> ping?

Sure.  It might also make sense to queue up the device / refcount
updates from th mpath series to nvme-4.15 ASAP so you only have
to base on top of those.
