Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A91BC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eoB4WlzK60FfsTcEbS+2/+Q3Hn7n6G9AnefRUurVRPY=; b=AS1A6+7yDd31Sh5WpzCu4k6skK
	BZUwFCLoDwySvF4wegQ5ZoH+hN3J+Yt/n+XSZ//rU6guB8i39V9MLVqk3XbQQpGGR/F/4a+h/sAm9
	ZCSpIjWKqL8wS28mp6FCxMiljQkKJ3o32e8AdM4qxKsvzZdn6V7wViZSSLba04uaeya7S7VoNzTZs
	b0G9XcXyyuY1ZXxNon3ZUIL1twNeyflWA2Ryqb7c6SlZ+k02TcJE6b0ZYgsdrRBcixQ9+3TC6oOnI
	Qb/3bYA8+jDsK4rMDqpIO4maW10dK6mQ3RMp+FaIangKIpiyDwfFbY+Cu0QyXTbohU2eV6/sNBgTX
	1vkB9DcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRN9-009xL7-0W; Fri, 15 Jul 2022 19:53:11 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRN5-009xBk-LK
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 19:53:09 +0000
Received: by mail-wr1-x429.google.com with SMTP id v16so8106685wrd.13
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eoB4WlzK60FfsTcEbS+2/+Q3Hn7n6G9AnefRUurVRPY=;
        b=MmkNJgf4adqUSub9F1axftbHk9wZnHA4JaaalePnEyJ7EOgvM9CSTIp7CslsWNpNom
         plt6nc9oFiSxD00JMKi/5EOwlmXpWhKKLPmqkun4FYoVbVK895cQT7S7+Vd/LigWiVty
         pN/RxT5jtb8En4Y+5s4RcIHCKbo0881QzLzF3pfwo+o47ENo67rzFrmDTy9Zc3R8IWX5
         fj16Sg0PozOZ9dI7mu5B3vnG008Uj4/3EkRx7ioJUx3eFytLGngXn6gs/L95Z/J/9qMT
         3w0+JVJ/efmtAfMjwzJYofJ74Yu1uiMkuviDV8AUe2bH7M7ZedeZ8J4z5oYXYh1pzcOs
         zwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eoB4WlzK60FfsTcEbS+2/+Q3Hn7n6G9AnefRUurVRPY=;
        b=m7nIaX/wCDa3pRY0WNATHLD4eroCM/CAC5hZwzRiPHy5Y5N09xYCDwzcYgXZyAYevU
         a16Z/rIVdWBbbAXoJRqGR5upxYzWCL6mUqPTotA6jwse7MIvZ6jQ4KkchS+bNvHV7dzT
         cxGXaQW2eTnpn+zxUACsfUwWd9kW+hCLqa5P6cunPfMzzTSScAnQGGlv/GJBcz64IOdb
         vsITBJcMTJubnSCGXM2uiz1QahHRIQY/NyYmVyEJQJ79vhfBtMMqAWvbJFra2tRz5Ztg
         YzsS/eICSeLhrNYP/v2Kt7UYBGNob1pRu+arG/NXDxtAFbkxBgsrHMXPOgUPpf5ZPiy7
         zlHw==
X-Gm-Message-State: AJIora9+7FNyMrWOiP1wadtdvzXhXCGMl9iVec5TpvfekbopTIJmZwrs
	PMxR97epWg6DNLrTLINR8Kv+/9cWj70xjbMPWz3R
X-Google-Smtp-Source: AGRyM1t4EF/iYxd2UkC/st4fF7/g1qJCRBqTVLY6gX5RFKjWehP/FkVvPuh7my6+DKGsdqn3Q8a1Zc/g1cNB1UFzXX8=
X-Received: by 2002:adf:f345:0:b0:21d:6a26:6d8f with SMTP id
 e5-20020adff345000000b0021d6a266d8fmr14412309wrp.538.1657914783213; Fri, 15
 Jul 2022 12:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
In-Reply-To: <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Jul 2022 15:52:52 -0400
Message-ID: <CAHC9VhRzm=1mh9bZKEdLSG0vet=amQDVpuZk+1shMuXYLV_qoQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To: Jens Axboe <axboe@kernel.dk>, Luis Chamberlain <mcgrof@kernel.org>
Cc: casey@schaufler-ca.com, joshi.k@samsung.com, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_125307_704388_E82824CD 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 15, 2022 at 3:28 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd"), this extended the struct
> > file_operations to allow a new command which each subsystem can use
> > to enable command passthrough. Add an LSM specific for the command
> > passthrough which enables LSMs to inspect the command details.
> >
> > This was discussed long ago without no clear pointer for something
> > conclusive, so this enables LSMs to at least reject this new file
> > operation.
>
> From an io_uring perspective, this looks fine to me. It may be easier if
> I take this through my tree due to the moving of the files, or the
> security side can do it but it'd have to then wait for merge window (and
> post io_uring branch merge) to do so. Just let me know. If done outside
> of my tree, feel free to add:
>
> Acked-by: Jens Axboe <axboe@kernel.dk>

Thank you both.

-- 
paul-moore.com

