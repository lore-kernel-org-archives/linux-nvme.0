Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19430CD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 19:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QSMMfEPFHek8pZ9CbVMlJ3mr2ELej7XZeoLYlBEmfF0=; b=pDp3wDOxQQZarXwbDJvBMucKrx
	uYUe2ROYFCi0Pq9Ks6KH1APyoebC7VdCP9SnIN6kHHVJsB9rD57X0Q6HRImAk+rOiA7OPVLycFOxP
	j9Uq/OI4RNmSiIl8/XpGBxwr457tqCAsq9LTbIRnpp1isK+muaMCRkDwk1BQ65eO8olZdv82BArYU
	dAPLZ7IPTP80ntHs2HpBp113tsKmQx5nuoZ8bTJ3NTwrMFZv3KKIjOEJLwbTafrmmE7OaDQ2+B6XX
	8dw0zUysh5QJmI11B1WhQjDvalJGrYzaY4Xm7bS8RgNnFuUVEfzKwBwBC/vs8/pfisB8McQvyxpZt
	7h5v3APQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQVbu-0000000BmkS-1qD9;
	Fri, 22 May 2026 19:32:42 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQVbt-0000000BmkK-3gaT
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 19:32:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C17FD60136;
	Fri, 22 May 2026 19:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045EC1F000E9;
	Fri, 22 May 2026 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779478360;
	bh=QSMMfEPFHek8pZ9CbVMlJ3mr2ELej7XZeoLYlBEmfF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AGRrKuchx3Su9jRdDyO1g7F4wpXSRoSf+fevwvbLQ2aZjdgjxYOs3E6A3wEi15Gwd
	 0GBOb7i323SbeIWj7MNHkg+zQh5PbKK0JTSES4pJi+Oav4SQwSdWzmuErOiG8BB5+J
	 x/D+PnNlKqQYymvmwuJGSUOPIvKeqwEniTw9SECX+t7+buVqCpvaEbSbYhf/FdE2YU
	 jMnPUHIBNPToT/PK0X9VBk/KyIM6CCCSqrQvZSZ2k94zMQdDEkkXRJMH1GXK/F53sf
	 7b06IesJc6pFE2vSTZlsgLl/oaNY1N+uIj/dYDK/Xyd7uDIoyRD8KqG/L0k4TTmbau
	 I5x2jhjwwfs2A==
Date: Fri, 22 May 2026 13:32:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v4] nvme: reject keep-alive passthrough on non-fabrics
Message-ID: <ahCvVhKxRLRPWscH@kbusch-mbp>
References: <20260522162639.395802-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522162639.395802-1-coshi036@gmail.com>
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

On Fri, May 22, 2026 at 12:26:39PM -0400, Chao Shi wrote:
> +/*
> + * Some Set Features commands change controller behaviour that the driver is
> + * not prepared to handle on every transport.  Reject such commands from
> + * userspace passthrough rather than letting them put the controller into a
> + * state the driver cannot deal with.  The list can be extended as other
> + * problematic features are identified.
> + */
> +static bool nvme_passthru_cmd_allowed(struct nvme_ctrl *ctrl,
> +				      struct nvme_ns *ns,
> +				      struct nvme_command *c)
> +{
> +	/*
> +	 * This only filters admin commands (ns == NULL).  I/O commands share
> +	 * the opcode space with admin commands - Dataset Management is 0x09,
> +	 * the same value as Set Features - so they must not be inspected here.
> +	 */
> +	if (ns || c->common.opcode != nvme_admin_set_features)
> +		return true;
> +
> +	switch (le32_to_cpu(c->common.cdw10) & 0xff) {
> +	case NVME_FEAT_KATO:
> +		/*
> +		 * Keep Alive is optional on PCIe (NVMe 2.0a 5.27.1.12) and the
> +		 * driver only arms keep-alive for fabrics.  Enabling it on
> +		 * other transports starts a keep-alive command the driver is
> +		 * not set up for and harms idle power states, so reject it.
> +		 */
> +		return ctrl->ops->flags & NVME_F_FABRICS;
> +	default:
> +		return true;
> +	}
> +}

This doesn't need to be its own function. You can add these checks to
the existing nvme_cmd_allowed():

---
@@ -50,6 +53,18 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
                        case NVME_ID_CNS_CTRL:
                                return true;
                        }
+		} else if (c->common.opcode == nvme_admin_set_features) {
+			switch (cpu_to_le32(c->features.fid) & 0xff) {
+			case NVME_FEAT_KATO:
+				if (ctrl->ops->flags & NVME_F_FABRICS)
+					break;
+				fallthrough;
+			case NVME_FEAT_HOST_BEHAVIOR:
+			case NVME_FEAT_HOST_MEM_BUF:
+			case NVME_FEAT_NUM_QUEUES:
+			case NVME_FEAT_AUTO_PST:
+				return false;
+			}
                }
                goto admin;
        }
--

