Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD06C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VPzEcAe1055c5n/y9lEnWF7wl7OtGWrTFZ4pjtY+NWQ=; b=yK9QHldhr0GLvkuYy50vuY8Gr9
	eTPKGyWf5B0iAI4TEnjlvnrwC0/X4eTPB5nJSX4wvHrjO0QVrImkx9utNJI9bkr7xrngoGd6dVU+Q
	xThr3RgM5K1DYxVV4j3bGfNk5THxu8MthVwWSY0Mt/gHQMd/LK39Oyynpj/USLr5P7cJSPgM/Znws
	03CUkpYdmF6paMBidPayFOIux7PRobERxQpG2wRGxR2Lbb1Nrjjy+/EQ5TEtjHXJhXJsT1fyQf1Dd
	Y7RNmsptgSXrIc+WOJ5qT9fU3MrlwekxDFRzit1Iv1mgpWkxps/zCXIN06SWFeH04uWT/HnTEvaaa
	72jBKXWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0mpD-004hZo-PA; Mon, 13 Jun 2022 16:21:59 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0mpB-004hZH-4I
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 16:21:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7F5CEB80ECA;
	Mon, 13 Jun 2022 16:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D886CC34114;
	Mon, 13 Jun 2022 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655137314;
	bh=gcImXZIQIwAHRHwODe0Ul+Bac06+nl5wFW912tEH008=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iN5j4+5WotasTUOVFIgakF39v5cTGZVzdaNRK8CsQ6HjXnU+cFPjJZh6T0CcTMbwk
	 txzxb97WOu49Fj6XexiFzhqfyFrZGxmV5Hc9xulOGMbyJR1lETRM5zad8r85o2b4ka
	 vkNuKSfOhwRjSwlGJWCQjvWH9ExYyaDMnPP4atXGKnqW3hC10LUXsWXJJURx2zLs15
	 dChZ+fa1yV1lqwQkFkU8Lr/JS5dJBp+r/U0nMIyVXc5cBx1wV7E7n3E+shyP8imVVI
	 sN1IiYlFK5MIK/2jnzjjkBj3DcG9RCDLDWZ7iZLsws5oRYn/w84p0+oY54WKqPNXpF
	 uYap3Nfug8iLA==
Date: Mon, 13 Jun 2022 10:21:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: add bug report info for global duplicate id
Message-ID: <YqdkHwC52qRBt8ba@kbusch-mbp.dhcp.thefacebook.com>
References: <20220607153029.157439-1-kbusch@fb.com>
 <YqdPaiDGtg+JuBug@kbusch-mbp.dhcp.thefacebook.com>
 <20220613150432.GA6424@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613150432.GA6424@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_092157_361685_38E4EB8F 
X-CRM114-Status: GOOD (  13.98  )
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

On Mon, Jun 13, 2022 at 05:04:32PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 13, 2022 at 08:53:30AM -0600, Keith Busch wrote:
> 
> > And since this appears to be a gap in compliance testing, I feel I should
> > report this. I think UNH is still handling compliance certification.
> 
> UNH provides the test suite, but the specs are handled in the nvme
> interoperability workgroup.  I already asked them to test this, but
> nothing happened, but I think you asking again is definitively a good
> idea.

Message sent, and I cc'ed the email you use for nvme workgroup discussion.

