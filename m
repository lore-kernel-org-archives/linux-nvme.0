Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A189CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NTzFF+RQDR3/2d2V/k+K17mO0idQ3ASZIvfP8RXP6uk=; b=eDXIgs76pBECmVbZF563QkdIPK
	vM9Xmw3Zuucz70JazaQrQgilVGnDIcCWXso0kVgisEM3NXQ4RWORpi2YXMd/H2D+TW1IxdJMzmDbe
	g1/HMAWnlfO3oRPiQLyR6gT7q24x4t5j2QIcic6mR5udumdbemuvhyiibBiqAE0zX9CPrsKdvCQXc
	Sw/eehMGBExJ5taxZSNClMYIzIRdyMsdKHAHcEU+ucdqhJnYURcrIaV2ESbzGhb2AEoJ/+VcdtSZq
	1HOpGa2vsmIxpDb/9wJqwrf8a1IeHlzJKB6Uzi1C1SauBLjkths4X2cuTZOXYeM4uKQocX7c4rQJ6
	aBZZ5m2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF47-00000004HCI-0rJ8;
	Wed, 27 May 2026 14:16:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF44-00000004HBk-07GD
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:16:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8544A68B05; Wed, 27 May 2026 16:16:49 +0200 (CEST)
Date: Wed, 27 May 2026 16:16:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v5] nvme: reject passthrough of driver-managed Set
 Features
Message-ID: <20260527141648.GA13404@lst.de>
References: <20260523225629.3964037-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523225629.3964037-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_071656_354931_E661A208 
X-CRM114-Status: GOOD (  35.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, May 23, 2026 at 06:56:29PM -0400, Chao Shi wrote:
> Since commit b58da2d270db ("nvme: update keep alive interval when kato
> is modified"), userspace can start keep-alive on any transport via a
> Set Features (KATO) passthrough command. nvme_keep_alive_work() then
> allocates with BLK_MQ_REQ_RESERVED, but nvme_alloc_admin_tag_set()
> only reserves admin tags for fabrics, so the allocation trips
> WARN_ON_ONCE() in blk_mq_get_tag() and fails:
> 
>   nvme nvme0: keep-alive failed: -11
> 
> More generally, several Set Features change controller state that the
> driver manages itself and cannot react to correctly when set behind
> its back from userspace. Reject these in nvme_cmd_allowed():
> 
>   - KATO on non-fabrics (keep-alive is only armed for fabrics; on PCIe
>     it has no reserved tag and an active keep-alive harms idle power
>     states)
>   - Host Behavior Support, Host Memory Buffer, Number of Queues, and
>     Autonomous Power State Transition (all driver-managed)
> 
> Keep Alive on fabrics is unchanged. I/O commands are unaffected as the
> check is confined to the admin path (ns == NULL).
> 
> Link: https://lore.kernel.org/linux-nvme/20260522162639.395802-1-coshi036@gmail.com/
> 
> Fixes: b58da2d270db ("nvme: update keep alive interval when kato is modified")
> 
> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).
> 
> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>
> ---
> 
> Reproducer for the keep-alive case (run as root on a PCIe NVMe device):
> 
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <string.h>
>     #include <sys/ioctl.h>
>     #include <linux/nvme_ioctl.h>
> 
>     int main(void)
>     {
>             struct nvme_admin_cmd cmd = {0};
>             int fd = open("/dev/nvme0", O_RDWR);
>             if (fd < 0) { perror("open"); return 1; }
>             cmd.opcode = 0x09;       /* SET_FEATURES */
>             cmd.cdw10  = 0x0f;       /* Feature ID: KATO */
>             cmd.cdw11  = 5;          /* KATO = 5 seconds */
>             if (ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd) < 0) {
>                     perror("ioctl");
>                     return 1;
>             }
>             return 0;
>     }
> 
> On an unpatched kernel, within ~kato/2 seconds after the program exits,
> dmesg shows:
> 
>     nvme nvme0: keep alive interval updated from 0 ms to 5000 ms
>     WARNING: CPU: 0 PID: ... at block/blk-mq-tag.c:148 blk_mq_get_tag+...
>     nvme nvme0: keep-alive failed: -11
> 
> With this patch the ioctl fails with EACCES on non-fabrics.
> 
> Changes since v4:
> - Fold the check into the existing nvme_cmd_allowed() instead of a
>   separate helper, and reject additional driver-managed Set Features
>   (Host Behavior, Host Memory Buffer, Number of Queues, Autonomous
>   Power State Transition) in the same switch (Keith Busch). The admin
>   vs I/O distinction is now structural: the switch lives in the
>   ns == NULL branch, so I/O commands (e.g. Dataset Management, which
>   shares opcode 0x09 with Set Features) are never inspected.
> 
> Changes since v3:
> - Only inspect admin commands so a DSM I/O command is not wrongly
>   rejected (Keith Busch).
> 
> Changes since v2:
> - Reject the KATO passthrough on non-fabrics instead of reserving an
>   admin tag for all transports (Keith Busch, Christoph Hellwig).
> 
> Changes since v1:
> - v2 added a spec citation and quirk discussion, superseded by the
>   reject approach.
> 
>  drivers/nvme/host/ioctl.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index a9c097dacad6..31784506e845 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -14,8 +14,9 @@ enum {
>  	NVME_IOCTL_PARTITION	= (1 << 1),
>  };
>  
> -static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
> -		unsigned int flags, bool open_for_write)
> +static bool nvme_cmd_allowed(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> +			     struct nvme_command *c, unsigned int flags,
> +			     bool open_for_write)
>  {
>  	u32 effects;
>  
> @@ -50,6 +51,26 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
>  			case NVME_ID_CNS_CTRL:
>  				return true;
>  			}
> +		} else if (c->common.opcode == nvme_admin_set_features) {
> +			/*
> +			 * Reject Set Features that change controller state the
> +			 * driver manages itself; setting them behind the driver's
> +			 * back from userspace leaves it unable to react correctly.

Overly long lines.  I suspect we're best off splitting out the
admin and ns-command set specific parts of nvme_cmd_allowed into
separate helpers.  And maybe use a switch statement on the command
as nested ifs become cumersome in the long run.

> -	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
> +	if (!nvme_cmd_allowed(ctrl, ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))

Another overly long line here.

Otherwise this looks good.

