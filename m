From: kbusch@kernel.org (Keith Busch)
Date: Wed, 8 May 2019 15:42:01 -0600
Subject: [RFC PATCH] nvme: guard ctrl->state by lock
In-Reply-To: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>
References: <20190508214128.20620-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190508214201.GB8365@localhost.localdomain>

On Wed, May 08, 2019@02:41:28PM -0700, Chaitanya Kulkarni wrote:
> This patch adds a helper function to check the nvme_ctrl state.
> This helper function uses controller lock when accessing ctrl->state
> member which is guarded in the nvme_change_ctrl_state().

Does this really fix anything though? None of the readers prevent a
state change after checking it.
