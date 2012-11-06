From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 6 Nov 2012 16:19:58 +0000
Subject: [PATCH] NVMe: Add discard support for capable devices
In-Reply-To: <20121106161509.GU4244@linux.intel.com>
References: <1343933944-32726-1-git-send-email-keith.busch@intel.com>
 <20121106161008.GA1736@linux.intel.com>
 <20121106161509.GU4244@linux.intel.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B9162BBEBC@FMSMSX105.amr.corp.intel.com>

Yes, though I should have made this patch dependent on the cmdid patch so I could use the right error handling here. I'll submit an update to reflect this and your other comments. Thanks for the review, I very much appreciate the feedback.

> -----Original Message-----
> From: Matthew Wilcox [mailto:willy at linux.intel.com]
> Sent: Tuesday, November 06, 2012 9:15 AM
> To: Busch, Keith
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Add discard support for capable devices
> 
> On Tue, Nov 06, 2012@11:10:08AM -0500, Matthew Wilcox wrote:
> > Although ... now I'm looking at the failure path in
> > nvme_submit_bio_queue(), isn't it the case that we'll leak cmdids if
> > nvme_map_bio() fails?  And in this case?  So I think we also need:
> >
> > + free_cmdid:
> > +	free_cmdid(nvmeq, cmdid, NULL);
> >   free_iod:
> >
> > And then change the 'goto free_iod' to 'goto free_cmdid'.
> 
> Never mind; just got to the patch where you fixed this :-)
