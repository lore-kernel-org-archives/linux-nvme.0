Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A613C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLSwOWFY8u6E5fLHUkZmlThgK4Uo0S+g5manfostVQc=; b=4TAu/VJTSU2OE72/iMcOpJAkqq
	BWP9PIwX8BqyBBygmXQsGfvb9zPtTYwVPqegy19TTowZUS1mF7WDShSUmgAAHPn6kR2sk8HBHO6E6
	AN1ey3hhzH5KovQuYbDF2zsIcd4sz3NxMjcnsMNzEdMDgYfrWAtqGFQ4M6k3Y29UQXye9y4CmII3U
	rvVuYwPCL3Jx0+OtVUGmBbU3DBigRAuZViEZ+IVwGJbGx7q0NIAsaNwRhdPJUqaAcI0WgoMZ27hpc
	HEoFsj1aEw23EcpnMAj4AvdNvifj4axRZSQvfR9xSw7IItE67BwLYPMWmIDEYyB1eixRTQTrzL75X
	iRBi3fcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbmM-008Z8x-7Z; Wed, 26 Oct 2022 08:28:50 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbmJ-008Z7y-Aq
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:28:48 +0000
Received: by mail-qk1-x735.google.com with SMTP id x26so104951qki.0
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 01:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MLSwOWFY8u6E5fLHUkZmlThgK4Uo0S+g5manfostVQc=;
        b=XAeQFLugcon26no+DfmTPEV+PN8pOrRxNSy3aO2qp4Py8CVjyzlVTGflPAruI7kNLz
         eR2p/8GfFeZB+zd7NrpLCLAhkDL0zobCJAECug7+u2tI09f806IGtwLbR//SpCe2WbB/
         TyZ6FGQAY95ScGkWqjyo4FRx4JJwLynCa7f/9HIeiGe87mH0CHI2OroFs/ui5uAYFYWS
         MvNDWQS7G+1ZEInGJDg2RLEB5DB3cEIZBsp7bqqvEMY+xa3QGAQriYQUX4QVSxnmnTK3
         ng2a4hpcgtrg7AiE/Xn5Mts5piMZ2uiydOPi5N2wt5CBusN40OkNWRomaG12VrMS62dH
         UmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLSwOWFY8u6E5fLHUkZmlThgK4Uo0S+g5manfostVQc=;
        b=P8FocYOOER1vKHzIF38YEwFTnXfNgkJwKnf8Sg03q6Q0EHf70bxhLqJBQvCLD3ZyPb
         3ReOQRz5w/GNJDHIZyF6ocdvodhlhkn4p0WOO6HNCi/R05Bp/06wQ7zAsAnzN+b38azv
         UEclhCtivPo9JasJY/+jbEgOorDonz3KtNhZulI+aiOPHdU0ev7KrrsmiivbYkRdM3iS
         w4L80x91iBnxez7bdBZsMNuQ+ZjGUkuRNz9d9KgSgTV97IwQe2hG84HCPCIlkavqy+rE
         EwV8rZzSKUi+KznfFgcnYgMiJ9zfV0NT++nbHJnzK5WZFpjEF4Of24d4VGm7yM/mdNVn
         Vu9Q==
X-Gm-Message-State: ACrzQf3JRTebqtpYZPP/0YC4orMqMuAkyJLT0KDoEL6qvkHLq9JzZ3ep
	Y0dCq65rNyZsnHjKrmqq3zKrVmZhOFTuOYzU714=
X-Google-Smtp-Source: AMsMyM7Jw8Jfuk6f78c6WHth+TCmxkqeF/ei8KTlOn3wA3MlETNwu9z1dGxbXsXlqwDN4B4aHkvJSgXzHXTGKTpuC6c=
X-Received: by 2002:a05:620a:f11:b0:6cf:be4e:e953 with SMTP id
 v17-20020a05620a0f1100b006cfbe4ee953mr29846206qkl.437.1666772924405; Wed, 26
 Oct 2022 01:28:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221025135958.6242-1-aaptel@nvidia.com> <20221025160039.GA26372@lst.de>
In-Reply-To: <20221025160039.GA26372@lst.de>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Wed, 26 Oct 2022 11:28:35 +0300
Message-ID: <CAJ3xEMiwkNsqOJy-0m9r3MNn+x-To00Pi7a4TifSJYPJbv=pYQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/23] nvme-tcp receive offloads
To: Christoph Hellwig <hch@lst.de>
Cc: Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, leon@kernel.org, linux-nvme@lists.infradead.org, 
	sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, 
	smalin@nvidia.com, ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com, 
	aurelien.aptel@gmail.com, malin1024@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_012847_405272_28871CFC 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 25, 2022 at 7:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Oct 25, 2022 at 04:59:35PM +0300, Aurelien Aptel wrote:
> > The feature will also be presented in netdev this week
> > https://netdevconf.info/0x16/session.html?NVMeTCP-Offload-%E2%80%93-Implementation-and-Performance-Gains
>
> That seems to miss slides.

to be presented on Friday this week.. AFAIK slides are uploaded little later

The design/principles were presented last year
https://netdevconf.info/0x15/session.html?Autonomous-NVMe-TCP-offload

