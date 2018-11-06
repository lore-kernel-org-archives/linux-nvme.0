From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 5 Nov 2018 23:10:57 -0800
Subject: [PATCH 2/2] nvme: add quirk to not call disable function when
 suspending
In-Reply-To: <20181106020402.21120-2-acelan.kao@canonical.com>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106020402.21120-2-acelan.kao@canonical.com>
Message-ID: <20181106071057.GB23935@infradead.org>

On Tue, Nov 06, 2018@10:04:02AM +0800, AceLan Kao wrote:
> Call nvme_dev_disable() function leads to the power consumption goes
> up to 2.2 Watt during suspend-to-idle, and from SK hynix FE, they
> suggest us to use its own APST feature to do the power management during
> s2idle.
> After D3 is diabled and nvme_dev_disable() is not called while
> suspending, the power consumption drops to 0.77 Watt during s2idle.

Same comment as previous one.  Get the firmware fixed please - this
doesn't prevent the drive from working, but it is a grave implementation
bug in it that needs to get fixed.
