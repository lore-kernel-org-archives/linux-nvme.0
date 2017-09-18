From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 Sep 2017 13:24:48 -0400
Subject: [PATCH] nvme: allow timed-out ios to retry
In-Reply-To: <e2ccf8e7-7c58-4f8d-a8e2-c9e846090e8c@broadcom.com>
References: <20170907201804.24979-1-jsmart2021@gmail.com>
 <20170907203759.GA2832@localhost.localdomain>
 <a6b3ce68-1df1-7d9a-0234-a7aab59cd863@gmail.com>
 <e2ccf8e7-7c58-4f8d-a8e2-c9e846090e8c@broadcom.com>
Message-ID: <20170918172447.GC17096@localhost.localdomain>

On Mon, Sep 18, 2017@10:15:45AM -0700, James Smart wrote:
> 
> So where are we with this - what should be put in place ?
> 
> The one revision I'd make from above based is - we'd only apply this timer
> on an I/O marked with a fastfail flag.

That's unnecessary as we already return 'false' immediately from the
blk_noretry_request check (which checks failfast) prior to checking the
timeout and retry count. So, I think you're patch is good as-is.
