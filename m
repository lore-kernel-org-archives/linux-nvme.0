Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326D6CD4F3C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 13:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RfxhCV7FuEx6FN3Ph695dMdjOoXCIAnanxO/gTjt8nU=; b=COa3/Qps9ut7Hjm2f+3D63gddZ
	9nm5JfM6ze/ENZIoB+yuo08ttrbZjMTGBcSYo3t0sUp8QzquFSNvraEal//uIkMwo4xc6Ih2Y414Z
	rSe9rZrmzr7JWq1PFYFgja+LcrKsnZI9XKvT1bNhC8rnZPe+eEup3bzCZWZxDO/iITIZI30j7thII
	nBJfZ7ekJiHJCNhxczDMTiCLlHO4dgzOnKTN8CdXgwPJgPEcE6fYrhiaR0D4ew42s1IFScGXOoSDn
	EQ372ZeTX+l5yz9DlFcmwve5WudwM0shLMWhI97k4fussQQGIftPe6vWwV0z/kSY2eHjCoccIwMvv
	Yd6cWuPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPh0O-00000004gPv-21nj;
	Wed, 20 May 2026 13:30:36 +0000
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPh0L-00000004gOP-2e4T
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 13:30:34 +0000
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so52911326d6.2
        for <linux-nvme@lists.infradead.org>; Wed, 20 May 2026 06:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779283831; x=1779888631; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfxhCV7FuEx6FN3Ph695dMdjOoXCIAnanxO/gTjt8nU=;
        b=SkCHndfEL8lD4jKkO5zhTsuyTQX47aW50dkUH2jmx1GzmRjFI6C1wkUkTuWVeQ1P4f
         60u7MfIzWnEJV/Y6JhkdiPp8O5Uwf0vMLE0QbQ3lcnXGG9Ce6OyKh9FY9XRqh3lmpSVV
         qLGyz7uQYprfYiKmiYWyn4o/9SpjoyhwmRNosptMTxqu6O0yxOsVwwpTRQ6zFMkQiFkZ
         N9fegV518QSAMji4fbmv8mC6ZQPH+oEpXCR0F0BabJfo6P/r8oWD4e7wclNnbmdlxyqE
         DE1Z9bIwNuAEy5OKY6XuFivhM4s4sBG+PMDZJhz5Jc4je1J6XqDo8n2q8GwnuAlw//hL
         hAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779283831; x=1779888631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfxhCV7FuEx6FN3Ph695dMdjOoXCIAnanxO/gTjt8nU=;
        b=mb1mh5kkqGhv+kbFJ8zVkFT+n75eurrcAOL2pgJ8zdmxVUS8lvFavJsjJeywluqzkQ
         DE5R/yLr9ojXiHKIvKaoSvOeySIYV/jnc7fgyBTaiqU+xB/+FiFbOLeCXPFaK5v9O3jn
         rH1NLTXKWsQlQOEuYuSgAPBpw783645hyrknRn33GUOHGubfG/ibZKhXnV0YI3hj0P/f
         u+waJ7l5KM6XxLdPdTptHZKvqo5KrdCeBo0YSEI2mzvkxuQVWRBrjPb1Tkn2UT0AYITT
         FnnHZG0hqms0K0jfRBIKs2vsgvnHXT580scy9k5v+iaj9LIjl/7Lkgvgw4OjxAeX9z9n
         lWRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/B7KL+RMZ1qt1AqqmCmp0jJYAKdKUQgupmRVHR/yFZ3cNDMD7j9scQuXffrotGdEYSS/BqtBS8I4B@lists.infradead.org
X-Gm-Message-State: AOJu0YyZzVKQeTGkjNsn9y/QntPIN3GoeQ5nX7LGUCS+D420QPhki4Oc
	/TeiLcpQCCu4qzI6ZE+Kmn7y8KuXtkFxqeVi0684tVlMU10xZlVLSGBR
X-Gm-Gg: Acq92OFiXs4e8J1lyRxg7f59NkQQZ5YjzNvvDKvHGZAf4ZoXn5MMUe/YJZzAxfw0U39
	9XQrCNWZgg9VEHn0EGkua7tU8dTc40tgwYB2yaLbApVmLPmI3dGdpougUhPyiah7vAiaqDbTsYB
	6cR3pyI6H2vO1IMWXNeVqpckH09ic+XDgTqnt4jMABNQMLG9fQ5j98Pf/ME9oH4QKyf1MijHr4K
	hvSljMyToCeS/D5sW7K2uZC52e0Gt2QpaiYUG3FS7tvMKVpY0g26q8EoUkqdd2Wg2SPwAbVt0NZ
	IGQVl4klYb9YZZGhTfaYZ2nuIGpQrov2dQGMz/1r3KeSWpBtCI/z8ZYzPW3XFK47CeIn/sWC0ad
	ukNyNeHgtvXyQO/3MGA/TbzWxaxHq6cjmXXQYSqhIMTCGkMUn9r9NHUP2q9Ey3hNHcqhaP2j4fy
	GrQxpGwMpofZI/ChjONTHQXJqJnIYb5fPFz98QgbgHwBubVQD540hUrEJohlknL9EODRMm0rCCx
	llt9b+5BpXM/juCXujC
X-Received: by 2002:a05:6214:5548:b0:8ac:a546:7753 with SMTP id 6a1803df08f44-8ca0f601c85mr373645396d6.8.1779283831333;
        Wed, 20 May 2026 06:30:31 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36190497sm121635816d6.29.2026.05.20.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:30:30 -0700 (PDT)
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
	David Laight <david.laight.linux@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Wed, 20 May 2026 09:30:15 -0400
Message-ID: <20260520133015.1018937-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519190615.2761667-1-michael.bommarito@gmail.com>
References: <20260519190615.2761667-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_063033_727302_8A8078DD 
X-CRM114-Status: GOOD (  19.94  )
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
Changes in v4:
- Use min() rather than min_t(u32, ...) for the pname_count clamp and
  fold away the temporary max_count variable, as David Laight suggested.

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
index dce95e361daf0..173ed6373f04b 100644
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
+	u32 i;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		pname_count = 0;
+	else
+		pname_count = min(pname_count, (desc_len - fixed_len) /
+				   sizeof(pname_list[0]));
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

