Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F67C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 22:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4tWNO49yRaxUSn0/n0YaA8EXqphEBZlHly9o1vpDrpo=; b=KeoYL5BNPzq25suWoyNRL6Jz0E
	8bjaedguNAhAF+f/D1M+oXgzz01r4y89cFiZA9qwdsq+HdYyhafz2+6F4u4pfmL1guCLbOJTvS+J8
	tfJ0Gp9B/x/E6FZ1Sv6G8xjGJIWS7L8HUxbqVAvYpPaLEbyKY9ql+lrvL9OrrAHGXk0wVW0pG4a+U
	vcoT8AMRt1NBKNx+G+GTapWxY60aLwf+8KKqUZrmxG/rVYY5pHVVEU1Z7lYYJK6ZKH4NCcrMrnqi6
	Fg7/RbBYtLl/nmhgUCKWeeXYpJtlLUJfbXAfRV92gMYtzkguTzPhUhwwH8NV/jiwJOH7bPvgX1NzI
	qbpyx61g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDXKk-0000000DMjp-3fdU;
	Sat, 01 Jun 2024 22:36:18 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDXKh-0000000DMjD-0se3
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 22:36:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D0A3CCE08CC;
	Sat,  1 Jun 2024 22:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44769C116B1;
	Sat,  1 Jun 2024 22:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717281372;
	bh=4tWNO49yRaxUSn0/n0YaA8EXqphEBZlHly9o1vpDrpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HRMX44sv00rOCbSAF60lPGH3JRZzhEsoDNFeng5E6garNf7q6rEb+1GW5qvaSCCaU
	 UR7SHXGQZ1Ze5i1UOo4MLPW/aALT+oC93AFcPPBPXo7cKvdRuleZty+tvjcHoG/JC0
	 m4lkKezVuhfirWKmSWRFqFhaZgF1i8Dh82hiSbCpNR4BqAiOSStrCNTA05PQuaiDLL
	 3xecdOQiaikuyVm5SnmU6jUS9jB+N+GtO8wXtrrJr/DjUVx09q+PrFRSatxQDQqRYS
	 bAFjqMVinp/g+4iFnNcFP0tskVaGsMMxcLmT3n5PKQNqrUX9BcSHNC10ZnJH3yqjT/
	 LzIJTYpQF1fZw==
Date: Sat, 1 Jun 2024 15:36:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org, dhowells@redhat.com,
 edumazet@google.com, pabeni@redhat.com, kbusch@kernel.org, axboe@kernel.dk,
 sagi@grimberg.me, philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
Message-ID: <20240601153610.30a92740@kernel.org>
In-Reply-To: <20240531073214.GA19108@lst.de>
References: <20240530142417.146696-1-ofir.gal@volumez.com>
	<20240531073214.GA19108@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240601_153615_532949_1528C7B7 
X-CRM114-Status: GOOD (  10.60  )
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

On Fri, 31 May 2024 09:32:14 +0200 Christoph Hellwig wrote:
> I still find it hightly annoying that we can't have a helper that
> simply does the right thing for callers, but I guess this is the
> best thing we can get without a change of mind from the networking
> maintainers..

Change mind about what? Did I miss a discussion?
There are no Fixes tags here, but the sendpage conversions are recent
work from David Howells, the interface is hardly set in stone..

