Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1014C76188
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Apr 2023 21:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkrq61akQVtSt2vsHQwWZ/SIZSgryWLnh/E9fAIT6uE=; b=tlPFcUGwBtCO2mxw7p3Tv1+eT5
	yN/UnO3BAh6yF0Y6GGAEL1g3+UTM4sBRCtiKwGS+2bPYbiVCOZX9XfOTedGribmEo/ZsiaiuJbS4C
	7G6Lit3u2YvZ3Qas2UbG1MOJn0k17EOMxQ2kfme5YK9+pxdcI1vUp01l5g6beA3lEddDYrWo1EHFU
	18DvbW+wDijrms7znIEEamcfrjQin5yTsqFMC0xb74UCVlUm/sMyvOQUAlSt2T+czHOeSlpg+lRYN
	FykHPrl227T81jTo6k7oOgbmO3kdNs9a/u5e+jt4Ej0ElBmtCzjup/jcWkusPs9C/a6E460OGOBPf
	hmyi8yuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjo34-002sye-00;
	Tue, 04 Apr 2023 21:18:38 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjo31-002sy8-0W
	for linux-nvme@lists.infradead.org;
	Tue, 04 Apr 2023 21:18:36 +0000
Received: by mail-pl1-x633.google.com with SMTP id o11so32589180ple.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Apr 2023 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680643113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rkrq61akQVtSt2vsHQwWZ/SIZSgryWLnh/E9fAIT6uE=;
        b=RCkbZxfnx2GYITloPyAuARxUP5in/dWNNgXlOtI9jvwa4fK7g2WpJu2XuSY8tq0gCv
         aDZ5vnF0HGQIO9sdbjyxa8+Ma9/g5fiJbYnbjD+8wfWukxf6uXMxWvm7J63VLMlHuZPR
         GQr9RWX6wyA5MkeyDgG3l3fyvz1Kg4JXjw60Rf7zuYsupIwp9EKyZOyn9cMig4YzJ6ti
         gGUdOOpoo9wszoZcDphBvrM+ADUvtltVuiwDI0YUKIM7DOLFZRnArt4RG3I2hJUyTGf8
         7Bjk+BN8tx7bgmorC1SzPKK8aAGAnv5FvuTXh0qE3u8loAU4ndf/g2hDhVTavWOwCYLB
         ZUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680643113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkrq61akQVtSt2vsHQwWZ/SIZSgryWLnh/E9fAIT6uE=;
        b=Wu901C4MeLMaCPEm0sqDFLLAjyHq0dHrM+pxg2F5so02QYCB/Yh/7/922aKru6zqoz
         NcNXWXp4VJPAIL9DakAfZJ6KLreal5u7amFTlym+xwydKSLbv/WOwHG5ac0PbhX1Sp3Q
         TAvDqMuwgFiZrkVu85zTrZf74PBH5RMv+0Eg80AeUeSP6ect+aaprt8+xGeo1CKTsNN+
         jlm/PocGip6A0pNdSJKZ3+3ocuSeUdULTtvdP1yBrcttEPkUoUy8rpcWSd7GPhU7MPB+
         D67joY8zXIX1eNSomZeMIrOUXs6iSxQAnKb9twJ7l53874WF8cOcQY6FENUSzeLK6kmT
         Wq+Q==
X-Gm-Message-State: AAQBX9eiXq71oYv9RM+tLVKH2j745PPfhNd1C5L3xNElD8y7lBuLBifZ
	rluPi2CnpFCXk/5cnXyvgY7ELT9gn4BUvE2THlo=
X-Google-Smtp-Source: AKy350Yn9y4D9U8y4TIylRf3CZur2mXmhls3j9CDPUfk0Un+MMktclCdH7UYrBCyXpE9lFxTsWqNVrcnSWH3lHL/oAU=
X-Received: by 2002:a17:90a:2a8a:b0:240:ad3a:6476 with SMTP id
 j10-20020a17090a2a8a00b00240ad3a6476mr1491971pjd.0.1680643113571; Tue, 04 Apr
 2023 14:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <ZCoguA3gBUw1CIdd@archlinux> <38fbc59a-94cf-9764-e4c4-0fd3c8f3830b@grimberg.me>
 <CALL+9ei1m2oj=MceRyyjM+FMuSrv9eD=nLKFrkX+RD-0Zp7v0Q@mail.gmail.com> <df40eec3-012e-3664-14ec-d15e1c57c258@grimberg.me>
In-Reply-To: <df40eec3-012e-3664-14ec-d15e1c57c258@grimberg.me>
From: irvin cote <irvincoteg@gmail.com>
Date: Tue, 4 Apr 2023 18:18:22 -0300
Message-ID: <CALL+9ejW7GqWgi_-nqEdPe0a5kc03bbnh9mNVusnDu_tomRGKw@mail.gmail.com>
Subject: Re: [PATCH] nvme-core: Fixing ctrl de-referencing in nvme_init_ctrl
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, kbusch@kernel.org, axboe@fb.com, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230404_141835_202168_40CFE797 
X-CRM114-Status: GOOD (  14.31  )
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

Oh sorry I had not understood the term, and I am not too familiar with
fix tags yet, but let's go with regression if it is a good fit.

On Mon, 3 Apr 2023 at 19:37, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > The thing is that after device_initialize is called the reference
> > count for the device is equal to 1. Now the function also calls
> > nvme_get_ctrl which increases the ref-count to 2.
> > However the teardown path only accounts for 1 decrement. This means
> > that if an error were to occur during nvme_init_ctrl, we would return
> > from nvme_probe without having freed the resources of the controller.
>
> Not arguing the bug, just want to understand what Fixes tag it needs,
> so that this can go as far as possible to stable kernels.

