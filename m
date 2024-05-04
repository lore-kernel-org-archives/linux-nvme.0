Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB81C10F1A
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NPDQp9iz52bwVJo3mnNLfwyR2KZgBAw1D8wHd64e5/Q=; b=4bboIJ+325m2QbwjHhm/AmA/Je
	FqL3rrS0CvZehDEqW90lrC/iJEt7FBzZhckwjQVrV6+wCqkVX/BcwzHDCXMpVFUJpBuDE99TPnw0J
	2/zR/WIOHx5Xa88Hnahm6iSlKz80lZZZeoZ390cAtw97DCszpNF+bou8wj8o/tf6IuUHiU4do+RGT
	8P1z8ZyV6gZZJAtuAKnQLwZo81nST8Stqq2j1375NMMHyEmexgjB1gYO1O5hHc6+BRWWSH+G32NYQ
	mWCqaVv/OvVj2u4occsUY6HCeibo58wtJqMpUN9TD2y+5ev8zPGCRM9KqPSfgyUh3BcsW0SSBuV0i
	5PCLV3ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AY1-00000001Yy5-1Uic;
	Sat, 04 May 2024 08:15:09 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXr-00000001Yo8-3JYO
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810499; x=1746346499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G793cZjy30aPyEIQAxowL1pADYTgaWu/BBcCwUB0WJM=;
  b=Dgb4BQ0ADvmP5VEpGUWaRKFgRKWCMCBQakTPKSGznqXdiFnXaLKyYo5j
   e69Xs0yFu0NuXEzujDhkPMLYVSe+U7bAhbGPEZB4XJd775R3HDnJhDB+n
   /l1n3SBvPmhJZ/oCujdIll+MnC4Be3Q8feGNwI8X8TaFDsOAJU1AbV7H0
   tLsevTeqv6/YcfLGTyfWOmIZJG7betV9j4iCtDsB1U2VuwOVsLOeQmKZT
   ojLM1T6wffdbIelm3CYNXiKaPV/hrqlvGxGyCeL8pkPfL6HMC1iNWFOLa
   RxBvhx+s+IMdMDvg7Dh2T6L+NBbBfmB64cag2xwun4NvxgGBmwD9j8q1E
   g==;
X-CSE-ConnectionGUID: XxXf4d7wSamf4i8PHdANgw==
X-CSE-MsgGUID: zi4IcBKrR3OUmz6LPzvzlw==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540311"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:58 +0800
IronPort-SDR: kNMAGcMw0SVrykp5ZCRYbDMKkGJaxTzxCYQJjMLBZ05pHKQFdefKAc3NVdER/0ggEHYKXaXS3u
 q/tY+gFXljuULyxmf9+Eck90xhb97CQSz8tQgMmmtWUuQF9L4wGv2cklQK12IkW/dEG4acu5hs
 eHFnyk5/Mb1nbK+NKACdsGyfSpsRSmXpj4q+M4HLw/3rilujngW+uJju5MfY3uRDieLSKpFFZw
 FsOWdxeU0qzzdEhPo/6XpNaWJMWKPK72bT7av0wBv8M81Qp+DJIGE7HxExMWl081lv2SLYaan4
 /SQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:56 -0700
IronPort-SDR: P7GfbLtTu24m7gpnxSapn/L5po3BYbCYSeE/0Q5th/LckOpYOa66mmwL5kmQpgDyiAKhZ6g1+M
 nxFAOTB5Ei4sWWOYRNuYT4Tf8VfCHgGvdm+cyTypf03jenrARpu7qjLYNn58oZchjeEiO+Ra3+
 BvcvUzE1Di8jWCMfGLh40zSwUmwF/0iDWuvKqmeNgXNxk2pOrxv5Ga3O2v2jw+ieNYObcNW3Ff
 hA8ZFXU8tXVWregtVOPfqafUdbBa8fEJ5m4c9f/17vy7XmGViXC6uQOQqOindnzil9HDdjGo8W
 BnE=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:58 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 07/17] common/rc: introduce _check_conflict_and_set_default()
Date: Sat,  4 May 2024 17:14:38 +0900
Message-ID: <20240504081448.1107562-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011500_187710_8CB7E45B 
X-CRM114-Status: GOOD (  15.56  )
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/common/rc b/common/rc
index fa61cc6..6a9a26c 100644
--- a/common/rc
+++ b/common/rc
@@ -515,3 +515,30 @@ _set_combined_conditions()
 	done
 	COND_DESC="$_cond_desc"
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


