Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD570C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 18:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l0L5su+mRIZah7JQgqrqHj4Md4K6it8j5GrTc5Wf4a0=; b=uaITiLwn/ftHHb1B2wsEvVvL/0
	r0ofzDghn0XkOnd7TLW24ms1vK+p7LmsEFxgueiT3QlrvpbFkwzoKF2aFiv96RZbRmdaC8Z30vBqT
	0Vt7dn12laOBzA6qDlELCH6BKoPWDgIubSPquu4QKaVAR8sV+T9/+dk+E+06La/TyLI1X3P4k3P00
	3TZjPZ21FG9US8WnZRd5YQCilFIvF445kUm4rgbzrCc8btLwc5OyTTmHg9y86zqoz5mqg2uKuiR3I
	7WqT232LKytDFG5kgEkIV95v0czAFpGgd3se2z75baw0mpUY1wlUw3pciOai8PfIrA18jYwtjl9jW
	BOQHKmRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oav-0057gl-U5; Mon, 13 Jun 2022 18:15:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oat-0057fS-15
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 18:15:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D97D268AA6; Mon, 13 Jun 2022 20:15:14 +0200 (CEST)
Date: Mon, 13 Jun 2022 20:15:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, james.smart@broadcom.com
Subject: Re: [PATCH 0/6] nvme: __nvme_submit_sync_command() cleanup
Message-ID: <20220613181514.GA16224@lst.de>
References: <20220607011647.24105-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607011647.24105-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_111519_258142_44953D4A 
X-CRM114-Status: UNSURE (   8.23  )
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

Thanks,

I've applied patches 1 and 2 to the nvme-5.20 branch.

