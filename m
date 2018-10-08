From: byungchul.park@lge.com (Byungchul Park)
Date: Mon, 8 Oct 2018 15:11:52 +0900
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <31b80bc0-afc6-6bd9-c722-302f538d3e5b@lge.com>
References: <20181006170915.GS2674@linux.ibm.com>
 <31b80bc0-afc6-6bd9-c722-302f538d3e5b@lge.com>
Message-ID: <20181008061152.GA18836@X58A-UD3R>

>On Tue, Sep 25, 2018@08:14:17PM -0700, Paul E. McKenney wrote:
>>I would expect something like this if someone did a double call_srcu()
>>or passed something to call_srcu() but then kept using it (for an example
>>of the latter, failed to make it inaccessible to readers before invoking
>>call_srcu() on it).  Yet another way to get here is to have unioned the
>>rcu_head structure with something used by the SRCU readers.
>>
>>The double call_srcu() can be located by building your kernel with
>>CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and rerunning your tests.  The other
>>two usually require inspection or bisection.
>>
>>So, the eternal question:  Is bisection feasible?
>
>Looks like I misread the lines pointed to by gdb, and it indeed seems
>like a premature free of the nvme_ns_head structure, but I fail to see
>where.

I'm sorry for making a noise if I'm telling something wrong. I'm not
familiar with nvme stuff though, I'm just curious about..

Is it ok to call nvme_mpath_clear_current_path(ns) without holding
any lock in nvme_failover_req(req)? No possible to race with other
rcu_assign_pointer(ns->head->current_path, some_value)?

In other words, has the namespace been serialized when calling
nvme_failover_req(req) so as to guarantee that there's no one doing
rcu_assign_pointer(ns->head->current_path, some_value) somewhere or so?

Sorry again if I miss something but hope it's helpful. Ignore if so.

Thanks,
Byungchul

>I've tried to bring up Barts testcase but failed so far.
>
>Bart, can you help out a bit?
>
>The last commit of the original merge 4.19 nvme merge is:
>
>b369b30cf510fe94d8884837039362e2ec223cec
>
>Can you check if that shows the problem (I suspect it does) and if so
>bisect between that and 9b89bc3857a6c0dfda18ddae2a42c114ecc32753, which
>as the first commit for the merge?
>
>>							Thanx, Paul
