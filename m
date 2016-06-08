From: sunad.s@samsung.com (Sunad Bhandary)
Date: Wed, 08 Jun 2016 10:43:14 +0530
Subject: [PATCHv2] NVMe: Fix removal in case of active namespace list
 scanning method
In-Reply-To: <20160531143507.GA24107@localhost.localdomain>
References: <20160531143507.GA24107@localhost.localdomain>
Message-ID: <5757A96A.3020207@samsung.com>

Hi Jens,

Can this be picked up?

Thanks and Regards,
Sunad

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Keith Busch
> Sent: Tuesday, May 31, 2016 8:05 PM
> To: Sunad Bhandary
> Cc: hch at infradead.org; linux-nvme at lists.infradead.org
> Subject: Re: Re: [PATCHv2] NVMe: Fix removal in case of active namespace list scanning method
>
> On Mon, May 30, 2016@04:15:41PM +0530, Sunad Bhandary wrote:
>> In the patch, the namespaces are not removed on failure of identify
>> list. If nvme_identify_ns_list fails, the value is returned and
>> sequential scanning is done. The call to
>> nvme_remove_invalid_namespaces is done when the value of nsid in the list is 0.
>
> Sorry, my mistake. You're right, it is good as-is.
