Return-Path: <SRS0=TgIa=3N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD5C2D0DB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 18:29:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D402075D
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 18:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S/NI3KXc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsUDthzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D402075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qtPBKrnhIkZfXy/OwpSQAN4RraGjhZv0hjkazSyqfB4=; b=S/NI3KXc/p68jf
	gqIgKEnNj/lJuIm99aPGZ7TmR7pIM8qitxSxrp5ARWcRPNMHZU5UBKp+XVQxnHikTiDMK1xiGhuMf
	uHHCOmkER+p3U8Ql8EkjXwAZhqTueJGQJVZShpKX3epNzY/TjTtASUcNpQUpCOnmKqSQq1W5hJOQ2
	auFZZRkWPANe+gAdid8m3l5lZb1MBt3FAsKnEcMVpGfsjVv44SybtYqPo4T49KbBpxybCgfBRMSwQ
	YS1pPh+rhD6lskj5DY3kgy5zCeDvRjA/6MICH+jnhexqTbgz9gpASZLD+NbtPOeyczCuwug3LXl/5
	GNbYOtT5iDFsk3ZhQOpw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iv3hX-0004Ak-JO; Fri, 24 Jan 2020 18:29:03 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iv3hV-00049o-3M
 for linux-nvme@lists.infradead.org; Fri, 24 Jan 2020 18:29:02 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 60E2A20709;
 Fri, 24 Jan 2020 18:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579890540;
 bh=s3mqi+GkMd6AIVi16w4CFqKsgmlILFLV/iCtU2QUG5E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KsUDthzOUNcHYkP0aVq9IJol/wyoR4eGNLqwNlN3y5Tsh4RtWcEvaw+DwJNpaupfm
 ZJs7+Gv/2JPNb3ZiWCohNL7TCJPeobTJu6gMT8SgP3dkmi6Z+anQ35pj85AS63S/6P
 0GpwNC4aBrkauFCO744MIaS5Sq8rGVhoDXFwTjf4=
Date: Sat, 25 Jan 2020 03:28:55 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: fix dsm failure when payload does not match sgl
 descriptor
Message-ID: <20200124182855.GA19243@redsun51.ssa.fujisawa.hgst.com>
References: <20200124173942.2744-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200124173942.2744-1-sagi@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200124_102901_173872_985BD288 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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
Cc: Dakshaja Uppalapati <dakshaja@chelsio.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 24, 2020 at 09:39:42AM -0800, Sagi Grimberg wrote:
> The host is allowed to pass the controller an sgl describing a buffer
> that is larger than the dsm payload itself, allow it when executing
> dsm.
> 
> Reported-by: Dakshaja Uppalapati <dakshaja@chelsio.com>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Thanks, applied for 5.6.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
