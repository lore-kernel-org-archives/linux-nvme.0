Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A46C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/3kG28pykc52lVoRlVBzIyp5t5ScEYpCDExlpfilTU=; b=B7paGcUOKg7ayRw3/bLS2BdnpF
	xNL/q7urP+OVhyKueNVOO4jpK1EIkJZ4LXA+r90zFtED/fJ+rqA9q6IH0RBQG1SECcm0QIWCop1gB
	Rp4AfdECYW6vyc8VtySk6xKiVn9Ouexn9HJ7BIel589L0YcMUKZUjlYTY95gY/TMbi4kaMNXuhvAU
	/HOLdlSgZUJxNgj7du2XgtmcJFz9RYn3o+Lptq5JZXvCGsvC8X2mFzIX8jhxlcxZvyG25rWGEKNgu
	TLoOKNEo8mn/xvh7t/5n+J+gfUy2fDAQyq5Bjhi6F1uEo/fYTypneAs6CEZfldu5iXL1V/0NKnCpr
	5DrHPTBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8eRI-005lxQ-Uu; Fri, 23 Dec 2022 09:34:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8eRG-005lpl-05
	for linux-nvme@lists.infradead.org; Fri, 23 Dec 2022 09:34:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BB5F68AA6; Fri, 23 Dec 2022 10:33:52 +0100 (CET)
Date: Fri, 23 Dec 2022 10:33:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
	kbusch@kernel.org, linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221223093351.GA8028@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de> <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net> <20221222160920.GA10193@lst.de> <87zgbfma5w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgbfma5w.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221223_013402_244209_782E1E83 
X-CRM114-Status: GOOD (  18.22  )
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

On Thu, Dec 22, 2022 at 01:54:35PM -0700, Jonathan Corbet wrote:
> I'm not really a fan of adding more top-level directories; one of these
> years I'd like to try to move things in the opposite direction.  That is
> a battle for another day, though; for now let's just go with this and
> get the document merged.

I though about that, but could not thing of a good subdirectory.

> 
> That said, I suspect you'll add a build warning about the new document
> not being included in any toctree.  Fixing that would involve adding a
> basic index.rst to the new directory and adding that to a file like
> Documentation/subsystem-apis.rst.

The new document is included in
Documentation/maintainer/maintainer-entry-profile.rst in this path.

I also did check for new warnings and did not see any, even if that's
a little difficult with the rather chatty shpinx output.

