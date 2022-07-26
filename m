Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E82C04A68
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 23:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guB1cTIS1RRgHxlh1DGoPy13IP31UCciVViLjNYzMvY=; b=GtTpisugCStgaZc63Ga8WoDKRk
	H2joDiEWCVILAbPRtgbjCv3RTwthYr+k+5MILndXkFxB95JplYJ+bUXMlVntdw8ayrGGuxmKohcAE
	OikNU4EScS1ikN4jVPf+OuvjZ4nXbpuHJxe5AmQyrjvecIRdch9PKuamNVMVqY2ETouB0byETS/75
	WAbP0LTCnxrICPYfC+P8bn6wJtrB5GrndBIwNsvaLQpj/B+oS7/FKHLMpcRbbyTynZpk8FDAEFMpO
	ciEcATE3/0iPsCvqUrbpJ5fRE6hjB8cd4wHKYGqJp1/n9jduoamChmtHOXISkcChBUEyVw9930plw
	NrDSE+tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGTjX-005aqS-K9; Tue, 26 Jul 2022 23:12:59 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGTjV-005aoT-WB
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 23:12:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=guB1cTIS1RRgHxlh1DGoPy13IP31UCciVViLjNYzMvY=; b=SxJjZiwzslnm81HdqmigkghWkM
	3XFhpuDVJ/UAvWdRaU6R976S0ZfSdaH30q6gGxwGJJojPWqJzw+wyZTxMnj0dALQkgP958DK+rv9R
	80Usq58V53ImrSOk5Uu7QM1uxo1haVbOtDE9XAfQB6z42vW/v6CtLM3gMrqTp7cXOpN/SH+sSCOUR
	1P/TfaIzIenEGEIJr/kmNj41a1zmRQHRSKtHFvi0enEG4cUGLQKKSBc2DwotQPqSK9jKTtIqCNJHc
	vdhaasYibAX9CKzXmwXj3IDwNXrF9dnEK3ZSzHFkTOlb0xnItbN6Kn9Mxas3jlvFj5q0OV1Wziglo
	akfijmVQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oGTjR-00GALr-2x;
	Tue, 26 Jul 2022 23:12:53 +0000
Date: Wed, 27 Jul 2022 00:12:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuB09cZh7rmd260c@ZenIV>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726173814.2264573-5-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_161258_054915_C0A455EF 
X-CRM114-Status: UNSURE (   9.00  )
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

On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:

> +	if (S_ISBLK(file_inode(file)->i_mode))
> +		bdev = I_BDEV(file->f_mapping->host);
> +	else if (S_ISREG(file_inode(file)->i_mode))
> +		bdev = file->f_inode->i_sb->s_bdev;

*blink*

Just what's the intended use of the second case here?

