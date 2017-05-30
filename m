From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 May 2017 14:30:48 +0300
Subject: [PATCH v2 1/2] nvme: Adding support for FW Slot info log
In-Reply-To: <20170529175421.GA25061@lst.de>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141731epcas5p39667840c01555c7cf49527167535f82c@epcas5p3.samsung.com>
 <1496067458-26190-1-git-send-email-a.dawn@samsung.com>
 <20170529175421.GA25061@lst.de>
Message-ID: <5d923369-326e-0c8c-ed91-92e7f463367a@grimberg.me>


> This functioin has basically no common code.  I think the current
> nvme_get_log_page should be renamed to nvme_get_smart_log and moved
> to scsi.c, and you'll just add a new helper for your log page or
> even just open code it in the caller.  A little inline helper for
> setting up dword10 would be nice, though.

Agree, that'd be cleaner.
