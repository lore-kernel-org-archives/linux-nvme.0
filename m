From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jul 2016 08:23:21 -0700
Subject: [PATCH v3] nvme/quirk: Add a delay before checking for adapter
 readiness
In-Reply-To: <5783A537.60105@linux.vnet.ibm.com>
References: <1465939361-16910-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160615102637.GA32253@infradead.org> <5783A537.60105@linux.vnet.ibm.com>
Message-ID: <57850B69.70108@fb.com>

On 07/11/2016 06:55 AM, Guilherme G. Piccoli wrote:
> On 06/15/2016 07:26 AM, Christoph Hellwig wrote:
>> Looks fine,
>>
>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>
> Thanks Christoph.
>
> Jens/Keith, sorry to bother.
> Wanna ask if there's a plan to merge this patch? If could be merged on
> 4.7 fixes would be amazing, but 4.8 merge window would be nice too.

I have added it for 4.8, thanks.

-- 
Jens Axboe
