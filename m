From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Apr 2018 16:28:37 -0600
Subject: 'modprobe nvme_core multipath=N' crashes in face of multipath
 fabric
In-Reply-To: <4b142a06-ff6a-0e68-2043-0ed2886b8d50@grimberg.me>
References: <20180410204953.GA17979@redhat.com>
 <20180411134530.GC9238@localhost.localdomain>
 <20180411141720.GB22124@redhat.com>
 <20180411175824.GE9238@localhost.localdomain>
 <20180411214611.GA24088@redhat.com>
 <4b142a06-ff6a-0e68-2043-0ed2886b8d50@grimberg.me>
Message-ID: <20180412222837.GE6424@localhost.localdomain>

On Thu, Apr 12, 2018@11:12:12AM +0300, Sagi Grimberg wrote:
> On 04/12/2018 12:46 AM, Mike Snitzer wrote:
> > This patch fixed the issue for me.  Verified that modprobe nvme_core
> > multipath=N and multipath=Y works with the mptest case I shared in my
> > original report.
> > 
> > If you do go with this patch, please feel free to add:
> > 
> > Tested-by: Mike Snitzer <snitzer at redhat.com>
> 
> This looks good to me too, you can add my
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

I'm going to have to make one minor change here since this will still
break if you've a multi-path subsystem with multiple namespaces. I'll
just need to move the IDA up to the subsystem level instead of on the
subsystem heads, but otherwise much the same.
