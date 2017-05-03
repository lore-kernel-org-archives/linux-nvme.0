From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 May 2017 10:59:40 +0300
Subject: [PATCH] nvme core: allow controller RESETTING to RECONNECTING
 transition
In-Reply-To: <20170502185458.3495-1-jsmart2021@gmail.com>
References: <20170502185458.3495-1-jsmart2021@gmail.com>
Message-ID: <fa1b98e7-9751-885e-a2b0-a1918779cf2a@grimberg.me>


> Allow controller state transition : RESETTING to RECONNECTING
>
> I intend to have the nvme_fc transport set the state to RESETTING when
> tearing down the current association (error or controller reset), then
> transitioning to RECONNECTING when attempting to establish a new
> association.

I'm not sure this is a good idea. I think that the semantics of
RESETTING state is that we are performing a controller reset,
RECONNECTING semantics means we are trying to reestablish our controller
session. It seems that mixing these states is just confusing.

In fact, I have a patch in the pipe that disallows the state transition
from RECONNECTING to RESETTING:

--
commit 210917a2a84fc8c19c37a899d5783bd0fcaaf1ac
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Sun Apr 30 12:35:44 2017 +0300

     nvme: Don't allow to reset a reconnecting controller

     The reset operation is guaranteed to fail for all scenarios
     but the esoteric case where in the last reconnect attempt
     concurrent with the reset we happen to successfully reconnect.

     We just deny initiating a reset if we are reconnecting.

     Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..cfc8f8da89c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -165,7 +165,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
                 switch (old_state) {
                 case NVME_CTRL_NEW:
                 case NVME_CTRL_LIVE:
-               case NVME_CTRL_RECONNECTING:
                         changed = true;
                         /* FALLTHRU */
                 default:
--
