Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F51C433E6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 18:36:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C57E464F59
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 18:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57E464F59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cxNywPAKXLagmYVTnSOmgZQ9WfYgT6IfR922vzu0k3M=; b=pqzGze6N29V6Qt6VTmwLj28gL
	Q1011tejcyY+7uK3BPjW68d9mR3OAG4JwBRGTQ0X3uXJggsQYCWCaN02vCauMiOz07KUkPNQEXYiA
	zkFpMCMCjPWO0QNeio8O6rukifaN5/w4gBwy9oVsCGTixKlT5V/UmQ+vJaZx2y3hoKBEir093boiy
	Y6cqmDOlcaYc2tQGa+ulPxBUxjTvTmpo5VecqRlYoKR1KAbDm2SpG3/fKXGVGF8rJ45rD4SOQbz0H
	ZQU1ngxs+tkrj840Hh78W9f0CB+JCwnzBywou+Qri3XC8H0E4tpgkwOuonnMCSXP/ajAJGkOVzTL4
	DxFz6qdcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7jUk-00033u-KG; Thu, 04 Feb 2021 18:36:46 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7jUi-000331-HI
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 18:36:45 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id i6so4177924ybq.5
 for <linux-nvme@lists.infradead.org>; Thu, 04 Feb 2021 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UqMQ/GMTZ6SvjPq30QG7VPUvPnPGHPYTqgfLdXQVAkc=;
 b=LyZ3A3Lmzqa4HkekOWrcIkvNIGnTiP8h7yn6jpXCpK655PcTayjIddQGPC2ppHDZbt
 DNYCPOMVwbxvrROgrXImQT/KspeG7SDBbwGktObKI3gkhQuesBOKqEJbYsco4Q+F7Y7M
 RPpECwGpoNRF/5S1x0NAovWaucKKgZsW9SonsWJ7l7i1G0r8VKOK9snb9JMlQrfIM0gJ
 L6tQSphrZCO6JLcWzgfXjAQsqzRnJ2EvIdNW3DEhNQ6+ox5vsJLwexcdqVBZf4Fvy8yp
 ZSv8G0CH2ZtFiyMxh8f1/ZX5NMrRP05x5G7AtfhLUqI/BjuWNuh/h1d1fZj/ytGHeaQu
 4MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UqMQ/GMTZ6SvjPq30QG7VPUvPnPGHPYTqgfLdXQVAkc=;
 b=flO4sCmjK2Go781+LHaoMVVcbJl035hcnFsPb0gt1nA8D8h2VYFrkks1iSOYB0Di3q
 gQOW8NMhaDkmgheXEQpdEq5yLwM4wEsRSl/iGI4PEjfZlYM5w9g0i9p3fHYr2Da1VIGi
 nYsgDPU6Q2rz7+czP3FxUoq4znBIkpetAhwof2l6cRwOJLu4ZD7CjGEuksVbfO2typcA
 kVqFqNvs5m682+bzgGyaHlliHo6AFSw1zM5HBC9Eua9qY8pBEm6YIKr2akBN6QYTa+JJ
 hLWzS+UdY9EZNxbaWtwKKwnmiW5Uch9FcFRrl+MMsM7Qt2fnf70Egax+/kXgrmwrOjMQ
 vlGQ==
X-Gm-Message-State: AOAM532XCj6NUzZw/SqDr1QTgE8RTfa+fD1v0IIV6s69QaHXd+yR4qAr
 oIWGQdSHLG6vJpQjdv6WdBBFzZfvlSdRQwwIU/k=
X-Google-Smtp-Source: ABdhPJzNloHxgGPC4oJnyoA85Rq0G3DJrGU2d/8HUY7WajfwjT60zC6XBiMPLUIpZyr5jC/YDS6BF20iR9+NzsehnJo=
X-Received: by 2002:a25:ba13:: with SMTP id t19mr806489ybg.129.1612463802396; 
 Thu, 04 Feb 2021 10:36:42 -0800 (PST)
MIME-Version: 1.0
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-9-borisp@mellanox.com>
 <a104a5d1-b4cb-4275-6ced-b80f911b6f47@grimberg.me>
In-Reply-To: <a104a5d1-b4cb-4275-6ced-b80f911b6f47@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 4 Feb 2021 20:36:31 +0200
Message-ID: <CAJ3xEMhSxrjLfDvfzVRCLb27K4KmRh-KHQaKxvDF_6VDbNN8Jw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 08/21] nvme-tcp : Recalculate crc in the end
 of the capsule
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_133644_619160_ED914092 
X-CRM114-Status: GOOD (  13.54  )
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
Cc: smalin@marvell.com, linux-nvme@lists.infradead.org,
 Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>, benishay@nvidia.com,
 David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Linux Netdev List <netdev@vger.kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, David Ahern <dsahern@gmail.com>,
 Keith Busch <kbusch@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Or Gerlitz <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 3, 2021 at 11:12 AM Sagi Grimberg <sagi@grimberg.me> wrote:

> > @@ -1841,8 +1913,10 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
> >       nvme_tcp_restore_sock_calls(queue);
> >       cancel_work_sync(&queue->io_work);
> >
> > -     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> > +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
> > +         test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> >               nvme_tcp_unoffload_socket(queue);
> > +
>
> extra newline

will remove

> >   }
> >
> >   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> > @@ -1970,8 +2044,6 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
> >   {
> >       int ret;
> >
> > -     to_tcp_ctrl(ctrl)->offloading_netdev = NULL;
> > -
>
> Unclear what is the intent here.

yep, unclear indeed.. will look and probably remove

as for your other comment on this patch, will get back to you later on

> >       ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
> >       if (ret)
> >               return ret;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
