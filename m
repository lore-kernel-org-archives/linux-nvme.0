From: jsmart2021@gmail.com (James Smart)
Date: Wed, 20 Sep 2017 14:47:59 -0700
Subject: [PATCH] nvme_fc: add message on final controller removal
In-Reply-To: <20170920213214.GC10442@infradead.org>
References: <20170919210210.20201-1-jsmart2021@gmail.com>
 <20170920213214.GC10442@infradead.org>
Message-ID: <28899ddd-7fbb-89bb-97eb-9c54ae6d9cbb@gmail.com>

On 9/20/2017 2:32 PM, Christoph Hellwig wrote:
> On Tue, Sep 19, 2017@02:02:10PM -0700, James Smart wrote:
>> Given disparity between class level delete and transport delete,
>> add an info message when the transport controller object deletes.
> 
> Hmm.  Why do we need this in the FC code?
> 

It's a debug aid. I'm finding all the transitions spit out messages 
saying controller is deleting, which makes the admin think it's deleted. 
But what really happened was the delete calls were made to the core 
routines, but those routines are getting hung up in ns teardown. So 
admins are reporting things as "deleted" when they really aren't yet. 
This message just book-ends the initial deleting messages.

it could certainly go in the core nvme_free_ctrl() call before it calls 
the transport free routine.

-- james
