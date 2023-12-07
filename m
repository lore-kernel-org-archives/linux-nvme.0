Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C076C10F04
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qBi1TekSRtm5ic47GzMmMdwpuilnYjzd3dhSaXWmsz0=; b=1mgXtNohp2KcKApVxU8E/zmSYG
	iraoIrgiu9yiiJwsl4sXQ3kgAp9yx3qGLFtnXO8NaVQQiwEYo676PO8WzOS9/I9umgybJS+t+RVAp
	uWEcUNTKNOFF8bOHiGszYmaxaYUy+/gFFqGZmXbBE/IRH4VZ4PeqN0SS6WtN+wuJgLBPC31w2/hdm
	UjCTRMIZEjpA+ATzIBB39d4It3ZwwjfXko30xBr4mPtwnTKwe+qQCZN7sOdzDasMXrvoqfBFGjp7+
	aKfjWdIdOGx8eVlSkGweNjqQez+uohZAVjRIElGBKXZ7vXlzGuGQKjAwQ+cIJwUP1QR8dl2tGtx40
	m3jeCguA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDho-00CpJO-2B;
	Thu, 07 Dec 2023 12:42:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDhl-00CpIe-31
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 12:42:15 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 401E321CC0;
	Thu,  7 Dec 2023 12:42:12 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D539139E3;
	Thu,  7 Dec 2023 12:42:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +L+fCaS9cWXfBAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 07 Dec 2023 12:42:12 +0000
Date: Thu, 7 Dec 2023 13:42:11 +0100
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 3/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <hryojvgqgmhie6s3ykr6242bqybb2hnzfiywwaij4cmennvb6r@xs5ibnslvhg5>
References: <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207123624.29959-4-dwagner@suse.de>
X-Spamd-Bar: +++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [13.37 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.42)[78.19%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Rspamd-Queue-Id: 401E321CC0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_044214_119967_81A0A947 
X-CRM114-Status: GOOD (  10.95  )
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

On Thu, Dec 07, 2023 at 01:36:23PM +0100, Daniel Wagner wrote:
> +static int ns_head_update_nuse(struct nvme_ns_head *head)
> +{
> +	struct nvme_id_ns *id;
> +	struct nvme_ns *ns;
> +	int srcu_idx, ret = -EWOULDBLOCK;
> +
> +	/* Avoid issuing commands too often by rate limiting the update */
> +	if (!__ratelimit(&head->rs_nuse))
> +		return 0;
> +
> +	pr_info("%s: head %p\n", __func__, head);

Forgot to remove this debug print.

> +static int ns_update_nuse(struct nvme_ns *ns)
> +{
> +	struct nvme_id_ns *id;
> +	int ret;
> +
> +	/* Avoid issuing commands too often by rate limiting the update. */
> +	if (!__ratelimit(&ns->head->rs_nuse))
> +		return 0;
> +
> +	pr_info("%s: ns %p\n", __func__, ns);

ditto

