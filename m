Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F44C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 07:57:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E491E64E71
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 07:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E491E64E71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=j5oZCTxnduaNYy5AorgJyA0zjN7s/0zsikjfqEOalBo=; b=XO4byPwn0CYsW4mawGeS8gKEh
	wDa535iZVG2vjwd2UPgU9ul+zxP9nkHX/vzRuu7gTSx0GlkW2FL1/2fu0DVk5tkBpenYVIHzl2XCF
	+hWaw3nVbkvrr0DPBFUbDmchxM8KZOxtvtTEVf4+P4U8M5T5zmLJm2NM0VFaXrHHqJwDHKTnIUI6o
	PcVHBaf6/UP0Juy1xC2RzVmNXAkXxc/eAM23/HftgXZoy3OkwKPKy7asLKoMIu/T0Udmplsat8tts
	diQ0fff2zClEL2XqT/MvW2At7wWVSR4sWmZNwNlHEoQ+Bt2NL153OosILvmSFf9bl9H7tTuE+EEt+
	MH4Fa74bg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBYlH-0002b3-Rm; Mon, 15 Feb 2021 07:57:39 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBYlE-0002aV-L0
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 07:57:37 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id l8so6258140ybe.12
 for <linux-nvme@lists.infradead.org>; Sun, 14 Feb 2021 23:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xRrCe72/CdWUDvsr0RGVjqqpypb4q7lznYDnnHmF084=;
 b=pSjla5YF0Fa48dyQsvdyPViGCk2Av/8w1S6nwtudRE3Sff8FTGB6X8vly+vbNR+5Rq
 Ylf7cR/+rnGuaB2XmF63neNKn6yV+Pc4vNk55JF3emkhTet75M5hnLS7Z7xZZ9MiP27H
 1bvlmoIpc6NjbITEWaXIZgwvEn4CQ7Hxlj6LSt0J9+wpf77+hQ/a9vCzLpSnKdkG2VnB
 14qRT9xG38UXBypOqy4PEw4tOU1J/2OY+mvLRKSf2JjRQrzsvtYKokHA+A9o23sE9vCx
 Ydk+FDMyei6NfGovROfZArTyGYnf0xXcnxGrABuJyHJ06GIO2yWkw91Foqa+Ki74e/Va
 zh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xRrCe72/CdWUDvsr0RGVjqqpypb4q7lznYDnnHmF084=;
 b=PkCoV4GC5zGh4iMTCAs3HyyUSRIYv4jwKj5XI1kejGfLUjgJfMIMuo3bTTZGqwQdCS
 3eEZU20qsBJIbrb3AtRiqO/o9XYXJLvRXhF5VyaE84nfabSPjvxHiVl8tHQAYicOlelQ
 +I60Mv6FCS4WxPIawl/hPLOzHxfze2n+dCaUzJMmwZN7ttldTzR4qQKOLEfDWJbJYE6u
 PBYHBAVXs+i07bpSti1VCCprTCNAUhQvTcB9WpL66iFprfRcDOWBsUKTsLLe++fjQQLM
 Xvfmq/eiUCDH/Jm16KDqRg03m4zXK3d5LkVUvwqlIP0jTE4lbfK28N5xMuRBe4BgNdep
 5viQ==
X-Gm-Message-State: AOAM532P5YAZ/EQn+GS/DOnNEafgulTvlGnxkAWZhD2iB5lwd4cvc0yU
 7LwJOV0Rulb5WuNF4cTgVlLmR354j17pnfyLbsI=
X-Google-Smtp-Source: ABdhPJz1O+cpV52RAzgq76H4yycwKHlcm4jQ0kMs+6/Bl50qjIETHfwy15kfD5sCrOOcALdHGM0RLc8EVGhcwcLR3JE=
X-Received: by 2002:a25:9383:: with SMTP id a3mr21111797ybm.215.1613375851909; 
 Sun, 14 Feb 2021 23:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-7-borisp@mellanox.com>
 <2dd10b2f-df00-e21c-7886-93f41a987040@gmail.com>
In-Reply-To: <2dd10b2f-df00-e21c-7886-93f41a987040@gmail.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Mon, 15 Feb 2021 09:57:20 +0200
Message-ID: <CAJ3xEMg3GWNVjkixVVop9uhn958Opdq4ej0qktA11NS6GM9s-g@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 06/21] nvme-tcp: Add DDP offload control path
To: David Ahern <dsahern@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_025736_729531_B02E603F 
X-CRM114-Status: GOOD (  10.82  )
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
 Sagi Grimberg <sagi@grimberg.me>, yorayz@nvidia.com, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, Yoray Zack <yorayz@mellanox.com>,
 benishay@nvidia.com, David Miller <davem@davemloft.net>, axboe@fb.com,
 Eric Dumazet <edumazet@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
 Or Gerlitz <ogerlitz@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Feb 14, 2021 at 8:20 PM David Ahern <dsahern@gmail.com> wrote:
> On 2/11/21 2:10 PM, Boris Pismenny wrote:
> > @@ -223,6 +229,164 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
> >       return nvme_tcp_pdu_data_left(req) <= len;
> >  }

Hi Dave,

Thanks for the continuous feedback. Folks are out this week and it seems
for that few comments we will need to discuss internally, but anyway I will
address at least  some of the comments later today/tomorrow.

Or.

Or.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
