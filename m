Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6088C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:33:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E23D22795
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 07:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E23D22795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HbOnUPk6hHV0sn6u6s4ubfeOQb8jntKz4iBHVErkeQY=; b=FzKA+tPGrnX97gWVNWlD4t2g2
	R9FriayULEK5gOat5OJRHc74X82ZEBjQnoyPR8F7Ft+xFxJKF/IXtci9zf3YA9p/iszpgr8cPBH9H
	UbXSd0nZYFqquYjQ1rqQcb2KNP4L2srcP22pi+iHFLp56Ykhcz6EQavJ6w3pj8UV6Nmw+wC/RYa98
	XyP1Iw/PO8Uie5tCTefSMYxDBsPBFyFanAu21uNVuj0o9L1pGOvPn6jdwvol7OIV7F2LZurcIcn1n
	cfNwflOPOPio/HrLeqHYgwNsPeu9Q4amUS46WtK/VBTjLTPMspw6w2NuQhOpE+GIn6rik+P8CgJmL
	8Qbdxjc1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyrhe-0006A2-O8; Mon, 11 Jan 2021 07:33:26 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyrhb-000689-80
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 07:33:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2BD77AD6A;
 Mon, 11 Jan 2021 07:33:22 +0000 (UTC)
Subject: Re: [PATCH v7 05/16] lpfc: vmid: Supplementary data structures for
 vmid and APIs
To: Muneendra <muneendra.kumar@broadcom.com>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, tj@kernel.org, linux-nvme@lists.infradead.org
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
 <1609970430-19084-6-git-send-email-muneendra.kumar@broadcom.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <91bb4afd-a7de-12eb-cd27-a0e5ec72c6d6@suse.de>
Date: Mon, 11 Jan 2021 08:33:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1609970430-19084-6-git-send-email-muneendra.kumar@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_023323_430867_12DF6055 
X-CRM114-Status: GOOD (  20.95  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, emilne@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS82LzIxIDExOjAwIFBNLCBNdW5lZW5kcmEgd3JvdGU6Cj4gRnJvbTogR2F1cmF2IFNyaXZh
c3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29tLmNvbT4KPiAKPiBUaGlzIHBhdGNoIGFk
ZHMgYWRkaXRpb25hbCBkYXRhIHN0cnVjdHVyZXMgZm9yIHN1cHBvcnRpbmcgdGhlIHR3bwo+IHZl
cnNpb25zIG9mIHZtaWQgaW1wbGVtZW50YXRpb24uIEZpcnN0IHR5cGUgdXNlcyBhcHAgaGVhZGVy
IHdoaWxlCj4gdGhlIG90aGVyIHR5cGVzIHVzZXMgcHJpb3JpdHkgdGFnZ2luZyBtZWNoYW5pc20u
IFRoZXNlIGRhdGEKPiBzdHJ1Y3R1cmVzIGFyZSB1c2VkIG1vc3RseSBmb3IgRUxTIGFuZCBDVCBj
b21tYW5kcyBmb3IgdGhlCj4gdHdvIHZtaWQgaW1wbGVtZW50YXRpb24uCj4gCj4gVGhlIEFQSSBk
ZXRlcm1pbmVzIGlmIFZNSUQgaXMgZW5hYmxlZCBieSB0aGUgdXNlciBvciBub3QuCj4gCj4gU2ln
bmVkLW9mZi1ieTogR2F1cmF2IFNyaXZhc3RhdmEgPGdhdXJhdi5zcml2YXN0YXZhQGJyb2FkY29t
LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+
Cj4gCj4gLS0tCj4gdjc6Cj4gTm8gY2hhbmdlCj4gCj4gdjY6Cj4gTm8gY2hhbmdlCj4gCj4gdjU6
Cj4gTWVyZ2VkIHRoZSBwYXRjaDUgb2YgdjQgdG8gdGhpcyBwYXRjaAo+IFVuaWZvcm0gZGF0YSB0
eXBlIG5hbWluZyBzY2hlbWUKPiAKPiB2NDoKPiBObyBjaGFuZ2UKPiAKPiB2MzoKPiBObyBjaGFu
Z2UKPiAKPiB2MjoKPiBQb3J0ZWQgdGhlIHBhdGNoIG9uIHRvcCBvZiA1LjEwL3Njc2ktcXVldWUK
PiAtLS0KPiAgIGRyaXZlcnMvc2NzaS9scGZjL2xwZmMuaCAgICAgIHwgIDI0ICsrKysrKysKPiAg
IGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfZGlzYy5oIHwgICAxICsKPiAgIGRyaXZlcnMvc2NzaS9s
cGZjL2xwZmNfaHcuaCAgIHwgMTI0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0K
PiAgIGRyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2xpLmggIHwgICA4ICsrKwo+ICAgNCBmaWxlcyBj
aGFuZ2VkLCAxNTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAKUmV2aWV3ZWQtYnk6
IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApo
YXJlQHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4
OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXgg
SW1lbmTDtnJmZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1l
Cg==
