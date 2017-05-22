From: jsmart2021@gmail.com (James Smart)
Date: Mon, 22 May 2017 14:53:15 -0700
Subject: [PATCH v2 07/10] nvmet_fc: Add queue create and delete callbacks
 in LLDD api
In-Reply-To: <20170516124858.GH28689@infradead.org>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-8-jsmart2021@gmail.com>
 <20170516124858.GH28689@infradead.org>
Message-ID: <d9270db3-66ad-754e-5506-2fcaa8a28067@gmail.com>

On 5/16/2017 5:48 AM, Christoph Hellwig wrote:
> On Mon, May 15, 2017@05:10:21PM -0700, James Smart wrote:
>> To facilitate LLDD resource management on nvme queue creation and
>> deletion, add optional callbacks queue_create and queue_delete.
>
> Please send these together with driver changes to implement them,
> otherwise they are impossible to review.
>

Christoph,

The api was put in to support lpfc sizing async receive queues.  Idea 
was not to have the lldd snoop the LS payloads, thus the transport will 
call the lldd when the LS created or deleted a queue.

It turned out better for lpfc to dynamically grow its pools based on 
demand rather than queue sizing, so the api was moved away from. I 
continued to post it, thinking it may be useful for another lldd 
implementation, one that may actually create hw queues to map 1:1 to the 
queues.

Given there are no current consumers, I've removed it from the next posting.

-- james
