Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25DBC2B9F7
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:31:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BC12611AB
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 13:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BC12611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=EqCOgl4GG8mpKzTz2f+QRLAnFIvrFy7SdX7iQHUcmvw=; b=qMQHqaw7ZbgFsGDodr5qodT0rj
	n/S6l/8u5EVf2KZQ7IlxrboYjBWrx+E/MA9jiuZ82GYmkvC90pIGYGOCkPNYXgU8SNjaAJATZ/g8c
	Vs0cEL03TlAPOy7wFw0J2c8+UO0/wUAN1/9v+U2OWwlmYZXgong9shfBdJ9TyryGeGXTJ+dQKO9fK
	jKSMxINekA17gnZclLrvLMHYFegQOE1uSzLqUSp+mri0rb+obNX2s+Sj/+W5nfdnFLIL073zIVvNc
	wMJ+rZUlHi5C9JhMEBl8korDR3B+cZw9ukrvSbedpZlzRH4/3bJW11EqCsc4EIJff1nLFndf/csPk
	6mEwZ2OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmca2-00FnM6-FE; Fri, 28 May 2021 13:31:14 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmcDK-00Fe5w-Kh
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 13:07:51 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2982D218B3;
 Fri, 28 May 2021 13:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622207265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERRtxFJvp5L1bfUoMh6rT6SEqUZr++CR0IsW9hus3JQ=;
 b=ko9X3K9IjL4c/gboFx0SUj0+HIFiamVCOv8SIj9fKUbsQ4WrZw/232H4VH8kZ95iAf4fRi
 PQ2OVUbxDw8Sw/pLFUPOQxMVQnRg3NOkqTinxuuTqDhYEuGKeK1o6/BszuTO6C/GjfnFXX
 a6r+M9lVVFqAV1+XqbkwMupQ2hrFiG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622207265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ERRtxFJvp5L1bfUoMh6rT6SEqUZr++CR0IsW9hus3JQ=;
 b=cbai/uYTpRu5BtW9Q6vXuMQWzwqN0LkKnrC9K3wNq09s42g57Tn3z/FJBVqNZr3Hrs5LYl
 +MLDxUdVaV1LloAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id EB65511A98;
 Fri, 28 May 2021 13:07:44 +0000 (UTC)
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id YnjFOCDrsGDoPQAALh3uQQ
 (envelope-from <hare@suse.de>); Fri, 28 May 2021 13:07:44 +0000
Subject: Re: [RFC PATCH v6 24/27] qedn: Add support of NVME ICReq & ICResp
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-25-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <3718cc2f-2d4b-97bf-bead-99021f138acf@suse.de>
Date: Fri, 28 May 2021 15:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-25-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_060746_892882_DB085D46 
X-CRM114-Status: GOOD (  13.87  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IFByYWJoYWthciBL
dXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwuY29tPgo+IAo+IE9uY2UgYSBUQ1AgY29ubmVjdGlv
biBlc3RhYmxpc2hlZCwgdGhlIGhvc3Qgc2VuZHMgYW4gSW5pdGlhbGl6ZQo+IENvbm5lY3Rpb24g
UmVxdWVzdCAoSUNSZXEpIFBEVSB0byB0aGUgY29udHJvbGxlci4KPiBGdXJ0aGVyIEluaXRpYWxp
emUgQ29ubmVjdGlvbiBSZXNwb25zZSAoSUNSZXNwKSBQRFUgcmVjZWl2ZWQgZnJvbQo+IGNvbnRy
b2xsZXIgaXMgcHJvY2Vzc2VkIGJ5IGhvc3QgdG8gZXN0YWJsaXNoIGEgY29ubmVjdGlvbiBhbmQK
PiBleGNoYW5nZSBjb25uZWN0aW9uIGNvbmZpZ3VyYXRpb24gcGFyYW1ldGVycy4KPiAKPiBUaGlz
IHBhdGNoIHByZXNlbnQgc3VwcG9ydCBvZiBnZW5lcmF0aW9uIG9mIElDUmVxIGFuZCBwcm9jZXNz
aW5nIG9mCj4gSUNSZXNwLiBJdCBhbHNvIHVwZGF0ZSBob3N0IGNvbmZpZ3VyYXRpb24gYmFzZWQg
b24gZXhjaGFuZ2VkIHBhcmFtZXRlcnMuCj4gCj4gQWNrZWQtYnk6IElnb3IgUnVzc2tpa2ggPGly
dXNza2lraEBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEg
PHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBPbWthciBLdWxrYXJuaSA8
b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhbCBLYWxkZXJvbiA8
bWthbGRlcm9uQG1hcnZlbGwuY29tPgo+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxp
b3JAbWFydmVsbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2hhaSBNYWxpbiA8c21hbGluQG1hcnZl
bGwuY29tPgo+IC0tLQo+ICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuLmggICAgICB8ICAzNyAr
KysrCj4gIGRyaXZlcnMvbnZtZS9ody9xZWRuL3FlZG5fY29ubi5jIHwgMzIzICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0KPiAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9tYWluLmMg
fCAgMTQgKysKPiAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl90YXNrLmMgfCAgIDggKy0KPiAg
NCBmaWxlcyBjaGFuZ2VkLCAzNzggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiBSZXZp
ZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+CgpDaGVlcnMsCgpIYW5uZXMK
LS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0
CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29m
dHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVu
ZMO2cmZmZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=
