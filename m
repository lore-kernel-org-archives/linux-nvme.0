From: jeg@amazon.com (Gu, Jerry)
Date: Thu, 24 Sep 2015 21:27:09 +0000
Subject: Adding IOCTL for NVMe controller reset
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93CC139C4@fmsmsx104.amr.corp.intel.com>
References: <ee3333b3a0ae4f878f4903ffe8ce547f@EX13D05UWC003.ant.amazon.com>
 <B58D82457FDA0744A320A2FC5AC253B93CC139C4@fmsmsx104.amr.corp.intel.com>
Message-ID: <5e3d24c0e83948469d55193ca79b9d43@EX13D05UWC003.ant.amazon.com>

Hi Keith,

   Thanks for your prompt response.  
   Is all the latest development happening on kernel.org now? Git.infradead.org is no longer used?

Thanks a lot,
Jerry

-----Original Message-----
From: Busch, Keith [mailto:keith.busch@intel.com] 
Sent: Thursday, September 24, 2015 2:00 PM
To: Gu, Jerry; linux-nvme at lists.infradead.org
Subject: RE: Adding IOCTL for NVMe controller reset

> I was wondering what's the latest about adding an IOCTL to reset NVMe 
> controller as described in this thread:
> http://lists.infradead.org/pipermail/linux-nvme/2015-March/001611.html
> Is there a patch available yet?
> 
> This is very useful to finish a firmware upgrade without power-cycling 
> the host on some old kernel where the sysfs method doesn't work.

Yep, it's been committed upstream:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4cc06521ee1f153e0d292413a5bff7bbbdee92d0
