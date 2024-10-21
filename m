Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28FCD15DB4
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 15:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RVmtRko+d5tlIuSRfckw03QU903Xjd0IaTayqWFaP2g=; b=gVsDAu9c+t3eGICxbMtOC6g6Uf
	7XeRbUCO2K13M7CslK36P8/114e10Pwblsfpbf4e9tHsK6XnMWlU7gu1yo5cQtCPVhqyQAbCSmvSE
	X6tjVcmlk07znZC6g+B85JYjKxSSVRw+zjHXeraUcVsn1RrX2ba7dt2ZL9xE5TsWuiciBzb96gVLL
	bYQpCar1bBa40XF4I0EXmuGWuGWx9R194lERNBwlWzWtCq101mou2SUg9lTVyIFPLRhHAsRHXRMIc
	TsA4tjd3Yaz+T+ActLFz81LcLsDY9M7u7fKwoFky2jmcvL71vAz7k6DzL/FEd+EN2SCVB/K86hKHy
	o+AQP/eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2ujD-00000007sDq-1B5W;
	Mon, 21 Oct 2024 15:53:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2udM-00000007r4I-1BEp
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 15:47:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DB544A435C9;
	Mon, 21 Oct 2024 15:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF50BC4CEC3;
	Mon, 21 Oct 2024 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729525670;
	bh=eoIDTD70jGHK8rQg1tI8OpdE3wiIkzDwBZrBOvTpqTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uJ6O3/Eg6LuZBVbvEhmJGmq5UhlraJjHuFScrTmXpEbKNqxl3qPWCqW9og//FdOw7
	 hfp0NqrPLYmgYPdeXpezpTfJ04KOnUCv9G2+czs7PPHV9dRShcsBk0Q0WxJs0GNuN8
	 UkrpQv50sacx/D8D/8C+f0jcf6P3LDBdaNzUpIRwJSpQvs865Cy65GK9ctVP75vriQ
	 pDZLbes5RePbk2QSNN9Iy3AUxFmd/e7JxGwLvMQkGwvigIA7axQxf1FoApGbxeavpO
	 Sb9UIt0xyMQQgHX4r+mr52vXegSrJlMS1/CVz9gmB5OVwVuaP9K70NWGxZICWFwf+g
	 7RwmJfZ2RfFfQ==
Date: Mon, 21 Oct 2024 09:47:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv8 1/6] block, fs: restore kiocb based write hint
 processing
Message-ID: <ZxZ3o_HzN8HN6QPK@kbusch-mbp>
References: <20241017160937.2283225-1-kbusch@meta.com>
 <20241017160937.2283225-2-kbusch@meta.com>
 <20241018055032.GB20262@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018055032.GB20262@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_084752_415625_66F5AD48 
X-CRM114-Status: GOOD (  14.17  )
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

On Fri, Oct 18, 2024 at 07:50:32AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 09:09:32AM -0700, Keith Busch wrote:
> >  {
> >  	*kiocb = (struct kiocb) {
> >  		.ki_filp = filp,
> >  		.ki_flags = filp->f_iocb_flags,
> >  		.ki_ioprio = get_current_ioprio(),
> > +		.ki_write_hint = file_write_hint(filp),
> 
> And we'll need to distinguish between the per-inode and per file
> hint.  I.e. don't blindly initialize ki_write_hint to the per-inode
> one here, but make that conditional in the file operation.

Maybe someone wants to do direct-io with partions where each partition
has a different default "hint" when not provided a per-io hint? I don't
know of such a case, but it doesn't sound terrible. In any case, I feel
if you're directing writes through these interfaces, you get to keep all
the pieces: user space controls policy, kernel just provides the
mechanisms to do it.

