From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 12 May 2019 08:49:57 -0700
Subject: [RFC PATCH] nvme: guard ctrl->state by lock
In-Reply-To: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>
References: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>
Message-ID: <38a8743f-76c0-b83c-d362-9794b5d5896f@grimberg.me>


> This patch adds a helper function to check the nvme_ctrl state.
> This helper function uses controller lock when accessing ctrl->state
> member which is guarded in the nvme_change_ctrl_state().
> 
> This RFC is light on the details, if this change is acceptable I'd
> like to send the detailed tested version.
> 
As commented, the state read access is not safe by definition as
the action needs to be atomic with it as well. The code needs to
be able to handle the fact that its advisory only.

If there is a case that doesn't, then it should protect it specifically
so fast-path checks are not affected.
