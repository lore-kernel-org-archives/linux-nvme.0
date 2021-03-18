Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423FBC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:46:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF62364F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF62364F2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FXBjRYKqBtKULSPaaNdfYxUrsrG4QgPX4SAfiKSJHik=; b=BkTbRRnbe0vOFwZ67B7W066ep
	E3udlbLiCpw+8xtLfXus+/LtInxjM05ze8U8Po/2u0kZyewgpX1zWGMNWLm/EvjzkOaspipi6Fwya
	MfTdZQg08byr74NVa0vCiC189X5uDnKOFFshdpsDfGlBoBiT7VmLXbByNHM//sPAiQqDlJkqImkv4
	gh3TjAv7GgM/UCMRgJ6O1p3XjVJWWBfZPFonsR7wYFksdvtVYAAGWSeI4Gs+tM1Swje5mz1bad7BO
	AwqG2X2+M8pJ9V5gwLm47t6/zFcF6ckjVr6V85msQK18iiCJ1KgyfI4hMlCYmWZLjnwcCWaFz3dbG
	yiwnbtYfQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMxf5-005sQD-29; Thu, 18 Mar 2021 18:46:23 +0000
Received: from mail-pg1-f178.google.com ([209.85.215.178])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMxev-005sNw-Hu
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 18:46:17 +0000
Received: by mail-pg1-f178.google.com with SMTP id l1so2025311pgb.5
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 11:46:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fZVuNzDc/dRANAGrG8nVbnMAJ9kjSw7HDXoum2hx/VM=;
 b=LirvuNWkb3JcKyORBPB2E5EFwBSBjFZivmTDXuIs4WcwMfJY88zZvTxg3/dDUBzMDe
 tECW1vIL67qOPvAfd6MQxXbOBLPsng+0RXKJl+u1ejW7SJGs5lNOMuvOx2Rzv3ge1Xxh
 rj5jRJ4B0XPXhIadx5KI70bQiRjTlzKeJDtb835EAKNtqpsJuU3igJDnwtw40+V8vy+x
 XzL7J38/snB/BhEEjUhiSxJFI3p0v165RQnWNWRGS3y4G9iEGJYvETQVZibV7lyhnPZv
 5sq6nUEwt2BDLXPYM4TZxk7p+N/rAuIwyXCu7ggkE1HXG8hwiTODCh8DWF/Suj1+uYQN
 9LpA==
X-Gm-Message-State: AOAM531rQYlNqz36Ierg2+LKbfD4FC7LjTp5CBV3Np9RbLptwnYL1CZg
 k72SwHk6c5l+R9pAYH/kCII=
X-Google-Smtp-Source: ABdhPJzB0obri+croUpuRYutI0f5ZhAfdDuxv25OX+8fxrNviXPCTOVZun3QT8bp9iQnAIdEil88iA==
X-Received: by 2002:a62:5cc3:0:b029:203:54be:e4c9 with SMTP id
 q186-20020a625cc30000b029020354bee4c9mr5465808pfb.80.1616093170718; 
 Thu, 18 Mar 2021 11:46:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:ce5f:588:9ba1:3bac?
 ([2601:647:4802:9070:ce5f:588:9ba1:3bac])
 by smtp.gmail.com with ESMTPSA id x186sm3055303pfc.65.2021.03.18.11.46.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Mar 2021 11:46:10 -0700 (PDT)
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
Date: Thu, 18 Mar 2021 11:46:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_184614_610813_17A63A28 
X-CRM114-Status: GOOD (  29.44  )
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

Cj4+Pj4+Pj4gV2lsbCBpdCB3b3JrIGlmIG52bWUgbXBhdGggdXNlZCByZXF1ZXN0IE5PV0FJVCBm
bGFnIGZvciBpdHMgCj4+Pj4+Pj4gc3VibWl0X2JpbygpCj4+Pj4+Pj4gY2FsbCwgYW5kIGFkZCB0
aGUgYmlvIHRvIHRoZSByZXF1ZXVlX2xpc3QgaWYgYmxrX3F1ZXVlX2VudGVyKCkgCj4+Pj4+Pj4g
ZmFpbHM/IEkKPj4+Pj4+PiB0aGluayB0aGF0IGxvb2tzIGxpa2UgYW5vdGhlciB3YXkgdG8gcmVz
b2x2ZSB0aGUgZGVhZGxvY2ssIGJ1dCB3ZSAKPj4+Pj4+PiBuZWVkCj4+Pj4+Pj4gdGhlIGJsb2Nr
IGxheWVyIHRvIHJldHVybiBhIGZhaWxlZCBzdGF0dXMgdG8gdGhlIG9yaWdpbmFsIGNhbGxlci4K
Pj4+Pgo+Pj4+IFllcywgSSB0aGluayBCTEtfTVFfUkVRX05PV0FJVCBtYWtlcyB0b3RhbCBzZW5z
ZSBoZXJlLsKgIGRtLW1wYXRoIGFsc28KPj4+PiB1c2VzIGl0IGZvciBpdHMgcmVxdWVzdCBhbGxv
Y2F0aW9uIGZvciBzaW1pbGFyIHJlYXNvbnMuCj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBCdXQgd2hvIHdv
dWxkIGtpY2sgdGhlIHJlcXVldWUgbGlzdD8gYW5kIHRoYXQgd291bGQgbWFrZSAKPj4+Pj4+IG5l
YXItdGFnLWV4aGF1c3QgcGVyZm9ybWFuY2Ugc3RpbmsuLi4KPj4+Pgo+Pj4+IFRoZSBtdWx0aXBh
dGggY29kZSB3b3VsZCBoYXZlIHRvIGtpY2sgdGhlIGxpc3QuwqAgV2UgY291bGQgYWxzbyB0cnkg
dG8KPj4+PiBzcGxpdCBpbnRvIHR3byBmbGFncywgb25lIHRoYXQgYWZmZWN0cyBibGtfcXVldWVf
ZW50ZXIgYW5kIG9uZSB0aGF0Cj4+Pj4gYWZmZWN0cyB0aGUgdGFnIGFsbG9jYXRpb24uCj4+Pj4K
Pj4+Pj4gbW92aW5nIG52bWVfc3RhcnRfZnJlZXplIGZyb20gbnZtZV9yZG1hX3RlYXJkb3duX2lv
X3F1ZXVlcyB0byAKPj4+Pj4gbnZtZV9yZG1hX2NvbmZpZ3VyZV9pb19xdWV1ZXMgY2FuIGZpeCBp
dC4KPj4+Pj4gSXQgY2FuIGFsc28gYXZvaWQgSS9PIGhhbmcgbG9uZyB0aW1lIGlmIHJlY29ubmVj
dGlvbiBmYWlsZWQuCj4+Pj4KPj4+PiBDYW4geW91IGV4cGxhaW4gaG93IHdlJ2Qgc3RpbGwgZW5z
dXJlIHRoYXQgbm8gbmV3IGNvbW1hbmRzIGdldCBxdWV1ZWQKPj4+PiBkdXJpbmcgdGVhcmRvd24g
dXNpbmcgdGhhdCBzY2hlbWU/Cj4+PiAxLiB0ZWFyIGRvd24gd2lsbCBjYW5jZWwgYWxsIGluZmxp
Z2h0IHJlcXVlc3RzLCBhbmQgdGhlbiBtdWx0aXBhdGggCj4+PiB3aWxsIGNsZWFyIHRoZSBwYXRo
Lgo+Pj4gMi4gYW5kIHRoZW4gd2UgbWF5IGZyZWV6ZSB0aGUgY29udHJvbGVyLgo+Pj4gMy4gbnZt
ZV9uc19oZWFkX3N1Ym1pdF9iaW8gY2FuIG5vdCBmaW5kIHRoZSByZWNvbm5lY3Rpb24gY29udHJv
bGxlciAKPj4+IGFzIHZhbGlkIHBhdGgsIHNvIGl0IGlzIHNhZmUuCj4+Cj4+IEluIG5vbi1tcGF0
aCAod2hpY2ggdW5mb3J0dW5hdGVseSBpcyBhIHZhbGlkIHVzZS1jYXNlKSwgdGhlcmUgaXMgbm8K
Pj4gZmFpbG92ZXIsIGFuZCB3ZSBjYW5ub3QgZnJlZXplIHRoZSBxdWV1ZSBhZnRlciB3ZSBzdG9w
cGVkIChhbmQvb3IKPj4gc3RhcnRlZCkgdGhlIHF1ZXVlcyBiZWNhdXNlIHRoZW4gZmFpbF9ub25f
cmVhZHlfY29tbWFuZCgpIGNvbnN0YW50bHkgCj4+IHJldHVybiBCTEtfU1RTX1JFU09VUkNFIChq
dXN0IGNhdXNpbmcgYSByZS1zdWJtaXNzaW9uIG92ZXIgYW5kIG92ZXIKPj4gYWdhaW4pIGFuZCB0
aGUgZnJlZXplIHdpbGwgbmV2ZXIgY29tcGxldGUgKHRoZSBjb21tYW5kcyBhcmUgc3RpbGwKPj4g
aW5mbGlnaHQgZnJvbSB0aGUgcXVldWUtPmdfdXNhZ2VfY291bnRlciBwZXJzcGVjdGl2ZSkuCj4g
SWYgdGhlIHJlcXVlc3Qgc2V0IHRoZSBmbGFncyB0byBSRVFfRkFJTEZBU1RfeHh4LCB3aWxsIGhh
bmcgbG9uZyB0aW1lIGlmIAo+IHJlY29ubmVjdGlvbiBmYWlsZWQuCj4gVGhpcyBpcyBub3QgZXhw
ZWN0ZWQuCj4gQW5vdGhlciwgSWYgdGhlIGNvbnRyb2xsZXIgaXMgbm90IGxpdmUgYW5kIHRoZSBj
b250cm9sbGVyIGlzIGZyZWV6ZWQgCj4g77yMZmFzdF9pb19mYWlsX3RtbyB3aWxsIG5vdCB3b3Jr
Lgo+IFRoaXMgaXMgYWxzbyBub3QgZXhwZWN0ZWQuCgpObyBhcmd1bWVudHMgdGhhdCB0aGUgcXVl
dWUgbmVlZHMgdG8gdW5mcmVlemUgYXNhcCBmb3IgbXBhdGgsIHRoYXQKaXMgZXhhY3RseSB3aGF0
IHRoZSBwYXRjaCBkb2VzLiBUaGUgb25seSB1bm5hdHVyYWwgcGFydCBpcyB0aGUKbm9uLW1wYXRo
IGNhc2Ugd2hlcmUgaWYgd2UgdW5mcmVlemUgdGhlIHF1ZXVlIGJlZm9yZSB3ZSByZWNvbm5lY3QK
SS9PcyB3aWxsIGZhaWwsIHdoaWNoIGlzIHdlIHNob3VsZCBhbHNvIHJlc3BlY3QgZmFzdF9mYWls
X3Rtby4KClRoZSBtYWluIGlzc3VlIGhlcmUgaXMgdGhhdCB0aGVyZSBhcmUgdHdvIGJlaGF2aW9y
cyB0aGF0IHdlCnNob3VsZCBtYWludGFpbiBiYXNlZCBpZiBpdHMgbXBhdGggb3Igbm9uLW1wYXRo
Li4uCgo+IFNvIEkgdGhpbmsgZnJlZXppbmcgdGhlIGNvbnRyb2xsZXIgd2hlbiByZWNvbm5lY3Rp
bmcgaXMgbm90IGdvb2QgaWRlYS4KCkFzIHNhaWQsIGZvciBtcGF0aCBpdHMgZm9yIHN1cmUgbm90
LCBidXQgZm9yIG5vbi1tcGF0aCB0aGF0IG1hdGNoZXMKdGhlIGV4cGVjdGVkIGJlaGF2aW9yLgoK
PiBJdCdzIHJlYWxseSBub3QgZ29vZCBiZWhhdmlvciB0byB0cnkgYWdhaW4gYW5kIGFnYWluLiBU
aGlzIGlzIGF0IGxlYXN0IAo+IGJldHRlciB0aGFuIHJlcXVlc3QgaGFuZyBsb25nIHRpbWUuCgpJ
IGFtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCBob3cgdGhhdCBldmVuIHN1cHBvc2VkIHRvIHdvcmsg
VEJILgoKPj4gU28gSSB0aGluayB3ZSBzaG91bGQgc3RpbGwgc3RhcnQgcXVldWUgZnJlZXplIGJl
Zm9yZSB3ZSBxdWllc2NlCj4+IHRoZSBxdWV1ZXMuCj4gV2Ugc2hvdWxkIHVucXVpZXNjZSBhbmQg
dW5mcmVlemUgdGhlIHF1ZXVlcyB3aGVuIHJlY29ubmVjdGluZywgb3RoZXJ3aXNlIAo+IGZhc3Rf
aW9fZmFpbF90bW8gd2lsbCBub3Qgd29yay4KPj4KPj4gSSBzdGlsbCBkb24ndCBzZWUgaG93IHRo
ZSBtcGF0aCBOT1dBSVQgc3VnZ2VzdGlvbiB3b3JrcyBlaXRoZXIuLi4KPiBtcGF0aCB3aWxsIHF1
ZXV1ZSByZXF1ZXN0IHRvIG90aGVyIGxpdmUgcGF0aCBvciByZXF1ZXVlIHRoZSByZXF1ZXN0KGlm
IAo+IG5vIHVzZWQgcGF0aCksIHNvIGl0IHdpbGwgbm90IHdhaXQuCgpQbGFjaW5nIHRoZSByZXF1
ZXN0IG9uIHRoZSByZXF1ZXVlX2xpc3QgaXMgZmluZSwgYnV0IHRoZSBxdWVzdGlvbiBpcwp3aGVu
IHRvIGtpY2sgdGhlIHJlcXVldWVfd29yaywgbm90aGluZyBndWFyYW50ZWVzIHRoYXQgYW4gYWx0
ZXJuYXRlIHBhdGgKZXhpc3Qgb3Igd2lsbCBpbiBhIHNhbmUgcGVyaW9kLiBTbyBjb25zdGFudGx5
IHJlcXVldWUra2ljayBzb3VuZHMgbGlrZQphIHJlYWxseSBiYWQgcHJhY3RpY2UgdG8gbWUuCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
