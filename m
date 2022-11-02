Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C245C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ff4znqwIZoXohUvIKNT0EbfCtlyW/3kc/qOs3Vln9I=; b=kF6Akm9aaeWVFGNwnZjrK9ZLNi
	moNS6XcRFN+LUwmABC6Zlwj4v396/viOnDkEmoFWVwFs6z8awXMdF4TUvpflTsa20PzOAIA7DqIDD
	DuVOyOAvVTS0SCb+Nk4Utf5K1eGxKIABH6/jqHZq9c4wCgrpx9vREA9iFxvXfKK13fwOuaxhhYPdE
	tt3IUm0c6T6XAq7rBGe6E3gLPGXUG1/d4R0YV5MjC3kSYEtoeFWFFJ/xsOyndzyqu4tWFfMLd7HqW
	yunx1kkaUca4JPxD6E+12x9NrqKlamH6oxg4V7yvNpeN+KFxexI0M9giVDrO5aFAwUgGFNDnGF/jj
	HdazZ0ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7oo-008Yj1-OM; Wed, 02 Nov 2022 07:05:46 +0000
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7ol-008YfM-2Z
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+ff4znqwIZoXohUvIKNT0EbfCtlyW/3kc/qOs3Vln9I=;
  b=XYoxH/inCwePyGL2wNXhyAEmag8/xhSQk/q0P4Wl3tioL/4QAedmERoK
   /p3jv/QLcgU5uVQWRM+1pjQNlRFvBY1X2JB0pxF9UpuDaeW1T/77Td9wE
   7wFnIKqEeaO1Qe3YFtSC/gKXiVMxQFCybQOx4oBodmkshr7+qmrz53ElI
   c=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,232,1661810400"; 
   d="scan'208";a="72566726"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 08:05:32 +0100
Date: Wed, 2 Nov 2022 08:05:32 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
    Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
    Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
In-Reply-To: <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
Message-ID: <alpine.DEB.2.22.394.2211020804180.3225@hadrien>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr> <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr> <20221102064747.GA8903@lst.de> <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1625700783-1667372732=:3225"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_000543_517855_8B292B82 
X-CRM114-Status: GOOD (  20.76  )
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1625700783-1667372732=:3225
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 2 Nov 2022, Christophe JAILLET wrote:

> Le 02/11/2022 à 07:47, Christoph Hellwig a écrit :
> > What are th other 29 patches doing in this series?  Due to the lack of
> > context individual patches from series have to through /dev/null here,
> > sorry.
> >
>
> Hi,
>
> in each patch, in order to give some context, I wrote:
>    ---
>    This patch is part of a serie that axes all usages of strtobool().
>    Each patch can be applied independently from the other ones.
>
>    The last patch of the serie removes the definition of strtobool().
>
>    You may not be in copy of the cover letter. So, if needed, it is
>    available at [1].
>
>    [1]:
> https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
>
>
> What is the best strategy for sending such patches?

I send the cover letter to everyone.  The problem with sending individual
unconnected patches is that people who are looking at the patches on
generic mailing lists can't easily see that they should just skip over all
of them at once.  But it is hard to please everyone for this issue...

julia

>
> Should I send only individual patches?
> Should everybody be in copy of all patches? Or at least of the cover letter?
>
>
> Some patches have already been Acked or even applied. So I'll wait a bit so
> that things stabilize before resending what is remaining.
>
> CJ
>
--8323329-1625700783-1667372732=:3225--

