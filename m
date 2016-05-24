From: mlin@kernel.org (Ming Lin)
Date: Tue, 24 May 2016 11:43:21 -0700
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <20160523145556.GB17208@localhost.localdomain>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
 <20160523105807.GC26331@infradead.org>
 <20160523134116.GA17208@localhost.localdomain>
 <20160523143631.GA28107@infradead.org>
 <20160523145556.GB17208@localhost.localdomain>
Message-ID: <CAF1ivSbWrkNUu0HgDdvev6yOV9bSbOjkDQ8mtS0VSq=k9SEqng@mail.gmail.com>

On Mon, May 23, 2016@7:55 AM, Keith Busch <keith.busch@intel.com> wrote:
>
>> > It's moved out of that function holding the rcu read lock since
>> > blk_mq_stop_hw_queues potentially sleeps.
>>
>> blk_mq_stop_hw_queues is a loop around blk_mq_stop_hw_queue,
>> which itself does two calls to cancel_delayed_work and a set_bit.
>> None of them can block.

It's blk_mq_cancel_requeue_work() that potentially sleeps.
