Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F72C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 15:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vque3X2OzXHYKZUW2J8eYMlWTtATvpHw+EddIieKXw4=; b=v+qxKCkCZb+YM3u4x4IkJX34Td
	328agdEqos5qmK/HG0jifX6E1D+KbhcVcLL8mylvTZpehJMnKq/tuQ4MWNOjXWQlkoz04HMQkOvCu
	02lpKnPpCb90qdlQ9QmU1zf8cyx4CqP1CG3rzV1NX2LLvZzLqsFelVThfGfnk6T2K0mS5XcJymWQM
	Oz7x/a1Qkt+GkYxFoA9We2Y+n3AB62jnY0NDQLMuzi9mmt0pKUoUhX4eFWqNIP+WWgoJsQrgYrx4I
	VmDUxivTzj3eLdXVs2xZ/Qkz6KNS3p5ioMRHr/fFDsoHdHaR875csQDrtvqHe4MVI8RnQ8XWYKcc+
	/vpP0CHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0ldE-004P2W-6f; Mon, 13 Jun 2022 15:05:32 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lRh-004KF4-9p
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 14:53:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id EC6FBB81022;
	Mon, 13 Jun 2022 14:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498FFC34114;
	Mon, 13 Jun 2022 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655132013;
	bh=NQZh6xHjNdzpwaFv2ySrdPakiKZzkm09RWg0l2D/k1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLoT2Ck8Coe061ZAGv9gzyVXkGO/1spmWwvf73AnTwKOuPaSvIJTkBVER0qB5S4aq
	 efWsHn/5XvwFquNFISaq9PIJa/5oU2jP/eeOWcjAql73LZHzeUyZJkoS+b+Kybjj0Z
	 4wK8QbbI6+UtFMTw4wsd74hJp3QB0L4Mxqfw9IKPB0/U/2xXd/I4AZ79mVcvXLOESe
	 elWPb80F8ClteSoGS4rG5dMawBEuuyYz1BgPEcKMFcML/l3q+u678ZL1jf26rbAWdZ
	 Ob966AqiPXagICX3eU6g+UEBVk9UuaFZs25rOUramNsamIzHRpUhESn58BODH+zWnr
	 DU7+fuVvjY3+g==
Date: Mon, 13 Jun 2022 08:53:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: add bug report info for global duplicate id
Message-ID: <YqdPaiDGtg+JuBug@kbusch-mbp.dhcp.thefacebook.com>
References: <20220607153029.157439-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607153029.157439-1-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_075337_550708_4133644C 
X-CRM114-Status: GOOD (  10.92  )
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

On Tue, Jun 07, 2022 at 08:30:29AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The recent global id check is finding poorly implemented devices in the
> wild. Include relavant device information in the output to help quicken
> an appropriate quirk patch.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

This problem seems more widespread than expected, so I think it would help to
apply this patch now.

And since this appears to be a gap in compliance testing, I feel I should
report this. I think UNH is still handling compliance certification.

