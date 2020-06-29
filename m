Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E9C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A6220663
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fdciM6lC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="whB+pnc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A6220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ez+fJ/ByBccZFu/9TVnKteUMH5ufkJxr58wB0Qg/dZI=; b=fdciM6lCPhFWHD7xWqKM1Nbdo
	q55AOjigZcLH2ForJ2DBvPSb4E1PXT9Tl2aCbueq2OCRewhWzqh5y+aSaEhuTJRvEsG7avR7KuCQB
	GFlzB/+qtu0tvR2ccHYwlVYRI1/ZJKNyK81lLWfhfg+duUpOEIJqjpeTMqLdFvR+TJ6MtzYcDM22T
	460PV9aglZ4PR4mdm4k3gs2YzXl7Qhqj9NRjEj2BRWNDJxIoNndy1DezL+EKPhvUXhX9YgOeiFoEK
	xAli598QM26drp9geWoUCyRTO4E0bpgwx9bUYJhtNw5E9+JsUrj8MDT+2U/dY427oiH0YGFTrMPUX
	b03Y4crYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpz7B-0006q5-0Y; Mon, 29 Jun 2020 19:06:49 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpz78-0006pX-I6
 for linux-nvme@lists.infradead.org; Mon, 29 Jun 2020 19:06:47 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3C3B5206A5;
 Mon, 29 Jun 2020 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593457606;
 bh=JUmth+pDiBWP+P3C9nrMBUIQyb4DiHFbp+GhDbhmX3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=whB+pnc82GwjgBknMFrZPWuwbY4aNzrrZt4nTJOnQnH1uKcexJrIMvbAcPS7Jaul9
 UCVsAmktqMbPhABMPSE8sLpW5O4/CmYWiMWclEXOEh5r50Hk7Tqax/wOBOD/ntYbx6
 K3OIb0Qv6+7/6fRePPOX1Cu442oqNbLcXBIDV+9M=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org
Subject: [PATCHv4 1/5] block: add capacity field to zone descriptors
Date: Mon, 29 Jun 2020 12:06:37 -0700
Message-Id: <20200629190641.1986462-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200629190641.1986462-1-kbusch@kernel.org>
References: <20200629190641.1986462-1-kbusch@kernel.org>
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
Cc: axboe@kernel.dk, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Daniel Wagner <dwagner@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Hannes Reinecke <hare@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
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
CnRoZSBjYXBhY2l0eSBmaWVsZCBpcyBhdmFpbGFibGUuCgpSZXZpZXdlZC1ieTogSmVucyBBeGJv
ZSA8YXhib2VAa2VybmVsLmRrPgpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFp
dGFueWEua3Vsa2FybmlAd2RjLmNvbT4KUmV2aWV3ZWQtYnk6IEphdmllciBHb256w6FsZXogPGph
dmllci5nb256QHNhbXN1bmcuY29tPgpSZXZpZXdlZC1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25l
ckBzdXNlLmRlPgpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVt
c2hpcm5Ad2RjLmNvbT4KUmV2aWV3ZWQtYnk6IE1hcnRpbiBLLiBQZXRlcnNlbiA8bWFydGluLnBl
dGVyc2VuQG9yYWNsZS5jb20+ClJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3Vz
ZS5kZT4KU2lnbmVkLW9mZi1ieTogTWF0aWFzIEJqw7hybGluZyA8bWF0aWFzLmJqb3JsaW5nQHdk
Yy5jb20+Ci0tLQogYmxvY2svYmxrLXpvbmVkLmMgICAgICAgICAgICAgIHwgIDEgKwogZHJpdmVy
cy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwgIDIgKysKIGRyaXZlcnMvc2NzaS9zZF96YmMuYyAg
ICAgICAgICB8ICAxICsKIGluY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oICB8IDE1ICsrKysr
KysrKysrKystLQogNCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay16b25lZC5jIGIvYmxvY2svYmxrLXpvbmVkLmMK
aW5kZXggMjM4MzFmYTg3MDFkLi44MTE1MmEyNjAzNTQgMTAwNjQ0Ci0tLSBhL2Jsb2NrL2Jsay16
b25lZC5jCisrKyBiL2Jsb2NrL2Jsay16b25lZC5jCkBAIC0zMTIsNiArMzEyLDcgQEAgaW50IGJs
a2Rldl9yZXBvcnRfem9uZXNfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVf
dCBtb2RlLAogCQlyZXR1cm4gcmV0OwogCiAJcmVwLm5yX3pvbmVzID0gcmV0OworCXJlcC5mbGFn
cyA9IEJMS19aT05FX1JFUF9DQVBBQ0lUWTsKIAlpZiAoY29weV90b191c2VyKGFyZ3AsICZyZXAs
IHNpemVvZihzdHJ1Y3QgYmxrX3pvbmVfcmVwb3J0KSkpCiAJCXJldHVybiAtRUZBVUxUOwogCXJl
dHVybiAwOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIGIvZHJp
dmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jCmluZGV4IGNjNDc2MDZkOGZmZS4uNjI0YWFjMDli
MDA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX3pvbmVkLmMKKysrIGIvZHJp
dmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jCkBAIC00Nyw2ICs0Nyw3IEBAIGludCBudWxsX2lu
aXRfem9uZWRfZGV2KHN0cnVjdCBudWxsYl9kZXZpY2UgKmRldiwgc3RydWN0IHJlcXVlc3RfcXVl
dWUgKnEpCiAKIAkJem9uZS0+c3RhcnQgPSBzZWN0b3I7CiAJCXpvbmUtPmxlbiA9IGRldi0+em9u
ZV9zaXplX3NlY3RzOworCQl6b25lLT5jYXBhY2l0eSA9IHpvbmUtPmxlbjsKIAkJem9uZS0+d3Ag
PSB6b25lLT5zdGFydCArIHpvbmUtPmxlbjsKIAkJem9uZS0+dHlwZSA9IEJMS19aT05FX1RZUEVf
Q09OVkVOVElPTkFMOwogCQl6b25lLT5jb25kID0gQkxLX1pPTkVfQ09ORF9OT1RfV1A7CkBAIC01
OSw2ICs2MCw3IEBAIGludCBudWxsX2luaXRfem9uZWRfZGV2KHN0cnVjdCBudWxsYl9kZXZpY2Ug
KmRldiwgc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCiAKIAkJem9uZS0+c3RhcnQgPSB6b25lLT53
cCA9IHNlY3RvcjsKIAkJem9uZS0+bGVuID0gZGV2LT56b25lX3NpemVfc2VjdHM7CisJCXpvbmUt
PmNhcGFjaXR5ID0gem9uZS0+bGVuOwogCQl6b25lLT50eXBlID0gQkxLX1pPTkVfVFlQRV9TRVFX
UklURV9SRVE7CiAJCXpvbmUtPmNvbmQgPSBCTEtfWk9ORV9DT05EX0VNUFRZOwogCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Njc2kvc2RfemJjLmMgYi9kcml2ZXJzL3Njc2kvc2RfemJjLmMKaW5kZXgg
NmY3ZWJhNjY2ODdlLi4xODNhMjA3MjBkYTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9zZF96
YmMuYworKysgYi9kcml2ZXJzL3Njc2kvc2RfemJjLmMKQEAgLTU5LDYgKzU5LDcgQEAgc3RhdGlj
IGludCBzZF96YmNfcGFyc2VfcmVwb3J0KHN0cnVjdCBzY3NpX2Rpc2sgKnNka3AsIHU4ICpidWYs
CiAJCXpvbmUubm9uX3NlcSA9IDE7CiAKIAl6b25lLmxlbiA9IGxvZ2ljYWxfdG9fc2VjdG9ycyhz
ZHAsIGdldF91bmFsaWduZWRfYmU2NCgmYnVmWzhdKSk7CisJem9uZS5jYXBhY2l0eSA9IHpvbmUu
bGVuOwogCXpvbmUuc3RhcnQgPSBsb2dpY2FsX3RvX3NlY3RvcnMoc2RwLCBnZXRfdW5hbGlnbmVk
X2JlNjQoJmJ1ZlsxNl0pKTsKIAl6b25lLndwID0gbG9naWNhbF90b19zZWN0b3JzKHNkcCwgZ2V0
X3VuYWxpZ25lZF9iZTY0KCZidWZbMjRdKSk7CiAJaWYgKHpvbmUudHlwZSAhPSBaQkNfWk9ORV9U
WVBFX0NPTlYgJiYKZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oIGIv
aW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKaW5kZXggMGNkZWY2NzEzNWYwLi40MmMzMzY2
Y2MyNWYgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCisrKyBiL2lu
Y2x1ZGUvdWFwaS9saW51eC9ibGt6b25lZC5oCkBAIC03Myw2ICs3MywxNSBAQCBlbnVtIGJsa196
b25lX2NvbmQgewogCUJMS19aT05FX0NPTkRfT0ZGTElORQk9IDB4RiwKIH07CiAKKy8qKgorICog
ZW51bSBibGtfem9uZV9yZXBvcnRfZmxhZ3MgLSBGZWF0dXJlIGZsYWdzIG9mIHJlcG9ydGVkIHpv
bmUgZGVzY3JpcHRvcnMuCisgKgorICogQEJMS19aT05FX1JFUF9DQVBBQ0lUWTogWm9uZSBkZXNj
cmlwdG9yIGhhcyBjYXBhY2l0eSBmaWVsZC4KKyAqLworZW51bSBibGtfem9uZV9yZXBvcnRfZmxh
Z3MgeworCUJMS19aT05FX1JFUF9DQVBBQ0lUWQk9ICgxIDw8IDApLAorfTsKKwogLyoqCiAgKiBz
dHJ1Y3QgYmxrX3pvbmUgLSBab25lIGRlc2NyaXB0b3IgZm9yIEJMS1JFUE9SVFpPTkUgaW9jdGwu
CiAgKgpAQCAtOTksNyArMTA4LDkgQEAgc3RydWN0IGJsa196b25lIHsKIAlfX3U4CWNvbmQ7CQkv
KiBab25lIGNvbmRpdGlvbiAqLwogCV9fdTgJbm9uX3NlcTsJLyogTm9uLXNlcXVlbnRpYWwgd3Jp
dGUgcmVzb3VyY2VzIGFjdGl2ZSAqLwogCV9fdTgJcmVzZXQ7CQkvKiBSZXNldCB3cml0ZSBwb2lu
dGVyIHJlY29tbWVuZGVkICovCi0JX191OAlyZXNlcnZlZFszNl07CisJX191OAlyZXN2WzRdOwor
CV9fdTY0CWNhcGFjaXR5OwkvKiBab25lIGNhcGFjaXR5IGluIG51bWJlciBvZiBzZWN0b3JzICov
CisJX191OAlyZXNlcnZlZFsyNF07CiB9OwogCiAvKioKQEAgLTExNSw3ICsxMjYsNyBAQCBzdHJ1
Y3QgYmxrX3pvbmUgewogc3RydWN0IGJsa196b25lX3JlcG9ydCB7CiAJX191NjQJCXNlY3RvcjsK
IAlfX3UzMgkJbnJfem9uZXM7Ci0JX191OAkJcmVzZXJ2ZWRbNF07CisJX191MzIJCWZsYWdzOwog
CXN0cnVjdCBibGtfem9uZSB6b25lc1swXTsKIH07CiAKLS0gCjIuMjQuMQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
