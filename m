Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BABCC433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 17:56:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2AE61166
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 17:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2AE61166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VDvHKcjZeg+GZo4ulsNmCCgRB8iNZx0qvWX0UPrP8us=; b=rc8joT3Ol1M8ehHb+qC7a/lvp
	BFYtT9mDgbK5Tes380fLjnrljL0Pia9ipUhcGvHGaUPvZ17t3o9SqIhZ5ta6Yoa9Fc7gPpjsH20JS
	1DpuErhG2JRyWYhzQKOcEQvYpG6Y0XtRwD1PYNkianaMrNxePrd5+JYoHKGgpibX95IYYid6hfbJC
	5z18OmrrIblxQFBR61YaYAVTwiAycP32OlwKIUqZD4qu77enI1yXFwjXEa8UpS0paw6G8bvKZugCd
	T8teO0WpnbgDqi3+YcNAaDdrB79reDASUnZYcfkdl6DtCFNKYcDgBmV4hr4JHUw+ZyB8CVs580JxQ
	Ogk54pynA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leLlA-001x6R-TU; Wed, 05 May 2021 17:56:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLl8-001x68-VN
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 17:56:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=dw5oszPW++Sy7Iq3KetI2v59gEspNAktX2qHuxKmvCo=; b=3hPdHIr+m+ZPeEIhXjPdbp9xrV
 qlMhA4ZstwVbzU389Tb20wiJMttxF1Dp8cTiNkS+aXojUY7aLMJC6CUJg1x0JBvOfGZ4YmPUJs4Sf
 7SyGAMGNV/ikmeOZnhT09pl6iwfFXNWAR8m5c9+th/kIj7y9TZlhmTolJic+ikpEH+rwJRhOmbxMt
 IIsRVTJ74RXw2PrObOUakhR1H9NMYG5ltGcZLOz218C10Mdcv73lA2q/bty1YYGosgVEXh3HP+NoJ
 +WJdwjmD5JA7FUY+qSvRLAQgKcKI0/WkVXKfkov9P15YDpq0cW5CoDpST15jXhFQpUHk10OWy75xT
 AUfqu9ig==;
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLl5-0056lj-Lc
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 17:56:29 +0000
Received: by mail-ed1-x52a.google.com with SMTP id y26so3078088eds.4
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 10:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=dw5oszPW++Sy7Iq3KetI2v59gEspNAktX2qHuxKmvCo=;
 b=Gadf7t3S4l+R8WRsOdhZH/rOtmwnwOkDPTopPTDMOzow1DzdSHkw/OklZRo66USa0g
 s6UZ7ZNMIj/GEF/XpUxGhjOe08RVnq6M+sAwccYpNwYyM2EzhJstDbCQA6ouIIy2A/C9
 ZzWjkEUxh6TyOvyNBH/5R+3XLbpXIdG75bfXVW45QIDHE0boDH4LV1GG8kezuAc1jx6f
 k4PF9cvbEuc+YEZCyBmysIu6wjNNP3JgQV0XrVFNu70PRZBnFAOL9JvCNLsEtOolixi7
 a9siJt8HlD64scoNNdyHPyFT2y5L+Q7IXDxHk9x0CCicFQqU3wiU/Tk0cO7rvzFMFfZ3
 RUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=dw5oszPW++Sy7Iq3KetI2v59gEspNAktX2qHuxKmvCo=;
 b=ndH4edszo37G2o6gN2YYkTC0nctiv+W5Tv9XIr20IFznHpyF22kbWJMZLDDy/7XqRr
 qzONGNSsNifbyPXQy4KvNJynalTyqNMc/dWu7ezyF8SnKKdP/2VNgT1b0msexDFlBmhN
 Rf+mZ9+LqHX4dLveI5+XNNpsVbFIEvzGjosyx+FR1yXzTFgsH2NwD8LTdsJHSq8MiJfY
 /ARzQ8Ne5YnZgc0wWyxgZ0OQD2T+4/aD7RxxxbpwnqSHJmjbvMbnW1Bw3FhJglyjX8XG
 sB8Vtw42tMOcd7wXWd9S7aMXJIUR/ZSPNPiZDdSKFxWLjeRCQwJbh1k8VmdRoFW/9p/N
 mx+Q==
X-Gm-Message-State: AOAM530pyZjsoaYVNFtgtiBNakbHo4ejbCa6aiRpMzuzNupmaX5Ax8x9
 QdskOBXtP2YDNgUga3auuzW3pjFzU+Kam2aRGZs=
X-Google-Smtp-Source: ABdhPJxnvp0iQN6IR05j7JN2kdKcICuPGWt+Y2elC826cZbJYMbpeDHwdFzOUvfh2f/5X3m1/KUGU3do77nuL+C8fRM=
X-Received: by 2002:a05:6402:138f:: with SMTP id
 b15mr252945edv.121.1620237386105; 
 Wed, 05 May 2021 10:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-21-smalin@marvell.com>
 <95009c8e-330f-fd99-781c-cb2b80263ba2@suse.de>
In-Reply-To: <95009c8e-330f-fd99-781c-cb2b80263ba2@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 5 May 2021 20:56:15 +0300
Message-ID: <CAKKgK4yBC022_7hmiaQXkKWq1DS1tFJd8dYOVN5w9mRQVfGYVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 20/27] qedn: Add connection-level slowpath
 functionality
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org, 
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, pkushwaha@marvell.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_105627_726072_C7809118 
X-CRM114-Status: GOOD (  16.52  )
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

T24gNS8yLzIxIDI6MzcgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBGcm9tOiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBr
dXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+Cj4gPiBUaGlzIHBhdGNoIHdpbGwgcHJlc2VudCB0aGUg
Y29ubmVjdGlvbiAocXVldWUpIGxldmVsIHNsb3dwYXRoCj4gPiBpbXBsZW1lbnRhdGlvbiByZWxl
dmFudCBmb3IgY3JlYXRlX3F1ZXVlIGZsb3cuCj4gPgo+ID4gVGhlIGludGVybmFsIGltcGxlbWVu
dGF0aW9uOgo+ID4gLSBBZGQgcGVyIGNvbnRyb2xsZXIgc2xvd3BhdGggd29ya3FldWV1ZSB2aWEg
cHJlX3NldHVwX2N0cmwKPiA+Cj4gPiAtIHFlZG5fbWFpbi5jOgo+ID4gICAgSW5jbHVkZXMgcWVk
bidzIGltcGxlbWVudGF0aW9uIG9mIHRoZSBjcmVhdGVfcXVldWUgb3AuCj4gPgo+ID4gLSBxZWRu
X2Nvbm4uYyB3aWxsIGluY2x1ZGUgbWFpbiBzbG93cGF0aCBjb25uZWN0aW9uIGxldmVsIGZ1bmN0
aW9ucywKPiA+ICAgIGluY2x1ZGluZzoKPiA+ICAgICAgMS4gUGVyLXF1ZXVlIHJlc291cmNlcyBh
bGxvY2F0aW9uLgo+ID4gICAgICAyLiBDcmVhdGluZyBhIG5ldyBjb25uZWN0aW9uLgo+ID4gICAg
ICAzLiBPZmZsb2FkaW5nIHRoZSBjb25uZWN0aW9uIHRvIHRoZSBGVyBmb3IgVENQIGhhbmRzaGFr
ZS4KPiA+ICAgICAgNC4gRGVzdHJveSBvZiBhIGNvbm5lY3Rpb24uCj4gPiAgICAgIDUuIFN1cHBv
cnQgb2YgZGVsZXRlIGFuZCBmcmVlIGNvbnRyb2xsZXIuCj4gPiAgICAgIDYuIFRDUCBwb3J0IG1h
bmFnZW1lbnQgdmlhIHFlZF9mZXRjaF90Y3BfcG9ydCwgcWVkX3JldHVybl90Y3BfcG9ydAo+ID4K
PiA+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFydmVsbC5jb20+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4K
PiA+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNv
bT4KPiA+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4g
PiBTaWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4gPiAtLS0K
PiA+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vTWFrZWZpbGUgICAgfCAgIDUgKy0KPiA+ICAgZHJp
dmVycy9udm1lL2h3L3FlZG4vcWVkbi5oICAgICAgfCAxNzMgKysrKysrKysrKy0KPiA+ICAgZHJp
dmVycy9udm1lL2h3L3FlZG4vcWVkbl9jb25uLmMgfCA1MDggKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+ID4gICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuX21haW4uYyB8IDIwOCAr
KysrKysrKysrKystCj4gPiAgIDQgZmlsZXMgY2hhbmdlZCwgODgzIGluc2VydGlvbnMoKyksIDEx
IGRlbGV0aW9ucygtKQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9udm1lL2h3L3Fl
ZG4vcWVkbl9jb25uLmMKPiA+Cj4KPiBSZXZpZXdlZC1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJl
QHN1c2UuZGU+CgpUaGFua3MuCgo+Cj4gQ2hlZXJzLAo+Cj4gSGFubmVzCj4gLS0KPiBEci4gSGFu
bmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdAo+IGhh
cmVAc3VzZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4
Cj4gU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnCj4gSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVs
aXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
