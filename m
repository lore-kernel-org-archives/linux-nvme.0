Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA089C47072
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V74CfvsNuQu26KyD3/uVY1yMokY91kwwBXptpriKlZI=; b=y5T4UNfh5e2I2WLuwXbbMaQX48
	FPQibg0mHL5qwEsg4yU7a1xNU4Bz47nqOsDbrVXvPhZxRzJAm81lSLw4Tj2BnKx3AmG4YlOSAUUak
	KFhJHrjqGvmLMfR9ASox/4Mm0GFjABvwEJPp3uMywsrsooG2UtQpmaM+ZhQdKLLG4nMNPT436RjNR
	91IDSHOgo+sx3xDH1A0Uk+X5xdPYXtMtrI0g4DRNK92yPTjWrKO8e41RFJUfAfGgYoA0O5euN/1vP
	2dRB9ZfYaTNx8ykVADHv8RzwAefa50KFRE4SRSbHggOe/k3a3ztDwTPN2Mj1VamkfGWxVaCNiHpzF
	wHjKAy/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r39t8-0005Rw-0e;
	Wed, 15 Nov 2023 07:00:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r38pM-00HXqq-1x
	for linux-nvme@bombadil.infradead.org;
	Wed, 15 Nov 2023 05:52:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=V74CfvsNuQu26KyD3/uVY1yMokY91kwwBXptpriKlZI=; b=FTJnqZb0R8hEby/A88RAqRkhkk
	Zwe/jI5e5iMfvAj+pzDf2Jj4FxO0uqBEs572PkzQTfhYjxSct15PHejyUV9UuL6/V1+YkFTOBozgn
	8BKVo14fYOg1lw9DfdmMQMom6II6LXTZ9kEfgDPPTWUEGTu2mGKnm6gajOSjhIhv7KYbaxCTxxW0S
	zqrI0nuCZwIwwMxZni/rOPgcWLQpUfRrQ90IyvfulExqjQ0M2IbrVpb/RUxnZ6NN2Xw5IQm3dsnrZ
	zhByOUwooiRf/cVJ1z330l1g2T4CqdDwnfiGt+GqyU60f939KfGKzspA5sqqzRkdCVzJkb16eEHWo
	CRePLnwQ==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r38pG-003kpt-38
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 05:52:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700027557; x=1731563557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4jNWZ5+60jJVVgZkKb721hlGX5UTRssjK9g4ZxZnfEQ=;
  b=p4PYJMpHSn5HgaQYFqrBq4ETh33FqzepKd8U07DayWZ+yV7+CUp/ZjWB
   NnBvVrtOfV2A4DpmP5yqgVpzeQd7hcJFqQHaCAJ3ig5y5ysMDbdXO1b5z
   rt/7tjUOT9zm+BfTBWQRddk78dPtCn950EIzYKiuxRf8mZq/Z6TifyvXe
   znPQj3KFCpzOg8VXTespzYpYctQfb1Q+O9kVXq7MvvCDPMYxYOwnDiJeH
   YTDr8rYHJ9rZKx8n4t5CuJrxJuphZhpT/L6EOTVbH/BDO3FmaVB1xdGIL
   QktUDYO7ApwwWrCGS9lPa+FTqom3Ro6oY+2u8ao2EdK+znF3dulbP101a
   A==;
X-CSE-ConnectionGUID: YAY7xCQgTh61aGeLqsU91A==
X-CSE-MsgGUID: C9Ou2TTxTLKb0ArHpopzgw==
X-IronPort-AV: E=Sophos;i="6.03,304,1694707200"; 
   d="scan'208";a="2313705"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 13:52:22 +0800
IronPort-SDR: IX7+hrYMcV529qQoHFtAgx5elfRZx9mTnkRU+DEd3BGI0W0qZdTZFyzNuoxDMxwWrUtBfYdiTn
 9rcDzKVLNICqqYv9xUTyjbShZqIr6Ip2qVz6186HXlIjePvsBGqJIdmcYTzgLBRbMvOF70ps+t
 DLLD/kKc4z2dGArMuKheb2UVHzIDNBJDJRIkbaHnRjzRw605RRQGpsM+EooMLAD5J4H6c9CAH7
 USSc6KHKowaMMLdwlj7TAPUt3V62S12/8A9TvKiHmwZr+WTQynsTEwaYnVi/6LqtV6IsDXAL3O
 q94=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2023 20:58:09 -0800
IronPort-SDR: Yne2acu87n1pBhflC4zb2qGLmJyAZ3fIBqQX+AvPKHxs2gC7qy7CG8fBy5/JlsTfVlukEUGXza
 2XkuN09TFkQz8uYFN1qkZ9MIf86SIYCVtpPYyyg8k1dimTRQHZ5NkddJwA4aaZwtTHnhHubc/3
 s8Q39vwUlGVrFhynI7TiUNO7WUyvS4bt7PvTvFrGHMbeBNwIORR/k4dff3CQxbwIEy/EPdP82H
 kX5rjDTKSJ8LsCwrAjIyGdYT2hY3WbW+5yssNUg1HsN+LEH0MEsDrKZ8f/hVo+jgK4Me2IGY4P
 1t0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2023 21:52:22 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 1/2] common/rc: introduce _kver_gt_or_eq
Date: Wed, 15 Nov 2023 14:52:19 +0900
Message-ID: <20231115055220.2656965-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_055237_620657_ACF5BD9B 
X-CRM114-Status: GOOD (  12.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To adjust test conditions per kernel version, introduce the new helper
function _kver_gt_or_eq. Also simplify the similar function _have_kver
using _kver_gt_or_eq.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index c3680f5..a3cdfa6 100644
--- a/common/rc
+++ b/common/rc
@@ -206,15 +206,22 @@ _have_kernel_option() {
 
 # Check whether the version of the running kernel is greater than or equal to
 # $1.$2.$3
-_have_kver() {
+_kver_gt_or_eq() {
+	local a b c
 	local d=$1 e=$2 f=$3
 
 	IFS='.' read -r a b c < <(uname -r | sed 's/-.*//;s/[^.0-9]//')
-	if [ $((a * 65536 + b * 256 + c)) -lt $((d * 65536 + e * 256 + f)) ];
-	then
-		SKIP_REASONS+=("Kernel version too old")
-		return 1
+	(((a * 65536 + b * 256 + c) >= (d * 65536 + e * 256 + f)))
+}
+
+# Check whether the version of the running kernel is greater than or equal to
+# $1.$2.$3 and set SKIP_REASONS.
+_have_kver() {
+	if _kver_gt_or_eq "$1" "$2" "$3"; then
+		return 0
 	fi
+	SKIP_REASONS+=("Kernel version too old")
+	return 1
 }
 
 _have_tracefs() {
-- 
2.41.0


