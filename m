Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEC1C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RsA38Zptu7ueFrvNXLIEQ+o4qJqLDn69wpgS1KSe5o8=; b=LQKtb2d3XEYfMoG7aeaeIoRGDF
	DFq89abtO7vctVHaG3TvvQ2WN+CGcu/byjVj/qyYWnHjcpDQvwbTs73edjaXXba2tMpsXbmVxgfWh
	4kN2zwJVNetL7DUA6v5wT7bLZeQzVe58uU9X0TL57EfPUG8Yl/4Lww4sBNTfQIX5wIxszoYsFVaPr
	aq4va/gwA6qARUmUCYm2KI3YiXGyYKPEoI+YN8Is0aNui0l91T0XcYmSbbxsOb5f13JRQSbZv6cvq
	Nk28s0j4wh1khN/eprvm1h8V7x+7dBuHJdh0tnxrsVeJo07PtG3RtO4ms3MqAkq/D7MaQZlKHUomm
	CGppFAYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoRj-007aEV-CJ; Tue, 18 Oct 2022 15:23:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoRR-007Zz5-Tc
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:23:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id DA2F0615D2;
	Tue, 18 Oct 2022 15:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CB6C433C1;
	Tue, 18 Oct 2022 15:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666106620;
	bh=Yo44F3LZmyIrl0Wd6y6m2ca1kq7fVPtyZd8arSAVZwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sw3aSRIeNtj0sqT0P8TCpkJC+Kg2chMzJrRxv5ieHzwkmOD/kf3tq7mhW8xDk6biU
	 OQ3aUCBXSth9ep3snUETnofOrEQF5VOvHFy9S7BKP/tZPM7ZMHfG/hJfGozsZllrd4
	 mSQBnAwzBa7F78zqRwUcKNcCevSeUoqoMXpxCsJAVrELgObtKZKaPkrIfGca40GOOP
	 wJc9CWhs36OUuLA2hBU3bkZt0ptL3Q+JXB2ZIYpn4jzQdlc9IdH295Hg81YDPXOjwf
	 hIXTtEYSMdx9EGuiRj7EDrsdQmz+6tGn7n/h7wUj6fqTgGZHlsXpbVaumM9UNF9pU8
	 no40EOBTh09lg==
Date: Tue, 18 Oct 2022 09:23:37 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Wagner <dwagner@suse.de>,
	Alan Adamson <alan.adamson@oracle.com>, gost.dev@samsung.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: ignore starting sector while error logging for
 passthrough requests
Message-ID: <Y07E+bH0E2s7xKWN@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20221006091054eucas1p1e4113b6dfd108907c2cd5ba7127a3f92@eucas1p1.samsung.com>
 <20221006091053.36611-1-p.raghav@samsung.com>
 <3f6f41b5-c743-83f7-a8f4-ab3ee2f16b3a@samsung.com>
 <20221018144535.GA20131@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018144535.GA20131@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_082342_024789_4A8A62F4 
X-CRM114-Status: GOOD (  18.84  )
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

On Tue, Oct 18, 2022 at 04:45:35PM +0200, Christoph Hellwig wrote:
> On Tue, Oct 18, 2022 at 03:48:57PM +0200, Pankaj Raghav wrote:
> > The final consensus in Daniel's patch[1] seems to be adding an opt in to
> > log error only for admin commands, and logging error for user IO commands
> > will remain as is.
> 
> Hmm, is it?  I'd think even for I/O commands the opt in makes some
> sense.
> 
> > In that case, should we reconsider this patch to avoid printing a garbage
> > value ((sector_t)-1) while logging error for IO passthrough commands?
> 
> We should probably do this, but it should probably go along with the
> opt-in for I/O commands.

What's the preferred opt-in mechanism? If we want to do it per-command,
we have an unsused 'flags' field in the ioctl structures that we can
start defining options for these kinds of things. If we don't want that
level of fine grained control, we could set it at the controller or
module level with a new sysfs file, though I'm not sure this warrants
creating new exports there.

