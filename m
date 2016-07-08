From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 08 Jul 2016 08:56:56 -0700
Subject: [PATCH] nvme-fabrics: add-remove ctrl repeat fix
In-Reply-To: <20160704084817.GA1217@infradead.org>
References: <1467400412-13052-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20160704084817.GA1217@infradead.org>
Message-ID: <1467993416.3883.2.camel@linux.intel.com>

On Mon, 2016-07-04@01:48 -0700, Christoph Hellwig wrote:
> On Fri, Jul 01, 2016@12:13:32PM -0700, Jay Freyensee wrote:
> > Fix by: "Ming Lin" <mlin at kernel.org>
> 
> So is this authored by you or by Ming?  In the latter case this
> should be a
> 
> From: "Ming Lin" <mlin at kernel.org>
> 
> The patch itself looks fine, I'll queue it up after we've sorted
> out the above question, thanks to both of you.

Sorry for the late reply, back from an extended 4th of July vacation.

Ming authored the fix after I found the kernel crash and sent it to me
for testing.  So yes, to answer your question, the title would be
"From: Ming Lin".  Sorry about that.

Jay

> But I think we'll also need a kref_get_unless_zero in
> __nvmf_host_find
> to make this code fully correct, I'll prepare a patch for that.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
