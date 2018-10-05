From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 5 Oct 2018 00:38:33 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <20180926031417.GS4222@linux.ibm.com>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920071040.GA8685@infradead.org>
 <1537464241.224533.8.camel@acm.org>
 <20180925233211.GB28388@infradead.org>
 <20180926031417.GS4222@linux.ibm.com>
Message-ID: <20181005073833.GB7075@infradead.org>

On Tue, Sep 25, 2018@08:14:17PM -0700, Paul E. McKenney wrote:
> I would expect something like this if someone did a double call_srcu()
> or passed something to call_srcu() but then kept using it (for an example
> of the latter, failed to make it inaccessible to readers before invoking
> call_srcu() on it).  Yet another way to get here is to have unioned the
> rcu_head structure with something used by the SRCU readers.
>
> The double call_srcu() can be located by building your kernel with
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y and rerunning your tests.  The other
> two usually require inspection or bisection.
> 
> So, the eternal question:  Is bisection feasible?

Looks like I misread the lines pointed to by gdb, and it indeed seems
like a premature free of the nvme_ns_head structure, but I fail to see
where.

I've tried to bring up Barts testcase but failed so far.

Bart, can you help out a bit?

The last commit of the original merge 4.19 nvme merge is:

b369b30cf510fe94d8884837039362e2ec223cec

Can you check if that shows the problem (I suspect it does) and if so
bisect between that and 9b89bc3857a6c0dfda18ddae2a42c114ecc32753, which
as the first commit for the merge?

> 							Thanx, Paul
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
