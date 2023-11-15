Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C61C47075
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x+IoghuR5Nn440JJqM6xDr9PK5KYHmIKQdi1TprsnFA=; b=XOsxfUDGLevPBk9CsLMPRMWtkk
	QKmsuQEaosLBqrOmNE3x0a8utPy+e1CSzqEDEPPRqIHUKYwoYYveMQBkVwOIwSKOJKoogwwbNBLh+
	Yuy8ZLFzk8ql9KHxlgVtqt32IjlnuPijYwpThQ9x5UqEE0A/D12t+mwZhMu5m03W8rKriDQVabOot
	43vSTJWIb9TYtKISPihSSIg3xnZQEf1XQCdC3foWfx2Zs1haPwWQ9F+CxtOIp5WATLWG0pA6VlOnq
	FzJYoE6dW0snxWq8oAJkEgrsKpRBQo60ZvFUuNcORmNIU44+qKXqsCLH0kF4OitaeM0vbiplh74+a
	/PRnDpFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r39t9-0005SR-1i;
	Wed, 15 Nov 2023 07:00:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r38pP-00HXrh-0u
	for linux-nvme@bombadil.infradead.org;
	Wed, 15 Nov 2023 05:52:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=x+IoghuR5Nn440JJqM6xDr9PK5KYHmIKQdi1TprsnFA=; b=jw5xBpo7H7RnCARGYRXvoTD/Ws
	60fZDWFtDNf+IAfA4xfT1UtdJhq56tSjPfigKvNtsttbubdHfCk37h0IKAjs3qOIKTnuNEbNaRQC6
	yyYilcA+pIVsR3cTL7f1xwzGKUhA+th2NClYWE4MMEh6H04/ViOwwTvoebDskq5jvEREuHdM+/C32
	I4liUI3Rs/S7lI2HBhnSLWdhhsb6GgF0QwnqL0spWuQGZ2e+xmnGjWZcOGwoBNgPbfewFRoF86TOF
	cyrIKW4Bw8aUpD5X4yqbjoL/pOcrqd3yiHHJtIQaOc7Dble9l5hnJH17pYRekoUfspXzp0uoEXiaX
	M7U4dPng==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r38pK-003kpj-0p
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 05:52:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700027558; x=1731563558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wpolysReVgxyZ9iB8V+ScjF0ki6VPMkTaXYP+O7+C6Y=;
  b=Lf0CqpKu8LLefpq/h6mtvAadxzExD+2Wtn0A+9zbnshu0qLZ4l+rOXFK
   Z68x/iQEi9mCDMZewr+sIsiMByBu5nubo7Y7AyKyY6iXGvFaBHAQ0evEB
   5hDbbFVorPBQZO/VYhGLDGvhYSBen1y31Jw1X/JJezjlE+JzpQ4MRNzch
   FRwoc26zl0aFCCipCujAE7TdTVQo/ksLwBJTXz5J2yJW3r6cPe5PrF7t2
   uGP33umSckOTVRHoybeYxJ5ICgHgpefNY8YqHwUmHx18B1lMWMf+MMPyq
   LWfeaIre/3VEIlQxJvzq8IWkQvUhVsHQfb4HFyGDRZuSpU1e8sB8YnIuj
   Q==;
X-CSE-ConnectionGUID: tUCjAApFRU+MxtNnSO1olw==
X-CSE-MsgGUID: HyOWj9GDT3+oqNn877kl2w==
X-IronPort-AV: E=Sophos;i="6.03,304,1694707200"; 
   d="scan'208";a="2313709"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 13:52:27 +0800
IronPort-SDR: 4QtLr9L7rfXKItyRTeCyrvZj3ocQYuEqueSXiYPCW3jR/HgnGyOucSvnybLKfb+DMhJhUYNfbj
 gUDXply77iXZ6wMQl1alwJN/SAiX6yrqwap5bOrtoL8KBwS3a3TCpwBKWzzo+oK5SDsLgZp+f+
 WXCHYIBaNx4+uZlrLWQ1nCRL7JCLkjBJrdLHGdlmCHiNZVXSzNquQw51IRaB9GlIUoSzl19vG1
 S+f3sABDxoO6roZxLRxorzpbOSY/2JplRzfF4DUAAu4blleRy3dQeFjFh0D/mfrh/3t6phjSJe
 Cz0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2023 20:58:11 -0800
IronPort-SDR: 25t3c2p2Hk15/eaYEXBY+AzbNCnqKHKstAcV+bbXBNDzVGL+6OgTPLteW2H/wrXiNOF+4d/Z3w
 7SzRK3nDUxDB/9QAJNYv16VGtWj1jintSkNpMMZEUf/z4BLBn56b/g5BrJWVNgoZPUhRaecXEg
 tzQrzucnaA+xU2TOOQxT9SWqVeyV78FgLkJrCUQIV6bKrfRakPJ3drefylbMMpwQkeaXTWzsKE
 phSqOBosUqOuSxCetB2033tjg/M22nFHxc+X4F21zzKbVmdW5EaLIzYw8fryrf8O2+DUdDNbvV
 +bY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2023 21:52:23 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel config NVME_HOST_AUTH
Date: Wed, 15 Nov 2023 14:52:20 +0900
Message-ID: <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_055238_852824_84D78558 
X-CRM114-Status: GOOD (  10.32  )
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

The kernel commit d68006348288 ("nvme: rework NVME_AUTH Kconfig
selection") in v6.7-rc1 introduced a new kernel config option
NVME_HOST_AUTH. The nvme test cases from 041 to 045 fail when the option
is disabled. Check the requirement of the test cases.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Link: https://lore.kernel.org/linux-nvme/CAHj4cs_Lprbh1zWsJ2yT6+qhNoqjrGDrBgx+XOYvU9SLpmLTtw@mail.gmail.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/041 | 1 +
 tests/nvme/042 | 1 +
 tests/nvme/043 | 1 +
 tests/nvme/044 | 1 +
 tests/nvme/045 | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tests/nvme/041 b/tests/nvme/041
index d23f10a..a7a5b38 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/042 b/tests/nvme/042
index 9fda681..50d56d6 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 }
diff --git a/tests/nvme/043 b/tests/nvme/043
index c6a0aa0..b5f10bc 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/044 b/tests/nvme/044
index 7bd43f3..06e17d1 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -14,6 +14,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
diff --git a/tests/nvme/045 b/tests/nvme/045
index 1eb1032..126060c 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -15,6 +15,7 @@ requires() {
 	_have_loop
 	_have_kernel_option NVME_AUTH
 	_have_kernel_option NVME_TARGET_AUTH
+	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
 	_require_nvme_trtype_is_fabrics
 	_require_nvme_cli_auth
 	_have_driver dh_generic
-- 
2.41.0


