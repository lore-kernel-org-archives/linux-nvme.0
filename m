Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79941C388F2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:15:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9C2223C6
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 23:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sApi5OsX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p3YA2pZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9C2223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8bcaREsW9c7/p5Ds0jCLJf/VC0kmmZ+pvfDhK91NWJY=; b=sApi5OsXDnzx2qEHwXqAxReUg
	I6VNcpzmENicOLhPmetgsL0x958GugWK+N6UI/auw7JJLxPjTA2bJYUpfKOfrsDeeQD6+ad5HBb7g
	fQPXgUwXw5NxPeKDkbhYHqF/tUFWguV6Q4WfAzJrm0PrIISMIdxedIaPwd+rMYz0aAd7vcnXn/cAh
	NK23ZvUyYhWAiEN+dR3T3weYhWOuO23KuFl6epL62l/3ADqK1o1vtLDXG03bKdf7yoSC4KVv5ahuC
	zxwLKfVGvWO1eLDgDGB4n7vLhuXvhkS8RSMtbn+YEKPJl3pYKEg72gPLtVn9XL3VYbctNTMHlWcEo
	I4Ju52lXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV0qF-00019K-PT; Tue, 20 Oct 2020 23:14:55 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV0qB-00017o-Tw
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 23:14:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603235692; x=1634771692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m4hjCUzkWnu6h2bPnXJZ4bsr0xOYB1n4ttVdn7ZqUi8=;
 b=p3YA2pZMN3xDWScb7pWsWT44UXbv/09RjXJohX/VbucUoVqX73fxHdmP
 kvOy6NwUoJyt8m2DK5HferdSvmrhck4AXBDN2BRHmLhjbGTgPCbGdT2dp
 aKalszmMAMOIq6uHIcmbKa/QVzgo+LXOcocLhijHkPqf7sRSdOt38QFo1
 LW2lG+vWGCEbp7QN2HN4/yVCvzCKTuF5Jye70pnvu4XmdtjiaTWqgvjh9
 FVf6cjeV3wj/lO0G9MQk02/31xa3/6ZGI29hIMUPR1FfVrOFnKQAlYRsQ
 QdnPeoNWi+YxHj+s1lgGIR/825zQM0yIoimoisBO+2ahMoGo4iy0ramjB A==;
IronPort-SDR: ZfVJSwN1B69CVMSVkImews7nU10N4RmHXytZfn4tRNfOyKXRMpTb6PcSItzXty/cGIMGHi4TDD
 PZGUXpHDqN6VYuserCYdITDuFlXuAXO9/PqT9eL4BOG9a8FTVdY+CoZR1D06PlEzBRXTemW7ZA
 OAI6CGVEOfMpnb4kNYRY68FNO4WyiwtW3hPqIIDuwfE3ooTS+5EPYGtB8GiXkwNHPAA9sEeneT
 tRp6Ac2LRcjCsi3u2pmTVTPfUrbV/ZqIbWq1SO1j4U05ddHMwBS15YDH5t00jD6Fh/9l5XNyGA
 CK4=
X-IronPort-AV: E=Sophos;i="5.77,399,1596470400"; d="scan'208";a="150547167"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2020 07:14:52 +0800
IronPort-SDR: F09ivbAH/X0PxX5h3gYAGPMixOU4xQoIiBjebnUtHrNEj5c94diMyl58k0xLkxSD24IR07842t
 moomEiAJjtFRrTkmccsokyXr12ggfIs0YTbhmCnvangkPhxx4tpUb1rCnKpC4ihFCRXIXKAhDI
 nOcLmt3+HMamp5SjF1VIfUuKgMJYXxH4nAeke96l60+m8KJann0NbA9tKnL7t37YK8O3wUrm09
 ZLWnvUBOTZEVKFtrQOIG3m+A+o06cAz8Vu40P/N3fHRdPGK5EGfEkoWMr/KcKJOd3aa4sv0VMY
 irozLU60iy1KowD4kOEW3Qiu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2020 16:00:25 -0700
IronPort-SDR: ac/Wv4jx4peeUP/ZSE+oDc6sgO1cNehXeeHkoBGC+truMZYE8m/9TQgOgwVwzwOnUuYlPYrNhH
 gEhhNsTylQtkIbGnQd3dpgJdUdTqV9f+GaCZs1bzZBXtVGb70v8Zn2KmEfn+S7kvky0M8pmTn5
 IIST3lNqJg0pehybc3Bk1wKg0/4NzewOd204zBY0khnVMc3/rUcBe4HSwdsXwp7Aw04y1QYFpm
 XdnaKz0x7gfs868hiEq0U3i3dLKH0yYOCdKre9HtoDb243o4u8otFR78tae8KEaX0k6+ul1tCq
 kGU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 20 Oct 2020 16:14:52 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/1] nvmet: don't use BLK_MQ_REQ_NOWAIT for passthru
Date: Tue, 20 Oct 2020 16:14:04 -0700
Message-Id: <20201020231404.9365-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201020231404.9365-1-chaitanya.kulkarni@wdc.com>
References: <20201020231404.9365-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_191452_128163_3DBC876E 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QnkgZGVmYXVsdCwgd2Ugc2V0IHRoZSBwYXNzdGhydSByZXF1ZXN0IGFsbG9jYXRpb24gZmxhZyBz
dWNoIHRoYXQgaXQKcmV0dXJucyB0aGUgZXJyb3IgaW4gdGhlIGZvbGxvd2luZyBjb2RlIHBhdGgg
YW5kIHdlIGZhaWwgdGhlIEkvTyB3aGVuCkJMS19NUV9SRVFfTk9XQUlUIGlzIHVzZWQgZm9yIHJl
cXVlc3QgYWxsb2NhdGlvbiA6LQoKbnZtZV9hbGxvY19yZXF1ZXN0KCkKwqBibGtfbXFfYWxsb2Nf
cmVxdWVzdCgpCsKgIGJsa19tcV9xdWV1ZV9lbnRlcigpCsKgIMKgaWYgKGZsYWcgJiBCTEtfTVFf
UkVRX05PV0FJVCkKwqAgwqAgwqAgwqAgcmV0dXJuIC1FQlVTWTsgPC0tIHJldHVybiBpZiBidXN5
LgoKT24gc29tZSBjb250cm9sbGVycyB1c2luZyBCTEtfTVFfUkVRX05PV0FJVCBlbmRzIHVwIGlu
IEkvTyBlcnJvciB3aGVyZQp0aGUgY29udHJvbGxlciBpcyBwZXJmZWN0bHkgaGVhbHRoeSBhbmQg
bm90IGluIGEgZGVncmFkZWQgc3RhdGUuCgpCbG9jayBsYXllciByZXF1ZXN0IGFsbG9jYXRpb24g
ZG9lcyBhbGxvdyB1cyB0byB3YWl0IGluc3RlYWQgb2YKaW1tZWRpYXRlbHkgcmV0dXJuaW5nIHRo
ZSBlcnJvciB3aGVuIHdlIEJMS19NUV9SRVFfTk9XQUlUIGZsYWcgaXMgbm90CnVzZWQuIFRoaXMg
aGFzIHNob3duIHRvIGZpeCB0aGUgSS9PIGVycm9yIHByb2JsZW0gcmVwb3J0ZWQgdW5kZXIKaGVh
dnkgcmFuZG9tIHdyaXRlIHdvcmtsb2FkLgoKUmVtb3ZlIHRoZSBCTEtfTVFfUkVRX05PV0FJVCBw
YXJhbWV0ZXIgZm9yIHBhc3N0aHJ1IHJlcXVlc3QgYWxsb2NhdGlvbgp3aGljaCByZXNvbHZlcyB0
aGlzIGlzc3VlLgoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEu
a3Vsa2FybmlAd2RjLmNvbT4KLS0tCiBkcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgYi9kcml2ZXJzL252bWUvdGFy
Z2V0L3Bhc3N0aHJ1LmMKaW5kZXggNTZjNTcxMDUyMjE2Li5kMDgyMzUxNTY5ZGUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYworKysgYi9kcml2ZXJzL252bWUvdGFy
Z2V0L3Bhc3N0aHJ1LmMKQEAgLTIzNiw3ICsyMzYsNyBAQCBzdGF0aWMgdm9pZCBudm1ldF9wYXNz
dGhydV9leGVjdXRlX2NtZChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpCiAJCXEgPSBucy0+cXVldWU7
CiAJfQogCi0JcnEgPSBudm1lX2FsbG9jX3JlcXVlc3QocSwgcmVxLT5jbWQsIEJMS19NUV9SRVFf
Tk9XQUlULCBOVk1FX1FJRF9BTlkpOworCXJxID0gbnZtZV9hbGxvY19yZXF1ZXN0KHEsIHJlcS0+
Y21kLCAwLCBOVk1FX1FJRF9BTlkpOwogCWlmIChJU19FUlIocnEpKSB7CiAJCXN0YXR1cyA9IE5W
TUVfU0NfSU5URVJOQUw7CiAJCWdvdG8gb3V0X3B1dF9uczsKLS0gCjIuMjIuMQoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGlu
ZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
