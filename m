Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90726EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=; b=zcNmwOmpL9qAv7IbKUu9dA9V42
	SFIIqdzdnCaS6+XB0JwqNA5vb2AHklcdk+haWrsJWPCPQN8I9nqGg2p1xyA++UJsGr7WsHaoBPQn5
	JKOZwMDKGfv3VjG7TLbGRUR+wxLl/uWzVYK7QU0yfOnfy70rkbeqg8SDqP5j2jvI0cDz2nA28zRuO
	EEs+3cl8pLv02g/ZdtnOWfqX7iMeXwTgOl4XZ3WDCcE2beqa+tJeaEISnCOyZkTolwmizCtQoYTDg
	k/pCzn/uOeStihSqqxaCu5CoYI6YH2r9bL3td05NS00B8FRO1TeGeqQVhcgoM1tPBDatmLN2wRKLm
	J6ffQvCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIt6L-00C3By-1A;
	Mon, 10 Jul 2023 15:47:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIt6J-00C3BW-0c
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:47:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8508061089;
	Mon, 10 Jul 2023 15:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969F5C433C8;
	Mon, 10 Jul 2023 15:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689004018;
	bh=1cmxjMcfvrFVecoH9p5LC3mEGtFprhW9cvmWSFdwapk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ou1zV6X+ctbj2VRps+ge6CgFlQRO8MFi3o6vGGhoIzKE8bTFGcZTaVrlA6Sl1fM2v
	 PbxYb5Eho6dlFghIPUC7K8SeCHsuLjuSlGK8C5BS125V3pIvKWFT73fNitpD87at7h
	 xYltKZhEInAlqqP62Lv5RmeMDeii6Oh2vjyE1jxdLCyU7ZYB26t3JJodeSCjp6PxGr
	 GPkLXLboayTXIb7bw0mkmXv4G/6sAfWScYsVTImFAx97x2H7I/Na2aZKwx3sn3PSqV
	 52knnrXQiIXFcgadka90MXZi9NKZMbpDQGp7ZhzZRL4cOnJjFpt5DuSRhWLwVj/dWP
	 SmU7Lw+Pb8E+g==
Date: Mon, 10 Jul 2023 09:46:55 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: use PAGE_SECTORS_SHIFT
Message-ID: <ZKwn79c9xjGPT+3k@kbusch-mbp.dhcp.thefacebook.com>
References: <20230707003222.5854-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707003222.5854-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_084659_267287_26E68F9C 
X-CRM114-Status: UNSURE (   6.60  )
X-CRM114-Notice: Please train this message.
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

Applied, thanks!

