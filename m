Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D65C47074
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gtr4P2UJwdlPnC0Jvt/4m2XZg3zhCGEMyyhNCP4v8wY=; b=TFa0eWTT/9cAmFwjNXEhqNRNeK
	c/zvuZjtS3SxXWSLVDkMVjxuTFMezETc0N6aVIQQAjXDiX5BdhVLbZA5hsLUvNLZlpDgdZywi1FzL
	yWqmVd1R50BFV0SlDZfBjFfRWz2q6HfHHfYmOjrnCdazHgwI5KXDLblFFhgr6eC+Edu2v7GbO9f87
	cP3+Johm04RK1o2lkXIelVm8ci9m3gFccvPBgXA2a/3dwh1up8s5Owq5Z/XBTVSZrl0Fwv/xVpCu3
	oiD11iNf0Bs2lJn0qroo+IFvGqIUUjrXmPYmOoMT9GF07s5glovGhMrSy3mk9ZtPx43YQUqqfeLr1
	LTvFz45A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKm16-0090HJ-2H;
	Tue, 02 Jan 2024 21:09:40 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKm13-0090EJ-22
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:09:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8571ECE1152;
	Tue,  2 Jan 2024 21:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540FEC433C8;
	Tue,  2 Jan 2024 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704229774;
	bh=gtr4P2UJwdlPnC0Jvt/4m2XZg3zhCGEMyyhNCP4v8wY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLP70o3OHubT822rRtW7TE0wQP3Q6s4zqCWApESFJ5aNC7joMBfRElpZtVkFkxVMc
	 gFgsyINzeWRRP8kJBT8o6jFJ3uT6drbP0wcs7q+3czs0t9OjllHQuhNc3UK4kLqhjz
	 fgo/WonhHyAoGiYJHnyp2wJBuWu3CLpeSV8Zk6aV5AQfh5T5mzjgkatJ8QJi9e1DwK
	 bbQaiY5vEHMDbrTG0qL3EWgQ6OSwzQTR3Y41IMWwRppsGXod558KQvYV+MrPl2xfAf
	 eU/pMFWHTcyjCyDl1YttjhA1VDLc6uxzKYpWZQW156y627b/2fKgK3PMny8AYvn0X4
	 345Mybcp56kWw==
Date: Tue, 2 Jan 2024 14:09:32 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: tcp: remove unnecessary goto statement
Message-ID: <ZZR7jF79Cx6V6m4I@kbusch-mbp.dhcp.thefacebook.com>
References: <20231231065644.23319-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231065644.23319-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_130937_909607_A1655FE1 
X-CRM114-Status: UNSURE (   8.87  )
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

On Sun, Dec 31, 2023 at 02:56:44PM +0800, Guixin Liu wrote:
> There is no requirement to call nvme_tcp_free_queue() for queue
> deallocation if the pskid is null or the queue allocation fails, as
> the NVME_TCP_Q_ALLOCATED flag would not be set in such scenarios.

Thanks, applied to nvme-6.8.

