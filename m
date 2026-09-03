Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C48C61DD6
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2026 02:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F613iBUD69DqNXoihipCxglkR5WnMC1Q0NRfWEdTXAs=; b=BxeubZ09o0Yvq22ogICMBQWmbL
	SEBQQrCv+awwZwtM4t/fk2z/MIRfOZ9I8EE6GLLL2V4uWbNtn1aEbPTusKliuoVJDKxr/ObHuHA2j
	Oy1yuMQkXrh35OIKkDwkyx1mlwyTE9wLIhqlKQERqip/Q17UFtjpSbWSDdV1QKJA1hdlUymcD5+Zr
	8e8exzaBZ80l0BqcsMtOmM9CipdgqdFigExvthuNn1zuLUWS9G9UyGqzQu89TDA4fSBZeWiQ68D9e
	BT+d45XyluWrxl0DbF3Wa2rtKKGrbNk3seBJ8uWqe3BkwwwzWsBKe8yJULnlwYLeErIEMwA8ziLha
	jFZC+0OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1xMB-0000000GEVs-3uqT;
	Thu, 03 Sep 2026 02:39:15 +0000
Received: from out30-111.freemail.mail.aliyun.com ([115.124.30.111])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1xM9-0000000GEVW-0baf
	for linux-nvme@lists.infradead.org;
	Thu, 03 Sep 2026 02:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788403147; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=F613iBUD69DqNXoihipCxglkR5WnMC1Q0NRfWEdTXAs=;
	b=oejVgia1C7FmFEAYrEp1YYYxMWGi8xeRI1a0FzyX2qGADYD5TMiCi+O398KXxPa5OsM6HP3U4DHlb8ge4TP7fhiJcEEvui7R9qaxLblFP0+uIFkRLdM9aaBv9+ht9JNmd0iWCSC21gA09Fd4c0WecRd/WRwkIEgs1MFJZyGMgFg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0XAEVlOI_1788403145;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0XAEVlOI_1788403145 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 10:39:06 +0800
From: Yifei Chu <Chuyf26@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: verify the hostid when looking up a controller
Date: Thu, 03 Sep 2026 10:37:14 +0800
Message-ID: <178840303415.121937.10499065434948720286@linux.alibaba.com>
In-Reply-To: <20260902140400.GB23598@lst.de>
References: <178782553270.1581249.13595405857993482779@linux.alibaba.com>
 <5fb6acc2-4ac1-4f1a-861f-13c88b3b9239@grimberg.me>
 <178814381141.3422569.11201888645559295686@linux.alibaba.com>
 <20260902140400.GB23598@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_193913_864018_DE7FED9E 
X-CRM114-Status: GOOD (  11.51  )
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

On Wed, Sep 02, 2026 at 04:04:00PM +0200, Christoph Hellwig wrote:
> So?  The hostid does not identify a controller.

Agreed, the controller is identified by cntlid and hostnqn. The
check is not about identifying the controller; it is about the host
identity bound to the controller at creation time:

- The fabrics connect path has a dedicated status for rejecting a
  connect because of the host identity: NVME_SC_CONNECT_INVALID_HOST
  (include/linux/nvme.h). nvmet already returns it from
  nvmet_alloc_ctrl() when the hostnqn is not allowed, but the hostid
  half of the host identity is never compared when io queues attach
  to an existing controller.

- The Linux host fills the same hostid into every connect capsule
  (nvmf_connect_data_prep() copies ctrl->opts->host->id, used by
  both the admin and the io connect path), and it refuses locally to
  pair one hostnqn with a different hostid ("maintain unambiguous
  host identification"). A conforming host therefore can never fail
  this check.

- nvmet consumes ctrl->hostid as the host identity: persistent
  reservation registrants and holders are keyed by it
  (drivers/nvme/target/pr.c). Letting an io connect with a different
  hostid attach its queues to the controller attributes those queues
  to a host the controller was not created for.

Comparing both halves of the host identity in the lookup is the
symmetric counterpart of the existing hostnqn comparison. If the
nvme maintainers disagree, I will drop the patch.

Yifei Chu

