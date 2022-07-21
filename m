Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EA1CCA487
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eiDK0OFnIJ7UKD8c/oYTccsrMd+OK2z8+jfTnZqqs6Y=; b=fh87xq9GH9tiCyTu885ATnzhKW
	DuBHYB80h5Rhh/SYN8hJ3iYHXjVoI+ofkhbC3243MKbnFrObzC4Kb8WWabTv4PMU07F5JJYptbfpj
	HNxH39nLfD3XBzZuSuiMjTy6A2XxXl8JOX8ydGu/qS/98OGQH4JxfQaMXtC1eMaiGMshkiaTTkBNL
	PX17qp1AT0P+CUG7NiuqO3K62qLea5s/YIj2TpNcF+iDKvZtwg6BHJyEa3Y2iuzQqWPwNi91yMbET
	9BIE1QC5rvsJVrc+1Mk8SFSCZtD6J75WcQbNdNMParcZufp+DcQvDqZ01+QWg4iGqGG4EZshOtJPh
	wegB1sdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEYJW-009FJa-1T; Thu, 21 Jul 2022 15:42:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEYGD-009Csh-Nh
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 15:38:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1E87D68AFE; Thu, 21 Jul 2022 17:38:39 +0200 (CEST)
Date: Thu, 21 Jul 2022 17:38:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, kbuild-all@lists.01.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [linux-nvme:nvme-5.20 6/14] drivers/nvme/host/pci.c:3540:41:
 error: 'nvme_dev_pm_ops' undeclared here (not in a function); did
 you mean 'nvme_dev_map'?
Message-ID: <20220721153838.GB5900@lst.de>
References: <202207212326.SB1C57On-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202207212326.SB1C57On-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_083845_952099_B83B9A1C 
X-CRM114-Status: UNSURE (   8.38  )
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

I've dropped the patch for now.

