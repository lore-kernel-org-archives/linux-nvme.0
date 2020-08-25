Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1C5C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 15:00:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2262075F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 15:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yo0rCK+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2262075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=06V6CQc19yDsLwBhoqYHebmJUk4ayHUB4sMUjFv3LhQ=; b=yo0rCK+3F3sJCO0FIx2OtzfBt
	7W/eqRwvkD/BPu9aUHtzUvdjLR+MzH+Zr0e+CsZdZ5srm9oUydykmTPnKOb5EdRYga7S0W3pY14gB
	IQh3uRYYeuLZjas6y9pSBhM0oy0Rw7/TD8XIW7+IiDdYXUI6L8thKS7CEfCwnbq1aY8AJCQ011xtG
	XfFdPj5oaBsv5pONHh1rJLpuAC1wuo8Yj8sxRt8Ndf0RvAsKiUm3VZ4X22EJFemmB7mnPRuBG/lqS
	Yqhx9qG3rlrJmZ9yuBodQg/tjrcn4QFoHkoKsbSbDum57ArLQrhwbdgl7NqqGt68X8q8I4oFyDwUo
	XTC1f7oIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAaRM-0003vO-4C; Tue, 25 Aug 2020 15:00:48 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAaRJ-0003uU-LU
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 15:00:46 +0000
Received: by mail-pg1-f196.google.com with SMTP id v15so6999876pgh.6
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 08:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K1+FNc5UOjwYn0Zrr3r7dT5dVKeVt25MH8cG4Jb65yQ=;
 b=QQFGm5Cqnlpj8SCZaMzN0+0h+QUmkjWXn0d5s9Sq5fvf9RWMoAI+xzFhDgJat4UHWi
 zp1jvbsls8bOhNZUyhhHZMOozrUyulmjt4VvxG2x54ifYYy6WU2uamFsM0dXbIrhCaaT
 5PWPjCcpeMPVR2RG/y/gFeOzH1GoH7mAUmGLdmbeHo3k7WYhDJM6okxpS1QCMzT3ckbm
 ukulmTiqxvY5dSE0qIY4i7EK3uFy57C6Wrt72tA1FwgeFCA0pYJklM/GxGcb13ZSU0Qc
 Ax/fHoP9HHLBRlg5TsGRRMn/SaQRvCV2ZDeeiL0MdSOMcyLRCV48/g6ygsfsGtbojhuA
 5AIg==
X-Gm-Message-State: AOAM530j5XHA73vwX+VNZZsLZrVu6qJuQ8nZKfLGtAl5hpfRsAjI4GPt
 E+DdS+Cq15+xyuP08M8uxOrxdLXd1w6aHQ==
X-Google-Smtp-Source: ABdhPJxTQpMtDgJN0HUVwKZg2kchwBHdUHfO1aZ8B/TOEMCUqC9uFQeVaVn2HTBTsOJ6vtHIijjHSg==
X-Received: by 2002:a05:6a00:2b9:: with SMTP id
 q25mr8038921pfs.161.1598367642340; 
 Tue, 25 Aug 2020 08:00:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c51:77cf:ef42:8603?
 ([2601:647:4802:9070:4c51:77cf:ef42:8603])
 by smtp.gmail.com with ESMTPSA id w16sm3396430pjd.50.2020.08.25.08.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 08:00:41 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
 <20200825071345.GF29268@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
Date: Tue, 25 Aug 2020 08:00:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200825071345.GF29268@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_110045_725522_A77E8A75 
X-CRM114-Status: GOOD (  19.89  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IEkgY2hlY2tlZCBhZ2FpbiwgYW5kIHJlZ2FyZGluZyB0aGUgY29tbWVudDoKPj4KPj4gIkkn
bSBzdGlsbCByYXRoZXIgYm90aGVyZWQgd2l0aCB0aGUgYWRtaW4gcXVldWUgZXhjZXB0aW9uLiAg
QW5kIGdpdmVuIHRoYXQKPj4gdGhlIHFfdXNhZ2VfY291bnRlciBwcm9ibGVtIHNob3VsZCBvbmx5
IHJlYWxseSBiZSBhbiBpc3N1ZSBmb3IgZmlsZSBzeXN0ZW0KPj4gcmVxdWVzdHMsIGFzIHBhc3N0
aHJvdWdoIHJlcXVlc3RzIGRvIG5vdCBhdXRvbWF0aWNhbGx5IGdldCByZXRyaWVkIHdoeQo+PiBj
YW4ndCB3ZSBqdXN0IHJlamVjdCBhbGwgdXNlciBjb21tYW5kIHRvIGJlIHN5bWV0cmljIGFuZCBz
dHJhaWdodCBmb3J3YXJkPwo+PiBUaGUgY2FsbGVycyBpbiB1c2Vyc3BhY2UgbmVlZCB0byBiZSBh
YmxlIHRvIGNvcGUgd2l0aCByZXRyeWFibGUgZXJyb3JzCj4+IGFueXdheS4iCj4+Cj4+IGJsa19t
cV9hbGxvY19yZXF1ZXN0IGNhbGxzIGJsa19xdWV1ZV9lbnRlciwgd2hpY2ggbWVhbnMgdGhhdCBp
ZiB3ZSBkb24ndAo+PiBsZXQgdGhlbSBpbiwgY29udHJvbGxlciByZXNldCBjYW4gaGFuZywganVz
dCBsaWtlIGluIG5vcm1hbCBmcyBJL08uCj4gCj4gWWVzLiAgQnV0IHRoZSBkaWZmZXJlbmNlIGlz
IHRoYXQgdGhleSBkb24ndCBnZXQgcmV0cmll0ZUsIGJ1dCBpbnN0ZWFkIGp1c3QKPiBmYWlsLgoK
RG9lc24ndCBtYXR0ZXIuIFRoZSBpc3N1ZSBpcyB0aGF0IHdlIGdldCBhIHVzZXIgSS9PIHJlcXVl
c3QsIGVudGVycwp0aGUgcV91c2FnZV9jb3VudGVyLCBnb2VzIGludG8gcXVldWVfcnEsIHdlIGNo
ZWNrIGFuZCB3ZSBkZWNpZGUgd2Ugd2FudAp0byBmYWlsLiB0aGVuIGluIG52bWZfZmFpbF9ub25y
ZWFkeV9jb21tYW5kIHdlIHJldHVybiBCTEtfU1RTX1JFU09VUkNFLAphbmQgdGhlIHJlcXVlc3Qg
cmV0cmllZCBhbmQgZmFpbGVkIGFnYWluLi4uIFVudGlsIGl0cyBhbGxvd2VkIHRvIHBhc3MKdGhy
b3VnaCAod2hlbiB0aGUgY29udHJvbGxlciBpcyBMSVZFIGFnYWluKS4KCklmIHNvbWVvbmUgZnJl
ZXplIHRoZSBxdWV1ZSwgaXQgY2Fubm90IGJlY2F1c2Ugd2UgaGF2ZSBhbiBlbnRlcmVkIApyZXF1
ZXN0IHRoYXQgd2lsbCBuZXZlciBjb21wbGV0ZS4KCgo+PiBTbyB3ZSBlaXRoZXIga2VlcCB0aGlz
IGV4Y2VwdGlvbiBmb3IgYWRtaW4gY29tbWFuZHMsIG9yIHdlIGFsc28gbGV0Cj4+IHRoZW0gdGhy
b3VnaCBhcyBpdCBzZWVtcyB0byBiZSBzYWZlIHdpdGggdGhlIGN1cnJlbnQgY29kZSAoZnJvbSB0
aGUKPj4gcmVzZXQgZm9yd2FyZC1wcm9ncmVzcyBwZXJzcGVjdGl2ZSkuCj4+Cj4+IEkgdm90ZSB0
byByZW1vdmUgdGhpcyBleGNlcHRpb24gYWx0b2dldGhlci4uLgo+IAo+IFRvIG1lIHRoZSByaWdo
dCBhbnN3ZXIgd291bGQgYmUgdG8gcmVqZWN0IHVzZXIgY29tbWFuZHMgb24gdGhlIGFkbWluCj4g
b3IgSS9PIHF1ZXVlIGZvciB0aGUgbm90IGxpdmUgY29udHJvbGxlciBhcyB0aGUgY2FsbGVycyBu
ZWVkIHRvIGhhbmRsZQo+IGl0LiAgVGhhdCBzZWVtcyB0byBtYWtlIG1vcmUgc2Vuc2UgdG8gbWUg
dGhhbiBhIHNwZWNpYWwgYWRtaW4gcXVldWUKPiBleGNlcHRpb24uCgpTbyB5b3Ugc2F5IHRoYXQg
d2Ugc2hvdWxkIG5ldmVyIHJldHVybiBCTEtfU1RTX1JFU09VUkNFIGJ1dCByYXRoZXIgZmFpbAph
bGwgcmVxdWVzdHM/IHJlZ2FyZGxlc3MgZm9yIG11bHRpcGF0aCBvciBub3Q/CgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
