Return-Path: <SRS0=Uncj=4D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA897C35242
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:13:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97081206CC
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LdjfKXFH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="puGF+pAH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97081206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=YMg0C2onLt81YkvcFm0hE4Dwo6P7eZZKHqvhuJuEN0U=; b=LdjfKXFHTlAVEe
	X3l3e5qs7YuETsH2uMj2712wDQXI8zakqK7YcXEFCLegjIYqjjnweW6vPavzp1BHeTJBfhTzkgE89
	quezi7SZQfPhajx7m7igh2g2rKJbSTN5co+c0XaOblwqeZIgO/S9Y3cwcy7+LuMsbU+EWElKNLJQe
	x8rRReNZ+/fW/+LL16ti35nLlB8IXFSLqIW05whSmyFOVdwIgbUqHFl7ew0oHB5kgecbW5fgdstxE
	PravbqO9K7FhhlpneuHDKaXSdcyks+Am5unoQFafZKhgehB+hP5zONHc9fZGw1rMEryzXM5uH/tg/
	/PiLYSmAgZb4aivXHfrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2m1E-0005vG-KP; Sat, 15 Feb 2020 01:13:16 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2m1A-0005uf-Dx
 for linux-nvme@lists.infradead.org; Sat, 15 Feb 2020 01:13:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581729198; x=1613265198;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=jGQRiWvFaoajZbJR4tm+qhVrsHDqr4KnOEPxUskgVlg=;
 b=puGF+pAHxwO825AMsqAJmUehDgRoka/0kK5FZgQmlu3tNG0jstr6kUDu
 0feVMPkAyvs5NlUbJbuxBES5lvWgOJYDWShfj0vrLTvpXIp3CK5xzls9G
 nQDACdmoCXpJKABgOUJeQuZf8mbsnxMhm37RKIo7VT5+RbbDeTQOo6uTt
 bI8l4jOae1sOmfWclnTkXYYMt6oetjyWWIyBjq5iY1+r8Ci8MiXeiuuw3
 LRF8UBG7sPk6TyzDTE1WSpZixgfQq89e9sOeCOL99k+0++UwYMJNEv6bz
 yupgj45swY3hSxGdeHoApplfxdMdwp0B9OcJZgwSsh7VlOO6nl2ODgRZO Q==;
IronPort-SDR: 9l8/8eG5HERLKW/n7PlZe8krSy+zlDnNg0rsqlKqk1zvF7cbVljqZUG8BpUZaoz8ulnUmRv2FV
 DudojbJj5HlRrShZR1VOthUizN6TXTEPF3esxxpZzv07Q3p8kF6XfknVhNZFEeVfg6OFnPuyaY
 eW2kj06Sy8Cwbsxi1zFh/6rxVwgN2ZOP1TP+lq4evbIQkIXS5evRzbWF7ozt4kVkFtfzWXxd31
 9ru6WhavhCMyc+Xd7N5c8SKhv9SUCL8wkjRS3Za3Z6hFiyUvc7lxS539I0ADg868hC8626c4mH
 5vo=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; d="scan'208";a="231727103"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:13:06 +0800
IronPort-SDR: iqpNlP3evUcn7J+8mKBkag3xa0NHTkSh3Jax0rM1VyAxy3awaWztMv8BEeUrrDgKYRiRkJTu1i
 sltWUUpfAjmnXdtH53ft2KpUVOZw/uimQREV7u8/3/sA9bfrub8/jgOYsE73R4JfaNBb6ZnlZd
 vPDzEkHBCcoXE2MVkEsG3xefcQldU8KpCB+1zv5tK4R83IFM9chTfRXvGxTC+XUpUPt+dRtNW/
 e4GquoC6+kABXA24rulYblCKTra9FxctzcuBQC9eORtyis758xkxVjQwd5DCr9wQu7tyCPjpUt
 DXouTqmiJxWHqS6AwoeGn+8a
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 17:05:49 -0800
IronPort-SDR: nE2M5SAXsrfu4lONz1P3yTdbVlz5b5x+yJ3GjFav9V4BdeRegIxbLBjOOiuxdCMOmdN91lr6Xf
 QhZSnb9p0KFnPMRKMct0mnw9Wa197Wz4GqQpqD12d8aFp6lX5NMfK/GAabSTh9r8rc4W8S258W
 8guASKfzjJlAH0VfLrSPXmFRZ1/SNjHqdKmHf2FcYKoppf7BqNqNADiSHHLcup/Qsa+LHCht67
 1SlbZ/JBNkTbPyCPhR9lGNDjRrSbXsDwx3JV3BOacKnoXpxkgoMQFZMbispkOLXxZ7XJXtY/7A
 ZE8=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:13:05 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: kbusch@kernel.org
Subject: [PATCH V2] nvme: code cleanup nvme_identify_ns_desc()
Date: Fri, 14 Feb 2020 17:13:03 -0800
Message-Id: <20200215011303.4589-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_171312_583300_14133576 
X-CRM114-Status: GOOD (  15.30  )
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhlIGZ1bmN0aW9uIG52bWVfaWRlbnRpZnlfbnNfZGVzYygpIGhhcyAzIGxldmVscyBvZiBuZXN0
aW5nIHdoaWNoIG1ha2UKZXJyb3IgbWVzc2FnZSB0byBleGNlZWRlZCA+IDgwIGNoYXIgcGVyIGxp
bmUgd2hpY2ggaXMgbm90IGFsaWduZWQgd2l0aAp0aGUga2VybmVsIGNvZGUgc3RhbmRhcmRzIGFu
ZCByZXN0IG9mIHRoZSBOVk1lIHN1YnN5c3RlbSBjb2RlLgrCoApBZGQgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gbW92ZSB0byB0aGUgcHJvY2Vzc2luZyBvZiB0aGUgbG9nIHdoZW4gdGhlCmNvbW1hbmQg
aXMgc3VjY2Vzc2Z1bCBieSByZWR1Y2luZyB0aGUgbmVzdGluZyBhbmQga2VlcGluZyB0aGUKY29k
ZSA8IDgwIGNoYXIgcGVyIGxpbmUuCgpTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGNoYWl0YW55YS5rdWxrYXJuaUB3ZGMuY29tPgotLS0KQ2hhbmdlcyBmcm9tIFYxOiAtCgoxLiBQ
YXNzIHN0cnVjdCBudm1lX25zX2lkX2Rlc2MgKmN1ciBhcyBpdCBpcyB0byBhdm9pZCBkYXRhIGFu
ZCBwb3MKICAgcGFyYW1ldGVycyB0byBoYXZlIGEgc2xpZ2h0bHkgY2xlYW5lciBwYXRjaC4gKEtl
aXRoKQoKSGVyZSBpcyBxdWljayB0ZXN0IHJlc3VsdCB3aXRoIHRoaXMgcGF0Y2ggd2l0aCBWMiA6
LQoKIyBjYXQgY29uZmlnL252bWV0L3N1YnN5c3RlbXMvZnMvbmFtZXNwYWNlcy8xL2RldmljZV9u
Z3VpZCAKMTExMTExMTEtMTIzNC01Njc4LTkxMjMtMjIyMjIyMjIyMjIyCiMgY2F0IGNvbmZpZy9u
dm1ldC9zdWJzeXN0ZW1zL2ZzL25hbWVzcGFjZXMvMS9kZXZpY2VfdXVpZCAKMmIzZDEwMTktNjQw
My00ZjZiLTgzOTQtZGI0MmEwMzE2ZTgyCgojIG52bWUgbnMtZGVzY3MgL2Rldi9udm1lMW4xIApO
Vk1FIE5hbWVzcGFjZSBJZGVudGlmaWNhdGlvbiBEZXNjcmlwdG9ycyBOUyAxOgp1dWlkICAgIDog
MmIzZDEwMTktNjQwMy00ZjZiLTgzOTQtZGI0MmEwMzE2ZTgyCm5ndWlkICAgOiAxMTExMTExMTEy
MzQ1Njc4OTEyMzIyMjIyMjIyMjIyMgoKLS0tCiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA4
NiArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNDkgaW5zZXJ0aW9ucygrKSwgMzcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IGNkMGI0
N2VkMjE5ZS4uOWNhNzE5ZDA0YjFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC0xMDU1LDggKzEwNTUsNTIgQEAg
c3RhdGljIGludCBudm1lX2lkZW50aWZ5X2N0cmwoc3RydWN0IG52bWVfY3RybCAqZGV2LCBzdHJ1
Y3QgbnZtZV9pZF9jdHJsICoqaWQpCiAJcmV0dXJuIGVycm9yOwogfQogCitzdGF0aWMgaW50IG52
bWVfcHJvY2Vzc19uc19kZXNjKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBudm1lX25z
X2lkcyAqaWRzLAorCQkJCXN0cnVjdCBudm1lX25zX2lkX2Rlc2MgKmN1cikKK3sKKwljb25zdCBj
aGFyICp3YXJuX3N0ciA9ICJjdHJsIHJldHVybmVkIGJvZ3VzIGxlbmd0aDoiOworCXZvaWQgKmRh
dGEgPSBjdXI7CisJaW50IGxlbjsKKworCXN3aXRjaCAoY3VyLT5uaWR0KSB7CisJY2FzZSBOVk1F
X05JRFRfRVVJNjQ6CisJCWlmIChjdXItPm5pZGwgIT0gTlZNRV9OSURUX0VVSTY0X0xFTikgewor
CQkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLCAiJXMgJWQgZm9yIE5WTUVfTklEVF9FVUk2NFxuIiwK
KwkJCQkgd2Fybl9zdHIsIGN1ci0+bmlkbCk7CisJCQlyZXR1cm4gLTE7CisJCX0KKwkJbGVuID0g
TlZNRV9OSURUX0VVSTY0X0xFTjsKKwkJbWVtY3B5KGlkcy0+ZXVpNjQsIGRhdGEgKyBzaXplb2Yo
KmN1ciksIGxlbik7CisJCWJyZWFrOworCWNhc2UgTlZNRV9OSURUX05HVUlEOgorCQlpZiAoY3Vy
LT5uaWRsICE9IE5WTUVfTklEVF9OR1VJRF9MRU4pIHsKKwkJCWRldl93YXJuKGN0cmwtPmRldmlj
ZSwgIiVzICVkIGZvciBOVk1FX05JRFRfTkdVSURcbiIsCisJCQkJIHdhcm5fc3RyLCBjdXItPm5p
ZGwpOworCQkJcmV0dXJuIC0xOworCQl9CisJCWxlbiA9IE5WTUVfTklEVF9OR1VJRF9MRU47CisJ
CW1lbWNweShpZHMtPm5ndWlkLCBkYXRhICsgc2l6ZW9mKCpjdXIpLCBsZW4pOworCQlicmVhazsK
KwljYXNlIE5WTUVfTklEVF9VVUlEOgorCQlpZiAoY3VyLT5uaWRsICE9IE5WTUVfTklEVF9VVUlE
X0xFTikgeworCQkJZGV2X3dhcm4oY3RybC0+ZGV2aWNlLCAiJXMgJWQgZm9yIE5WTUVfTklEVF9V
VUlEXG4iLAorCQkJCSB3YXJuX3N0ciwgY3VyLT5uaWRsKTsKKwkJCXJldHVybiAtMTsKKwkJfQor
CQlsZW4gPSBOVk1FX05JRFRfVVVJRF9MRU47CisJCXV1aWRfY29weSgmaWRzLT51dWlkLCBkYXRh
ICsgc2l6ZW9mKCpjdXIpKTsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJLyogU2tpcCB1bmtub3du
IHR5cGVzICovCisJCWxlbiA9IGN1ci0+bmlkbDsKKwkJYnJlYWs7CisJfQorCisJcmV0dXJuIGxl
bjsKK30KKwogc3RhdGljIGludCBudm1lX2lkZW50aWZ5X25zX2Rlc2NzKHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwsIHVuc2lnbmVkIG5zaWQsCi0JCXN0cnVjdCBudm1lX25zX2lkcyAqaWRzKQorCQkJ
CSAgc3RydWN0IG52bWVfbnNfaWRzICppZHMpCiB7CiAJc3RydWN0IG52bWVfY29tbWFuZCBjID0g
eyB9OwogCWludCBzdGF0dXM7CkBAIC0xMDgzLDQyICsxMTI3LDEwIEBAIHN0YXRpYyBpbnQgbnZt
ZV9pZGVudGlmeV9uc19kZXNjcyhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lk
LAogCQlpZiAoY3VyLT5uaWRsID09IDApCiAJCQlicmVhazsKIAotCQlzd2l0Y2ggKGN1ci0+bmlk
dCkgewotCQljYXNlIE5WTUVfTklEVF9FVUk2NDoKLQkJCWlmIChjdXItPm5pZGwgIT0gTlZNRV9O
SURUX0VVSTY0X0xFTikgewotCQkJCWRldl93YXJuKGN0cmwtPmRldmljZSwKLQkJCQkJICJjdHJs
IHJldHVybmVkIGJvZ3VzIGxlbmd0aDogJWQgZm9yIE5WTUVfTklEVF9FVUk2NFxuIiwKLQkJCQkJ
IGN1ci0+bmlkbCk7Ci0JCQkJZ290byBmcmVlX2RhdGE7Ci0JCQl9Ci0JCQlsZW4gPSBOVk1FX05J
RFRfRVVJNjRfTEVOOwotCQkJbWVtY3B5KGlkcy0+ZXVpNjQsIGRhdGEgKyBwb3MgKyBzaXplb2Yo
KmN1ciksIGxlbik7Ci0JCQlicmVhazsKLQkJY2FzZSBOVk1FX05JRFRfTkdVSUQ6Ci0JCQlpZiAo
Y3VyLT5uaWRsICE9IE5WTUVfTklEVF9OR1VJRF9MRU4pIHsKLQkJCQlkZXZfd2FybihjdHJsLT5k
ZXZpY2UsCi0JCQkJCSAiY3RybCByZXR1cm5lZCBib2d1cyBsZW5ndGg6ICVkIGZvciBOVk1FX05J
RFRfTkdVSURcbiIsCi0JCQkJCSBjdXItPm5pZGwpOwotCQkJCWdvdG8gZnJlZV9kYXRhOwotCQkJ
fQotCQkJbGVuID0gTlZNRV9OSURUX05HVUlEX0xFTjsKLQkJCW1lbWNweShpZHMtPm5ndWlkLCBk
YXRhICsgcG9zICsgc2l6ZW9mKCpjdXIpLCBsZW4pOwotCQkJYnJlYWs7Ci0JCWNhc2UgTlZNRV9O
SURUX1VVSUQ6Ci0JCQlpZiAoY3VyLT5uaWRsICE9IE5WTUVfTklEVF9VVUlEX0xFTikgewotCQkJ
CWRldl93YXJuKGN0cmwtPmRldmljZSwKLQkJCQkJICJjdHJsIHJldHVybmVkIGJvZ3VzIGxlbmd0
aDogJWQgZm9yIE5WTUVfTklEVF9VVUlEXG4iLAotCQkJCQkgY3VyLT5uaWRsKTsKLQkJCQlnb3Rv
IGZyZWVfZGF0YTsKLQkJCX0KLQkJCWxlbiA9IE5WTUVfTklEVF9VVUlEX0xFTjsKLQkJCXV1aWRf
Y29weSgmaWRzLT51dWlkLCBkYXRhICsgcG9zICsgc2l6ZW9mKCpjdXIpKTsKLQkJCWJyZWFrOwot
CQlkZWZhdWx0OgotCQkJLyogU2tpcCB1bmtub3duIHR5cGVzICovCi0JCQlsZW4gPSBjdXItPm5p
ZGw7Ci0JCQlicmVhazsKLQkJfQorCQlsZW4gPSBudm1lX3Byb2Nlc3NfbnNfZGVzYyhjdHJsLCBp
ZHMsIGN1cik7CisKKwkJaWYgKGxlbiA8IDApCisJCQlnb3RvIGZyZWVfZGF0YTsKIAogCQlsZW4g
Kz0gc2l6ZW9mKCpjdXIpOwogCX0KLS0gCjIuMjIuMQoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK
