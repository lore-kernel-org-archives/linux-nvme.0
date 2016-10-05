From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 4 Oct 2016 21:16:30 -0700
Subject: [PATCH v2 4/7] blk-mq: Introduce blk_quiesce_queue() and
 blk_resume_queue()
In-Reply-To: <CACVXFVMY19vuDjsECg2uX0_y_K7DUaaGqXPX9PYiBy5sfXmAEw@mail.gmail.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <a9eb4e95-6d77-e527-c42a-fd2e6f104bed@sandisk.com>
 <CACVXFVOO4P3RsnWci8XHdFoYBhNPq0KqjWJddsie-92+31bpEg@mail.gmail.com>
 <9fb67745-954c-a70f-a89a-d184c99ae9aa@sandisk.com>
 <CACVXFVMY19vuDjsECg2uX0_y_K7DUaaGqXPX9PYiBy5sfXmAEw@mail.gmail.com>
Message-ID: <a11bb09a-6207-f4a8-cfd4-4fe5627c1700@sandisk.com>

On 10/01/16 15:56, Ming Lei wrote:
> If we just call the rcu/srcu read lock(or the mutex) around .queue_rq(), the
> above code needn't to be duplicated any more.

Hello Ming,

Can you have a look at the attached patch? That patch uses an srcu read 
lock for all queue types, whether or not the BLK_MQ_F_BLOCKING flag has 
been set. Additionally, I have dropped the QUEUE_FLAG_QUIESCING flag. 
Just like previous versions, this patch has been tested.

Thanks,

Bart.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-blk-mq-Introduce-blk_mq_quiesce_queue.patch
Type: text/x-patch
Size: 5211 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161004/c8855299/attachment.bin>
