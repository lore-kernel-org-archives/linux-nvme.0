Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBFDC54FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 21:13:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CDF206D9
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 21:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ijslzbFU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="W/Sdednr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CDF206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rl8R1kRrIC/5kRr7e8DmWGtT8tXfIW8vP1CQBqFxia0=; b=ijslzbFUVqjKEY
	kEBQw8uVj6K5o45Uk3nq1QkTmvQASlGwHMKvcfqGuvf0H8NLY5gmOFTH62kmOXgr9MMB2HixzYWiL
	DG89I0Gp24CRuXQYcTgaN7Kb3+JuAyXegdTextNBY/4erdNqkYIo9wkKUt+mD73aeJASYYct6G7vJ
	2FZQcFQgbqQImswKwVArMyXjxUEYdo0yl8IPBBg20CYY9gjfVUkl1DqDgfL39MNo0HAUiQw3nXsDl
	m2/n0nhoWv87JlKY540OxszVrO090XHMATvUBSuHZx+v+QbLXZUfhU2hp+Xk8Swf0fqpvMlCd4wJV
	7EetUZQV6K2XMCQtUAPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jR0CX-00036t-KJ; Tue, 21 Apr 2020 21:13:05 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jR0CV-00036K-Fv
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 21:13:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587503584; x=1619039584;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wIxNVr3yoxQeOPqQAcyWhLtzVpQogyoe8uhKmQwEc70=;
 b=W/SdednrKuzDIwBb05LDmhMJQwf63zHzhWlr2emmpKZEry65XPX7Scd6
 Iye/sQMI4o9PGzzaJgB0B24bD65lHWdcLRudkRH3NqggQDPF80cVoel1d
 yFKCN5szeIOSz/IOBOPV/7NzUS1zxHDzCtEqtRBjmsJP5hHsH+wg4I7je
 OaM5mw2+pi9QwD3NGJqXfnOKAVQAGIGaAs6ZVJiYT3sggeFAb+HLAwcKB
 7gUYrE7pvoGB/r11v6BLtGjlzyDG+uHnbYXrQxzQ3vwOhI1FJoKwUcQtB
 HTzhBV14ATJ+BdUVUKEPO7vCxvpZ2Adh9SKHeTnlgNLEW6YUwdPZRDj3T A==;
IronPort-SDR: 6M108/zcHdqT0/hw3B5vbkojgl0FKi2PKi0IwblcS2M7HUKLwC5omqR0pmP+R2zuuUX+ZO9dlJ
 1DyOr0p+DxX1nnRXKvWivZpJ584JdcMgqDIdiPVFZSYcfrW6irsTxZmzGBD1dNUzPu5s1YPppF
 uKaqhBwO+wz19oQsrc3QcJtoX6+rhhwqhqUefIUtWKRNAW6hT9vAe2wiziAwZM1iqi1dt6+xXP
 1AvplQBL8S7ycOLd8JNr4ovzRgufi9jPNVXfN5UU+rrfHQDDG3st1UnW3WBw7rkq2lo+zImm1y
 +eI=
X-IronPort-AV: E=Sophos;i="5.72,411,1580745600"; d="scan'208";a="136135655"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2020 05:12:58 +0800
IronPort-SDR: M67LZQSIHto3S0bwQXCRNzoFD/B9R87jKFI1GsJCXDe0XPOtzeF8RY2WJK4mg2M93PsmHl7DWa
 5vH+sAp50KgU+a2C1gO+PmluzZYRnj+WI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2020 14:03:15 -0700
IronPort-SDR: WXG0vxqvpHwiYLUM9oeIVp0M7l8VMfp7sQvhzUPhMUyEuRPXT6FQfPAkhua6kQcRSQmp56tO/X
 V+IIQtseUhXw==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 Apr 2020 14:12:58 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH nvme-cli] nvme: allow addr family to recognize loop
Date: Tue, 21 Apr 2020 14:12:54 -0700
Message-Id: <20200421211254.17417-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_141303_568937_7963CDE2 
X-CRM114-Status: UNSURE (   9.87  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This adds ability to decode discovery log page address family
when NVMeOF configured as loop.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fabrics.c    | 1 +
 linux/nvme.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index e2c9bfb..5f8b951 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -136,6 +136,7 @@ static const char * const adrfams[] = {
 	[NVMF_ADDR_FAMILY_IP6]	= "ipv6",
 	[NVMF_ADDR_FAMILY_IB]	= "infiniband",
 	[NVMF_ADDR_FAMILY_FC]	= "fibre-channel",
+	[NVMF_ADDR_FAMILY_LOOP]	= "loop",
 };
 
 static inline const char *adrfam_str(__u8 adrfam)
diff --git a/linux/nvme.h b/linux/nvme.h
index 640b966..f2c4fdb 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -85,6 +85,8 @@ enum {
 	NVMF_ADDR_FAMILY_IP6	= 2,	/* IP6 */
 	NVMF_ADDR_FAMILY_IB	= 3,	/* InfiniBand */
 	NVMF_ADDR_FAMILY_FC	= 4,	/* Fibre Channel */
+	NVMF_ADDR_FAMILY_LOOP	= 254,	/* Reserved for host usage */
+	NVMF_ADDR_FAMILY_MAX,
 };
 
 /* Transport Type codes for Discovery Log Page entry TRTYPE field */
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
