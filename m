From: malakar.atul5070@gmail.com (Atul Malakar)
Date: Mon, 7 May 2018 20:50:53 +0530
Subject: Need help to understand error messages from nvmet_rdma_send_done
Message-ID: <CABhaTPzPaTkvQg-v9OgmPSGuWucwBeyNJsjvy4weR7nL_kX2PA@mail.gmail.com>

Hi All,

We are developing a windows application to connect and send I/Os to
Linux RDMA target in kernel 4.16.3.

When we are sending 128KB read commands using 8 threads with 4
outstanding I/Os each, in the "nvmet_rdma_send_done" routine the
wc->status has value "IB_WC_WR_FLUSH_ERR" and "IB_WC_RETRY_EXC_ERR".

Most of the cases it is "IB_WC_WR_FLUSH_ERR" and in some cases it is
"IB_WC_RETRY_EXC_ERR". We have no idea which module and for what
reason these values are set.

Can anybody let us know from where these error is coming?

Thanks,
Atul
