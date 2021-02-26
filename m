Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFE2C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 17:19:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0878B64F1F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 17:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0878B64F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VzyCLpngfjlGY/fyib+kdZ3/LWtktNBVoZxZyswnOMk=; b=P7UJQx9woLNOlCPFxjuScO/jI
	EzcTvdyqDwSS9uussMXs2KJCJyv7w9ho4CqMZIcv4tOVRLLt4cwUP3pq1qECHj0r8ON4ciDDMqjqv
	K/8OKtwcAWVjmph1816uP95Qec3ave4EIAinZu/d1jzuNrng9L8CUkQ74BRE54YiI9abEyOpZdF2M
	ImCkLRZ/5tr0WjZppG+BbCz1Zkg2yEdYb4LDVmWhY0BlybcmsuxDJXXWwc6VFYnn/mP/TdDOQf0rQ
	34f6GQWGp4ibshk5/1qei8eTVTsYlR3d13xdSxeVtfH5YB/Eev4USXEdobSRg3E8VzuSJhsuBjBku
	V71F+PnDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFglm-0007hK-2O; Fri, 26 Feb 2021 17:19:14 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFglj-0007gx-A6
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 17:19:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AF0564F0E;
 Fri, 26 Feb 2021 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614359947;
 bh=Bd65XOTrei5fxTOedo0AjEPLzm2AKptX7w7syoIfjEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pYoJwosyELFYEIXxbJxq635ucCVg8L5ywVQfRZgrvXD9USOPC4lIPoxyKBWODEavg
 NC/BDaTzdzxp50/0ApeNMHmUwxCn+9LiVdH0ZKXiKSmgcAkQiQRChpjRGz5Wan3RSs
 HBm3VjFhjRWnMxKI8S/qg8kLTu73Xu4j7ItUb0kMHHXSrsJD2Us9wT0x2CvuYtJO4/
 SQOjOKacJSaL7DeE0LYVOml5Po7RN5Yje9B0sX8lBaxp3xOoAgE+XolwX6Rg25iPRK
 7NGQU1HqAftCl9CgzWt43+g8M6x84ISJP9+wOz20/I8oqqKvQl0sS6/plHSKcSA8OS
 ojq8uq2FYoVOA==
Date: Sat, 27 Feb 2021 02:19:01 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210226171901.GA3949@redsun51.ssa.fujisawa.hgst.com>
References: <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
 <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
 <a2064070-b511-ba6d-bd64-0b3abc208356@grimberg.me>
 <20210226123534.4oovbzk4wrnfjp64@beryllium.lan>
 <9e209b12-3771-cdca-2c9d-50451061bd2a@suse.de>
 <20210226161355.GG31593@redsun51.ssa.fujisawa.hgst.com>
 <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a42d6285-ff32-3e16-b2b1-808d29f2a743@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_121911_422942_B216EB33 
X-CRM114-Status: GOOD (  14.14  )
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

On Fri, Feb 26, 2021 at 05:42:46PM +0100, Hannes Reinecke wrote:
> On 2/26/21 5:13 PM, Keith Busch wrote:
> > 
> > That's just addressing a symptom. You can't fully verify the request is
> > valid this way because the host could have started the same command ID
> > the very moment before the code checks it, incorrectly completing an
> > in-flight command and getting data corruption.
> > 
> Oh, I am fully aware.
> 
> Bad frames are just that, bad frames.
> We can only fully validate that when digests are enabled, but I gather that
> controllers sending out bad frames wouldn't want to enable digests, either.
> So relying on that is possibly not an option.
> 
> So really what I'm trying to avoid is the host crashing on a bad frame.
> That kind of thing always resonates bad with customers.
> And tripping over an uninitialized command is just too stupid IMO.

Crashing is bad, silent data corruption is worse. Is there truly no
defense against that? If not, why should anyone rely on this?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
