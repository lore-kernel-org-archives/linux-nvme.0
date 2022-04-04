Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A272DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 07:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FMWIo/t0pBJbFM7SMmzqzD+lvfP1HNZjrbiz7PovWyY=; b=w0crfMhmieiZgPkse870vGbxwF
	7huwmjoNy8YtQCUzGtfSsFTBmS5tYbxa7Rh/JDB+XfA/WLYh4CO3JilAobBCwjp/MQgL0pn+pSnSh
	tVu8Kq+VLjS4cHhUuQeiWc8HxvABJU6Tk2mqmmWf4FpdTq+zwMF+Lz6hzD/aX7Dq0Tb8xr5uSI8Nb
	ryIZnYnHdPq/No8IPKXPnr5YDzdSI8N+DWLvRSR55+GidDNbal6a/4nLYBhL0w/E/whz7W2DVI5u3
	7r3L3EPm+kJI9Y5A4gs3gnBDA5IQxMMUfMy6NUn91FLjMcLrOarf+YWJBX0JSZEcwrv2aUkUfeWNa
	tUWM+GRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbGog-00DWmn-6V; Mon, 04 Apr 2022 07:07:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbGod-00DWjl-KC
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 07:07:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 386EC68AFE; Mon,  4 Apr 2022 09:07:47 +0200 (CEST)
Date: Mon, 4 Apr 2022 09:07:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, pankydev8@gmail.com,
 javier@javigon.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [RFC 4/5] io_uring: add support for big-cqe
Message-ID: <20220404070747.GA444@lst.de>
References: <20220401110310.611869-1-joshi.k@samsung.com>
 <CGME20220401110836epcas5p37bd59ab5a48cf77ca3ac05052a164b0b@epcas5p3.samsung.com>
 <20220401110310.611869-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401110310.611869-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_000755_839404_6E051795 
X-CRM114-Status: GOOD (  10.61  )
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

On Fri, Apr 01, 2022 at 04:33:09PM +0530, Kanchan Joshi wrote:
> Add IORING_SETUP_CQE32 flag to allow setting up ring with big-cqe which
> is 32 bytes in size. Also modify uring-cmd completion infra to accept
> additional result and fill that up in big-cqe.

This should probably be patch 2 in the series.

