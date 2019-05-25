From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 26 May 2019 00:05:26 +0900
Subject: [PATCH 3/3] nvme: quiesce admin queue for fw activation
In-Reply-To: <CAOSXXT5QT4q7fbTgs-k50DU87xeidgFoGkJDboY59ypU6ovHzQ@mail.gmail.com>
References: <20190524202036.17265-1-keith.busch@intel.com>
 <20190524202036.17265-4-keith.busch@intel.com>
 <20190525131710.GA342@minwooim-desktop>
 <CAOSXXT5QT4q7fbTgs-k50DU87xeidgFoGkJDboY59ypU6ovHzQ@mail.gmail.com>
Message-ID: <20190525150525.GC342@minwooim-desktop>

> >
> > Keith,
> >
> > Can we have an warning here to indicate if device firmware has not set
> > the CSTS.PP yet.  In that case, the information message that you have
> > introduced here may be invalid.  It would be great if we check the
> > CSTS.PP first, and then print it out.
> >
> > If it's not necessary to have it, please feel free to let me know.
> > Of course, device has to prepared the processing paused status,
> > though :)
> 
> Well, between the fw notice AEN and when the work can finally check
> CSTS.PP, we really have no way of knowing if the controller paused and
> resumed before we observed that controller status, so a warning would
> be a bit much. We're still quiescing, so the print is valid.

That makes sense.  The work scheduled from the AEN request cannot
guarantee whether firmware has paused/resumed or not.

How about this, we prints out that the queues have been quiesced
instead of "processing paused" which might make confusing between
firmware just sets the CSTS.PS and the work scheduled has just quiesced
the admin and io queues both.

Thanks for your kindly response, by the way.

> In case the controller did pause processing, and we hit the unusual
> timeout race that does not see CSTS.PP, the new prints make it clear
> that's what happened.
