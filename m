Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC622C388F7
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 19:56:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45E3206D8
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 19:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EjZlccVH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="UP/1RwTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45E3206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lBDK9wVqJVnEDnx1nJJyJ/xm1UO+19VMQ5WFnUkJ/Lc=; b=EjZlccVH/Df/YUtPx111dgms3
	SA16J+ZBivvurcFfT/zS5NDuTXQdlkho2tHaMMDdmPpmMZd8noxTaeI/a+8eWcD0r9F9QBOBPnf+x
	c3gANU0KfZfMB9ggvUKPe15vU0YGHCNneRR8GLcppBIvxI4iu2zHH2p/OBnP1bswiE7IO9Zc/x8+2
	vnhXhegy3dHSTW0LfW61ETEoCh9iXaMPjZ/W+hUcNEkoBnkOkySp8IROiFC/nkFWkGqvSH+/o4eW+
	ktl3IBjTr94SuNCc9ez/frcJH6cvSVEARoJlOI7rnEu3uJTAXQFPBkGsSy5gjCZSB+29D/cN2Cpow
	7Buf/cGVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcZkI-0004Dx-So; Tue, 10 Nov 2020 19:56:02 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcZkF-0004DK-Rz
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 19:56:01 +0000
Received: by mail-ed1-x544.google.com with SMTP id a15so14136963edy.1
 for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2020 11:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=pgO8LSm7rMPKtTw+RAIb7HJGumePII/RfxxVSh9XMP0=;
 b=UP/1RwTZeKv+aSUgb1FlkZ5/PIjZxNgK+KEMRzbIkyBDPFpQKEhladO7Z9+0xT3Wa7
 mRMzvkmpmOiYEGuOR68MbAEBjN9zhiL6cJBz6PhTggHpyXLemfEcBVTaBwg8O76THgbp
 4QPzBn4mjcHju5puRuZo7S7RPhkP0Z2GbBx1lGC/CNi9voaw1uiukuYgLCMsLi8xp11i
 7pn9wI26agZFKqUM71DCJGysS8ZT8cttqI6SuwNNjMCxk1woEhQkBLXVeH69IugxHCUj
 axa+BCN/7tk4Slp/i9cQps+tmhdXQCW+IOXBlnaElCLlgQVDcqEFlzIFApLIfyC3LmrA
 ApGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pgO8LSm7rMPKtTw+RAIb7HJGumePII/RfxxVSh9XMP0=;
 b=S+Nai2R3wqPW6HWtHaQA6QxgCBhXMnYuNnb3/WYSLnF3RtoVQhWllPi46/0tI9c371
 HRfwUsV7KpvDWu402fclv7lV0STiIKMZH8A7np2ws3k7ZZ0K2KcYz6q+r71TmfTZ8mPS
 yg0PJStxStQ9HRn9+ZtQTOZK8reWq+ORlep3SM8rTF/YaoH5SxnZE8mm0ttjo/+2eNy9
 8BdSZ/Tq0KPawql/u7Qx+T0QMDoQWdo6HzZqnlDamMfQ/Dml6sMg12aR1C7yFMITQTsi
 rY6LZ9QzFIR0PrL7ZVRdJT72VBC4q2utmJgSHHdD1shwiGCCTZw57C2EDTYHUZNWlYlw
 tO6w==
X-Gm-Message-State: AOAM530XN00SI/4XWOwfV8V4HtPDwmfvsWqmQa5MoqQse2N5cflFjmEH
 ujLE+aOkPIR33Lzbpx+sS8GAHQ==
X-Google-Smtp-Source: ABdhPJx0eHHki8+yi032+9uSCy/U1eYvA3pLpI8aZqWtK8JaOiCdpynRyj2vbX/T7T9JWkc7B8NqsA==
X-Received: by 2002:aa7:d64b:: with SMTP id v11mr1106671edr.253.1605038158720; 
 Tue, 10 Nov 2020 11:55:58 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id d19sm11103156eds.31.2020.11.10.11.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:55:58 -0800 (PST)
Date: Tue, 10 Nov 2020 20:55:57 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: nvme: enable ro namespace for ZNS without append
Message-ID: <20201110195557.v25tq7eicxzwfgrz@MacBook-Pro.localdomain>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
 <20201110094354.GB25672@lst.de>
 <20201110112554.GA465503@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110112554.GA465503@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_145600_055128_49519DA9 
X-CRM114-Status: GOOD (  20.75  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "k.jensen@samsung.com" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAuMTEuMjAyMCAxMToyNSwgTmlrbGFzIENhc3NlbCB3cm90ZToKPk9uIFR1ZSwgTm92IDEw
LCAyMDIwIGF0IDEwOjQzOjU0QU0gKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiA+
IC0JaWYgKGlkLT5uc2F0dHIgJiBOVk1FX05TX0FUVFJfUk8pCj4+ID4gKwlpZiAoaWQtPm5zYXR0
ciAmIE5WTUVfTlNfQVRUUl9STyB8fAo+PiA+ICsJCQl0ZXN0X2JpdChOVk1FX05TX0ZPUkNFX1JP
LCAmbnMtPmZsYWdzKSkKPgo+SW5kZW50YXRpb24gZm9yIHRoZSB0ZXN0X2JpdCgpIGxvb2tzIG9m
Zi4KPkkgYXNzdW1lIHRoYXQgQ2hyaXN0b3BoIGNhbiBmaXh1cCB0aGF0IHdoZW4gYXBwbHlpbmcu
Cj4KPiQgLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1zdHJpY3Qgfi9qYXZpZXIucGF0Y2gKPkNI
RUNLOiBBbGlnbm1lbnQgc2hvdWxkIG1hdGNoIG9wZW4gcGFyZW50aGVzaXMKPiMyODA6IEZJTEU6
IGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYzoyMDYyOgo+KyAgICAgICBpZiAoaWQtPm5zYXR0ciAm
IE5WTUVfTlNfQVRUUl9STyB8fAo+KyAgICAgICAgICAgICAgICAgICAgICAgdGVzdF9iaXQoTlZN
RV9OU19GT1JDRV9STywgJm5zLT5mbGFncykpCj4KPgo+Rm9yIHRoZSByZWNvcmQ6Cj4KPldBUk5J
Tkc6IEZyb206L1NpZ25lZC1vZmYtYnk6IGVtYWlsIGFkZHJlc3MgbWlzbWF0Y2g6ICdGcm9tOiAi
SmF2aWVyIEdvbnrDoWxleiIgPGphdmllckBqYXZpZ29uLmNvbT4nICE9ICdTaWduZWQtb2ZmLWJ5
OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4nCj4KPklmIHlvdSB3
YW50IHRvIHVzZSBhIFNvQiB0aGF0IGlzIGRpZmZlcmVudCBmcm9tIHRoZSBlbWFpbCBhZGRyZXNz
IHdoaWNoCj55b3UgYXJlIHNlbmRpbmcgZnJvbSwgdGhlbiBhY2NvcmRpbmcgdG8gdGhlIFRoZSBj
YW5vbmljYWwgcGF0Y2ggZm9ybWF0Ogo+Cj5odHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1s
L2xhdGVzdC9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI3RoZS1jYW5vbmljYWwtcGF0
Y2gtZm9ybWF0Cj4KPiIiIgo+VGhlIGZyb20gbGluZSBtdXN0IGJlIHRoZSB2ZXJ5IGZpcnN0IGxp
bmUgaW4gdGhlIG1lc3NhZ2UgYm9keSwgYW5kIGhhcyB0aGUgZm9ybToKPgo+ICAgIEZyb206IFBh
dGNoIEF1dGhvciA8YXV0aG9yQGV4YW1wbGUuY29tPgo+Cj5UaGUgZnJvbSBsaW5lIHNwZWNpZmll
cyB3aG8gd2lsbCBiZSBjcmVkaXRlZCBhcyB0aGUgYXV0aG9yIG9mIHRoZSBwYXRjaCBpbiB0aGUg
cGVybWFuZW50IGNoYW5nZWxvZy4KPklmIHRoZSBmcm9tIGxpbmUgaXMgbWlzc2luZywgdGhlbiB0
aGUgRnJvbTogbGluZSBmcm9tIHRoZSBlbWFpbCBoZWFkZXIgd2lsbCBiZSB1c2VkIHRvIGRldGVy
bWluZQo+dGhlIHBhdGNoIGF1dGhvciBpbiB0aGUgY2hhbmdlbG9nLgo+Cj5Ob3RlLCB0aGUgRnJv
bTogdGFnIGlzIG9wdGlvbmFsIHdoZW4gdGhlIEZyb206IGF1dGhvciBpcyBhbHNvIHRoZSBwZXJz
b24gKGFuZCBlbWFpbCkgbGlzdGVkIGluIHRoZQo+RnJvbTogbGluZSBvZiB0aGUgZW1haWwgaGVh
ZGVyLgo+IiIiCj4KPgo+VGhhdCB3YXksIHdoZW4gdGhlIG1haW50YWluZXJzIHVzZSBnaXQgYW0s
IGl0IHdpbGwgcGljayB0aGUgYXV0aG9yCj5mcm9tIHRoZSAiRnJvbToiIGluIHRoZSBtZXNzYWdl
IGJvZHksIHJhdGhlciB0aGFuIGZyb20gdGhlIGVtYWlsIGhlYWRlci4KPgo+T3RoZXJ3aXNlIHRo
ZSBBdXRob3I6IGZpZWxkIGluIHRoZSBnaXQgbG9nIHdpbGwgYmUgZGlmZmVyZW50IGZyb20geW91
ciBTb0IuCj4KPlRoZXJlIGFyZSBzZXZlcmFsIHdheXMgeW91IGNhbiBmaXggdGhpcywgZWl0aGVy
IGJ5IHVzaW5nIHRoZSBjb3JyZWN0IGVtYWlsCj53aGVuIHlvdSBkbyB0aGUgY29tbWl0IGluIHRo
ZSBmaXJzdCBwbGFjZSwgdGhlbiBnaXQgZm9ybWF0LXBhdGNoIHdpbGwgYWRkCj5Gcm9tOiBhdXRv
bWF0aWNhbGx5LCBvciBieSB1c2luZyB0aGUgZ2l0IGNvbmZpZyBzZW5kZW1haWwuZnJvbSwgb3Ig
LS1mcm9tCj5vcHRpb24gdG8gZ2l0LXNlbmQtZW1haWwuCj4KClRoYW5rcyBmb3IgdGFraW5nIHRo
ZSB0aW1lIE5pa2xhcy4gSSBoYXZlIGRvbmUgdGhpcyBpbnRlbnRpb25hbGx5IGZvcgpxdWl0ZSBz
b21lIHRpbWUgLSBJIHVzZSBqYXZpZXJAamF2aWdvbi5jb20gdG8gc3VibWl0IGFuZCBjb21taXQg
YW5kIHRoZW4Kc2lnbi1vZmYgd2l0aCBteSBjdXJyZW50IGVtcGxveWVyLgoKSWYgdGhpcyBwcmVz
ZW50cyBhbiBpbmNvbnZlbmllbmNlLCBJIGRvbid0IG1pbmQgY2hhbmdpbmcgdGhlIGNvbW1pdHRl
cgp0byBteSBjdXJyZW50IFNhbXN1bmcgZW1haWwuCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
