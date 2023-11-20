Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB61C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LivTIn+Mzfm4V76NAY22FThYk4d+bbOVIr11rT80ov4=; b=tr6wModnTaNxppxB3eHOMnDL/l
	y1WD1FrA3v5glALiZXeF00/ffNOZ70ZCUbw9+rhfWkggVT/qfvAtJoSPAU05Zt1eKPzukPp4Th0j+
	Be4eH1AblWYyqjU2YX+YKg366g4nGgJMLfNKzsOIDxCh8a1HlmY5VSMu3F7KxU/RHJ9OPNlhLl/16
	U7ZMgRWblXIeWO1gvwvG5mhmuwCTaKeQjW4gotpXbpHNM1mCSwz+6iO5xaaTwFPBo4zNeMGLXhtlU
	5Bk3M/UC9E1NMXjalmGENxGGyBpOmjX4smlAFBTGC4A53H9yXPnF4aynUz84ktyGcYaIMDYU9nkxM
	TPbme6Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5DkR-00F3sV-1e;
	Mon, 20 Nov 2023 23:32:11 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5DkO-00F3qs-2r
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 23:32:10 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3316ad2bee5so2247462f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 15:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1700523123; x=1701127923; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LivTIn+Mzfm4V76NAY22FThYk4d+bbOVIr11rT80ov4=;
        b=VdeIyNj51v461k4oKUjZyboptIhvkWHiFSg6oLW4JW5cj+aynRnBqG9Sib5S+R83mn
         SQVTnRk5j0RZtoJ8yJmE7HIV44rYLlDluFYqhmU5DpGVm1UIw4Rq6ftPRc+4DcP68Xdp
         2sqVz+RypYzovIzahkKBhVLCI3zIxbvFuWdRiBYn+ZY7VJdI2+MKqvEA/dGIBxR4byI0
         IYF5OHhnHzaEchaaPS26kZ1quz85XkNKT2EqplE39Q/4/VAv7GJ7awBTCXH7ZIxq2VOE
         xT2VDgl3uyAoIGu9A0aoTct5zc1R1xcHC+ig/qV5SO91lh7b6R1Ts5IxF5J0GaZn2jNH
         aztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700523123; x=1701127923;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LivTIn+Mzfm4V76NAY22FThYk4d+bbOVIr11rT80ov4=;
        b=R5kwvJ2rlSGiL6IXD8Jjz3XzB9UAZHdI9Qfl911nsKxch/RwoRE+ViTzIrlIKcrKN8
         var1FULVrMUcYtOtwRBOUQwmtIk9nSiZ82Ua1sfIaMMZoPR5ysf0vo22KpzFf3aS1abl
         We5ivIc82XK0x9H/hUGjCCdcCJajmj26S0dLt/BZfTBON1G4Ox8mxBTqCskqCxtow8rO
         GJGoyWTZFhcp9p5swXeikW9d/dty4ZRYZdWqspdMSq9GmQcnGt4u0LD5iyXqm2pfzdIi
         RwoW0F4VodYaynB/e4gJ58wwFNSuISvn4Seqe9c6L/yb/8mStLNeaQcu3ecL6vNxe7wP
         T6rA==
X-Gm-Message-State: AOJu0YwwENrjgracONANDVnOeO+VBYC+pU9X6inRK8kwoRlT0RBIe/uY
	AaVryLI3J/NlUxhg3GvMspy8SjVbUk0VVhZyXp/iuw==
X-Google-Smtp-Source: AGHT+IHpcmPExtK67atdaxwWnyiYeCi6k+SQSH5bx2f3uKwQEOJG/Oh95gfg8c1enjKiPJ3dfOaOB0PThA1KqgZYN9o=
X-Received: by 2002:a5d:67cb:0:b0:32d:a2a0:bd6c with SMTP id
 n11-20020a5d67cb000000b0032da2a0bd6cmr5182381wrw.34.1700523123614; Mon, 20
 Nov 2023 15:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20231115185439.2616073-1-yzhong@purestorage.com>
 <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com>
 <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com>
 <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com> <20231117132846.GB7867@lst.de>
 <ZVeW-8cNNVOvNdaR@kbusch-mbp.dhcp.thefacebook.com> <20231120082346.GA11622@lst.de>
 <2fc7ca93-3ad7-4127-b779-76c32f8d9124@grimberg.me>
In-Reply-To: <2fc7ca93-3ad7-4127-b779-76c32f8d9124@grimberg.me>
From: Randy Jennings <randyj@purestorage.com>
Date: Mon, 20 Nov 2023 15:31:52 -0800
Message-ID: <CAPpK+O2aitq+ubFRBtjOrUWjdRz=8x3Us9Am4_aVcSo4vAhLYA@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Yuanyuan Zhong <yzhong@purestorage.com>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, hcoutinho@purestorage.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_153209_023864_67CF9B5F 
X-CRM114-Status: GOOD (  10.27  )
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

>> It doesn't make sense for effects logs to be different per-controller
>> for the same shared namespace. The spec doesn't seem to explicitly
>> prevent that, but hints that all hosts should be seeing the same thing
>> no matter which controller they're connected to:
>
> Also agreed as already indicated in the past mail.

Yuanyuan Zhong already pointed out a situation where the commands
supported portion of the log page could be different.  When upgrading
the subsystem, some controllers may be upgraded sooner than others.
The upgrade could support new commands.

However, I would be surprised if the effects would be different for
currently supported commands, unless a controller was not reporting
effects before and starts reporting them.

Sincerely,
Randy Jennings

