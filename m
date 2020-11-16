Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9FDC55ABD
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:15:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7BA9222E8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 08:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h4Z9JQO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BA9222E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nmN366uNEkpk4p4J/0WKV0tnoV0uLVmMumpN8LecZ6o=; b=h4Z9JQO+A0poSn/IUI1otFTDO
	pumCsWPYRfFnoBHCFfebRBOMZ5tayL/DDZBL7JvGrFhqTUwi+QYwCAyzydZs5LSfKPNCmXq6Io6In
	fF6UkRpoWsXqNh8kBxIAMM9PDU2qYGwOZ3fajGT6tmOjD+l4dFa81NAOSjX8+mmQBxTD4WxRN7Y+a
	hC6Dv+tn2btr+MTWHwqUsDN/Et9YqqJp3G4SfPLRCFHRB8FKfM2R01gtUuPtQmXRDigNug6NN1+BR
	l1OJ3KmD97QOWvYKfNCAAAaNNazGboOQffWxA0HD1+QCZOZ4NXcOMQ+DxUzVuCrIlxbRsf5HuZGvU
	yN4mm12JQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keZfe-0005je-Bg; Mon, 16 Nov 2020 08:15:30 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keZfa-0005i6-AT
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 08:15:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4348AAFAB;
 Mon, 16 Nov 2020 08:15:25 +0000 (UTC)
Subject: Re: [PATCH v4 19/19] scsi: Made changes in Kconfig to select
 BLK_CGROUP_FC_APPID
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
 <1604895845-2587-20-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <43145656-b258-be6b-070e-0947dc639042@suse.de>
Date: Mon, 16 Nov 2020 09:15:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604895845-2587-20-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_031526_519156_E8D863FB 
X-CRM114-Status: GOOD (  23.90  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvOS8yMCA1OjI0IEFNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gQWRkZWQgYSBuZXcgY29uZmln
IEZDX0FQUElEIHRvIHNlbGVjdCBCTEtfQ0dST1VQX0ZDX0FQUElECj4gd2hpY2ggRW5hYmxlIHN1
cHBvcnQgdG8gdHJhY2sgRkMgaW8gVHJhZmZpYy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBNdW5lZW5k
cmEgPG11bmVlbmRyYS5rdW1hckBicm9hZGNvbS5jb20+Cj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPgo+IAo+IC0tLQo+IHY0Ogo+IEFkZHJlc3NlZCB0aGUg
ZXJyb3IgcmVwb3J0ZWQgYnkga2VybmVsIHRlc3Qgcm9ib3QKPiAKPiB2MzoKPiBOZXcgcGF0Y2gK
PiAtLS0KPiAgIGRyaXZlcnMvc2NzaS9LY29uZmlnIHwgMTMgKysrKysrKysrKysrKwo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
Y3NpL0tjb25maWcgYi9kcml2ZXJzL3Njc2kvS2NvbmZpZwo+IGluZGV4IDcwMWI2MWVjNzZlZS4u
MWM3M2M2MGUzOThmIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvc2NzaS9LY29uZmlnCj4gKysrIGIv
ZHJpdmVycy9zY3NpL0tjb25maWcKPiBAQCAtMjM1LDYgKzIzNSwxOSBAQCBjb25maWcgU0NTSV9G
Q19BVFRSUwo+ICAgCSAgZWFjaCBhdHRhY2hlZCBGaWJlckNoYW5uZWwgZGV2aWNlIHRvIHN5c2Zz
LCBzYXkgWS4KPiAgIAkgIE90aGVyd2lzZSwgc2F5IE4uCj4gICAKPiArY29uZmlnIEZDX0FQUElE
Cj4gKwlib29sICJFbmFibGUgc3VwcG9ydCB0byB0cmFjayBGQyBpbyBUcmFmZmljIgo+ICsJZGVw
ZW5kcyBvbiBCTE9DSyAmJiBCTEtfQ0dST1VQCj4gKwlkZXBlbmRzIG9uIFNDU0kKPiArCXNlbGVj
dCBCTEtfQ0dST1VQX0ZDX0FQUElECj4gKwlkZWZhdWx0IHkKPiArCWhlbHAKPiArCSAgSWYgeW91
IHNheSBZIGhlcmUsIGl0IGVuYWJsZXMgdGhlIHN1cHBvcnQgdG8gdHJhY2sKPiArCSAgRkMgSU8g
dHJhZmZpYyBvdmVyIGZhYnJpYy5JdCBlbmFibGVzIHRoZSBGYWJyaWMgYW5kIHRoZQo+ICsJICBz
dG9yYWdlIHRhcmdldHMgdG8gaWRlbnRpZnksIG1vbml0b3IsIGFuZCBoYW5kbGUgRkMgdHJhZmZp
Ywo+ICsJICBiYXNlZCBvbiB2bSB0YWdzIGJ5IGluc2VydGluZyBhcHBsaWNhdGlvbiBzcGVjaWZp
Ywo+ICsJICBpZGVudGlmaWNhdGlvbiBpbnRvIHRoZSBGQyBmcmFtZQo+ICsKPiAgIGNvbmZpZyBT
Q1NJX0lTQ1NJX0FUVFJTCj4gICAJdHJpc3RhdGUgImlTQ1NJIFRyYW5zcG9ydCBBdHRyaWJ1dGVz
Igo+ICAgCWRlcGVuZHMgb24gU0NTSSAmJiBORVQKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWlu
ZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5l
Y2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2
ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVy
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1u
dm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
