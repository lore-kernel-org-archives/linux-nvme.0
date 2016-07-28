From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 28 Jul 2016 14:36:47 -0700
Subject: [PATCH] [RESEND] nvme-cli: user-defined hostnqn option for
 discover
In-Reply-To: <45CF57A8-206F-4353-9386-A0BB8158AB5A@mellanox.com>
References: <1469736200-6618-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1469736200-6618-2-git-send-email-james_p_freyensee@linux.intel.com>
 <c6c9f9d8-7e02-70da-5972-28f8f9c6550c@mellanox.com>
 <20160728203534.GB2420@localhost.localdomain>
 ,<1469740914.9209.3.camel@linux.intel.com>
 <45CF57A8-206F-4353-9386-A0BB8158AB5A@mellanox.com>
Message-ID: <1469741807.9209.10.camel@linux.intel.com>

On Thu, 2016-07-28@21:27 +0000, Roy Shterman wrote:
> Sounds good to me, but what about the short option character?
> 
> I think using 'h' as a short option will not work because it is
> already dedicated for --help parameter.
> 

That is a good point :-/.

OK, I'll respin my discover patch to use 'q' short option you chose.
I'll send the patch out shortly.
 
> I will send my patch later only for connect after Keith will merge
> discover patch.
> 
> Thanks,
> Roy
> 
> ?-29 ????? 2016, ???? 00:22, ??J Freyensee ?<
> james_p_freyensee at linux.intel.com> ???/?:?
> 
> > On Thu, 2016-07-28@16:35 -0400, Keith Busch wrote:
> > > On Thu, Jul 28, 2016@11:20:15PM +0300, Roy Shterman wrote:
> > > > Hi Jay,
> > > > Actually I planned to send the same patch tomorrow,
> > > > I think we should add user-defined hostnqn parameter into
> > > > 'connect'
> > > > command.
> > > Is it okay to apply this as-is, or should I wait for the patch
> > > for
> > > connect?
> > I think we should break up the patches as one for discover, and one
> > for
> > connect.  Each patch can show a usage for each of the commands (one
> > for
> > 'discover', one for 'connect'.
> > 
> > How about apply my discover patch as-is, then Roy re-submit his
> > patch
> > for connect?  And in the connect patch, supply an example usage
> > (which
> > I think this will be useful as there is currently no man pages for
> > these new fabrics commands).
> > 
> > 
> > > _______________________________________________
> > > Linux-nvme mailing list
> > > Linux-nvme at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-nvme
