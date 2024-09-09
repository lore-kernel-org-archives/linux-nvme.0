Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66A2ECE589
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtA6Yd9gRTtmh/6EGCgInnztqoegsuGjnNZ1R+cU+OQ=; b=opGevW6/wXtuO1TpkN/IlHIUGu
	G8iz5G6YvwI4TL5/27r/wUqbtygfi7PNvQQLgRd/LRF8mE1bFPGBsRPdmrhrslttLOP5QV3YYar8b
	6IVIBc4zZp/mx/+vKcVdFMAnggOQJX8hkInHWJK1LWfdt3bpLBQQBZG4fC2Kp4A702u87N46YAbPN
	t0AtZbD+qfbH/JhbIJQZgRSnkHWXXzx4SWKYKJEBpkKmIRHrTYEbJ62syzRO+uYDdx0Zuy0x7SI8B
	If3MDnKFYujYAsar9XQun+dXGqeSw7UDO0kCV9xDeZiTYoMdwL5eFeDtHVpv0GcLiraIHG5BynqLj
	53uDJafA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snl0i-00000003ES0-057H;
	Mon, 09 Sep 2024 20:29:20 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snl0f-00000003ERd-3GY5
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 20:29:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 8BDC8A41D7A;
	Mon,  9 Sep 2024 20:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4934DC4CEC5;
	Mon,  9 Sep 2024 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725913756;
	bh=CtA6Yd9gRTtmh/6EGCgInnztqoegsuGjnNZ1R+cU+OQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VngAlnNNc9MhFwnO5mIOi9E+KeBVe6/LAOuO7kdvGnlljFpj5ZrP/+z0l1ncQBK+Q
	 RcsCpTlfu3nrVrRFdyapWin9AV6hx4dKXiOJpVRSXI+9qqCYO2ctKO6myjweGBXp1j
	 VcvQxk7KUSCQTGxLNNbILrrKE/sbYZJA5fxDjWU87R+65bSCg8U1K+/O/i1QvvGaNO
	 7bF6prF20NiG1YDFGVhLGp/Xd6jSHuAXb/PnrbdpJTTHA+FFDiz8UoWIPaodb0e0YR
	 6TLCc6CTbMC23LRHmjWPLdJ3lDQagxSbP1zQuObUjS07VcdCudKZVF9cKkyfWAFTek
	 YZ0ipQefXOS9w==
Date: Mon, 9 Sep 2024 14:29:14 -0600
From: Keith Busch <kbusch@kernel.org>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: possible regression fs corruption on 64GB nvme
Message-ID: <Zt9amhUGs9FT5i-O@kbusch-mbp>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_132917_898561_C7C43C05 
X-CRM114-Status: UNSURE (   8.81  )
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

On Mon, Sep 09, 2024 at 07:34:15PM +0100, Robert Beckett wrote:
> - it only seems to affect these 64GB single queue simple disks. Other devices with more capable disks have not showed this issue.

As a test, could you try kernel parameter "nvme.io_queue_depth_set=2"?

