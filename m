Return-Path: <SRS0=c2UW=74=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A4C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608772074D
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jun 2020 23:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nktYLpMC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jRbHzKWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608772074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fLJU0I5L8vtDc2O76Ejntv5BtFYL1/G3PxD1dtCNohQ=; b=nktYLpMCQsY0lF
	cvnny6FoOnJXuJISfMPiKRFJMro2uz840UD7RahyweULE7GmZQaPDdN/3Rzfck0nyjBC5tJhku63K
	3oOuaBA6nlh36I9mZ90F5qcU7AjxTWO3jNTotFiRBT8AXqMhBHjYuniO6BZwTmLGox0Dl0i1bOLFq
	UIEk7mRSzFk/tasvb1DsxO3vF+ZDURqaJSFQdqz2GxoI2jToqDIQtpGmKzOLDOo/9XsCkTBHR88UD
	CzdFRBXx7PJp0FmcEXizFyuA6MqnqfFOqwmKTIJkFVFsJzYOuKbJesApz1sXOkD3wnsIJnLHQiaDj
	bnzWaz2gsbpmVhYt9qNA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jkydK-0004zV-W5; Mon, 15 Jun 2020 23:35:19 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkydH-0004oV-0T
 for linux-nvme@lists.infradead.org; Mon, 15 Jun 2020 23:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592264115; x=1623800115;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/dV0XpG3sEX/aw3d1RyhoLZ6PnRO6yjnnlAlMi46u0Q=;
 b=jRbHzKWiFSgfQMuP9vpPuyZ2r8vGGFvmPk1j74+fuv+QWev/o96G4Neh
 bAmrNhNLKNAEhF4t3+czdU6LIq7jmlJNxHZSAEhxgQRA3h3c+IscdIR6M
 KuQ3Ei7BDpS35y+/5Aot3oCt5gbSgTTryhNPNPpGr6MKmTAkeSQymcx25
 7yUlxP6ke4K3yktUQQYSktN7AI/FTf2MGG317tf3oRA0kBO7el6BZTacM
 U3m/n+rZvuRmYrOnpjZl4+Z9fyLHJepqowylAzf107UdoEvVJNcuXuJfL
 dcBMX29O5r2ooffvZahicHepuRjhSpYerdz8p4fV79YcvstRjoEKy/8j/ A==;
IronPort-SDR: 5ka25leJWNRh5zp4ohulhMAv5WnZULgnq0sWj45HTcXUvila9U8fKLszvXaO/NlD9WdYsa0Dlt
 vg/M96aafVJUDHcfSoYuatSZHVGkvZZhHbFpI7OFuh4pctnDy31bdsPYoP9CzGeJIrX8siDNqc
 nztN1o5YCpJZc5TAZoZOfjJFKYF2kx/CCW5LGuN+QUWuClBnT/G2Wkn8QdgeqxHJKpBeK+yGPa
 KHkyEUuDv+fpBV0OxahNlX1+AJAUBceUwK6hAbVGkLN1mBwYu+L/wMqwsxHJLXxM9JLmtQm/Aa
 IX8=
X-IronPort-AV: E=Sophos;i="5.73,516,1583164800"; d="scan'208";a="144394449"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2020 07:35:15 +0800
IronPort-SDR: BlZvhg9RHuitSnxDOO19lavinn5JgcNWEyTrNXZGyn+bV909UOEhMfRYIvWxhqrc5c4m1rkNmb
 VXPHjEzIaI4ElXnjeFwdoBGh1qLoVNrQE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2020 16:24:31 -0700
IronPort-SDR: rd/GBl9PzcZ6CyCsEG5yJjKOFPM8htXP5G8XouZ6r5RPQsoknm4/xjatsdkESO1XskIhTPYq+7
 UcMUBxWyOTGQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun51.ssa.fujisawa.hgst.com) ([10.149.66.26])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Jun 2020 16:35:13 -0700
From: Keith Busch <keith.busch@wdc.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 0/5] nvme support for zoned namespace command set
Date: Tue, 16 Jun 2020 08:34:19 +0900
Message-Id: <20200615233424.13458-1-keith.busch@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200615_163515_093029_A079600D 
X-CRM114-Status: GOOD (  11.02  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 =?UTF-8?q?Matias=20Bj=C3=B8rling?= <matias.bjorling@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

RnJvbTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPgoKVGhlIE5WTSBFeHByZXNzIHdv
cmtncm91cCBoYXMgcmF0aWZpZWQgdGVjaG5pY2FsIHByb3Bvc2FscyBlbmFibGluZyBuZXcKY29t
bWFuZCBzZXRzLiBUaGUgc3BlY2lmaWNhdGlvbnMgbWF5IGJlIHZpZXdlZCBmcm9tIHRoZSBmb2xs
b3dpbmcgbGluazoKCiAgaHR0cHM6Ly9udm1leHByZXNzLm9yZy93cC1jb250ZW50L3VwbG9hZHMv
TlZNLUV4cHJlc3MtMS40LVJhdGlmaWVkLVRQcy56aXAKClRoaXMgc2VyaWVzIGltcGxlbWVudHMg
c3VwcG9ydCBmb3IgdGhlIFpvbmVkIE5hbWVzcGFjZSAoWk5TKSBDb21tYW5kIFNldApkZWZpbmVk
IGluIFRQNDA1MywgYW5kIHRoZSBOYW1lc3BhY2UgVHlwZXMgYmFzZSBzdXBwb3J0IGl0IGRlcGVu
ZHMgb24KZnJvbSBUUDQwNTYuIAoKVGhlIGJsb2NrIGxheWVyIGlzIHVwZGF0ZWQgdG8gaW5jbHVk
ZSB0aGUgbmV3IHpvbmUgd3JpdGVhYmxlIGNhcGFjaXR5CmZlYXR1cmUgZnJvbSBaTlMsIGFuZCBl
eGlzdGluZyB6b25lIGJsb2NrIGRldmljZSBkcml2ZXJzIGFyZSB1cGRhdGVkIHRvCmluY29ycG9y
YXRlIHRoaXMgZmVhdHVyZS4KCkFyYXZpbmQgUmFtZXNoICgxKToKICBudWxsX2JsazogaW50cm9k
dWNlIHpvbmUgY2FwYWNpdHkgZm9yIHpvbmVkIGRldmljZQoKS2VpdGggQnVzY2ggKDIpOgogIG52
bWU6IHN1cHBvcnQgZm9yIG11bHRpLWNvbW1hbmQgc2V0IGVmZmVjdHMKICBudm1lOiBzdXBwb3J0
IGZvciB6b25lZCBuYW1lc3BhY2VzCgpNYXRpYXMgQmrDuHJsaW5nICgxKToKICBibG9jazogYWRk
IGNhcGFjaXR5IGZpZWxkIHRvIHpvbmUgZGVzY3JpcHRvcnMKCk5pa2xhcyBDYXNzZWwgKDEpOgog
IG52bWU6IGltcGxlbWVudCBJL08gQ29tbWFuZCBTZXRzIENvbW1hbmQgU2V0IHN1cHBvcnQKCiBi
bG9jay9ibGstem9uZWQuYyAgICAgICAgICAgICAgfCAgIDEgKwogZHJpdmVycy9ibG9jay9udWxs
X2Jsay5oICAgICAgIHwgICAyICsKIGRyaXZlcnMvYmxvY2svbnVsbF9ibGtfbWFpbi5jICB8ICAg
OSArLQogZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwgIDE3ICsrLQogZHJpdmVycy9u
dm1lL2hvc3QvTWFrZWZpbGUgICAgIHwgICAxICsKIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyAg
ICAgICB8IDIyMyArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIGRyaXZlcnMvbnZtZS9o
b3N0L2h3bW9uLmMgICAgICB8ICAgMiArLQogZHJpdmVycy9udm1lL2hvc3QvbGlnaHRudm0uYyAg
IHwgICA0ICstCiBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyAgfCAgIDIgKy0KIGRyaXZl
cnMvbnZtZS9ob3N0L252bWUuaCAgICAgICB8ICA1MSArKysrKystCiBkcml2ZXJzL252bWUvaG9z
dC96bnMuYyAgICAgICAgfCAyMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiBk
cml2ZXJzL3Njc2kvc2RfemJjLmMgICAgICAgICAgfCAgIDEgKwogaW5jbHVkZS9saW51eC9udm1l
LmggICAgICAgICAgIHwgMTM0ICsrKysrKysrKysrKysrKysrKy0KIGluY2x1ZGUvdWFwaS9saW51
eC9ibGt6b25lZC5oICB8ICAxNSArKy0KIDE0IGZpbGVzIGNoYW5nZWQsIDY0NyBpbnNlcnRpb25z
KCspLCA1MyBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL252bWUvaG9z
dC96bnMuYwoKLS0gCjIuMjQuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK
