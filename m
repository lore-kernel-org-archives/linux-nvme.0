From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Oct 2018 17:40:35 -0700
Subject: [PATCH RFC] nvmet-rdma: use a private workqueue for delete
In-Reply-To: <972d73ea2043fe755e9a5d9be649bb15a88378e7.camel@sipsolutions.net>
References: <20180927180031.10706-1-sagi@grimberg.me>
 <CAO+b5-oBVw=-wvnWk1EF=RBaZtjX6bjUG+3WABXbvzX9UTu26w@mail.gmail.com>
 <9716592b-6175-600d-c1a1-593cd3145b39@grimberg.me>
 <1539966212.81977.53.camel@acm.org>
 <972d73ea2043fe755e9a5d9be649bb15a88378e7.camel@sipsolutions.net>
Message-ID: <0d62caa5-28ec-593b-7537-c27c8260366a@grimberg.me>


>>> There is something I'm missing here, the id_priv->handler_mutex that the
>>> connect context is running on is guaranteed to be different than the
>>> one being removed (a different cm_id) and also the workqueues are
>>> different.
>>>
>>> Is it not allowed to flush workqueue A from a work that is hosted on
>>> workqueue B?
>>
>> It seems like we ran into a lockdep complaint triggered by a recently queued
>> patch (87915adc3f0a ("workqueue: re-add lockdep dependencies for flushing")).
>> However, it's not clear to us whether anything is wrong with the code the
>> complaint refers to. Can any of you have a look? I have attached the lockep
>> complaint to this e-mail.
> 
> Is it possible that you're just running into the general lockdep
> limitation in that it doesn't know anything about *instances*, just
> *classes*?
> 
> Without looking at the correct code I don't want to try to diagnose this
> further, but that's what it seems like?
> 
> It's clearly telling you that you're acquiring "id_priv->handler_mutex"
> and lists a long dependency chain:
> 
>    &id_priv->handler_mutex --> (wq_completion)"nvmet-rdma-delete-wq" --> (work_completion)(&queue->release_work)
> 
> so that you shouldn't be trying to acquire this mutex again from running
> inside the release work:
> 
>    kworker/u16:7/169 is trying to acquire lock:
>    00000000578ccf82 (&id_priv->handler_mutex){+.+.}, at: rdma_destroy_id+0x6f/0x440 [rdma_cm]
> 
>    but task is already holding lock:
>    000000005d67271b ((work_completion)(&queue->release_work)){+.+.}, at: process_one_work+0x3ed/0xa20
> 
> 
> This looks like lockdep is working as it should.
> 
> If these are indeed (guaranteed to be) different, then I'd say you'd
> have to split them into different classes. However, I have no idea what
> the rules are for the recursion here, so I can't really say how you
> could do that.

I'm not sure how I can divide them into classes. The priv is really
an internal structure that surrounds a connection connection
representation. The priv->handler_mutex wraps every event handling
dispatched to the upper layer consumer.

The connection destruction barriers by acquiring and releasing this
event_handler mutex such that no events are handled by the

See drivers/infiniband/core/cma.c rdma_destroy_id()

In our case, one of the event handlers flushes a workqueue that
is hosting work items that essentially call rdma_destroy_id() on
connections that are guaranteed not to be the one currently handling
the event. So the priv is guaranteed to be a different instance.
