Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0D3C07E8E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zh73MWhENqkFmeiQkhQ9YY0yKfrOOghVVtd8657F6zo=; b=vIF7WyJJOmW/35rFNp8w1HlLK7
	6M0govXX/pdG+Bk8ENrTZhY3nFl3lOTJRxXtVCjG+0b/+ed+9NDrMbOPJmJqji5QFjVVsRm6BeEch
	Hiu4dSNGxMwEPFQza5Q6lp6BuIUNrk3CA9BbYN/lXNSBf4DVayOrgQsxDslTLnuDLQfQPOZCgj9L2
	5x0AE1LnDMkia0CiKQmzoWTt81siaUFlYYPdbW7ZIJ/z4kDHJn7tchiYTehn/gefRwKp8cPChrK+s
	P84pR9iZeRL8/m754XvhOSWFWRUZtVsxs9yd3X451SLSRMZqupKxxQvJCuFfDauMTf9SJQ/5dRa6C
	SoKNKmAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXYE-00000003C6y-3DYt;
	Wed, 24 Apr 2024 08:00:22 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXv-00000003Bmj-1PN1
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945603; x=1745481603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yHpLX1JLyja72v9Ay7upFM5xSkaMZAaYoylx1iwvVZI=;
  b=fyevzBlR+qNLIn3ffFwZR6AycGXKkYTZu80HOfeG9iC4ffIHWgUf91/s
   wynXAJ7lDXWUvJFXYjJh15XPjcc4ySS1Bfcp2FFqadeeUpWx/Nd4H04Pu
   +vZjCl3sLnHhAKXUxpCdL2Jfi/cQQFL4SXtB/sS+XoQB1cKVD4PfcvT8V
   FU4OXe1CVFoTSfqPTH5M8KGARmjTA6DCuJUyX66KlIxxZedzW9j3Ef+hP
   MDfEJkp+XNUUFy14QfUJMxgiUvryL3pJ4OI1eL2crYQ1V4wRUuuRFmw14
   hh/JsIubpiBu+vm2rh8VqeUXYJayESXoTMCqe7KPxgS8gLLUDJ/zf8ziG
   Q==;
X-CSE-ConnectionGUID: 4yvYJ4PnRqWBcO/I+lHrlg==
X-CSE-MsgGUID: rAKfzD82Q1yaSg4PwIUkLg==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738263"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:02 +0800
IronPort-SDR: 0VVvnJ4HexGyDfIzcH+OYAKGR0h+iGAqUHm4+Az5M1vzSwILs+IncsK9NfeijAWiTjyM5Q0wP2
 31EuBCde0lqgDdmUOX9zCo3hrfQmnOu+jtqbO8eKnPphR0AyjFdYW5N6GBDshrUwYdqCwbFoS9
 nJO1dv34QEyWKmcr/Z6tSkyEYKWgsgkaVNzMipTi/aA/AJpe9ZAwEOs7dNlB72RfTdPm6+XOMK
 ZTnH+XNILBNhyTiNRmrk0o7MsMeG/lIEeaYQ6goKbTqoOAtuG37KecFJB6GnhTLttTY+jS/pus
 vFM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:12 -0700
IronPort-SDR: YaJvLZZoTODNj7TXjVY2iiIDjM4IZettOgbKTI+aAfCtUcqs2qNw9++Tj9qq5AgC4crPWUb5x3
 /OAn7u11b7sCgVuawFR0Lw/0wupxvCQB+8eks9CUlYNXWqlbYI4yLzyBObTQmqxLm0kgVcCORV
 MAQlSvSw8ufSvp00CRwmd5vGsVWdmL+ObuEpIMa03+vH991SH2lwSpy0LPyK54nt0O5RC67Ypb
 YS4fGl8onh5a2UmAq9UHC55YtiTJlmSnoJgCWgluwfPM/ihNoMMXOkjY7ZEXZgaVX7MxDg9bPX
 MB4=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:01 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 05/15] common/rc: introduce _check_conflict_and_set_default()
Date: Wed, 24 Apr 2024 16:59:45 +0900
Message-ID: <20240424075955.3604997-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010003_545155_64630C99 
X-CRM114-Status: GOOD (  14.31  )
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

Following commits are going to rename some config option parameters from
lowercase letters to uppercase. The old lowercase options will be
deprecated but still be kept usable to not cause confusions. When these
changes are made, it will be required to check that both new and old
parameters are not set at once and ensure they do not have two different
values.

To simplify the code to check the two parameters, introduce the helper
_check_conflict_and_set_default(). If the both two parameters are
set, it errors out. If the old option is set, it propagates the old
option value to the new option. Also, when neither of them is set, it
sets the default value to the new option.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/common/rc b/common/rc
index c3680f5..9ff31cf 100644
--- a/common/rc
+++ b/common/rc
@@ -470,3 +470,30 @@ convert_to_mb()
 		echo "$((res * 1024))"
 	fi
 }
+
+# Check both old and new parameters are not configured. If the old parameter is
+# set, propagate to the new parameter. If neither is set, set the default value
+# to the new parameter.
+_check_conflict_and_set_default()
+{
+	local new_name="$1"
+	local old_name="$2"
+	local default_val="$3"
+	local new_name_checked="$new_name"_checked
+
+	if [[ -n ${!new_name_checked} ]]; then
+		return
+	fi
+
+	if [[ -n ${!old_name} ]]; then
+		if [[ -n ${!new_name} ]]; then
+			echo "Both ${old_name} and ${new_name} are specified"
+			exit 1
+		fi
+		eval "${new_name}=\"${!old_name}\""
+	elif [[ -z ${!new_name} ]]; then
+		eval "${new_name}=\"${default_val}\""
+	fi
+
+	eval "${new_name_checked}=true"
+}
-- 
2.44.0


