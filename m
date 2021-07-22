Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E6C6377D
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:34:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C43E61289
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C43E61289
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RX43u1vd0v0mTiCq2JiNsajhTiE6YEiVnP4eiZjS8mE=; b=ZkTrMTgJeX8eA6
	wJZpUPagagwcRS5OV3aYpcjYtvp0m2j2xKsBGkafHi3pW2UqguAFGhe36gIsVUFYS1VrjTffPk6E9
	PGblgdLLDzk6QfDc3SH7FY8Rk2qHnP/dTIxPBZNJh/Z1dI6GpMpFp0i3IbdLyTXw/DpUp4XdCVrL+
	ZkZ/t74t4nJvD0mm70t5rnNvsliG5P0/pYvbdRiEvhblVgWL+22MGi2NdWHwv6buVB0MXKOk6ApXN
	4IfUtVK/FSOIdZMaA8jBhU2jv1HoMGfgwcT9GWBidkP96C7GAkKc3B2vW6G/oaOyqLubneN7Qz59g
	z5rRAcez8FvzZ4Pq8AqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6YqP-001gvJ-R2; Thu, 22 Jul 2021 13:34:34 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6YSy-001bW3-SU
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 13:10:25 +0000
Received: by mail-yb1-xb35.google.com with SMTP id g5so8222112ybu.10
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E9r9uVnuNcXfAI11JfB/29V/jMcTVQxprw/1WIN4XSg=;
 b=KLPi8kjA3PUJYShcGJz9RjnV8s1Zyf7CJLHNfrXdxLvQUWaB+qCVdt05IBbzWKL6Fk
 EXqC3/nwswJNTfer4ctEQtC21dphTHd5mVYNrEYmTmRVv0nlfzdehjIIjgvJhuC/yM0d
 AJytpffV4WLsheDKXFdWgFS7zvq/DfAc2+sqOhZP3cYsnFEcqDGS5FZ4ZejmOcTGs7wA
 GizX24D8L+C4BFS1TtF40A3Pd7nyBbWb0AmVglhjbW3fDeLu+j2d0ATaP3HPXqMXFgSK
 CP2ds+cvHop0us6rPCuWtvrbUFm5BSmB5ypFHNix3Y9Mmt3PL+qmpInv0wTTgS0FbJ19
 z0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E9r9uVnuNcXfAI11JfB/29V/jMcTVQxprw/1WIN4XSg=;
 b=abtMt3jW/eHrOlKT0PwBsKRhGa2IYyTQdCJVR/9yZ2ElUW9iiQT6JzWqyQrED2TgWm
 mqywx4f1mm1JeckojH7Aq7drNwgJU/YPo9wvLgN2LMlo49+/HbR3R1CKVj6OXZQjRV9j
 VtwHefSE1FxtqCDiwROYMH9/wSS9QJBI6Y+Q+0iEy5DLO42duYBPknF0AEwcQklWOvGg
 mpNf8fE/+XvMVxm670KP942VHhV2Hu9Ly2DoY1hajksiWy2PWhB5kP3vzv/NNgp76pNh
 vK1dTsMJUf8XUfVZPqB8+akyOvXEARMd29ZfPiGGj1QWI+Ev3rAY3dby+2RgzvoywD3V
 gjBA==
X-Gm-Message-State: AOAM531ryEhPRcZeclH+gvU1cyiI8ldCrhey1ZhXYuyCGeUh3EBqTGZn
 7pvA39z9yPiTK+Y1tjNuWevcbpqsB8wiNxKl5KLHnA==
X-Google-Smtp-Source: ABdhPJxUZnFnJidC9QmDkN2l4ri35ZU3TXQ4d7hxHQ6oMksfsIsHdp6lOwVVQdtfW2vspoyPw1nfrySiC7zakBJA4eM=
X-Received: by 2002:a25:550:: with SMTP id 77mr52731774ybf.452.1626959418958; 
 Thu, 22 Jul 2021 06:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-2-borisp@nvidia.com>
 <CANn89iLP4yXDK9nOq6Lxs9NrfAOZ6RuX5B5SV0Japx50KvnEyQ@mail.gmail.com>
 <7fdb948a-6411-fce5-370f-90567d2fe985@gmail.com>
In-Reply-To: <7fdb948a-6411-fce5-370f-90567d2fe985@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jul 2021 15:10:07 +0200
Message-ID: <CANn89iLUDcL-F2RvaNz5+b8oQPnL1DnanHe0vvMb8QkM26whCQ@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 01/36] net: Introduce direct data placement
 tcp offload
To: Boris Pismenny <borispismenny@gmail.com>
Cc: Boris Pismenny <borisp@nvidia.com>, David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 Saeed Mahameed <saeedm@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 sagi@grimberg.me, axboe@fb.com, 
 kbusch@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, smalin@marvell.com, 
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org, 
 netdev <netdev@vger.kernel.org>, benishay@nvidia.com, ogerlitz@nvidia.com, 
 yorayz@nvidia.com, Boris Pismenny <borisp@mellanox.com>, 
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>, 
 Yoray Zack <yorayz@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_061021_003427_4042999D 
X-CRM114-Status: GOOD (  32.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 22, 2021 at 2:18 PM Boris Pismenny <borispismenny@gmail.com> wrote:
>
> On 22/07/2021 14:26, Eric Dumazet wrote:
> > On Thu, Jul 22, 2021 at 1:04 PM Boris Pismenny <borisp@nvidia.com> wrote:
> >>
> >> From: Boris Pismenny <borisp@mellanox.com>
> >>
> >>
> > ...
> >
> >>  };
> >>
> >>  const char
> >> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> >> index e6ca5a1f3b59..4a7160bba09b 100644
> >> --- a/net/ipv4/tcp_input.c
> >> +++ b/net/ipv4/tcp_input.c
> >> @@ -5149,6 +5149,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
> >>                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
> >>  #ifdef CONFIG_TLS_DEVICE
> >>                 nskb->decrypted = skb->decrypted;
> >> +#endif
> >> +#ifdef CONFIG_ULP_DDP
> >> +               nskb->ddp_crc = skb->ddp_crc;
> >
> > Probably you do not want to attempt any collapse if skb->ddp_crc is
> > set right there.
> >
>
> Right.
>
> >>  #endif
> >>                 TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
> >>                 if (list)
> >> @@ -5182,6 +5185,11 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
> >>  #ifdef CONFIG_TLS_DEVICE
> >>                                 if (skb->decrypted != nskb->decrypted)
> >>                                         goto end;
> >> +#endif
> >> +#ifdef CONFIG_ULP_DDP
> >> +
> >> +                               if (skb->ddp_crc != nskb->ddp_crc)
> >
> > This checks only the second, third, and remaining skbs.
> >
>
> Right, as we handle the head skb above. Could you clarify?

I was simply saying you missed the first skb.

>
> >> +                                       goto end;
> >>  #endif
> >>                         }
> >>                 }
> >
> >
> > tcp_collapse() is copying data from small skbs to pack it to bigger
> > skb (one page of payload), in case
> > of memory emergency/pressure (socket queues are full)
> >
> > If your changes are trying to avoid 'needless'  copies, maybe you
> > should reconsider and let the emergency packing be done.
> >
> > If the copy is not _possible_, you should rephrase your changelog to
> > clearly state the kernel _cannot_ access this memory in any way.
> >
>
> The issue is that skb_condense also gets called on many skbs in
> tcp_add_backlog and it will identify skbs that went through DDP as ideal
> for packing, even though they are not small and packing is
> counter-productive as data already resides in its destination.
>
> As mentioned above, it is possible to copy, but it is counter-productive
> in this case. If there was a real need to access this memory, then it is
> allowed.

Standard GRO packets from high perf drivers have no room in their
skb->head (ie skb_tailroom() should be 0)

If you have a driver using GRO and who pulled some payload in
skb->head, it is already too late for DDP.

So I think you are trying to add code in TCP that should not be
needed. Perhaps mlx5 driver is doing something it should not ?
(If this is ' copybreak'  this has been documented as being
suboptimal, transports have better strategies)

Secondly, tcp_collapse() should absolutely not be called under regular
workloads.

Trying to optimize this last-resort thing is a lost cause:
If an application is dumb enough to send small packets back-to-back,
it should be fixed (sender side has this thing called autocork, for
applications that do not know about MSG_MORE or TC_CORK.)

(tcp_collapse is a severe source of latencies)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
