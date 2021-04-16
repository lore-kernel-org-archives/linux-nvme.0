Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA7C433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 11:47:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA0D61057
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 11:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA0D61057
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JfuHAY0CbgBTkG95RTKNE40K3dMh+h3M5HE+scL7SHg=; b=UJXEiXepSCZTigZNTdjmHnQlzC
	uQOYANL1CRie6YMZ0KBG/4WxNW511HaaLg2SthznOQmCtX/7v6QGjNc7tvrEUwm8xfBUZ0cUPUVxu
	NXOIgfUxWQ8oxAbbuimkmaxvTMYSlo9+WkhWN6JvJGTkCjKhjKhX30ZqN8Yd3rMG/ehbg/zIBEpeD
	7KHwzfzeNNAZvGsxnnrtU11qUy9C1ptRcBd00+H692eoVeGE/NQc/I6n469+JD93y+Ki46cUxWFkz
	izKyU0AiZoZjmsqRxyIKI6Z21U+dV18uveOKLm52x74E6rCqnx8zb1NZGo4N6Ha816xixnjqfOfNP
	SKGK7P/Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXMw3-001ySV-7I; Fri, 16 Apr 2021 11:46:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMve-001yNF-OX
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 11:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=cJE73Zta1OwfeSgHqxfcQ5ROPePVYTB+10LPvDhtcMI=; b=TjKolD3EHp6VtgJU/R4uVWp1Fr
 f+3WHZpp0yuHhjRbBdS/k8XWkUcJ5sLdCCELTR/85WVL1ZQBdxqtDIA75OZUvI+xSoKzvJmNn0cIc
 WeDW+9V1uaX3lhTEaxzVv6qctxUANJ9wxLDt3LZgvrou9affPXiqnmH5Gvt2gXkDN6AV4/OQyBYIa
 R91oDPUaJ0nuGaVvsllX+xipMkYHU9E8x1/1ixuyezyn/X9go6tmPLj/eyo+qUkyS069bBGykw+6W
 24MkPTWnTuLQgQaKy2xfqRtgISO0BrdWQcMcXEBRk/p5rGEiR+qd9SkhBTPDpwy0XuqdRq5IYjMi+
 o5tvYjYg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXMvb-009KRl-8y
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 11:46:28 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B7495B029;
 Fri, 16 Apr 2021 11:46:25 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 0/2] nvme: sanitize KATO setting
Date: Fri, 16 Apr 2021 13:46:19 +0200
Message-Id: <20210416114621.129736-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_044627_503373_465E6F5B 
X-CRM114-Status: UNSURE (   9.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

here is a patchset to sanitize and expose the KATO value to sysfs.
We should follow the rules outlined in the NVMe base spec for
calculating the KATO value and interval.
And by exposing it to sysfs we allow userspace to identify persistent
discovery controllers (which will have a non-zero KATO value); a patch
for that has been sent to the nvme-cli github repository.

As usual, comments and reviews are welcome.

Changes to v2:
- Include reviews from Christoph
- Rebase on top of nvme-5.13

Hannes Reinecke (2):
  nvme: sanitize KATO setting
  nvme: add 'kato' sysfs attribute

 drivers/nvme/host/core.c    | 20 +++++++++++++++++---
 drivers/nvme/host/fabrics.c |  4 +---
 drivers/nvme/host/nvme.h    |  1 -
 3 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
