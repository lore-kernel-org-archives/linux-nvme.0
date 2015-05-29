From: axboe@fb.com (Jens Axboe)
Date: Fri, 29 May 2015 10:06:41 -0600
Subject: [PATCH] NVMe: fix type warning on 32-bit
In-Reply-To: <alpine.LNX.2.00.1505282235140.15930@localhost.lm.intel.com>
References: <2271255.ypbMPZa6tA@wuerfel>
 <alpine.LNX.2.00.1505282235140.15930@localhost.lm.intel.com>
Message-ID: <55688E91.10408@fb.com>

On 05/28/2015 04:35 PM, Keith Busch wrote:
> On Tue, 19 May 2015, Arnd Bergmann wrote:
>> A recent change to the ioctl handling caused a new harmless
>> warning in the NVMe driver on all 32-bit machines:
>>
>> drivers/block/nvme-core.c: In function 'nvme_submit_io':
>> drivers/block/nvme-core.c:1794:29: warning: cast to pointer from
>> integer of different size [-Wint-to-pointer-cast]
>>
>> In order to shup up that warning, this introduces a new
>> temporary variable that uses a double cast to extract
>> the pointer from an __u64 structure member.
>
>
> Thanks for the fix.
>
> Acked-by: Keith Busch <keith.busch at intel.com>

Picked up for this series.

-- 
Jens Axboe
