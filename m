Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22378CA5FC4
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 07:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IuoVDFisGJtBiR6B4hUqoFcY2KUNUjB6ufO+jyeqPv8=; b=zIvc1MCJJNz+awKFvAmRwRGgB+
	EdLmf5VVyG4Z92oCEXtPjKLbDF9xCGkMA0iIF9Bf1dZtnkRmNI335SbM4KFrSDjNAwzV9r7+7oMnw
	fx/xydKQIhoMR1xC6AsSakaQ38ptV9gM7vGQn3RxEI34ZrJUhR/9B8zlnyNuRzifQ9WB3akjbxsgZ
	UgAlQjZkuTjZG9NmKU+zv9tKuOh3YIZaJu14IAUAjdDMYe5Mtt4J/AC3sNS+6hliv42caLB+J5l06
	eTQ6aK2hw+KxI9BN658YFlfjprM4rcrno4Vz+9AriaCGMzYQ+545JTfnCMhDCl5VxOXJtV6I7wf9e
	DTn8FiCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCXHU-0000000AlMk-3IXO;
	Fri, 02 Oct 2026 07:02:08 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCXHR-0000000AlMI-22ut
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 07:02:07 +0000
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261002070201epoutp03d6aed1252f644a62677eb76a1bf47ba2~apF0DCQx60265402654epoutp031
	for <linux-nvme@lists.infradead.org>; Fri,  2 Oct 2026 07:02:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261002070201epoutp03d6aed1252f644a62677eb76a1bf47ba2~apF0DCQx60265402654epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790924521;
	bh=IuoVDFisGJtBiR6B4hUqoFcY2KUNUjB6ufO+jyeqPv8=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=HfVWCHS6yuYXfydKbOshIMCeJDd+mJWcs20yF6EhmxFmwjG+G5gPb29eAqoo2oij0
	 kGTWMvjgRgOMgo7LbkSjOp6rO3k4bveSTCqYM8FPgiYIqF/lE/HTPxMeJ/39W7cSuT
	 p28TQy4Qf/1jZ71q6VAz2h7HtH62/RwljdoMzaKU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPS id
	20261002070200epcas2p13075a036b31125d4054157e3f0cf9bc3~apFzs9jrw2252422524epcas2p1q;
	Fri,  2 Oct 2026 07:02:00 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.209]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hx0883DzQz6B9m6; Fri,  2 Oct
	2026 07:02:00 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 1/2] nvmet: fix use-after-free of the old registrant in
 nvmet_pr_preempt()
From: Daejun Park <daejun7.park@samsung.com>
To: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "kanie@linux.alibaba.com"
	<kanie@linux.alibaba.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261002070200epcms2p593a0aa8ac482e776e8f1de89d9f212ae@epcms2p5>
Date: Fri, 02 Oct 2026 16:02:00 +0900
X-CMS-MailID: 20261002070200epcms2p593a0aa8ac482e776e8f1de89d9f212ae
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465
References: <20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1>
	<CGME20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_000205_865398_B3BD66C1 
X-CRM114-Status: GOOD (  22.09  )
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
Reply-To: daejun7.park@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_pr_preempt() handles a preempt sent by the reservation holder by
changing the reservation type with nvmet_pr_update_reg_attr(), unless
the reservation is of an All Registrants type.  For the holder that
helper does not modify the registrant in place: it puts a copy on the
registrant list, points pr->holder to the copy and passes the old
registrant to kfree_rcu().

If the reservation type changed, nvmet_pr_preempt() then hands
&reg->hostid of that old registrant to nvmet_pr_resv_released().  Unless
the reservation released notification is masked, that function takes
subsys->lock and compares the host id against every controller of the
subsystem.  The caller only holds pr->pr_sem and is not in an RCU
read-side critical section, so nothing keeps the old registrant alive
while it is read.

The result is a read of 16 freed bytes that decides which controllers
get the notification.  Found by code inspection.  kfree_rcu() defers
the free, so it usually happens after the read; when the pending free
is forced to run before the read, KASAN reports the host id as freed
memory.

Pass the host id of the controller that sent the command instead.  The
registrant was looked up by that host id, and the controller outlives
the request.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Cc: stable@vger.kernel.org
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---

Notes:
    The KASAN report came from this change on top of the base commit, which
    forces the pending free and then checks the pointer that is handed to
    nvmet_pr_resv_released():
    
     		status = nvmet_pr_update_reg_attr(pr, holder,
     				nvmet_pr_update_holder_rtype, &rtype);
    +		kvfree_rcu_barrier();
    +		kasan_check_read(&reg->hostid, sizeof(reg->hostid));
     		if (!status && original_rtype != rtype)
     			nvmet_pr_resv_released(pr, &reg->hostid);
    
    A holder that preempts itself with another reservation type then gives:
    
      BUG: KASAN: slab-use-after-free in nvmet_pr_preempt.isra.0+0x462/0xa50
      Read of size 16 at addr ff110001113bb088 by task kworker/u32:0/12
      ...
      Allocated by task 12:
       ...
       nvmet_execute_pr_register+0x1f4/0x1130
      ...
      Freed by task 864:
       ...
       __rcu_free_sheaf_prepare+0x61/0x230
       rcu_free_sheaf_nobarn+0x1d/0x50
       rcu_core+0x691/0x1e20
    
    The free in this report is the one forced by the added barrier.  The
    same two lines with &ctrl->hostid on top of this patch give no report.

 drivers/nvme/target/pr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 09d8c63f5..bfd5447f6 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -589,7 +589,7 @@ static u16 nvmet_pr_preempt(struct nvmet_req *req,
 		status = nvmet_pr_update_reg_attr(pr, holder,
 				nvmet_pr_update_holder_rtype, &rtype);
 		if (!status && original_rtype != rtype)
-			nvmet_pr_resv_released(pr, &reg->hostid);
+			nvmet_pr_resv_released(pr, &ctrl->hostid);
 		return status;
 	}
 
-- 
2.43.0


