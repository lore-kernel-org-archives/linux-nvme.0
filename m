Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6303C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=iSnDtYlCWdfmQVKMyrLQtczPSHuh1Z0uNxlOAUJPl0o=; b=H4gZik3p7fUjaa
	YDvJTXgxAEECPZ8V8PcCHbAydIo7Xi9/sA/sA8iB7qhPACCBr4w937ZuLMquL9esHqWPVye4U5P2+
	llkw46hYS99AqA4Tm3VcxHPkXi86OyOEejckJs02JQulZ36bUyE/Uj0hybBM/Ay2IWEbTEhL/6Pgy
	ZHponMS/8s8ZeQmIFQ1EzXIhTxW+Uj3OfGDiH+bBI6BrZo4jlalLH0Ks+tI+wIwA2m8m9LG5edKvr
	d2375FW0b5apJUOl0EiEcshmyeSugnSabT06aZwiDgLK7M8Wb6QuEyFFXF4fYpyxhmunkgFmzhybB
	KuuXaeQ31ceclx8JhdLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaO-00000005G0c-3I9A;
	Tue, 11 Mar 2025 10:11:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaM-00000005G0G-34V1
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:11:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E3C0E5C5D63;
	Tue, 11 Mar 2025 10:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E8BC4CEE9;
	Tue, 11 Mar 2025 10:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687901;
	bh=eA0gXLdR8NU7j/cSciXgg6v3rrHW4bvlrhA6x3wySUE=;
	h=From:Subject:Date:To:Cc:From;
	b=KMhHb+bJ5He/eENrBrmUIB5q+xURf8b+IsXJ0i1s71x1+UW4Dn3A6tBmw5ZztlG0O
	 0V5nFewuxswJjFVafY+ALYd3Fw5u7McbfB/Oa6n+/3JSFxKx9LyfWED4USfS9lkF8U
	 a26pEXmvOxHK4voDk+W+fu8g8X+x22k37n0Wuqlm9LsM8v6JPRgbWEmRBuISys19lR
	 sFr6ZakpUishNUrufE1Fxiq/yTBNbl60KOAm8CLRodTmuvtrzz290yEwfQn6c1zKc3
	 jtmeadc6Gp4wCIyrVIHnr1hThC/EzbJm9CxHPZSfHiORe2k3opxNz7R5KIG/W/XPdq
	 fqmuSTI46FCaA==
From: Daniel Wagner <wagi@kernel.org>
Subject: [PATCH v2 00/15] nvmet-fcloop: track resources via reference
 counting
Date: Tue, 11 Mar 2025 11:11:26 +0100
Message-Id: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4M0GcC/1XMQQ6DIBRF0a2YPy4NAkXrqPtoHCB8ldSCAUPaG
 PZeajrp8L7knR0iBosRumqHgMlG610JdqpAz8pNSKwpDYyyC2W1IC49cSOjXrxfiZLi2vB2aFA
 ilMsacLSvg7v3pWcbNx/eh57q7/qDmPyHUk0o0XQwLTeCo1S3BwaHy9mHCfqc8wcvlJnHqQAAA
 A==
X-Change-ID: 20250214-nvmet-fcloop-a649738b7e6e
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031142_868407_B4B329F3 
X-CRM114-Status: GOOD (  13.62  )
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

The idea to use ref counting for tport and rport didn't work well. fcloop
was to eager to remove resources when the assocication was torn down.
Thus I looked more closely how the existing solution is supposed to work
and fixed all the problems I found.

This also avoids taking references for a nport and a rport/tport step in
step which Hannes was not happy with.

With all these changes it is possible to add/remove the target side and
nothing blows up anymore. There is just one small issue left with
nvme/030. The problem is that the test case assumes that the generation
counter is updated immediately but for FC it takes a bit, thus the test
fails. A sleep before reading the genctr 'fixes' it:

@@ -36,27 +36,32 @@ test() {
 	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
 	_create_nvmet_host "${subsys}1" "${def_hostnqn}"

+	sleep 1
 	genctr=$(_discovery_genctr "$port")
[...]

There is another problem I was not able to figure out so far. When I run
blktests in a loop, the system runs out of memory eventually.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Changes in v2:
- drop tport and rport ref counting, use implicit synchronisation
- a bunch of additional fixes in existing ref countig
- replaced kref with refcount
- Link to v1: https://lore.kernel.org/r/20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org

---
Daniel Wagner (15):
      nvmet-fcloop: remove nport from list on last user
      nvmet-fcloop: replace kref with refcount
      nvmet-fcloop: add ref counting to lport
      nvmet-fcloop: refactor fcloop_nport_alloc
      nvmet-fcloop: track ref counts for nports
      nvmet-fcloop: sync targetport removal
      nvmet-fcloop: update refs on tfcp_req
      nvmet-fcloop: add missing fcloop_callback_host_done
      nvmet-fc: update tgtport ref per assoc
      nvmet-fc: take tgtport reference only once
      nvmet-fc: free pending reqs on tgtport unregister
      nvmet-fc: inline nvmet_fc_delete_assoc
      nvmet-fc: inline nvmet_fc_free_hostport
      nvmet-fc: take tgtport refs for portentry
      nvmet-fc: put ref when assoc->del_work is already scheduled

 drivers/nvme/target/fc.c     | 146 ++++++++++-------
 drivers/nvme/target/fcloop.c | 366 +++++++++++++++++++++++++------------------
 2 files changed, 308 insertions(+), 204 deletions(-)
---
base-commit: 4bfed375fd3acdfa4324acaf22f7664e4819fbb1
change-id: 20250214-nvmet-fcloop-a649738b7e6e

Best regards,
-- 
Daniel Wagner <wagi@kernel.org>


