From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 4 May 2016 14:59:11 +0000
Subject: RFC: what to do about abort?
In-Reply-To: <20160504105815.GA20848@infradead.org>
References: <20160504100313.GA22726@infradead.org>
 <5729CCC9.9060307@suse.de> <20160504105815.GA20848@infradead.org>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D57C119@fmsmsx104.amr.corp.intel.com>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Christoph Hellwig
> Sent: Wednesday, May 04, 2016 4:58 AM
> To: Hannes Reinecke
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: RFC: what to do about abort?


> The NVMe spec is extremely vague about Abort doing anything:
> 
> "An Abort command is a best effort command; the command to abort may
>  have already completed, currently be in execution, or may be deeply
>  queued. It is implementation specific if/when a controller chooses
>  to complete the command when the command to abort is not found."
> 
> And various controllers make full use of the ambiguity offered.

That's an unfortunate way to the spec describes this command. All my controllers immediately post success status with the CQE's DWORD0 set to 0;abort is essentially a no-op.

Even though it's a no-op for me, the main benefit is that abort makes for an awesome trigger for analyzers and firmware. It's been a valuable tool for debugging issues, and I'd hate to lose it.

Can we propose changing the spec instead?
