From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 22 Oct 2018 18:17:31 -0700
Subject: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
In-Reply-To: <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <094669f3df1690dec5913c2086f6a6d8c470f685.camel@sipsolutions.net>
 <1540241646.128590.16.camel@acm.org>
 <d45d54e8a46028c2b83296c5bf25a89500a289c4.camel@sipsolutions.net>
Message-ID: <8d1a9c8c-fddb-7fb9-4bba-377bc6d51829@acm.org>

On 10/22/18 2:04 PM, Johannes Berg wrote:
> On Mon, 2018-10-22@13:54 -0700, Bart Van Assche wrote:
>> The code in the column with label "CPU0" is code called by do_blockdev_direct_IO().
>>  From the body of that function:
>>
>> 			/* will be released by direct_io_worker */
>> 			inode_lock(inode);
> 
> I don't think this is related. If this comment is true (and I have no
> reason to believe it's not), then the inode lock is - by nature of
> allowing lock/unlock to happen in different processes - not something
> lockdep can track to start with.
> 
> [ ... ]
 >> You do realize that this workqueue tracking stuff has been around for
> a few years (and got removed again in refactoring, etc.) and has found > countless bugs?

This is something I had not realized when I posted the patch at the 
start of this e-mail thread. Thanks for having mentioned this.

But I doubt that the inode lock has been annotated incorrectly. From the 
kernel source code:

static inline void inode_lock(struct inode *inode)
{
	down_write(&inode->i_rwsem);
}

[ ... ]

void __sched down_write(struct rw_semaphore *sem)
{
	might_sleep();
	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);

	LOCK_CONTENDED(sem, __down_write_trylock, __down_write);
	rwsem_set_owner(sem);
}

It seems to me that the inode lock has been annotated correctly as an 
rwsem. It's not clear to me however why lockdep complains about a 
deadlock for the direct I/O code. I hope someone has the time to go to 
the bottom of this.

Bart.
