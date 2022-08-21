Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288C2C00140
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Aug 2022 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jILonV086DNQ+KWlOgi6a3UzHTGVyIQ7N2DF/l9R5Ms=; b=lFZr9xnz3aGKQhbgCKQtydvxFu
	PpNQ/GC8mFUPxqDB5FsaIwK/gbhEEEDf2JEjnSW67e50WQ+coz7CdRQgYCFqt27vqw91VOqdwYCIR
	BVjsyMiYhLnnSjwVTxXkqmKS8SEaWzSwiLQVNKqCAhPAFOFSbkXeK7iGjRxaJHoUqEFPcd7BztuVU
	J0Zc4VCAafcKt9WftxPO2m00SbpcZxfQriXJuBoWHFx9240fP7Q35UcD0cRzk6+ZTqFWWQnMdMzIX
	FSDByEC1Gp2ob3IPzqK6aRSnb02x4x6olIRLm7avF8PA9KdJs0gUGfC+/VaU0j4vGK1sFPAcU1ZH6
	vox3GpTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPqNS-00E3fD-1m; Sun, 21 Aug 2022 19:12:54 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPqNO-00E3VT-3S
	for linux-nvme@lists.infradead.org; Sun, 21 Aug 2022 19:12:51 +0000
Received: by mail-ed1-x533.google.com with SMTP id e21so6553196edc.7
        for <linux-nvme@lists.infradead.org>; Sun, 21 Aug 2022 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=jILonV086DNQ+KWlOgi6a3UzHTGVyIQ7N2DF/l9R5Ms=;
        b=d6as8TiE4LmDOL120eqrxKyMEZMpLMYZKRTGZ9J0ByyZvoY0XLB/GqMnanObaxp8tG
         Et6snwtFVB3GEt0jNM4JMqVe2BcB8lm4JY2tItXb+W+tLJYgp6qHCj6+POofV6NPgPec
         I/hoJdgZ2LFstLdE4PZ/cg+weAgbGm09rQFGDhCxCcMNGy+Df7n5hT6ZZ4kPFVjFOaBd
         +GjwhLKxtkA4vPUPk1V4wYZW1/FGs5c8CBCvMt8Fcl1PYPY1IgPp8E0ZYik/1mjzC5+0
         Fz2yAWujFXCSsMs7K9Qm0aOa0gI9+8eu6rJcp6zRcesak1GRhlIXN+HkyEaps/oNhvCN
         HcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=jILonV086DNQ+KWlOgi6a3UzHTGVyIQ7N2DF/l9R5Ms=;
        b=LJEC4PuBcx9G91S3cxS1Z7WtITELwOLwBup3yw3PucDo7cdmXvVBc5cyV3XxV74M5H
         Q9OyeAplyZbLDa9CGJnZ+sJlGZXoEY0BEbJy+uQehmZDtBQJDmqqWnWtmlCAvAisTbtv
         S4IeQMc9eClt2MQBnIlOV12Jjx2WQKw6QXE+M51KZ6cKrGl31Iw7CNjrBBT3aSbSkV2Z
         VRfc1YDhURF7pT21ji1YMCfacS7HE59YjGmlmESamGyQ3AYqJcfJ+OU6YI6WdpUxS+Qv
         wPNbD74S7w6QDkD053CLWJj8fisi8zlZOXr8DdybK3smj/X+gpZFXC86lkr1RjUdHzOM
         WNkg==
X-Gm-Message-State: ACgBeo2+OnGax6xqxSz1aoQd5IgqPL2iGbDUZTPFLi0bDMJ3rB1Ru0Jo
	R868T7iTyNDAKL57DEilKAA=
X-Google-Smtp-Source: AA6agR6jzKOvGqSaReSFOGzi1pxDqEbFCqv6BU5VfB4swj3L7QT90lmf8GbslEdWIeksHK/NQ0XJdg==
X-Received: by 2002:a05:6402:2499:b0:440:942a:40c2 with SMTP id q25-20020a056402249900b00440942a40c2mr13743059eda.37.1661109155774;
        Sun, 21 Aug 2022 12:12:35 -0700 (PDT)
Received: from opensuse.localnet (host-87-17-106-94.retail.telecomitalia.it. [87.17.106.94])
        by smtp.gmail.com with ESMTPSA id s13-20020a170906a18d00b0072af102e65csm5149520ejy.152.2022.08.21.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 12:12:33 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2] nvmet-tcp: Don't kmap() pages which can't come from HIGHMEM
Date: Sun, 21 Aug 2022 21:12:30 +0200
Message-ID: <8107517.T7Z3S40VBb@opensuse>
In-Reply-To: <20220821054602.GA25754@lst.de>
References: <20220817184519.25141-1-fmdefrancesco@gmail.com> <20220821054602.GA25754@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220821_121250_285022_E9BB4243 
X-CRM114-Status: GOOD (  11.90  )
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

On domenica 21 agosto 2022 07:46:02 CEST Christoph Hellwig wrote:
> This introduced tons of pointless over 80 character lines, please stick
> to a proper coding style.

I'm sorry for this mistake. I'll break those long lines in the next version.
 
> Also or in-kernel I/O wouldn't it make more sense to use a BVEC iter
> insted of a KVEC if we have the pages anyway?  Or does networking not
> support them properly?

I must admit I knew practically nothing about this code until I met it while 
doing my long journey towards kmap() and kmap_atomic() removals. I can say the 
same for regard to the differences between BVEC iter and KVEC iter. 

Since you are asking this, today I did some research and read code from other 
drivers/subsystems, despite this particular issue is out of the scope of my 
patch.

I also read an interesting article in LWN: "The iov_iter interface" at 
https://lwn.net/Articles/625077/

I may very well be wrong, however I think that iov_iter_kvec() is better 
suited here.

@Sagi, anything to add to this discussion?

Thanks,

Fabio 




