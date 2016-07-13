From: mlin@kernel.org (Ming Lin)
Date: Wed, 13 Jul 2016 10:25:55 -0700
Subject: NVMe over RDMA latency
In-Reply-To: <CABgxfbEa077L6o-AxEqMr1WMuU-gC8_qc4VrrNs9nAkKLrysdw@mail.gmail.com>
References: <1467921342.24395.12.camel@ssi> <57860EBA.5010103@grimberg.me>
 <CABgxfbEa077L6o-AxEqMr1WMuU-gC8_qc4VrrNs9nAkKLrysdw@mail.gmail.com>
Message-ID: <CAF1ivSZV1h3y2KYjGxo3nba_Qpn-5nsN8SVmCW3Rafzc4tsH4Q@mail.gmail.com>

On Wed, Jul 13, 2016@10:22 AM, Wendy Cheng <s.wendy.cheng@gmail.com> wrote:

> 2) Could anyone pass the pointer on how to check whether a block device
> supports the polling mode (and how to turn it on) ?

Example:

echo 0 > /sys/block/nvme0n1/queue/io_poll
echo 1 > /sys/block/nvme0n1/queue/io_poll
