Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25764CD4F49
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Dh1s6OdAS1PfBEWRup+gzc+11JwMqjGvirdDEgh7WY=; b=oUDBJpRd+wsib+DZGdtiDtaJ2Y
	2ISrRqp2tuPQb72Mw+XSQsfFnAmXsHqilCdTIszwDaFbEV5sHC5nNsBz7aDo1OG313vYTfS9s+sbD
	POA/2BZPznsujZlxTMLffDju0m0cgonHS0/ML3WMEZRO1KXqor5ATcZHG2XZ7ajFpAd9jmmPRJD/g
	X+MB5CJlMSZWTiuX8tJXQpcXXnWEmVCQeMnfGgygLBJCk9Do1hIzKV2HUkVq36U5TOimMY+LsJqYG
	SGFAPYEcuZzCH1kD8uvG++EK/9BdBuVWWDaM/7D2i/B0udEZqVTnYlrRDPHKydfmQuA86hhlaM6oA
	7Mi+gNfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOz5o-0000000G0tL-0KWu;
	Mon, 18 May 2026 14:37:16 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOz5k-0000000G0rq-2Oe6
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 14:37:13 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-50e5c7eb565so29895311cf.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779115031; x=1779719831; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Dh1s6OdAS1PfBEWRup+gzc+11JwMqjGvirdDEgh7WY=;
        b=iNVyKlsyn+qg2CHGLcWqQ84GQ2LvnjOnBz+1ND4PJVGpZnqcLnBz1S5SPcPCZLUQLm
         zEmCGnSLy1G+sDmCxrofKzaw3V2TchQlkAuCwKI91l6jQURxU0Ur5FmOgD0Fi1IDH0Jp
         FWJlL6ewQm66layzOaZ6HYFZjnm9wNbfHdilV1L6CrosmUv/tyB24ZuydcGEUZZkJ+Bt
         VzcGdm2hR/0cVigA19TGNLOMbTUy74uZEW3TCLtLapzZxrzrrKk8BdXh+3pgpClYlIYN
         tRbTSHDQpIDVypXpuMCTxtailrLDX89PNNt85yJaDH8H0uaoa3GFFdNQF92zz0ZGvqUy
         dO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779115031; x=1779719831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Dh1s6OdAS1PfBEWRup+gzc+11JwMqjGvirdDEgh7WY=;
        b=rL8nOUm95hR/3clEgy6eBFaQLXzbrvINCTvlkJVCr7690jk+O4OsaUYKXwIv0eNn4P
         hHBfCJMwoPl8rkBwZlpz358wEzKk0svs73xdWb/K87jlwkAAu1aKx3HXOIxz41ZtmSIi
         oSAlIDFJlAhYJx6AP6WpDh42fkqYfmxqjgCbV72W7iY5RjS7AbnRDAVORRzNwXw0UBAa
         oIo9oCnDckfa83H7JB+aJrEwy+Ee0S7LFwoKdWkF7k0gbggFEh3/tD52/xCVtQgi+qxz
         YWmwatcmuMQ9W42H/4bNaR9eChQR+NM/IHalzBdh+zyxYftZ12mM/r9Nfh/u/uH/8F0o
         VzcA==
X-Forwarded-Encrypted: i=1; AFNElJ/6MDcPZ18rxXSdJTawhteDIQ3BMcyvxs6m3ToXXNIcv/43bpwwKyxgoMi2oRJsU1cN72Q5sQ9kV75T@lists.infradead.org
X-Gm-Message-State: AOJu0YxL90CkmMnYrdVsHccNAYMmIIv0rLtstCJZaS3+lcBUepidaaVm
	HH9861TD+FWeBoRnKxRN63j/DzsBnmnzPbiY+MHlzyJRspykvtU3y8/L
X-Gm-Gg: Acq92OFgDLhE5o7WF1CMpbUEdGUjAtA8M+U5zc7Ak8vuzonf8Qh/Y6gbiIidTElovf+
	6koMePBH5lKTBhoDhy4FmyzddYuy3jxkmJzC3+xI8iy1/g0TmJYiyex4yU62FsaWLchU5DGENt2
	7zqxXzP0ua5bLXmL9EcH1qZBu6wfzgwSl7t09Gl7M4MBP9cEa8AohWPl2qjnTgNUyNkbBYJRAJb
	1xbj9LCzujfJZe1fdTgIbeP/koQqF/0A1sHeBr3AFyRgrc79/ujdEOF5nMr5DzdjjsZgYIoCZtr
	gGeFNVfUxPqCZqMKmeTDcT4XukuccmotWAp3BafJxldX0REZBIoJtq5Xk7PQLTVyP3Taz7XBGna
	ucmkHB4QgSn8OxgZoWBDReBWtj1X4QMY7l24o2a24hF+BVGzE9Y13vrzk8z9Xg3hYVnCK3vrkkj
	RBFpe+bmBeUsBoY1QOTqibXi/K+CaHn/8sGl0brhc2gNc2qR2IlW8NM7isfZEH0/L7fqSDRfA1W
	4s8U5mTc+GgyahcEoMHvVEPesymHssHk27+GuXlvsE=
X-Received: by 2002:a05:622a:54a:b0:50b:37a6:e497 with SMTP id d75a77b69052e-5165a2c6a09mr217034241cf.44.1779115031155;
        Mon, 18 May 2026 07:37:11 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm57986926d6.14.2026.05.18.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:37:10 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Mon, 18 May 2026 10:37:06 -0400
Message-ID: <20260518143706.2808177-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518140945.2751273-1-michael.bommarito@gmail.com>
References: <20260518140945.2751273-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_073712_638452_444003AB 
X-CRM114-Status: GOOD (  19.40  )
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

drivers/scsi/scsi_transport_fc.c::fc_fpin_li_stats_update() and
fc_fpin_peer_congn_stats_update() walked the on-wire
pname_list[] with a u8 loop counter against the 32-bit __be32
pname_count field, and never bounded pname_count by the
descriptor body the TLV walker already validated.

A fabric-side FPIN sender (the elected fabric controller, a
co-tenant N_Port that spoofs S_ID 0xFFFFFD after FLOGI, or a
compromised switch supervisor) could hang the FC ELS receive
thread of an lpfc or qla2xxx initiator indefinitely by
emitting one FPIN ELS frame whose Link-Integrity or
Peer-Congestion descriptor sets pname_count to 256, because
the u8 counter rolls over and the loop condition i <
pname_count stays true for every value i can take.

Widen the loop counter to u32 in both walkers and clamp
pname_count against the per-descriptor available bytes
(desc_len minus the fixed body that precedes pname_list[])
before iterating.  A malformed descriptor that claims more
entries than its TLV body can hold is rejected by the clamp.

Fixes: 3dcfe0de5a97 ("scsi: fc: Parse FPIN packets and update statistics")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: drop the redundant cover letter shipped with v1.  A
    single-patch send should not carry a cover; the lead
    belongs in the commit message, which the patch below
    already has.  The v1 cover also carried stale drafting-
    time envelope markers that should have been stripped
    before send.  Apologies for the noise; please ignore the
    v1 cover at
    https://lore.kernel.org/linux-hardening/20260518140945.2751273-1-michael.bommarito@gmail.com/
    The patch hunks below are byte-identical to v1's 0001.

 drivers/scsi/scsi_transport_fc.c | 81 ++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index dce95e361daf0..cef0c85693fd4 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -747,7 +747,7 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 static void
 fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 {
-	u8 i;
+	u32 i, pname_count, max_count, desc_len;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
@@ -764,20 +764,34 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
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
+	/*
+	 * Clamp pname_count to the number of pname_list entries
+	 * the descriptor body can actually hold.  desc_len
+	 * excludes the desc_tag/desc_len header (FC_TLV_DESC_HDR_SZ),
+	 * so the bytes available for pname_list[] are
+	 * desc_len - sizeof(fixed fields before pname_list[]).
+	 */
+	pname_count = be32_to_cpu(li_desc->pname_count);
+	desc_len = be32_to_cpu(li_desc->desc_len);
+	if (desc_len < sizeof(*li_desc) - FC_TLV_DESC_HDR_SZ)
+		max_count = 0;
+	else
+		max_count = (desc_len -
+			     (sizeof(*li_desc) - FC_TLV_DESC_HDR_SZ)) /
+			    sizeof(li_desc->pname_list[0]);
+	if (pname_count > max_count)
+		pname_count = max_count;
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(li_desc->pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			fc_li_stats_update(event_type,
+					   &rport->fpin_stats);
 		}
 	}
 
@@ -827,7 +841,7 @@ static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 				struct fc_tlv_desc *tlv)
 {
-	u8 i;
+	u32 i, pname_count, max_count, desc_len;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_fn_peer_congn_desc *pc_desc =
@@ -844,20 +858,27 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
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
+	pname_count = be32_to_cpu(pc_desc->pname_count);
+	desc_len = be32_to_cpu(pc_desc->desc_len);
+	if (desc_len < sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)
+		max_count = 0;
+	else
+		max_count = (desc_len -
+			     (sizeof(*pc_desc) - FC_TLV_DESC_HDR_SZ)) /
+			    sizeof(pc_desc->pname_list[0]);
+	if (pname_count > max_count)
+		pname_count = max_count;
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(pc_desc->pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			fc_cn_stats_update(event_type,
+					   &rport->fpin_stats);
 		}
 	}
 }
-- 
2.53.0


