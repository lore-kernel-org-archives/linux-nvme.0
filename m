Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF057C3DA63
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vTUKsuAlDi0iSYRC+we38+DtQsnQSdSQdS20sVQC7cY=; b=xuGGOh4lsW1UP6YmIgQoHlUbyX
	3lzMbqctK9eUIzQFRjHa2oS3fInDfFZo8Z/jkJwuPo7muT+Fsu1YVZyMlQUBWqan4Xd9V2hcCPjbT
	yZn1b8MVnm1W/gUWg86KB3uPU3NOg2UZrq58sCsl7heJ1fuWb57q3VlDiSLvTkcQsGiMa1VYOr6ea
	XeFD8xRh2Y4kYcybtXisCZyT0MUZ6RtqS7cSw9vvZ3Fk7ZrhYSTRVbvppeeong8GI1uPpcT2QykPI
	wlZdudsMoDpzC+6uaYEHWOH6Bi9l1xffiWcJGApYIp+NBnKoh0a69MG+4o7RdhRj8cn9NORbbrT85
	w3m49vAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWC9Q-0000000C4aM-2xgI;
	Tue, 23 Jul 2024 09:49:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWC9M-0000000C4ZN-0ZWM
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 09:49:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721728178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vTUKsuAlDi0iSYRC+we38+DtQsnQSdSQdS20sVQC7cY=;
	b=iL7wkTfVNGFNgnYAGyf4wToaQC0FL7Fq3eW8ylMTf+sqCbvnolthnEZ62cyUwzEf0xHA88
	9av3EQMlk5rdPtd56EQWsJk3p+qVXEWg8VPoEatEGWt6txJT03Z/g1b/bVFKOL8M0a8USp
	3p8lHAUKFbVoASIvYaCW+1E+GfwM6mg=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-GusneatdMGiLQ0ovILVnog-1; Tue, 23 Jul 2024 05:49:36 -0400
X-MC-Unique: GusneatdMGiLQ0ovILVnog-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5d1cf213b62so4040006eaf.3
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jul 2024 02:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721728175; x=1722332975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTUKsuAlDi0iSYRC+we38+DtQsnQSdSQdS20sVQC7cY=;
        b=BykY14JesX4d/g3ee/YHA32mNib3DHoMW/TDneMFwfmiExXqahu3Hos+0SgameAO6N
         22E+M5W5rkgkyp3jhQoWF1H6oc28ncKfi5J9dXfP9HepcgR6qmsCreHP5kbCSaWmtz4N
         MK6lbWxNTS8PCUCCxngc/UTPIrED/wn6fSbdvHo97mktsspYuyqukXdjdRYnue6T3WJa
         esI0g/Fk12Tqq6vZWSN+dTR2A1HNqxUc5Os9XGGdFnRRVzuWW1iMsoS+6mcBTO52qxl1
         rLEU72rBbddjPrQmdL6mSAayXNGuWb4eSt1cQsDX//ioMJ15kQDgdJh4t6blhfQtLYiO
         nGXg==
X-Forwarded-Encrypted: i=1; AJvYcCXgfnFxRu0K5ZDQkerZLU7rCsxZev/0PBzlOJthqmwgrd03gbJJdMMvsGYYaMf433Ueinf6RiEDOQWGUEJF5ffE9tuQZFSZlMj5SouIPlo=
X-Gm-Message-State: AOJu0YzDJUtVkB82BZyN+5JKy6MMoldBjfRb8oO7+cu3sZOkWMPDA7c+
	4bfRM8P0qLjpvcfF1voXPyTfdRAyeqJQbAmkQEfgUR3cuA+Eef19WNi/74u/xU545qeLcEheTpz
	DgKDgy88258ud4yDz2NAkZNjLimoEPi3WAaG3WP6ydXUxElucPJiURIGRpCW0II6yVxUrkT37yq
	GFlePeTdDXwzybVGnakx61+MLGnZmbaHls3AYM3j8=
X-Received: by 2002:a05:6820:1f0f:b0:5d5:6699:2c9b with SMTP id 006d021491bc7-5d5669930eemr13369702eaf.7.1721728175677;
        Tue, 23 Jul 2024 02:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJeYmoto4XfYkVaB8eVl5Rfnz6Zc7Zo5wuLRY713Uc0WXbr7Z9z8IthtfHXxldZAL02rgTLcuhfhVDsnxcrU=
X-Received: by 2002:a05:6820:1f0f:b0:5d5:6699:2c9b with SMTP id
 006d021491bc7-5d5669930eemr13369695eaf.7.1721728175401; Tue, 23 Jul 2024
 02:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230725110622.129361-1-ptyadav@amazon.de>
In-Reply-To: <20230725110622.129361-1-ptyadav@amazon.de>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Tue, 23 Jul 2024 11:49:24 +0200
Message-ID: <CAFL455=O23ci6GCzdnJr8DmyVSXAD=ctmj4AEk=XfSSLjbUQYA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has none
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_024940_269695_7926E3B1 
X-CRM114-Status: GOOD (  24.75  )
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

=C3=BAt 25. 7. 2023 v 13:07 odes=C3=ADlatel Pratyush Yadav <ptyadav@amazon.=
de> napsal:
>
> If a device has no NUMA node information associated with it, the driver
> puts the device in node first_memory_node (say node 0). As a side
> effect, this gives an indication to userspace IRQ balancing programs
> that the device is in node 0 so they prefer CPUs in node 0 to handle the
> IRQs associated with the queues. For example, irqbalance will only let
> CPUs in node 0 handle the interrupts. This reduces random access
> performance on CPUs in node 1 since the interrupt for command completion
> will fire on node 0.
>
> For example, AWS EC2's i3.16xlarge instance does not expose NUMA
> information for the NVMe devices. This means all NVMe devices have
> NUMA_NO_NODE by default. Without this patch, random 4k read performance
> measured via fio on CPUs from node 1 (around 165k IOPS) is almost 50%
> less than CPUs from node 0 (around 315k IOPS). With this patch, CPUs on
> both nodes get similar performance (around 315k IOPS).
>
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> ---
>  drivers/nvme/host/pci.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index baf69af7ea78e..f5ba2d7102eae 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2916,9 +2916,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct p=
ci_dev *pdev,
>         struct nvme_dev *dev;
>         int ret =3D -ENOMEM;
>
> -       if (node =3D=3D NUMA_NO_NODE)
> -               set_dev_node(&pdev->dev, first_memory_node);
> -
>         dev =3D kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
>         if (!dev)
>                 return ERR_PTR(-ENOMEM);
> --

FYI, we have received bug reports because of this patch.
All single numa nodes like a VMware guest or a system set to interleaved mo=
de
will now see -1 as the numa_node attribute.

Apparently, some applications like Lightbits do not expect to see -1.

Maurizio


