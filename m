From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 27 Feb 2017 16:42:08 +0200
Subject: [PATCH] nvme/pci: Poll CQ on timeout
In-Reply-To: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
References: <1487977168-5347-1-git-send-email-keith.busch@intel.com>
Message-ID: <c29ea931-b57e-b873-2e22-06f02f26bc8c@grimberg.me>

> If an IO timeout occurs, it's helpful to know if the controller did not
> post a completion or the driver missed an interrupt. While we never expect
> the latter, this patch will make it possible to tell the difference so
> we don't have to guess.

Did you really got a missed interrupt?

It seems reasonable, I'm just curious...
