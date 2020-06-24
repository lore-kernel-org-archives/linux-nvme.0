Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC2BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817D12082F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 19:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L5o7jg4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817D12082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N4cBPrkrGeVw3E93+nt5ruDwyVmoxvu1ji5qQ3ERm5o=; b=L5o7jg4XmxYZvzmEpnn1TZwAD
	XdIHNX7vw2oJFid4wM1kfqYnh8oKc2s6h6nEu5WWsZJV8GAc1OOx0a2OzADK410dJXU5cUp26Rglo
	zMJ6RzQ1qOimOqIfzMVb1Cm1FH79lv/B2Y0/pHTzi998zJXvUwuiFSSfzFsjSl2JOqUh4ec8mUMXE
	2r9Vl7nGydN3MltkDblTIRrPDVBg89RsDjwVIRKEXMWwMnDCtl7FMVnKD6809WBA6ZuV8dAp0Q4V6
	8fjHFVjDoviyDein08SzNYHHG01G+j0zhZcx+stgaQCvzhUX4yJS4eF1PTgQ83yNwPI2Yns38esL/
	jWtzz9dgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joAgV-0001QK-Cl; Wed, 24 Jun 2020 19:03:47 +0000
Received: from mail-pg1-f193.google.com ([209.85.215.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joAgS-0001PV-Pi
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 19:03:45 +0000
Received: by mail-pg1-f193.google.com with SMTP id t6so1865416pgq.1
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 12:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CxnPLwafznlw6uJemM271g2mVdpK3sZFeqy60qOzhic=;
 b=Ju3wNIp2ClOFccm7FhjcRPcE1t9nl57Th6qdQY35CDsq17HxQD2fNsyKifoQ4affU/
 knxHupwYZwgHg2yZWOZPrk+jfMX+gWmOWwd/ll3KBGm29oAYqvWW+VB8j43L+u/b9WlC
 NvB+hvqJ1KArN46/COvb/SyJ5owD6LcNhdUDQqv7PkddMOSxRPKuMYOIENj0xo2qqH8x
 P2yciX1LmVtOZaS9xEi9N3uIr/pG7ubWEqotq9ZHWheFwI+yQfe8+FSNf8NgnX0oeq5s
 Ns3E6RlbRPZB6v0SHHfJCket6X4TCp03qQHscFv3KiEOYnwguCH977zoGztenVx9GTBI
 E3jw==
X-Gm-Message-State: AOAM530RwTS2KBuJrqFi29OlmDMhNiqk04x8wpBXK0XURzQ3wuUwjqbs
 7wM9BOFriL2T4mCae7IsH7s=
X-Google-Smtp-Source: ABdhPJy/Hj214+mQy5P/DMkoPRn1OUvSUd/hKX06vUukopctG/W4/3m3RFpmd44LPrnBmlYJyPLaUg==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr7035532pfn.219.1593025423919; 
 Wed, 24 Jun 2020 12:03:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947?
 ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id 4sm20391425pfn.205.2020.06.24.12.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 12:03:42 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set support
To: Keith Busch <kbusch@kernel.org>
References: <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
 <20200624180323.GE1291930@dhcp-10-100-145-180.wdl.wdc.com>
 <1ddbf614-f5a7-a265-b1a2-7c5ed0922f18@grimberg.me>
 <76966a48-0588-3f3c-0ec1-842cd2ac413d@grimberg.me>
 <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <06623bef-7269-f45b-9f43-8c854ddf812d@grimberg.me>
Date: Wed, 24 Jun 2020 12:03:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624184016.GF1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 "hch@lst.de" <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gSWYgdGhlIGNvbnRyb2xsZXIgZG9lcyBub3Qgc3VwcG9ydCB0aGUgQ05TIHZhbHVlLCBp
dCBtYXkgcmV0dXJuIEludmFsaWQKPj4+PiBGaWVsZCB3aXRoIEROUiBzZXQuIFRoYXQgZXJyb3Ig
Y3VycmVudGx5IGdldHMgcHJvcG9nYXRlZCBiYWNrIHRvCj4+Pj4gbnZtZV9pbml0X25zX2hlYWQo
KSwgd2hpY2ggdGhlbiBhYmFuZG9ucyB0aGUgbmFtZXNwYWNlLiBKdXN0IGFzIHRoZSBjb2RlCj4+
Pj4gY29tZW50cyBzYXksIHdlIGhhZCBiZWVuIGhpc3RvcmljYWxseSBiZWVuIGNsZWFyaW5nIHN1
Y2ggZXJyb3JzIGJlY2F1c2UKPj4+PiB3ZSBoYXZlIG90aGVyIHdheXMgdG8gaWRlbnRpZnkgdGhl
IG5hbWVzcGFjZSwgYnV0IG5vdyB3ZSdyZSBub3QgY2xlYXJpbmcKPj4+PiB0aGF0IGVycm9yLgo+
Pj4KPj4+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IHlvdSBhcmUgc2F5aW5nIEtlaXRoLgo+Pj4K
Pj4+IE15IGNvbW1lbnQgd2FzIGZvciB0aGlzIGJsb2NrOgo+Pj4gLS0gCj4+PiAgIMKgwqDCoMKg
aWYgKCFzdGF0dXMgJiYgbnZtZV9tdWx0aV9jc3MoY3RybCkgJiYgIWNzaV9zZWVuKSB7Cj4+PiAg
IMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKGN0cmwtPmRldmljZSwgIkNvbW1hbmQgc2V0IG5vdCBy
ZXBvcnRlZCBmb3IgbnNpZDolZFxuIiwKPj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5z
aWQpOwo+Pj4gICDCoMKgwqDCoMKgwqDCoCBzdGF0dXMgPSAtRUlOVkFMOwo+Pj4gICDCoMKgwqDC
oH0KPj4+IC0tIAo+Pj4KPj4+IEkgd2FzIHNheWluZyB0aGF0ICFzdGF0dXMgZG9lc24ndCBuZWNl
c3NhcmlseSBtZWFuIHN1Y2Nlc3MsIGJ1dCBpdCBjYW4KPj4+IGFsc28gbWVhbiB0aGF0IGl0cyBh
biByZXRyeS1hYmxlIGVycm9yIHN0YXR1cyAoZHVlIHRvIHRyYW5zcG9ydCBvcgo+Pj4gY29udHJv
bGxlcikuIElmIHdlIHNlZSBhIHJldHJ5LWFibGUgZXJyb3Igd2Ugc2hvdWxkIHN0aWxsIGNsZWFy
IHRoZQo+Pj4gc3RhdHVzIHNvIHdlIGRvbid0IGFiYW5kb24gdGhlIG5hbWVzcGFjZS4KPj4+Cj4+
PiBUaGlzIGZvciBleGFtcGxlIHdvdWxkIGFjaGlldmUgdGhhdDoKPiAKPiBXZSdyZSBub3QgdGFs
a2luZyBhYm91dCB0aGUgc2FtZSB0aGluZy4gSSBhbSBvbmx5IHRhbGtpbmcgYWJvdXQgd2hhdAo+
IGludHJvZHVjZWQgdGhlIEROUiBjaGVjaywgZnJvbSBjb21taXQgNTljN2MzY2FhYWY4Ny4KPiAK
PiBJIGtub3cgeW91IGFkZGVkIGl0IGJlY2F1c2UgeW91IHdhbnQgdG8gYWJvcnQgY29tcGFyaW5n
IGlkZW50aWZpZXJzIG9uIGEKPiByZXNjYW4gd2hlbiByZXRyaWV2aW5nIHRoZSBpZGVudGlmaWVy
cyBmYWlsZWQuIFRoYXQncyBmaW5lLCBidXQgSSBhbQo+IHNheWluZyB0aGlzIGZhaWxzIG5hbWVz
cGFjZSBjcmVhdGlvbiBpbiB0aGUgZmlyc3QgcGxhY2UgZm9yIHNvbWUgdHlwZXMKPiBvZiBkZXZp
Y2VzIHRoYXQgdXNlZCB0byBzdWNjZWVkLgoKT0ssIG5vdyBJIHRoaW5rIEkgdW5kZXJzdGFuZCAo
dGhhbmtzIGZvciBjbGFyaWZ5aW5nIHRoYXQgdGhlIGRpc2N1c3Npb24KaXMgbm90IG9uIHBhdGNo
IDMvNSwgYnV0IHJhdGhlciBvbiA1OWM3YzNjYWFhZjg3KS4KClNvIHRoZSBvcmlnaW5hbCBwcm9w
b3NhbCB3YXMgdG8gY2hlY2sgTlZNRV9TQ19IT1NUX1BBVEhfRVJST1IgKGFuZCBub3cKd2UgaGF2
ZSBOVk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQpIGJ1dCB3aXRoIHRoZSByZXZpZXcgQ2hyaXN0b3Bo
IGdhdmUKaXQgc2VlbWVkIHRvIG1ha2UgbW9yZSBzZW5zZSB0aGF0IHdlIGdlbmVyYWxpemUgYW5k
IGNoZWNrIHRoZSBETlIgYml0LgoKV2UgY291bGQgcmVzdHJpY3QgaXQgYmFjayB0byBjaGVja2lu
ZyB0aGUgc3RhdHVzIGlzCk5WTUVfU0NfSE9TVF9QQVRIX0VSUk9SIG9yIE5WTUVfU0NfSE9TVF9B
Qk9SVEVEX0NNRCBpZiB5b3UgdGhpbmsgaXQKY3JlYXRlcyBwcm9ibGVtcy4gSG93ZXZlciwgaWYg
d2Uga2VlcCB0aGUgY29kZSBhcyBpcywgdGhlIG9yaWdpbmFsCmNvbW1lbnQgc3RpbGwgaG9sZHMu
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
