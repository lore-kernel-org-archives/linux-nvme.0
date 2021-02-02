Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D597C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 18:14:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E580D64F94
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 18:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E580D64F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=z7P1XL4WcGCe/qlYzeRCfi4zBZmYCCzvaF4gQQgo468=; b=TWgdsbIswev8AT2E1z2jH01sK
	iFdTqvoLPkJFu+PuUrqlB2UJeKId/5ZKEYcEAjYSEmA01UgFJVTywEQeoEytsjyBeG0s/3gH39KkU
	GgYe4Y+9x3iwDsCWJ7EmIFjvPQS3MoKl8zJdU/jqeZruU4NPyzYhW126TwVj2KNkamhqIjOeLQlnb
	6q8n+Bk6xXZ7/nUlohzjff+zM3zRgxinfOzzEzC39UVcfftBIddtUizWAooKZl6sSrSX008d5n1Wi
	ZTUh4/b4cEsMcA0CBEg3zZvI4nOt/r/EVZPq3KAFSLHW2k+E6gtBuXZQj8VFOBzPF4uQc+CW0PGfA
	j91T77EGw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l70CL-0003tX-OW; Tue, 02 Feb 2021 18:14:45 +0000
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l70CJ-0003sg-JJ
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 18:14:44 +0000
Received: by mail-yb1-xb35.google.com with SMTP id w204so18523638ybg.2
 for <linux-nvme@lists.infradead.org>; Tue, 02 Feb 2021 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Q4Yet8/ICUuecxx3G8n77Q2xsvxpIESRvJ/T6154iuQ=;
 b=NhN8vrvP2eO34zTWQNC5MdOiqQA8HXgPZY/h5EGUpkHwzEZ2go5Mfq49nEITvGje9w
 s5eF/Gi4b8T3YprD3BsTD1jGWr4EZJca4IA8kt9WckVCsZL+dxPSpWUrYkhLsWvcVeUU
 cUL1g0NWyFF7cFZoxWKqj8kzbdWcmCPJyxK/+NCq/E50xQ7hdSBDFxpT31b1QcrPof1i
 QeeLXomoBFPeNZPV4CAgRgIM9TZujLSsxmvgIjoYsawAO5fKEYx/S21t7raOSfKQ5lON
 R8zT5gXg3TXPjBHebvRkQkJuYadIYReCo5QjOLaB+E3JgwTKtdT5sESsQrKvzZ4Gk/Pd
 Lxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q4Yet8/ICUuecxx3G8n77Q2xsvxpIESRvJ/T6154iuQ=;
 b=dpu+p2+KEdsp6HnRmsQFVEYO8olDV7YTddFsIDVegKS7/Sj5gmnyyk2j6Ola1+0qfW
 ctTZ8E/XWjwC0oFdf+NLEPfalcEl5uzywRtq+jbcu5C0PLtQqRENF9k0GVbG5wC32fq9
 zb5SKZ/lyCbh3kPjjnG1UEcdBPeDvPVhTypOsrHhGse9xjmiVMdSJvTpvJIFdTDBiAai
 r2ns+XJJ5LZyNmkISgaYFReQ9sE+EsNNfSRit8DhuwInLeSABmS60OoCuWZ/02ZUGfrO
 V2y035JBLMHspjLi/cT4JZksfzIqhlBCb5LJBOKrDVDOQRX+uGLCGVEvYwwxGzC8Mzeu
 cbPw==
X-Gm-Message-State: AOAM530TV3NAhQCMc2QTRWy7RWgHOi+8F1+B9l93f9AIwbLjs35kYOg+
 TteU9gwoCbfeO4Ebm7LDHaBmctJV07cv+7vDn04=
X-Google-Smtp-Source: ABdhPJwuULxnYDOw9vRvGPNO1pzxjIRiQYMajRXjd92soZGhut9VeX5yjyuWhRPpS/rAlGuSs3I5CJ702h6r3k4J7y4=
X-Received: by 2002:a25:76ce:: with SMTP id r197mr13366975ybc.11.1612289681486; 
 Tue, 02 Feb 2021 10:14:41 -0800 (PST)
MIME-Version: 1.0
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-8-borisp@mellanox.com>
 <20210201173744.GC12960@lst.de>
In-Reply-To: <20210201173744.GC12960@lst.de>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 2 Feb 2021 20:14:30 +0200
Message-ID: <CAJ3xEMhninJE5zw7=QFL4gBVkH=1tAmQHyq7tKMqcSJ_KkDsWQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 07/21] nvme-tcp: Add DDP data-path
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_131443_645645_2FFC6978 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
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
Cc: smalin@marvell.com, David Ahern <dsahern@gmail.com>,
 Boris Pismenny <borisp@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, yorayz@nvidia.com, Yoray Zack <yorayz@mellanox.com>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Linux Netdev List <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com,
 Saeed Mahameed <saeedm@nvidia.com>, David Miller <davem@davemloft.net>,
 Or Gerlitz <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 1, 2021 at 7:40 PM Christoph Hellwig <hch@lst.de> wrote:
> Given how much ddp code there is can you split it into a separate file?

mmm, do we need to check the preferences or get to a consensus among
the maintainers for that one?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
