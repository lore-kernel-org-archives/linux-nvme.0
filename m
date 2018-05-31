From: hch@lst.de (Christoph Hellwig)
Date: Thu, 31 May 2018 18:22:13 +0200
Subject: [PATCH] nvme: report subsystem-reset not supported by controller.
In-Reply-To: <1527626554-101086-1-git-send-email-dmilburn@redhat.com>
References: <1527626554-101086-1-git-send-email-dmilburn@redhat.com>
Message-ID: <20180531162213.GA30654@lst.de>

On Tue, May 29, 2018@03:42:34PM -0500, David Milburn wrote:
> Add a little more description for "nvme subsystem-reset"
> failures, currently driver reports "Inappropriate ioctl
> for device".

A warning sounds nice, but why can't we add it in nvme-cli?
