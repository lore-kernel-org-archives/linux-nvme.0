Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50518C5DF86
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3IDevQ0Z6zU8xfNoMOXiOUBHriHQRNef2NcXthxVGaI=; b=cTXXO6g1moMYbNkzL+G47rUGpa
	zL0YVjnU6HmC26KBU3LEvUUcc9ifUt/jtmnp+MI+DVkOR+sipQq8bp9XDWxAEB6XndYUhAsnPSuGG
	aS/PQZqKVo0oAIbemDnGIttf4VqdJB+czcY7eXHgGbkLNUiqxufWsJvzCW9wlMyExFYuyr/ViVJPK
	jXrDfzSk5Jjzl4qEM7YW/A8OnG9DHIA0vl+a5s70sCdDgqnvpWgkSsZeHha19eFhZXVVnnSkEqw6o
	qiNYK0R2wGbr2Xd3RqX+IQp2v19Mt+I14kyv4IuuRVJ1uhNWuvw1K0hnWgxsnVtMks55fQG+iOGJZ
	3xvZFKHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwehD-00000009gmU-1BQ8;
	Wed, 19 Aug 2026 11:43:03 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wweh9-00000009gky-4Axm
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 11:43:01 +0000
X-UUID: 1c0f146e9bc311f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:85c6c030-466d-40ab-94a5-e78f40081adf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:b778686e1c716a07527b9d6df8874b04,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|850|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c0f146e9bc311f19a56ed5b684f684d-20260819
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1648008702; Wed, 19 Aug 2026 19:42:51 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Hannes Reinecke <hare@kernel.org>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH 2/2] scsi: fnic: free the NVMe port template from the delete callback
Date: Wed, 19 Aug 2026 19:42:42 +0800
Message-Id: <20260819114242.3598034-3-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260819114242.3598034-1-lilinmao@kylinos.cn>
References: <20260819114242.3598034-1-lilinmao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_044300_352574_795B081E 
X-CRM114-Status: GOOD (  13.14  )
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

nvfnic_nvme_unload() calls nvme_fc_unregister_localport(), waits for the
transport to call back into nvfnic_local_port_delete(), and then frees
iport->nv_tmpl.  The wait is bounded, and when it expires the driver
only warns and frees the template anyway.

iport->nv_tmpl is the struct nvme_fc_port_template the transport keeps
in lport->ops.  nvme_fc_unregister_localport() only invokes
->localport_delete() when the local port has no active remote ports
left; otherwise the call is deferred to
nvme_fc_rport_inactive_on_lport(), which dereferences lport->ops long
after the unregister call returned.  Freeing the template on the timeout
path therefore leaves the transport with a dangling ->ops.

Tie the lifetime to the callback that marks the end of the transport's
use of the template instead of to the timeout.  nvfnic_local_port_delete()
runs from ->localport_delete(), after which nvme_fc_free_lport() no
longer touches lport->ops, so freeing there is safe in both the direct
and the deferred case.  The free is done before the completion is
signalled, because the unload path may tear the fnic down, and with it
the embedded iport, as soon as it wakes up.

Fixes: 5efdd5cf9281 ("scsi: fnic: Add the NVMe/FC transport path")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/scsi/fnic/fnic_nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/fnic_nvme.c b/drivers/scsi/fnic/fnic_nvme.c
index 00d9d5d439a38..a8b7b7d40b9ab 100644
--- a/drivers/scsi/fnic/fnic_nvme.c
+++ b/drivers/scsi/fnic/fnic_nvme.c
@@ -1243,7 +1243,6 @@ void nvfnic_nvme_unload(struct fnic *fnic)
 				WARN_ON(1);
 			}
 			iport->flags &= ~FNIC_LPORT_NVME_REGISTERED;
-			kfree(iport->nv_tmpl);
 		}
 	}
 
@@ -1669,6 +1668,9 @@ void nvfnic_local_port_delete(struct nvme_fc_local_port *lport)
 	FNIC_NVME_DBG(KERN_INFO, fnic, "lport delete 0x%x\n",
 		      iport->fcid);
 
+	kfree(iport->nv_tmpl);
+	iport->nv_tmpl = NULL;
+
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	if (fnic->nvme_lport_unreg_done)
 		complete(fnic->nvme_lport_unreg_done);
-- 
2.25.1


