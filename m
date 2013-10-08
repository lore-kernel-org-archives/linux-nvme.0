From: m@bjorling.me (=?ISO-8859-1?Q?Matias_Bj=F8rling?=)
Date: Tue, 08 Oct 2013 15:19:48 +0200
Subject: [PATCH RFC 0/2] Convert from bio-based to blk-mq
In-Reply-To: <20131008131036.GC7422@linux.intel.com>
References: <1381224862-5299-1-git-send-email-m@bjorling.me>
 <20131008131036.GC7422@linux.intel.com>
Message-ID: <52540674.5030402@bjorling.me>

On 10/08/2013 03:10 PM, Matthew Wilcox wrote:
> On Tue, Oct 08, 2013@11:34:20AM +0200, Matias Bj?rling wrote:
>> The nvme driver implements itself as a bio-based driver. This primarily because
>> of high lock congestion for high-performance nvm devices. To remove the
>> congestion, a multi-queue block layer is being implemented.
>
> Um, no.  You'll crater performance by adding another memory allocation
> (of the struct request).  multi-queue is not the solution.
>

Agree that there shouldn't be yet another allocation. blk-mq allocates 
the requests upfront for that reason. Additionally, nvme_cmd_info can be 
handled within the request payload.
