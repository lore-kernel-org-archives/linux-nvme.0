From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 23 Sep 2016 09:49:36 -0500
Subject: [PATCH RFC] nvme-cli: propose 'c' vs 'r' for connect flag
In-Reply-To: <20160923033301.GB12637@infradead.org>
References: <1474583840-23739-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20160923033301.GB12637@infradead.org>
Message-ID: <00c801d215a9$b45b62f0$1d1228d0$@opengridcomputing.com>



> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of
> Christoph Hellwig
> Sent: Thursday, September 22, 2016 10:33 PM
> To: Jay Freyensee
> Cc: swise at opengridcomputing.com; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH RFC] nvme-cli: propose 'c' vs 'r' for connect flag
> 
> On Thu, Sep 22, 2016@03:37:20PM -0700, Jay Freyensee wrote:
> > I am not sure if it matters too much except in possibly
> > human usage understanding, but '-r' is used in the 'discover'
> > command for --raw.  Change the --reconnect-delay flag
> > single letter to something not being used in any fabrics
> > command.
> 
> Sounds ok to me.  But I have to say dealing with these short options
> start to be a little annoying.  For a lot of these commands I'd prefer
> to simply support long options only if we could (I'll need to look
> at argconfig.c in a bit more detail how easily that could be done).

You could just not document the short options...
