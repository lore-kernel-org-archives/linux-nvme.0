Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3353C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:39:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A53207BB
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 00:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BslW85l5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A53207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N6oB852+OqvNXPYPzB2sIIGQA94kiWYGZvTzCLHe08A=; b=BslW85l5BmHqRWpwv1o9DNlRI
	bDP87sDImtdrgTBhpw9QpsQ6MyppAuK9pyRxfvaVBwgn10fH1IrVz7zIULeM3FrCDJ8DCtSUrFwRs
	aIxtRpmTOrrNsARq7/S2dLS5Kyw0/eEeAogci2DzeA0nBSBJRODgtjQGJANEsB3xzS1Q4Qu4x4w88
	+XjzK093wW1Q2GTcdkpW9OXlIgCCs6qzYkI0E4aBm41dWeKtEnBODRi6szDsj76RIpJtUobaYo0Hu
	Xk+AtOxD1QWsDqLn56xZz/6GKsUQ6FqujrCxBZO5p43k5fa89ne/DAK2BBOECEjvOUevdM9QTuVv5
	pTN5KizqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8C8S-0005sl-JF; Wed, 19 Aug 2020 00:39:24 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8C8Q-0005sG-51
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 00:39:22 +0000
Received: by mail-pf1-f195.google.com with SMTP id u20so10801024pfn.0
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 17:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sD1fC1aKILfd79LmeQ0eoc5tKmJt16fXspWfAnjIExs=;
 b=DfcuCfrJzjzvQefAr4MAnm87wZ9tnD+FHiq8y+8gqUskuLm6otfj8NHvpPT0yAiF5c
 jg5Z2SR0DUiJf/ADaQdX8nQIDVnSG/HiQ5+u7yIyrr1HK0+vub0uIL2MFO0I4qurUafX
 HGcNyxVv2cmLpaNeLYbehqrSUXBdkJrWV1hzTapK9xsrJHjvp55WVb91zpwLcYugYzq6
 L0UcMC7Q871XpTFuAh+W+w6JMqe5CsaYBy86Nrs6arQKGkpcDCdDGb8laiKdKTtQMGX8
 kFUmwv9o6mCswBTErtc3Xy1BkbJ9R/9jWlB5d3vWlrzKqcUY02aPRYcSlANfgJRYYc1c
 +CJA==
X-Gm-Message-State: AOAM532WxOmzCCPSntjg2jpG5de0kA9ARjU4e4C0dwCNzNQUyn3kfr/y
 ABzUZWOUB0ULOcnu/9mvkn8=
X-Google-Smtp-Source: ABdhPJx/vPa8mWCDcUi+YKXvXl/WQS2jOnY19zOMD4SGbZ36JBaP++/tcS4e1i/tevU+YbYYJWe59w==
X-Received: by 2002:a63:a412:: with SMTP id c18mr15589933pgf.120.1597797560992; 
 Tue, 18 Aug 2020 17:39:20 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bcd0:fda9:d34d:a3ab?
 ([2601:647:4802:9070:bcd0:fda9:d34d:a3ab])
 by smtp.gmail.com with ESMTPSA id d17sm1011856pjr.40.2020.08.18.17.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 17:39:20 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me>
 <37c1a34b-9956-b9b6-8e06-f44c99470a73@broadcom.com>
 <edaacba9-fe97-a91c-3795-7542861c3335@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1872b3fe-dfba-4c37-d2b0-9bc414cb4731@grimberg.me>
Date: Tue, 18 Aug 2020 17:39:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <edaacba9-fe97-a91c-3795-7542861c3335@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_203922_213034_D009C1C8 
X-CRM114-Status: GOOD (  16.16  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IE9uIDgvNi8yMDIwIDEyOjExIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4gQ3VycmVu
dGx5IHdlIGNoZWNrIGlmIHRoZSBjb250cm9sbGVyIHN0YXRlICE9IExJVkUsIGFuZAo+Pj4gd2Ug
ZGlyZWN0bHkgZmFpbCB0aGUgY29tbWFuZCB1bmRlciB0aGUgYXNzdW1wdGlvbiB0aGF0IHRoaXMK
Pj4+IGlzIHRoZSBjb25uZWN0IGNvbW1hbmQgb3IgYW4gYWRtaW4gY29tbWFuZCB3aXRoaW4gdGhl
Cj4+PiBjb250cm9sbGVyIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlLgo+Pj4KPj4+IFRoaXMgaXMg
d3JvbmcsIHdlIG5lZWQgdG8gY2hlY2sgaWYgdGhlIHJlcXVlc3Qgcmlza2luZwo+Pj4gY29udHJv
bGxlciBzZXR1cC90ZWFyZG93biBibG9ja2luZyBpZiBub3QgY29tcGxldGVkIGFuZAo+Pj4gb25s
eSB0aGVuIGZhaWwuCj4+Pgo+Pj4gVGhlIGxvZ2ljIHNob3VsZCBiZToKPj4+IC0gUkVTRVRUSU5H
LCBvbmx5IGZhaWwgZmFicmljcy9hZG1pbiBjb21tYW5kcyBvdGhlcndpc2UKPj4+IMKgwqAgY29u
dHJvbGxlciB0ZWFyZG93biB3aWxsIGJsb2NrLiBvdGhlcndpc2UgcmVzZXQgdGhlIHRpbWVyCj4+
PiDCoMKgIGFuZCBjb21lIGJhY2sgYWdhaW4uCj4+PiAtIENPTk5FQ1RJTkcsIGlmIHRoaXMgaXMg
YSBjb25uZWN0IChvciBhbiBhZG1pbiBjb21tYW5kKSwgd2UgZmFpbAo+Pj4gwqDCoCByaWdodCBh
d2F5ICh1bmJsb2NrIGNvbnRyb2xsZXIgaW5pdGlhbGl6YXRpb24pLCBvdGhlcndpc2Ugd2UKPj4+
IMKgwqAgdHJlYXQgaXQgbGlrZSBhbnl0aGluZyBlbHNlLgo+Pj4gLSBvdGhlcndpc2UgdHJpZ2dl
ciBlcnJvciByZWNvdmVyeSBhbmQgcmVzZXQgdGhlIHRpbWVyICh0aGUKPj4+IMKgwqAgZXJyb3Ig
aGFuZGxlciB3aWxsIHRha2UgY2FyZSBvZiBjb21wbGV0aW5nL2RlbGF5aW5nIGl0KS4KPj4+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+Pj4gLS0t
Cj4+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgfCA2OCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9u
cygrKSwgMTggZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9o
b3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4gaW5kZXggYWJjMzE4NzM3
ZjM1Li4zMGI0MDFmY2MwNmEgMTAwNjQ0Cj4gCj4gTm90ZTogRkMgaGFzIHRvIGRvIHRoaXMgYSBs
aXR0bGUgZGlmZmVyZW50bHkuIEZyb20gd2hhdCBJIGNhbiB0ZWxsLCAKPiB0aGVyZSdzIG5vIGNy
b3NzLW92ZXJzIGluIHlvdXIgcGF0Y2hlcyB2cyBtaW5lLCBzbyBubyBuZWVkIHRvIHdhaXQgZm9y
IAo+IEZDIHBhdGNoZXMgdG8gbWFycnkgd2l0aCB0aGVtLgoKR29vZCB0byBrbm93IEphbWVzLgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
