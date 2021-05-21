Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A6C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:42:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BE4613AF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BE4613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ched4Wq2cpO+634v1hG/X+sOBu71G/S8WBzoSi68D+E=; b=Na2OwqupqF6wXc2mywZYVZ+N7A
	Z6i3rK+b0IHLm0Sj9jmBYFAU71D4PC7fQjTgXPSYS9i+0xYZtjSWAq5hwsPXyMpTsPSTHr/FodTmE
	WGeV5xtq6zxP1kzQhWleitkB9r8macRnUmVr3W8c9310yRPCML8Xill2jervY46boXjL7T26ZyeQ0
	YjjiNFhoBswo9uu0s9XFol/dZq+osB5+Uw3JJXpiMPtz3najh4D4UG6oKqbgCA3cKiIqgjL00wGCI
	jtRk9G24uWCRkZPYLOUz3PxQIG4Fz1cmTyPAGANQxb0iVbGpe2zyunG6Pyn6O0fwJ7p4xueO0uH0W
	mDzsjfnw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDqQ-001Gs0-Ct; Fri, 21 May 2021 22:42:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDqN-001GrV-QQ
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:42:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=9twwF6dhtulcyWtsB8rfJAgzJRDkWgM+S2N3QcW70tE=; b=Or7ihGFM4V/KnMDAMIzQtYNU3x
 dzf1BVHLxvP9yO48IAc61/Qiylik8uM0/CcxJAzdQg741kR1arqLN100ecDvZLRnTyNYgxaCMSAXi
 rJKB8uaNGj/47H5yoj+HlYmchyUWki3Xpn9QgxICXT/3R2Jtelwq3DLnEknUyRmnQFTWfMpXq0R4P
 r+zelD39yJ6eeysC8twygadOLxT8TWb0p/GrKmFZJhNbAYbgod4CIQT7KWXqJVWpV6QM/ajwn6goY
 tj+DjV3Zyg0eLsli3VOyjE8NjOnvtyitJO1DpR7pOqvNpl6PtgLfweff0HQFZzkgxXguEas4LacIY
 Gfc0t8Fg==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDqL-00HTfb-0j
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:42:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621636929; x=1653172929;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xWFm15jvGqv2AsFXR8DAbu5GfqOELuAWquiZGiYCYEw=;
 b=eO8FL7B5LmhgfvD0ry/x6lWHrG3tDmmf55bN0zWWB5kByJIYmqB600ve
 JizeFXL2GwL4FGBWjLS/AWvw1BUBHLbgt+p3Vey63NXiIrpJtTrEFOFxH
 ncfX82X7DhP5LQmCbA5I+PA6u+bgN3/AoQ3g18Yz3aml04GhGhusujJUn
 36X5KDLZMn8gtybzHUUjs4+KSdRKCxeoqoLFgvAtfxmpKyMe31xd+sH8K
 466D67KXAm/qjEmNV2oaWAoGzPPCt4+pRIHbGRhwZW3I6XVOgtQHmHKft
 NMu4mDCfvFu0YOaT8Q88jgmsHNY5YCtitGHPnvSso2fNC/8skI5tiN9ZH w==;
IronPort-SDR: 8wB9kevMMemZxrgaWsYDS/zr0me2tQjNoqwuWlUQ6/1hPNG0PjF7P3LKoDDDoqqhmgLVx7HuQA
 f+glgDWVaLvczakDTcWPm/z0M2Br/GRB2+ENk5lM3y8ve8TQzFzK7dKExiW5RARA4PI/uDdAAn
 fbDGlq9LDbc9UimPR9z93AF1Uw4Cqs7Fj+5D+tLasmb+SEdsz+eeJiQrs3KA+pFy29KOdaarm5
 2gdwnFxQeZots1nMllQV6nqXrq8EkydEb3gU6nZYLOElLGyVk+q4K+lZ2SFJYRgX4J1fzgv+Hg
 bVU=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="169598947"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 06:42:07 +0800
IronPort-SDR: vFNsqMj+0ZXx1CO6Ge7ahKap9/EJ50kujROijfgObSA+2ECaGS9gV20R+G9zKsAZFh6DMt8ClP
 zIxc2iN3PFPo7O1Mu9MKGtYXAZMOTvN1rieQ5S4zTnoTgy7wGgXh6SuQZzOfyJ3vR5HQa08gCo
 Ws95HiwBPk1r5E69l+jnZ2MycGkRpc1wY6QiF8Vt6Lpof/pBjxlpGQ2h+6FYjCGFd4RQWYIHK4
 78QcaQ4XeHoqMBZqa5USj/e6YmmzpvicP/lhNnNzOi6jGHo7sHQyVxlq14lFrycE9wq4dWrexB
 5Hj4g7seg65wLbZL0ljS8yz/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 15:20:28 -0700
IronPort-SDR: Fv+go5kGGrtUdok7b5HRarOOfH/R1iGaX11alF4PXOHxfd3a+Z3qnlWUVgLvt0HnJt9O09Iggi
 UrajLmG9Wx0gNr/8r2yUvI1zmsOLyc4gYaJVPj7qf2xH1irJAypF3cMzAtP+NDTpSKbZqQlvpx
 h63uYenriPCQizfKpJzwhzIH/0U8N8p1EqoCRrwm5PToSnKLS804ZTbM48jQqsOmJsF8V+rrzq
 NB4DYQoqRLyzC9Oph1t1SezrxKPf95dbUnV4jvC71nq1QXiSPUx1D+mCaMvwJFAtQzMnJwwRJi
 Dgk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 May 2021 15:42:07 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/4] nvme-fabrics: cleanup around nvmf_log_connect_error()
Date: Fri, 21 May 2021 15:41:56 -0700
Message-Id: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_154209_155961_3053BBDD 
X-CRM114-Status: UNSURE (   8.53  )
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

Hi,

Small cleanup around nvmf_log_connect_error() to fix style issues.

-ck.

Chaitanya Kulkarni (4):
  nvme-fabrics: fix comment nvmf_log_connect_error()
  nvme-fabrics: remove extra new lines in the switch
  nvme-fabrics: remove extra comment
  nvme-fabrics: remove extra braces

 drivers/nvme/host/fabrics.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
