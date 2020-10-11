Return-Path: <SRS0=akZa=DS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D113C433DF
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Oct 2020 06:55:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96745207FB
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Oct 2020 06:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KrYbukL1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiWL/nwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96745207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uIp5vVPxKmyk7hrsVvOOFdANBVDtENmqjcOtVawkoWQ=; b=KrYbukL1PcQOMNgexaR1IFIly
	82Uos5oEywRIwZj3cTPhWMl/GVEVoR25rcY3djfJVSF3gEuYah5tSXCYZeHH4PFXrEjdHb8nKe50X
	lY9H1KvctniC7kYWEFWQvoUQmGU5ECotWBPj4xXExypsT0EctjWQBKeYYHY5+l8tEfwUgOm5v/2ed
	FV/K2/Rrncsvcs1P8/9MWziX67gscvuF0yxKk7sRKxIDhU4asepJvb5Nagp7ScAYZ/QsUi8lA5UC7
	pePsFQhmwdS4+IEVFz5QX09Cz4ec1JKLj7Jrs1b+rRKDQcyEcBGeyCYNA//KQX0rOJgo175eHLpg+
	+lO5oOPVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kRVFx-0003lg-N5; Sun, 11 Oct 2020 06:54:57 +0000
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kRVFq-0003l8-El
 for linux-nvme@lists.infradead.org; Sun, 11 Oct 2020 06:54:51 +0000
Received: by mail-yb1-xb44.google.com with SMTP id a4so1445366ybq.13
 for <linux-nvme@lists.infradead.org>; Sat, 10 Oct 2020 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DwtEKZWE7kyFtmQNQI1VaHt6bZEv5zkM7EVSuNZ3u+w=;
 b=RiWL/nwx6REBlJQotq0kZSWCrmU08/qAWFrigdmXYNlsWR33TUmaPiHxVOw1U2FDLh
 ka9wvtume7N1EfhSme3MyNhJDPtbACfhvEFqbVqVa8eZH2fOuySKlgiLBZD5UxL09TGy
 mmrthcgPUwTt/y7/gOmeWVUwwPBS6fETM4u193KOmdrq4domga7Zp15U+pYJj+jzkSeC
 JLBcKT7vqSTdzU+2DrsW2dNJjCvQAVLOdbS+wtk1pQ9T6llWLOZfVrhIzTW2O+fpxT4H
 NuJLfdupQjNdKZSvZJMqTsjKdpC8ntSDmq34xZYVbmtxNecqFJPLms1boM12YOhLjS6y
 V0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DwtEKZWE7kyFtmQNQI1VaHt6bZEv5zkM7EVSuNZ3u+w=;
 b=hkswcvgpMFjOk57OVFghtdJfTdClH44rUx5BpeCY86B3+Eq2/TiUKeDpu4bJo0tHm+
 G0a9en4WU28Gm+DFNpdZY1giaofxJHfuVnM3PnwDngkyA0vpeFZJCsT9HzMeeceMyGdK
 +kropcmajvXWz45v40rC2dkLMFTq2UeLLQhNsrBcEEGzuOrumLaYAS892YJFzdR88TgY
 zzGAwMcHYXJk8qUBAZ7/sb2a2XCFUWO4BWuoZ6S0UmEA+uf5/O+8m9fdPGxz4jYnqDma
 9TIRqUzpbAtHhRysxUKIsqGhQfb5xQcXcnncsagTwQG3ewnErQPUBjJjBTqH9ucvHS9c
 LFxQ==
X-Gm-Message-State: AOAM532Y7VS5dIFduVLLS+ZDOgGHwMYHckviTKBazB95P0SHrBD8/gKw
 x+/U5OVZkDWDMg72iQb6hCXj0wj17ZPTtw4XT5qpuUV7jFfEKQ==
X-Google-Smtp-Source: ABdhPJzfLkn1r2ocZJdM30e8vSbXrAH8Zrvp1/iXO8bWCb7qil7HJ2cP+9ebMs/5Ac/UXFEQHb2WjPX3sG0q+gpPWoI=
X-Received: by 2002:a5b:4d2:: with SMTP id u18mr24157729ybp.56.1602399288409; 
 Sat, 10 Oct 2020 23:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-9-borisp@mellanox.com>
 <67e29f83-5bab-4abd-44c0-9c5ae29d5784@grimberg.me>
In-Reply-To: <67e29f83-5bab-4abd-44c0-9c5ae29d5784@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Sun, 11 Oct 2020 09:54:37 +0300
Message-ID: <CAJ3xEMh4FBQ583bhxbXwHZKmZLX28Obf6gArP0qpd5OebnuuSw@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 08/10] nvme-tcp: Deal with netdevice DOWN
 events
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201011_025450_609331_E30BB3B3 
X-CRM114-Status: GOOD (  13.94  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, David Miller <davem@davemloft.net>,
 axboe@fb.com, Eric Dumazet <edumazet@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, kbusch@kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Oct 9, 2020 at 1:50 AM Sagi Grimberg <sagi@grimberg.me> wrote:

> > @@ -412,8 +413,6 @@ int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue,
> >               queue->ctrl->ctrl.max_segments = limits->max_ddp_sgl_len;
> >               queue->ctrl->ctrl.max_hw_sectors =
> >                       limits->max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
> > -     } else {
> > -             queue->ctrl->offloading_netdev = NULL;
>
> Squash this change to the patch that introduced it.

OK, will look on that and I guess it should be fine to make this as
you suggested


> > +     case NETDEV_GOING_DOWN:
> > +             mutex_lock(&nvme_tcp_ctrl_mutex);
> > +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
> > +                     if (ndev != ctrl->offloading_netdev)
> > +                             continue;
> > +                     nvme_tcp_error_recovery(&ctrl->ctrl);
> > +             }
> > +             mutex_unlock(&nvme_tcp_ctrl_mutex);
> > +             flush_workqueue(nvme_reset_wq);
>
> Worth a small comment that this we want the err_work to complete
> here. So if someone changes workqueues he may see this.


ack

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
