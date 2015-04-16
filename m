From: jim@thebergstens.com (James R. Bergsten)
Date: Thu, 16 Apr 2015 09:01:35 -0700
Subject: [PATCH 5/5 v2] nvme: LightNVM support
In-Reply-To: <alpine.LNX.2.00.1504161528010.32385@localhost.lm.intel.com>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-6-git-send-email-m@bjorling.me>
 <alpine.LNX.2.00.1504161433110.32385@localhost.lm.intel.com>
 <694D3575-E49B-45BB-8E48-7188169B75F0@paletta.io>
 <alpine.LNX.2.00.1504161528010.32385@localhost.lm.intel.com>
Message-ID: <057301d0785e$9f8e81c0$deab8540$@thebergstens.com>

My two cents worth is that it's (always) better to put ALL the commands into one place so that the entire set can be viewed at once and thus avoid inadvertent overloading of an opcode.  Otherwise you don't know what you don't know.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Thursday, April 16, 2015 8:52 AM
To: Javier Gonz?lez
Cc: hch at infradead.org; Matias Bj?rling; axboe at fb.com; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org; Keith Busch; linux-fsdevel at vger.kernel.org
Subject: Re: [PATCH 5/5 v2] nvme: LightNVM support

On Thu, 16 Apr 2015, Javier Gonz?lez wrote:
>> On 16 Apr 2015,@16:55, Keith Busch <keith.busch@intel.com> wrote:
>>
>> Otherwise it looks pretty good to me, but I think it would be cleaner 
>> if the lightnvm stuff is not mixed in the same file with the standard 
>> nvme command set. We might end up splitting nvme-core in the future 
>> anyway for command sets and transports.
>
> Would you be ok with having nvme-lightnvm for LightNVM specific 
> commands?

Sounds good to me, but I don't really have a dog in this fight. :)
