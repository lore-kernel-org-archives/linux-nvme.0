From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Sep 2016 09:40:08 +0300
Subject: [PATCH WIP/RFC v3 3/6] nvme_rdma: keep a ref on the ctrl during
 delete/flush
In-Reply-To: <00b201d20394$15a0ab60$40e20220$@opengridcomputing.com>
References: <cover.1472574410.git.swise@opengridcomputing.com>
 <f3b74c6ef7caba2fdff194be0c90ec7423103893.1472574410.git.swise@opengridcomputing.com>
 <c749145e-618e-ef0c-4249-8f441c55e4b1@grimberg.me>
 <012001d202e6$aa27bbb0$fe773310$@opengridcomputing.com>
 <1bb868c7-2417-0853-ff35-77770a6557af@grimberg.me>
 <00b201d20394$15a0ab60$40e20220$@opengridcomputing.com>
Message-ID: <21c29ffe-e5c8-e16f-fd47-e23768c09e8a@grimberg.me>


> Oh. :)
>
> Does this fully avoid the race?
>
> @@ -1671,7 +1671,8 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
>          * Keep a reference until all work is flushed since
>          * __nvme_rdma_del_ctrl can free the ctrl mem
>          */
> -       kref_get(&ctrl->ctrl.kref);
> +       if (!kref_get_unless_zero(&ctrl->ctrl.kref))
> +               return -ENOMEM;

We shouldn't return -ENOMEM failure because we'll only get it if
someone else already deleted the controller, -EBUSY is more appropriate.
