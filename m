Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EA4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 08:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZniICb4GRMQaWlTpM8Zy+RtpqwJIOxkxULerivmeKsc=; b=m3W3JihbJKB3HmXSmK+S564DNn
	OY+QMp3kq320S0+x8af4LnEGiHx7gT2MuzqXXM1e2IrXt/tobO5Ejt1TC7rZUqwyHeHbPldWaN/ff
	BM8XZyZPmJ5JkJiFN3gv6bvaRFG0O4L+Mi5kvEZ+suDAIxoQgGE0vxegP2hh2bVBYioZzLXnglyqw
	ik4G55ffdxxudq0f/njMTYPGGn1jXnHL5Nk7SUFglw/lwVZgN5yLNWzB3Y6vaPDCO8Kr3BZEEkSsn
	J0gJlFTl5Z1fv6v+T6O5lXckW5jNJjGtD5wKP/QJeWF9BBmrnwuOL6phK7/GtLe7vLlwyci26/s4X
	SsUrpOyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEo8b-00BRpk-Re; Tue, 01 Feb 2022 08:03:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEo8Y-00BRp4-Ci
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 08:03:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B899E68AFE; Tue,  1 Feb 2022 09:03:35 +0100 (CET)
Date: Tue, 1 Feb 2022 09:03:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 1/4] nvme-tcp: fix a possible use-after-free in
 controller reset during load
Message-ID: <20220201080335.GB29518@lst.de>
References: <20220130092119.595854-1-sagi@grimberg.me>
 <20220130092119.595854-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220130092119.595854-2-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_000338_602858_925F96D8 
X-CRM114-Status: GOOD (  13.53  )
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

On Sun, Jan 30, 2022 at 11:21:16AM +0200, Sagi Grimberg wrote:
>  	struct nvme_tcp_cmd_pdu *pdu = ctrl->async_req.pdu;
>  	struct nvme_command *cmd = &pdu->cmd;
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
> +	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
> +
> +	if (ctrl->ctrl.state != NVME_CTRL_LIVE || !queue_ready)

Why do we need the local variable?

Also what prevents the controller or queue state to change just after
this check?

