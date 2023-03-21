Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3935EC74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k2U9iRcrk66NNxgnyMe9jI/rzDFE990iNpPlhfeBk58=; b=3qHrzMBYd7feYfkG8+mozTbAu9
	t3l75j34RHNjHaVzaBHQCNqtPvhjUTzuqrWa5MHj0H/7P4AVJTfJsZZ/cK83xFktfa3Pry6U62TMn
	tcNt0M9umJfx0u+rv5E3ijTtnH1vb7Ed6dVjOArwSv3cbyTAGN9LixrMTG4xQTUcXW//yGD+pAlj+
	RY+yw7AgsM4U8x9jY46gI2LiypZ1iCBJQEyiM1PhTPTynfXZaEfPmNHMybjwcoEKWn0NRwghadTfk
	/g+hTB/61TOPJ05RokZJ/YNnito/saL5vxAPjHk+iIEjY8cxI2OohZEqbDwD0bYqn5O0mDwVGo8py
	jZbFfojA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebZg-00CRYy-0u;
	Tue, 21 Mar 2023 12:58:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebZc-00CRY7-2j
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:58:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 435452001F;
	Tue, 21 Mar 2023 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679403523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2U9iRcrk66NNxgnyMe9jI/rzDFE990iNpPlhfeBk58=;
	b=HAEuEo9Gx+8J0lPOX6zOqOwVyRQsmd8rrbfrvNyNuRPH1mJoR3bUwHZltruvvE3GOLAFsr
	qSwzCGd9xnDqt8942YcO/OKZso5ZH1F/rgzaYQrqgVsZHVkRR+kpL94FQO7a3eKkJ3ngG6
	ug3nDyeJ5HL7Yd9REcXmru1FWeWM7L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679403523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2U9iRcrk66NNxgnyMe9jI/rzDFE990iNpPlhfeBk58=;
	b=neHRW38i+130EkpEjMxSf13YJt4Unk4wxezl55ySn3sppHnDuGMic+y9Q9PASrPPtQ9Hq6
	UATUcojsnzc+xOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 356D713440;
	Tue, 21 Mar 2023 12:58:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4/MFDQOqGWR7dwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 12:58:43 +0000
Date: Tue, 21 Mar 2023 13:58:42 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321125842.b77iskzsq56lstpf@carbon>
References: <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <20230321104009.nltadi6zs6iz66h4@carbon>
 <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
 <20230321110645.ruxzlw5egzikagnw@carbon>
 <b6b14ada-e004-8dec-5ed4-2c188ba7a9ad@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6b14ada-e004-8dec-5ed4-2c188ba7a9ad@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_055845_046987_8FAD7160 
X-CRM114-Status: UNSURE (   9.44  )
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

On Tue, Mar 21, 2023 at 01:10:51PM +0200, Sagi Grimberg wrote:
> Can you verify that you never see a bio-less requests is being polled?

As far I can tell this is not happening anymore. I could trigger just by
doing a

   nvme connect-all -P 2

I've added my annotation again and don't see the combination of

  hxct type = 2 && bio == 0

anymore:

[  503.353236] nvme nvme1: creating 12 I/O queues.
[  503.366038] nvme nvme1: mapped 2/8/2 default/read/poll queues.
[  503.370816] nvme nvme1: q ffff888106944580 rq ffff888140090000 bio ffff88810d1c5e00
[  503.372115] rq ffff888140090000 mq_hctx ffff888104e87000 type 0 bio ffff88810d1c5e00
[  503.372977] nvme nvme1: q ffff888106944580 rq ffff888121820000 bio ffff88810d1c4800
[  503.375439] rq ffff888121820000 mq_hctx ffff888104e80800 type 0 bio ffff88810d1c4800
[  503.376712] nvme nvme1: q ffff888106944580 rq ffff888128790000 bio ffff8881ec613100
[  503.379097] rq ffff888128790000 mq_hctx ffff888104e82000 type 1 bio ffff8881ec613100
[  503.380127] nvme nvme1: q ffff888106944580 rq ffff888129870000 bio ffff8881243c6c00
[  503.382560] rq ffff888129870000 mq_hctx ffff888104e84000 type 1 bio ffff8881243c6c00
[  503.383833] nvme nvme1: q ffff888106944580 rq ffff888105910000 bio ffff8881243c7d00
[  503.383889] rq ffff888105910000 mq_hctx ffff888104e82800 type 1 bio ffff8881243c7d00
[  503.386522] nvme nvme1: q ffff888106944580 rq ffff888104350000 bio ffff8881243c6600
[  503.389771] rq ffff888104350000 mq_hctx ffff888104e83800 type 1 bio ffff8881243c6600
[  503.390783] nvme nvme1: q ffff888106944580 rq ffff888107610000 bio ffff8881243c7c00
[  503.393617] rq ffff888107610000 mq_hctx ffff888104e86000 type 1 bio ffff8881243c7c00
[  503.394612] nvme nvme1: q ffff888106944580 rq ffff888104280000 bio ffff8881243c6200
[  503.397470] rq ffff888104280000 mq_hctx ffff888104e81800 type 1 bio ffff8881243c6200
[  503.398530] nvme nvme1: q ffff888106944580 rq ffff888113e30000 bio ffff8881243c7000
[  503.401462] rq ffff888113e30000 mq_hctx ffff888104e84800 type 1 bio ffff8881243c7000
[  503.402353] nvme nvme1: q ffff888106944580 rq ffff888128940000 bio ffff8881243c7800
[  503.405161] rq ffff888128940000 mq_hctx ffff888104e86800 type 1 bio ffff8881243c7800
[  503.406433] nvme nvme1: q ffff888106944580 rq ffff8881070c0000 bio ffff8881243c7200
[  503.409353] rq ffff8881070c0000 mq_hctx ffff888104e85800 type 2 bio ffff8881243c7200
[  503.410438] nvme nvme1: q ffff888106944580 rq ffff888112210000 bio ffff8881243c7700
[  503.413271] rq ffff888112210000 mq_hctx ffff888104e87800 type 2 bio ffff8881243c7700
[  503.414505] nvme nvme1: q ffff888106e84e30 rq ffff888105fc1400 bio 0000000000000000
[  503.417447] rq ffff888105fc1400 mq_hctx ffff8881417c4800 type 0 bio 0000000000000000
[  503.418401] nvme nvme1: q ffff888106e84e30 rq ffff888105fc1000 bio ffff888111242000
[  503.418410] nvme nvme1: new ctrl: NQN "nqn.io-1", addr 10.161.60.136:4420

