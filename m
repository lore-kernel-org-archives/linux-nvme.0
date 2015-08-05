From: havenyang@126.com (HavenYang)
Date: Wed, 5 Aug 2015 08:53:30 +0800 (CST)
Subject: what time does host will re-used the prplist memory region.
In-Reply-To: <20150804134000.GB13681@linux.intel.com>
References: <e06add8.1a3fb.14ef6c204d6.Coremail.havenyang@126.com>
 <20150804134000.GB13681@linux.intel.com>
Message-ID: <756479b3.d0e.14efb594bf2.Coremail.havenyang@126.com>


Dear Matthew

Thank you for your feedback, it's very important to me.
I suggest your comment for my first question should be wrote to the spec, 
otherwise, there maybe others confused for this issue and go to the wrong way.



At 2015-08-04 21:40:00, "Matthew Wilcox" <willy@linux.intel.com> wrote:
>On Tue, Aug 04, 2015@11:29:47AM +0800, HavenYang wrote:
>> It says the SQhead indicate Submission Queue entries may be re-used, but it not say the PRPlist related to this command may be re-used or not, I confused.
>> 
>> my question is:
>> 1. from host side,?what is the condition can host re-used the prplist memory region for a host command, SQHead or command complete?
>
>The host can only reuse the PRP list memory when the command has been
>completed.  The device is entitled to use the PRP list throughout
>execution of the command.
>
>> 2. from device side, what is the condition to update SQHead, fetched command head(simple) or fetched all prp from prplist(complex)?
>
>The first; the host only takes this as an indication that it can reuse
>the SQ entry.
