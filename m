Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A4AC48BCF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:28:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90FDE613EC
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 01:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FDE613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=QYrtwILf4HiOq/hGjcqrjlQxFe6yFS2EYqrfrLPuc8c=; b=KGn1hfKaI7dLHl
	LymOnB1m+oKMvqN32kpau9qN3CU8Q0lhAQprTnAOZZ4KOzNdJQBdhJp+2OLbirfhQDb5UJ6Nt0rIm
	l8lXDhP8fC4deOhGyqDJ7uNc/WFM2cGlAbqUOdIv3xqyTrjLJhh8e9OuNaZjm7nrmVaoFXg4pFhA2
	kxX+V+VYFEdIlojVTN2lIPeJihGo7CADabNIpEUEYG+1FaHbyF0ASZcClctQUrUzZjiBmF54V1KUB
	fVV13dOccvbc/X2eiO4poFx+XyWQ4xSgb/S1Kd49GHnc43z2rgMGZHB9AeoZ701BTVkLvCsdo4/aB
	34dHzQfHs1thnFAi/wRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr9Uo-00GFwk-9M; Thu, 10 Jun 2021 01:28:34 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr9Ul-00GFwS-IO
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 01:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623288511; x=1654824511;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=UG7WkcTo5TPZDrcV8FoI0fjpgB3XBu5PBYDdXchSaYM=;
 b=W9g4WUcVbXY/gxUE00v6pxYaxEYUtMirxLrEIezumxcwtq3o23vfVdNC
 D7b9lypOe1LP6b16WHhpE6kCtl64xaUjsElpyTZXXUzmEWTquxkT905zq
 bB9A36CRSosazyp8nfSYduZOeNdn0fMJprR/YiVYxHzNe/txVevTUPZTT
 Yn8rvZmp0HfRbp32ofMLzOuvFFZepp03rLwxRvXTQF2WaCmVtTDa6Zu3F
 Hi0jw03W+sihs+nMjtA3kDLWBYp7QAN6Q0X0pjgGnbkCOxD6dNdrL1PQ3
 TegYoabu/np2CW4E3+mZsoVEkLGD5CFZ+J0SGQz0gRReoRKkKh9qrnXyn g==;
IronPort-SDR: kRrNzI+sbnxjy+JXYR17k4y2THXHfmA0kaJeWRLoMJ/BnCEpr/26YSZ4qntODQlwEG4lDR6D4n
 drv9xCpajp3OSAcCb2OwWX7SbiADCjLmEzdJ8Q3ZugI2T7citrKjOX865rjBYvtuAsqiZF8NNC
 DV7o19cCAtIp2169JmKHxxNqu61zXvr0E29PTIeAPlExl/djmfWAGIHunbJFWFwWy7anfvkDIw
 VsiiitR/gSjBGv/b1QClnc4uZoNba3PpY3lv2/xonw6G38zx/TY1R0YJ86xeGYXUIp6qlmHXr9
 Mao=
X-IronPort-AV: E=Sophos;i="5.83,262,1616428800"; d="scan'208";a="170653254"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 09:28:29 +0800
IronPort-SDR: STRpDwPuluNzL7jvu08RcZZcKjOqZu+TUOuI6w95rheaje6NjDX4ynuMNDpkbjqCpJ2ftmmUDk
 yyKqgWn91thbxieCp0t0+fzKUQh82cykeWaJFM9Y3XgZeaCrWm78y0PwrD8gdivrKTbuM0saMx
 RYSwK/f+S3CnNwdZgJaGSw2GaUr3EB+Ly/KveuUWYeizFnW60FZGA5oRe/zb9aNpm/p71ITV6p
 ejXU1LuZVAQ/EcoTz4ZWYCOZvx+/ZDsUBAekQtH/Xh1kQn3Neg0n0lf8OxyCp7+ytybL+Nbr+E
 LDDIgYIyEioWG5nOfejg1sC+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 18:07:32 -0700
IronPort-SDR: hEebQFY0S6Bqpne6/mwwT5/szP0Ssd8Gg55gJlKw1ZBiXUZLDdP82wY/0zgViqNk+a7Xe3djyd
 sq26KC6EicXxDH8cfkpjfpcOyQpx8+NGIzOPrSexeh9CJqLC+dtkVouV84OdWyCVf35J9nd92B
 CTDahdScO3RoTZHuQhqifuSVqDbU6xsbqXI6x84A2elZnwvxMnIn0DKFilwqbRiSC8vfJkhvlz
 y1m/hWyol8A5JNjUOTrvP5PRuVdYWRhfib2e0vZGk+yAWttIqwJP0LLO7oslZn5ykCvcYG4KwU
 FzA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Jun 2021 18:28:29 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/4] nvme: add ctrl sgl supported helper
Date: Wed,  9 Jun 2021 18:28:22 -0700
Message-Id: <20210610012826.53398-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_182831_709564_8205D85B 
X-CRM114-Status: UNSURE (   9.72  )
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

For various transports such as fc/tcp/pci it is common to check if
NVMe SGLs are supported or not by the controller.

Instead of open coding that check add nvme_ctrl_sgl_supported()
helper and use it in the respective transports on the host side.

-ck

Chaitanya Kulkarni (4):
  nvme: add a helper to check ctrl sgl support
  nvme-fc: use ctrl sgl check helper
  nvm-pci: use ctrl sgl check helper
  nvme-tcp: use ctrl sgl check helper

 drivers/nvme/host/fc.c   | 2 +-
 drivers/nvme/host/nvme.h | 8 ++++++++
 drivers/nvme/host/pci.c  | 4 ++--
 drivers/nvme/host/tcp.c  | 2 +-
 4 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
