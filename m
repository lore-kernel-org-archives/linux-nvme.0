Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFBFCE79DC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Sep 2023 14:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IdkwIYdMI8V3dmFlJ2w9ygeIsEoj45Nybb84GzRauaI=; b=md2490wCNJtnadzhwohALXrC4y
	e0m44MfNPKNPbIg8X2wQq4TpUVVq2SzPhk4QPucxXQV616p9XmQDZcSwWyQ/XM4cnw1yIja6YV+It
	QDusnNj+7pvIMBdNuSzAYuTjhtS7GaMIb4mHkGw9fHalga/Tc+79Uh8rDYZYemVvhdKzSPRdBZyjh
	vO4WuY1Qr/Cs70XS6sOXTuAfiL+I9jb1+30JMFgBhI4RQ4KYDVrZ6Ik8gp1nq+TmmFjIzSmES/4fW
	JBP8JzlsxmCidqAniG5GzfQd6wCjlxwEb9ubUg0ham8fVoPRGTQNiZzCuzXYHLZxq61ZVgVlkelQm
	3o9ZUtWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiyPl-003PE9-2g;
	Wed, 20 Sep 2023 14:42:53 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiyPi-003PDS-2G
	for linux-nvme@lists.infradead.org;
	Wed, 20 Sep 2023 14:42:52 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-52349d93c8aso1614387a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 20 Sep 2023 07:42:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695220966; x=1695825766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IdkwIYdMI8V3dmFlJ2w9ygeIsEoj45Nybb84GzRauaI=;
        b=NkxcHeUwHju+YOWMoAZqNINA1V/MnSIZSn6vJNSq3Yj8aOIaBFthmNgqXqeFVeBVoI
         pBVkvgAPxhKnGi4Yh0vkxYdmkEPxQgYu4rBemaF1yw2rrHN4dChElmSJHjseFMSsCT0g
         NrFHnJyFas301Ifhqdma7zPwhBRJGWIAxs+rXqesXOfPKco2HGCjEw4si1oUclLl+26n
         gcUI82hs6mfNXWBfuocW8ZJvNEqMoI3591ShsBZRbWpYnu6yHvR+OzymhPst+SfyLe6D
         H6XdffoClX+IvmoHkzpF5+RIQt4TKe/ukbrhJIFmqX2gSnLzWvMs2qFQYwkXhKMiCeMe
         TP6Q==
X-Gm-Message-State: AOJu0Yy2A6nepThO2j+OZtN4D88RiCuyfFzseItIvdvUGKcVODATqKpO
	oAZwNj0LaJmTF+aOFHN7qf5Hahemf4c=
X-Google-Smtp-Source: AGHT+IEvZWFberJnubB0uo+BcCMFaK/ZjiHGJm9h3wrl07kw4EMJSIFCr3W69QWt+IRzPU5HEhKgcQ==
X-Received: by 2002:a17:906:739b:b0:9ae:3663:4bc2 with SMTP id f27-20020a170906739b00b009ae36634bc2mr2246717ejl.7.1695220965785;
        Wed, 20 Sep 2023 07:42:45 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u26-20020a170906c41a00b00989828a42e8sm9510165ejz.154.2023.09.20.07.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 07:42:43 -0700 (PDT)
Message-ID: <6596810b-103a-ff18-49b2-7ae5c8d01c38@grimberg.me>
Date: Wed, 20 Sep 2023 17:42:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/1] nvmet: View subsystem connections on nvmeof target
Content-Language: en-US
To: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>,
 linux-nvme@lists.infradead.org
Cc: kch@nvidia.com, hch@lst.de, antoine.damhet@shadow.tech,
 valentin.brice@shadow.tech
References: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230920141205.26637-1-redouane.boufenghour@shadow.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_074250_741826_7890FA03 
X-CRM114-Status: GOOD (  24.74  )
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


> HI,
> We need to list the nqn and their IP connected to our target nvmeof server.
> In fact we can have several dozen connections on a machine and we need to know
> which server is connected to which subsystem.
> Currently there is no way to find out which machine is connected to which subsystem
> except through the nqn.
> The nqn can be modified by the initiator , so for us it’s not necessarily a source
> we can trust.
> We’ve created a POC to retrieve the nqn and associated ip when a client is connected
> to a subsystem.

No patch attached afaict.

> We’ve tested this poc on a tcp and rdma connection and it’s OK.
> For the POC we write to the attr_connected_ctrls file in the subsystems directory for
> each subsystem.
> We’re not sure this is the right implementation.
> Either we create a ctrls directory which will be created on the userland side and
> populated with information
> from the ctrl connected when the ctrl number folder is created.
> Or we use the host directory to add an entry when the machine is connected to write its
>   IP address, but this folder is also used by ACLs.
> Or we stick to a simple attribute listing all connected controllers nqn and addresses.
> That being said, given the reduced size of a configfs page and the large size of some
> addresses (ie IPv6 address), that would drastically limit the numbers of controllers
> and addresses we could list in this attribute.
> what do you think?

I don't think that this should be a configfs attribute at all. And yes,
a single attribute is going to be unnecessarily limited.

This type of information probably belongs in debugfs. It is possible to
have nvmet create a root in debugfs and build a hierarchy that the user
can traverse to get this information from something like:
/<debugfs>/nvmet/<subsys>/<ctrl>/

A controller can expose different things like host_traddr and hostnqn.

