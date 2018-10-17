From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 16 Oct 2018 23:39:41 -0700
Subject: Kernel v4.19-rc4 KASAN complaint
In-Reply-To: <20181005073833.GB7075@infradead.org>
References: <6892a170-0dcf-9498-19c2-50e1ae89f4ef@acm.org>
 <20180920071040.GA8685@infradead.org>
 <1537464241.224533.8.camel@acm.org>
 <20180925233211.GB28388@infradead.org>
 <20180926031417.GS4222@linux.ibm.com>
 <20181005073833.GB7075@infradead.org>
Message-ID: <20181017063941.GA11885@infradead.org>

On Fri, Oct 05, 2018@12:38:33AM -0700, Christoph Hellwig wrote:
> Looks like I misread the lines pointed to by gdb, and it indeed seems
> like a premature free of the nvme_ns_head structure, but I fail to see
> where.
> 
> I've tried to bring up Barts testcase but failed so far.
> 
> Bart, can you help out a bit?
> 
> The last commit of the original merge 4.19 nvme merge is:
> 
> b369b30cf510fe94d8884837039362e2ec223cec
> 
> Can you check if that shows the problem (I suspect it does) and if so
> bisect between that and 9b89bc3857a6c0dfda18ddae2a42c114ecc32753, which
> as the first commit for the merge?

Bart, do you cycles to help out bisecting this?
