Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50561C5DF87
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Yyv73///1qpGCJBXJ/uk8/OXLPmuGVDDneCaKQ1QKRU=; b=3dW213heRUZeIqT60SCN8/SfgX
	uRERoN+Ea9Ky7oaDfQs4FHWfNOIPLFG5wN1Ksy5B0tCB9q0B9grps1s2qeEQ+Fcx560l0jLeaa2Jr
	rOcb90RsHRFQEO06b3yvBdNSz8B/R1ko4xUwLnELromEwHV4mwr1l85lzZ1n7jojQt2c4z+o9PFDR
	2VCeOEcTnkecY3Pl0fyxdayxnY6rHuNAPisgupIIF+zz+3f6cosweYpRn2dcW5EoycrA98MVhKeYn
	koVEZR80KM4MMeWyF2wOB9frehGsdONkWi9TaeVmjp3OAsaxa+lB5BiI0k7nT8X9Y5RhbnEKAbhqv
	hhu/aNUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwehC-00000009gmC-0hCZ;
	Wed, 19 Aug 2026 11:43:02 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wweh8-00000009gkX-1aOj
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 11:42:59 +0000
X-UUID: 199793149bc311f19a56ed5b684f684d-20260819
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:ffe35c04-71d1-4b4f-a318-5bee73abca0d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:c079dca72ed37e67654abce35560a85e,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 199793149bc311f19a56ed5b684f684d-20260819
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 721095833; Wed, 19 Aug 2026 19:42:47 +0800
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
Subject: [PATCH 0/2] scsi: fnic: fix NVMe/FC local port setup and teardown
Date: Wed, 19 Aug 2026 19:42:40 +0800
Message-Id: <20260819114242.3598034-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_044258_725958_2DB9C023 
X-CRM114-Status: GOOD (  12.82  )
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

Two small fixes to the NVMe/FC transport path added in commit 5efdd5cf9281
("scsi: fnic: Add the NVMe/FC transport path"), both found by reading the
code rather than by hitting them on hardware.  They apply to
scsi/for-next, since that code is not in mainline yet.

Patch 1 initializes struct nvme_fc_port_info in nvfnic_add_lport().
dev_loss_tmo is currently left uninitialized on the stack.  The transport
does not read it for a local port, so this is hygiene rather than a
behaviour fix, and it carries no Fixes tag; nvfnic_add_tport() right below
already memsets its own copy.

Patch 2 moves the kfree() of iport->nv_tmpl out of nvfnic_nvme_unload()
and into nvfnic_local_port_delete().  The template is what the transport
stores in lport->ops, and nvme_fc_unregister_localport() only calls
->localport_delete() inline when no active remote ports are left;
otherwise the call is deferred to nvme_fc_rport_inactive_on_lport(),
which dereferences lport->ops after the unregister has returned.  Today
the driver frees the template even when the removal wait times out, which
leaves the transport with a dangling ->ops.

Note that patch 2 only narrows that one use-after-free.  The rest of the
timeout path still tears the fnic down while the transport holds
lport->private == iport, so that path may deserve a wider look; I did not
want to fold that into a fix.

Patch 2's reasoning rests on the NVMe/FC transport's lifetime rules, so
linux-nvme and the FC transport maintainers are copied for a second
opinion on that argument.

Compile-tested only (allmodconfig, W=1, drivers/scsi/fnic/ clean).  I do
not have Cisco VIC hardware, so neither patch has been tested on a live
adapter.

Linmao Li (2):
  scsi: fnic: initialize the NVMe local port info before registering
  scsi: fnic: free the NVMe port template from the delete callback

 drivers/scsi/fnic/fnic_nvme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)


base-commit: 30733f28c0347d237ffb5333fdfab7a9a2d4ed34
-- 
2.25.1


