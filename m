Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D1DC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 12:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hdfx3WFABSXDf7nwTXX1FPeaeTgAM1QYvXnfQUDulPE=; b=qdaK1e8E2XwbgJEzhaR8NQ4r+k
	ODzyNwc2mTfdiVF3ru7e2zTaPqG1R1efez1P7yRXhq2TX5xGanpIJzGt1mNtkZqj7iy0If17DmIap
	r4Fvwn9JIMF/Tq0qlSMJJR1zec0vt/HAGApPRsHjHlNo7TFuIax9mxKolHGBvA6ngYbfrulyHplfU
	ixi1ExJS0NdC1xwnFHbPOkhY+11KhYBHQwlKN7ZrmjhkYPO4T4iVJo9bG1IkDNS7rKcar/BbOsRxZ
	jEJakCiWZeOzxpZ89aFBPVjSa5FSrif5MleDrxbV+yA/dfZ/LPR7OKn2VbNsYUwWADgQN2iSzyAZT
	AXx4SUOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBS4-0000000Ed2J-0PFu;
	Mon, 29 Jun 2026 12:51:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weBS0-0000000Ed19-2Zdi
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 12:51:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F63B68CFE; Mon, 29 Jun 2026 14:50:54 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:50:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, elver@google.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 14/17] nvme: fix Clang context analysis warning in
 rdma.c
Message-ID: <20260629125054.GC23695@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-15-nilay@linux.ibm.com> <20260626064916.GC11106@lst.de> <d72e3efb-875e-40b4-80cb-1fa642bea7a5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d72e3efb-875e-40b4-80cb-1fa642bea7a5@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_055100_801897_1C390FF7 
X-CRM114-Status: GOOD (  12.72  )
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

On Fri, Jun 26, 2026 at 09:01:20PM +0530, Nilay Shroff wrote:
>> Does switching to list_empty_careful fix this?  If not, does
>> list_empty_careful need annotations to make this work?
>>
>
> I tried using list_empty_careful() but clang still throws the
> same warning. And yes it needs same annotation to suppress
> the warning.

Sounds like we should have annotations (or just use of data_race)
in list_empty_careful, as it is designed to be used without holding
the relevant lock used for modifications?


