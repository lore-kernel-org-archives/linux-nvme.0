Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD0AC47087
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 11:11:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EB4613C9
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 11:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EB4613C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ZEnbhQDcp69Vx4pUwumjsF4oZwlO2iPWTOc3Fpz+Uxw=; b=1v0AGLPOJDKJljB3ktVpOlov5+
	71wafE0DBbLLVIry3eqNj0zXLdQtWgBHFLfoMKx6wR39346zhQSB70bdHv7tdlepsFewde+jy1cau
	OaeaYjQp7wX+hIMo3y1XDv6PlAi1QysSteWo12DIh/oYcKhG0vEXzPFoapCXs6z6p+V0cTC7fx9Bo
	FTKGV+mPV6RhVVJZWci0xPv6tNaNrfpUEkZeD3dbuh+9HZcSImpM150EVQh6giFRuwbM5OBKKzUbT
	t9bTlE0VxvIzW0RHvgyl2q6BCiJff3swLjuiNEUVag8cIU+dp/yROu+KUZ3bHaQP+lmBDTi+eBroa
	N7tA2Myg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmaOD-00EhS5-HO; Fri, 28 May 2021 11:10:53 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmZZT-00EJXS-JM
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 10:18:29 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A043218B3;
 Fri, 28 May 2021 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622197104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xwzxPsqkRs33JFbxt2zkP1hnKW16XUAwJ7jZ33Dcx0=;
 b=n4cgimD+8eAxXX+9t7cHQRlox6GheamXBsS6fKXLEWMvvdGdp4n4fRT3qzZCFmG7Hz1cVP
 SXhJHUY9FjZ/TDKextxTosQ75U2V4tKhsHzqysBHME5t+6ZxS1+BcwCFX51lAjrBhVYbRq
 wW6TK6l7OQUsXt4IcxuANaHMnTx5wzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622197104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/xwzxPsqkRs33JFbxt2zkP1hnKW16XUAwJ7jZ33Dcx0=;
 b=G86OMUJ6ggBLRJl3meZkVluLc/THDuA1OyKH5AKI31Mrh/vF8pth6EfdaTDW7mla5Tc9D0
 L+GMv7jjgThdASCg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
 by imap.suse.de (Postfix) with ESMTPSA id EDE0211A98;
 Fri, 28 May 2021 10:18:23 +0000 (UTC)
Subject: Re: [RFC PATCH v6 02/27] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
To: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc: aelior@marvell.com, mkalderon@marvell.com, okulkarni@marvell.com,
 pkushwaha@marvell.com, malin1024@gmail.com,
 Arie Gershberg <agershberg@marvell.com>
References: <20210527235902.2185-1-smalin@marvell.com>
 <20210527235902.2185-3-smalin@marvell.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <e0a36dc7-f5f2-e7b6-7368-323769c54caa@suse.de>
Date: Fri, 28 May 2021 12:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527235902.2185-3-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210528_031827_827538_B8B509F7 
X-CRM114-Status: GOOD (  17.28  )
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

T24gNS8yOC8yMSAxOjU4IEFNLCBTaGFpIE1hbGluIHdyb3RlOgo+IEZyb206IEFyaWUgR2Vyc2hi
ZXJnIDxhZ2Vyc2hiZXJnQG1hcnZlbGwuY29tPgo+IAo+IE1vdmUgTlZNRl9BTExPV0VEX09QVFMg
YW5kIE5WTUZfUkVRVUlSRURfT1BUUyBkZWZpbml0aW9ucwo+IHRvIGhlYWRlciBmaWxlLCBzbyBp
dCBjYW4gYmUgdXNlZCBieSB0aGUgZGlmZmVyZW50IEhXIGRldmljZXMuCj4gCj4gTlZNZVRDUCBv
ZmZsb2FkIGRldmljZXMgbWlnaHQgaGF2ZSBkaWZmZXJlbnQgbGltaXRhdGlvbnMgb2YgdGhlCj4g
YWxsb3dlZCBvcHRpb25zLCBmb3IgZXhhbXBsZSwgYSBkZXZpY2UgdGhhdCBkb2VzIG5vdCBzdXBw
b3J0IGFsbCB0aGUKPiBxdWV1ZSB0eXBlcy4gV2l0aCB0Y3AgYW5kIHJkbWEsIG9ubHkgdGhlIG52
bWUtdGNwIGFuZCBudm1lLXJkbWEgbGF5ZXJzCj4gaGFuZGxlIHRob3NlIGF0dHJpYnV0ZXMgYW5k
IHRoZSBIVyBkZXZpY2VzIGRvIG5vdCBjcmVhdGUgYW55IGxpbWl0YXRpb25zCj4gZm9yIHRoZSBh
bGxvd2VkIG9wdGlvbnMuCj4gCj4gQW4gYWx0ZXJuYXRpdmUgZGVzaWduIGNvdWxkIGJlIHRvIGFk
ZCBzZXBhcmF0ZSBmaWVsZHMgaW4gbnZtZV90Y3Bfb2ZsZF9vcHMKPiBzdWNoIGFzIG1heF9od19z
ZWN0b3JzIGFuZCBtYXhfc2VnbWVudHMgdGhhdCB3ZSBhbHJlYWR5IGhhdmUgaW4gdGhpcwo+IHNl
cmllcy4KPiAKPiBBY2tlZC1ieTogSWdvciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IEFyaWUgR2Vyc2hiZXJnIDxhZ2Vyc2hiZXJnQG1hcnZlbGwuY29t
Pgo+IFNpZ25lZC1vZmYtYnk6IFByYWJoYWthciBLdXNod2FoYSA8cGt1c2h3YWhhQG1hcnZlbGwu
Y29tPgo+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogTWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5j
b20+Cj4gU2lnbmVkLW9mZi1ieTogQXJpZWwgRWxpb3IgPGFlbGlvckBtYXJ2ZWxsLmNvbT4KPiBT
aWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4gUmV2aWV3ZWQt
Ynk6IEhpbWFuc2h1IE1hZGhhbmkgPGhpbWFuc2h1Lm1hZGhhbmlAb3JhY2xlLmNvbT4KPiBBY2tl
ZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KPiAtLS0KPiAgZHJpdmVycy9u
dm1lL2hvc3QvZmFicmljcy5jIHwgNyAtLS0tLS0tCj4gIGRyaXZlcnMvbnZtZS9ob3N0L2ZhYnJp
Y3MuaCB8IDcgKysrKysrKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkKPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+
CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJCSAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAgICAgICAgICs0OSA5MTEg
NzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgOTA0MDkgTsO8
cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
