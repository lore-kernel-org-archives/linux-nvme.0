Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9EFC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 09:39:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8988923403
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 09:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dYWGcKE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8988923403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W1fNsRRu8x5gVtz0v1HGGRFY0EknN9wnPzx+hStLmnc=; b=dYWGcKE6GS74I3rdKLAdt5LuU/
	E+X+FpNlm8of2XKNl1eqvH1amPvaLDwrZOL7rXOQFuZgEfULCLxDFlC8BvhmlW2r5o0JPbpMNe8vu
	r4p9mNA9a8mqrfW2aO2nBEIKKZZRclO5IwZMGMqaub5ByldU4bzbKkyrqW0YRhq2KH3sWQFXMIv+D
	8qDvN2UtqIBVMh7QeY96Ytm/NSHwE+CbcuS+MYr1Q4O/Je1l+vFRyRVW8vLuz41xEeA/2C6MH1hyV
	5ZhgP1lwfEzOVJvaUnA/2ft3nEEpNGstOya36Qka/PKl33leSYMcPTvo2aRKt3r35CUsGbffFasQC
	MUwRbdRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpqFs-0000Uy-4t; Mon, 29 Jun 2020 09:39:12 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpqFl-0000SO-Ht
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 09:39:07 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 29 Jun 2020 12:38:53 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 05T9crld008962;
 Mon, 29 Jun 2020 12:38:53 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de
Subject: [PATCH 1/1] nvme: initialize CMB only if supported
Date: Mon, 29 Jun 2020 12:38:53 +0300
Message-Id: <20200629093853.6078-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
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
Cc: israelr@mellanox.com, logang@deltatee.com, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QWNjb3JkaW5nIHRvIHRoZSBOVk1lIHNwZWNpZmljYXRpb24gcmV2aXNpb24gMS40IChDTUJTKToK
IklmIHNldCB0byDigJgx4oCZLCB0aGlzIGJpdCBpbmRpY2F0ZXMgdGhhdCB0aGUgY29udHJvbGxl
ciBzdXBwb3J0cyB0aGUKQ29udHJvbGxlciBNZW1vcnkgQnVmZmVyLCBhbmQgdGhhdCBhZGRyZXNz
ZXMgc3VwcGxpZWQgYnkgdGhlIGhvc3QgYXJlCnBlcm1pdHRlZCB0byByZWZlcmVuY2UgdGhlIENv
bnRyb2xsZXIgTWVtb3J5IEJ1ZmZlciBvbmx5IGlmIHRoZSBob3N0IGhhcwplbmFibGVkIHRoZSBD
b250cm9sbGVyIE1lbW9yeSBCdWZmZXLigJlzIGNvbnRyb2xsZXIgbWVtb3J5IHNwYWNlLiBJZiB0
aGUKY29udHJvbGxlciBzdXBwb3J0cyB0aGUgQ29udHJvbGxlciBNZW1vcnkgQnVmZmVyLCB0aGlz
IGJpdCBzaGFsbCBiZSBzZXQKdG8g4oCYMeKAmS4iCgpBbHNvLCB3aGlsZSB3ZSdyZSBoZXJlLCBh
ZGQgbW9yZSBtYWNybyBkZWZpbml0aW9ucyByZWxhdGVkIHRvIENNQgpyZWdpc3RlcnMgYWRkZWQg
dG8gcmV2aXNpb24gMS40IG9mIHRoZSBzcGVjLgoKU2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95
IDxtYXhnQG1lbGxhbm94LmNvbT4KLS0tCiBkcml2ZXJzL252bWUvaG9zdC9wY2kuYyB8ICA1ICsr
KystCiBpbmNsdWRlL2xpbnV4L252bWUuaCAgICB8IDExICsrKysrKysrKysrCiAyIGZpbGVzIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCmluZGV4IGIxZDE4
ZjAuLjE2OThiNWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jCisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3BjaS5jCkBAIC0xNzYyLDYgKzE3NjIsMTAgQEAgc3RhdGljIHZvaWQg
bnZtZV9tYXBfY21iKHN0cnVjdCBudm1lX2RldiAqZGV2KQogCXN0cnVjdCBwY2lfZGV2ICpwZGV2
ID0gdG9fcGNpX2RldihkZXYtPmRldik7CiAJaW50IGJhcjsKIAorCWlmIChyZWFkbChkZXYtPmJh
ciArIE5WTUVfUkVHX1ZTKSA+PSBOVk1FX1ZTKDEsIDQsIDApICYmCisJICAgICFOVk1FX0NBUF9D
TUJTKGRldi0+Y3RybC5jYXApKQorCQlyZXR1cm47CisKIAlpZiAoZGV2LT5jbWJfc2l6ZSkKIAkJ
cmV0dXJuOwogCkBAIC0yMzY0LDcgKzIzNjgsNiBAQCBzdGF0aWMgaW50IG52bWVfcGNpX2VuYWJs
ZShzdHJ1Y3QgbnZtZV9kZXYgKmRldikKIAkJCSBkZXYtPnFfZGVwdGgpOwogCX0KIAotCiAJbnZt
ZV9tYXBfY21iKGRldik7CiAKIAlwY2lfZW5hYmxlX3BjaWVfZXJyb3JfcmVwb3J0aW5nKHBkZXYp
OwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9udm1lLmggYi9pbmNsdWRlL2xpbnV4L252bWUu
aAppbmRleCA1Y2U1MWFiLi4zYWZkNDkwIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L252bWUu
aAorKysgYi9pbmNsdWRlL2xpbnV4L252bWUuaApAQCAtMTE2LDYgKzExNiwxMCBAQCBlbnVtIHsK
IAlOVk1FX1JFR19CUE1CTAk9IDB4MDA0OCwJLyogQm9vdCBQYXJ0aXRpb24gTWVtb3J5IEJ1ZmZl
cgogCQkJCQkgKiBMb2NhdGlvbgogCQkJCQkgKi8KKwlOVk1FX1JFR19DTUJNU0MJPSAweDAwNTAs
CS8qIENvbnRyb2xsZXIgTWVtb3J5IEJ1ZmZlciBNZW1vcnkKKwkJCQkJICogU3BhY2UgQ29udHJv
bAorCQkJCQkgKi8KKwlOVk1FX1JFR19DTUJTVFMJPSAweDAwNTgsCS8qIENvbnRyb2xsZXIgTWVt
b3J5IEJ1ZmZlciBTdGF0dXMgKi8KIAlOVk1FX1JFR19QTVJDQVAJPSAweDBlMDAsCS8qIFBlcnNp
c3RlbnQgTWVtb3J5IENhcGFiaWxpdGllcyAqLwogCU5WTUVfUkVHX1BNUkNUTAk9IDB4MGUwNCwJ
LyogUGVyc2lzdGVudCBNZW1vcnkgUmVnaW9uIENvbnRyb2wgKi8KIAlOVk1FX1JFR19QTVJTVFMJ
PSAweDBlMDgsCS8qIFBlcnNpc3RlbnQgTWVtb3J5IFJlZ2lvbiBTdGF0dXMgKi8KQEAgLTEzNCw4
ICsxMzgsMTUgQEAgZW51bSB7CiAjZGVmaW5lIE5WTUVfQ0FQX05TU1JDKGNhcCkJKCgoY2FwKSA+
PiAzNikgJiAweDEpCiAjZGVmaW5lIE5WTUVfQ0FQX01QU01JTihjYXApCSgoKGNhcCkgPj4gNDgp
ICYgMHhmKQogI2RlZmluZSBOVk1FX0NBUF9NUFNNQVgoY2FwKQkoKChjYXApID4+IDUyKSAmIDB4
ZikKKyNkZWZpbmUgTlZNRV9DQVBfQ01CUyhjYXApCSgoKGNhcCkgPj4gNTcpICYgMHgxKQogCiAj
ZGVmaW5lIE5WTUVfQ01CX0JJUihjbWJsb2MpCSgoY21ibG9jKSAmIDB4NykKKyNkZWZpbmUgTlZN
RV9DTUJfUU1NUyhjbWJsb2MpCSgoKGNtYmxvYykgPj4gMykgJiAweDEpCisjZGVmaW5lIE5WTUVf
Q01CX1FQRFMoY21ibG9jKQkoKChjbWJsb2MpID4+IDQpICYgMHgxKQorI2RlZmluZSBOVk1FX0NN
Ql9EUE1MUyhjbWJsb2MpCSgoKGNtYmxvYykgPj4gNSkgJiAweDEpCisjZGVmaW5lIE5WTUVfQ01C
X0RQQ0lMUyhjbWJsb2MpCSgoKGNtYmxvYykgPj4gNikgJiAweDEpCisjZGVmaW5lIE5WTUVfQ01C
X0RNTU1TKGNtYmxvYykJKCgoY21ibG9jKSA+PiA3KSAmIDB4MSkKKyNkZWZpbmUgTlZNRV9DTUJf
UURBKGNtYmxvYykJKCgoY21ibG9jKSA+PiA4KSAmIDB4MSkKICNkZWZpbmUgTlZNRV9DTUJfT0ZT
VChjbWJsb2MpCSgoKGNtYmxvYykgPj4gMTIpICYgMHhmZmZmZikKIAogZW51bSB7Ci0tIAoxLjgu
My4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
