Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472E0ECAAD5
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 15:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UgOC/lt3YQEi3JAkIjq0dNLFahuQl/6rqg64CrdHFnU=; b=cjSbfq3AHuiC6xiWyIXMDatgne
	v90lNYhmJaCWQSU6QZGeBtHHFNWA5GIKL6VOlm+S7aPFgI094bgWG6p2gBtza9ld58/4UM9VimJG6
	IgpCfaarkYQEn3ttxDEHuTP8HsTyaUznTdRQLL/TJlaab/lkQ+wepzg+pefca/pbzHdxJlJRXPph9
	7/7gj4r7TWxVGVL92/jiFT00JZ6Xpt8Eap2Xlje9Q0L9Prtx80+8HC0cyS/iNFX4Auht3oQyzEtar
	1bsxD5TZwFzAR1V+77Q7rfiNG0b4IO6u+6qL62HT+c5T8nt2rww0s/YJyK6A0D6/Boz+dnsqDicK3
	mB1WMI2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVasa-00F37G-6n; Tue, 06 Sep 2022 15:52:48 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVaCW-00Eb6R-RM
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 15:09:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A868C61566;
	Tue,  6 Sep 2022 15:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FC5C433D6;
	Tue,  6 Sep 2022 15:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662476956;
	bh=87A/oq8f5EH+biwjpLK2y08HVD6loW1Ms1pF/v9Rars=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qPez72sgVaaMsA8BDNbS3kIPzbnpJ4YQKmC4Vc+aCi+ge7QVhJ37NQh0JnsUPnNc9
	 estYGCo0QqKqDJuyJuA120q5tpLMNwWH8gKTTG5c3y9OHCUFVFgN20jMPm1AmuR/iI
	 BZRetHPjNXsuhJSCkW19wy+obnl5Xp/z2AwOaQyk7v6zaBuZ9F6OZnJWtTg7Rq5qk5
	 P+Uob/+z+GUiJf2SZpWW29JEWJ/bQ+18aHshc7ofeq37xa+tIqj35QGadu55Gnah71
	 M8NJpjXVkHsyvj9d3fxlN33N+t8UpQHF+ZJp9SyLylwCJ2BGeKXpcEcf7znH7cmZtD
	 VaJ6f0MfOcwtQ==
Date: Tue, 6 Sep 2022 09:09:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: [PATCH] nvme: requeue aen after firmware activation
Message-ID: <YxdimKNsMzSN0qjb@kbusch-mbp.dhcp.thefacebook.com>
References: <20220901153039.4162460-1-kbusch@fb.com>
 <0a040337-4be7-f57b-597b-a90afd4206cf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a040337-4be7-f57b-597b-a90afd4206cf@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_080920_999628_82AE8EEE 
X-CRM114-Status: GOOD (  18.86  )
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

On Mon, Sep 05, 2022 at 12:10:24PM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/1/22 18:30, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The driver prevents async event work while handling a processing paused
> > event, but someone needs to restart it after the controller returns to a
> > live state.
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=216400
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >   drivers/nvme/host/core.c | 14 +++++++++++---
> >   1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index af367b22871b..66446f1e06cf 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -4703,6 +4703,8 @@ static void nvme_fw_act_work(struct work_struct *work)
> >   	nvme_start_queues(ctrl);
> >   	/* read FW slot information to clear the AER */
> >   	nvme_get_fw_slot_info(ctrl);
> > +
> > +	queue_work(nvme_wq, &ctrl->async_event_work);
> 
> Why is the rest below needed? why is this not enough? Also a code
> comment would help here...

We can only allow one thread to queue the work because no one is tracking
outstanding command id's on AEN commands. If nvme_fw_act_work needs to take
responsibility to restart the async_event_work, then we can't let the previous
handler also attempt to requeue it.

