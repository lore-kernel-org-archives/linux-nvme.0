Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1621C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 17:09:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E68613C8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 17:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E68613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MGvusR0T+BKaAwVcp3w3uOzBtFZUdPsUfZhcW03tCyU=; b=cnv68R0H+2KVkzSHtOMxb73Sy
	q7v5tLgGJ/mcdpRtmwwvpPlXhNLelW83LsrOHRKmy4YMyqDMh8ckJcXGPnsVRX+8vDXYcY1fdE+jn
	8HvPKJ49zl2iC+d3UiuiQ6Z0NdJjgJ0vR+5rYkwXl+Oy9NgqaQIPK2cFdia957gT2U2ZjjkXfOfo/
	z9eqFsc5L6TRatx5dk75h6cZWp2yPkc2uVjqjk43bhEm8wLqed7uwrlpIKT/y8B0A6ssDSChCrjJG
	ycbZV0YhD16+84LUEROQ0gMk5d0+Sal3jONM4eP11UXIvev8R2vcVYoyov2k6DlUlqXkxB8kZ0K2V
	bX0bYCX8Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZzIo-001xgk-LS; Fri, 23 Apr 2021 17:09:14 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZzIm-001xgT-31
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 17:09:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=aifPE182q7SeQ5+SPh/DLu+jX7LwFXZmojcNfUNDDD0=; b=AVzmZ5xIm/ZGZfEnJFamv86x1D
 6+YWH3zeD7pIGyz+jtmd6PpzC9AknwNI/zEudBUWeW0gL3WPWxvGPfvKku2+v2pMUxB0FXyHrC4Q3
 614aNp4wjOwyl9nYce7yXYO84oNTCG5w2ZmGRmlG2aYTzIpm8Jr9CHfrUJHQhIJqn062yLaH2awx5
 Bzg8DGmoHcGU65f/qASiqI+z+giOnnk7T2huOxPRnbwMK09MmSW/HCMhlpn4VGjYsCipxRlkrlqXS
 1hdCTT7qPn5PBudoAhTRIs3Bz2AygSdgEnou4/Zl6CIilteakfuyaskvHHCDehX1a48+kLYw2OW+f
 VPN1jKew==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZzIj-00EZxz-Fi
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 17:09:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1619197745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aifPE182q7SeQ5+SPh/DLu+jX7LwFXZmojcNfUNDDD0=;
 b=XIWLUzzOaZXi8te4s6mKpLRHjgR6IqlAhp/+NgNl9l6gpnWx8J4YztYi14MuWDxdSiz+iq
 KhPYPW+Vu7AimfrtgDbCR2vK7/Ck5JcGYQ9GKwpWrStP3TTukdfVAO9NZ7BEFBVPLstsyK
 MYLJNYqGIofC1j5OTUCH3l6jM7oLlkE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2E462ADAA;
 Fri, 23 Apr 2021 17:09:05 +0000 (UTC)
Message-ID: <f883e44164bdb124050ed12837a6f735cb10607c.camel@suse.com>
Subject: Re: [PATCH v2] nvme: rdma/tcp: call nvme_mpath_stop() from
 reconnect workqueue
From: Martin Wilck <mwilck@suse.com>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>, Hannes
 Reinecke <hare@suse.de>,  Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org
Date: Fri, 23 Apr 2021 19:09:04 +0200
In-Reply-To: <b2315ed2e6e1c273c9e000b107c38e41e2ddd33c.camel@suse.com>
References: <20210423133835.25479-1-mwilck@suse.com>
 <CAFL455k3aBLcZrZPq=Q-9aws4UesstA5gSOr_E7mEFrLT+KbKw@mail.gmail.com>
 <b2315ed2e6e1c273c9e000b107c38e41e2ddd33c.camel@suse.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_100909_695351_CBE6F7F1 
X-CRM114-Status: GOOD (  13.30  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2021-04-23 at 18:43 +0200, Martin Wilck wrote:
> On Fri, 2021-04-23 at 17:50 +0200, Maurizio Lombardi wrote:
> > Hello,
> > =

> > p=E1 23. 4. 2021 v=A015:49 odes=EDlatel <mwilck@suse.com> napsal:
> > > From: Martin Wilck <mwilck@suse.com>
> > > =

> > > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > > index a0f00cb8f9f3..46287b4f4d10 100644
> > > --- a/drivers/nvme/host/tcp.c
> > > +++ b/drivers/nvme/host/tcp.c
> > > @@ -2068,6 +2068,7 @@ static void
> > > nvme_tcp_error_recovery_work(struct
> > > work_struct *work)
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > > =A0 =A0 =A0 =A0 }
> > > =

> > > +=A0 =A0 =A0 =A0nvme_mpath_stop(ctrl);
> > > =A0 =A0 =A0 =A0 nvme_tcp_reconnect_or_remove(ctrl);
> > > =A0}
> > > =

> > =

> > =

> > Do you think it would make sense to call nvme_mpath_stop()
> > inside=A0nvme_tcp_reconnect_ctrl_work() too?=A0
> > Right before it requeues itself by calling
> > nvme_tcp_reconnect_or_remove(ctrl)?
> =

> Good point, probably yes. I'll have another look.

I did now, and I don't think it's necessary. With my patch,
nvme_mpath_stop() will be called the before the first invocation of
nvme_tcp_reconnect_ctrl_work(). The anatt timer and mpath work queue
will only be started if nvme_tcp_setup_ctrl() succeeds, so we don't
need to stop them again when it fails.

Regards
Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
