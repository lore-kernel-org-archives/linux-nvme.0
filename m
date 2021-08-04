Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D5EC4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 13:27:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF04760F43
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 13:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF04760F43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qnxQx+ZEIHxpuRkecQKH/I0WlFs/2OrLREWkAFm6Drc=; b=OFBUQDpM2SquSc
	N+oQnf/2nCGVk4s8GMVoS+/Oq1d4Rk63+MZ96flIqrrSDf7bhD8kHe0Sm1lNXFm/3aEJK2yhq+uL8
	+58w5Gd4ZLBuvSqt2u525XzfgTv1muA2A2e678rfy5C7wAdN0T2/yXCuMZUdJ00f4NyWG64tg+pMa
	hsN3z1fsxRDZWK11r9lgIuxn1z5WXBVz1RsTgFje+iLeuovJUgKrb5jcm8PUMQXVO4UdM3Xj+2iW5
	n1jInNGunMXOwbtWzrJUcQPfbw+OChV80u0X+ofK4eajy5yKHTKLtacswwmbG521qszN/+OFqOrXP
	fKLZVhGhCifuUlB/9kvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBGv0-006A8D-Bm; Wed, 04 Aug 2021 13:26:46 +0000
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBGux-006A7l-SZ
 for linux-nvme@lists.infradead.org; Wed, 04 Aug 2021 13:26:45 +0000
Received: by mail-io1-xd29.google.com with SMTP id s184so2389584ios.2
 for <linux-nvme@lists.infradead.org>; Wed, 04 Aug 2021 06:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dYdEg3FEjnNJNThyUvC517fEe1eHnKogxE9Vzfv1UIY=;
 b=pyuZLS/FOfE/HBGll+dPoZ1LtOgBykNvSiMNx5Kqhp/Ypy+svNMfDD4IVaPagLGLoM
 L4MXI00DzGsGUTi/nnu23RMlKv8X7QhmSMuEJd9dTbLVyLWHuMGhbM4Qhm/aMxyeeUOq
 nUmTi63s/xOtwLZZN465P50BtDaubNZgKKGjf4wPW0E2x5c5OQrJ+TXEIMxeYWw+cKny
 idm9y51ARmYxC58XFBZOk1Km6GxfVy02QHpI3wWp+eLFOrvciJzlQEHsYDWGqXQ306SC
 3aD++ejy5rJMQyjyg1daDJhKE0rJYoa5ZDskmj+BuZ2HLfzTcE58/6fW+mRVS0Vw7YV7
 kPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dYdEg3FEjnNJNThyUvC517fEe1eHnKogxE9Vzfv1UIY=;
 b=F61T8T3JJXR+6V/SD4s94YjOfmA6pCrvBSyvrNCYPotMGJ/JYld/VdNGQNyFI+PC3c
 2oLqFLDgt6QLdJGdMGavioZNycZvEyk/Z7GCfHPAKFQ8mywSdcyAK/Qds/LvIyT1ROau
 quslXrP0RdREuQe5FzQIgogjRi68wnSo3fsrrm73z7da2C8RlKj+Nsr+TayG7n5cE9Bv
 YtG+SZ3YXkQDHb7Lv3JTyv0fWpCO7o20uS0+KV+z6kffLaiJ5kQOVG67PbbI3NoDvwlY
 v/ON+9rahDSwcdCC7yJNQAEYQHBkaA8dUSb/jBGZNfToVeRJvM68GB4+bBiwif4PjYDE
 58ig==
X-Gm-Message-State: AOAM530/n72+vP2wQHD5Q7ecb8kJbjrZWoCjlRZ0UqNNK1Kymo6u/Dnv
 HRUBdD0sAcQyUDqASxlNN1Lm8RnVcQkOa3PP/eE=
X-Google-Smtp-Source: ABdhPJwHCkpNkLRfonCftH7xrpR5xKYOfBuU7tCEvKhzz4cL8l/tVlCLekEnJrlwYG79KY2VRUDXt2bCOoRTN5pbiAM=
X-Received: by 2002:a6b:e602:: with SMTP id g2mr286609ioh.50.1628083602175;
 Wed, 04 Aug 2021 06:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-5-borisp@nvidia.com>
 <20210723060631.GA32369@lst.de>
In-Reply-To: <20210723060631.GA32369@lst.de>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Wed, 4 Aug 2021 16:26:31 +0300
Message-ID: <CAJ3xEMjFOPFfU4ibFJPYdYUSh0nFkRwfW1cdAV2BMvg1aaP_eg@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 04/36] net/tls: expose get_netdev_for_sock
To: Christoph Hellwig <hch@lst.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Boris Pismenny <borisp@nvidia.com>, David Miller <davem@davemloft.net>, 
 Saeed Mahameed <saeedm@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 axboe@fb.com, 
 Keith Busch <kbusch@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Eric Dumazet <edumazet@google.com>, Shai Malin <smalin@marvell.com>,
 boris.pismenny@gmail.com, 
 linux-nvme@lists.infradead.org, Linux Netdev List <netdev@vger.kernel.org>, 
 benishay@nvidia.com, Or Gerlitz <ogerlitz@nvidia.com>,
 Yoray Zack <yorayz@nvidia.com>, David Ahern <dsahern@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_062644_006475_2FF25BCC 
X-CRM114-Status: GOOD (  15.49  )
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

On Fri, Jul 23, 2021 at 9:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Jul 22, 2021 at 02:02:53PM +0300, Boris Pismenny wrote:
> > From: Boris Pismenny <borisp@mellanox.com>
> >
> > get_netdev_for_sock is a utility that is used to obtain
> > the net_device structure from a connected socket.
> >
> > Later patches will use this for nvme-tcp DDP and DDP DDGST offloads.
> >
> > Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>
> I don't think this should be an inline.  Please move it to net/core/dev.c,
> andd add an EXPORT_SYMBOL_GPL and a kerneldoc comment.

Jakub,

What's your preference here?

Or.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
