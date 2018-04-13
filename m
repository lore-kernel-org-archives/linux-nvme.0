From: hch@lst.de (Christoph Hellwig)
Date: Fri, 13 Apr 2018 19:06:24 +0200
Subject: [PATCH v1 0/5] Fix keep-alive mechanism for fabrics
In-Reply-To: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
References: <1523380689-17151-1-git-send-email-maxg@mellanox.com>
Message-ID: <20180413170624.GC23178@lst.de>

On Tue, Apr 10, 2018@08:18:04PM +0300, Max Gurtovoy wrote:
> I've noticed that there is no clear definition in the NVMe spec
> regarding the keep-alive mechanism association. IMO, it should be
> a property of the admin queue and should be triggered as soon as
> the admin queue configured successfuly.

It is a property of the controller, sent over the admin queue.
I'm not sure what else it could be, but if things are confusing
please reach out to the technical working group.

Note that we can only send NVMe command (rather than Fabrics commands)
when the controller is enabled.  Based on that I think that we need
to fix keep alive, but in a different way than in this series.

So instead of starting keep alive in nvme_start_ctrl we should
start in nvme_enable_ctrl, and similar on the stop side with
disable/shutdown.  On the target side we can also only start to
expect a a keep-alive once the controller has been enabled,
and need to stop expecting one once the controller has been disabled.
