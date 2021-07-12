Return-Path: <SRS0=IqcX=ME=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B915EC07E99
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 14:40:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BAA61164
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jul 2021 14:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BAA61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jszews0RZ/mT9m17VhcAFsEeyBVGVrRWdq+0/hzNTjI=; b=rWlJRjnIJQiWua
	9aPmrd459FL4MdvpcqvA4JPnlqXKHUBG0zlk9H51cfofZSoXIMCCpsYtxiaVPiYFRkbPOLM9j05I7
	kNNsvecEoF12UaVMREEeZPFz2JuAepVKEgwrrg7GvmTns+Tq7ehK58ge3PlIr1aY/SfudFd4uCyyc
	WS1isndFL517tsYNF36Gbv7ZN4CAW/hQY8Qw96XvTgIfSsn+Roduqc6CbfQUrzdLbhdNXCAVDpoFF
	Hea8gk6qSKK0j/Ppo7XxjiS2g9kxr7kB5TTHoA6JHYXGRQfGsHcuJaPVjQGNlEacD+LE9BRgnQT/X
	b6Vd1Yd5OWdkLznbHAEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m2x6c-007eEu-Fw; Mon, 12 Jul 2021 14:40:22 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2x6Z-007eDN-0f
 for linux-nvme@lists.infradead.org; Mon, 12 Jul 2021 14:40:20 +0000
Received: by mail-wr1-x435.google.com with SMTP id v5so25971324wrt.3
 for <linux-nvme@lists.infradead.org>; Mon, 12 Jul 2021 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iDsVFTO3ZHdLrNE2anWcqscNFt8PHjKAZyzbOJqIiM8=;
 b=uQKdQ8nH7ZaYzuLd7Y1emLMCgc+86GMT+N0Ns5FfPFnECAYkhDBaS0gPCCMWYA1hHk
 JESbk9xDV5aLY0+/z3C+oDvHMoW6hQ1aiAJ05xXSkwb9alhO6YgEsiZDONuccXD23xJo
 CfIxOlsOJHXovpF1ZzCjBOvH3wZN5zntU6yXSkOfjY17TpzjhOmiAxTeHKW1KS3eQ1d3
 hlaBuYqMqqerPQGgh2bIubdER8O4UydkY2XdmsfZ/dwvOBTvICLwSX4nxeuDAH5Vlx+n
 +oXyPnjJ8U/HwYTpwqniRtXyBmmENG3QRtUQbQo95ipGRZ8Wkx5KaAUosK2vxR/FQXWY
 hChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iDsVFTO3ZHdLrNE2anWcqscNFt8PHjKAZyzbOJqIiM8=;
 b=IKdzYimSY8Xe8/+LH//kke+AbCVk44XulcnNvRwyJKFmZeH+vcPWqXtbZ6q34R0Q2N
 vMU36TsNAid9ZmK5hut9MHAxptaOib+bcNr87GsTENS7+u1PlmcZ6keKHx/njNJeSAZg
 EClsS9Z9g0xu0KFtWKJkmYz62AosBc/1T8nRPXOFakz387wCbgiky5Vx0g+qGxAUMXIC
 7qwrlX342BUZaFS5bunp3JIMoa0fTJlU9vV35pNZY13rLBDH1nBdzZR4RhtX/veoJn8U
 6OfOeBxFGQyKEk3UuLAJ4xCDZFXv1m5dpELaiptO3uVEx72JO2DmGcfLmviv/eFemtMa
 VpTQ==
X-Gm-Message-State: AOAM531pSR7G8nXmm4ejUaKM9/BFsyPqnK/wepWrafBYMbCLIcXKwtqW
 j5gaoxYL+tlnkptk3bTzxgeYi6YSQ3jXz/XZmj0=
X-Google-Smtp-Source: ABdhPJxlfSKP7rYcWC8rmkXBJ/+FtsV2eJUGCbxP1c9H2g89ifr0e88Kin2u/7vIJiaMRhBoFBEn6xVVxvyKR1OQsfg=
X-Received: by 2002:a05:6000:1212:: with SMTP id
 e18mr14098193wrx.255.1626100815872; 
 Mon, 12 Jul 2021 07:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-2-pkushwaha@marvell.com>
 <20210701133424.GB18548@lst.de>
 <CAKKgK4wN49NX+pDff5eFbebeTWBi4aMK9CVMmq4jixgtXHRmQA@mail.gmail.com>
In-Reply-To: <CAKKgK4wN49NX+pDff5eFbebeTWBi4aMK9CVMmq4jixgtXHRmQA@mail.gmail.com>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Mon, 12 Jul 2021 20:09:39 +0530
Message-ID: <CAJ2QiJKSszNAdo1K+QnTGRf77uJirmTM2SoeahN4Arkqfq9_9g@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP
 HW offload ULP
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 axboe@fb.com, 
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>,
 David Miller <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, Shai Malin <smalin@marvell.com>,
 Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, Omkar Kulkarni <okulkarni@marvell.com>,
 Dean Balandin <dbalandin@marvell.com>, Shai Malin <malin1024@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210712_074019_105361_68D97D65 
X-CRM114-Status: GOOD (  22.67  )
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

SGkgQ2hyaXN0b3BoLAoKT24gTW9uLCBKdWwgNSwgMjAyMSBhdCA4OjQwIFBNIFNoYWkgTWFsaW4g
PG1hbGluMTAyNEBnbWFpbC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCAxIEp1bCAyMDIxIGF0IDE2
OjM0LCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gd3JvdGU6Cj4gPgoKW3NuaXBdCgo+
Cj4gPgo+ID4gPiArc3RhdGljIHN0cnVjdCBudm1mX3RyYW5zcG9ydF9vcHMgbnZtZV90Y3Bfb2Zs
ZF90cmFuc3BvcnQgPSB7Cj4gPiA+ICsgICAgIC5uYW1lICAgICAgICAgICA9ICJ0Y3Bfb2ZmbG9h
ZCIsCj4gPiA+ICsgICAgIC5tb2R1bGUgICAgICAgICA9IFRISVNfTU9EVUxFLAo+ID4gPiArICAg
ICAucmVxdWlyZWRfb3B0cyAgPSBOVk1GX09QVF9UUkFERFIsCj4gPiA+ICsgICAgIC5hbGxvd2Vk
X29wdHMgICA9IE5WTUZfT1BUX1RSU1ZDSUQgfCBOVk1GX09QVF9OUl9XUklURV9RVUVVRVMgIHwK
PiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTlZNRl9PUFRfSE9TVF9UUkFERFIgfCBOVk1G
X09QVF9DVFJMX0xPU1NfVE1PIHwKPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTlZNRl9P
UFRfUkVDT05ORUNUX0RFTEFZIHwgTlZNRl9PUFRfSERSX0RJR0VTVCB8Cj4gPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIE5WTUZfT1BUX0RBVEFfRElHRVNUIHwgTlZNRl9PUFRfTlJfUE9MTF9R
VUVVRVMgfAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBOVk1GX09QVF9UT1MgfCBOVk1G
X09QVF9IT1NUX0lGQUNFLAo+ID4gPiArfTsKPiA+ID4gKwo+ID4gPiArc3RhdGljIGludCBfX2lu
aXQgbnZtZV90Y3Bfb2ZsZF9pbml0X21vZHVsZSh2b2lkKQo+ID4gPiArewo+ID4gPiArICAgICBu
dm1mX3JlZ2lzdGVyX3RyYW5zcG9ydCgmbnZtZV90Y3Bfb2ZsZF90cmFuc3BvcnQpOwo+ID4gPiAr
Cj4gPiA+ICsgICAgIHJldHVybiAwOwo+ID4gPiArfQo+ID4gPiArCj4gPiA+ICtzdGF0aWMgdm9p
ZCBfX2V4aXQgbnZtZV90Y3Bfb2ZsZF9jbGVhbnVwX21vZHVsZSh2b2lkKQo+ID4gPiArewo+ID4g
PiArICAgICBudm1mX3VucmVnaXN0ZXJfdHJhbnNwb3J0KCZudm1lX3RjcF9vZmxkX3RyYW5zcG9y
dCk7Cj4gPiA+ICt9Cj4gPgo+ID4gTG9va2luZyBhdCB0aGUgZmluYWwgcmVzdWx0IHRoaXMgZG9l
c24ndCBkbyBtdWNoLiAgQXNzdW1pbmcgd2Ugd2FudAo+ID4gdG8gc3VwcG9ydCB0aGVzZSBraW5k
cyBvZiB3aGFja3kgb2ZmbG9hZHMgKHdoaWNoIEknZCByYXRoZXIgbm90IGRvKSwKPiA+IHRoZSBw
cm9wZXIgd2F5IHdvdWxkIGJlIHRvIGFsbG93IHJlZ2lzdGVyaW5nIG11bHRpcGxlIHRyYW5zcG9y
dF9vcHMKPiA+IHN0cnVjdHVyZXMgZm9yIGEgZ2l2ZW4gbmFtZSByYXRoZXIgYWRkaW5nIGFuIGlu
ZGlyZWN0aW9uIHRoYXQgZHVwbGljYXRlcwo+ID4gYSB3aG9sZSBsb3Qgb2YgY29kZS4KPgo+IElu
IHRoYXQgY2FzZSwgd291bGQgeW91IHByZWZlciB0aGF0IHdlIGludm9rZSB0aGUgdGNwLW9mZmxv
YWQgZnJvbQo+IHdpdGhpbiB0aGUgdGNwIGZsb3c/Cj4gU2hvdWxkIGl0IGJlIHdpdGggdGhlIHNh
bWUgdHJhbnNwb3J0IG5hbWUgKOKAnHRjcOKAnSkgb3Igd2l0aCBhIGRpZmZlcmVudAo+IHRyYW5z
cG9ydCBuYW1lICjigJx0Y3Bfb2ZmbG9hZOKAnSk/Cj4KPiBBbHNvLCB3b3VsZCB5b3UgcHJlZmVy
IHRoYXQgd2UgcmVnaXN0ZXIgdGhlIG9mZmxvYWQgZGV2aWNlIGRyaXZlcgo+IGRpcmVjdGx5IHRv
IGJsa19tcSBsYXllciBvciB0aHJvdWdoIHRoZSB0Y3Atb2ZmbG9hZCBsYXllcj8KPgoKSSBob3Bl
IHlvdSBnb3Qgc29tZSB0aW1lIHRvIGxvb2sgaW50byB0aGUgYWJvdmUgcXVlcmllcy4KV2Ugd291
bGQgYXBwcmVjaWF0ZSB5b3VyIGZlZWRiYWNrIGluIG9yZGVyIHRvIGZpbmFsaXplIHRoZSBkZXNp
Z24uCgotLXBrCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
