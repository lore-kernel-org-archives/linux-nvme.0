From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Fri, 19 Jan 2018 14:53:37 +0800
Subject: [PATCH V5 2/2] nvme-pci: fixup the timeout case when reset is
 ongoing
In-Reply-To: <20180119060521.GD12043@localhost.localdomain>
References: <1516270202-8051-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516270202-8051-3-git-send-email-jianchao.w.wang@oracle.com>
 <20180119045944.GC12043@localhost.localdomain>
 <0b74b36d-ecb5-e9e2-2900-6dc9c9699658@oracle.com>
 <20180119060521.GD12043@localhost.localdomain>
Message-ID: <23b3ea15-aed0-3b2f-e02f-124fe6fdf618@oracle.com>

Hi Keith

Thanks for your kindly reminding.

On 01/19/2018 02:05 PM, Keith Busch wrote:
>>> The driver may be giving up on the command here, but that doesn't mean
>>> the controller has. We can't just end the request like this because that
>>> will release the memory the controller still owns. We must wait until
>>> after nvme_dev_disable clears bus master because we can't say for sure
>>> the controller isn't going to write to that address right after we end
>>> the request.
>>>
>> Yes, but the controller is going to be reseted or shutdown at the moment,
>> even if the controller accesses a bad address and goes wrong, everything will
>> be ok after reset or shutdown. :)
> Hm, I don't follow. DMA access after free is never okay.
Yes, this may cause unexpected memory corruption.

Thanks
Jianchao
