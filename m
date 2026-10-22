Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A0606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=abqWLEot;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FZe/pxAZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=bJlNgn1WBW2DrWAS5ZGfcDqNOjcwVQOGGu+jWU8TgLc=; b=abqWLEot/QubbG
	1u0h7aSAW83skEwMjNAJVLpKBTodS97dwhM0Qjjfco7W1wKjQnp+sM+5M69CSJcQnDuIqyLTlsDLm
	c0PdZbKjuGYTCxQZp9m36necwDtDhw/1WQtGXjCguWbbs1i4OIIr8GIGmFf+RWGLjtagMCMJDK6RY
	i4tbuPeSgsmKSjwCmCZsvrd1o2x2lzaAoNzQPr0fyKltG8dggdRwfylMNUr6jk7icVfxOGy1LdD2t
	II6ZlYN0S2EtbUWHLo+EyZ5H+yJqaM14qEwj+5l5FR1cStg/MkUgFqVDX7/0XAXt8C/ZJCQ7G5E89
	wXrogkWPEjgn36l1NcoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsYC-0000000E8px-03Jo;
	Thu, 22 Oct 2026 13:09:44 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJsY9-0000000E8oq-2eCk
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:09:42 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso16749815e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674580; x=1793279380; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJlNgn1WBW2DrWAS5ZGfcDqNOjcwVQOGGu+jWU8TgLc=;
        b=FZe/pxAZ5DXySVHXS5mp6QlEpq69+WNlva7tR1LE4NaYwnG1sXimkX9bDSMJBmSGkX
         SYV+cSrwskl5biIq/GMZEo74UAZPnq+nUBtp8hAUpLrdbsLhOfCerB3W2iyKoh0XDeZY
         i4NUMQ87DyJ9+z/mk6Fh/TMlrC7KWyQR8cQxlZFV0MaDd+l3/2zCSoPF23W2Vv2xhUPv
         2etVNRsp48NsdIChUh39Zo7S7zvQjvx4w/tG0lnP+dfhqJfa7/xnoTx5R/znyqQ2s7Fv
         jibgl6a9/MwlW4wn4OyNbhyOhb2jE3ykNbYBECsWkOcioCh6m7iqNx+Swge6q8nAnDTB
         JxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674580; x=1793279380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJlNgn1WBW2DrWAS5ZGfcDqNOjcwVQOGGu+jWU8TgLc=;
        b=TzVRHldylb4A2WFUE5RRXGJtv6/wShjXhj2OlLX/Va5LmTmtLGVzrtCc8fXlBzIFvK
         9gqnte4Eqzt67O3sSB/qm9Yk9V9GgESyWobg4B4F1n27D3Nz0K1tcDe5z7AOCHVShgzu
         dDuLWXwlQC+mgGywSKD0jQBlK5rt7vga/3wZ7q49SlReoQW31Gy7//BG3Mc2Zp0S5dxr
         a0lYcuj8oEvpHnsS1qmAsngc4Bnyvi7H/Vu045iG4g9z1vaAw6JPolK4TrfIsGANIj+0
         h/wBcI86VXxrkm9iZWE9IIN96PTtZd1BKItgajwRloop/JMGAKaDU8juVUAZrfc0ICP+
         wlCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwiE7hT2wQr6hgIeMTgboyZzxw0nPHJ2coOEKWV5TPxAg1D4m3iyLyu8BLfbP/T8SNBIT3ZVakK/lPZ@lists.infradead.org
X-Gm-Message-State: AFq9FYK06+KxGU8xIVlFPkabqAPTJ92jrQwtUx/kgjZtpBfejqjk9Xkx
	vfnGHrsHQdrTHPvp8ZEOUCxNUNk7f1L1T9cvJhsln2fQAu6u94g6qFXz4Ihs7nJr
X-Gm-Gg: AYBFou3rlwXvV2BXrd0S0AIpM8ySjTweOflIrAtOKFLyezzka0wMo/WEPaK/wTxLxpU
	LJ/qIcenc5ZpTPNISTSwUWP0RXMsR0PLGHvCVDn4QVgFMaPNRRYiI9CvVleO7NRH9WnKksSXUT4
	DgDcPfAR90q0CNF/MjVOE7phyb1N6nbSp+XttT0cFoWN+7wk/0OdI3q9NXsRitbqYqiygPAetFq
	vzBI6mtM44NBeIJBFhqoVU4iCTIUT7c8NAqRqJ0gChdGL+23dyZDX2H8Vjr+Nd8MJJ2qj+KNrwk
	iIVfYBlDZGnOIxvDW9fc8y6Uu9htUhGIOjfbHn7+fUdxNZg6DjLudS0DCySAc4w9ZN4wFYyGl39
	th6oHbITIEp6E6TcchGdeGWpsdcOymis520U0ckSry1Ui1cy9281+5eLbNybCx/8K+QDUrgC8zy
	HYz2fx3ulrTktlowShOQSje+nQrXT4/xn1IzIf+yNTiy4utHbWs8BBvx/NJFG37/KGjbQQ6ZDQz
	hL75McUvv0wDYhzcKUCH1l1CK/JOi4+E4tDItKYVzMnAfzXP+cvzdiG9B8t3yZmLfWRcbFblmJA
	0kIv6EDRy89KgqkDW64c2LnN
X-Received: by 2002:a05:600c:b86:b0:4a1:83f0:7c8a with SMTP id 5b1f17b1804b1-4a1fd8a68b1mr103975625e9.1.1792674579522;
        Thu, 22 Oct 2026 06:09:39 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:38 -0700 (PDT)
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
Subject: [PATCH blktests v2 1/4] nvme/rc: add zoned null_blk target helpers
Date: Thu, 22 Oct 2026 15:09:21 +0200
Message-ID: <20261022130927.3583166-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_060941_697232_4B51140F 
X-CRM114-Status: GOOD (  11.97  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add helpers that export a zoned null_blk device as a namespace of the
default subsystem and connect to it, tear that setup down again, and
issue a partial Zone Management Receive and check its completion status.

The zone report tests added next share them.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/rc | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c415ca1234407..8abd14eeb1129 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -408,6 +408,64 @@ _nvmet_passthru_target_cleanup() {
 	_remove_nvmet_host "${def_hostnqn}"
 }
 
+# Export a zoned null_blk device as a namespace of the default subsystem and
+# connect to it. Callers must source common/null_blk.
+_nvmet_zoned_target_setup() {
+	if ! _configure_null_blk nullb1 blocksize=512 size=1024 zoned=1 \
+	     zone_size=1 power=1 >>"$FULL" 2>&1; then
+		echo "could not configure zoned null_blk device"
+		return 1
+	fi
+
+	_nvmet_target_setup --blkdev none
+	_create_nvmet_ns --blkdev /dev/nullb1 --uuid "$def_subsys_uuid" \
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


