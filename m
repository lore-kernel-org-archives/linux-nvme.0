Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D8BCCA476
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 09:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXkEgRJ7VOgVOUpd4r/73LrVgNsOSE4mgMUamvQW218=; b=kosWyWK6BRJPsJIbjb/1v8CZfs
	fmErqteLtQTwFFU6Mak7LhQowk5UIs+HLgIumWMnCMG2QYbAn2Y4e307fZuo1EB2h+BYi45dc7m3s
	yytkCB5sMg9KFwIejqvE/ywqG4GV2ecqPB9dwvG9cCabmd3dBd9NlPUE5JSUUSmeljHHYK2VXeHZu
	lrY3dHi0o9KczXziGiHecb980RPYqAg7x0DNKGPzbVEAgO5rkvKewKhoHzayAAZ6SWG1kJuyFu4Gy
	YTswm1jvoPeo9c3WOGtcDRv8ZjkBhhVJr/0VpW39O1Bfd2lVlmwQ0z73h5jsNZFY6J/ano99qWJwL
	vUSjEeGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cUv-0000000BzX6-2QaC;
	Fri, 03 Oct 2025 09:54:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4cUs-0000000BzWQ-1yOW
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 09:54:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2102F227AAC; Fri,  3 Oct 2025 11:54:34 +0200 (CEST)
Date: Fri, 3 Oct 2025 11:54:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, hare@suse.de,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 7/8] nvmet-tcp: Support KeyUpdate
Message-ID: <20251003095434.GB15497@lst.de>
References: <20251003043140.1341958-1-alistair.francis@wdc.com> <20251003043140.1341958-8-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003043140.1341958-8-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_025442_652991_099EEC9D 
X-CRM114-Status: GOOD (  16.81  )
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

On Fri, Oct 03, 2025 at 02:31:38PM +1000, alistair23@gmail.com wrote:
> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue);
> +static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w);
> +#endif

Can we find a way to structure the code to do without forward declarations
and either without ifdefs or with stubs when you need them?

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED &&
> +				queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}

Wrong indentation and superflous braces here.

> +	ret = nvmet_tcp_tls_handshake(queue, HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = wait_for_completion_interruptible_timeout(&queue->tls_complete, 10 * HZ);

Please avoid the overly long lines.

> +
> +	if (ret <= 0) {
> +		tls_handshake_cancel(queue->sock->sk);
> +		return ret;
> +	}
> +
> +	queue->state = NVMET_TCP_Q_LIVE;
> +
> +	return ret;

This should be a unconditional ret 0, or am I missing something?

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED &&
> +				queue->state != NVMET_TCP_Q_DISCONNECTING &&
> +				queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
> +					goto done;
> +			}

Same as above.  And given that we have multiple instances of this
check I suspect we want a little helper for it.

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +#endif
> +				return;
> +		}

If you provide a proper stub for update_tls_keys this becomes much
saner:

		if (ret != -EKEYEXPIRED)
			return;
		update_tls_keys(queue);

> +#ifdef CONFIG_NVME_TARGET_TCP_TLS
> +			if (ret == -EKEYEXPIRED)
> +				update_tls_keys(queue);
> +			else
> +#endif
> +				return;

Same here.


