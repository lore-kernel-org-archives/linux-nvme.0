From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Mon, 12 May 2014 19:41:52 +0000
Subject: [PATCH] Remove redundant writes to uncached sqe memory
In-Reply-To: <20140511025254.GC6121@linux.intel.com>
References: <536D3E3F.9050902@micron.com>
 <20140511025254.GC6121@linux.intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A99438A4E4@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Matthew Wilcox [mailto:willy at linux.intel.com]
> Sent: Saturday, May 10, 2014 7:53 PM
> To: Sam Bradshaw (sbradshaw)
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] Remove redundant writes to uncached sqe memory
> 
> On Fri, May 09, 2014@01:44:47PM -0700, Sam Bradshaw wrote:
> > The memset to clear the SQE in nvme_submit_iod() is made partially
> > redundant by subsequent writes.  This patch explicitly clears each
> > SQE structure member in ascending order, eliminating the need for
> > the memset.  With this change, our perf runs show ~1.5% less time
> > spent in the IO submission path and minor reduced q lock contention.
> 
> I'm shocked!  I thought that zeroing the cacheline first would be
> better
> performing than storing into parts of the cacheline.  But I can't argue
> with your numbers.  I think your patch is missing a store to the
> metadata
> element though; care to rerun your test with that added?

Yes, thanks for pointing out the missing store to ->metadata.

Without memset:

+  35.35%  fio  nvme_process_cq 
+  10.85%  fio  nvme_make_request 
+  10.64%  fio  nvme_map_bio      
+  10.49%  fio  free_cmdid        
+   9.65%  fio  alloc_cmdid       
+   9.52%  fio  bio_completion    
+   5.18%  fio  nvme_submit_iod   
+   2.38%  fio  nvme_submit_bio_queue
+   2.26%  fio  nvme_alloc_iod       
+   2.17%  fio  nvme_setup_prps      
+   0.90%  fio  nvme_free_iod        
+   0.61%  fio  nvme_irq                                      

With memset:

+  36.24%  fio  nvme_process_cq    
+  11.04%  fio  nvme_make_request  
+  10.76%  fio  nvme_map_bio       
+   9.48%  fio  free_cmdid         
+   9.24%  fio  alloc_cmdid        
+   8.51%  fio  bio_completion     
+   6.33%  fio  nvme_submit_iod    
+   2.38%  fio  nvme_submit_bio_queue
+   2.30%  fio  nvme_alloc_iod       
+   2.18%  fio  nvme_setup_prps      
+   0.91%  fio  nvme_free_iod        
+   0.62%  fio  nvme_irq            

The numbers pretty consistently show nvme_submit_io() taking more 
cpu time with the memset.  But, to be fair there is run-to-run 
variation +/- ~1%  in cpu time for any of the bigger offenders.  

The test setup is a bit odd for several (deliberate) reasons:

1) we have fewer queue pairs supported by hardware than cpu cores.
2) fio io submission threads are pegged to cores on nodes other than
the nodes owning the SQ/CQ physical memory, causing the SQE update
to cross a QPI link.
3) io submission threads concurrently run on more than one remote 
core and contend for the SQ lock.

If you're not so keen on these data as justification, I could rerun
the experiment on a platforms with differing coherency models. May 
take a bit of time, though.

-Sam


 
