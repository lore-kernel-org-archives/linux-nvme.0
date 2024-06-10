Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E73C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nPDd4pHK3huS/bYarDMNvstf9AhHNsvf/CKokouyd7I=; b=wBvcTQHpYutqrN3EaCFKzIsq7f
	/NBuHR8qSc64mBngbaG+93hkeBKXY0uVhU+f8m7le0z3czMFvoqiBtoBEBbj7Auxe4sDQMITRn29X
	sfwQhY2LIIHmMsgNopEvaorAIT6UqCXyyBy4cA1t7znF+LkoQEgGtgXqPcoKSIBISfFpYuJBG9IhA
	lLzBPkp02KQ0acTI/tWvtxkvSWYuAWTqQI5EiNfuNHbtzXk6WBdP42pPzqrEPX+BErQkbRgBCTPnz
	f4HXTI3DULwVKPtavM2X3YwLKBf7haMjJRpEP056JAzcHVQeDnIAX/Si0PB+/c4+zNiEzmFIAe5wc
	3+CfQ/OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGk8t-00000006C3E-1TeB;
	Mon, 10 Jun 2024 18:53:19 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGk8p-00000006C2l-2bkt
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 18:53:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7B88ECE181D;
	Mon, 10 Jun 2024 18:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BA1C2BBFC;
	Mon, 10 Jun 2024 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718045592;
	bh=I98Y7QWonOUW8VtV8Ziw+2/VviXGTMMP9IFQ+8hdMEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vF1dyYyBlQXhXzGrzE9Q8qLqzLpVrIPx7UXUGQ0gkQdeTfGIcBgXsajqXjYhDQmY9
	 VS+XAtbCfcZr8bR+7dRQ8vhkd+Hm8JBajhV1Qzi/jygW1VZKQqU3wA1nTQnKnolOFe
	 RbXDw58KdHM3ElK330jq7qK8N2E4QX5RrknLDrqPVxfJStj+mJHc7o9xgOXFRijsOU
	 YiyMdQ3GnvMMQijmMaYh0wyqPv7Cnm1LZCrfBiMbppwpw2gQ29LX2Ek/sTuTPxnP+0
	 AKkISnLHG/y+QUJUP1VBq3p0WI1xdWTJqG3NcnvQ2LyGZem6z4ZcoL4pB3Z3jp94wg
	 oi8neoB3IIfiw==
Date: Mon, 10 Jun 2024 12:53:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: sagi@grimberg.me, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Message-ID: <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_115316_299121_4963D4CE 
X-CRM114-Status: UNSURE (   9.94  )
X-CRM114-Notice: Please train this message.
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

On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
> 
> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.

My mistake. The namespace remove list appears to be getting corrupted
because I'm using the wrong APIs to replace a "list_move_tail". This is
fixing the issue on my end:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7c9f91314d366..c667290de5133 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	mutex_lock(&ctrl->namespaces_lock);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
-			list_splice_init_rcu(&ns->list, &rm_list,
-					     synchronize_rcu);
+		if (ns->head->ns_id > nsid) {
+			list_del_rcu(&ns->list);
+			list_add_tail_rcu(&ns->list, &rm_list);
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
--

