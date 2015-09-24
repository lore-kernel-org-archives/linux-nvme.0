From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 24 Sep 2015 20:59:37 +0000
Subject: Adding IOCTL for NVMe controller reset
In-Reply-To: <ee3333b3a0ae4f878f4903ffe8ce547f@EX13D05UWC003.ant.amazon.com>
References: <ee3333b3a0ae4f878f4903ffe8ce547f@EX13D05UWC003.ant.amazon.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93CC139C4@fmsmsx104.amr.corp.intel.com>

> I was wondering what's the latest about adding an IOCTL to reset NVMe controller as described in
> this thread:
> http://lists.infradead.org/pipermail/linux-nvme/2015-March/001611.html
> Is there a patch available yet?
> 
> This is very useful to finish a firmware upgrade without power-cycling the host on some old kernel
> where the sysfs method doesn't work.

Yep, it's been committed upstream:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4cc06521ee1f153e0d292413a5bff7bbbdee92d0
