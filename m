Return-Path: <SRS0=sDNq=MK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4D0C636CA
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:44:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD7C60C3F
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jul 2021 12:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD7C60C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MCUbvZ3+cx1Jfk3Fq0wsxTwHggdXxSquCtJFy02pBtc=; b=etlbLK7ZI1qT8Lj+npH1odp6jW
	Wr7MRibSAJyV44PkcFwJOvwYOTY2WfD6+0y8f1TyYp74SDOpgMo3Opm7AyzBZNyDCbYH3MMXXUh25
	0lFV6OFUhLDuTND21SloJLukFqHOFqv8kgO80LklB+D9FcV/OyFHTi37X/NRN+7oQ5DJN++lkWXxl
	s6IaBJfl7iJcoX0HZwoNK3GwD6eXEJl/4nyWVz+V+D2QQ5yGKRWqzgoSTBADgZy1AmjskZyqUmo3p
	MhyTLlbPixRp7iOD0HTA3+iZNTDsqrCqRwKtuo2smwGGBTjhpmQoER7uy7Bd6JkcF6NWxn/zF29Bd
	7UvcraDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m569z-007i5G-J6; Sun, 18 Jul 2021 12:44:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m569w-007i4f-Ch
 for linux-nvme@lists.infradead.org; Sun, 18 Jul 2021 12:44:41 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 256142014B;
 Sun, 18 Jul 2021 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626612279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGvSJCtE89wYB1aW87Os9l7E9zsyPETbtXOQsO+kQo8=;
 b=tYqfNE8cI9vnPeevBhf4CCG2wN+qtnDHkd3uNIcs2pnrzwpAYUp6MN10+XGAf+P8cwGmeH
 HnrZopVsZIBzxmS2vQ9aVHCgF3p1ZaKlsCZx3UjRmuL+vZBlW42H8mxjbwJx5I8iu7DYHo
 fvWDh3dZzSUmFTe1uFI6iAXNGqqGJfI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626612279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGvSJCtE89wYB1aW87Os9l7E9zsyPETbtXOQsO+kQo8=;
 b=y9gcQX8MLz6+z+PtthxS85whmNZJMTrfEWwzYBYRxVWX4YVZRX+B7EqqxIEQoTaqa5wZ4T
 Z9z017urunFGfiAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 0306913AD2;
 Sun, 18 Jul 2021 12:44:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 5jMTADci9GCUPgAAGKfGzw
 (envelope-from <hare@suse.de>); Sun, 18 Jul 2021 12:44:39 +0000
Subject: Re: [PATCH 11/11] nvme: add non-standard ECDH and curve25517
 algorithms
To: =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-12-hare@suse.de>
 <2097520.Z47m7augs3@positron.chronox.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <cea86e44-6e2b-46be-2005-e03db413fd2b@suse.de>
Date: Sun, 18 Jul 2021 14:44:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2097520.Z47m7augs3@positron.chronox.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210718_054440_627643_2E230B88 
X-CRM114-Status: GOOD (  10.84  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNy8xNy8yMSA2OjUwIFBNLCBTdGVwaGFuIE3DvGxsZXIgd3JvdGU6Cj4gQW0gRnJlaXRhZywg
MTYuIEp1bGkgMjAyMSwgMTM6MDQ6MjggQ0VTVCBzY2hyaWViIEhhbm5lcyBSZWluZWNrZToKPiAK
PiBIaSBIYW5uZXMsCj4gCj4+IFRMUyAxLjMgc3BlY2lmaWVzIEVDREggYW5kIGN1cnZlMjU1MTcg
aW4gYWRkaXRpb24gdG8gdGhlIEZGREhFCj4gCj4gY3VydmUyNTUxOT8KPiAKCk9mIGNvdXJzZS4K
CkNoZWVycywKCkhhbm5lcwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZSAgICAgICAgICAgICAgICBL
ZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwg
TWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCkhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwg
R2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
