Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A48CCD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 19:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=frUuugDajwbIOykQjzhC84jXkkFKRlA58W38jq3zHQc=; b=UNLVJxvzf5XlF0ivheEbtxBbHo
	9h0fZdoKQhmmNd/zntkMTJ04kkPYQ4v8V6hBrXKt3ylHxTPfv2sUXbJH2UiGudLdQSPyAJz7OJnOL
	ni2U1J4g+H0P2QDXGyQfV6AC4mZmbN+S2iDTl22d6D0I+Jk6Z/PE4TavGT1vzjl79+Tfiqj94ezUy
	nCq7G+9oIRG0TyEYvqh1uA4ZMWP+90KctPtkKJU1NtRQihjbQwnRAGuYn7IRTHWCZbyC8jpNODGfP
	rQVFS/k+FcosDQFaHp88hr6No9W/MPotDWj5oncsF9OhPU7wFJoKC6jdEGDFk1wQ8kLAkN7/1Xn/Q
	F2Cb5jhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPPm4-00000002a6s-0n9o;
	Tue, 19 May 2026 19:06:40 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPPm2-00000002a6K-1D6V
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 19:06:39 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-516389a9b70so45052341cf.3
        for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779217597; x=1779822397; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frUuugDajwbIOykQjzhC84jXkkFKRlA58W38jq3zHQc=;
        b=VShyrWiCjfQwg6Ou7BGdGmLuN0kNmwx99IjFN0k0J++jev6bm3myXEtnOQiQffSHbg
         WpRmN9Fgh/NXUQEZwMkwD/Ye4dQWcAHeP+rDk+Vm075tfVEFALTSaHbgeJ29VMRJx1hc
         NkqFZLgrrIIrACBkUIgKUnjOdwVfIsLtoQugbCC6vqJHUVFEmLLuv+n7lwiB6S2njaB7
         z+hYNVryaQPOKq2ZT22aMeGQRvj49tI/3m7jHmnOeLduFIK+q7w00YNuIpI5KtPtYKCQ
         26yR2S7gkaD5CSExlovF9smGOJCugP6ixOB/Bee5vfXNdtS3FQn5QwpRmP2mnkcTeJxs
         7icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217597; x=1779822397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=frUuugDajwbIOykQjzhC84jXkkFKRlA58W38jq3zHQc=;
        b=CUxcFENUrjlsZrjCjBsr5RlmVs/ZmoepN8urzclBBm+j9PXYwZ5Z7qIqlgpr/QuV0T
         68RugtHOUinNaPBk4xVmoANVU6gN2TrHquZFsSk/qPFzr9RwRAGiSKREdKIUKpFIoR4k
         DYs2EzcEHZYG3K1oXJx+PLTFQlVQ7IeJTgKTLxBXNbqX51uEljquYaUbzCPIWw5WBjZW
         HuQAVk1tvMtEruizmlzOnPnuvjpwKAu+w89x5yYpfa7JAwows+tVwZXRHzXkEpmId+n5
         aZgY8xP7bokKjy8cbtkc3edeV2XOIOQ8VA+E9ZktZVkh8Xuc9cHcyL8OpCYgGJApSHxS
         uJPw==
X-Forwarded-Encrypted: i=1; AFNElJ9czBtZTCf7Fihn92ybhTe79IiIrzbptDjbBvLt5lLPOztBbwRzCoU+4O3c87jyhbpwr87l0Q5vqHCL@lists.infradead.org
X-Gm-Message-State: AOJu0YycHKd4qJLOH890vH6aX9ktKDoa/cb1tppsZjf+B/bAZ78qiHR4
	g1JDJ2NA5raopx4mHgq+xnS3puunBNYPkYMYYHSpsm/Th4rPZmyMlpzP
X-Gm-Gg: Acq92OFfhuUKS0nLkB90NdugL0AjZkd+v2oyVfLR9RsE3/Jf1yTsCt5ZFCeyw/G5L+d
	exlW3fVEfIHUAAUrT2fb2dgTuBLCEC7NB5+NWaKQP0iZaspMwvU4qZt2tyLLWasJrItYZKl8a/V
	heF7tId+TRcv2GMcqXWhc+D412MiR/jcwG92EGkCs4y3GzH7aOtyValE7OyoPEX5Hi7N1P4zz1a
	6EUaYqOiVebCVmTT99io+3qnezbjrvip8S8W45b3QL4e5Yn4HXV590aB/2OIZ58hqLWGN9aDhbT
	+M6u2JHWTOMmnS1XDIozRzNkJdTTLcyGEEWCONWdViN5QDQJ1as77QAjumdz/O7niSPOZ80/d9R
	aK0VousHKPgiegiskH0w7fA+asZ4pb3ghx9/0Jj8FUKkujZWWJ86HOMs3w+65oRJJiuxA62pRzk
	Ifl07051k+XSnbKoRY13U3mTA8u/pFXXQYZ/kgWwgiHK7Uk8Dw6ziHFjo7gqKPiDwDwSZYhA27u
	1hCe1S9sCReiFwAfmNu
X-Received: by 2002:a05:622a:2445:b0:4f1:ab79:fb18 with SMTP id d75a77b69052e-5165a03e931mr269170821cf.25.1779217596596;
        Tue, 19 May 2026 12:06:36 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm187088571cf.31.2026.05.19.12.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:06:36 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nilesh Javali <njavali@marvell.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	Shyam Sundar <ssundar@marvell.com>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Tue, 19 May 2026 15:06:15 -0400
Message-ID: <20260519190615.2761667-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518143706.2808177-1-michael.bommarito@gmail.com>
References: <20260518143706.2808177-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_120638_352910_4C2A824D 
X-CRM114-Status: GOOD (  20.24  )
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

An adjacent Fibre Channel fabric actor that can deliver an FPIN ELS
frame to an lpfc or qla2xxx Linux initiator can trigger a non-return
in the generic FC transport. This is not a local userspace or IP
network path; the attacker must be able to inject fabric traffic, for
example as a compromised switch or fabric controller, or as a same-zone
N_Port on a fabric that permits source spoofing.

The Link-Integrity and Peer-Congestion FPIN walkers used a u8 loop
counter against the 32-bit on-wire pname_count field, and did not bound
pname_count by the descriptor body already validated by the TLV walker.
A pname_count of 256 therefore wraps the counter and keeps the loop
condition true indefinitely.

Factor the shared pname_list[] walk into one helper, widen the counter
to u32, and clamp pname_count against the entries that fit in the
descriptor body before iterating.

Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
Changes in v3:
- State the fabric-adjacent threat model explicitly in the commit
  message and clarify that this is not local userspace or IP-network
  reachable.
- Use min_t(u32, ...) for the pname_count clamp, as Christoph suggested.
- Use FC_TLV_DESC_LENGTH_FROM_SZ() instead of open-coding the descriptor
  body length calculation.
- Factor the duplicate LI and peer-congestion pname walker into a common
  helper while preserving the LI-only host-stat update.

Changes in v2:
- Drop the redundant cover letter shipped with v1.  A single-patch send
  does not need one, and the v1 cover carried stale draft markers.

 drivers/scsi/scsi_transport_fc.c | 77 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index dce95e361daf0..0684d8c69c3c6 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -737,6 +737,37 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 	}
 }
 
+static void
+fc_fpin_pname_stats_update(struct Scsi_Host *shost,
+			   struct fc_rport *attach_rport, u16 event_type,
+			   u32 desc_len, u32 fixed_len, u32 pname_count,
+			   __be64 *pname_list,
+			   void (*stats_update)(u16 event_type,
+						struct fc_fpin_stats *stats))
+{
+	u32 i, max_count;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		max_count = 0;
+	else
+		max_count = (desc_len - fixed_len) / sizeof(pname_list[0]);
+	pname_count = min_t(u32, pname_count, max_count);
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			stats_update(event_type, &rport->fpin_stats);
+		}
+	}
+}
+
 /*
  * fc_fpin_li_stats_update - routine to update Link Integrity
  * event statistics.
@@ -747,13 +778,11 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 static void
 fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
 	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
 	u16 event_type = be16_to_cpu(li_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(li_desc->attached_wwpn));
@@ -764,22 +793,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 		fc_li_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(li_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(li_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(li_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_li_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(li_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*li_desc),
+				   be32_to_cpu(li_desc->pname_count),
+				   li_desc->pname_list, fc_li_stats_update);
 
 	if (fc_host->port_name == be64_to_cpu(li_desc->attached_wwpn))
 		fc_li_stats_update(event_type, &fc_host->fpin_stats);
@@ -827,13 +845,11 @@ static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 				struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_fn_peer_congn_desc *pc_desc =
 	    (struct fc_fn_peer_congn_desc *)tlv;
 	u16 event_type = be16_to_cpu(pc_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(pc_desc->attached_wwpn));
@@ -844,22 +860,11 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 		fc_cn_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(pc_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(pc_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(pc_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_cn_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(pc_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*pc_desc),
+				   be32_to_cpu(pc_desc->pname_count),
+				   pc_desc->pname_list, fc_cn_stats_update);
 }
 
 /*
-- 
2.53.0

