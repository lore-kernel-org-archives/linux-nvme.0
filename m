From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 6 Sep 2018 09:35:09 +0800
Subject: [PATCH 0/3] Introduce a light-weight queue close feature
In-Reply-To: <1536162485.11534.3.camel@acm.org>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <1536162485.11534.3.camel@acm.org>
Message-ID: <ebeffce9-4136-1b4d-1253-b5c045eff3f7@oracle.com>

Hi Bart

On 09/05/2018 11:48 PM, Bart Van Assche wrote:
>> The 3rd patch apply the queue close in nvme-pci to avoid the IO hang
>> issue above.
> Hello Jianchao,
> 
> Is this patch series based on a theoretical concern or rather on something
> you ran into? In the latter case, can you explain which scenario makes it
> likely on your setup to encounter an NVMe timeout?

It is a theoretical concern. But I think it is very obvious.
It could be very easy to reproduce if simulate IO timeout in software.

Thanks
Jianchao
