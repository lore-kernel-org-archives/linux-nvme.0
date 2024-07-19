Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AB4C3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 05:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ruwlRkP6IuJggMlRGs72Zfxw2Fcqo6ND4CwUVY0cRg=; b=RGahSjbVV1N366MtDgEcnDkGmq
	HpbrTvilXDcSYFd4qZ5Yv4TLzLvwvobegcIKxT4/yP9LMZQMD0axhRIFUPC6YvjgCfMmE8SMETINp
	eME8874geQPizJvGLv9PObJ4bzWrqILuP0X+z4FJ8zMHQlAyCqc2r8VoToMxzhrEDK66PUwDmwXOh
	GUTxEb4vOC/SgusV/WYSB3QU0QZ3opExc4gsnAEnoSnkVAvuw+8fbPItRgA/sl0b6WqIZh95oMFlE
	zDMu8PkFLdmq6aMAWCoT613LoftmhqB3CmEkZmA7dSwayQp/TthLXOqzUa10DeEyV2gQBpAnO+YZD
	lhV3decQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgIk-00000001ezm-16Rb;
	Fri, 19 Jul 2024 05:37:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUgIh-00000001eyq-2wsI
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 05:37:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEFA468BFE; Fri, 19 Jul 2024 07:37:00 +0200 (CEST)
Date: Fri, 19 Jul 2024 07:37:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] nvme-tcp: check for invalidated or revoked key
Message-ID: <20240719053700.GA21604@lst.de>
References: <20240718144858.19074-1-hare@kernel.org> <20240718144858.19074-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718144858.19074-4-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_223703_905874_CFD4E500 
X-CRM114-Status: GOOD (  10.18  )
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

> +	return (test_bit(KEY_FLAG_REVOKED, &psk->flags) ||
> +		test_bit(KEY_FLAG_INVALIDATED, &psk->flags));

No need for the outer braces.

> +struct key *nvme_tls_key_lookup(key_serial_t key_id)
> +{
> +	struct key *key = key_lookup(key_id);

Empty line after variable declarations, please.

> +static inline struct key *nvme_tls_key_lookup(key_serial_t key_id) { return ERR_PTR(-ENOTSUPP); }

Please avoid the overly lone line.


