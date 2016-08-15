From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 15 Aug 2016 09:47:29 -0600
Subject: [PATCH] nvme: Prevent controller state invalid transition
In-Reply-To: <1469819718-25511-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1469819718-25511-1-git-send-email-krisman@linux.vnet.ibm.com>
Message-ID: <7c16b20d-8721-ebd9-d7e1-894dd069fcf6@kernel.dk>

On 07/29/2016 01:15 PM, Gabriel Krisman Bertazi wrote:
> Acquiring the nvme_ctrl lock before reading ctrl->state in
> nvme_change_ctrl_state() should prevent a theoretical invalid state
> transition, in the event of two threads racing inside that function.
>
> I haven't been able to observe this happening with the current code, and
> the current state machine seems to be simple enough to not be
> affected by these invalid transitions, but future modifications could
> make it more likely to happen.

Applied, thanks.

-- 
Jens Axboe
