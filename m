Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE738CCA47F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 19:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TC9V6WH3/mO28sVNiLYs7di1XEMTRlaFpLDgBDwbNkw=; b=ue9Q02YJP1k/dPRugJkrjTOozo
	lQOIHOxRAaruX/zkgqf0F/grX3Fdz4KUpBE/PFnEESYsmeVZSPnd5mN1DA8dTfEOXzYzqST9EQof8
	P+Vh59gTrewCrPUALBRwYcKdechqbtPKr5QxfAEV1lv6MzrY8pscjIV9nL0IVYWSEw0QktQvY4c7u
	pf6W63OVeqvK4frgAUARgucWgercGpxKePc35IBYG3dqKMr3RQ6Oefz/yPjFQuzOcvQ2vPlwu+P0p
	E3EDBBQCh6LFy4WPGsi0gzDOrXhoM+2p1mkMwgmJgk6YOzKnic43Nd/hqmcBVMvXTos0WHTu2CJNL
	j6E4JB8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o46JW-00C7Fo-QB; Wed, 22 Jun 2022 19:46:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o46JU-00C7F5-6F
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 19:46:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B90BC612E6;
	Wed, 22 Jun 2022 19:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAECEC34114;
	Wed, 22 Jun 2022 19:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655927214;
	bh=JImrhOhVa9HkUpaidUpkGGhBgXp+neHhTguaXVeNgtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKXw8XQOOBWQS1mdzCjhH+cEip9BBCY/2Sx9m9V0G5tL5OLKLLLVX06LBjQRC13fM
	 LQRSh/8EJfkDttrkJFiEDBCW/IHPYkv0J5jWPsJmtvPQChwkz0YcvmpYgx3T3KSsS3
	 pDUudIyy/mpOA+G0nZNzADRpaGCVNH1+zFgOmTbOTG0cd3AXpKqh2UXB52ScW2RfJw
	 A1WScjNn3keGZmYSPQne/bloXHgsUwnih+/yPwERFds4xV954SzEbxQSHwBV07Q9it
	 DYvmRd36205N4hK1svN4ROqw+MH2g+gQXxHdSQ6ivkhogZBQBHjWkRfvstpV6u0D/+
	 dNZY2C216GqPg==
Date: Wed, 22 Jun 2022 13:46:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Leo Savernik <l.savernik@aon.at>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] Introduce NVMe quirk for multiple Micron MTFDKBA2T0TFH
 SSDs
Message-ID: <YrNxq0E1xcLjVKOD@kbusch-mbp.dhcp.thefacebook.com>
References: <af7628d5-2b91-4fea-a2bd-56825dbcb02f@aon.at>
 <YrDs2sPzH4RPzhGI@kbusch-mbp.dhcp.thefacebook.com>
 <86c55fb7-ef0f-4c3d-82cb-9d655f17baf9@aon.at>
 <YrLtNVIhLMwvfMZZ@infradead.org>
 <4c94e275-34c1-43a3-9ffd-f616c6b6bb2f@aon.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c94e275-34c1-43a3-9ffd-f616c6b6bb2f@aon.at>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_124656_292762_36B304A0 
X-CRM114-Status: GOOD (  12.76  )
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

On Wed, Jun 22, 2022 at 09:28:44PM +0200, Leo Savernik wrote:
> Am Mittwoch, 22. Juni 2022 12:21:41 CEST schrieb Christoph Hellwig:
> > The patch seemed whitespace damaged.  I've manually applied it and
> > use that opportunity to shorten the commit log a bit.
> 
> Oh, I'm sorry! I took care to send it as 7-bit ASCII but apparently it still
> got mangled. Thank you everybody for reviewing and your efforts!

It's no problem, sometimes the code diff is the easiest part to a commit. :)

Christoph,

You may want to force-push an update since it looks like this patch is missing
your committer Sign-off (the bots may flag you without it!).

http://git.infradead.org/nvme.git/commit/aa5f8f971c1c159ec444bcdcf6a5ec07a8d10d2c

