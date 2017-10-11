From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:11:26 +0300
Subject: [PATCH 2/4] nvmet: Fix error flow in nvmet_alloc_ctrl()
In-Reply-To: <1507635633-16665-3-git-send-email-israelr@mellanox.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
 <1507635633-16665-3-git-send-email-israelr@mellanox.com>
Message-ID: <3378b1a9-2dd8-0768-d691-51543d588a4c@grimberg.me>

Israel,

> Also rearrange nvmet_ctrl_free().

It would be better to separate into two patches.
In the nvmet_ctrl_free() patch, please explain
why is the rearrangement needed.
