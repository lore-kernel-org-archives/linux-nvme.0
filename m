From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 11:12:12 +0300
Subject: 'modprobe nvme_core multipath=N' crashes in face of multipath
 fabric
In-Reply-To: <20180411214611.GA24088@redhat.com>
References: <20180410204953.GA17979@redhat.com>
 <20180411134530.GC9238@localhost.localdomain>
 <20180411141720.GB22124@redhat.com>
 <20180411175824.GE9238@localhost.localdomain>
 <20180411214611.GA24088@redhat.com>
Message-ID: <4b142a06-ff6a-0e68-2043-0ed2886b8d50@grimberg.me>



On 04/12/2018 12:46 AM, Mike Snitzer wrote:
> On Wed, Apr 11 2018 at  1:58pm -0400,
> Keith Busch <keith.busch@intel.com> wrote:
> 
>> On Wed, Apr 11, 2018@10:17:21AM -0400, Mike Snitzer wrote:
>>> On Wed, Apr 11 2018 at  9:45am -0400,
>>> Keith Busch <keith.busch@intel.com> wrote:
>>>
>>>> On Tue, Apr 10, 2018@04:49:53PM -0400, Mike Snitzer wrote:
>>>>> This isn't new since the 4.17 merge or anything, I first noticed this
>>>>> issue existed while using a 4.16-rc4 kernel.
>>>>>
>>>>> modprobe nvme_core multipath=N
>>>>
>>>> Thanks for the notice.
>>>>
>>>> There is definitely a bug here when CONFIG_NVME_MULTIPATH=y but nvme_core
>>>> multipath is disabled in the presence of shared namespaces. I think we'd
>>>> need each namespace to get a different "head" out of the subsystem in
>>>> this case, but it may take a moment for me to detangle this.
>>>
>>> No problem, it certainly isn't something I could tackle any quicker ;)
>>>
>>> Thanks for looking to resolve this though.
>>
>> It doesn't look like we'll be able to allocate new namespace 'heads'
>> here without complicating this even more.
>>
>> The below should fix the naming collision by getting new instances for
>> each namespace that attaches to a head. I'm not sure this is much better,
>> but maybe Christoph will have a better suggestion.
> 
> This patch fixed the issue for me.  Verified that modprobe nvme_core
> multipath=N and multipath=Y works with the mptest case I shared in my
> original report.
> 
> If you do go with this patch, please feel free to add:
> 
> Tested-by: Mike Snitzer <snitzer at redhat.com>

This looks good to me too, you can add my

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
