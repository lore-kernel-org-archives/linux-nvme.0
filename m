Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C75C2B9F8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C4B61417
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C4B61417
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q97iWVLejotAC5w9/5IamDWDy5ZzRZFL24kEHGFOgT0=; b=Cha7ixdHscJsB5XBqO0KKvZzOo
	TZfIhAOdldB77qgKioHza2TJKBL7B+yhqfsl5Fq1bnYDncfC/QfFXGuOL6brn1B9cg7ANWoCp0wNs
	7pzQcvGLe7rE++H0suDfqWBbtjo4on3BtO5Zr05xy7sy5YMRsPeJa7MoB3QK7/NtcukXtSKga05SM
	v1a0qdrbRVTL+lJBbDXQMcY/WQTy9tS85nWIgwQzGwELpuMgUFnD5WX2A8dS+zvMLh/ETJZXzSJ9D
	C3DsJD3wGIprXmKTBNSWuML3IkSMseTrS7na9KLWGn16AxrGwzo6q1d2Rc09Li0s2BeNiGoW2gVnu
	rTUiRMew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llaZu-006k5J-JU; Tue, 25 May 2021 17:10:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llaZr-006k2d-EJ
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 17:10:48 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1621962645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ic/kHu3+er9zmWTXs/ezmw2RMHPP6ivimNx474VPJC4=;
 b=Vh/EblwxbG2VjeEzM2D8903olQEsOQwdKJ5Amal99FpI2r/TszMPvjQ3NkQox96UmviDDW
 GDq/3PQqpacTm4xGcd6vUAJhBnap5Rwak0s9eWHZUmcSAAX4/gJU+PSS8cxkF9XlufKECV
 XFNUdxuPDN61t9K9Ur8/f0fWHy51y1c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1621962645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ic/kHu3+er9zmWTXs/ezmw2RMHPP6ivimNx474VPJC4=;
 b=bf+O6azX+N4AwjGmws2scpSOh7ABJB4/2wonDEn7yKUKFVm1pKqa2zcnjH9pJWSCWSBS9H
 zqlxhM0OhHyAtaAA==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 73E03AEEB;
 Tue, 25 May 2021 17:10:45 +0000 (UTC)
Subject: Re: [PATCH] nvmet: fix false keep-alive timeout when a controller is
 torn down
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20210525154905.2245888-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f0365de8-3bfc-b7a3-2355-ab0bca6fee10@suse.de>
Date: Tue, 25 May 2021 19:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525154905.2245888-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_101047_668080_8EF80700 
X-CRM114-Status: GOOD (  15.06  )
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

T24gNS8yNS8yMSA1OjQ5IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IENvbnRyb2xsZXIgdGVh
cmRvd24gZmxvdyBtYXkgdGFrZSBzb21lIHRpbWUgaW4gY2FzZSBpdCBoYXMgbWFueSBJL08KPiBx
dWV1ZXMsIGFuZCB0aGUgaG9zdCBtYXkgbm90IHNlbmQgdXMga2VlcC1hbGl2ZSBkdXJpbmcgdGhp
cyBwZXJpb2QuCj4gSGVuY2UgcmVzZXQgdGhlIHRyYWZmaWMgYmFzZWQga2VlcC1hbGl2ZSB0aW1l
ciBzbyB3ZSBkb24ndCB0cmlnZ2VyCj4gYSBjb250cm9sbGVyIHRlYXJkb3duIGFzIGEgcmVzdWx0
IG9mIGEga2VlcC1hbGl2ZSBleHBpcmF0aW9uLgo+IAo+IFJlcG9ydGVkLWJ5OiBZaSBaaGFuZyA8
eWkuemhhbmdAcmVkaGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdp
QGdyaW1iZXJnLm1lPgo+IC0tLQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgIHwgMTYg
KysrKysrKysrKysrLS0tLQo+ICAgZHJpdmVycy9udm1lL3RhcmdldC9udm1ldC5oIHwgIDIgKy0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKPiAK
UmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFu
bmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdl
IEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkg
OTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1
LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8
aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==
