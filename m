Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24E6C678D5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7rU39BK/c5sjuQr2a8DhzftW5omgr0+m7qG5+kPdksA=; b=pJlVW6aQowwtthtT3sX7gtqW9s
	E1hO/4G1SEOXBmDfW9k93hyyawA/uEuIITEGyiCzyUpRPvd/cgv3v3O7TeCESd/CQmgrPiY/hsx34
	CLZaY9O9Tbz4LoW4sZz2dvYa39PZXd0WXEfikYzjRr5VhPzmEwjCUosbcneIJvLnvqRbg8b26QJPj
	sOFI8bToSNCytp7/dIpXsAt0m/6HA2CtgsRlW46v4dSwGBkncTeqgTgynd6YSlPuwrd486GXoUl0P
	NsodfsdtObYrlwNF0LajaLBe+vLx3ngWJAyLr5PKMPUdGKU69m+sVtob2jXzWA48RKIalypI1dcwE
	BFNOiPrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZvlU-005iTM-RA; Wed, 08 Mar 2023 15:31:40 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZvlR-005iRb-Cc
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 15:31:38 +0000
Received: by mail-lj1-x232.google.com with SMTP id a32so16981392ljr.9
        for <linux-nvme@lists.infradead.org>; Wed, 08 Mar 2023 07:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678289495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rU39BK/c5sjuQr2a8DhzftW5omgr0+m7qG5+kPdksA=;
        b=kWmrdHcBAQf3IWE70aLYjZRwxZUF4c/qUG2KWMkK2CszQu/Ka/fjQYds/xPVTv3TGD
         8EcmF4TbcgKg9NnVzjdkA5y3YI7QfhpWKfMZISJKuu/54JOHy2ISc7cqpqbmx/U391mx
         fyg4hKWXC3yznvV9N+d0d/++QwVbCBC+CWwb0FgOMf8wMp0mkbJDpCFJu7dkHLomUutl
         VEX3uCxkXhwqw0+Jz95DS9fgPI3IAJ2EOFzS1dQSVFE5jg+H59SfGjHDn6DHkbiFc/Y5
         SysqNLS8J5JlhU/4HERt8BV4qlon9ij5hMSMIeT/anqrb3QA+wIF0LRrHI0YTseRFjQY
         Kpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678289495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rU39BK/c5sjuQr2a8DhzftW5omgr0+m7qG5+kPdksA=;
        b=BSYfK538YroGVJwl38aJS5SuvQq4rXfRZfd3/UCt3lKQYIwMqxCiTSg8I5UVcMlEQ7
         J6zgpe6PcD9MzJNcqdwQNleJzNKA3xpDvsajEilHTnh/pXDhF6nKOiapFN6v4HEmOs5j
         aBSMOd4x4RP/2djcPYdJKWcfmMFnsncCoB9DI16v05SeFlhBflfPWeoh1uPeqK4P9niN
         MSbVadp0qMJZzGYS3G5DqOh1CvD8DKeBHyOsWeTsVhGHQsFwCwoQcLodLmR+TzSmMHw6
         IUAIoDJfee+T/+L88MrHVuMxH0j20hWp6Pcdvuc0ira+ws8sGAW3UO6vtyY7jT+yLpyc
         tBkg==
X-Gm-Message-State: AO0yUKXJEUwnBC1K5s6VGTzB/e/qQviULX8xFfB8i9OCBzRu0oO0gCu+
	PGVgiuUgtjZheOrxp9qehXiT+JygOsjZa3oYBuA=
X-Google-Smtp-Source: AK7set/Sl/hiTWOa8kc40UlwtkTC2qqSpNstuyDjBxwfu+D/+3OGxcMh532921R/4Gunw/ZMmNz8BdwLftBnvWEHgVs=
X-Received: by 2002:a2e:b544:0:b0:295:b597:c903 with SMTP id
 a4-20020a2eb544000000b00295b597c903mr5671953ljn.3.1678289494757; Wed, 08 Mar
 2023 07:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20230307163045.5882-1-akinobu.mita@gmail.com> <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
In-Reply-To: <ba7cec63-2518-c68f-0dd6-b0a936132720@grimberg.me>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 9 Mar 2023 00:31:22 +0900
Message-ID: <CAC5umyimsitZW0Msvv=0dYhMn4gfRpBb4RUc5+Sq+RrO2nEiMQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: print correct opcode on timeout and error handling
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_073137_445039_C4D94A99 
X-CRM114-Status: GOOD (  19.89  )
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

2023=E5=B9=B43=E6=9C=888=E6=97=A5(=E6=B0=B4) 20:06 Sagi Grimberg <sagi@grim=
berg.me>:
>
>
> > In timeout and error handling, various information is reported about th=
e
> > command in error, but the printed opcode may not be correct
> >
> > The opcode is obtained from the nvme_command structure referenced by th=
e
> > 'cmd' member in the nvme_request structure.
> > (i.e. nvme_req(req)->cmd->common.opcode)
> >
> > For the nvme-tcp driver, the 'cmd' member in the nvme_request structure
> > points to a structure within the page fragment allocated by
> > nvme_tcp_init_request().  This page fragment is used as a command capsu=
le
> > PDU, and then may be reused as a h2c data PDU, so the nvme_command
> > referenced by the 'cmd' member has already been overwritten.
> >
> > To fix this problem, when setting up the nvme_command, keep the opcode =
in
> > a newly added member in the nvme_tcp_request and use that instead.
>
> I'm wandering if we should just not reuse the cmd pdu for a subsequent
> data pdu...
>
> It will take more space allocated per request (up to a few MBs for lots
> of requests and controllers)...
>
> but will prevent from propagating this to nvme core...
>
> Something like the below (untested):

Your fix looks good. It actually fixed the problem as well.

