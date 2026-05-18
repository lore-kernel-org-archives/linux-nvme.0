Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644A5CD4F49
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 14:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JcCkhUrBAXbdWT6IfHUQo8JZZr8OMY5xmgFkJbZZrG4=; b=FhJkwqyE1Du0P8ZsP5ySbnQ5/8
	7mFEcAp429gIS4eawi4Ospvn5VoQkDLQzdUWnQgjeYt4ZjnBuOnjOqaHfVrfpI+nUS8sHSNfmIP5V
	a9UuY7CY/QvI65b2CT/wv6aSvzfRd/zlKuIUE+/fubJVn8HthzB5w1umXChojpmuOTmD435/QB7l8
	TzRVXn31bKSDx9eKVFmECSBj7Vfc0LLQfuF4EF/2Djkn/jkCVnNLvljTuFaqz5kP+0nA+IfUqcEpV
	iT596Jm0JhWtx1/TwDgVbyULqvGT/rvD2nkEjpeTzhXfeYF+fbLRNW01WYma3TE3runZ0qj/WGywd
	BV7MIvGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOyfN-0000000FvVU-3D43;
	Mon, 18 May 2026 14:09:57 +0000
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOyfL-0000000FvTO-0UEo
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 14:09:56 +0000
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-50e5c7eb565so29587751cf.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779113394; x=1779718194; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcCkhUrBAXbdWT6IfHUQo8JZZr8OMY5xmgFkJbZZrG4=;
        b=JKPvrZkGtn/Sb+KMfWY9cmvgsx1v6VyJBNtnLOG77nA+gaEmLq1hxi2P42oskxR/t4
         POPaJ9pCAR4LdtnuK7B8SZmAf8QqhqPhMgjCj9AysRZOwHL96NCyNOKsgH301TaYIxwo
         5ulKt0gkjNqIas6bwBaTUSkZaxBPts4L6tq0zv98tdHguyybtkJ75La47tRnfFFTq/JD
         suAE5tX0NKNLLGNKXC+lShNUcwTXaH1AzSztTEyMlwAy/X94wvNSUhmr5Sq1uAVWe47j
         R3nfYO/KwjFiE80M9jbJCMC6FWTPyv4bl5MIMnGp02ZUvk1fmu8/J+wuyq9q21lkJnDa
         /Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779113394; x=1779718194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JcCkhUrBAXbdWT6IfHUQo8JZZr8OMY5xmgFkJbZZrG4=;
        b=JiKYGvLUEs0lLUSHriwumnEqPk4g+Hlp38yluOu2gA+xE3wcI0435ifSWS7yyTNGDl
         PFd1XvLGGWhq0gXCy0uWnYwnGEd/ljl30mgV88jHQKLT/j8h52R3PmzxttIfgM9OP9JW
         6XlM1GJxeDsYPHU7myf9o5SO6KdwNGZ8jHcDkptnfX4oteEbscjMrJfDUfD9v9ATus5M
         jyeL+fjbfu43hSJvX53XawQw8EuFTB/UIMcmdVtVlR+4bvczZ94Dho+sQ60zEUuRiYwx
         3Hi9360pvWv+1+VUeSr25DhO5O0OAPrw5eELv5DisCv9Fsp3TMf229oAWqPeubcCJyOK
         ac0A==
X-Forwarded-Encrypted: i=1; AFNElJ9DhDei32g1WpgWw2A2yTakcm+AGdw6dPp1T8ii0uaGuNFebGWnqbWU6zTxlzArc148CNYfU7s/TwuO@lists.infradead.org
X-Gm-Message-State: AOJu0YwjMjDKQLAknlwSFQVY/0gZ9jryb4T2RahU2PKvecIQb/Omzn4q
	LD62ietikZV+fGs+u6QeF3UdR9bJa7NE0HqOUJzvqt3rVwqozgf3kFtK
X-Gm-Gg: Acq92OG25jb2TRtKYLZfIYlu4JTZjGVMnhfHRa10anc8XDE0Rge34LayflwM6IlGa5i
	AgQIRI7fYGX9I9fckswODNWceLRdMUYtQtIlB/kqfBpApVGGwU3e3Tx21U2fJx84uR7fT96UBRz
	D/uWkXTfaXnFn6FLX71BJwdLX6f5knLIRB9yS5lI3ZZd4bdqsc+bQfRp9/MNifR9gUMumgZRuMy
	KX3CgIWvqCBFZwMrI/mQbKHjniZxOWKThO75yqV+/RH0GlKrSp8FFhq8WaSx8OvG4QvheMkygYI
	hr9sDhiw93yueN4nO1RkTW1FD8o8+TpSM8fXWa6pNLkfYlItcobAq3XmYPH/oQjEsXPjsvZkD2O
	9LAI7q5AyM4mqXvOxVPYhZ8DKK/GgxM1lC/B0oAEKDOA0bvJ97OFqjQnYPLhsQCcrQ5l8MuO5ot
	bCuQPZe/ZlZL8pyljGpFzkwod6/gFOZx8KzmByeGRNt2/9o8gWx9piLCSg1H2MDGJkiT2bLWluR
	GaeP7cuEsWhVFg84dM4TuwGeL3/3LzjwgmXMxVMPxE=
X-Received: by 2002:a05:622a:5e13:b0:50b:487c:f3d1 with SMTP id d75a77b69052e-5165a0703b6mr201830211cf.3.1779113392898;
        Mon, 18 May 2026 07:09:52 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456888f6sm139477401cf.3.2026.05.18.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:09:52 -0700 (PDT)
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
Subject: [PATCH] scsi: scsi_transport_fc: widen FPIN pname walker counter to u32
Date: Mon, 18 May 2026 10:09:45 -0400
Message-ID: <20260518140945.2751273-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518140945.2751273-1-michael.bommarito@gmail.com>
References: <20260518140945.2751273-1-michael.bommarito@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_070955_236656_82CAE769 
X-CRM114-Status: GOOD (  17.41  )
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


