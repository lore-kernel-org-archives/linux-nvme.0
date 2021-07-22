Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B6BC63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:45:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB3A61244
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 13:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB3A61244
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7lFASeXE0Zz5vr5+PIjv33zNWqtVj80hic8IAEJ1emQ=; b=DeZAausjn0gBwR
	9rif40dsiC5UAcxgSqqT+5aMGErghSgLnkVrNA5cyXH8S9fXRIxzPPP7uFq8DSvALvak66cIqvJF2
	YHEpWGn0nky5MK84OOv6u33TKE37HFiCe/Q3578TF52ckLzRRzX0bYpBLy14rTRooa0mlNPBEO2j+
	uRkYImRpfikUliD6mQ7vyj+ToxhhyFZACQ/nT6FF9/DYHc+6Gn6j02zcIG/FB0TPjGzvg7DcocGgs
	uefTOsyszO5FzhQO6QMUOdFQgM7nYfJ1FZ4oP5dWVX1AkQFSe2wRBTQG50axdAINeVqShzuLVrtWO
	jx+esZ6crTsweAr4gdRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Z0o-001jdA-1b; Thu, 22 Jul 2021 13:45:18 +0000
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Yvq-001iJQ-0P
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 13:40:11 +0000
Received: by mail-yb1-xb2a.google.com with SMTP id c16so1545706ybl.9
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 06:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=t/SYEUTpMcYPz7ljfmN2tSvSvDf5PRFbAVjr0C0ufJo=;
 b=Z6pmogOABigg8nzrH2VHgN59Ye6w3ShFXG4i+q7xQd0Bb2BOXwYjLyyZTjv/AXSQum
 p5C8jK/0KJWOROT1gB3IExD+t9qo3MFxYomri2BquX2NOyNMrfq3FFXxkNcEX6DkFfHC
 FKPUcKPqfeD0JtdnqWzvattypfXCdC3vnOFOvTFQtyHEVqbqQfbl/Yh7PiAekWczQIoU
 Yym+3QmGE3KCXcGfRPigHLQR6SLhJbtlUmcL5X6K4PWtVu5ZUHZ83UBp0/Drj2oGrQEt
 wSSNUbx/3/Ak0IxJX35hFnUNnKdIdiMrhBQKKCJI8kNzWSjLRPvclyLQYP0hqxfaeIGF
 q7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=t/SYEUTpMcYPz7ljfmN2tSvSvDf5PRFbAVjr0C0ufJo=;
 b=U+H3OMmr7xzgXY+uGBgAswMt3zaU5R6xjD4Oqe7OdmaR+hU05gyyz3+KMOUCSW/+Zh
 AqpI3GN6+dAxuoYPdtOsFq/i+gp9G58ykW1FNzYOlc+56p0bGVgH8D5Hr3WtHvFD0Vt2
 AQdXxsgeNUUcQj+1dnmeFE+0xiDWS2pZouG5HQhYIuylV0kREy8QSiWqfNcxtcKzeoQK
 0hRhM4mhewl5piAZyndgT+cwiPfk4YZSllw7J0Gnu2C54DXu9tMlxeumcPli14mVVnF1
 offJrIAv5LMz91TVVh8uctiYHUobILhnRF0QiRyM+uARgPxt6AJUiDvxsH1apAvcuGyF
 zPlg==
X-Gm-Message-State: AOAM532czKJpeP+9FiujMgL5MyPuAkng8FkFWjcsf5InfVaZJOuPvGI1
 wsZhQorT+wiSleX03zkLpurG2Nl7Us5qtLkwIcfx4g==
X-Google-Smtp-Source: ABdhPJwAMPt2rCrRmZCZp2l0hbRR1pf0HqduTCNcfwu0o+n2AKY27xHTkl/8rX/MYaOvFX5QrKjzeOXVJc+aiSgWK/o=
X-Received: by 2002:a25:f0b:: with SMTP id 11mr51639739ybp.518.1626961208474; 
 Thu, 22 Jul 2021 06:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-2-borisp@nvidia.com>
 <CANn89iLP4yXDK9nOq6Lxs9NrfAOZ6RuX5B5SV0Japx50KvnEyQ@mail.gmail.com>
 <7fdb948a-6411-fce5-370f-90567d2fe985@gmail.com>
 <CANn89iLUDcL-F2RvaNz5+b8oQPnL1DnanHe0vvMb8QkM26whCQ@mail.gmail.com>
 <ba72f780-840e-de73-31b3-137908c52868@gmail.com>
In-Reply-To: <ba72f780-840e-de73-31b3-137908c52868@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jul 2021 15:39:57 +0200
Message-ID: <CANn89i+kHx5zzKcPQZ406fw9DWchxXrNJQhqwGe2_=hvrxSwYw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20210722_064010_126051_42C72E5A 
X-CRM114-Status: GOOD (  16.33  )
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

On Thu, Jul 22, 2021 at 3:33 PM Boris Pismenny <borispismenny@gmail.com> wrote:

> Sorry. My response above was about skb_condense which I've confused with
> tcp_collapse.
>
> In tcp_collapse, we could allow the copy, but the problem is CRC, which
> like TLS's skb->decrypted marks that the data passed the digest
> validation in the NIC. If we allow collapsing SKBs with mixed marks, we
> will need to force software copy+crc verification. As TCP collapse is
> indeed rare and the offload is opportunistic in nature, we can make this
> change and submit another version, but I'm confused; why was it OK for
> TLS, while it is not OK for DDP+CRC?
>

Ah.... I guess I was focused on the DDP part, while all your changes
are really about the CRC part.

Perhaps having an accessor to express the CRC status (and not be
confused by the DDP part)
 could help the intent of the code.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
