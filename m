Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC0BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 06:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EdvCX2GT0W6Cm/w/JCftPinES1WaQ+X1jEwXlQkLESg=; b=OpTBgtYr3yiXKm1BmAfal4Vai2
	Qq0nwaegICaBAN2iHUnq+/ZlmQo0g+CNicVU7rEH2eWroWKr2Sv8FQz9vV56vMfdSh43d5l+4SFom
	16uT6Nm1p3WgoE4gbV95+nepiUJ34RXfkecd7K9V8DCuZ5bbDEsZ1Usjbqq3qeXLFE5egcVPlKozp
	tExM1se5nxHEtBNK4WakKNnHm99bneZk+fmb0Y2lR5HW8RvDDI1DNvBIiI5B1Ijhy1Cnr9MCl8aVE
	2ARiF9Imak985L+B/TyvrHCb6IftQmNJHQvXlRXFGYPTZCA/GAA4462a3Md2cO2RvbBog7k9fBMLN
	05u3G5+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovBZu-000BME-AR; Wed, 16 Nov 2022 06:07:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovBZr-000BJv-Bg
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 06:07:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49CB868AA6; Wed, 16 Nov 2022 07:07:07 +0100 (CET)
Date: Wed, 16 Nov 2022 07:07:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [linux-nvme:nvme-6.2 26/41] drivers/nvme/host/nvme.h:1030:1:
 error: non-void function does not return a value
Message-ID: <20221116060707.GA19088@lst.de>
References: <202211160745.7DFOlBj7-lkp@intel.com> <9c9e54d2-7ed8-0ecd-0742-4bc5e6ef7739@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9e54d2-7ed8-0ecd-0742-4bc5e6ef7739@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_220715_556269_3FB4259D 
X-CRM114-Status: UNSURE (   8.54  )
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

Thanks, fixed up again.

