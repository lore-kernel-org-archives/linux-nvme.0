Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEC2C32772
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 16:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCLXgqO8EvoOIETpd2/7M1jgGA3/DtyQ52aB1PjAuC4=; b=svCISaYJ6o3WdFfXCyXLQeVcVu
	0QZcGKQ3PqzV4FOdjStTeUPnANhNbbSkZ/d7KMl0v5vOqMqpC9Z7Z+hViIEUF2eaDAd+VPpEjZAWZ
	sL9h3dM/T1n9S6qJ/eALqrHa8hqKMPS9Dmn71Na02sW5PR93Q2vSTUNJABWX4lrUiq6crPfrehQTM
	FSjnIJBRtC6R8R86ZR6k14fbozJgxb/NS22GXBz5XxmspYhKsaIveKoW/FnoTlrr59lW8jofqP6Cp
	E6g1e3D7ATEOPq0JeuCvtoRQmsoRUyCG/6Op3dLHvlB/7K1bUFbLOJ5TS3g4TnSAvbJm+sm0jYLzP
	opQ4zlfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQWXe-007DxR-LZ; Tue, 23 Aug 2022 16:14:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQWXb-007Dvp-Jx
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 16:14:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA24668AA6; Tue, 23 Aug 2022 18:14:08 +0200 (CEST)
Date: Tue, 23 Aug 2022 18:14:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org,
	Jonathan Derrick <Jonathan.Derrick@solidigm.com>
Subject: Re: [PATCH] nvme: don't flush scan work with non-idle request
Message-ID: <20220823161408.GB21462@lst.de>
References: <20220812182147.1564958-1-kbusch@fb.com> <20220821144039.GA3384@lst.de> <YwOcFmTPQeDAl0Og@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwOcFmTPQeDAl0Og@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_091411_823405_E58B9F1F 
X-CRM114-Status: GOOD (  23.73  )
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

On Mon, Aug 22, 2022 at 09:09:10AM -0600, Keith Busch wrote:
> On Sun, Aug 21, 2022 at 04:40:39PM +0200, Christoph Hellwig wrote:
> > With this the flush_work is lost for the target passthrough case.
> > 
> > I also don't really like the double call to nvme_command_effects().
> > 
> > What about just removing nvme_execute_passthru_rq() and open coding
> > it in the two calles, with the nvme_passthru_end call moved until
> > after freeing the request?
> 
> I didn't think it mattered for passthrough because the host needs to flush the
> scan work on its side before safely using the changed namespace. It doesn't
> matter if the target side has flushed out the new namespace format because it's
> not the one creating LBA command parameters.

Well, a passthrough controller is still also available locally, so I don't
think we can just skip the scan.

> Never-the-less, if you do prefer to have each caller open code the sequence, I
> have that patch ready to send.

It's not that I really like the open coding, but it was the first
thing that came to mind on how to fix the passthrough case.

