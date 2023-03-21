Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE31C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9GdfrWTrc4C7fSAmNpCfRVoTRsp/WdwpgbN+cHPoM2k=; b=M+URNPTjd3pH/ITqgzDRVdqnrn
	o3U4EjoMs9EHEQ/Vz2AWC61/4Y333bjO+ZeyBiLen3roH0yi7VXzRH6ez70dBTVMF5zPvNeMRpFW3
	O1Cify2E+xLV4eeNMFcg3tNrNR6sbHxkDF7rPhLgLqyR7p+oQB7x6iFvSK9fsa0YmgG6qqTKyh1eJ
	2k7Wg626RYKiaahM20NSXfvFqoO9IDtaqn8DpDNdhdrMN6IHWasijAA5idTFo6TMAQ3snTIJTBy+W
	/ZnhkdMp8qg4urqNJH1B2rqIOvY3ojT29DQSilw15KWhmVOHGsdcN5DK5Sb8BWtwHlWWGKK/KVHT5
	76BJpoNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebIj-00CMt7-25;
	Tue, 21 Mar 2023 12:41:17 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebIg-00CMql-27
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:41:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 49B3021D70;
	Tue, 21 Mar 2023 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9GdfrWTrc4C7fSAmNpCfRVoTRsp/WdwpgbN+cHPoM2k=;
	b=WN5i5/AZIKkjy96yCqv6i49uvUSUnbozUO5MgkbgLLQbwAs9PKbIbE5p3NODlumE7DyZLN
	sNPfSvDWRcbflYzyarZUlMxYUCDjjlVecw+RId4uub0rDpVthiuWY+Ay4LZHXE/HYXHZ+w
	etw4eTCTcmL/BjMvTwdGbVM12Ob/DNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9GdfrWTrc4C7fSAmNpCfRVoTRsp/WdwpgbN+cHPoM2k=;
	b=g8A1VT9LrVAqkGYFh96VvyHIUFrpso0PoAlJgCN6jv7QJa7Y55+MZhR7iMmU9LBsIrm3Bf
	qlgtrJ2E6uuSJGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3543313440;
	Tue, 21 Mar 2023 12:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gej1DOWlGWT2XQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 12:41:09 +0000
Date: Tue, 21 Mar 2023 13:41:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321124108.6tehgwwntu7cg74c@carbon>
References: <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <20230321104009.nltadi6zs6iz66h4@carbon>
 <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
 <20230321110645.ruxzlw5egzikagnw@carbon>
 <b6b14ada-e004-8dec-5ed4-2c188ba7a9ad@grimberg.me>
 <0be807ea-8d44-f124-bffd-8abfcf046492@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be807ea-8d44-f124-bffd-8abfcf046492@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054114_837703_49661FDF 
X-CRM114-Status: GOOD (  12.93  )
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

On Tue, Mar 21, 2023 at 01:14:11PM +0200, Sagi Grimberg wrote:
> 
> > > > That is not a crash, but a WARN stack dump.
> > > 
> > > Not sure how you get to this conclusion.
> 
> bool blk_rq_is_poll(struct request *rq)
> {
>         if (!rq->mq_hctx)
>                 return false;
>         if (rq->mq_hctx->type != HCTX_TYPE_POLL)
>                 return false;
>         if (WARN_ON_ONCE(!rq->bio)) // this is the stack dump
>                 return false;
>         return true;
> }

This should trigger if rq->bio is NULL, no? Though the rq->bio
pointer is not NULL in my trace:

[   53.669844] rq ffff888106c40000 mq_hctx ffff888106247800 type 2 bio ffff88810da4e100

And I thought the would be a WARN or something simimilar, but that
might have changed and I didn't noticed.

Sorry for being so daft.

