From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 13 Oct 2016 09:40:01 -0700
Subject: [PATCH nvme-cli] argconfig: Rewind optind before looping on
 getopt_long
In-Reply-To: <85c9a770-2121-fdc7-5695-f0e4f6026647@grimberg.me>
References: <1476373205-30860-1-git-send-email-sagi@grimberg.me>
 <20161013161005.GD17823@localhost.localdomain>
 <85c9a770-2121-fdc7-5695-f0e4f6026647@grimberg.me>
Message-ID: <1476376801.6246.0.camel@linux.intel.com>

On Thu, 2016-10-13@19:00 +0300, Sagi Grimberg wrote:
> > 
> > > 
> > > In conf file based discovery we can call argconfig_parse
> > > multiple times.
> > 
> > Jay beat you to it. :)
> 
> Heh :)
> 
> October is a multi-holiday sparse month...
> 
> Thanks Jay!

No thank you :-)

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
