Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0BACCFA1A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 06:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zQjd5UDJFSg/xff5rUuTDqSiNcfvn5HB5xq/yjSaq5I=; b=q3rTBYToOhJovXvCtXBXRb2/RE
	mnPWZ+Fwls6n8oziyyFisZdX+cFm/3ZpsMKk4onaRS1BqGZZdASuKdwMssr49inxTuW1JavsJxm9s
	9BZJUPzuY+xMAYRJEaKXsx1caQXTm6bH0qXHaqlS3cvi+9P+lOwL7xzjCo4oHylmGkOiKS8h9sPzq
	lJG4BmfRTC2T+rj/Ktu2cXwk6hBBU/Vf0kZC9KgKZMPyOz7b6IGXdl9GQH959HZdXHcAFgnW0PxLy
	U5uzCwI8y44paXH3/DTNhFUhcIhmpallt6nJ+1zWns5ISDdWvov2r2n7Kjh7BlCHuXxwH14IYjkRb
	bpszGXUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4pL-00000008F39-43Mf;
	Wed, 12 Nov 2025 06:59:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJ4pG-00000008F2b-3kTl
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 06:59:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BE87227AA8; Wed, 12 Nov 2025 07:59:26 +0100 (CET)
Date: Wed, 12 Nov 2025 07:59:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
Message-ID: <20251112065925.GF4873@lst.de>
References: <20251112042720.3695972-1-alistair.francis@wdc.com> <20251112042720.3695972-6-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112042720.3695972-6-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_225933_126033_AD53B4E8 
X-CRM114-Status: GOOD (  15.47  )
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

On Wed, Nov 12, 2025 at 02:27:19PM +1000, alistair23@gmail.com wrote:
>  
>  		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>  		if (ret < 0) {
> +			/* If MSG_CTRUNC is set, it's a control message,
> +			 * so let's read the control message.
> +			 */

This is not the normal kernel comment style, which would be:

			/*
			 * If MSG_CTRUNC is set, it's a control message, so
			 * let's read the control message.
+			 */

> +			if (msg.msg_flags & MSG_CTRUNC) {
> +				memset(&msg, 0, sizeof(msg));
> +				msg.msg_flags = MSG_DONTWAIT;
> +				msg.msg_control = cbuf;
> +				msg.msg_controllen = sizeof(cbuf);
> +
> +				ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);

Overly long line.  Also given that we're in the main receive handler
it would be nice to have this outside the main flow using a goto and
an unlikely label anyway.


