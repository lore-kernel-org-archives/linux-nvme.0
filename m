Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B8C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 18:30:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DB364D9A
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 18:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DB364D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RVm7CzN9WQM2zjkvpgqsrTIYRnl8TvazHEu1LZUs7rM=; b=A2KCV4nZcIhUch1y4oUtTOKKl
	1kp8Zf+kv6ERaM1SOVahDEem5g9wWSy6wUvBBMl+W/IoRhD91U1NMiZK2MC+sWidfKMeAJWyys+A0
	xfyhZ3jiK/CLyRCRJttmIXOmqm2L+3+GJ7cEGl8wAaEQw07Zm5FXtdX+VpKkIRkOP2c1NgC6+Vkh6
	VPobojYiwCtNGNRntH3JBB7AJGdCb7vPShihsVSAgoHWrsYKOeDHNgQKtBYRPISS4tfLEngNgIS2K
	ddkVSG4BNRjSgYJjZrtVZ8sshMc51Qa/cLBGdZWYEjbQny8WBnYf2ExtTmUrnK+xnKtiqIee1EdIk
	Vpd47VqJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7jOD-0001yK-B8; Thu, 04 Feb 2021 18:30:01 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7jO7-0001w7-Kh
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 18:29:56 +0000
Received: by mail-yb1-xb36.google.com with SMTP id w204so4192537ybg.2
 for <linux-nvme@lists.infradead.org>; Thu, 04 Feb 2021 10:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eWgh0XkVaRWPuWo7WK7qz5Q0H3AISoN4etSff7sqhGw=;
 b=Zm8Jwd2j2XDdwDja/gEY8F0m/doWOuQFeKvwXWxdJhS2QyIi6oaf3OHot4DBk9Hqbx
 Q3TfccWb3tsqlbkXKHWfSk7PY+9bDCoofSB5v7UxmnKqt2DgL2ggzMzmG3OVmVf59v4m
 bAKEmhAT5C4En27IXXiIIOnPGYEp1Ugk9cM1Jhaj8noNTyLvpzvO+1vyn4+kIE3ucaCl
 qMK9L6C0qsNTQWYweqWEfebQaRHIH9Qw0t/Pt5L1S2iWt/jgaz0yg/AXpmqGbhJQu23s
 ftGltkD6+LUile+VMud9NATpK9oyWJspgiDAV704nfJnZ/riL3BGqcJ+GxeA0I/1q9k9
 UA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eWgh0XkVaRWPuWo7WK7qz5Q0H3AISoN4etSff7sqhGw=;
 b=oZXHqqRFFsZ+a4qok5oaCD6i7S5G14asT+vKY7/oOj8OUVv7M1rYtfRXCUF1xCMSIM
 ThDW+zvnFc5uBAZdrRXX+4KM3/Am+NsPuM8870258m7D9BofGvvnbY/+HV3Crfxt6WX5
 kLIhcxam1P7r6WEWZcijAuqSU2/IRwW0Xmn27YYoTrRHRcXcG+DY0leqmi8YtBlg2hNt
 y4os7mPex9MulhTHsid/Huy16lBcBCo7wX0LN0LvGwGH8HVaLZYViKZRvpMObg/HU5/+
 tmi+lEIq15RySnXXgbvBr1c9jppi5o62IbQnFEmT3OYKcN7Jy5U4mgPkTAfB6tyaFs/Q
 w1KQ==
X-Gm-Message-State: AOAM532UE+2CArB2HP+9atoVSdk7q5FydyM8WbQrndK/xSmr4qBEMh/I
 pt/hEv/b+2ADghxQ7QjN/aZhrUKWNXQTy/+aaRk=
X-Google-Smtp-Source: ABdhPJyPbmOvFiklD3H0VNXQr6NZf54rjz/Qni/kpYtt32m4+s71llCUvOi0m045SGW63zF5Gn5rMFTsMJzoP//s2f0=
X-Received: by 2002:a25:ba13:: with SMTP id t19mr763188ybg.129.1612463392132; 
 Thu, 04 Feb 2021 10:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-10-borisp@mellanox.com>
 <c864eb96-18ea-21dd-3ef3-15ca908c5959@grimberg.me>
In-Reply-To: <c864eb96-18ea-21dd-3ef3-15ca908c5959@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Thu, 4 Feb 2021 20:29:41 +0200
Message-ID: <CAJ3xEMjzh=PEqLNwW5RMtofskGQubD3Z5+CR_JhuCUCH50jtGg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 09/21] nvme-tcp: Deal with netdevice DOWN
 events
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_132955_722548_F685124E 
X-CRM114-Status: GOOD (  14.57  )
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

On Wed, Feb 3, 2021 at 11:17 AM Sagi Grimberg <sagi@grimberg.me> wrote:
> > @@ -2930,6 +2931,27 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
> >       return ERR_PTR(ret);
> >   }
> >
> > +static int nvme_tcp_netdev_event(struct notifier_block *this,
> > +                              unsigned long event, void *ptr)
> > +{
> > +     struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> > +     struct nvme_tcp_ctrl *ctrl;
> > +
> > +     switch (event) {
> > +     case NETDEV_GOING_DOWN:
> > +             mutex_lock(&nvme_tcp_ctrl_mutex);
> > +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
> > +                     if (ndev != ctrl->offloading_netdev)
> > +                             continue;
> > +                     nvme_tcp_error_recovery(&ctrl->ctrl);
> > +             }
> > +             mutex_unlock(&nvme_tcp_ctrl_mutex);
> > +             flush_workqueue(nvme_reset_wq);
> > +             /* we assume that the going down part of error recovery is over */
>
> Maybe phrase it as:
> /*
>   * The associated controllers teardown has completed, ddp contexts
>   * were also torn down so we should be safe to continue...
>   */

sure

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
