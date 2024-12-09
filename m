Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01404E77181
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L0dfLtPvcnX967uJBDz1qctsEMhtpyJegfR5RKjbIoc=; b=JGJBJxp0LkSV1fAYiC4SHEo6oy
	dyBmrKtg3C0Lpixf6K9dZpCTnasNVZbtEH8wPpyvffEAZLgzA7d9dGHdXroX1x0zST4kcYZQR9Ev5
	nl5311NZsmOobUgv9iv37FLVNGe1GGXUIg6YXSPXgioI+3/oootRXMyflYKCK+VzJ0tjyJunIhZPd
	nf2XiHpHw0+6rAh16ktikE6Nf/9BeFyMSESOOWL8rKTcIHvcVcDgWtsYt57vCsZm3yBYjJocq7SLJ
	QdSqIEMJL7jIud+C4uUxvrH3UGM9Ha/DDcG+9VXVeqB+d5V9/aSElQJMC6UZ2WQURbltc9KnjxMcs
	AjuS9Caw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKg8y-00000008SaH-13Sx;
	Mon, 09 Dec 2024 15:57:56 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKg8v-00000008SYd-1sXX
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 15:57:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 07F8DA402DE;
	Mon,  9 Dec 2024 15:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99310C4CEDE;
	Mon,  9 Dec 2024 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759872;
	bh=Pz7fIUtIf0IsPOePSYLfjM9CCwShvhiLHveXBe7i7aM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fub9RQA+FnF//HKXEpAIl9wIGLsvt16Lxi5GuSRKF3kz90wTwUOD6W9ml8l/JmGZW
	 1Vrx/S2taBUhavUbY6j5SgCgN/M+5wt3Q2zmXzs9veQ1mVi8HX5VykT5HwNvpnf1Eu
	 a4hQfnvXvgX/VRwUGoDElS5UDn17M8dYF+p/Gr/KiES18jNujUalngJZh8bAVvkGZ6
	 +hwajX3SU/W3fbC7h12rB3isNSfebaHRMCRxwe07rr8wAjvAjq+cU8f4gyBUzwHxor
	 KmDJgTWSLbo2jB95tQTT391EWWyIfszP060xJPx0W27jB1fzdIRcG6WDcmv9qEUQQn
	 3uuQ80y/dltRA==
Date: Mon, 9 Dec 2024 08:57:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	sagi@grimberg.me, asml.silence@gmail.com
Subject: Re: [PATCHv11 00/10] block write streams with nvme fdp
Message-ID: <Z1cTfefzaKHMFQ9p@kbusch-mbp.dhcp.thefacebook.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
 <20241209125132.GA14316@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209125132.GA14316@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_075753_553890_77DEF200 
X-CRM114-Status: GOOD (  19.22  )
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

On Mon, Dec 09, 2024 at 01:51:32PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 05, 2024 at 05:52:58PM -0800, Keith Busch wrote:
> > 
> >  Not mixing write hints usage with write streams. This effectively
> >  abandons any attempts to use the existing fcntl API for use with
> >  filesystems in this series.
> 
> That's not true as far as I can tell given that this is basically the
> architecture from my previous posting.  The block code still maps the
> rw hints into write streams, and file systems can do exactly the same.
> You just need to talk to the fs maintainers and convince them it's a
> good thing for their particular file system.  Especially for simple
> file systems that task should not be too hard, even if they might want
> to set a stream or two aside for fs usage.  Similarly a file system
> can implement the stream based API.

Sorry for my confusing message here. I meant *this series* doesn't
attempt to use streams with filesystems (I wasn't considering raw block
in the same catagory as a traditional filesystems).

I am not abandoning follow on efforst to make use of these elsewhere. I
just don't want the open topics to distract from the less controversial
parts, and this series doesn't prevent or harm future innovations there,
so I think we're pretty well aligned up to this point.

