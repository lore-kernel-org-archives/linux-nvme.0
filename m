Return-Path: <SRS0=n/mE=MT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_ALL,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673FCC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 15:13:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038F361B26
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jul 2021 15:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 038F361B26
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u7F2U5dQNKslIfo1JoMnFXWOjNYLlBfs6oftf/6bIwc=; b=KCI6566qhQB0sK
	ehbRfXwwUdXRbMQZ2YNn7GUD8bkA+pVsp3J4tEPxRT1M5O7RdH2J8INS9VQumFw3IJSdVoTz7kNBH
	O3rdfIunzCnyBe9JsmCh8E9n08f2qXiTNXlcSrTYv51knedxBp7wbzO1UAWMU4Wv2cfGPEOveDL6s
	uASKJna+/dtqnec1NJaM6tdeptjefrrG+o72kp620c0Cb4TukdkYiFigERN8bo/OxpOnC+6unXopt
	38ddIdUJuchSwSGKV2yNrKMyrmdxBEadcf8kc+bNDbbySP7II4ilpkx4PGmO53JovmF/IVE1LzwYg
	q88VRVRixf5QpD+ueG9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8Ol9-00FBop-4K; Tue, 27 Jul 2021 15:12:43 +0000
Received: from vulcan.natalenko.name ([104.207.131.136])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8Okf-00FBns-C1
 for linux-nvme@lists.infradead.org; Tue, 27 Jul 2021 15:12:15 +0000
Received: from spock.localnet (unknown [151.237.229.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by vulcan.natalenko.name (Postfix) with ESMTPSA id D4363B5A46B;
 Tue, 27 Jul 2021 17:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
 s=dkim-20170712; t=1627398728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+u6eFB12YZ1NCrj7Q9V4Jck5qxdhuaziUeq3IRaHAM=;
 b=iT8WAcuG8Zbp1m3DR97NkkyBWUJbGjHXR49VIDYoSes7UmojArxLze8zKS8wObxOA9zUds
 3bmVrh5KU+8fa+ugk4cgQQjWb10aNYy4o1OQbKgoVzOUyNB9mGzkOHiD7MshxZ+XE2p2OR
 Q4TnXkMe1dFkZ1riTMWneRF9M+EdZYY=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, David Jeffery <djeffery@redhat.com>,
 Laurence Oberman <loberman@redhat.com>,
 Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
 Sasha Levin <sashal@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: New warning in nvme_setup_discard
Date: Tue, 27 Jul 2021 17:12:03 +0200
Message-ID: <17691292.WCMSeNvH9h@natalenko.name>
In-Reply-To: <YPfUOKrxGs6FjaOZ@T590>
References: <4729812.CpyZKHjjVO@natalenko.name>
 <2356877.Yf5hrMSTGe@natalenko.name> <YPfUOKrxGs6FjaOZ@T590>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210727_081213_606091_571E471A 
X-CRM114-Status: GOOD (  16.05  )
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

SGVsbG8uCgpPbiBzdMWZZWRhIDIxLiDEjWVydmVuY2UgMjAyMSAxMDowMDo1NiBDRVNUIE1pbmcg
TGVpIHdyb3RlOgo+ID4gSSdtIHN0aWxsIGhhbW1lcmluZyB2NS4xNC1yYzIgKyB5b3VyIHBhdGNo
LCBhbmQgSSBjYW5ub3QgcmVwcm9kdWNlIHRoZQo+ID4gaXNzdWUuIEdpdmVuIEkgZG8gbm90IGhh
dmUgYSByZWxpYWJsZSByZXByb2R1Y2VyIChJJ20ganVzdCBmaXJpbmcgdXAgdGhlCj4gPiBrZXJu
ZWwgYnVpbGQsIGFuZCB0aGUgaXNzdWUgcG9wcyB1cCBldmVudHVhbGx5LCBzb29uZXIgb3IgbGF0
ZXIsIGJ1dAo+ID4gdXN1YWxseSB3aXRoaW4gYSBjb3VwbGUgb2YgZmlyc3QgdHJpZXMpLCBmb3Ig
aG93IGxvbmcgSSBzaG91bGQgaGFtbWVyIGl0Cj4gPiBmb3IgeW91ciBmaXggdG8gYmUgY29uc2lk
ZXJlZCBwcm92ZW4/Cj4gCj4gWW91IG1lbnRpb25lZCB0aGF0IHRoZSBpc3N1ZSBpcyByZXByb2R1
Y2libGUgd2l0aCB2NS4xNC1yYywgdGhhdCBtZWFucwo+IGl0IGNhbiBiZSBhbHdheXMgcmVwcm9k
dWNlZCBpbiBsaW1pdGVkIHRpbWUoc3VwcG9zZSBpdCBpcyBBKS4gSWYgdGhlIGlzc3VlCj4gY2Fu
J3QgYmUgcmVwcm9kdWNlZCBhbnkgbW9yZSBhZnRlciBhcHBseWluZyB0aGUgcGF0Y2ggaW4gbG9u
ZyBlbm91Z2ggdGltZQo+IEIoQiA+PiBBKSwgd2UgY2FuIHRoaW5rIGl0IGlzIGZpeGVkIGJ5IHRo
ZSBwYXRjaC4KPiAKPiBGb3IgZXhhbXBsZSwgaWYgQSBpcyBvbmUgaG91ciwgd2UgY2FuIHNldCBC
IGFzIDUqQSBvciBiaWdnZXIgdG8gc2ltdWxhdGUKPiB0aGUgbG9uZyBlbm91Z2ggdGltZS4KCldp
dGggeW91ciBwYXRjaCB0aGUgaXNzdWUgaXMgc3RpbGwgbm90IHJlcHJvZHVjaWJsZSBmb3IgbWUu
IEhlbmNlLCBmcm9tIG15IApzaWRlIHRoZSBwYXRjaCBsb29rcyB0byBiZSB2ZXJpZmllZC4KClRo
YW5rcy4KCi0tIApPbGVrc2FuZHIgTmF0YWxlbmtvIChwb3N0LWZhY3R1bSkKCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
