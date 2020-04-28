Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D67C83004
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 10:32:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4386B206D6
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 10:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Azog6pz3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ST57LC3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4386B206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NBW7748kv09q2lZyfp7u++HdPrn1bq/adIz8rF9XleM=; b=Azog6pz3R/jTjmPbLue3Zm8d1
	lXt0x4Xx3rV0LV0vi+RBdVVCJamJU6747o+5R0HAr6/PwMsqK7ZPrWY4dAQyPnRbjuLRtIubV5Ieq
	olqGVzDTKTQBgZdXcIOBca0GoVq9POxGvuEAVq5ksOZRLYnG4sfApnN7+b4lsYqsfDvFgMeihITTk
	cqL3SyTh0LHf+v/yitEIr5Sa5ga3shJHZ/SppgT6QF3dTb4Y85TZvwHlZIwVo94RMxluLlAvqVIbg
	qB2l3QWbY4JVjJNjGwKKIUpYXHFvjLvipuFIfiToKajDHmHkO6o2DDFfM39wnhdx1RRh9XVEsyWcD
	N0r3uk/DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTNXq-0004td-G1; Tue, 28 Apr 2020 10:32:54 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTNXo-0004sr-Ig
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 10:32:54 +0000
Received: by mail-wr1-x444.google.com with SMTP id d15so22400319wrx.3
 for <linux-nvme@lists.infradead.org>; Tue, 28 Apr 2020 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=AXbiHKswDMgt8rbtX7mZPHUHWcmhaf3PNptTH7f7SYs=;
 b=ST57LC3kF7eIqJdj03lQTNsNn5Ok+/tjEP9i+P/j7W9mhC7e4ig2ci/TvRNkrdH/gv
 tPSFyDRYzMfiQLrQcppDnYsKYajS6Xrr741febcQjxcbLgtZ/78c2LblD9cQN8Sgry8e
 n6/wRPIuYArrvUgoEaaTceqcGXRujm9C/fTCLcU96VADhG0Tmk0MlqM4zDpZpqLGAwkE
 ZcJKtA3xTY9SC/K6IGJWpjPp918Pi4wzXhpjpKxEHp20KtqOwK/FRCvXmgDcAbyk82Ng
 sow52dVMlkzZiUIHGCdu6AB1gpEbhWPw8l8vUAsOoxtUpgbJNdYcrg07XBEQGcF+/wmi
 HEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AXbiHKswDMgt8rbtX7mZPHUHWcmhaf3PNptTH7f7SYs=;
 b=fvcPkmhG2vZhTWfW9svXX/lKmWIzeqeE8lztAeePK7LMnyfycxUsbMklyu5yKmUpus
 pNKFbfpt1uFkSzQmDxkvOZlvYffTQ3kvKCMnp9tvQGTKSkj/uv3G1yXcAT7k3UmPx41T
 X9v8wxjAlEbkz9RdgcYmFV7hnl1nKDAueNZVYltHGm/BUKZBz21mUgBtgZ7049LZ5h4b
 kmhKQqZrD5xznD0q+Y8QQ3LQiihDa+QU4ez4BVVzRzmpT5h4IMM94WzSC012I5kdfzij
 7xSkaAlM79LrTVhzYbymnq0lgKCLNBivKPIzYp3B/AjhYSG11IZB2WTRh23kng+ICznV
 5IDA==
X-Gm-Message-State: AGi0Pub8bTEkqZsbXmgf43xos3ukCqNGofZ4fKbt85yqZYy2+G1u5BtV
 bDEua9x6Dt51/A+2ccofOhrUUg==
X-Google-Smtp-Source: APiQypK6ZDksNp73FYMuOOqRaJtjM5HLTyKxvbHE/CUIs+juS4qvPRGTGQA9zTzOYsc/IiHC7i9y7A==
X-Received: by 2002:adf:f990:: with SMTP id f16mr30076642wrr.33.1588069970704; 
 Tue, 28 Apr 2020 03:32:50 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
 by smtp.gmail.com with ESMTPSA id l5sm24606831wrm.66.2020.04.28.03.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 03:32:50 -0700 (PDT)
Date: Tue, 28 Apr 2020 12:32:49 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Message-ID: <20200428103249.nrs2lhi2f5oakyrh@mpHalley.local>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
 <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
 <20200427182245.GA547726@localhost.localdomain>
 <20200428070651.qbsyivvaakflipr4@mpHalley.localdomain>
 <20200428074935.GA584449@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428074935.GA584449@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_033252_665976_F860F0ED 
X-CRM114-Status: GOOD (  28.18  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Igor Konopko <igor.j.konopko@intel.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjguMDQuMjAyMCAwNzo0OSwgTmlrbGFzIENhc3NlbCB3cm90ZToKPk9uIFR1ZSwgQXByIDI4
LCAyMDIwIGF0IDA5OjA2OjUxQU0gKzAyMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+IENB
VVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgV2VzdGVybiBEaWdp
dGFsLiBEbyBub3QgY2xpY2sgb24gbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBrbm93IHRoYXQgdGhlIGNvbnRlbnQgaXMgc2FmZS4K
Pj4KPj4KPj4gT24gMjcuMDQuMjAyMCAxODoyMiwgTmlrbGFzIENhc3NlbCB3cm90ZToKPj4gPiBP
biBNb24sIEFwciAyNywgMjAyMCBhdCAwODowMzoxMVBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6
IHdyb3RlOgo+PiA+ID4gT24gMjcuMDQuMjAyMCAxNDozNCwgTmlrbGFzIENhc3NlbCB3cm90ZToK
Pj4gPiA+ID4gV2hlbiBqdW1waW5nIHRvIHRoZSBvdXRfcHV0X2Rpc2sgbGFiZWwsIHdlIHdpbGwg
Y2FsbCBwdXRfZGlzaygpLCB3aGljaCB3aWxsCj4+ID4gPiA+IHRyaWdnZXIgYSBjYWxsIHRvIGRp
c2tfcmVsZWFzZSgpLCB3aGljaCBjYWxscyBibGtfcHV0X3F1ZXVlKCkuCj4+ID4gPiA+Cj4+ID4g
PiA+IExhdGVyIGluIHRoZSBjbGVhbnVwIGNvZGUsIHdlIGRvIGJsa19jbGVhbnVwX3F1ZXVlKCks
IHdoaWNoIHdpbGwgYWxzbyBjYWxsCj4+ID4gPiA+IGJsa19wdXRfcXVldWUoKS4KPj4gPiA+ID4K
Pj4gPiA+ID4gUHV0dGluZyB0aGUgcXVldWUgdHdpY2UgaXMgaW5jb3JyZWN0LCBhbmQgd2lsbCBn
ZW5lcmF0ZSBhIEtBU0FOIHNwbGF0Lgo+PiA+ID4gPgo+PiA+ID4gPiBTZXQgdGhlIGRpc2stPnF1
ZXVlIHBvaW50ZXIgdG8gTlVMTCwgYmVmb3JlIGNhbGxpbmcgcHV0X2Rpc2soKSwgc28gdGhhdCB0
aGUKPj4gPiA+ID4gZmlyc3QgY2FsbCB0byBibGtfcHV0X3F1ZXVlKCkgd2lsbCBub3QgZnJlZSB0
aGUgcXVldWUuCj4+ID4gPiA+Cj4+ID4gPiA+IFRoZSBzZWNvbmQgY2FsbCB0byBibGtfcHV0X3F1
ZXVlKCkgdXNlcyBhbm90aGVyIHBvaW50ZXIgdG8gdGhlIHNhbWUgcXVldWUsCj4+ID4gPiA+IHNv
IHRoaXMgY2FsbCB3aWxsIHN0aWxsIGZyZWUgdGhlIHF1ZXVlLgo+PiA+ID4gPgo+PiA+ID4gPiBG
aXhlczogODUxMzZjMDEwMjg1ICgibGlnaHRudm06IHNpbXBsaWZ5IGdlb21ldHJ5IGVudW1lcmF0
aW9uIikKPj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTmlrbGFzIENhc3NlbCA8bmlrbGFzLmNhc3Nl
bEB3ZGMuY29tPgo+PiA+ID4gPiAtLS0KPj4gPiA+ID4gZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IHwgMiArKwo+PiA+ID4gPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4+ID4gPiA+
Cj4+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPj4gPiA+ID4gaW5kZXggOTFjMWJkNjU5OTQ3Li5mMmFkZWE5NmIw
NGMgMTAwNjQ0Cj4+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiA+ID4g
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gPiA+ID4gQEAgLTM2NDIsNiArMzY0
Miw4IEBAIHN0YXRpYyB2b2lkIG52bWVfYWxsb2NfbnMoc3RydWN0IG52bWVfY3RybCAqY3RybCwg
dW5zaWduZWQgbnNpZCkKPj4gPiA+ID4KPj4gPiA+ID4gICAgICAgcmV0dXJuOwo+PiA+ID4gPiAg
b3V0X3B1dF9kaXNrOgo+PiA+ID4gPiArICAgICAgLyogcHJldmVudCBkb3VibGUgcXVldWUgY2xl
YW51cCAqLwo+PiA+ID4gPiArICAgICAgbnMtPmRpc2stPnF1ZXVlID0gTlVMTDsKPj4gPiA+ID4g
ICAgICAgcHV0X2Rpc2sobnMtPmRpc2spOwo+PiA+ID4gPiAgb3V0X3VubGlua19uczoKPj4gPiA+
ID4gICAgICAgbXV0ZXhfbG9jaygmY3RybC0+c3Vic3lzLT5sb2NrKTsKPj4gPiA+ID4gLS0KPj4g
PiA+ID4gMi4yNS4zCj4+ID4gPiA+Cj4+ID4gPiBXaGF0IGFib3V0IGRlbGF5aW5nIHRoZSBhc3Np
Z25tZW50IG9mIG5zLT5kaXNrPwo+PiA+ID4KPj4gPiA+IGRpZmYgLS1naXQgaS9kcml2ZXJzL252
bWUvaG9zdC9jb3JlLmMgdy9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gPiA+IGluZGV4IGE0
ZDhjOTBlZTdjYy4uNmRhNGE5Y2VkOTQ1IDEwMDY0NAo+PiA+ID4gLS0tIGkvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCj4+ID4gPiArKysgdy9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gPiA+
IEBAIC0zNTQxLDcgKzM1NDEsNiBAQCBzdGF0aWMgaW50IG52bWVfYWxsb2NfbnMoc3RydWN0IG52
bWVfY3RybCAqY3RybCwgdW5zaWduZWQgbnNpZCkKPj4gPiA+ICAgICAgICAgZGlzay0+cXVldWUg
PSBucy0+cXVldWU7Cj4+ID4gPiAgICAgICAgIGRpc2stPmZsYWdzID0gZmxhZ3M7Cj4+ID4gPiAg
ICAgICAgIG1lbWNweShkaXNrLT5kaXNrX25hbWUsIGRpc2tfbmFtZSwgRElTS19OQU1FX0xFTik7
Cj4+ID4gPiAtICAgICAgIG5zLT5kaXNrID0gZGlzazsKPj4gPiA+Cj4+ID4gPiAgICAgICAgIF9f
bnZtZV9yZXZhbGlkYXRlX2Rpc2soZGlzaywgaWQpOwo+PiA+ID4KPj4gPiA+IEBAIC0zNTUzLDYg
KzM1NTIsOCBAQCBzdGF0aWMgaW50IG52bWVfYWxsb2NfbnMoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCwgdW5zaWduZWQgbnNpZCkKPj4gPiA+ICAgICAgICAgICAgICAgICB9Cj4+ID4gPiAgICAgICAg
IH0KPj4gPiA+Cj4+ID4gPiArICAgICAgIG5zLT5kaXNrID0gZGlzazsKPj4gPiA+ICsKPj4gPgo+
PiA+IEhlbGxvIEphdmllciEKPj4gPgo+PiA+Cj4+ID4gVGhlIG9ubHkgY2FzZSB3aGVyZSB3ZSBq
dW1wIHRvIHRoZSBvdXRfcHV0X2Rpc2sgbGFiZWwsIGlzIGlmIHRoZQo+PiA+IG52bWVfbnZtX3Jl
Z2lzdGVyKCkgY2FsbCBmYWlsZWQuCj4+ID4KPj4gPiBJbiB0aGF0IGNhc2UsIHdlIHdhbnQgdG8g
dW5kbyB0aGUgYWxsb2NfZGlza19ub2RlKCkgb3BlcmF0aW9uLCBpLmUuLAo+PiA+IGRlY3JlYXNl
IHRoZSByZWZjb3VudC4KPj4gPgo+PiA+IElmIHdlIGRvbid0IHNldCAibnMtPmRpc2sgPSBkaXNr
OyIgYmVmb3JlIHRoZSBjYWxsIHRvIG52bWVfbnZtX3JlZ2lzdGVyKCksCj4+ID4gdGhlbiwgaWYg
cmVnaXN0ZXIgZmFpbHMsIGFuZCB3ZSBqdW1wIHRvIHRoZSBwdXRfZGlzayhucy0+ZGlzaykgbGFi
ZWwsCj4+ID4gbnMtPmRpc2sgd2lsbCBiZSBOVUxMLCBzbyB0aGUgcmVjb3VudCB3aWxsIG5vdCBi
ZSBkZWNyZWFzZWQsIHNvIEkgYXNzdW1lCj4+ID4gdGhhdCB0aGlzIG1lbW9yeSB3b3VsZCB0aGVu
IGJlIGEgbWVtb3J5IGxlYWsuCj4+ID4KPj4gPgo+PiA+IEkgdGhpbmsgdGhhdCB0aGUgcHJvYmxl
bSBpcyB0aGF0IHRoZSBibG9jayBmdW5jdGlvbnMgYXJlIGEgYml0IG1lc3N5Lgo+PiA+IE1vc3Qg
ZHJpdmVycyBzZWVtIHRvIGRvIGJsa19jbGVhbnVwX3F1ZXVlKCkgZmlyc3QgYW5kIHRoZW4gZG8g
cHV0X2Rpc2soKSwKPj4gPiBidXQgc29tZSBkcml2ZXJzIGRvIGl0IGluIHRoZSBvcHBvc2l0ZSB3
YXksIHNvIEkgdGhpbmsgdGhhdCB3ZSBtaWdodCBoYXZlCj4+ID4gc29tZSBtb3JlIHVzZS1hZnRl
ci1mcmVlIGJ1Z3MgaW4gc29tZSBvZiB0aGVzZSBkcml2ZXJzIHRoYXQgZG8gaXQgaW4gdGhlCj4+
ID4gb3Bwb3NpdGUgd2F5Lgo+PiA+Cj4+Cj4+IEhpIE5pa2xhcywKPj4KPj4gWWVzLCB0aGUgb3V0
X3B1dF9kaXNrIGxhYmVsIHdhcyBpbnRyb2R1Y2VkIGF0IHRoZSBzYW1lIHRpbWUgYXMgdGhlCj4+
IExpZ2h0TlZNIGVudHJ5IHBvaW50LiBXZSBjYW4gZG8gYSBiZXR0ZXIgam9iIGF0IHNlcGFyYXRp
bmcgdGhlIGNsZWFudXAKPj4gZnVuY3Rpb25zLCBidXQgYXMgZmFyIGFzIEkgY2FuIHNlZSBucy0+
ZGlzayBpcyBub3QgdXNlZCBpbiB0aGUgTGlnaHROVk0KPj4gaW5pdGlhbGl6YXRpb24sIHNvIGRl
bGF5aW5nIHRoZSBpbml0aWFsaXphdGlvbiBzaG91bGQgYmUgb2suIFBhcnQgb2YKPj4gdGhpcyBz
aG91bGQgYmUgYWxzbyBjaGFuZ2luZyB0aGUgb3V0X3B1dF9kaXNrIHRvIHB1dF9kaXNrKGRpc2sp
Lgo+Cj5IZWxsbyBKYXZpZXIsCj4KPgo+SWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgeW91IGFy
ZSBzdWdnZXN0aW5nIHRoaXM6Cj4KPi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+Kysr
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj5AQCAtMzYxNiw3ICszNjE2LDYgQEAgc3RhdGlj
IHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lk
KQo+ICAgICAgICBkaXNrLT5xdWV1ZSA9IG5zLT5xdWV1ZTsKPiAgICAgICAgZGlzay0+ZmxhZ3Mg
PSBmbGFnczsKPiAgICAgICAgbWVtY3B5KGRpc2stPmRpc2tfbmFtZSwgZGlza19uYW1lLCBESVNL
X05BTUVfTEVOKTsKPi0gICAgICAgbnMtPmRpc2sgPSBkaXNrOwo+Cj4gICAgICAgIF9fbnZtZV9y
ZXZhbGlkYXRlX2Rpc2soZGlzaywgaWQpOwo+Cj5AQCAtMzYyOCw2ICszNjI3LDggQEAgc3RhdGlj
IHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lk
KQo+ICAgICAgICAgICAgICAgIH0KPiAgICAgICAgfQo+Cj4rICAgICAgIG5zLT5kaXNrID0gZGlz
azsKPisKPiAgICAgICAgZG93bl93cml0ZSgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4gICAg
ICAgIGxpc3RfYWRkX3RhaWwoJm5zLT5saXN0LCAmY3RybC0+bmFtZXNwYWNlcyk7Cj4gICAgICAg
IHVwX3dyaXRlKCZjdHJsLT5uYW1lc3BhY2VzX3J3c2VtKTsKPkBAIC0zNjQyLDcgKzM2NDMsNyBA
QCBzdGF0aWMgdm9pZCBudm1lX2FsbG9jX25zKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHVuc2ln
bmVkIG5zaWQpCj4KPiAgICAgICAgcmV0dXJuOwo+ICBvdXRfcHV0X2Rpc2s6Cj4tICAgICAgIHB1
dF9kaXNrKG5zLT5kaXNrKTsKPisgICAgICAgcHV0X2Rpc2soZGlzayk7Cj4gIG91dF91bmxpbmtf
bnM6Cj4gICAgICAgIG11dGV4X2xvY2soJmN0cmwtPnN1YnN5cy0+bG9jayk7Cj4gICAgICAgIGxp
c3RfZGVsX3JjdSgmbnMtPnNpYmxpbmdzKTsKPgo+Cj5UaGF0IHdvdWxkIG5vdCBzb2x2ZSB0aGUg
ZG91YmxlIGZyZWUgZXJyb3Igd2hlbiB0aGUgcmVnaXN0cmF0aW9uIGZhaWxzLAo+c2luY2UgZGlz
ay0+cXVldWUgaXMgc3RpbGwgc2V0LCBzbyB0aGlzIGNhbGwgd2lsbCBzdGlsbCBmcmVlIHRoZSBx
dWV1ZS4KPgo+TGF0ZXIgaW4gdGhlIGNsZWFudXAgY29kZSBibGtfY2xlYW51cF9xdWV1ZShucy0+
cXVldWUpOwo+aXMgY2FsbGVkLCB3aGljaCB3aWxsIHN0aWxsIHRyeSB0byBmcmVlIHdoYXQgaXMg
YWxyZWFkeSBmcmVlZC4KPgo+VG8gcmVtb3ZlIHRoZSBkb3VibGUgZnJlZSBieSBkZWxheWluZyBh
c3NpZ25tZW50cywgd2Ugd291bGQgbmVlZCB0bwo+ZGVsYXkgdGhlIGFzc2lnbm1lbnQgb2YgZGlz
ay0+cXVldWUgdW50aWwgYWZ0ZXIgdGhlIExpZ2h0TlZNIGVudHJ5IHBvaW50LAo+YnV0IEkgZG9u
J3QgdGhpbmsgdGhhdCBpcyBwb3NzaWJsZSwgc2luY2UgX19udm1lX3JldmFsaWRhdGVfZGlzaygp
LCB3aGljaAo+aXMgY2FsbGVkIGJlZm9yZSB0aGUgTGlnaHROVk0gZW50cnkgcG9pbnQgdXNlcyBk
aXNrLT5xdWV1ZS4KPgo+Q2hyaXN0b3BoIHNhaWQgdGhhdCBoZSB3b3VsZCBjbGVhbiB1cCB0aGlz
IG1lc3Mgd2l0aCBiZXR0ZXIgYmxvY2sgbGF5ZXIKPkFQSXMuIFNvIHBlcmhhcHMgdGhlIGZpeCB0
aGF0IGlzIGFscmVhZHkgcXVldWVkIGlzIGdvb2QgZW5vdWdoIHVudGlsIHRoZW4uCj4KCk1ha2Vz
IHNlbnNlLiBJIHNlZSBzb21lIHRoaW5ncyBoYXZlIGNoYW5nZWQgaW4gdGhpcyBwYXRoIHNpbmNl
IEkgbGFzdApsb29rZWQgYXQgaXQuCgpUaGFua3MhCkphdmllcgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
