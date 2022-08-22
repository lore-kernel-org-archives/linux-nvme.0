Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1CBC28D13
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9EV0zqICrkuOhqHkdJV0QflueyFmDGA5I1mTY7Y9QzQ=; b=Lx8iwSXDcqWHPU4BajdtXn/YLv
	9HqRth3+n0/l+SaloE68RRwRNCrMPFkNKtpBftP4RMTswsZ+TgA0EZ8DJiNbDw6HqYiqmiOWbtUjD
	zkLIrmwI5u/z4SpY/0zj5f+OJ0uGlM91rqojgqb0DPuUnsqgstrBEyg3oA2cqVe9akmHDP/DPO+jR
	EXUIpyx/5WY9ExjUzUzEnwsS8TS0o6yJCAD4PxLrEi+rpEvpL+fbyNwMskk+4Y+KAYHjkXibeRZAs
	N6r+C9BRGEG30hLJLijPkADqNd4xiccmQU2KbpQKRpgj+MdwHkaNwltCffUmk/KQD3JnBsYeMCHc8
	+KI5DauA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ93F-00C0IF-BU; Mon, 22 Aug 2022 15:09:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ93D-00C0G9-Ae
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 15:09:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 09F6360FC7;
	Mon, 22 Aug 2022 15:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17616C433D6;
	Mon, 22 Aug 2022 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661180953;
	bh=dtFr2FXzqBkHvUpt1QniFB0+ylMSEfkkW1bk+O5Rzzs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RpH8niHCTuLHy0BfPe3k1xPNv2Ch6dMpmvsgQx3Oks3Gy5NQ+DIBkD+Lsk3Zq30bp
	 G91p7zC97f6Do9L24poCp9OC4xwI/BjHUbNARpnqJvMNWlucRo1fTKIvswUqd09exO
	 inSDJ/yn43cDWw3Bx2icY1eoGhjssQCcW56J4Fx/Ocy1QaOqADAM5bfQ5jqAGVnS8w
	 Rb/tQNW6j4/8RGfI2MS6Ek/d5JeAIXfFh9tfyGfOj9D4PQ8gVyZJ4souAZb5+833Gx
	 vFgwUr3JwBj2dHNwPJjPXw2FN1tO4adgCPmL33rRw+Puz6D9AAgDHFupg6OaYVMxBB
	 dNKNtrJKKeLgA==
Date: Mon, 22 Aug 2022 09:09:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	Jonathan Derrick <Jonathan.Derrick@solidigm.com>
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
Message-ID: <YwOcFmTPQeDAl0Og@kbusch-mbp.dhcp.thefacebook.com>
References: <20220812182147.1564958-1-kbusch@fb.com>
 <20220821144039.GA3384@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220821144039.GA3384@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_080915_431459_812F5B90 
X-CRM114-Status: GOOD (  16.03  )
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

On Sun, Aug 21, 2022 at 04:40:39PM +0200, Christoph Hellwig wrote:
> With this the flush_work is lost for the target passthrough case.
> 
> I also don't really like the double call to nvme_command_effects().
> 
> What about just removing nvme_execute_passthru_rq() and open coding
> it in the two calles, with the nvme_passthru_end call moved until
> after freeing the request?

I didn't think it mattered for passthrough because the host needs to flush the
scan work on its side before safely using the changed namespace. It doesn't
matter if the target side has flushed out the new namespace format because it's
not the one creating LBA command parameters.

Never-the-less, if you do prefer to have each caller open code the sequence, I
have that patch ready to send.

