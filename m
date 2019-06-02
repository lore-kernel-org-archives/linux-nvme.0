From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun, 2 Jun 2019 22:46:12 +0900
Subject: [PATCH v3 3/3] nvme: notify thermal framework when temperature
 threshold events occur
In-Reply-To: <20190601090353.GE6453@lst.de>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-4-git-send-email-akinobu.mita@gmail.com>
 <20190601090353.GE6453@lst.de>
Message-ID: <CAC5umyg_nDjtLyJM8iNF5f+YdQ6EG+G5ks-uFqu_VFiX2=e=qQ@mail.gmail.com>

2019?6?1?(?) 18:04 Christoph Hellwig <hch at lst.de>:
>
> So before we allowed userspace to get smart AEN notifications through
> uevent, and would expect userspace to clear the AEN.  I think this
> could at least potentially break existing userspace by now doing that
> in kernel space.

This change unconditionally sets NVME_SMART_CRIT_TEMPERATURE flag in
nvme_enable_aen(), it could be problematic for existing userspace.
So it's better to provide a knob to enable/disable the event notification
and we can utilize get_mode()/set_mode() in the thermal_zone_device_ops.

Other than that, this change doesn't remove ctrl->aen_result, so existing
userspace still receives NVME_AEN=* uevents.
