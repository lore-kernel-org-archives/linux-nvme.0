Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7958BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:29:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B22120809
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qR+1U0ER";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iHV+wqoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B22120809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3H9+dwb3a6a6+ZBtb9s1EbZTuzODCHX/mQeG12Wtyio=; b=qR+1U0ERy89pBhvRmQO3y2bwa
	xXZfIZT1le1rCUh6Q5zJrgX4r52ORf2KSja2sU261FOmoObxqBvK6azpyW17Um4nmqpm+dClc9Zif
	W+B/dRT/EZ3cMJFWPoeXJFlbUOdzgxebe9c53dWeiXM1yX1uSOQm99pqYm+dVgs88kHwuXEWYAcs8
	60mkOuHTglwqDWhL0FKylrCi6MdXHTtlLHkq0/bo/4piC7K2FJQHZxWwJHdsyCDXr9jGI+4xMKNEh
	X4o+4yFZDxnis7nZ/Go7KH1Y/OjyUlH9SHCX4kkzVbX1bLln+6b//Swjgtwaia4lb1QtEbP1sFhYA
	bnbkcWCYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0ptF-0008QG-DL; Wed, 29 Jul 2020 17:29:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0ptD-0008Pw-T8
 for linux-nvme@merlin.infradead.org; Wed, 29 Jul 2020 17:29:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Mu6OJOdC0P3joJmalDqfOgVzBKFyyZYaXiANYfUgff8=; b=iHV+wqoHtT87JKzkyzOf0iC38/
 DxkhKsBao0zxki6IH1iBE8HiaQvSUfLCtZvHsraFhSz+D5bf69NlwbPMqGqfIceFKBhAhVNcYha6v
 c5BSc2OYwkJzVUemsqklKunJq/9L8f697IFXnVIwbAbjgfpavDtxOILxvzI9fPqa6cchh9skPESK4
 qWJvj+FTgUgs6SjTHs0cJZ1URztmrAdbkpj6eeCn/nuAv1V7WdD4xvPikY5QQuIlc6JaD4deeEg4G
 BPVyuruT6OeYQsG5/IoFW/Eu+ApHz4mhSpZblfxwafouXhS/YWmpWGlTL/wl0UWoJfzlrquFkym8j
 /xsvO8lQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k0ptC-0003PI-D4; Wed, 29 Jul 2020 17:29:14 +0000
Date: Wed, 29 Jul 2020 18:29:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200729172914.GA13002@infradead.org>
References: <20200729170952.GA21060@infradead.org>
 <fa539a99-31a0-81cc-0d7b-3952721b2b22@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa539a99-31a0-81cc-0d7b-3952721b2b22@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 29, 2020 at 11:22:18AM -0600, Jens Axboe wrote:
> On 7/29/20 11:09 AM, Christoph Hellwig wrote:
> > The following changes since commit adc99fd378398f4c58798a1c57889872967d56a6:
> > 
> >   nvme-tcp: fix possible hang waiting for icresp response (2020-07-26 17:24:27 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.infradead.org/nvme.git nvme-5.8
> > 
> > for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:
> > 
> >   nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)
> > 
> > ----------------------------------------------------------------
> > Christoph Hellwig (1):
> >       nvme: add a Identify Namespace Identification Descriptor list quirk
> > 
> > Kai-Heng Feng (1):
> >       nvme-pci: prevent SK hynix PC400 from using Write Zeroes command
> > 
> >  drivers/nvme/host/core.c | 15 +++------------
> >  drivers/nvme/host/nvme.h |  7 +++++++
> >  drivers/nvme/host/pci.c  |  4 ++++
> >  3 files changed, 14 insertions(+), 12 deletions(-)
> 
> There seems to be more here than what is in the pull request:
> 
>  drivers/nvme/host/core.c | 15 +++------------
>  drivers/nvme/host/nvme.h |  7 +++++++
>  drivers/nvme/host/pci.c  |  4 ++++
>  drivers/nvme/host/tcp.c  |  3 +++
>  4 files changed, 17 insertions(+), 12 deletions(-)
> 
> In particular, this one:
> 
> nvme-tcp: fix possible hang waiting for icresp response

Ooops, yes.  I send the PR with the wrong start commit, will resend.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
