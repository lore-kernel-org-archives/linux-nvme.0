Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E002C12002
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:54:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68E9560E0B
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 07:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E9560E0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KuWi+es1P/b+pZo/z5ZFGxrcRX+6KRReLQazcuQ7ZC4=; b=I+thBUvYdGPLIf
	VPUJnfo2bxrYJZccdWRBp419t/KVq8aMLYVaaNIye7Irsg4EyMe+Q6q/x5mjmSLLwC+EuaHM4bETH
	HZe7TC3DSOLw4+9Qs8cnxJpu2OLan9TnhaM5/Qk2PaU6YXGa3345vipysRSM8I4jWIA3x0QW0cEcE
	M5J8BDnnFnu48LOHm1Gen0c0Ey8f5/f2Tc696EB9/ao28M6zXmJmcBc3tZrgwb1d+e6CV+U5zYlDl
	6wM4kGtZB4sp7xekAWhxCsK8/GnnTy+a/ck3rNHECnk4m9WbX6MjXnH8AhY7RfKEJKKo1gBgzFySV
	s59pAlfWsQOAglmUnLMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4Ifh-003bcn-KB; Fri, 16 Jul 2021 07:54:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4Ife-003bbl-3a
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 07:54:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3BC4F67373; Fri, 16 Jul 2021 09:54:04 +0200 (CEST)
Date: Fri, 16 Jul 2021 09:54:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 rakesh@tuxera.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] nvme-pci: Don't WARN_ON in nvme_reset_work if
 ctrl.state is not RESETTING
Message-ID: <20210716075404.GC15223@lst.de>
References: <20210705133829.349660-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210705133829.349660-1-chengzhihao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_005406_348999_83BDD842 
X-CRM114-Status: UNSURE (   7.88  )
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

Thanks,

applied to nvme-5.14.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
