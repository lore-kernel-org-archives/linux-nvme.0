Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A906C47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 06:01:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC4561184
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 06:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC4561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgFtgdFUaNz1mwtPMFqtAvNT5eiBVCSWunDKa5B6Poc=; b=diM+IbIzDimlXuYEn8zzzksNed
	eAGj8DMoRD6jbMMQXvj9qgotqOYQ9EKeXMlo8xG60AOaHr9qeIWCzWW07PzzDYNP4rYJvZeH1g7Ke
	iKBAM77xY0zqoiye6Uf6r/UN7DnQbeCxLPYkwYt03RNKWVPIA5j8lXaj5pe3BPFlVaWAq3fIN6WmD
	PDfZo/KCR2y7OgRT0W0AcLqvyRcf6Gwn0gpkoI7PdIPEVwYqlvzG1v/5+5EMFJShe++67jz1fIz2d
	9dY1v5YvmomYx5SCmOS7sdkqCXx8RQFr7+p0QVPppMJC7wkVH3X8Xx9L97wxxZno8uJxvC4I1M/+R
	ZbHUbIng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqUo5-006djx-Fx; Tue, 08 Jun 2021 06:01:45 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqUo2-006djO-8H
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 06:01:43 +0000
Received: by mail-wm1-x336.google.com with SMTP id
 3-20020a05600c0243b029019f2f9b2b8aso1018611wmj.2
 for <linux-nvme@lists.infradead.org>; Mon, 07 Jun 2021 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HPnNNnFk8ZJfdOepiUgC87XNGbVnqt8OoqKJvYcxXMM=;
 b=X1aXA1thb11a2kyKlVa0sPlBbxSMNiRT2AVV9Rdw6tvifc2j0MI83o42qwXqBXrog+
 mF/g8yIP+ThoslfsdTpZg5UZxkP3R+FXjod7Lo7vbXKmxkGAfHyAWk5/cPVJomP50r6j
 0LegrCktFXzU7nFpQyAO/gZKC7dx1KeClWVv0qXw6XNm3A8Ztv5MiTbwrm4M0aiV2hlT
 25RudjAqbOlx/6Pktzrr1RDG4xmvDZcr+7sg5KCRB6h20GeuazPOJHPcvL1fL4pETzJ5
 1C1opJlfutU4aCTWQahRZLhHuT5PR8RaWNtJmtDYgpfz+XuMbmJPbArZ7lPCHXdBlV0X
 RJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HPnNNnFk8ZJfdOepiUgC87XNGbVnqt8OoqKJvYcxXMM=;
 b=IYQyg5C+EiT0mTv3nHihM/7mT6pVU1FMVa7UyHEL1OCpXmn61LqROkcMyaqoi59Tou
 GuWnuN3N9Hl3BIlw7i3COK9K02CLgXjM2pG4NdocuwfeHfp5tzDrbZW9vSKykH513kue
 4WHQJthcAQyIAHkRoBVX70SFmi9Op3JyKtVMSvsRmZ7OTZgJNO4TaMHKmHE6ktoHt+OF
 hhWkKZXddjcGUEyXGYhCkIltDi1+8/dWUkWOmr3oCNxyoufd3INTG1jGpE6EG2IrYvSz
 JopllDAU+fg1ahhoJZXq9U0QqREJ+xQY5qL8kRJGrp04n/EpP2KAXu3/JpjoSfSoiaSP
 YW5g==
X-Gm-Message-State: AOAM533TushP9zRG05d3DLLoffRNjVrnJvUbBWYU0zscYf5tNlI01C0D
 JGnM8++85vO//dCl6jmeAOA=
X-Google-Smtp-Source: ABdhPJxnySTQbq+Bn4oGnl+u7CvRfBOtu+sK+wz5uzXxsJGecEjC3JPWfbVtl8HcB9x9MSaxtI7Jaw==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr20108803wmi.106.1623132099755; 
 Mon, 07 Jun 2021 23:01:39 -0700 (PDT)
Received: from ?IPv6:2a02:908:1984:a6c0::ac4c? ([2a02:908:1984:a6c0::ac4c])
 by smtp.gmail.com with ESMTPSA id m3sm19354310wrr.32.2021.06.07.23.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jun 2021 23:01:39 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] ACPI: Add quirks for AMD Renoir/Lucienne CPUs to
 force the D3 hint
To: Mario Limonciello <mario.limonciello@amd.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-acpi@vger.kernel.org, rrangel@chromium.org,
 david.e.box@linux.intel.com, Shyam-sundar.S-k@amd.com,
 Nehal-bakulchandra.Shah@amd.com, Alexander.Deucher@amd.com,
 prike.liang@amd.com
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210607173156.5548-2-mario.limonciello@amd.com>
From: Julian Sikorski <belegdol@gmail.com>
Message-ID: <328f5fd7-f8d1-0543-a328-44ef0641c64b@gmail.com>
Date: Tue, 8 Jun 2021 08:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607173156.5548-2-mario.limonciello@amd.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_230142_323125_AF574FC0 
X-CRM114-Status: GOOD (  19.79  )
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

VyBkbml1IDA3LjA2LjIwMjEgb8KgMTk6MzEsIE1hcmlvIExpbW9uY2llbGxvIHBpc3plOgo+IEFN
RCBzeXN0ZW1zIGZyb20gUmVub2lyIGFuZCBMdWNpZW5uZSByZXF1aXJlIHRoYXQgdGhlIE5WTUUg
Y29udHJvbGxlcgo+IGlzIHB1dCBpbnRvIEQzIG92ZXIgYSBNb2Rlcm4gU3RhbmRieSAvIHN1c3Bl
bmQtdG8taWRsZQo+IGN5Y2xlLiAgVGhpcyBpcyAidHlwaWNhbGx5IiBhY2NvbXBsaXNoZWQgdXNp
bmcgdGhlIGBTdG9yYWdlRDNFbmFibGVgCj4gcHJvcGVydHkgaW4gdGhlIF9EU0QsIGJ1dCB0aGlz
IHByb3BlcnR5IHdhcyBpbnRyb2R1Y2VkIGFmdGVyIG1hbnkKPiBvZiB0aGVzZSBzeXN0ZW1zIGxh
dW5jaGVkIGFuZCBtb3N0IE9FTSBzeXN0ZW1zIGRvbid0IGhhdmUgaXQgaW4KPiB0aGVpciBCSU9T
Lgo+IAo+IE9uIEFNRCBSZW5vaXIgd2l0aG91dCB0aGVzZSBkcml2ZXMgZ29pbmcgaW50byBEMyBv
dmVyIHN1c3BlbmQtdG8taWRsZQo+IHRoZSByZXN1bWUgd2lsbCBmYWlsIHdpdGggdGhlIE5WTUUg
Y29udHJvbGxlciBiZWluZyByZXNldCBhbmQgYSB0cmFjZQo+IGxpa2UgdGhpcyBpbiB0aGUga2Vy
bmVsIGxvZ3M6Cj4gYGBgCj4gWyAgIDgzLjU1NjExOF0gbnZtZSBudm1lMDogSS9PIDE2MSBRSUQg
MiB0aW1lb3V0LCBhYm9ydGluZwo+IFsgICA4My41NTYxNzhdIG52bWUgbnZtZTA6IEkvTyAxNjIg
UUlEIDIgdGltZW91dCwgYWJvcnRpbmcKPiBbICAgODMuNTU2MTg3XSBudm1lIG52bWUwOiBJL08g
MTYzIFFJRCAyIHRpbWVvdXQsIGFib3J0aW5nCj4gWyAgIDgzLjU1NjE5Nl0gbnZtZSBudm1lMDog
SS9PIDE2NCBRSUQgMiB0aW1lb3V0LCBhYm9ydGluZwo+IFsgICA5NS4zMzIxMTRdIG52bWUgbnZt
ZTA6IEkvTyAyNSBRSUQgMCB0aW1lb3V0LCByZXNldCBjb250cm9sbGVyCj4gWyAgIDk1LjMzMjg0
M10gbnZtZSBudm1lMDogQWJvcnQgc3RhdHVzOiAweDM3MQo+IFsgICA5NS4zMzI4NTJdIG52bWUg
bnZtZTA6IEFib3J0IHN0YXR1czogMHgzNzEKPiBbICAgOTUuMzMyODU2XSBudm1lIG52bWUwOiBB
Ym9ydCBzdGF0dXM6IDB4MzcxCj4gWyAgIDk1LjMzMjg1OV0gbnZtZSBudm1lMDogQWJvcnQgc3Rh
dHVzOiAweDM3MQo+IFsgICA5NS4zMzI5MDldIFBNOiBkcG1fcnVuX2NhbGxiYWNrKCk6IHBjaV9w
bV9yZXN1bWUrMHgwLzB4ZTAgcmV0dXJucyAtMTYKPiBbICAgOTUuMzMyOTM2XSBudm1lIDAwMDA6
MDM6MDAuMDogUE06IGZhaWxlZCB0byByZXN1bWUgYXN5bmM6IGVycm9yIC0xNgo+IGBgYAo+IAo+
IFRoZSBNaWNyb3NvZnQgZG9jdW1lbnRhdGlvbiBmb3IgU3RvcmFnZUQzRW5hYmxlIG1lbnRpb25l
ZCB0aGF0IFdpbmRvd3MgaGFzCj4gYSBoYXJkY29kZWQgYWxsb3dsaXN0IGZvciBEMyBzdXBwb3J0
LCB3aGljaCB3YXMgdXNlZCBmb3IgdGhlc2UgcGxhdGZvcm1zLgo+IEludHJvZHVjZSBxdWlya3Mg
dG8gaGFyZGNvZGUgdGhlbSBmb3IgTGludXggYXMgd2VsbC4KPiAKPiBBcyB0aGlzIHByb3BlcnR5
IGlzIG5vdyAic3RhbmRhcmRpemVkIiwgT0VNIHN5c3RlbXMgdXNpbmcgQU1EIENlemFubmUgYW5k
Cj4gbmV3ZXIgQVBVJ3MgaGF2ZSBhZG9wdGVkIHRoaXMgcHJvcGVydHksIGFuZCBxdWlya3MgbGlr
ZSB0aGlzIHNob3VsZCBub3QgYmUKPiBuZWNlc3NhcnkuCj4gCj4gQ0M6IEp1bGlhbiBTaWtvcnNr
aSA8YmVsZWdkb2xAZ21haWwuY29tPgo+IENDOiBTaHlhbS1zdW5kYXIgUy1rIDxTaHlhbS1zdW5k
YXIuUy1rQGFtZC5jb20+Cj4gQ0M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPgo+IENDOiBSYWZhZWwgSi4gV3lzb2NraSA8cmp3QHJqd3lzb2NraS5uZXQ+Cj4g
Q0M6IFByaWtlIExpYW5nIDxwcmlrZS5saWFuZ0BhbWQuY29tPgo+IExpbms6IGh0dHBzOi8vZG9j
cy5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3MtaGFyZHdhcmUvZGVzaWduL2NvbXBvbmVudC1n
dWlkZWxpbmVzL3Bvd2VyLW1hbmFnZW1lbnQtZm9yLXN0b3JhZ2UtaGFyZHdhcmUtZGV2aWNlcy1p
bnRybwo+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxs
b0BhbWQuY29tPgo+IC0tLQoKVGVzdGVkLWJ5OiBKdWxpYW4gU2lrb3Jza2kgPGJlbGVnZG9sQGdt
YWlsLmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
