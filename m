From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Apr 2015 15:52:12 +0000 (UTC)
Subject: [PATCH 5/5 v2] nvme: LightNVM support
In-Reply-To: <694D3575-E49B-45BB-8E48-7188169B75F0@paletta.io>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-6-git-send-email-m@bjorling.me>
 <alpine.LNX.2.00.1504161433110.32385@localhost.lm.intel.com>
 <694D3575-E49B-45BB-8E48-7188169B75F0@paletta.io>
Message-ID: <alpine.LNX.2.00.1504161528010.32385@localhost.lm.intel.com>

On Thu, 16 Apr 2015, Javier Gonz?lez wrote:
>> On 16 Apr 2015,@16:55, Keith Busch <keith.busch@intel.com> wrote:
>>
>> Otherwise it looks pretty good to me, but I think it would be cleaner if
>> the lightnvm stuff is not mixed in the same file with the standard nvme
>> command set. We might end up splitting nvme-core in the future anyway
>> for command sets and transports.
>
> Would you be ok with having nvme-lightnvm for LightNVM specific
> commands?

Sounds good to me, but I don't really have a dog in this fight. :)
