Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA35C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 00:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRir9JllalyuLpwnndBtiaoQRm/o21AwXQPAdfUazI4=; b=yPr9KEP70Mmmbs946tBXCl8MkA
	vCg0GNNNcnJphXxM4pynL4wXsbzWl5kyYRWb/ZvffJMUNDR9qXLY0f/utjJHCU/ewGy3MQ+sqjPyr
	+XPwW3yGB54Xl5DjWcvS0Os0sJJbXyBl4spqnjYAj2bGqVqOG0WwJ5AxPSarmpm2sNbaaoZEcd7zO
	xwwWC4dKKf/jaP0UZ82+VjkTTyZovwmMGY/6zuGVvGI0tY1ssvFFHNJhbsQYLAuIsebnC7IRdVYAL
	y9NZdftC9NbluB69tzlU6jjuRdCv/zTHMCeh3GpqOjcVNTBcPHzX+N/zEoml3XQTWodqjjZzb8vd9
	xflRgeDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4i5-00000007sjz-0c7G;
	Mon, 13 Jul 2026 00:39:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wj4i0-00000007sg8-2Txn
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 00:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783903184; x=1815439184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mIo3rXHbmOxTmJNEKH5qOQCJUhuDzPKTHLwlpLqV3KQ=;
  b=ZwiNUOSTodEcwxtcdo458Yf8NGky9m8YBAdd/MhS99PPUfEyTMFTLEXL
   K/J+zOXqQ0rzF0QFqV+JrD8E4Inmvr8cLe+PwDChGFwZ5xi38HpoNevIo
   j7BUJCYXqb7jQR1bKTv4gS7wDaic3JC6WAKLQEqNoCBrdLVJo3zfJWOZw
   oKqYQpJZLxB3PdArQ5DSKQ8N2uYaBK3P3NcakiU5sL5IahnREmdvoIpo0
   FYLuQ9dVDAnyQ9XPDy1jktrgFGXE7Mr3L0IXYjx1q/Qakea9zZfD9O0Es
   Tb4seXEhiEHUiADlLwvxL4l2/kGUXIwJJdZA25z426oXZl00eu2nJxT4a
   g==;
X-CSE-ConnectionGUID: Nc/9Z1MuT4uS+scKaqG0WQ==
X-CSE-MsgGUID: kWMJYQZzSbalI22XfQcpyQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150596184"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2026 08:39:40 +0800
X-CSE-ConnectionGUID: uXDuH1KrQdKbUCYRpCjKMQ==
X-CSE-MsgGUID: bO36u6KyQZKMMlH7Qqy0Wg==
IronPort-SDR: 6a5433b0_2M0cIlwX4/TBtOK38ZJsOHQabcN1J9IUsbvsAqN+gUedJu5
 EyBJVtBWqYKEHovYgDQzAnSU80xcXPEI6x6QYMg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jul 2026 17:39:12 -0700
X-CSE-ConnectionGUID: rqFW510mTOeLajmnUS+GhA==
X-CSE-MsgGUID: wQaYklwbTzGGyOBYyOmS8A==
WDCIronportException: Internal
Received: from unknown (HELO shinmob.iptvf.jp) ([10.224.106.2])
  by uls-op-esai1-o.wdc.com with ESMTP; 12 Jul 2026 17:39:11 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 4/4] new: guide long command options
Date: Mon, 13 Jul 2026 09:39:06 +0900
Message-ID: <20260713003906.21153-5-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_173944_635926_61D6A7D7 
X-CRM114-Status: GOOD (  10.68  )
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

In the past, command option confusion caused a script bug. The command
option definition change and command option misunderstanding were the
cause. To avoid such troubles, guide to use long command options.

Link: https://lore.kernel.org/linux-nvme/Zbu2qJGoz9UQfPw7@kbusch-mbp.dhcp.thefacebook.com/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 new | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/new b/new
index 4773175..58b5006 100755
--- a/new
+++ b/new
@@ -279,6 +279,9 @@ test() {
 # - Use the \$() form of command substitution instead of backticks.
 # - Use bash for loops instead of seq. E.g., for ((i = 0; i < 10; i++)), not
 #   for i in \$(seq 0 9).
+# - Use long command options instead of short options for readability and
+#   stability: e.g., 'nvme io-passthru --opcode X' is recommended over
+#   'nvme io-passthru -o X'.
 #
 # Please run \`make check\` after your test is done to check for shell
 # scripting errors and other mistakes.
-- 
2.55.0


