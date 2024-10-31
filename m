Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E239EE68958
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUrG3rRpo1ODMcpq/h1JSd/3TTN/xfHoWeRIoYkaI6k=; b=08xOjRe2qcJl+uhjTQgwiWt8kE
	FDMfG9O9wYNPtDUjqlEMR+f+fCLfnGFYFyeoM6qDJpeQ5VljC5uab9HLPKJ/dKQJl90DtbOU57lWh
	Q+Xq+S5syxhnC5BnQGPj/VYAC7sU5rUzZF5+1IurGqJPvqEClR2rc15G0wN6uWny0GL8t8RQjfu+n
	rYV7FbrePuGMmBEJw2HwcFAyYNPMDn/wLWCp3Ag167bTo4g2Uu5OsI1S6IPtU8ODxJycNK3Qb1mXG
	aJkfaV1DizgQpmSikyH3q0efDEPgBeam0djhl/+JDHwlldObJxYmxR0EeYz1HEViqQGXDuX+2D5ax
	toAGHFlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P86-00000002jli-1LFy;
	Thu, 31 Oct 2024 06:58:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6P83-00000002jkt-2yft
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 06:58:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6232A227AAD; Thu, 31 Oct 2024 07:57:56 +0100 (CET)
Date: Thu, 31 Oct 2024 07:57:56 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet: make nvmet_wq visible in sysfs
Message-ID: <20241031065756.GA26518@lst.de>
References: <20241031022720.27202-1-kanie@linux.alibaba.com> <3cb63cfd-a4d5-4516-a2eb-7b968a036f7a@nvidia.com> <74fd4aa7-5d58-4493-a718-673143611989@linux.alibaba.com> <019d19a4-cf4e-4405-8672-b371f116da22@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <019d19a4-cf4e-4405-8672-b371f116da22@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_235800_320254_82098AFD 
X-CRM114-Status: UNSURE (   6.69  )
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

Looks good with the updated commit message:

Reviewed-by: Christoph Hellwig <hch@lst.de>


