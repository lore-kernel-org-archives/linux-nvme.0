Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70A7C54F51
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ymh6iDnk70vzkTfI1rJg7jsntRh3NceOVlS3wu011Y0=; b=d7luOTrq5bhWJoi5U5Lo94kTiu
	to/B6hsVAyx4nXQZC4LMuo+EHJODs0PSK47x2AiErrD6GwlQDhcOLZGoG+j+2Kp99UIeBWPnJK/CS
	nv9DO8WpJRCafgnlxEOLtT6kk035M2R09+Iga3P9p6i5X2TYkoAHVvpnyPjQhqIY13Xmqo5uwJ9Ow
	rTH1zJoubiSwH1LD6lQrmyZZIxOjHoE9K7QfP4gsN51dwvqgsli6VDrvTRWQP4s90dI/vK5vEs/T3
	tjbKWNYKySKK+WP0BZlsrjKNp3SuVGzLqeCE4DmptgGOj428fkbhnCjp1Kqt2Aew2FdFPvihVRxpP
	cyQ66j1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4vf-00000008Cgb-02fh;
	Wed, 29 Jul 2026 14:06:39 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp4vd-00000008CgH-3QLD
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 14:06:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CECDE6001D;
	Wed, 29 Jul 2026 14:06:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E5E1F000E9;
	Wed, 29 Jul 2026 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785333996;
	bh=Ymh6iDnk70vzkTfI1rJg7jsntRh3NceOVlS3wu011Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZWSYsncx9Dxu6GRTl7K02K/XqI97Z2TECSSnrlQNvTxqG3coPPJXXstdOTiYis9u0
	 FZ+fwFiTMPJfjsRfVaZZgYi5zic7R4TqSH3kycYIDEAuR64No3CCQKvbapo3oG25Zs
	 yy5wfENh4xvGNIAPraTjbzoC8FeScWIkzNX9QE/KOJZs+ZxuhwrWqnabbSb0tzayPG
	 08vL/rdCDnX5/jR/tD05nBApmzSMqn3jb/nMXFeMS2A9vDk/d9zxf/WBmKaEg6HsZf
	 jxVK5TQ5DjHDsyiJfBods/rvOOpHpNhdPJ+WgEZeyCQcSfpmEdTN4P5nnnGVp0NZhM
	 kukwXL3I1ZGWA==
Date: Wed, 29 Jul 2026 08:06:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v4 00/20] Support Clang context analysis for NVMe host
 drivers
Message-ID: <amoI6iw_e3DeACKD@kbusch-mbp>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
 <amjp4ymLa-u9iO_U@kbusch-mbp>
 <CANpmjNN2+m7O206xFDRwyCoihsEr9J972pOFSa5Uc=xx6kkTHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN2+m7O206xFDRwyCoihsEr9J972pOFSa5Uc=xx6kkTHw@mail.gmail.com>
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

On Wed, Jul 29, 2026 at 11:03:52AM +0200, Marco Elver wrote:
> On Tue, 28 Jul 2026 at 19:41, Keith Busch <kbusch@kernel.org> wrote:
> >
> > It doesn't look like there's a single source for updating list.h, so any
> > concern with taking this series through the nvme tree?
> 
> I think that's fine; conflicts should appear in -next, but I don't see any yet.

Sounds good, applied to nvme-7.3!

