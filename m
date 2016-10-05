From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 5 Oct 2016 11:22:51 +0300
Subject: [PATCH 1/1] nvme : Add sysfs entry for NVMe CMBs when appropriate
In-Reply-To: <1475014513-18083-2-git-send-email-sbates@raithlin.com>
References: <1475014513-18083-1-git-send-email-sbates@raithlin.com>
 <1475014513-18083-2-git-send-email-sbates@raithlin.com>
Message-ID: <9d062df7-d895-4c21-ca0d-b4fc3cb878c1@grimberg.me>


> Add a sysfs attribute that contains salient information about the NVMe
> Controller Memory Buffer when one is present. For now, just display the
> information about the CMB available from the control registers. We attach
> the CMB attribute file to the existing nvme_ctrl sysfs group so it can
> handle the sysfs teardown.

Hey Stephen,

I'm wandering if placing this only for pci is correct. In theory, we
could have fabrics expose a cmb (while its usage is still somewhat
unknown at the moment).

Perhaps cmbloc/cmbsize should exist in ctrl and be queried by
->reg_read32() callout. In addition, we would need a new map_cmb()
callout in ctrl->ops.

Thoughts?
