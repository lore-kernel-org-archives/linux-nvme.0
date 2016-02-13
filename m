From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 13 Feb 2016 01:44:01 -0800
Subject: [PATCHv2-4.5 04/10] NVMe: Fix namespace removal deadlock
In-Reply-To: <1455221147-24228-5-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <1455221147-24228-5-git-send-email-keith.busch@intel.com>
Message-ID: <20160213094401.GA15318@infradead.org>

So, this one is the thing I don't like.  The real issue here is the
broad scope of namespaces_mutex.  I think we should have a small
scope lock protecting just the list manipulations, which is not
held over I/O, and the issue would sort itself out.

Note that we already have a high level serialization for scanning
by always executing it in the scan_work work_item, so there is no
need for the high level serialization anyway.
