Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92742C3600C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 05:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nnlKcunjrO5Vrzf8adu6sG/IV+JTDrSeQCmltXqSrKo=; b=e1lIyOvt+glxE3OM5GsEBE6oxT
	mkv7kwSPf7oFkhXEYENFLKThJ+WJuQPTIlnsR2xunyyFfR/bu7acvMk/45yXcQKL6XWFSnkhCpF7M
	LelrUK4n0ZV4h+3K+Q/rzUO2DXrdRNoytlP7hShNZgW2WNtcOsTVgdmE74BrTyd+3iUE11D7kJVG9
	01qmLMDJr4sM52Ndvdmfu8R9pqgeGNbmKMoke89PDSjYiGd+q6SI+t+yynIPKIE6qAEa0t9RI2NgO
	/JXtkAJNTw52ajoVcvsdOrapuwDxNpHF1qe5IcKrZnz4JNwS3rNOpGtdTJ175pgohvF9cyYWgSYOk
	AmFiLG0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u21xC-00000002p7u-33Rc;
	Tue, 08 Apr 2025 05:56:58 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u21wM-00000002p0M-0bgF
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 05:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744091766; x=1775627766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nnlKcunjrO5Vrzf8adu6sG/IV+JTDrSeQCmltXqSrKo=;
  b=ou2IfHuQo1/ITsqo0DlXLv0ZnBBax6cMiYMBzbwkMkEA1dtXaSIDejY4
   PifO6JQnqwxbxwQu9QGU8/jn6FKqDFhXYRWgS5AIXhTJbtXOyNL0xNXTm
   nYYSbr/LClooXB4fcNv6BVlHWZJQ0/goaD1R0wZfDYX+49raOlnrP4pjB
   E=;
X-IronPort-AV: E=Sophos;i="6.15,197,1739836800"; 
   d="scan'208";a="185441349"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 05:56:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:60199]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.120:2525] with esmtp (Farcaster)
 id b3b618e6-478e-41e4-b234-2896bb1f70bd; Tue, 8 Apr 2025 05:56:01 +0000 (UTC)
X-Farcaster-Flow-ID: b3b618e6-478e-41e4-b234-2896bb1f70bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 05:56:01 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 05:55:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <hch@lst.de>
CC: <axboe@kernel.dk>, <gechangzhong@cestc.cn>, <kbusch@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <netdev@vger.kernel.org>,
	<sagi@grimberg.me>, <shaopeijie@cestc.cn>, <zhang.guanghui@cestc.cn>
Subject: Re: [PATCH v2] nvme-tcp: Fix netns UAF introduced by commit 1be52169c348
Date: Mon, 7 Apr 2025 22:55:27 -0700
Message-ID: <20250408055549.16568-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408050408.GA32223@lst.de>
References: <20250408050408.GA32223@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.45]
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_225606_234276_4574AE64 
X-CRM114-Status: GOOD (  10.44  )
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
Date: Tue, 8 Apr 2025 07:04:08 +0200
> On Mon, Apr 07, 2025 at 10:18:18AM -0700, Kuniyuki Iwashima wrote:
> > The followup patch is wrong, and the correct fix is to take a reference
> > to the netns by sk_net_refcnt_upgrade().
> 
> Can you send a formal patch for this?

For sure.

Which branch/tag should be based on, for-next or nvme-6.15 ?
http://git.infradead.org/nvme.git

