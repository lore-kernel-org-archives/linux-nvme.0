Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B03BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2zYvqvXjbGs5C4WInuhh3U2C66flVl4taaDYYUBAVA=; b=owksW/rwNTsY5deUKlQoHk2Iai
	NpnsVVlzQF7+7R6xpkLlBNOHEhu18tOcQMO3wCyB+yl+vMBBnYD00PjZ54Xy1fxmTfJDKepDcnuje
	BWKRg/2EMKONse9mAWiQVsnZEnKizh0dTOLD+ahR4P2tkx9sU5+NINvfcjXyA8W75rqeIrRGTwaIE
	IJNK6XP9jGATP5O4ooVi2WZM3ckiGmrDOtzpAEyX6QRLsikZQd6yUujvAjZMr88kzHJzJtOXk6Fx2
	+uvIcZbtxIQvJ/qKHoT4ho/nPZ7HCsnyGnApcxMQEGYV1x3rJ5fB1Je8b8sJm+5fLTPBhaO7YtQcA
	fevfZ7Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxWK3-00Anuw-JO; Tue, 22 Nov 2022 16:40:35 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxWJy-00AnqH-Us
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 16:40:32 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3a4c2c83300so53956587b3.13
        for <linux-nvme@lists.infradead.org>; Tue, 22 Nov 2022 08:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D2zYvqvXjbGs5C4WInuhh3U2C66flVl4taaDYYUBAVA=;
        b=UaPYWxjEdnLjXhU3WdNH0ejVKdY6kJXtscrlYGI69kfDiXTFnkEFSR46W2T3RsVTP5
         txRxDRJTQ5DGe1K0fZYS21f3clsrdGw1OmUM57d/xnboggySp77gI/he4O487ft97Vme
         WjL5PCnk+w6qZV6gSZ5h2mCoCKhm4FCXTP2xmNiSQtU3F3GIbxDFq7JKpYSU6wP2r8aj
         XF3xQD/+sfPTM13ufbByfB62otc+u+lBsqKTJ7YGmdX62IlF6ErreeTKbQsO0GDLWdSb
         uJoPEapG5MKQI1G39sCxzblmndinWn12RMatkEK5M/uOEUhP2wtZt9eh0uL14R7rZ3Tb
         XQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2zYvqvXjbGs5C4WInuhh3U2C66flVl4taaDYYUBAVA=;
        b=vwYYKavEqoHHJEmOtUoLz4bXfx2H73WxmgwPwjWF4SpkLunoWlNYpw4a8YXeEc3xLt
         nXmHsNCep/hch1iYj/pXJcXq8jQORQbRhEodM1CiZiEu9eYAoe+dchzZf6VTFmoN2Waz
         5Kb3WvP/J2WZToQA0wgaRHaaxZPRbu2ZMMplneWSuMCYIBJbf977IyVJ4kaRTLcnA1PN
         JNsYlP8xPBvJaTU4wgujuF7qVx/4cs2eJ2mp3o0AaY9dx9rXNuk4bAXzK8icv2Fr/Xvf
         2tSknvu7J9keiCL3LXRqAZYI1aMFCnrIVIyQfh5XJhRvuXNTaUC8ZOsHGo+S3P4R69hd
         Ta7Q==
X-Gm-Message-State: ANoB5plSG28DcIiZ7232DB5CSNH3NqtyN0VuCtOC69hC3o57IQXkn7Mx
	KaZ1nWZOErBSaYuaUaSRZcC5wT4bcL3E0SgCTorb1Q==
X-Google-Smtp-Source: AA0mqf4mkW4nuiEh4N+hOrMH9u/+FRLT0Zho1JaAfLTjdPVXW3dNj6y1yEg0KGDKXO2qAlyN170k/W4HmBBv8EvuyBs=
X-Received: by 2002:a81:acf:0:b0:391:48c6:3eb with SMTP id 198-20020a810acf000000b0039148c603ebmr22657111ywk.93.1669135225214;
 Tue, 22 Nov 2022 08:40:25 -0800 (PST)
MIME-Version: 1.0
References: <20221101150050.3510-1-hch@lst.de> <20221101150050.3510-15-hch@lst.de>
 <20221121204450.6vyg6gixsz4unpaz@google.com> <a8e3d7a4-c5f6-13d0-a517-72097daa2a7b@huawei.com>
 <20221122060855.GA14111@lst.de>
In-Reply-To: <20221122060855.GA14111@lst.de>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 22 Nov 2022 08:40:13 -0800
Message-ID: <CALvZod7AFOSyN7pz0+B2rbQrzepTD+QLwmSYSNUa5jyaXEfKfg@mail.gmail.com>
Subject: Re: [PATCH 14/14] nvme: use blk_mq_[un]quiesce_tagset
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Leng <lengchao@huawei.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_084031_067119_3F2A996D 
X-CRM114-Status: GOOD (  17.81  )
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

On Mon, Nov 21, 2022 at 10:08 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Nov 22, 2022 at 10:53:17AM +0800, Chao Leng wrote:
> >> This patch is causing the following crash at the boot and reverting it
> >> fixes the issue. This is next-20221121 kernel.
> > This patch can fix it.
> > https://lore.kernel.org/linux-nvme/20221116072711.1903536-1-hch@lst.de/
>
> Yes,  But I'm a little curious how it happened.  Shakeel, do you
> have a genuine admin controller that does not have any I/O queues
> to start with, or did we have other setup time errors?  Can youpost the
> full dmesg?

Sorry, I don't know about the admin controller and its I/O queues. For
dmesg, it was an early crash, so not in /var/log/message. I was able
to get the crash dump through the remote serial console but there is
no easy way to get it to give full dmesg. I will see if I can get more
info.

