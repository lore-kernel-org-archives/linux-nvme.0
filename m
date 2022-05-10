Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B60DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cWEwnUHauh/YtLqhV9UlUNuuXB64BevecWZnrqZGsQ0=; b=1GY4/qUAyHSPY1OeQMJf6Izlyc
	yqIBNAIJ9/m/EWkN8DGNQg19VT207+HbmHeiv7EV1YNlpZJsWJmckSD9acb7HkY2FZo0vNNGhH3+G
	vV/csJ4HhVjEH2M3quHbL+akc/r08ewjwVCFC0d/i8GH+NNKOayIHwcxw334855FRnKxdhfcmZW2h
	FkkfdL4902vrL5y4Ot2xAGlZzL7xPyOZeNzKc8vE1bg2bP6n6ONQrAUJdQotkjMd+aHlNeeuVsQXu
	8oGc0yUwd3Sph4UijyqAxZ9hKNuimcXuF3iZJFO5siD9U/6uRNfZRBp3B97TmhKI+a2FoJpxjCsif
	iPkfuHaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJQs-000AQd-Hw; Tue, 10 May 2022 06:33:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJQp-000APY-Pe
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 06:33:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2B92868AFE; Tue, 10 May 2022 08:33:12 +0200 (CEST)
Date: Tue, 10 May 2022 08:33:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org
Subject: Re: [PATCH 1/3] nvmet: handle admin default command set identifier
Message-ID: <20220510063311.GA11389@lst.de>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-2-kch@nvidia.com> <20220411061853.GC14797@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411061853.GC14797@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_233316_019600_76D06F9D 
X-CRM114-Status: GOOD (  17.00  )
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

Any chance you could respin this to actually report the correct
Identify data structure?

On Mon, Apr 11, 2022 at 08:18:54AM +0200, Christoph Hellwig wrote:
> On Sun, Apr 10, 2022 at 08:12:47PM -0700, Chaitanya Kulkarni wrote:
> > -static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> > +static void nvmet_execute_identify_cns_cs_ctrl_nvm(struct nvmet_req *req)
> 
> No, this does not work.
> 
> nvmet_execute_identify_ctrl handles the
> "Identify Controller data structure" from the base spec, CNS 01h, no CSI.
> 
> The "I/O Command Set Specific Identify Controller data structure" from
> the NVM Command set spec (CNS 06h, CSI 00h) is an entirely different
> data structure and needs separate handling.
> 
> I'd also drop the cns here and in the other names, every identify command
> has a CNS value associated with it and these names are already getting
> rather long.
> 
> > +			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> > +				nvmet_execute_identify_cns_cs_ctrl_zns(req);
> > +				return;
> >  			}
> > +			break;
> 
> Nit: I'd invert the IS_ENABLED check.  This saves one line, and one
> level of indentation and just reads easier as well.
---end quoted text---

