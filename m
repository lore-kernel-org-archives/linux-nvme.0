From: hare@suse.de (Hannes Reinecke)
Date: Fri, 16 Nov 2018 11:06:32 +0100
Subject: [PATCH] nvme: allow ANA support to be independent of native
 multipathing
In-Reply-To: <20181116094947.GA19296@lst.de>
References: <20181112215323.GA7983@redhat.com>
 <20181113161838.GC9827@localhost.localdomain>
 <20181113180008.GA12513@redhat.com> <20181114053837.GA15086@redhat.com>
 <30cf7af7-8826-55bd-e39a-4f81ed032f6d@suse.de>
 <20181114174746.GA18526@redhat.com>
 <87c931e5-4ac9-1795-8d40-cc5541d3ebcf@suse.de>
 <20181115174605.GA19782@redhat.com> <20181116091458.GA17267@lst.de>
 <37098edd-4dea-b58f-bca6-3be9af8ec4ee@suse.de>
 <20181116094947.GA19296@lst.de>
Message-ID: <bbaf4637-209c-5cfe-2749-3fcc54f7a35f@suse.de>

On 11/16/18 10:49 AM, Christoph Hellwig wrote:
> On Fri, Nov 16, 2018@10:40:40AM +0100, Hannes Reinecke wrote:
>>>> Introduce ability to always re-read ANA log page as required due to ANA
>>>> error and make current ANA state available via sysfs -- even if native
>>>> multipathing is disabled on the host (e.g. nvme_core.multipath=N).
>>>
>>> The first part I could see, but I still want to make it conditional
>>> in some way as nvme is going into deeply embedded setups, and I don't
>>> want to carry the weight of the ANA code around for everyone.
>>>
>> Can you clarify this a bit?
>> We _do_ have the NVME multipath config option to deconfigure the whole
>> thing during compile time; that isn't influenced with this patch.
>> So are you worried about the size of the ANA implementation itself?
>> Or are you worried about the size of the ANA structures?
> 
> I just see the next step of wanting to move ANA code into the core
> which is implied above.

Really, I couldn't care less _where_ the ANA code lives.
If the size of which is any concern we can even make it configurable of 
sorts.

>>
>>> The second I fundamentally disagree with.  And even if you found agreement
>>> it would have to be in a separate patch as it is a separate feature.
>>>
>> Why? Where's the problem with re-reading the ANA log pages if we get an
>> event indicating that we should?
> 
> "second" here means the sysfs file.
> 
Ok, so would you be happy with making ANA support configurable?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
