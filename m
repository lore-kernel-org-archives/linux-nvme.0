From: helen.koike@collabora.co.uk (Helen Koike)
Date: Wed, 4 May 2016 13:48:43 -0300
Subject: [PATCH v2 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <20160503080552.GA13239@infradead.org>
References: <1460657059-21214-1-git-send-email-helen.koike@collabora.co.uk>
 <5718D697.3050800@collabora.co.uk> <20160421133823.GA13563@infradead.org>
 <1461262295.4797.11.camel@ssi> <20160503080552.GA13239@infradead.org>
Message-ID: <572A27EB.5060202@collabora.co.uk>

Hi,

On 03-05-2016 05:05, Christoph Hellwig wrote:
> On Thu, Apr 21, 2016@11:11:35AM -0700, Ming Lin wrote:
>>>     agreement on it, although once the basic agreement is there it
>>>     shouldn't be too hard to also support the older google specific
>>>     version.  And this is no new feedback, a couple of people including
>>>     me said that a long time ago, and we've seen zero action on it.
>>
>> For "action", did you mean the "agreement" or the spec extension
>> proposal?
>>
>> I think you'll make the proposal, right?
>
> No, we really need Google to bring it in.

We (Collabora) have Google's support and are completing this work for them.

But before we submit this to the NVMe consortium, I would appreciate 
your comments on this proposal draft:

	https://people.collabora.co.uk/~koike/nvme-set-doorbel-mem.odt

I had formatted the document using ascii art for the tables and send it 
using git send-email but it seems that my message was held due to 
suspicious header, so I am just re-sending without that document 
content, sorry if you are receiving this email twice.

Anyway, it would be good to discuss the proposal in the document above.

Questions:

1) I predict the command Set Doorbell/EventIdx Memory in the proposal, 
should have an Unset command?

2) What should be filled in the function field in figure 40?

3) In the original patch, the command Set Doorbell/EventIdx Memory is 
assumed to be performed after all the queues are created, then what 
should happen if a queue is created after this command? We should abort 
the create queue command? Or we should first unset the doorbel/eventIdx 
memory then create the queues and then set it again? Or we just change 
the original proposal and if the controller has this functionality, it 
should support queues being created after the Set Doorbell/EventIdx 
Memory command?
Personally I think the controller should support creating queues after 
the Set Doorbell/EventIdx Memory command was performed, what do you think?


Helen
