From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 20 Dec 2017 16:35:39 +0900
Subject: [PATCH] nvme-cli: add BPS bit field to CAP controller register
In-Reply-To: <1513354326-9924-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1513354326-9924-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <CAA7jztchGA27O=osjx-wSmrDQ5P_M455yPq_k8pWW3b4brAckw@mail.gmail.com>

On Sat, Dec 16, 2017@1:12 AM, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> NVMe 1.3 spec introduced BPS(Boot Partition Support) bit field in CAP of
> controller register.
> Add this bit field to "struct nvme_bar_cap" by changing
> "css_nssrs_dstrd" field to "bps_css_nssrs_dstrd".
> Also add a print for BPS bit field to print CAP properly when show-regs
> command with human-readable.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>

Hi Keith,
Ping?
