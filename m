Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31314CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 17:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cLpXe4/u91k9DHDDYoXmFNxRFAC/Zm9beCfIpbWNzcY=; b=D0czzEPTlGUdtLfdRSkMWHHjAm
	0I7wA2SA7xzvaIeJsaqZoS+ZaR23FuipSk2lP1OiVH9chgGOT3L4llcXLHBo0G+CVB/cHaMwBogVm
	G0hBJrPMbcKCIOb9D54LtI4CEWwBMuc3cjynyFP0snyNHXxSMigJqgmWW/d57v5415Ay+lswMIHfy
	lVC0X9E4zDDhltZQvIQF71E0/GXf1tMTcRb2fbd9Mb+zie92bcD9aSy9pw1VqaFaQVtAzcjhN1BYB
	GN8mysx43S3z54czTH0lmY0/rNtbsjnAQMQarn53CgNdW47X8KYdMbUNLwJN/ZmMV07QogQltYHEG
	ZALxXuNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Ld-0000000G38r-3gNR;
	Wed, 14 Oct 2026 17:01:01 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2La-0000000G37i-3XVc
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 17:01:00 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso32050545e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 10:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997257; x=1792602057; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cLpXe4/u91k9DHDDYoXmFNxRFAC/Zm9beCfIpbWNzcY=;
        b=B6iOrV1gw4NkhYv1be6139qGK5aEYM3KTjBmoyosAqLNByJ0fJAxUv7lO39WWgjgc0
         xpOT+K7ZCwENfAG3VhhsZgvCKMXyDbjY3DeKSHXaAILWlVpu13Zrj8U3AqoWzgeuqLhD
         /eC37mhviUoH+9kOpc/dSL+ByAPLKUvSjmRQCGF9aFcDSa6eDUi3vqTxdAPZ2leDdtz+
         ac0IhOhVTpy7coBrodNcLJMMJXBwh73SwQXzgZ9EFKutf8Egz43jAF3tN1YGyVuu+wSK
         Lswa2BaIbVS6oi98gYZXFaNcoAzsGSeICm4FCFlnjmDauXbhdXkfrAFHctvyomR8dIF/
         aBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997257; x=1792602057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cLpXe4/u91k9DHDDYoXmFNxRFAC/Zm9beCfIpbWNzcY=;
        b=z+haWqnDfecHld+9ncSpnPybP8nUjoXgPFhINQ2MOOuoS2JSiqDPbRQ/d7IR4knYSu
         ZESUzUrQPy2UnPL5kBCs3hz3tBep9bm+/aNUPazzb3haVKmK+99qPvMvKPk3To1Qjmj7
         MH62NxixH1OiVbAVaeywWdC2o+tRwRvkkT0CMAM/chA1cG7DtwYwk9NTxxa/hthVU2nc
         9ePcrn2+/wCe+huP2rIgrnjbehPhIk/lcwiPzwfEfLUC221MvMWY22zCn9FuY3KNvINj
         QJpy//F9bn3eO5PZmDjfEwW5rutu1exej4IpMrA72gNfzSBjkXV6x8e3zsTFrjbzX9nG
         YRWQ==
X-Forwarded-Encrypted: i=1; AKwUvByQdXlQIWOwdtpGIBJTmQLBVwNo4WmwUMFOKv8j3a48ox+VJxwyvZ/JVrqpmiY8bTveuArDQW/6olTi@lists.infradead.org
X-Gm-Message-State: AFq9FYKk2XyD+Mw3wQCukhvr6z9HT+qjV0lalI/EsSni2xMhCPsmxUKe
	vgD5WJTcjyVeANykWIP7zj9BBFNRltDLfT+S4w63kIOq9QiMtptb0I9d
X-Gm-Gg: AYBFou38QBXubJKmvtlAomFVr+E2cuk5BSeODa7o6LYl+6386XJAQmv7mWPyC6CPItc
	Vk0k6yP8RSqeGdogQ493gFDfxHugYjQRn9Xq57qSUy1B0twue04RvSExLtgCBS0xVAI5Mm83aAS
	wOTHNYvUEEOemrMQIScEGzqhgU8fM5RCd1rWbhyvl0rduTq10gNxBGaltps3oiSaAGUT0RXOJj5
	fhCW19bF5jTDus7HP7PBG8ebU3EC9Moe1ZxUneSHc4PzLbTkUlStETCrd07CbBU/zCBVVKjR7mY
	n1eZwr4I2/LqI/5neyShNx+XFsSBBIdVu4FGFrKXiZSeQCvUlEuVmWUn7qaUTJLuWf9LZAXEtEX
	cZR8hKTsTIjvPIzkHXkMQKLip54lrRyiMSvs8Jc9NPIZYeZvbytZBHcNHWJhh+Fa8Js38h3zGK3
	67bN0Pq0AP40I99oQdeQ3KekEc3EW3rsmk6gW6af+qN43wcYaWNdp4Ul+EkYFevzz7mU00Q0t4b
	I5S1KkO45xCbK+UKwWdC4yCG4JHlK7fzNFE6Oj0xdS94g==
X-Received: by 2002:a05:600c:190b:b0:4a1:82cc:1e9a with SMTP id 5b1f17b1804b1-4a18e4b2b25mr330216135e9.17.1791997256518;
        Wed, 14 Oct 2026 10:00:56 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:00:56 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests 1/4] nvme/rc: add zoned null_blk target helpers
Date: Wed, 14 Oct 2026 19:00:38 +0200
Message-ID: <20261014170046.2516-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014170046.2516-1-parri.andrea@gmail.com>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_100059_627481_B89EA115 
X-CRM114-Status: GOOD (  12.02  )
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

Add helpers that export a zoned null_blk device as a namespace of the
default subsystem and connect to it, tear that setup down again, and
issue a partial Zone Management Receive and check its completion status.

The zone report tests added next share them.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/rc | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c415ca1234407..270fad19d61f1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -408,6 +408,67 @@ _nvmet_passthru_target_cleanup() {
 	_remove_nvmet_host "${def_hostnqn}"
 }
 
+# Export a zoned null_blk device as a namespace of the default subsystem and
+# connect to it. Callers must source common/null_blk.
+_nvmet_zoned_target_setup() {
+	if ! _init_null_blk nr_devices=0; then
+		return 1
+	fi
+	if ! _configure_null_blk nullb0 blocksize=512 size=1024 zoned=1 \
+	     zone_size=1 power=1 >>"$FULL" 2>&1; then
+		echo "could not configure zoned null_blk device"
+		return 1
+	fi
+
+	_nvmet_target_setup --blkdev none
+	_create_nvmet_ns --blkdev /dev/nullb0 --uuid "$def_subsys_uuid" \
+		>/dev/null
+	_nvme_connect_subsys
+}
+
+_nvmet_zoned_target_cleanup() {
+	_nvme_disconnect_subsys
+	_nvmet_target_cleanup
+	_exit_null_blk
+}
+
+# Test cleanup handler to register with _nvmet_zoned_target_setup().
+_cleanup_nvmet_zoned_target() {
+	_cleanup_nvmet
+	_exit_null_blk
+}
+
+# Issue a partial zone report from zone 0 of namespace device $1 with a
+# $2-byte data buffer and NUMD $3, and check that it completes with status
+# code $4, or succeeds if $4 is 0.
+_check_zone_report() {
+	local dev=$1 data_len=$2 numd=$3 expected=$4 desc err rc status
+
+	desc="zone report with $data_len bytes and NUMD $numd"
+	err=$(nvme io-passthru "$dev" --namespace-id=1 --opcode=0x7a --read \
+		--data-len="$data_len" --cdw10=0 --cdw11=0 --cdw12="$numd" \
+		--cdw13=0x10000 2>&1 >/dev/null)
+	rc=$?
+	status=$(sed -n \
+		's/^NVMe status:.*(\(0x[[:xdigit:]][[:xdigit:]]*\)).*/\1/p' \
+		<<<"$err")
+	printf '%s: exit=%d status=%s\n' "$desc" "$rc" "${status:-none}" \
+		>>"$FULL"
+
+	if ((expected == 0)); then
+		if ((rc != 0)); then
+			echo "$desc failed"
+		fi
+	elif ((rc == 0)); then
+		echo "$desc was not rejected"
+	elif [[ -z "$status" ]]; then
+		echo "$desc returned no NVMe status"
+	elif (((status & 0x7ff) != expected)); then
+		printf '%s returned status %s, expected %#x\n' "$desc" \
+			"$status" "$expected"
+	fi
+}
+
 _discovery_genctr() {
 	local port=${1}
 
-- 
2.53.0


