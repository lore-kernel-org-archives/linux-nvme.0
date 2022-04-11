Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0100AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 06:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SF+Vfjyayu6LNxZzgyoMeZguv6U2fa/QkfpLwthNzXE=; b=HTEN4zApM6MOeisoew5D5QC2gl
	F4DEZjAOwvdNsW6Gz+AlxI0VgxiY9upZpCarmhrWgsHpDX7dVeFBbsblAMtWVbPWJRopDBaccip2b
	1xTIpZc7y+3sBGrI9vmT7s5WTEVCuy+QcP6y191HHeyakjCmeTStpSAVCaXEbmSYBkboZim8XO3wf
	huCpd8whYOmvMgfPy1C4r2PyL5nBXxfog6TkkvOemoJiFapPej5JGlPTUa49ak9sK2m1svKpz/xSd
	7rHhTYLTwfJCURMFj3azObApi1jsIgNWz0dTXK79f/zfe2mOhe+W4t1ajVi9OpIB9H3RVdWurPjOh
	jQOKSwxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndnO9-006tw1-20; Mon, 11 Apr 2022 06:19:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndnO5-006tvG-O4
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 06:18:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 29A7468AFE; Mon, 11 Apr 2022 08:18:54 +0200 (CEST)
Date: Mon, 11 Apr 2022 08:18:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org
Subject: Re: [PATCH 1/3] nvmet: handle admin default command set identifier
Message-ID: <20220411061853.GC14797@lst.de>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411031249.5158-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_231857_967977_FDDC1AFD 
X-CRM114-Status: GOOD (  11.16  )
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

On Sun, Apr 10, 2022 at 08:12:47PM -0700, Chaitanya Kulkarni wrote:
> -static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
> +static void nvmet_execute_identify_cns_cs_ctrl_nvm(struct nvmet_req *req)

No, this does not work.

nvmet_execute_identify_ctrl handles the
"Identify Controller data structure" from the base spec, CNS 01h, no CSI.

The "I/O Command Set Specific Identify Controller data structure" from
the NVM Command set spec (CNS 06h, CSI 00h) is an entirely different
data structure and needs separate handling.

I'd also drop the cns here and in the other names, every identify command
has a CNS value associated with it and these names are already getting
rather long.

> +			if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
> +				nvmet_execute_identify_cns_cs_ctrl_zns(req);
> +				return;
>  			}
> +			break;

Nit: I'd invert the IS_ENABLED check.  This saves one line, and one
level of indentation and just reads easier as well.

