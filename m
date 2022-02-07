Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D438C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fWqtRymzcsRW7TkiZ+SjJ07oOe1gSbKU+ih5b1NC1bU=; b=g7YcdANrvpf7LfgxhqCU0VQ5dn
	iuvBqQ98qZfJiotk2BP1sWD8zeM1O17xJ5Z12tzal+9KmNGmKgNREH4hGWUjdO6MW7eJvglbtObOg
	wpk4uhDoMv0IPP+/Zw0e5k1joNigW3pk0PqT3mB4BmZfDlbEK6Ej3cqxte0CtdGQRSw8XEb3lGHG7
	VZNYm/xny3QXYzqqnvHEltiw6TMrQht0F/iYiTsbEHvnnGxruMGMjDEfrdjrlDHES0pNwDC/Dnm88
	48oUpI+RaoJ0SatEIsS9IH+QDtj7KImbpU1PGLF7gAd2IMVG8d3elQ3eWCXKwhZi4HHMyPJU7dvYU
	27PxnSeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nH3H1-00AAaP-70; Mon, 07 Feb 2022 12:37:39 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nH3Gx-00AAZk-QA
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 12:37:37 +0000
Received: by mail-wr1-f48.google.com with SMTP id s10so21927452wra.5
 for <linux-nvme@lists.infradead.org>; Mon, 07 Feb 2022 04:37:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fWqtRymzcsRW7TkiZ+SjJ07oOe1gSbKU+ih5b1NC1bU=;
 b=VZuRebWxTHmc9BTSgKkK4WysWwXiQ00BcFQkMymyanEHs/l2crkcEewHEMKRliCJT7
 /19Pg1JXF4nrHeCb4UIySZtICwZcOYtAf14I0hMx08GlY9ZjEOk0F0gVt5jbm34E9FP+
 EwavqcPj8SUPdPCpnLJvaBZ6JcM81vSY1R4K2ieNIMIAf3Yky/jGV/EtZefUoGSmeSeK
 lPqAVEIXX+V10tbU5mUJ4zoJsAUmgRrTWU23/6cKlu8csOZIl/liB3IH6/BI9THGxScN
 8xMn2WIbp1AqxzgYkW/ED7oSFwEzSzcGcrLTkfiAM8TtfMjEeNonSTnWWh7fk1Cphgy+
 BRfw==
X-Gm-Message-State: AOAM533MrpYGnqC86KzFvaS7EQn0uHm2zRozyQQmp8BAcayqGhJCqAQE
 BOp8aWjzIISabR/tUvDIk5c=
X-Google-Smtp-Source: ABdhPJybTF1T4FH3b/4ypjtpVmH42jD/cbW+TUwZSfaEvKW+SOXKDBbZ1gVaZNyk9gK6nm29w5bCcQ==
X-Received: by 2002:a5d:67c1:: with SMTP id n1mr8101274wrw.511.1644237453808; 
 Mon, 07 Feb 2022 04:37:33 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h18sm11585297wro.9.2022.02.07.04.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 04:37:33 -0800 (PST)
Message-ID: <93fb8e2d-3edc-0753-f71a-34c7ce054c27@grimberg.me>
Date: Mon, 7 Feb 2022 14:37:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220207100005.34404-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220207100005.34404-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_043735_879835_AD530478 
X-CRM114-Status: GOOD (  15.12  )
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


> On large installations the ANA log buffer can be exceedingly large;
> we've come across a controller with 49 ANA Group Descriptors and
> 65536 namespaces, resulting in an ANA buffer with an order-7 allocation.
> And this is just to validate that the namespace ID is _really_listed
> in the log page.
> So to avoid an overly large memory allocation we can leverage the
> 'RGO' bit when retrieving the ANA log page, and check whether the
> ANA group ID from the namespace is found in the ANA descriptors.
> That cuts down the memory allocation, and provides the same result.
> But to be on the safe side I've added a module option 'ana_groups_only'
> to switch between modes.

Hannes, why not a sysfs writable attribute? One can add a udev rule if
it wants a one-shot all controllers...

Although maybe that will bring us to yet another attribute that is
unstable until the controller identifies...

I think we are getting more indication that the controller device
creation is sitting in the wrong place...

