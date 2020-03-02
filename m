Return-Path: <SRS0=ymBk=4T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400BC3F2D1
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 14:53:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19C82080C
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2020 14:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qa28YHa2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWCPKmEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19C82080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZaXyYI0M7C0/CSrVloVcm9OtVdDeT3eyiKzMiQnFfvg=; b=Qa28YHa2dLQnRa
	qaiXJijQXxxFFX8HAB69Epb/6iMVL/pxhEkKqVdDCNN5ZN2EapoABwItJ3xgor7fGWEHSP0RhaNYb
	xyTDQHrQpzGAMACsUMl50UaMLS2GbVs+DmluZY9BwL3GMQnscEyLtXI0Se+fPN4939qWfuWV6Wuae
	hWdUGbziuH5YhyL7a0Oq+9Y18xaUdGGeucRr5OvGV7ZZvLCt9BZOLXXFEq1U1800cqjuQ5bKUX4hq
	fyszxxzYT6GkAjHh73IOqTL6LC0aOr0H99Ys23LyH3FI3mUJCVjT0zxTESbjRaD4SxSn/ZjUp7U6t
	P+K7XzmYd5yV6D6jvUZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8mRg-0005kf-1V; Mon, 02 Mar 2020 14:53:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8mRd-0005iw-HS
 for linux-nvme@lists.infradead.org; Mon, 02 Mar 2020 14:53:22 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 72A2121775;
 Mon,  2 Mar 2020 14:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583160801;
 bh=/ujiqn0F0eKhpDPmiPeKaMj+WcKEVZBmjG4Jyn1nIVw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eWCPKmEpAbTbc0FD61hW+TSlsCou0lKiFUWG7L+waQ0j4qgJTBCsZRYL0Ch+MM4m8
 fap+mhyu7CPFkUF5zvXRXwucz1Hg46kWfCTuQeO1LIHOdsQAW0mqIUu0i2CyZb5U61
 zwfxVeEjgoDyS+9b5RuC8zgKauyn8rYnLfHUGEGI=
Date: Mon, 2 Mar 2020 23:53:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Message-ID: <20200302145313.GA6773@redsun51.ssa.fujisawa.hgst.com>
References: <20200229025228.GA203607@localhost>
 <20200301183231.GA544682@dhcp-10-100-145-180.wdl.wdc.com>
 <20200301191501.GA235404@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200301191501.GA235404@localhost>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_065321_599141_AD4AFB6E 
X-CRM114-Status: GOOD (  12.39  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Mar 01, 2020 at 11:15:01AM -0800, Josh Triplett wrote:
> On Sun, Mar 01, 2020 at 10:32:31AM -0800, Keith Busch wrote:
> > I doubt there's really an issue there, but thought it's worth considering
> > what happens at the other end of the specturm.
> > 
> > Anyway, the patch looks fine to me.
> > 
> > Reviewed-by: Keith Busch <kbusch@kernel.org>
> 
> Thank you!
> 
> Does this seem reasonable to enqueue for 5.7?

Yes, early enough for 5.7. Let's just give this a few more days to see if
nvme fabrics developers have any comments. Reading controller status for
those transports is more complicated than PCI. I don't see an issue
there either, but since this is common code, we should see if anyone
else want to weigh in.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
