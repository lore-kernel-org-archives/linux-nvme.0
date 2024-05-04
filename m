Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6641DC25B5F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 May 2024 08:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5zvQLNkS4OBFYTZbwJzFxssiM7ZLjCnKWn0cV7U6kw=; b=PFy+3jvgVio2ba7YrspC8ZbjVp
	EuNr5Lsc3jZS2Mn8L70cvTII6SlbZ6vI7LrrCU+SUUlaRZriwMKxacDbsmkbpHPvdooZ5bYTL5tfU
	4ztPv+uKW0s0iPIRejArupGQ2VBwgSdqvaJiHlsVtn9E8FyW1Ml4xzU8f4vEgQ4YzwZPjuqA2Zwop
	HVg5ca+BG3f2gQSaLpxPKPz0/fC2R4ZPqvvXhAZcgLqFNiK041tRADzoEYxxSCqAu82n+JXQpvfUA
	RvJ7nr8F4+7CMCmixPrJcQEccmswyzHJV5EdVI1Wrec+ERWC2A8GRLlON/llGZ/f47rx9R4MPQRVs
	Qe82dTOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXx-00000001Yuo-3fsp;
	Sat, 04 May 2024 08:15:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3AXr-00000001YnF-0Aq3
	for linux-nvme@lists.infradead.org;
	Sat, 04 May 2024 08:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810498; x=1746346498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+K+jDy7e3gF1AgCoCIbrLB/6EUv1Sobcxjxoms8/AuA=;
  b=XmL+QdhxiKeWvpAlYEcsCR09wj/CTp5td8YflG5j1+QKWQOetgFDcS2g
   yW4+HUZlWEPk+wSS86oVV8uQ7Ihqli/XuELmU5p7eDurhau6GEitGWEE/
   K7PJFt6o6BLZTLC/NaOQRq8omn2nYcs6Oqe3NwPMqRsLvkBgCUe0sJPoW
   SeR+9yLdx676Z3SaQ427G7yDX/Qw6MC43e1Z9VoLD1n3aAu5dmEwkrFIj
   5mNTJ8K1pbuh1tlk2i0YVVvOOC1ceSpMBjA5Wy0a8w4AMPt53V2RvGUGM
   JrMaNIPVuatCZeawSi67Z7pJyzbnHYkFQt71Pf0eLmayIif3GWGbI3TcQ
   w==;
X-CSE-ConnectionGUID: ZG3Esc6PRCSHhdKcGYlVkw==
X-CSE-MsgGUID: 5XNmtfUcQgeIKaDqwqCdkg==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540307"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:14:56 +0800
IronPort-SDR: vpzt95xjDoBQSIyyAwdBcHrYPYkVUBoRkYPPtpsupS3Ifzg3LGvu3BqjG1tEVM/QO079L9JLeT
 NGW9q/80cf9o5Rycsa5YlVJQhxGewXmBxNcWKxTxSglqZLREzAR31z4XC/rdNYg+x0+E2wbvI2
 6W1j9IfXWVZqqfTuFaNYs/AHd7Ojai9KD7nOc936LjzrIdMOGPCjsD6ypIobJji5fa1VZ5jFOB
 NDC22XW4Rkb/aXagLKCbPUlZKCfBNfpicPbefvDC4Nt6TS3eyEuxH4Z1m0JL+2NXqxTeegMCK+
 flA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:22:54 -0700
IronPort-SDR: kFkhNGbrLKQFZuFDITcNasFNoVHPWDonHevw2gVnSHOpEl4rxwW2c8WZMnAP/cZRsW6ik3SEIG
 a5E0zCEoxWCmLjRZD/e24ofIWt6ZCkoPxTmJubX3yQuHEm7tRJtVSviGLekURPg6bmOQptUrYv
 jNC8ghZZdePVBGpdp8pksXjFUm/ozUBNa6OsQs/T/OnAgCVo3Zph9qQZ2l2olDh/EGxy1zIDeq
 Dny6HOzR/byvJA6j6xjWckXXT3KbNkSZiZcQOHFfpCI/fO7sVzE8vgqXz+f6tnr88n2bPCJgkZ
 Bmc=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:14:55 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 05/17] common/rc: introduce _set_combined_conditions
Date: Sat,  4 May 2024 17:14:36 +0900
Message-ID: <20240504081448.1107562-6-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240504_011459_197684_81C2E60B 
X-CRM114-Status: GOOD (  14.83  )
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

When the test case has the "set_conditions" hook, blktests repeats the
test case multiple times. This allows repeating the test changing one
condition parameter. However, it is often desired to run the test for
multiple condition parameters. For example, some test cases in the nvme
test group are required to run for different "transport types" as well
as different "backend block device types". In this case, it is required
to iterate over all combinations of the two condition parameters
"transport types" and "backend block device types".

To cover such iteration for the multiple condition parameters, introduce
the helper function _set_combined_conditions. It takes multiple
_set_conditions hooks as its arguments, combines them and works as the
set_conditions() hook. When the hook x iterates x1 and x2, and the other
hook y iterates y1 and y2, the function iterates (x1, y1), (x2, y1),
(x1, y2) and (x2, y2). In other words, it iterates over the Cartesian
product of the given condition sets.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/common/rc b/common/rc
index c3680f5..fa61cc6 100644
--- a/common/rc
+++ b/common/rc
@@ -470,3 +470,48 @@ convert_to_mb()
 		echo "$((res * 1024))"
 	fi
 }
+
+# Combine multiple _set_conditions() hooks to iterate all combinations of them.
+# When one hook x has conditions x1 and x2, and the other hook y has y1 and y2,
+# iterate (x1, y1), (x2, y1), (x1, y2) and (x2, y2). In other words, it iterates
+# the Cartesian product of the given condiition sets.
+_set_combined_conditions()
+{
+	local -i index
+	local -a hooks
+	local -a nr_conds
+	local total_nr_conds=1
+	local i nr_cond _cond_desc
+	local -a last_arg
+
+	last_arg=("${@: -1}")
+	if [[ ${last_arg[*]} =~ ^[0-9]+$ ]]; then
+		index=$((${last_arg[*]}))
+	fi
+	read -r -a hooks <<< "${@/$index}"
+
+	nr_hooks=${#hooks[@]}
+
+	# Check how many conditions each hook has. Multiply them all to get
+	# the total number of the combined conditions.
+	for ((i = 0; i < nr_hooks; i++)); do
+		nr_cond=$(eval "${hooks[i]}")
+		nr_conds+=("$nr_cond")
+		total_nr_conds=$((total_nr_conds * nr_cond))
+	done
+
+	if [[ -z $index ]]; then
+		echo $((total_nr_conds))
+		return
+	fi
+
+	# Calculate the index of the each hook and call them. Concatenate the
+	# COND_DESC of the all hooks return.
+	for ((i = 0; i < nr_hooks; i++)); do
+		eval "${hooks[i]}" $((index % nr_conds[i]))
+		index=$((index / nr_conds[i]))
+		[[ -n $_cond_desc ]] && _cond_desc="${_cond_desc} "
+		_cond_desc="${_cond_desc}${COND_DESC}"
+	done
+	COND_DESC="$_cond_desc"
+}
-- 
2.44.0


