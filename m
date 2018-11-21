From: roland@purestorage.com (Roland Dreier)
Date: Tue, 20 Nov 2018 17:57:36 -0800
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async
 event data
In-Reply-To: <CAE=VkfB4G8PFZuNihQR0fei9BSr5ayqOrMWjFq9Xo5anQNgk7w@mail.gmail.com>
References: <1542744673-28129-1-git-send-email-psajeepa@purestorage.com>
 <CAL1RGDXrdn1krOyoVMVuRRuuAv8HSNHMusuwq2Evg9fDCGJN8A@mail.gmail.com>
 <47965bbe-ef63-eb54-60e3-b2662ae82e8f@grimberg.me>
 <CAE=VkfB4G8PFZuNihQR0fei9BSr5ayqOrMWjFq9Xo5anQNgk7w@mail.gmail.com>
Message-ID: <CAL1RGDXXKvg+n-QfMZoHp8By81seMW7YatQ0RXD3JnAe_eFDXg@mail.gmail.com>

On Tue, Nov 20, 2018 at 5:45 PM Prabhath Sajeepa
<psajeepa@purestorage.com> wrote:

> So, Does it make sense to set
> qe->data = NULL immediately after kfree(qe->data) in nvme_rdma_free_qe() ?

I thought about suggesting that; I have no objection although most
calls of free_qe are in nvme_rdma_free_ring() where we free the
containing structure immediately after.

However that doesn't fix the bug I spotted where alloc_qe fails the
DMA mapping, because we don't call free_qe in that path.  I think we
should set qe->data to NULL in alloc_qe when the DMA mapping fails, or
else the caller needs to know that alloc_qe can return an error but
leave a non-NULL pointer in qe->data.

 - R.
