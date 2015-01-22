From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 14:22:25 +0000 (UTC)
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO command
 is being issued via a block device file descriptor
In-Reply-To: <CADMsRTZjajAj682a5FH-AmpphoQ4vw5QxqnJiGEQ+Jg_f7TvoA@mail.gmail.com>
References: <1421886503-25276-1-git-send-email-yan@purestorage.com>
 <alpine.LNX.2.00.1501220035170.15481@localhost.lm.intel.com>
 <CADMsRTZjajAj682a5FH-AmpphoQ4vw5QxqnJiGEQ+Jg_f7TvoA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1501221409080.15481@localhost.lm.intel.com>

On Wed, 21 Jan 2015, Yan Liu wrote:
> For IO passthrough command, it uses an IO queue associated with the device. Actually, this patch does not modify that part.
> This patch is not really focused on io queues; instead, it is more about namespace protection from other namespace's user ios. The patch here doesn't prevent a user?submitting completely arbitrary?commands on IO queues. One still can
> do it through a char dev file descriptor. However, when a user?explicitly chooses a namespace's file descriptor, it is unlikely that she/he tries to issue an io command to a different namespace. Maybe in that case someone should to
> use a new admin command.

Oh, I just realized your patch is not for the blk-mq version of this
driver. The mainline kernel uses blk-mq and is a little different in
this path. My mistake, you're right the command works the same as before
using the character device here. In that case, this seems very reasonable,
but doesn't merge upstream.
