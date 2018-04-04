From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 16:02:38 +0300
Subject: [PATCH 1/1] nvme-rdma: Add IB event handling support
In-Reply-To: <1521647315-10011-1-git-send-email-maxg@mellanox.com>
References: <1521647315-10011-1-git-send-email-maxg@mellanox.com>
Message-ID: <351db80c-ed94-3b92-fc68-97f1873d8a1d@grimberg.me>


> IB devices may invoke IB events that need a special treatment
> from the ib_client. For example, fatal event notification raised
> to registered clients due to an invalid port/device state after EEH.
> IB clients should be aware of this fatal event and not post any WR's
> to the device. Draining the QP, for example, is forbidden and will
> stuck forever waiting for the flushed work completions.

Where can we find a documentation to what should and should not
work in this event?
