Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566A91093183
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FdFFLV14Faxe/kIuLbvgbXK9WITPtfvnewZyM+xZuwo=; b=YBJHlvBGntSBd2Qfo+wSC8vww0
	TlV5M7Jngh4prhBvh9ePqoFOFV4ezT3xgyvCdMBNpYtZ2sC4mFZMf5xJ9y85vIRjd0x4mmCfcj8US
	7PSgT7U0cs44wbtjt+m+dlT/dQUL3BdqrzW91UooehMGPVscbLMGKzzSGjGS5EyLPaBh8KHQ3lV9b
	0HTs3En9X5qhGVqxrGjTHJgNcpSWi4MzrfH0J4tXaEcE+KyQvty1Q0b61he/URlSEBi+wASA/dJwK
	VfBF64/+7Bk6XBtSeGcAj/ddrLXjthgY1mj8B8guPkgDIG7qvZRB9k9mK2M9iodyfZSvgYV+91PsU
	Z0KbvPsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Ug6-0000000CIGt-3E11;
	Fri, 20 Mar 2026 07:53:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Ug4-0000000CIGS-0mPB
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:53:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E26A6732A; Fri, 20 Mar 2026 08:53:48 +0100 (CET)
Date: Fri, 20 Mar 2026 08:53:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v7 5/5] nvmet-tcp: Support KeyUpdate
Message-ID: <20260320075348.GC14616@lst.de>
References: <20260304053500.590630-1-alistair.francis@wdc.com> <20260304053500.590630-6-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304053500.590630-6-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_005352_373512_5404ECCA 
X-CRM114-Status: GOOD (  14.91  )
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

>  static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue,
> +				   enum handshake_key_update_type keyupdate);
> +#endif

Can we find a way to just avoid the ifdefered here and just rely on
compiler dead code elimination?

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
> +{
> +	return ret == -EKEYEXPIRED &&
> +		queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +		queue->state != NVMET_TCP_Q_TLS_HANDSHAKE;
> +}
> +#else
> +static bool nvmet_tls_key_expired(struct nvmet_tcp_queue *queue, int ret)
> +{
> +	return false;
> +}
> +#endif

This is a pretty clear candidate for IS_ENABLED().

> +	spin_lock_bh(&queue->state_lock);
> +	if (queue->state == NVMET_TCP_Q_TLS_HANDSHAKE) {
> +		/* Socket closed during handshake */
> +		tls_handshake_cancel(queue->sock->sk);
> +	}
> +	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
> +		queue->state = NVMET_TCP_Q_DISCONNECTING;
> +		kref_put(&queue->kref, nvmet_tcp_release_queue);
> +	}

switch on the queue state?

> +	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);

Overly lone line.

>  		if (unlikely(ret < 0)) {
> +			if (nvmet_tls_key_expired(queue, ret))
> +					goto done;

This has extra indentation.


