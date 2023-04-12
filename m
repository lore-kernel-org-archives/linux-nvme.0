Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886A3C77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ennUOyOmU7+phnyVvuuQwmDGknVMbYvCwh89SLpzY8s=; b=wIU3VoT75Nab/AZ7WeNLrxHJb6
	QVvoRXOhCN791lv9bd+P5EodO3DAEFFHTKdXZ++qgIUaiWK39mYZ0GlCvODAL3kbGK7wubWLTucuA
	7qbcYsfytX5OdvI82qCeFSGcG1pjjairPup/UVitlB4z3lly0L6JizTEuTu9QhzJwrb2wWJ9La5qz
	YHnQJsSnujTYMbrrGGygMww0v+PozrLHgQMGPXwqOTtPI8lGsoYoIUGMQXV5bQIbJ5ucLZBPqK6JE
	wemj6Vgaz0Pvp6A6S26o8xGAcaWXjeowoFl4dmHZQSl18jUfzyXBBQwnL/zJlZ4G0X9H+9a69d/gF
	NQgMOwuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWKr-002L3n-2h;
	Wed, 12 Apr 2023 09:00:13 +0000
Received: from new3-smtp.messagingengine.com ([66.111.4.229])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmWKo-002L32-3D
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 09:00:12 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id F1028582878;
	Wed, 12 Apr 2023 05:00:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Apr 2023 05:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1681290009; x=1681290609; bh=ennUOyOmU7
	+phnyVvuuQwmDGknVMbYvCwh89SLpzY8s=; b=GP88NCI+zw6qtLqDk39lXA7iqX
	yaut3h7uvhj2DGUJleDZYdhAfeIscGsmJ1+bthdueJyoVbIZaRlSq0T4dpNlrJCi
	wUpbI+eyYp5XJrTMzFd2sSjncVkk/uo/XwxGozGy8zlsARk0M63j2R8fVBcUY4GC
	9gFa3jo4Ijyzyh9Lsv2gXZ4E9uZIhQvDctEIuVZ7bQB/wcRh2obv01PRF+bu8b2D
	tDzp472c70u+V4OcwmH71PWDFPcx0l+p1r/RKeIZa3qBzUuLjH+yQ8MlZ6FkglBK
	NgcB1brwOLeckFVMihTqqhOs+PyI/aR3KE4GxQrCA+x9wzIj2BcAqdR7sSDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=ie1e949a3.fm3; t=1681290009; x=1681290609; bh=enn
	UOyOmU7+phnyVvuuQwmDGknVMbYvCwh89SLpzY8s=; b=fUJtAH9BsC2eQFELltf
	9rM3fKZMene0w7sqC0jqCxxmlQpXRVyw1dVes/Ven/EaWLox1Ssj4iFXbUEr2esP
	4l82gW53EpF8/0QpA8iLwAu9JH3OJcr04VlzNbXvtEsmFpw6JkteRKqz+o22Ybvj
	h3hRuoM3MVWGpYNGPQQ50N4T5S7Chfh6saBRUpV5NkWnLA5/hIi+AU+rIceNvzGm
	Az+oS54QbESpRXwcLQS7MNnzbYArgRkX/+IF8WwiN6IDkcDhXq2jCJY43NqKQTrC
	a0u1p2/zgx2cJJbWPgsi8m3AQTW1d4hMzqvBWFEGBz3nIT2kbUnLsq8M8qw+eou2
	EQw==
X-ME-Sender: <xms:GXM2ZGjusMBVAZ3_HDDdiO6IA8pxHWANiObLWa57bA_eN-XuBF0zdw>
    <xme:GXM2ZHAOXUHTZtRt5M67z2X1Uz_uO8h5ETevQxPk4HsUTME1ZepILjZ-PmRq-BWNh
    lHzxuuJa9XfbXF3ADc>
X-ME-Received: <xmr:GXM2ZOEdONYqKs-AZTYNrWgUjg_4EPGn9F_KO5WEpz2N-6c3iDOAV7oQl6eLbjSvyP-p63kt0DIbKL_CEvL4qz6QpSl7IP7FAdutyFyZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhhihhnkdhi
    tghhihhrohcumfgrfigrshgrkhhiuceoshhhihhnihgthhhirhhosehfrghsthhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgfdukefgfedvfffgfeeuiefgteelgffhffei
    kedvvdekteeiledtteeivefgffevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehshhhinhhi
    tghhihhrohesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GXM2ZPRKDI8E6c_12KZg16AqsmW7QoawPWnWRfT-Ta6B8y2dXgDUdw>
    <xmx:GXM2ZDzmxuDuxYu3t0NOGR3OeBpaWzJMpdJD4bnAJ07AZyj7uxg6UQ>
    <xmx:GXM2ZN6LwC8m6JMMCdiwTir1MnQhB3cDlhLHu-fqtLBbeOrU-GekEg>
    <xmx:GXM2ZD9Pb73VfcmzcyhKsW3Umum_OUEKmfJ13Esxuj1j7NPZk0AbuGCUdUc>
Feedback-ID: ie1e949a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 05:00:07 -0400 (EDT)
From: Shin'ichiro Kawasaki <shinichiro@fastmail.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Alan Adamson <alan.adamson@oracle.com>
Cc: Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/039: avoid failure by error message rate limit
Date: Wed, 12 Apr 2023 17:59:23 +0900
Message-Id: <20230412085923.1616977-1-shinichiro@fastmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_020011_105750_4DC79098 
X-CRM114-Status: GOOD (  10.78  )
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

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

The test case nvme/039 tests that expected error messages are printed
for errors injected to the nvme driver. However, the test case fails by
chance when previous test cases generate many error messages. In this
case, the kernel function pr_err_ratelimited() may suppress the error
messages that the test case expects. Also, it may print messages that
the test case does not expect, such as "blk_print_req_error: xxxx
callbacks suppressed".

To avoid the failure, make two improvements for the test case. Firstly,
wait DEFAULT_RATE_LIMIT seconds at the beginning of the test to ensure
the expected error messages are not suppressed. Secondly, exclude the
unexpected message for the error message check. Introduce a helper
function last_dmesg() for the second improvement.

Fixes: 9accb5f86670 ("tests/nvme: add tests for error logging")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/linux-block/5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv/
---
 tests/nvme/039 | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tests/nvme/039 b/tests/nvme/039
index 11d6d24..f327b54 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -18,6 +18,15 @@ requires() {
 	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
 }
 
+# Get the last dmesg lines as many as specified. Exclude the lines to indicate
+# suppression by rate limit.
+last_dmesg()
+{
+	local nr_lines=$1
+
+	dmesg -t | grep -v "callbacks suppressed" | tail "-$nr_lines"
+}
+
 inject_unrec_read_on_read()
 {
 	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
@@ -29,10 +38,10 @@ inject_unrec_read_on_read()
 	_nvme_disable_err_inject "$1"
 
 	if ${nvme_verbose_errors}; then
-		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
+		last_dmesg 2 | grep "Unrecovered Read Error (" | \
 		    sed 's/nvme.*://g'
 	else
-		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		last_dmesg 2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
 		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
 		    sed 's/nvme.*://g'
 	fi
@@ -49,10 +58,10 @@ inject_invalid_status_on_read()
 	_nvme_disable_err_inject "$1"
 
 	if ${nvme_verbose_errors}; then
-		dmesg -t | tail -2 | grep "Unknown (" | \
+		last_dmesg 2 | grep "Unknown (" | \
 		    sed 's/nvme.*://g'
 	else
-		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
+		last_dmesg 2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
 		    sed 's/I\/O Error/Unknown/g' | \
 		    sed 's/nvme.*://g'
 	fi
@@ -69,10 +78,10 @@ inject_write_fault_on_write()
 	_nvme_disable_err_inject "$1"
 
 	if ${nvme_verbose_errors}; then
-		dmesg -t | tail -2 | grep "Write Fault (" | \
+		last_dmesg 2 | grep "Write Fault (" | \
 		    sed 's/nvme.*://g'
 	else
-		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
+		last_dmesg 2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
 		    sed 's/I\/O Error/Write Fault/g' | \
 		    sed 's/nvme.*://g'
 	fi
@@ -90,10 +99,10 @@ inject_access_denied_on_identify()
 	_nvme_disable_err_inject "$1"
 
 	if ${nvme_verbose_errors}; then
-		dmesg -t | tail -1 | grep "Access Denied (" | \
+		last_dmesg 1 | grep "Access Denied (" | \
 		    sed 's/nvme.*://g'
 	else
-		dmesg -t | tail -1 | grep "Admin Cmd(" | \
+		last_dmesg 1 | grep "Admin Cmd(" | \
 		    sed 's/Admin Cmd/Identify/g' | \
 		    sed 's/I\/O Error/Access Denied/g' | \
 		    sed 's/nvme.*://g'
@@ -139,6 +148,9 @@ test_device() {
 
 	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
 
+	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
+	sleep 5
+
 	inject_unrec_read_on_read "${ns_dev}"
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"
-- 
2.39.2


