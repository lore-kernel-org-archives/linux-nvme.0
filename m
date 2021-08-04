Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D91DC4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 13:51:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D9C60EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 13:51:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B2D9C60EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vgKmx/hxDH0eFGRxuk56+OT7fj9ke3zywYt0+OwFaBs=; b=3oOwtDGh+HPkdw
	KQyHJlRtZfJvafjvQrH7zwCbM7lc+CrO+UOmuk0hM+sbhqiD5DncDWRNTvePdreJ4udHXn9gNxdcz
	1yN5fs8F3cl+ygKvqNakBVafCLEiZCpxaSwMGWXmlmO6ShiVjny54btT8R6ZIY4Zob0tDiyyZWToj
	HWyBBHb2eTr3BNq2hW1nOCNxUVg7xrDC4aTcn2wNS5F5bJIPa650WSXfTKmg+cqVclhEiXjDQR6QU
	xCQ+UzL1I8OG4IoJRgU3CgWpMNGQth90uLkOIaEjyedg9SNLHeiNQOQO0Ylb/TPEee74bwsWDWfKa
	f1r60zR274vY7ytL3dRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBHJ9-006CqX-OV; Wed, 04 Aug 2021 13:51:43 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBHJ6-006Cpp-3J
 for linux-nvme@lists.infradead.org; Wed, 04 Aug 2021 13:51:41 +0000
Received: by mail-io1-xd2e.google.com with SMTP id y200so2491040iof.1
 for <linux-nvme@lists.infradead.org>; Wed, 04 Aug 2021 06:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=68nPIx50G72fNHdU1dcBEsPtx3OF9xmvajVBIyCS/po=;
 b=qPayotjezohGISbFc0kL/JoSZmCfzaa9gtukgjIfhkhs24b15kO53YIUvTe1cg8JtO
 OoYS86Lkwd0Q+Q4l44kZDefCpFAXXGfJ7glm1DkY3RKl9WCaed5QYICankMU/h/UF4u0
 tEAbcRm0mCgBGBJMpHErxs5hWriK9njJqhDEM3fTcpqI04WxTC6G2tC3Q9mB26wWez8v
 XmqmPSMCte9pCEY6Mzy6qvKC/NX6d34kkrMooMr/liRidv8/YXdgNbKEw2rYoV4u6r9w
 IqnHYERy2PFy3o0EZydJzoP3jvRdqZTXhA9KX2IBVFbYdi+N/CTS0I5zXec7xYjplPDj
 LETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=68nPIx50G72fNHdU1dcBEsPtx3OF9xmvajVBIyCS/po=;
 b=pg6+oOCso8UjCSBCJt97R6X1+x2GvZ5kbqj6yTCIyVG+SeRqHOvjXiY0jaEQXSqWyV
 M9yfvbEc4D8IyufsLw6Aa0ciBPBDMufO9fyO8quOKWnhtVcMgTy1eekAaUs9Ygy7/7l8
 Kt8zQzx/Ggy6e+GQ0m7tlU/PwA4z3X6am36gTwCyTS6u+R/vcVIiDKKIfzzte/tntApV
 zHmk4wiPDxhsBRbGGcLjmsamE9LT89HJg74RXWnIsTGeeJyz3TeTOmxRSXwIesx/igeE
 lDuHvc27XSNvK6v3WmbublxX2jfrymwjEXb1lE0XRDZBx/HMNNHvdXnoSydxTLgNGREY
 cIzQ==
X-Gm-Message-State: AOAM532oj4ypBBbsQirr/949GTwAVcOpHD29piAxeDOFsJazOYrY/nz8
 4QvvKOBHSYIR2gREix6UiHVwGMrcHdb/EzFkvY0=
X-Google-Smtp-Source: ABdhPJx/s5W4aY4K+0PL8ycaC5ei0GbKojAogtOUr3HbryX7jmwMlpuUnAvnixVbtuP6fbqpISKI76GlF6qY4HOpRq8=
X-Received: by 2002:a5d:96da:: with SMTP id r26mr872103iol.47.1628085099337;
 Wed, 04 Aug 2021 06:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210723055626.GA32126@lst.de>
 <02c4e0af-0ae9-f4d9-d2ad-65802bdf036a@grimberg.me>
In-Reply-To: <02c4e0af-0ae9-f4d9-d2ad-65802bdf036a@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Wed, 4 Aug 2021 16:51:27 +0300
Message-ID: <CAJ3xEMjzRqrj-EN7gbqKmD5txAV-gZn828V+6QAf5wfwYsqySQ@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 00/36] nvme-tcp receive and tarnsmit offloads
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@nvidia.com>,
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 Saeed Mahameed <saeedm@nvidia.com>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Eric Dumazet <edumazet@google.com>, 
 Shai Malin <smalin@marvell.com>, boris.pismenny@gmail.com, 
 linux-nvme@lists.infradead.org, Linux Netdev List <netdev@vger.kernel.org>, 
 benishay@nvidia.com, Or Gerlitz <ogerlitz@nvidia.com>,
 Yoray Zack <yorayz@nvidia.com>, Boris Pismenny <borisp@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_065140_198313_AA0F269C 
X-CRM114-Status: GOOD (  16.90  )
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

On Fri, Jul 23, 2021 at 10:59 PM Sagi Grimberg <sagi@grimberg.me> wrote:

> [.. ] It is difficult to review.
> The order should be:
> 1. ulp_ddp interface
> 2. nvme-tcp changes
> 3. mlx5e changes

.. and this is exactly how the series is organized, for v6 we will drop the
TX offload part and stick to completing the review on the RX offload part.

> Also even beyond grouping patches together I have 2 requests:
> 1. Please consolidate ddp routines under a single ifdef (also minimize
> the ifdef in call-sites).

ok, will make an effort to be better in that respect

> 2. When consolidating functions, try to do this as prep patches
> documenting in the change log that it is preparing to add ddp. Its
> difficult digesting both at times.

to clarify, you would like patch #5 "nvme-tcp: Add DDP offload control path"
to only add the call sites and if-not-deffed implementation for the added knobs:

nvme_tcp_offload_socket
nvme_tcp_unoffload_socket
nvme_tcp_offload_limits
nvme_tcp_resync_response

and a 2nd patch to add the if-yes-deffed implementation?

This makes sense, however IMHO repeating this prep exercise for
the data-path patch (#6 "nvme-tcp: Add DDP data-path") doesn't
seem to provide notable value  b/c you will only see two call sites
for the two added empty knobs:

nvme_tcp_setup_ddp
nvme_tcp_teardown_ddp

but whatever you prefer, so.. let us know

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
