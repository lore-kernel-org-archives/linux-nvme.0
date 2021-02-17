Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF46C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37F464DDA
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37F464DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WgUPWfiUypVoDUQM6H3LMPif2V26VkB9ddfypUnoe4A=; b=KCziXg7C1WrMVfXQYIoyrhhes
	ImGv77P+ddAXF8wMNyf8UXtH+elx9U0LPXrHBJVv9jVW/K1AbxtICi59yzpDmKUoHZoasUS6ZjxK/
	HLV+Xmx+M1tlmK3JPllqyPLiOCWnGtY8C/sCHzeQqZBvr8XxtneDZBb2hF2Bsd2SodyzUF0yKuST/
	WQeCNxiK1NTSd5tdiXrwo+O+LfeYudSaXKe8Xf0ZSBiFxoUZt9g9e+QU+L4ct6v71Z5tKpkc3rpXA
	+Rb4aJsNVonqDcp2iA+xUPu+PJk2n12kCcfekXZFyfH61A3bdoU8ykC14UPZW7B3bd0ZsnsxzItmw
	A7oaEwCsw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCARt-00080E-0r; Wed, 17 Feb 2021 00:12:09 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCARl-0007xc-Os
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:12:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613521767; x=1645057767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ksjUn5m8BHtP6hGJ8hndRvNYWx6F2wE5gWC9nYjaixs=;
 b=FqD4cI1mbYUMyq/ARJ+rK56sUpQbC2akU2Gm4d0obn2+93pqmeE/ltW2
 ZE8xRV3jn8Gka/Yt/kWyir2OFlvFrAiTAucMmZR2ZCHxHL22kL8y4NUwo
 3Ptgjz/riK/mE2h2uwUOGFVawkKzNVH3MT+bu5eEhNjqLNTF9iwEeg+M/
 XKG3rPztyIGhmZCpPJ2NNY3X3Alp0chrGd7w7B5VZNFEg6lz3IBCXBdtf
 4KR768rhDA341pukCbiMj/ZgeKKDtkaVs2ydgP8HCT3BRABP2ySJWtWwD
 TdqxnyFacOhpiSYamQ2cLtkmG5NOOrlBmbCm/q5biBZLw6KODirGS5fTh w==;
IronPort-SDR: zVrwFAM0hhqnnwp/ekS7sthgtJUQjunOdXw7F0Ky1C1kefONM6RDaYCGd15tzZdTo2PPQuF2Vg
 oJCHd23GRIp/RID/CbuAA2sw/m6OCILR8tMjBkUg9WrdZ2B3bX+ayMfd6/j03Y3U2vPQPZdgNx
 7MEyOKDsnSEYkdi/lemYbzBE4lEU105NdPyyVLtDQ/XMrjT/3bKHJ3ljduQ7b+S7EZA5a7WofY
 IU/b5HUgIrRPzMkbit8iozOIt6NcdkT3lJNkafefDMiSj1PN2//MNjFgVH1JdscMwgqHcW4fOC
 ZY0=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="264274446"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:29:26 +0800
IronPort-SDR: TdVQrI7OamE+Zabsh/1SJSPpXks1Pz0piHhpfDeE8qVhkEtp7DFjZa8TI/8G9k7/PPbfjOCeCd
 ncGVb+bG2qu/leqEDPRFnaFi/ENDgJp3tLv5Uua3ICo8kN7MENiDOCQSSPQ4rber2vigO3muJS
 RsLE/BhNV0cAL/lGzrn03EFuHuY+QuKIJrlBUtGwGpHtLhULdiU3/xdfTWID4gSHrrcvuWsVf6
 n8y+JAc1dDzkDKjakZzxSMX72s+59Df/qzOQFGvp5WIQonWYGKWfQpcrWHUAMMy6Zq1hkCZsNj
 bACNAMci95ZvAOL+XfbFRBOu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:53:45 -0800
IronPort-SDR: xoyuieNWkmX4POrTxKKh2gG1G1aHDWULKPQRxUJPxP2jubu0YOCFcUdVGor4Lk5XxQX0kaRzbT
 8Q5w4SfbCUnkISZTYTnjL+y0hbu9ZuI2yz630+KpymqSqLT6NV2GbZYUpg1VZviBFZpPDB4KH7
 xRMCuoRuVFSRG6g41mZtNWnk69nOu+QtObQQIOVoEDvUDsMOK3k/WbrzD38dPjtXIpC/V7T+Cg
 WzmONI6eoyEVkHAof/UEh4CksfL8oU9z1GzjPCbqjhyqEnF1yGFm4y/v/EyaWbwzMaLuwfoB16
 sfc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:12:01 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 12/14] nvme-core: don't check nvme_req flags for new req
Date: Tue, 16 Feb 2021 16:10:30 -0800
Message-Id: <20210217001032.25741-13-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191202_021615_009748A2 
X-CRM114-Status: GOOD (  14.39  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

bnZtZV9jbGVhcl9yZXF1ZXN0KCkgaGFzIGEgY2hlY2sgZm9yIGZsYWcgUkVRX0RPTlRQUkVQIGFu
ZCBpdCBpcyBjYWxsZWQKZnJvbSBudm1lX2luaXRfcmVxdWVzdCgpIGFuZCBudm1lX3NldHVvX2Nt
ZCgpLgoKVGhlIGZ1bmN0aW9uIG52bWVfaW5pdF9yZXF1ZXN0KCkgaXMgY2FsbGVkIGZyb20gbnZt
ZV9hbGxvY19yZXF1ZXN0KCkKYW5kIG52bWVfYWxsb2NfcmVxdWVzdF9xaWQoKS4gRnJvbSB0aGVz
ZSB0d28gY2FsbGVycyBuZXcgcmVxdWVzdCBpcwphbGxvY2F0ZWQgZXZlcnl0aW1lLiBGb3IgbmV3
bHkgYWxsb2NhdGVkIHJlcXVlc3QgUlFGX0RPTlRQUkVQIGlzIG5ldmVyCnNldC4gU2luY2UgYWZ0
ZXIgZ2V0dGluZyBhIHRhZywgYmxvY2sgbGF5ZXIgc2V0cyB0aGUgcmVxLT5ycV9mbGFncyA9PSAw
CmFuZCBuZXZlciBzZXRzIHRoZSBSRVFfRE9OVFBSRVAgd2hlbiByZXR1cm5pbmcgdGhlIHJlcXVl
c3QgOi0KCm52bWVfYWxsb2NfcmVxdWVzdCgpCglibGtfbXFfYWxsb2NfcmVxdWVzdCgpCgkJYmxr
X21xX3JxX2N0eF9pbml0KCkKCQkJcnEtPnJxX2ZsYWdzID0gMCA8LS0tLQoKbnZtZV9hbGxvY19y
ZXF1ZXN0X3FpZCgpCglibGtfbXFfYWxsb2NfcmVxdWVzdF9oY3R4KCkKCQlibGtfbXFfcnFfY3R4
X2luaXQoKQoJCQlycS0+cnFfZmxhZ3MgPSAwIDwtLS0tCgpUaGUgYmxvY2sgbGF5ZXIgZG9lcyBz
ZXQgcmVxLT5ycV9mbGFncyBidXQgUkVRX0RPTlRQUkVQIGlzIG5vdCBvbmUgb2YKdGhlbSBhbmQg
dGhhdCBpcyBzZXQgYnkgdGhlIGRyaXZlci4KClRoYXQgbWVhbnMgd2UgY2FuIHVuY29uZGl0aW5h
bGx5IHNldCB0aGUgUkVRX0RPTlRQUkVQIHZhbHVlIHRvIHRoZQpycS0+cnFfZmxhZ3Mgd2hlbiBu
dm1lX2luaXRfcmVxdWVzdCgpLT5udm1lX2NsZWFyX3JlcXVlc3QoKSBpcyBjYWxsZWQKZnJvbSBh
Ym92ZSB0d28gY2FsbGVycy4KCk1vdmUgdGhlIGNoZWNrIGZvciBSRVFfRE9OVFBSRVAgZnJvbSBu
dm1lX2NsZWFyX252bWVfcmVxdWVzdCgpIGludG8KbnZtZV9zZXR1cF9jbWQoKS4KClRoaXMgaXMg
bmVlZGVkIHNpbmNlIG52bWVfYWxsb2NfcmVxdWVzdCgpIG5vdyBnZXRzIGNhbGxlZCBmcm9tIGZh
c3QKcGF0aCB3aGVuIE5WTWVPRiB0YXJnZXQgaXPCoGNvbmZpZ3VyZWQgd2l0aCBwYXNzdGhydSBi
YWNrZW5kIHRvIGF2b2lkCnVubmVjZXNzYXJ5IGNoZWNrcyBpbiB0aGUgZmFzdCBwYXRoLgoKU2ln
bmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNv
bT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCAxMSArKysrKy0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKaW5kZXgg
YTBkMGMzYTVhYmZmLi42MDg0NjJkZjJjMzkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTYzNywxMSArNjM3LDkg
QEAgRVhQT1JUX1NZTUJPTF9OU19HUEwobnZtZV9wdXRfbnMsIE5WTUVfVEFSR0VUX1BBU1NUSFJV
KTsKIAogc3RhdGljIGlubGluZSB2b2lkIG52bWVfY2xlYXJfbnZtZV9yZXF1ZXN0KHN0cnVjdCBy
ZXF1ZXN0ICpyZXEpCiB7Ci0JaWYgKCEocmVxLT5ycV9mbGFncyAmIFJRRl9ET05UUFJFUCkpIHsK
LQkJbnZtZV9yZXEocmVxKS0+cmV0cmllcyA9IDA7Ci0JCW52bWVfcmVxKHJlcSktPmZsYWdzID0g
MDsKLQkJcmVxLT5ycV9mbGFncyB8PSBSUUZfRE9OVFBSRVA7Ci0JfQorCW52bWVfcmVxKHJlcSkt
PnJldHJpZXMgPSAwOworCW52bWVfcmVxKHJlcSktPmZsYWdzID0gMDsKKwlyZXEtPnJxX2ZsYWdz
IHw9IFJRRl9ET05UUFJFUDsKIH0KIAogc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQgbnZtZV9y
ZXFfb3Aoc3RydWN0IG52bWVfY29tbWFuZCAqY21kKQpAQCAtOTQzLDcgKzk0MSw4IEBAIGJsa19z
dGF0dXNfdCBudm1lX3NldHVwX2NtZChzdHJ1Y3QgbnZtZV9ucyAqbnMsIHN0cnVjdCByZXF1ZXN0
ICpyZXEsCiB7CiAJYmxrX3N0YXR1c190IHJldCA9IEJMS19TVFNfT0s7CiAKLQludm1lX2NsZWFy
X252bWVfcmVxdWVzdChyZXEpOworCWlmICghKHJlcS0+cnFfZmxhZ3MgJiBSUUZfRE9OVFBSRVAp
KQorCQludm1lX2NsZWFyX252bWVfcmVxdWVzdChyZXEpOwogCiAJbWVtc2V0KGNtZCwgMCwgc2l6
ZW9mKCpjbWQpKTsKIAlzd2l0Y2ggKHJlcV9vcChyZXEpKSB7Ci0tIAoyLjIyLjEKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
