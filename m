From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:54:50 +0200
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <03e07267-4ae0-24c7-a3ce-10e55debd4a8@linux.vnet.ibm.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <20170707181436.GC24427@lst.de>
 <20170713212955.GD14716@localhost.localdomain>
 <03e07267-4ae0-24c7-a3ce-10e55debd4a8@linux.vnet.ibm.com>
Message-ID: <20170714125450.GB26975@lst.de>

On Fri, Jul 14, 2017@09:50:20AM -0300, Guilherme G. Piccoli wrote:
> We were planning to implement this here on LTC, and some ideas in
> discussion is whether such tool could be integrated to nvme-cli, like a
> "nvmed" tool, a daemon to handle the events. Advantages of the daemon
> are possible implementation of RAS features like trigger actions based
> on adapter's error, etc.

Don't uevent call a binary each time?  Either way nvme-cli is the right
place for it.

> Do you think this kind of tool is interesting? Suggestions on this topic
> are greatly appreciated. One of our concerns is that AEN events still
> need to be enabled by the user, not all events are enabled by default.
> One such tool would allow friendly configuration on which events user
> wants to enable.

Yes, AERs generally are opt-in.
