From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 15 Aug 2016 10:17:25 -0500
Subject: [PATCH] nvme: Prevent controller state invalid transition
In-Reply-To: <1469819718-25511-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1469819718-25511-1-git-send-email-krisman@linux.vnet.ibm.com>
Message-ID: <01c801d1f708$20df28f0$629d7ad0$@opengridcomputing.com>

> 
> Acquiring the nvme_ctrl lock before reading ctrl->state in
> nvme_change_ctrl_state() should prevent a theoretical invalid state
> transition, in the event of two threads racing inside that function.
> 
> I haven't been able to observe this happening with the current code, and
> the current state machine seems to be simple enough to not be
> affected by these invalid transitions, but future modifications could
> make it more likely to happen.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>

Looks correct.

Reviewed-by: Steve Wise <swise at opengridcomputing.com>
