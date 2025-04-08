Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9229C3600C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 06:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nkQR+Pqjxb7qD2vxoEoYXOmPzl6qLR7UVCq3LQivBf8=; b=Uad5JkqoqGR5NbRgY6qSdezX6O
	M9G5HkbheG6qnJdKFKrploCr9iXQvE6BMJntxhiT/4PWyX6X5IWkFJYHZigLPrrGXPEs5VDKPOfVZ
	GPtyLxo7Hpl3vOspnOX3HuPG1EyF0pIwSVLOCizyZoxU+nqd0XUoNTZjQj26YyThrqDzG61m0d7gR
	wyEoHiLiAa//g0lzkrhpPjYwPNVdjfh2CBc/H99FAsjDP+9NqICn8OiZ9RpMwLYzeCbyhToHwCvde
	FDhajpPz8uXjPpA6aS2VqunMRMihNm30Lhue72fENqI7aaVHjR6wBPaA30R0o94bXRac9jkM2TmWW
	a84puqAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u22C0-00000002rv7-27Qr;
	Tue, 08 Apr 2025 06:12:16 +0000
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u228J-00000002r24-30Dq
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 06:08:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744092508; x=1775628508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkQR+Pqjxb7qD2vxoEoYXOmPzl6qLR7UVCq3LQivBf8=;
  b=AT3El06zE9LiYXvLZaHen+5CQi+IPPmE7TuDXYJisY3vQK1zpsV7yha5
   yREvC5bKYn1Cdo8oVUYhRWTILn8v9imkst0Uhq130rj2GFp1Xi9qDCQJD
   yVgQtVn4g0V2ERmcdV0WHTrmnmbkZ66eu8JH2dKssEkJvGDl8MCt3tmKX
   U=;
X-IronPort-AV: E=Sophos;i="6.15,197,1739836800"; 
   d="scan'208";a="814217596"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 06:08:22 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:35289]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id 7e2c9346-85be-47ed-8283-ea868b0c771a; Tue, 8 Apr 2025 06:08:21 +0000 (UTC)
X-Farcaster-Flow-ID: 7e2c9346-85be-47ed-8283-ea868b0c771a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 06:08:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 06:08:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hch@lst.de>
CC: <axboe@kernel.dk>, <gechangzhong@cestc.cn>, <kbusch@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <netdev@vger.kernel.org>,
	<sagi@grimberg.me>, <shaopeijie@cestc.cn>, <zhang.guanghui@cestc.cn>
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit 1be52169c348
Date: Mon, 7 Apr 2025 23:08:05 -0700
Message-ID: <20250408060810.19654-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408055830.GA708@lst.de>
References: <20250408055830.GA708@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.45]
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_230827_888163_D7548036 
X-CRM114-Status: UNSURE (   9.32  )
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

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 8 Apr 2025 07:58:30 +0200
> On Mon, Apr 07, 2025 at 10:55:27PM -0700, Kuniyuki Iwashima wrote:
> > Which branch/tag should be based on, for-next or nvme-6.15 ?
> > http://git.infradead.org/nvme.git
> 
> nvme-6.15 is the canonical tree, but for bug fixes I'm fine with
> almost anything :)

Thanks, will post a patch tomorrow :)

