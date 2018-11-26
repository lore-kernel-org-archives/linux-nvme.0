From: roland@purestorage.com (Roland Dreier)
Date: Mon, 26 Nov 2018 09:26:54 -0800
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async
 event data
In-Reply-To: <1543252659-22757-1-git-send-email-psajeepa@purestorage.com>
References: <1543252659-22757-1-git-send-email-psajeepa@purestorage.com>
Message-ID: <CAL1RGDWF4EnYhUxcy2wrG-bNb4b4=dBR9MGvrmYy_N+xBLro_Q@mail.gmail.com>

On Mon, Nov 26, 2018 at 9:18 AM Prabhath Sajeepa
<psajeepa@purestorage.com> wrote:
> Some error paths in configuration of admin queue free data buffer
> associated with async request SQE without resetting the data buffer
> pointer to NULL, This buffer is also freed up again if the controller
> is shutdown or reset.

Reviewed-by: Roland Dreier <roland at purestorage.com>
