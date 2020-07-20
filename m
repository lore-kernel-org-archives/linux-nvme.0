Return-Path: <SRS0=fGVD=A7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC5BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:41:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7638207DF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2020 19:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Kwa0Gfkc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7638207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sF7Gt+R1rfXXDlOydDTjVLPW+SrtNJH3VbMYf0PQr8g=; b=Kwa0GfkccTq9vypQrPzG+OHkl
	GpijreG8CHNAwDapqVZgFVGO8EhKJiMC1A1//UpLrMkWItHduohykdQFZqfvNrRkgVMqfr+xwfuO2
	AhORm0FpicxTxqriLYCkqs4pANEHdmGosHVXQs7OHGMfPKsDgAnRviKFZPFGRpaRTrr0AGuP+8gja
	PufxlHj+v47qJYOn7Ev0GFiCkEDnWQk2RIf8DtXN5GNWwsUfqC8KfTa2j5S5+xEecssru3ZBR9ZYB
	C8YmPmuIggAin8iF8gsvB5D6+4raZr9OmC2SJKw3wbxwcxnG8yobSa19doSRTl2Yju19pZ5JZ19TM
	tC9PyEmuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxbf8-0001Pj-W9; Mon, 20 Jul 2020 19:41:23 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxbf6-0001P7-T2
 for linux-nvme@lists.infradead.org; Mon, 20 Jul 2020 19:41:21 +0000
Received: by mail-pl1-f195.google.com with SMTP id l6so9144737plt.7
 for <linux-nvme@lists.infradead.org>; Mon, 20 Jul 2020 12:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xq6rRkupV48/Q+eMS+zHlGiSC3TOvOgXF/JqrFNgXPc=;
 b=MgGAtUQxQwJMK4Ctdf/jTOrceyq/cPyfB1WcyJRzxOZj5qAinBNFLlnW6Q55lxmGFN
 XBvni5immQ+j2fOIrDz0VwigzbPT/iBrUtx/eRmuSw5F+Tcn+LDq1JUGhQ5D+Yu1+hOt
 QN+Gge/eEK+F6gLL/ja8kETWi3vL9jqr9BJNa6fZqHahNa99iWtR0jI4BEFBDaJpSZb6
 c5A6XF9mSbdvdvpUTXq6H4WwKfV8tCsrd3GJymxitL3PAAlHmLfffYVL5tEQyPtq7KMr
 tb7RxyKFmEHYU7tZbGfzH6o16RI0DKnkGKwjyGXFvE7lHaa7WSIcARrLcM2sLe5khH87
 bE1w==
X-Gm-Message-State: AOAM532LkcgoohX00VGprgtG/+3N4LRBUCv38FLxbib7W98EhyL66TtR
 hlAN1pgodD3IxnnvOENHRQQECqfP
X-Google-Smtp-Source: ABdhPJwy5xn/FdEEsWXNe9pEgf0EH2B76npy9WOHhhcAQvLjq6nvwfpslwp34IJbMhVDlq2XGKi0Mg==
X-Received: by 2002:a17:90a:206a:: with SMTP id
 n97mr968836pjc.94.1595274079418; 
 Mon, 20 Jul 2020 12:41:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:81fd:84d6:3c38:f7ef?
 ([2601:647:4802:9070:81fd:84d6:3c38:f7ef])
 by smtp.gmail.com with ESMTPSA id y7sm367553pjy.54.2020.07.20.12.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 12:41:18 -0700 (PDT)
Subject: Re: [PATCH V4 2/2] nvme-core: use xarray for ctrl ns tracking
To: Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
References: <20200720033203.11474-1-chaitanya.kulkarni@wdc.com>
 <20200720033203.11474-3-chaitanya.kulkarni@wdc.com>
 <20200720133454.GA2837@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bd710102-c37c-30a5-bc06-d175288f3c59@grimberg.me>
Date: Mon, 20 Jul 2020 12:41:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720133454.GA2837@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_154120_942410_F41B4D03 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IFRoaXMgcGF0Y2ggcmVwbGFjZXMgdGhlIGN0cmwtPm5hbWVzcGFjZXMgdHJhY2tpbmcgZnJv
bSBsaW5rZWQgbGlzdCB0bwo+PiB4YXJyYXkgYW5kIGltcHJvdmVzIHRoZSBwZXJmb3JtYW5jZS4g
Rm9yIGhvc3QgZXZlbiB0aG91Z2gKPj4gbnZtZV9maW5kX2dldF9ucygpIGRvZXNuJ3QgZmFsbCBp
bnRvIHRoZSBmYXN0IHBhdGggeWV0IGl0IGRvZXMgZm9yCj4+IE5WTWVPRiBwYXNzdGhydSBwYXRj
aC1zZXJpZXMgd2hpY2ggaXMgY3VycmVudGx5IHVuZGVyIHJldmlldy4gVGhpcwo+PiBwcmVwYXJl
cyB1cyB0byBpbXByb3ZlIHBlcmZvcm1hbmNlIGZvciBmdXR1cmUgTlZNZU9GIHBhc3N0aHJ1IGJh
Y2tlbmQKPj4gc2luY2UgbnZtZV9maW5kX2dldF9ucygpIHVzZXMgc2FtZSBkYXRhIHN0cnVjdHVy
ZSBhcyBpdCBkb2VzIGluIHRhcmdldAo+PiB0byBmaW5kIG5hbWVzcGFjZSBpbiBJL08gcGF0Y2gg
ZnJvbSBuc2lkIHNwZWNpZmllZCBpbiB0aGUgbnZtZV9yd19jbWQuCj4gCj4g0IYnbSBzdGlsbCBu
b3QgcmVhbGx5IHNvbGQgb24gdGhhdCByYXRpb25hbGUuLgoKSSB0aGluayB0aGF0IHlvdXIgc3Vn
Z2VzdGlvbiB0byBoYXZlIGEgcGFzc3RocnVfcSBpcyBhIG11Y2ggbW9yZQplbGVnYW50IHNvbHV0
aW9uIChhbHRob3VnaCBpdCBwcm9iYWJseSBjYW5ub3QgYmUgdW5pZmllZCB3aXRoIHRoZQpjb25u
ZWN0X3Egd2hpY2ggc2hvdWxkIGJlIGFibGUgdG8gbWFrZSBmb3J3YXJkIHByb2dyZXNzIG9uIGEg
cXVpZXNjZWQKcXVldWUgYXMgd2VsbCBmb3IgZmFicmljcykuCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
