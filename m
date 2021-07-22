Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E5C63793
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:43:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38C06128A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 12:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38C06128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rw8qgpWun1mRg90pl9Ie7qWViZuA6pvCUVR8Y6rSDkc=; b=LcV5dT+otJqaN8
	qHtSjCtlTXrjw9xYaPL6Y5vP693d6afCwhRbMj3m5D1LF3q8EoqZcE0VjfyY5zQZplyO0JNRxRj3L
	K42nLoxq0xjOqBEFN6MTlicrJIE2xhUcsozIgFjT6HYBrUM5tsMrcPZtjlA2tbULVguI6pb7Z+HIl
	JucW2f7xLv1rQX/eFGfEO4YAMZ43OGo9zISdd1FhophpKNBRLymHnGOjPV4hb0YFRl3pALycRdvrl
	TrCpRnyV+MJDU4J2tT1PiHROMglwHh6jxEaaQazp8H4xgFtV2mp965X23+iJCP3irRMzHsR91t4O3
	SnWaT9aBaVRllNk/ijYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6Y2u-001WUW-Kp; Thu, 22 Jul 2021 12:43:24 +0000
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6Wqt-001MHt-8Y
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 11:26:56 +0000
Received: by mail-yb1-xb2c.google.com with SMTP id t186so4974203ybf.2
 for <linux-nvme@lists.infradead.org>; Thu, 22 Jul 2021 04:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LY/3UQVMLCt1YmqZR3yy9aFu3cFmtUpm6v8HH0OSmpc=;
 b=DzQJSlI/+Mu0zyH8vlobVbL5E3AUDLfvusB5aX9EK/4Qdr0LwIaNjK64Smd0Ez3eBC
 Jza1U59xvhpt9V4o0kuew5hXp3MLmNsQDRurz3U/iyFIt8d4yCF6X6v/W8WgfXX8BBgU
 Oc9rnZucceIOUiCAm/y85j4vT0sN15aTpMSy1EeGobg+r+zcPxjmr1AJ+dOg32EIfuGI
 IYOpUQC+FPdeWb/xt7CkFPw0SmZmTjNMih2HKR5KC8ThtrJQxoI+QpNSlT3avs5WOEnC
 zLI9kFQwnzSIQbCf5hSOw9rMpMiQS8RzxZ1XiST4DFxAvq/jce9enPnQnJRx9bV4VhBG
 Bs6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LY/3UQVMLCt1YmqZR3yy9aFu3cFmtUpm6v8HH0OSmpc=;
 b=La7WSLRbtvOFzeSIktmB6qieKCxz3/ZyRlrWHgc2UbpTM/qhLCRo62Jb++bm3jMVEI
 mKBT9O8QxRrxqZ+aZsH8VUFtejIfRdPc2++rNIKe9tLIXK6ou2bBe57lpVXLdFbRpqGY
 SosMg+teBFGh/8VMj0rsZN4YByq2/9yAXqGe96JE7NRCsMlRzrAVVlQKMjR6F64mHCPR
 EGHonJnYEBqsRtOWN2XfXxyt12/iWolxYWxNFXScIS+EaVc+A+cPWB0n27AswyxCuxdz
 Xb08o8DPRGny97teyD7ohrQrVHv8UAyJApUoBKVW3l3QnB4U4cT7nFz1VPvNod/iNLvH
 tIIQ==
X-Gm-Message-State: AOAM532PU+ytRcuTtZQLnPTyxsg/41BKz8XhDH8bUYd1ZwGgkbDHQWGy
 zlaTXrr7isqp7M1dmHl+hF3xBqeEJrxoEh4X5KTKAw==
X-Google-Smtp-Source: ABdhPJyL4vwqaMpNugwufDInzlGAlBzOgDGT0wpkeVoth+W+20J79EbDnLUBZEHhtECw0hpcbHNjvL+caHgL2+V33GM=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr49814639ybj.504.1626953209728; 
 Thu, 22 Jul 2021 04:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-2-borisp@nvidia.com>
In-Reply-To: <20210722110325.371-2-borisp@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jul 2021 13:26:38 +0200
Message-ID: <CANn89iLP4yXDK9nOq6Lxs9NrfAOZ6RuX5B5SV0Japx50KvnEyQ@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 01/36] net: Introduce direct data placement
 tcp offload
To: Boris Pismenny <borisp@nvidia.com>
Cc: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 David Miller <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, 
 axboe@fb.com, kbusch@kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
 smalin@marvell.com, boris.pismenny@gmail.com, linux-nvme@lists.infradead.org, 
 netdev <netdev@vger.kernel.org>, benishay@nvidia.com, ogerlitz@nvidia.com, 
 yorayz@nvidia.com, Boris Pismenny <borisp@mellanox.com>, 
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>, 
 Yoray Zack <yorayz@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_042655_346239_3BAFD935 
X-CRM114-Status: GOOD (  15.62  )
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

On Thu, Jul 22, 2021 at 1:04 PM Boris Pismenny <borisp@nvidia.com> wrote:
>
> From: Boris Pismenny <borisp@mellanox.com>
>
>
...

>  };
>
>  const char
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e6ca5a1f3b59..4a7160bba09b 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5149,6 +5149,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>                 memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>  #ifdef CONFIG_TLS_DEVICE
>                 nskb->decrypted = skb->decrypted;
> +#endif
> +#ifdef CONFIG_ULP_DDP
> +               nskb->ddp_crc = skb->ddp_crc;

Probably you do not want to attempt any collapse if skb->ddp_crc is
set right there.

>  #endif
>                 TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
>                 if (list)
> @@ -5182,6 +5185,11 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  #ifdef CONFIG_TLS_DEVICE
>                                 if (skb->decrypted != nskb->decrypted)
>                                         goto end;
> +#endif
> +#ifdef CONFIG_ULP_DDP
> +
> +                               if (skb->ddp_crc != nskb->ddp_crc)

This checks only the second, third, and remaining skbs.

> +                                       goto end;
>  #endif
>                         }
>                 }


tcp_collapse() is copying data from small skbs to pack it to bigger
skb (one page of payload), in case
of memory emergency/pressure (socket queues are full)

If your changes are trying to avoid 'needless'  copies, maybe you
should reconsider and let the emergency packing be done.

If the copy is not _possible_, you should rephrase your changelog to
clearly state the kernel _cannot_ access this memory in any way.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
