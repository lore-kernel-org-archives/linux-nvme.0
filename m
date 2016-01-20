From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 20 Jan 2016 09:12:23 -0800
Subject: [PATH v2] NVMe: init nvme queue before enabling irq
In-Reply-To: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
References: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <20160120171223.GA28243@kroah.com>

On Wed, Jan 20, 2016@05:48:35AM -0500, Wenbo Wang wrote:
> From: Wenbo Wang <wenbo.wang at memblaze.com>
> 
> During reset process, the nvme_dev->bar (ioremapped) may change,
> so nvmeq->q_db shall be also updated by nvme_init_queue().
> 
> Currently nvmeq irq is enabled before queue init, so a spurious
> interrupt triggered nvme_process_cq may access nvmeq->q_db just
> before it is updated, this could cause kernel panic.
> 
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> ---
>  drivers/nvme/host/pci.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
