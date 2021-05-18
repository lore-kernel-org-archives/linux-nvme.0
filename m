Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9BBC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:00:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE49D611BF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 18:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE49D611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=dWNO+QuBGweYJT9tVl4y+UFWuzr0YpAwk1UmYhyIr/c=; b=Yovj97UCTmCiC59DsmjEvsb5o
	AhytSEDQrvYIAZgBiD2fDrSFRykpPU1J/Vu6UnAnlekTLkoMUmWwo/7Hv0reMpM9LVAR6F8Gm0o3F
	qlHODrdAIRrlgJtR0o8QqqbHxx1+O/irdof4H5JJhZTqiQPbokyqj//vYgPiYIah7f/rabyqxKszV
	hp6o077w9+e1vXnoAIC8LkgYiTkqwL3AnvZJ5SbOT8yVUKz4Mk0KxcodEMvf2GIkA6eWb3jpZQrFe
	nTzCI0wtlG7g1YfowmXziXpJsp4GAD9/S45W+tsmb2yF6sZeO6qKTrk41ZY3hZpCqVlE28XQuBTJD
	buU3EBKFw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj417-001YT3-D5; Tue, 18 May 2021 18:00:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj414-001YSu-Rj
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 18:00:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=5dUWlsnLJ5V2VZ+iMzdbGOZ0P6OiTx5/jrBZLglTO4c=; b=BCER4K4MRwqRC9sbYJm8mArjhI
 4MVs+o0i4olYoWUi/EZsOwTU4ULDMN291DoUaG74tg4K8SSHm1JDQJXfOZ31q1tZGFYJbgOdZxiGC
 kN1Ho1Ghrayvjmt/db39WzK0wzSOlEuv4jLbMQYzQsmPSpHuCA5Y2lirHryv0KNdKwJAULnHX70JY
 /EYk5havP4rzjeMEOb8cW4C79PLsigtwuWCpYNiNLTim3DC5fMiCTJgQswneXqiigsHZb9elbRvwc
 5v1TYZVl0jryXgvIXMl3u5YmMjmahQW2n+sO048+OWS4GbPcj5mIXJM2sVEnmYnpSc19DwY3F4Gpq
 cNhdHIAw==;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj412-00ErKy-4x
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 18:00:25 +0000
Received: by mail-wr1-f53.google.com with SMTP id r12so11229153wrp.1
 for <linux-nvme@lists.infradead.org>; Tue, 18 May 2021 11:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dUWlsnLJ5V2VZ+iMzdbGOZ0P6OiTx5/jrBZLglTO4c=;
 b=E6INLUBtmoWi/NkLKdeyJMF9E17jTadHWB5S9ePdz14rn4mvZo1cHou/YZBmgeaPaz
 wU2bbjE//6XHKaHxvf7Di3lPbgaAOnvzdMicBcb6b24F7nebikT/kxj1PJX7Wj7Ic76g
 qKF6mCohPm4SRVjyiG1yepr0VvOYifqechn0WimXw9/1SBnL4NOaQHdZGM87WM26f2Ap
 fO6OmvvTxfivYdBqaAtJv5QRzJDQlYi6J9fmrUfR58X6WDYVMSXaIXcMI3S2sLFGTLtJ
 8TnRrP3wriu7UQ4rzP29EtJky47XPUAqhEOyE0pcSHf8c/pk7cR5qsrQ0vymQtY5NLZk
 lAsQ==
X-Gm-Message-State: AOAM5333dnN8UwEq+jUPFQYEpvQGNWtOKWbx/5dyOO3K7rvHx85KpIRL
 RBaMuit91fPCt9NIBq51BrxPYQMCSRM=
X-Google-Smtp-Source: ABdhPJyNsPTY4bj3mBY5JBKzR5eA1PfsP8YURey5GMecIR3zyDdPNtFwXSgf3uCHeoNfE+GYEOxKwQ==
X-Received: by 2002:a05:6000:cb:: with SMTP id
 q11mr8718320wrx.72.1621360822078; 
 Tue, 18 May 2021 11:00:22 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f888:e3f1:214b:6edc?
 ([2601:647:4802:9070:f888:e3f1:214b:6edc])
 by smtp.gmail.com with ESMTPSA id d3sm22616602wrs.41.2021.05.18.11.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 11:00:21 -0700 (PDT)
Subject: Re: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210517083215.105604-1-hare@suse.de>
 <32bda760-9d71-c063-565e-e3a79b8c3135@grimberg.me>
 <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <deb1d103-8fc6-6f38-f9e9-d3a327ea5678@grimberg.me>
Date: Tue, 18 May 2021 11:00:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2174fba2-9c43-b92c-ea73-da59cd91d3ca@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_110024_207440_9CCED6C8 
X-CRM114-Status: GOOD (  14.53  )
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

Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMgCj4+PiBiL2Ry
aXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+PiBpbmRleCAwNTUxNzk2NTE3ZTYuLmVjYzk5
YmQ1ZjhhZCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4gQEAgLTEwMCw4ICsxMDAs
MTEgQEAgdm9pZCBudm1lX2tpY2tfcmVxdWV1ZV9saXN0cyhzdHJ1Y3QgbnZtZV9jdHJsIAo+Pj4g
KmN0cmwpCj4+PiDCoMKgwqDCoMKgIGRvd25fcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7
Cj4+PiDCoMKgwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnkobnMsICZjdHJsLT5uYW1lc3BhY2Vz
LCBsaXN0KSB7Cj4+PiAtwqDCoMKgwqDCoMKgwqAgaWYgKG5zLT5oZWFkLT5kaXNrKQo+Pj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAga2Jsb2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVhZC0+cmVx
dWV1ZV93b3JrKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW5zLT5oZWFkLT5kaXNrKQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+PiArwqDCoMKgwqDCoMKgwqAga2Js
b2NrZF9zY2hlZHVsZV93b3JrKCZucy0+aGVhZC0+cmVxdWV1ZV93b3JrKTsKPj4+ICvCoMKgwqDC
oMKgwqDCoCBpZiAoY3RybC0+c3RhdGUgPT0gTlZNRV9DVFJMX0xJVkUpCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkaXNrX3VldmVudChucy0+aGVhZC0+ZGlzaywgS09CSl9DSEFOR0UpOwo+
Pj4gwqDCoMKgwqDCoCB9Cj4+Cj4+IEkgYXNrZWQgdGhpcyBvbiB2MSwgaXMgdGhpcyBvbmx5IG5l
ZWRlZCBmb3IgbXBhdGggZGV2aWNlcz8KPiAKPiBZZXM7IHdlIG5lZWQgdG8gc2VuZCB0aGUgS09C
Sl9DSEFOR0UgZXZlbnQgb24gdGhlIG1wYXRoIGRldmljZSBhcyBpdCdzIAo+IG5vdCBiYWNrZWQg
YnkgaGFyZHdhcmUuIFRoZSBvbmx5IG5vbi1tdWx0aXBhdGhlZCBkZXZpY2VzIEkndmUgc2VlbiBz
byAKPiBmYXIgYXJlIFBDSSBkZXZpY2VzIHdoZXJlIGV2ZW50cyBhcmUgZ2VuZXJhdGVkIGJ5IHRo
ZSBQQ0kgZGV2aWNlIGl0c2VsZi4KCkFuZCBmb3IgZmFicmljcz8KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
