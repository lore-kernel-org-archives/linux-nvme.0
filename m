From: a.dawn@samsung.com (Arnav Dawn)
Date: Tue, 30 May 2017 19:32:31 +0530
Subject: [PATCH v2 1/2] nvme: Adding support for FW Slot info log
In-Reply-To: <20170529175421.GA25061@lst.de>
References: <20170529175421.GA25061@lst.de>
 <CGME20170530140219epcas1p31163ac83162e9fa69328f5484e4a1daa@epcas1p3.samsung.com>
Message-ID: <1496152951-8790-1-git-send-email-a.dawn@samsung.com>


> 
> This functioin has basically no common code.  I think the current
> nvme_get_log_page should be renamed to nvme_get_smart_log and
> moved to scsi.c, and you'll just add a new helper for your log page or even
> just open code it in the caller.  A little inline helper for setting up dword10
> would be nice, though.

Agree, i'll change it in next version.
