Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26136C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 20:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAOZOlpzE0Xm1wcPXJFjZJKELfuapsjqBWU2wgxOpRQ=; b=15PcxNB6HlhNbrayFyXGaXz76/
	QMkED+y7M2VrxH/f/DsW1PybH6wGgYgPS34efzKmYUy+GgaWa0mxWNsX9t6FCw0LaA58uTnjkzUuy
	EHzkerz6QQWYptfpbib2g4RsiHrGNz3j6vsGL+PVlOA0RlJloX1llFR9r/yYjvlZheK4K9mg4Zt4R
	VmLiCcP6Tv+jkV/w7UCTGiD+R5Z5AvGsCYTwl9etT54UMtmAwMXm5BmCqQd/HRb8opTLv2JPUO8cF
	Ew0J8rc3h7GCwwVrtxXnDhzPJ8fy+jLIjALzd2SZ8w4VjcgyWmSBwALFX99UR0TXvxYhM3lHswXS0
	F7CUQnGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOh6-0000000DLVA-0DqU;
	Tue, 06 May 2025 20:15:12 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCL9O-0000000CfiY-3VSS
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 16:28:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E6D98A4D6B5;
	Tue,  6 May 2025 16:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDE0C4CEE4;
	Tue,  6 May 2025 16:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746548889;
	bh=l+1Yy2LMZkqI2UGfxB7y8XrZgZuxgFkcvjxpPhz2zqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gIhl+hDVvP+N5Eh4G9K1CizeYtMvMU01L+FIsjtrktrJ9Ebu4F7MtceO//hyZL4fp
	 7GFzJjO2G1GpkHuA6FzORzvdhaNP5QFyMBp+u507XpkQY81nxLtCYm/F7IZaiH+J9G
	 cK839Cfq48TW8EMmD4eK5euk5pRgJHXHV+jWypZlEL19olcTCZglL246EiwD8TAd/y
	 4J9v1IQ5MRD2iF0reTzV7Mw8FtLdQEZqqRP+mvl8DcDV3JMHG9qU19Z1EqAHVk8+lb
	 WCEap/Nrd6PDEHPo5sZruY3WjtxbfpnukLOiD3EXtcuNPIrVOJon5yV6rRxYCofZ/K
	 SSiqGymysJW/w==
Date: Tue, 6 May 2025 10:28:06 -0600
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	asml.silence@gmail.com, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v16 11/11] nvme: use fdp streams if write stream is
 provided
Message-ID: <aBo4lkbeq1IU3RDU@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20250506122653epcas5p1824d4af64d0b599fde2de831d8ebf732@epcas5p1.samsung.com>
 <20250506121732.8211-1-joshi.k@samsung.com>
 <20250506121732.8211-12-joshi.k@samsung.com>
 <CADUfDZrWstGcx+EqsmaQvSJJrMAK-Ls+HtGyS8j3okZQ+N4FKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUfDZrWstGcx+EqsmaQvSJJrMAK-Ls+HtGyS8j3okZQ+N4FKQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_092810_934489_7AA1649B 
X-CRM114-Status: UNSURE (   6.12  )
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

On Tue, May 06, 2025 at 09:14:19AM -0700, Caleb Sander Mateos wrote:
> > +       head->plids = kcalloc(head->nr_plids, sizeof(head->plids),
> > +                             GFP_KERNEL);
> 
> Should this be sizeof(*head->plids)?

Indeed it should. This as-is overallocates the array size, so wouldn't
have easily found it at runtime.

