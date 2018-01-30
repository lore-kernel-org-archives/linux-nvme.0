From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 Jan 2018 08:05:19 +0100
Subject: [PATCH] nvmet: Change error code of discard command if not
 supported
In-Reply-To: <0012e13c-a621-fdc3-f072-294641b00136@grimberg.me>
References: <1517234450-16502-1-git-send-email-israelr@mellanox.com>
 <0012e13c-a621-fdc3-f072-294641b00136@grimberg.me>
Message-ID: <20180130070519.GB12196@lst.de>

On Mon, Jan 29, 2018@08:30:45PM +0200, Sagi Grimberg wrote:
> Actually I don't think we are allowed to fail with this status. We claim
> we support dsm regardless of the underlying backend device (because we
> can expose different devices in the same subsystem), so we can't fail
> a valid dsm command on invalid opcode. Either we keep the existing
> behavior or we simply return success as dsm is a hint anyways...

Yes, we should return success here.
