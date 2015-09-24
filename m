From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Sep 2015 21:34:12 +0000 (UTC)
Subject: Adding IOCTL for NVMe controller reset
In-Reply-To: <5e3d24c0e83948469d55193ca79b9d43@EX13D05UWC003.ant.amazon.com>
References: <ee3333b3a0ae4f878f4903ffe8ce547f@EX13D05UWC003.ant.amazon.com>
 <B58D82457FDA0744A320A2FC5AC253B93CC139C4@fmsmsx104.amr.corp.intel.com>
 <5e3d24c0e83948469d55193ca79b9d43@EX13D05UWC003.ant.amazon.com>
Message-ID: <alpine.LNX.2.00.1509242130240.23840@localhost.lm.intel.com>

On Thu, 24 Sep 2015, Gu, Jerry wrote:
> Hi Keith,
>
>   Thanks for your prompt response.
>   Is all the latest development happening on kernel.org now? Git.infradead.org is no longer used?

Right, the path to mainline for all nvme driver work is through the
linux-block tree on kernel.org now:

https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git

I still have repos on infradead.org, though I don't use it to get things
upstream.
