Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532F2C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:13:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259362074D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 07:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sCBL5MR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259362074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Byi5ilqgSPYJCfflA/olRbmO7EZwToB/eoGeU3l811M=; b=sCBL5MR2OjW0PBbTwa9m/cDVu
	+L2liFs4ebqUOsczieWXWigJAdLiQebKmyOjR9lkAw49PgufHdTlTC0lD5hLaIFCElaQSIsQw8d0c
	eUZSyUCOWeNG+iCkBz7AfBRxgywtC7NAX4se9IrTrYGNE86Ti4ANJuCpaurl+dvAWMKMXWJ4FEBTs
	Z4a5CQk1cjXhfjs/D5uMmt0MidEP05SV+0cqzfkSB0ZiG0UAuXsrQ0MkmTI7SGoS/VhzVAGIKScQP
	BroZL4mp11ub5GWlxuo+j3yVHgXh0x4fEaS4xPYM3ivYnCa7QytJZALxV9cZagugNAt0yirCo6Xs1
	YLkcKl5KQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAT9S-0002H1-Kh; Tue, 25 Aug 2020 07:13:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAT9Q-0002G6-57
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 07:13:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DED8C68BEB; Tue, 25 Aug 2020 09:13:45 +0200 (CEST)
Date: Tue, 25 Aug 2020 09:13:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
Message-ID: <20200825071345.GF29268@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_031348_329647_FF3D42BC 
X-CRM114-Status: GOOD (  17.55  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gTW9uLCBBdWcgMjQsIDIwMjAgYXQgMDE6MDI6NDBBTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3
cm90ZToKPiBJIGNoZWNrZWQgYWdhaW4sIGFuZCByZWdhcmRpbmcgdGhlIGNvbW1lbnQ6Cj4KPiAi
SSdtIHN0aWxsIHJhdGhlciBib3RoZXJlZCB3aXRoIHRoZSBhZG1pbiBxdWV1ZSBleGNlcHRpb24u
ICBBbmQgZ2l2ZW4gdGhhdAo+IHRoZSBxX3VzYWdlX2NvdW50ZXIgcHJvYmxlbSBzaG91bGQgb25s
eSByZWFsbHkgYmUgYW4gaXNzdWUgZm9yIGZpbGUgc3lzdGVtCj4gcmVxdWVzdHMsIGFzIHBhc3N0
aHJvdWdoIHJlcXVlc3RzIGRvIG5vdCBhdXRvbWF0aWNhbGx5IGdldCByZXRyaWVkIHdoeQo+IGNh
bid0IHdlIGp1c3QgcmVqZWN0IGFsbCB1c2VyIGNvbW1hbmQgdG8gYmUgc3ltZXRyaWMgYW5kIHN0
cmFpZ2h0IGZvcndhcmQ/Cj4gVGhlIGNhbGxlcnMgaW4gdXNlcnNwYWNlIG5lZWQgdG8gYmUgYWJs
ZSB0byBjb3BlIHdpdGggcmV0cnlhYmxlIGVycm9ycwo+IGFueXdheS4iCj4KPiBibGtfbXFfYWxs
b2NfcmVxdWVzdCBjYWxscyBibGtfcXVldWVfZW50ZXIsIHdoaWNoIG1lYW5zIHRoYXQgaWYgd2Ug
ZG9uJ3QKPiBsZXQgdGhlbSBpbiwgY29udHJvbGxlciByZXNldCBjYW4gaGFuZywganVzdCBsaWtl
IGluIG5vcm1hbCBmcyBJL08uCgpZZXMuICBCdXQgdGhlIGRpZmZlcmVuY2UgaXMgdGhhdCB0aGV5
IGRvbid0IGdldCByZXRyaWXRlSwgYnV0IGluc3RlYWQganVzdApmYWlsLgoKPiBTbyB3ZSBlaXRo
ZXIga2VlcCB0aGlzIGV4Y2VwdGlvbiBmb3IgYWRtaW4gY29tbWFuZHMsIG9yIHdlIGFsc28gbGV0
Cj4gdGhlbSB0aHJvdWdoIGFzIGl0IHNlZW1zIHRvIGJlIHNhZmUgd2l0aCB0aGUgY3VycmVudCBj
b2RlIChmcm9tIHRoZQo+IHJlc2V0IGZvcndhcmQtcHJvZ3Jlc3MgcGVyc3BlY3RpdmUpLgo+Cj4g
SSB2b3RlIHRvIHJlbW92ZSB0aGlzIGV4Y2VwdGlvbiBhbHRvZ2V0aGVyLi4uCgpUbyBtZSB0aGUg
cmlnaHQgYW5zd2VyIHdvdWxkIGJlIHRvIHJlamVjdCB1c2VyIGNvbW1hbmRzIG9uIHRoZSBhZG1p
bgpvciBJL08gcXVldWUgZm9yIHRoZSBub3QgbGl2ZSBjb250cm9sbGVyIGFzIHRoZSBjYWxsZXJz
IG5lZWQgdG8gaGFuZGxlCml0LiAgVGhhdCBzZWVtcyB0byBtYWtlIG1vcmUgc2Vuc2UgdG8gbWUg
dGhhbiBhIHNwZWNpYWwgYWRtaW4gcXVldWUKZXhjZXB0aW9uLgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGlu
dXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
