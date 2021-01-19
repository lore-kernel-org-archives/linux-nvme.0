Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B5EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 19:07:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0741722E00
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 19:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0741722E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hgd61BmSc1UxJx+3lAXoGLYohpAV0CuADB/oJlOGanc=; b=bR8vo0MsXYEjx/hXcUVLAsfHK
	aQ3CVmk8IC6JJvaBaa61qJA9yOSAZGuQgJ0aOroS3t5ZSpXjWWxch5AXTysxxNAitPBIfUd8JF04i
	aN5H/UqXbe31nWd17RiKB67We6QYyY28fBRwcTWSvMs72FkgRIZYpLDtK//+uChsTFuJXyavVpLwP
	d1xEeM1wuZjOYGrYOkWkF/Yuge4QQYM0KPn3PgTvUvp1/EBoB+HSN9ty9RjrpbMx6u50BBvdfDp8u
	S5qzz1r2547isqabKUkJKZ49t3qRIMb9P9MS+2pIh0xkDiE3dqUCZ7SvhUsuSR7lTpiX92Eu0ncon
	DDzm6JiGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1vkD-0005zA-C0; Tue, 19 Jan 2021 18:28:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1vkA-0005yE-DT
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 18:28:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6430B20776;
 Tue, 19 Jan 2021 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611080921;
 bh=G/Iizd+1i4ee0dIyL2dAo1EGK2IkTYImCzy6WPT7wqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nUQkbo0POaBcn5Ait+ahdyxuahnsdJR4IjsPao47GP0GMpkog+10I4cJs/UFHCf1u
 niuPwxohZbF2dR79igFzkx/NNC9WIYGLMluKeA5L+Df0c7KmRF5tpyNI1fyfzCxMio
 JAvG8f2S+UuihKllomZwxntFUE2f68Q/gUtWrE3bw8Rue6oOEsoYYbXRtQ4dofiTDW
 /qDpnXr2iMRaLuEorhxryrKgBwhoXWdvShxySSQR1pG2yacIMFBPN2xYFNlb5622L2
 dx4qyhXfIy5Q02oDEKa+lH0jVk21X4cIZREoI8iaqAX6otDk5Ww50cVYbqWqDP+6mZ
 MJlPP08pn9PpQ==
Date: Wed, 20 Jan 2021 03:28:38 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 3/3] nvme: retry commands based on ACRE flag
Message-ID: <20210119180535.GA1520627@dhcp-10-100-145-180.wdc.com>
References: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
 <20210114133110.20779-4-minwoo.im.dev@gmail.com>
 <20210115170412.GA1515933@dhcp-10-100-145-180.wdc.com>
 <20210115182602.GA2822@localhost.localdomain>
 <20210118174051.GA8542@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210118174051.GA8542@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210119_132842_536184_ABEFD4F7 
X-CRM114-Status: GOOD (  23.43  )
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
Cc: Jens Axboe <axboe@fb.com>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 18, 2021 at 06:40:51PM +0100, Christoph Hellwig wrote:
> On Sat, Jan 16, 2021 at 03:26:02AM +0900, Minwoo Im wrote:
> > > I am not sure we should ignore the FAILFAST for non-path errors. If we
> > > need retryable admin commands, we should let the driver provide a way
> > > for callers to dispatch requests without that flag.
> > 
> > Understood.  I thought the opposite way about FAILFAST in case with
> > acre, if device is enabled with acre, all commands would be retried
> > regardless to FAILFAST...  Thanks for pointing that out!
> > 
> > How do you think which one is right choice to go with if a user-space
> > application(e.g., nvme-cli) wants a command to be retired in case of
> > ACRE && Error && !DNR:
> > 
> >   - User-space application should figure out !DNR and retry the command.
> >     (Maybe we are not able to easily figure out exact status code from
> >     the user-space application by the return value).
> > 
> >   - Driver should retry the command right before putting result up to
> >     the user-space even it's a FAILFAST request.
> > 
> > Thanks,
> 
> We could come up with a version of the ioctls that use the normal
> retry mechanisms.  nvme_passthru_cmd64 has two reserved fields we
> could use for UAPI flags like this.

Yeah, I'm totally okay with adding driver control flags for this sort of
behavior.

For the moment, the ioctl interface has always been 1:1 for commands
submitted to completions received, so all user space applications using
this should have been prepared to receive unfiltered status back and
handle retries on their own.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
