Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E1C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 16:06:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF78D64E12
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 16:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF78D64E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rXTJQiL6SMKSFkHWs+BH8xzzW+iePkn7dXYweFFflnw=; b=wsdlrv/O7rUX2uAm4g/1ULaLN
	v1jZZ33W7rRRnUt37PcwHYqgbwJsh/jP48d1WHOy2BRxDjNJiEZTh8clPwg/fqRy/VGrIsV6gnGNl
	c89kscJ+QbL4zqNwlNcj2T90jSIWAPHJcxfU/N3ZUwxTDSK46vYJv+bjI8OYHACn3dosXeBK5nOFc
	TXGoIJpuBI5W4IB/6ZlqLa0KLEGbVOo0LzZRP3qgQhGNR4WZKpW7iIuo9+9ivOnKU+ycRq8KGztlV
	ROvMylksJ+v88eQYciSwCHgmEAonjHQzJV4qgFpGXrvrqZcCvDFT/Hd95DGALXzEjQcQliZpDnVB8
	WEd2sk2Tw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGl3W-0008AO-LP; Mon, 01 Mar 2021 16:05:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGl3U-00089n-Gp
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 16:05:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FFE564DF5;
 Mon,  1 Mar 2021 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614614754;
 bh=i198r6jtTCRsZqWaZm7Kh1ycZSMAjkCxokbm36sHl8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bJ2L1VIkg/VZo1RT8kTKIwVVXFx2S6A6yQZb6Sdue0ou9DAqhcZNPX5yaDKGZjam1
 DkHv1zoAHN2nEtSxh49Q/+xKrksvaQDoCExjCWAbqXW0bG0w7VYNZndxoMk9Tzb39f
 /VItL6HJMOOOiJGSaAJT/x2WlxqYPnvL8mGxxFScqU81ipfjl00IogkAT5MXytF8nO
 rZ8SEIRCfSaZg+esD+ye9gkg4TGYGQwMls12CNrZgM+YbdKSqvsbVqEL78n4GlfkNz
 aCp0DD2h7VL2nNyC91dfevS19Yuj2fRechEQuXKq7/KnqtmmWgEZSFQa3BSrM/Lg4s
 o3qZN1l7lBtoQ==
Date: Tue, 2 Mar 2021 01:05:47 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210301160547.GB17228@redsun51.ssa.fujisawa.hgst.com>
References: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
 <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
 <20210301132639.n3eowtvkms2n5mog@beryllium.lan>
 <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <786dcef5-148d-ff34-590c-804b331ac519@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_110556_638704_D2B853C6 
X-CRM114-Status: GOOD (  16.41  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 01, 2021 at 02:55:30PM +0100, Hannes Reinecke wrote:
> On 3/1/21 2:26 PM, Daniel Wagner wrote:
> > On Sat, Feb 27, 2021 at 02:19:01AM +0900, Keith Busch wrote:
> >> Crashing is bad, silent data corruption is worse. Is there truly no
> >> defense against that? If not, why should anyone rely on this?
> > 
> > If we receive an response for which we don't have a started request, we
> > know that something is wrong. Couldn't we in just reset the connection
> > in this case? We don't have to pretend nothing has happened and
> > continuing normally. This would avoid a host crash and would not create
> > (more) data corruption. Or I am just too naive?
> > 
> This is actually a sensible solution.
> Please send a patch for that.

Is a bad frame a problem that can be resolved with a reset?

Even if so, the reset doesn't indicate to the user if previous commands
completed with bad data, so it still seems unreliable.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
