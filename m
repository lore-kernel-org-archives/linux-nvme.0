Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B826C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBA220890
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 14:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iHTtbEgM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkMLXVAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBA220890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3SFwsRUTTJ2n7EtVjhr/WOL/7NfOlAGRY838SAIHiNo=; b=iHTtbEgMD5/dwK
	mNAFo2JLDpzhfHNxEgkVaXgE+MqubXaI/sGKQauj1RmMsqlji4W2LHHyxL7gx+8ZFZRSDeOhZvDQ0
	5Z29XbUdCnK8pqm6mPJu4qiQxSr5EiynlZfOE8c53K7Ii7M10m/LL52PDE7fQWpAAZJqZIsFA05Bi
	FJlTAVwLwJszZKv/NECE4PK5Ahe53CpkUg4J40Go4lw5SdCoKKZLdY9rU77CB8Y3se/YvKBsfQbsG
	JJBJ0h+X0tJIyO/C7UlTOSIUPzgL7EtRdUBNXJw+ciECuhQ0pzIP7O211FLxItkPVX+N1NoewVcWo
	HUVSyHYMYAGnnq3CZbuQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlvvh-0003XV-Hb; Thu, 18 Jun 2020 14:54:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlvva-0003Po-5A
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 14:54:07 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2534020773;
 Thu, 18 Jun 2020 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592492045;
 bh=NdlnDueaM2kAyVhJucVHNEWSj5SbWdxgXOtHXhq/U+I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dkMLXVAr/jz0vuGLz5qQYgNPvVVtGlxSIZ4RmeqS5gtaH88Jew0Yafvy13L4znaxv
 HIdjKL8lcaBHnLO5Uy75lUMmpkpw0evLYQrf2AWZMMe7N/gvQMSgws+bKX6n9J+qyV
 uCDgdGUbXVn57IPCNjLKDPSATBarHQ8xB7ZYXZvY=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCHv2 1/5] block: add capacity field to zone descriptors
Date: Thu, 18 Jun 2020 07:53:50 -0700
Message-Id: <20200618145354.1139350-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200618145354.1139350-1-kbusch@kernel.org>
References: <20200618145354.1139350-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_075406_237574_26D6D2A1 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogTWF0aWFzIEJqw7hybGluZyA8bWF0aWFzLmJqb3JsaW5nQHdkYy5jb20+CgpJbiB0aGUg
em9uZWQgc3RvcmFnZSBtb2RlbCwgdGhlIHNlY3RvcnMgd2l0aGluIGEgem9uZSBhcmUgdHlwaWNh
bGx5IGFsbAp3cml0ZWFibGUuIFdpdGggdGhlIGludHJvZHVjdGlvbiBvZiB0aGUgWm9uZWQgTmFt
ZXNwYWNlIChaTlMpIENvbW1hbmQKU2V0IGluIHRoZSBOVk0gRXhwcmVzcyBvcmdhbml6YXRpb24s
IHRoZSBtb2RlbCB3YXMgZXh0ZW5kZWQgdG8gaGF2ZSBhCnNwZWNpZmljIHdyaXRlYWJsZSBjYXBh
Y2l0eS4KCkV4dGVuZCB0aGUgem9uZSBkZXNjcmlwdG9yIGRhdGEgc3RydWN0dXJlIHdpdGggYSB6
b25lIGNhcGFjaXR5IGZpZWxkIHRvCmluZGljYXRlIHRvIHRoZSB1c2VyIGhvdyBtYW55IHNlY3Rv
cnMgaW4gYSB6b25lIGFyZSB3cml0ZWFibGUuCgpJbnRyb2R1Y2UgYmFja3dhcmQgY29tcGF0aWJp
bGl0eSBpbiB0aGUgem9uZSByZXBvcnQgaW9jdGwgYnkgZXh0ZW5kaW5nCnRoZSB6b25lIHJlcG9y
dCBoZWFkZXIgZGF0YSBzdHJ1Y3R1cmUgd2l0aCBhIGZsYWdzIGZpZWxkIHRvIGluZGljYXRlIGlm
CnRoZSBjYXBhY2l0eSBmaWVsZCBpcyBhdmFpbGFibGUuCgpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlAd2RjLmNvbT4KUmV2aWV3ZWQtYnk6IEphdmll
ciBHb256w6FsZXogPGphdmllci5nb256QHNhbXN1bmcuY29tPgpSZXZpZXdlZC1ieTogRGFuaWVs
IFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPgpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJu
IDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRl
cnNlbiA8bWFydGluLnBldGVyc2VuQG9yYWNsZS5jb20+ClNpZ25lZC1vZmYtYnk6IE1hdGlhcyBC
asO4cmxpbmcgPG1hdGlhcy5iam9ybGluZ0B3ZGMuY29tPgotLS0KIGJsb2NrL2Jsay16b25lZC5j
ICAgICAgICAgICAgICB8ICAxICsKIGRyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYyB8ICAy
ICsrCiBkcml2ZXJzL3Njc2kvc2RfemJjLmMgICAgICAgICAgfCAgMSArCiBpbmNsdWRlL3VhcGkv
bGludXgvYmxrem9uZWQuaCAgfCAxNSArKysrKysrKysrKysrLS0KIDQgZmlsZXMgY2hhbmdlZCwg
MTcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ibG9jay9ibGst
em9uZWQuYyBiL2Jsb2NrL2Jsay16b25lZC5jCmluZGV4IDIzODMxZmE4NzAxZC4uODExNTJhMjYw
MzU0IDEwMDY0NAotLS0gYS9ibG9jay9ibGstem9uZWQuYworKysgYi9ibG9jay9ibGstem9uZWQu
YwpAQCAtMzEyLDYgKzMxMiw3IEBAIGludCBibGtkZXZfcmVwb3J0X3pvbmVzX2lvY3RsKHN0cnVj
dCBibG9ja19kZXZpY2UgKmJkZXYsIGZtb2RlX3QgbW9kZSwKIAkJcmV0dXJuIHJldDsKIAogCXJl
cC5ucl96b25lcyA9IHJldDsKKwlyZXAuZmxhZ3MgPSBCTEtfWk9ORV9SRVBfQ0FQQUNJVFk7CiAJ
aWYgKGNvcHlfdG9fdXNlcihhcmdwLCAmcmVwLCBzaXplb2Yoc3RydWN0IGJsa196b25lX3JlcG9y
dCkpKQogCQlyZXR1cm4gLUVGQVVMVDsKIAlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
YmxvY2svbnVsbF9ibGtfem9uZWQuYyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYwpp
bmRleCBjYzQ3NjA2ZDhmZmUuLjYyNGFhYzA5YjAwNSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ibG9j
ay9udWxsX2Jsa196b25lZC5jCisrKyBiL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYwpA
QCAtNDcsNiArNDcsNyBAQCBpbnQgbnVsbF9pbml0X3pvbmVkX2RldihzdHJ1Y3QgbnVsbGJfZGV2
aWNlICpkZXYsIHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxKQogCiAJCXpvbmUtPnN0YXJ0ID0gc2Vj
dG9yOwogCQl6b25lLT5sZW4gPSBkZXYtPnpvbmVfc2l6ZV9zZWN0czsKKwkJem9uZS0+Y2FwYWNp
dHkgPSB6b25lLT5sZW47CiAJCXpvbmUtPndwID0gem9uZS0+c3RhcnQgKyB6b25lLT5sZW47CiAJ
CXpvbmUtPnR5cGUgPSBCTEtfWk9ORV9UWVBFX0NPTlZFTlRJT05BTDsKIAkJem9uZS0+Y29uZCA9
IEJMS19aT05FX0NPTkRfTk9UX1dQOwpAQCAtNTksNiArNjAsNyBAQCBpbnQgbnVsbF9pbml0X3pv
bmVkX2RldihzdHJ1Y3QgbnVsbGJfZGV2aWNlICpkZXYsIHN0cnVjdCByZXF1ZXN0X3F1ZXVlICpx
KQogCiAJCXpvbmUtPnN0YXJ0ID0gem9uZS0+d3AgPSBzZWN0b3I7CiAJCXpvbmUtPmxlbiA9IGRl
di0+em9uZV9zaXplX3NlY3RzOworCQl6b25lLT5jYXBhY2l0eSA9IHpvbmUtPmxlbjsKIAkJem9u
ZS0+dHlwZSA9IEJMS19aT05FX1RZUEVfU0VRV1JJVEVfUkVROwogCQl6b25lLT5jb25kID0gQkxL
X1pPTkVfQ09ORF9FTVBUWTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3NkX3piYy5jIGIv
ZHJpdmVycy9zY3NpL3NkX3piYy5jCmluZGV4IDZmN2ViYTY2Njg3ZS4uMTgzYTIwNzIwZGE5IDEw
MDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvc2RfemJjLmMKKysrIGIvZHJpdmVycy9zY3NpL3NkX3pi
Yy5jCkBAIC01OSw2ICs1OSw3IEBAIHN0YXRpYyBpbnQgc2RfemJjX3BhcnNlX3JlcG9ydChzdHJ1
Y3Qgc2NzaV9kaXNrICpzZGtwLCB1OCAqYnVmLAogCQl6b25lLm5vbl9zZXEgPSAxOwogCiAJem9u
ZS5sZW4gPSBsb2dpY2FsX3RvX3NlY3RvcnMoc2RwLCBnZXRfdW5hbGlnbmVkX2JlNjQoJmJ1Zls4
XSkpOworCXpvbmUuY2FwYWNpdHkgPSB6b25lLmxlbjsKIAl6b25lLnN0YXJ0ID0gbG9naWNhbF90
b19zZWN0b3JzKHNkcCwgZ2V0X3VuYWxpZ25lZF9iZTY0KCZidWZbMTZdKSk7CiAJem9uZS53cCA9
IGxvZ2ljYWxfdG9fc2VjdG9ycyhzZHAsIGdldF91bmFsaWduZWRfYmU2NCgmYnVmWzI0XSkpOwog
CWlmICh6b25lLnR5cGUgIT0gWkJDX1pPTkVfVFlQRV9DT05WICYmCmRpZmYgLS1naXQgYS9pbmNs
dWRlL3VhcGkvbGludXgvYmxrem9uZWQuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5o
CmluZGV4IDBjZGVmNjcxMzVmMC4uNDJjMzM2NmNjMjVmIDEwMDY0NAotLS0gYS9pbmNsdWRlL3Vh
cGkvbGludXgvYmxrem9uZWQuaAorKysgYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaApA
QCAtNzMsNiArNzMsMTUgQEAgZW51bSBibGtfem9uZV9jb25kIHsKIAlCTEtfWk9ORV9DT05EX09G
RkxJTkUJPSAweEYsCiB9OwogCisvKioKKyAqIGVudW0gYmxrX3pvbmVfcmVwb3J0X2ZsYWdzIC0g
RmVhdHVyZSBmbGFncyBvZiByZXBvcnRlZCB6b25lIGRlc2NyaXB0b3JzLgorICoKKyAqIEBCTEtf
Wk9ORV9SRVBfQ0FQQUNJVFk6IFpvbmUgZGVzY3JpcHRvciBoYXMgY2FwYWNpdHkgZmllbGQuCisg
Ki8KK2VudW0gYmxrX3pvbmVfcmVwb3J0X2ZsYWdzIHsKKwlCTEtfWk9ORV9SRVBfQ0FQQUNJVFkJ
PSAoMSA8PCAwKSwKK307CisKIC8qKgogICogc3RydWN0IGJsa196b25lIC0gWm9uZSBkZXNjcmlw
dG9yIGZvciBCTEtSRVBPUlRaT05FIGlvY3RsLgogICoKQEAgLTk5LDcgKzEwOCw5IEBAIHN0cnVj
dCBibGtfem9uZSB7CiAJX191OAljb25kOwkJLyogWm9uZSBjb25kaXRpb24gKi8KIAlfX3U4CW5v
bl9zZXE7CS8qIE5vbi1zZXF1ZW50aWFsIHdyaXRlIHJlc291cmNlcyBhY3RpdmUgKi8KIAlfX3U4
CXJlc2V0OwkJLyogUmVzZXQgd3JpdGUgcG9pbnRlciByZWNvbW1lbmRlZCAqLwotCV9fdTgJcmVz
ZXJ2ZWRbMzZdOworCV9fdTgJcmVzdls0XTsKKwlfX3U2NAljYXBhY2l0eTsJLyogWm9uZSBjYXBh
Y2l0eSBpbiBudW1iZXIgb2Ygc2VjdG9ycyAqLworCV9fdTgJcmVzZXJ2ZWRbMjRdOwogfTsKIAog
LyoqCkBAIC0xMTUsNyArMTI2LDcgQEAgc3RydWN0IGJsa196b25lIHsKIHN0cnVjdCBibGtfem9u
ZV9yZXBvcnQgewogCV9fdTY0CQlzZWN0b3I7CiAJX191MzIJCW5yX3pvbmVzOwotCV9fdTgJCXJl
c2VydmVkWzRdOworCV9fdTMyCQlmbGFnczsKIAlzdHJ1Y3QgYmxrX3pvbmUgem9uZXNbMF07CiB9
OwogCi0tIAoyLjI0LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1u
dm1lCg==
