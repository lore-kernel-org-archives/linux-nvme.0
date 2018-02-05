From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Feb 2018 16:46:07 +0200
Subject: [PATCH v3 0/3] Fix host side state machine
In-Reply-To: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
Message-ID: <9786ff4d-a95b-eb7e-9201-d23310f8182d@grimberg.me>


> Hi all,
> this series is rebased above nvme-4.16.
> Actually there is a still missing part in this tree (but I tested it on
> my own "stable" mixed kernel with this patch):
> "nvme-rdma: fix concurrent reset and reconnect" from Sagi.
> 
> The first motivation for this series was fixing RDMA initiator that crushes in
> case we fail during initial connect and start error recovery during initial
> connection establishment.
> This patchset also renames NVME_CTRL_RECONNECTING to NVME_CTRL_CONNECTING as
> this state doesn't represent only a reconnection flow but also used for
> initialization process.
> 
> The tested transport for these patches was RDMA.
> It will be appriciated if someone can run this series with real FC HW (to test
> patch #3).

The series looks fine to me.

I've picked it up, but I prefer to hear from Keith/Christoph before
adding it to the next pr round.
