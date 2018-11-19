From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 14:37:59 -0800
Subject: [PATCH] nvme: validate controller state before rescheduling keep
 alive
In-Reply-To: <20181116083123.GA10350@infradead.org>
References: <20181114231204.5996-1-jsmart2021@gmail.com>
 <20181116083123.GA10350@infradead.org>
Message-ID: <ce8f4e67-d318-02e2-d9eb-4e429225f1ae@grimberg.me>


> [adding Sagi for keep alive issues]
> 
> On Wed, Nov 14, 2018@03:12:04PM -0800, James Smart wrote:
>>   	ctrl->comp_seen = false;
>> -	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>> +	if (ctrl->state == NVME_CTRL_LIVE ||
>> +	    ctrl->state == NVME_CTRL_CONNECTING)
>> +		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>>   }
> 
> As we move into a different state before calling nvme_stop_keep_alive
> this should be fine, even if open code state checks always worry me
> a bit..

So this flow is when a keep alive successful completion arrives and
before we actually schedule the work we start to teardown the
controller (and stop the keep alive work) correct? I guess that can
happen...

I agree that it should be fine, but should we add a rmb before
checking the state (and a wmb when setting the state) given that
this is racy to begin with?

Trying to think if there is a cleaner way to address that...
