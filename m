From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Nov 2018 10:12:39 +0100
Subject: [PATCH v2 1/1] nvmet: debug namespace noiob boundary emulation
In-Reply-To: <20181030175729.25011-1-sagi@grimberg.me>
References: <20181030175729.25011-1-sagi@grimberg.me>
Message-ID: <20181108091239.GB4160@lst.de>

On Tue, Oct 30, 2018@10:57:28AM -0700, Sagi Grimberg wrote:
> Useful to exercise the host driver to noiob support without
> having device that actually require it. name it with a debug
> prefix such that it is clear that its a debug feature.

I'd really prefer to have a new CONFIG_NVME_TARGET_DEBUG
or similar config symbol so that we can not build these purely
debug knobs if desired.
