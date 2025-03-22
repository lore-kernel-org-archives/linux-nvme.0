Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57154C35FFC
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Mar 2025 20:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49++YOCyQWNmUfGfaJCXgmwoTlehQ0ChbOtbRtnavLU=; b=ConuVrAyLE3Ug1aO+0FDgBjF4A
	3+742vEISabvtlCZEGT14DAOCPbDaobkMl7cCJAC3Ui9XgnGTPl/S/ptOnU6+Jnlh4BN0Yy9O7bld
	mJoBl4qwtuPG/Qfa4X+WeRL1yxkwyjzJ6RdfWpJ1q1P6lwL9CMTXaOHeItsh6DeTbm7cD1oPa20j5
	8nCZOTZPs3ND2JUEopulEFuldpHq0cYsqa2ybutT/ThVSq+oQMoQIrGxRqIpyOvHoP6dxtVbve8zh
	r/kz1hfLKhaVXLqT9YSWHP5uIEWfl/J9WA2SoP6tRJvaFxdcTy1c0szFTporO+6tF4/KcwTCySQn6
	bgBPxNQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tw5me-00000000JP4-111n;
	Sat, 22 Mar 2025 20:49:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tw5mY-00000000JOw-2PtT
	for linux-nvme@bombadil.infradead.org;
	Sat, 22 Mar 2025 20:49:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=49++YOCyQWNmUfGfaJCXgmwoTlehQ0ChbOtbRtnavLU=; b=roVYuGKGAaveFhl9FahKGqzjb5
	h0kjrdCPRxnKe3RFeqW97s5/xsj85NS93PYA+escS/2VOUFpxsw7VQEL0zYFjOKerpijkbt11CoF1
	JREIwNfyfObEovtcRhtzVBWf0ft4BpGT7xJ+PpAeyCvrOXfjfh4d8B0ryDsmIM5r0y1d86tNKNfH5
	h1qQm3LKwYrsoQtJ4bc6aR5yn7YSSK0bSQtAJ4p5AfWL9Spq996yI74QVuMPM+yLbvhT+/LF8ilGV
	qKpse/gjnUMhbFO3p/sePHkonIS7aAxQv57XJysvbu0xbR/5ynGsyQlWNM2230XeECLg2Km4VTjTV
	TuQe/M5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tw5mV-00000005pJc-2fN2;
	Sat, 22 Mar 2025 20:49:23 +0000
Date: Sat, 22 Mar 2025 20:49:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: lsf-pc@lists.linuxfoundation.org, linux-scsi@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: REMINDER - LSF/MM/BPF: 2025: Call for Proposals
Message-ID: <Z98iU2mcZhuV_1Cv@casper.infradead.org>
References: <Z4pwZkf3px21OVJm@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4pwZkf3px21OVJm@tiehlicka>
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

I've had a quick look around the hotel.

All four conference rooms we're using are on the Mezzanine level.  You can
take the elevator to that floor, or if you're coming in from the outside,
there's a staircase to get to the mezzanine.  The doors that lead from
City Councillors St to the mezzanine level were locked when I tried to
open them today, but maybe they'll be open on Monday.  Also the courtyard
door from Sherbrooke is locked.

Concerto (the MM track room) is separate from all the others.  It's a
little hidden; you start going towards the Milton brasserie, and then
turn right just before you enter it.  It was set up with dining today,
so maybe we get special MM snacks?  ;-)

The Opus, Tchaikovsky and Beethoven rooms are all near each other towards
the north end of the hotel.  If you take the elevator, turn right towards
these three rooms (and left to go to Concerto).  There's also a Vivaldi
room that I don't think we're using.

