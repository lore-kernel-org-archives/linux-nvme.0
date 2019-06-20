From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Jun 2019 23:39:15 -0700
Subject: Use of WARN in nvme subssytem.
In-Reply-To: <82D7EABA-733D-4CBF-BCD6-E8EA51C2B220@oracle.com>
References: <82D7EABA-733D-4CBF-BCD6-E8EA51C2B220@oracle.com>
Message-ID: <20190620063915.GA13586@infradead.org>

On Fri, May 24, 2019@09:16:01AM -0500, John Donnelly wrote:
> Hi,
> 
> There is approximately 72 occurrences of WARN*  in the driver/nvme modules in 5.2.rc.  If the system is configured with the option ?panic_on_warn? the system will reboot.  Are all of  these warnings necessary ? I am sure many could  be converted to log entries with more informative content for administrators. 

Necessary is in the eye of the beholder, but they do have a very valid
use case to point out should not happen scenarios, which is what WARN*
is for.  OTOH panic_on_warn is generally bat shit crazy, so you get what
you ask for.
