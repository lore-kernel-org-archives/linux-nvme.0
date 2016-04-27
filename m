From: helen.koike@collabora.co.uk (Helen Koike)
Date: Wed, 27 Apr 2016 12:26:52 -0300
Subject: [PATCH v2 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <1461262295.4797.11.camel@ssi>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <5718D697.3050800@collabora.co.uk> <20160421133823.GA13563@infradead.org>
 <1461262295.4797.11.camel@ssi>
Message-ID: <5720DA3C.4050109@collabora.co.uk>

Hi Christoph,

On 21/04/2016 15:11, Ming Lin wrote:
> On Thu, 2016-04-21@06:38 -0700, Christoph Hellwig wrote:
>> I've not spent much time at it due to a busy conference week, but there
>> are two main comments on why I don't think this is suitable as is
>> despite really liking the general idea.
>>
>>   - I'd really like this to be proposed as an official extension to the
>>     NVMe technical workgroup.  I'm also happy to help with making that
>>     happen.  I really don't like to merge it until we have some basic
> That'd be great help. Thanks.
>
>>     agreement on it, although once the basic agreement is there it
>>     shouldn't be too hard to also support the older google specific
>>     version.  And this is no new feedback, a couple of people including
>>     me said that a long time ago, and we've seen zero action on it.

I would appreciate if we could work together to make this proposal happen.
I prepared a small draft to propose this feature, could you take a look 
and comment please? 
https://people.collabora.co.uk/~koike/nvme-set-doorbel-mem.odt

> For "action", did you mean the "agreement" or the spec extension
> proposal?
>
> I think you'll make the proposal, right?
>
>>   - the code is a mess in this version.  I really don't see the need for
>>     all the ifdefs, but if you really want to keep them they should move
>>     out of the main code path and just stub out helpers that would
>>     otherwise do work.

I'll rework on that as soon as we have an agreement about the format of 
the proposed command.

> I made the mess :)
>
> I thought this before.
> Probably add a new file ext.c and move these code into it.
>
> Then add a nvme_ext_ops ...
>

Helen
