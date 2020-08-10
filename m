Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04819C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EB220829
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BYHgfvjC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cIeypS+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EB220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vaVoHlGBeI7EAHJLYH4qGHuLdy6btmbpDb+8NcsC+zQ=; b=BYHgfvjCxkupWn8rKZF6wq5Wg
	2Br3VUEi4Tthha8bnxeJu+FTsfz3otuf4mYm8Xi/mKI9rEc8Bx62HVRMVak2FirbfXq7pBUZCHpxR
	tzmMlpXqFI69H5CMLAvJTOoWTqZ8YcTB9WNFgv09mBnXAgyYCJrcyDa4blagB5O94RY1O3670koXq
	dwwUjjl0X88DNzz6WrrdtR7kgesgvjw8qit3okT/l9+JoXwYGihGrrTnL4k20EG2GiGMLgGIWkBJ+
	a1Kl+9+34ZSujj+FM2VT1kyQ2Hdl4vXyRUCeSjS5Oqg9AnzUYvz23xa64YUbpNs7TpmARqS7HnKP5
	xNyWX00ZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5C8D-00012c-5m; Mon, 10 Aug 2020 18:02:45 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5C8A-00010P-35
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597082562; x=1628618562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rHgVmKaBhB64mU57TkmXGTd3Lvw+5bmK8e+BlV5WEPo=;
 b=cIeypS+rrA8MSQmSng4QDq9HCiiWd5lBZvEFYKgSHxV3m7I1DHGcs/BB
 oL8ASJ5aHvBHivFrk2arSOyWAntluNBZhnvPsLaE7hY9rUYphCjJBrzV6
 0ZGgJcPhMwYAHfZcL2e/Apmmx48n1EmGHtySdyFjjssgmCaquh8UxOQ7D
 +gnzLg7qhgm+ZHRh2fTFfGWEhKqFWh7i+AagXj/Zx4vQIE14fmMiwz98k
 yLIJV6E65db0ii4SrGbBgqaKNZl9X5tplZGoRamabPMbuS2nw2phUcl5C
 TV5wGg1W+sKrKRBxAO+d1P1jpXf0ieGhOOffhT659S391cMzPh/Buh/xf A==;
IronPort-SDR: BEbpnpHc+yG2TJyMPGjUqrwgUTWFcs338+gCXfRlIRok76UfgpWH/mAMLJWuKBHraIxm75gezm
 Hb2QiB1DMScundENz5xhs9T5S3j9PlKyyv0771Rd/6HNFNXMf7WqpkPtsvK5XgxbXhqcB6PASv
 R0U12h5cQYfCpagug0btLl7SjNLufWz03mU0vcWHfb/4a9gEb1eLD31bVzt46Z4a/FjIPBvSbo
 qv6pgOTInAMCyEJjAK4IJc15+sfhWTvRvjYY9LOswvdS918HocxTsQjaQCsS7Ef1XWXON0hCBQ
 z10=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144647703"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:02:24 +0800
IronPort-SDR: iaCUZ+Max24fMtqT/bavgIvzPFdl4dNk+GM598AywLjkdAQt6IeEaFsnNonbsEhZ3qED/ET1jD
 HzaJIaMm7Iuw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 10:50:18 -0700
IronPort-SDR: UbIGaWA5KaMVPF47V95F//BMBJvuWAVLLdA86ZUIXONc4vlc+Tfh38WL+vCZlVqvR95+d2UlWW
 ufuy3zQ3v9BQ==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:02:24 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [RESEND PATCH V2 1/3] nvmet: add ns tear down label for pt-cmd
 handling
Date: Mon, 10 Aug 2020 11:02:16 -0700
Message-Id: <20200810180218.5857-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810180218.5857-1-chaitanya.kulkarni@wdc.com>
References: <20200810180218.5857-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_140242_275873_54B20C48 
X-CRM114-Status: GOOD (  15.53  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gYmVmb3JlIHN1Ym1pdHRpbmcgdGhlIHBhc3N0
aHJ1IGNtZMKgd2UKbWF5IGNvbWUgYWNyb3NzwqBlcnJvciBlLmcuIGdldHRpbmcgbnMgZnJvbSBw
YXNzdGhydSBjb250cm9sbGVyLAphbGxvY2F0aW5nIGEgcmVxdWVzdCBmcm9tIHBhc3N0aHJ1IGNv
bnRyb2xsZXIsIGV0Yy4gRm9yIGFsbCB0aGUgZmFpbHVyZQpjYXNlcyBpdCBvbmx5IHVzZXMgc2lu
Z2xlIGdvdG8gbGFiZWwgZmFpbF9vdXQuCgpJbiB0aGUgdGFyZ2V0IGNvZGUsIHdlIGZvbGxvdyB0
aGUgcGF0dGVybiB0byBoYXZlIGEgc2VwYXJhdGUgbGFiZWwgZm9yCmVhY2ggZXJyb3Igb3V0IHRo
ZSBjYXNlIHdoZW4gc2V0dGluZyB1cCBtdWx0aXBsZSB0aGluZ3MgYmVmb3JlIHRoZSBhY3R1YWwK
YWN0aW9uLgoKVGhpcyBwYXRjaCBmb2xsb3dzIHRoZSBzYW1lIHBhdHRlcm4gYW5kIHJlbmFtZXMg
Z2VuZXJpYyBmYWlsX291dCBsYWJlbAp0byBvdXRfcHV0X25zIGFuZCB1cGRhdGVzIHRoZSBlcnJv
ciBvdXQgY2FzZXMgaW4gdGhlCm52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kKCkgd2hlcmUgaXQg
aXMgbmVlZGVkLgoKU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEu
a3Vsa2FybmlAd2RjLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0
LmRlPgpSZXZpZXdlZC1ieTogTG9nYW4gR3VudGhvcnBlIDxsb2dhbmdAZGVsdGF0ZWUuY29tPgot
LS0KIGRyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYyB8IDkgKysrKystLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS90YXJnZXQvcGFzc3RocnUuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3Ro
cnUuYwppbmRleCA4OWQ5MWRjOTk5YTYuLmU3ZGJjYTEyNzg1ZCAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9udm1lL3RhcmdldC9wYXNzdGhydS5jCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcGFzc3Ro
cnUuYwpAQCAtMjMwLDcgKzIzMCw3IEBAIHN0YXRpYyB2b2lkIG52bWV0X3Bhc3N0aHJ1X2V4ZWN1
dGVfY21kKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkKIAkJaWYgKHVubGlrZWx5KCFucykpIHsKIAkJ
CXByX2VycigiZmFpbGVkIHRvIGdldCBwYXNzdGhydSBucyBuc2lkOiV1XG4iLCBuc2lkKTsKIAkJ
CXN0YXR1cyA9IE5WTUVfU0NfSU5WQUxJRF9OUyB8IE5WTUVfU0NfRE5SOwotCQkJZ290byBmYWls
X291dDsKKwkJCWdvdG8gb3V0OwogCQl9CiAKIAkJcSA9IG5zLT5xdWV1ZTsKQEAgLTI0MCwxNCAr
MjQwLDE0IEBAIHN0YXRpYyB2b2lkIG52bWV0X3Bhc3N0aHJ1X2V4ZWN1dGVfY21kKHN0cnVjdCBu
dm1ldF9yZXEgKnJlcSkKIAlpZiAoSVNfRVJSKHJxKSkgewogCQlycSA9IE5VTEw7CiAJCXN0YXR1
cyA9IE5WTUVfU0NfSU5URVJOQUw7Ci0JCWdvdG8gZmFpbF9vdXQ7CisJCWdvdG8gb3V0X3B1dF9u
czsKIAl9CiAKIAlpZiAocmVxLT5zZ19jbnQpIHsKIAkJcmV0ID0gbnZtZXRfcGFzc3RocnVfbWFw
X3NnKHJlcSwgcnEpOwogCQlpZiAodW5saWtlbHkocmV0KSkgewogCQkJc3RhdHVzID0gTlZNRV9T
Q19JTlRFUk5BTDsKLQkJCWdvdG8gZmFpbF9vdXQ7CisJCQlnb3RvIG91dF9wdXRfbnM7CiAJCX0K
IAl9CiAKQEAgLTI3NCw5ICsyNzQsMTAgQEAgc3RhdGljIHZvaWQgbnZtZXRfcGFzc3RocnVfZXhl
Y3V0ZV9jbWQoc3RydWN0IG52bWV0X3JlcSAqcmVxKQogCiAJcmV0dXJuOwogCi1mYWlsX291dDoK
K291dF9wdXRfbnM6CiAJaWYgKG5zKQogCQludm1lX3B1dF9ucyhucyk7CitvdXQ6CiAJbnZtZXRf
cmVxX2NvbXBsZXRlKHJlcSwgc3RhdHVzKTsKIAlibGtfcHV0X3JlcXVlc3QocnEpOwogfQotLSAK
Mi4yMi4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
