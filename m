From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Jun 2019 09:32:29 +0200
Subject: [PATCH v3 3/3] nvme: notify thermal framework when temperature
 threshold events occur
In-Reply-To: <CAC5umyg_nDjtLyJM8iNF5f+YdQ6EG+G5ks-uFqu_VFiX2=e=qQ@mail.gmail.com>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com>
 <20190601090353.GE6453@lst.de>
 <CAC5umyg_nDjtLyJM8iNF5f+YdQ6EG+G5ks-uFqu_VFiX2=e=qQ@mail.gmail.com>
Message-ID: <20190604073229.GI15680@lst.de>

On Sun, Jun 02, 2019@10:46:12PM +0900, Akinobu Mita wrote:
> 2019?6?1?(?) 18:04 Christoph Hellwig <hch at lst.de>:
> >
> > So before we allowed userspace to get smart AEN notifications through
> > uevent, and would expect userspace to clear the AEN.  I think this
> > could at least potentially break existing userspace by now doing that
> > in kernel space.
> 
> This change unconditionally sets NVME_SMART_CRIT_TEMPERATURE flag in
> nvme_enable_aen(), it could be problematic for existing userspace.
> So it's better to provide a knob to enable/disable the event notification
> and we can utilize get_mode()/set_mode() in the thermal_zone_device_ops.
> 
> Other than that, this change doesn't remove ctrl->aen_result, so existing
> userspace still receives NVME_AEN=* uevents.

And that is the problem.  Because for notifications we expect userspace to
read the log page and clear the event, while we are not doing it in kernel
space.
