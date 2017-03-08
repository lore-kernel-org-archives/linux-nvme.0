From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Mar 2017 21:34:17 +0200
Subject: nvmet: race condition while CQE are getting processed
 concurrently with the DISCONNECTED event
In-Reply-To: <20170308154605.GA28937@infradead.org>
References: <CY1PR12MB077418C35F6EA2499CBACA45BC2C0@CY1PR12MB0774.namprd12.prod.outlook.com>
 <7dc99796-899e-b1a0-6ddb-cbfc497195dd@grimberg.me>
 <20170308154605.GA28937@infradead.org>
Message-ID: <9e9301a7-93a1-20a7-4f4f-d50f26a176e8@grimberg.me>


>> For that perhaps you can try patch [1].
>
> Yes, I'll think we need that.  Did I mention that the percpu
> refounter API is a complete trainwreck a couple times? :)

Heh, You probably did, I wander what is the use-case
for percpu_ref_kill without the guarantee that subsequent
percpu_ref_tryget_live will fail...

>> 2. ib_destroy_cq does not really protect against a case where
>>    the work requeue itself because it runs flush_work(). In this
>>    case when the work re-executes it polls a cq array that is
>>    already freed and sees a bogus successful completion. Perhaps
>>    ib_free_cq should run cancel_work_sync() instead? see [2].
>
> Yeah, we'll probably need that as well.  Independent of it solves
> the problem reported here.

I'll send proper patches.

Would be nice if Raju or Yi can see if this helps
at all..
