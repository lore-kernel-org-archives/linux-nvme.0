Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DBCECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFe3/uuJPsJVHDvJKnO0e2bhgWhWTbEiT41YS0XuBv0=; b=cajhK4wI1xOd5tyZgsf9hoUkmX
	3K4a17xNeT1+kXcAVsBY7flw0Zc82oMtlsRmonkrmqJp7M7Kjp2PHjfwduki3ol4sgnf4aT51a0LQ
	BlnLdriBA+UQexiQjZLkUmWV8xd63eVFkN19datbUOMpOK2RZdiNEQYCfJOf5tkKFdNUke0t4bQ8I
	Kf2Gk5gWAdjH6/qIyvanIEDLoq5f9GTEauuVx6PuQ73Xk5Yo4jKH9KFSpoRiBWVsnsawdljnayBpp
	rqf6hun0QzC+zvc0Af8GG1jiuj7qaXfC2yrsaX2tJmntWIqwrFCPliHLf8GEFksO7hKypWhaeZ2qV
	4olbMuZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooVdK-0026Q4-DT; Fri, 28 Oct 2022 20:07:14 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooVdI-0026P6-28
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 20:07:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AB5BEB82C10;
	Fri, 28 Oct 2022 20:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B294DC433C1;
	Fri, 28 Oct 2022 20:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666987629;
	bh=ukl4ESb4zsWIUKI2udyqhnlNUnnoWYmumx1LImiklhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WreZa3a6bIZIWA8ifR9CB10PKN5+FYbZn/yW5MeHjHphnwnBmQlHoJBYlbEt9JqV8
	 OwbFawXBQnz3y77LPGjD6LNLQBoJYXB3/aMoj6X2gq0ht16yqgz7Dv+1d6uLChx8+M
	 ZV7gnKPuXGT0Ng2X4CyHekiHCKOkF3DzkYL42k1/j0hep69Ob0ZwfgoMPXRP4blJNv
	 U0uiNx3SymQ7EFhPj9Ox8ihJ7DQ1KaIwgArIZ/u3Ui9RPPc8tTn9nBwo43jKKZ+PqH
	 NZav8wAUVJCFydhOCYA3WXJdmhwWJGiH5DAnnlq/Jhlmc6bgTOOf8xmPXmjUMLvmQ7
	 0nlMgcGjC8CBA==
Date: Fri, 28 Oct 2022 14:07:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Keith Busch <kbusch@meta.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"joshi.k@samsung.com" <joshi.k@samsung.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3] nvme: quiet user passthrough command errors
Message-ID: <Y1w2aqGMDpmLaRER@kbusch-mbp.dhcp.thefacebook.com>
References: <20221028144435.1613982-1-kbusch@meta.com>
 <5D2DB5CB-CF49-480C-BC6E-30EA28877F5F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5D2DB5CB-CF49-480C-BC6E-30EA28877F5F@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_130712_262843_4F65F4B6 
X-CRM114-Status: UNSURE (   8.55  )
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

On Fri, Oct 28, 2022 at 07:08:51PM +0000, Alan Adamson wrote:
> 
> Since all requests (not just user space initiated requests) call
> nvme_clear_nvme_requests(), all requests will set RQF_QUIET, so no
> error will get logged.

Ugh, yes! I even said this needs to go in the nvme_init_request() and
then proceeded to botch that in the wrong function. Thanks, I'll send
another version.

