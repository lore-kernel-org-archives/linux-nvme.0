Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13009D74963
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 05:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Zejj42rMQ3FXkWIlwn42KQgZnUw7MF5Ce4nWaFSAR4=; b=D3XpQmXwMFLtO2BJvde4023O6x
	f1KZ40Ki840URcLYKOWpHBuxVlkZCVz79MxnTdyn6aYckZ73B9v8YdDQUiRtmcviEXqVHHbeyv9E4
	eiLXPt4jMidg3g7/OjujqxPVYHW5ClLgldPq6R8jdQPFtsYvfEsc0V+yObolaOJw5LNg+N0DxRSf9
	bm3QRHBKIYP7th2sV5tYVMDatEK+0la0Pdgk4yGDdHuFdR7Ocjg3Sr6u5ubfH583/Oz04sLm8OoJL
	XbVb174MNG16CCIhBkuhz7bosGYIWFnWd41zno9MDo5xPfjnCn3HAZ55NtxddDNJhPCsI+Hz+HrU3
	hgd3cZzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t60wn-0000000GkYR-0pPH;
	Wed, 30 Oct 2024 05:08:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t60wk-0000000GkY3-1Ozb
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 05:08:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D3BCE227A8E; Wed, 30 Oct 2024 06:08:38 +0100 (CET)
Date: Wed, 30 Oct 2024 06:08:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	asml.silence@gmail.com, anuj1072538@gmail.com, brauner@kernel.org,
	jack@suse.cz, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 06/10] io_uring/rw: add support to send metadata
 along with read/write
Message-ID: <20241030050838.GB32598@lst.de>
References: <20241029162402.21400-1-anuj20.g@samsung.com> <CGME20241029163225epcas5p24ec51c7a9b6b115757ed99cadcc3690c@epcas5p2.samsung.com> <20241029162402.21400-7-anuj20.g@samsung.com> <ZyFuxfiRqH8YB-46@kbusch-mbp.dhcp.thefacebook.com> <e7aae741-c139-48d1-bb22-dbcd69aa2f73@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7aae741-c139-48d1-bb22-dbcd69aa2f73@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_220842_537220_5BCA94E8 
X-CRM114-Status: UNSURE (   9.82  )
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

On Wed, Oct 30, 2024 at 10:35:19AM +0530, Kanchan Joshi wrote:
> if (sqe->meta_type)
> {
> 	if (type1(sqe->meta_type))
> 		process(type1);
> 	if (type2(sqe>meta_type))
> 		process(type1);
> }

Ensuring that all these are incompatible, which doesn't exactly scale.

So as is this weird meta_type thing (especially overloading the
meta name which is unfortuntely) feels actively harmful.

