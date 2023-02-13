Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F8EC636D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 10:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KPuO2OxMrxF2mjArnp245A5L2ydvAazDghhHafveqME=; b=PgBX/NAIi++sm7flzcuAKgstds
	jmKC/pgVk+9eg62kyuTUuB3nl48LM66uKjR8eQSYLClHxHDdNk8MEiBl94Q0A8Prp03CLwmXN2jLW
	OizVykhVYuWI97SQuwu383Fp0QWOmUZuZPCBHIJaxTf7yEvyyyu7HjHYxz78e3IfPTs2iJn4uGSmG
	luTr8QDOjtsdKmOyeRQH2gc/DD09ZZ5Yl6Gd2SqAetj0RKb1kFYofeB2i1IK7tPOvnijCLdpDq8lj
	z65Mec1DUeIIzXhrLj/E48h/ulhXHFVWn+ffVJ4VKH9OFOo+Odrrg/C/wkKRp7b2S2nZfKsXhZOvx
	Yk9KBwBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVpj-00E3Tj-BP; Mon, 13 Feb 2023 10:13:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRVpg-00E3Rx-5K
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 10:13:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B5391FDB8;
	Mon, 13 Feb 2023 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676283186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KPuO2OxMrxF2mjArnp245A5L2ydvAazDghhHafveqME=;
	b=VMFIEcUdTVpvrfCs7T4/y1EvECHW3B0qVC/s/BkpvmXcB73b7zjcWlY8wOWnwhgDHtafg1
	xGv5YQ/ncbWKiJDDv9maA4PuQQWpCo/j+Xr25u8qGve1gbZB35QD0p0S8KQoPAU/kFl+bK
	1sostywQ1aOhgnv3vpItWUSmcdkL1GE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676283186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KPuO2OxMrxF2mjArnp245A5L2ydvAazDghhHafveqME=;
	b=3lJBM12yQP1lzu/of8hmrqtpe/U6gpRaDEHKob007/c8RCwiBTM5US8OyGenWYwO1ajC66
	SR3CXnrwdzbeqkBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C72A138E6;
	Mon, 13 Feb 2023 10:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id yFBEIjIN6mPLcwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 13 Feb 2023 10:13:06 +0000
Date: Mon, 13 Feb 2023 11:13:05 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Ivan Rubinov <linuxkernelpatch8234@riseup.net>, kbusch@kernel.org,
	axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230213101305.fgs6ke2jyhj3j7q6@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <20230213060850.GB13968@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213060850.GB13968@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_021312_477884_0BCD578E 
X-CRM114-Status: GOOD (  10.21  )
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

On Mon, Feb 13, 2023 at 07:08:50AM +0100, Christoph Hellwig wrote:
> I've already applied a patch from Daniel Wagner for this device,
> but thanks for sending it in!

This patch also add NVME_QUIRK_IGNORE_DEV_SUBNQN. Is it necessary?

