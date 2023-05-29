Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24903C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rAnwAcNdkTaMG5xzQCOFsYecrSLUVjR/QAtiXocAnXc=; b=NZLHl5+9xCdUxV8hSn+M36yqzP
	XsUVOhVow2wLYc5BKgr0CxI1YShT4liZRFKqdjAS+aD9mzv8D2gTY1bWHljd8qKK+dnf7CuSz1ACB
	hfuAJfuwwdhkNVNRJw+Gm+xVkk0xUYL9whjTYtwNM9Ycm6cAxUsSTLBJtkpPA6y8ZqnLR7Smi5mE0
	tGitqTg1i/hUHKjPmkesAcdwBATe67fjpZV1QeaSgzRyehrC/kShCRnKFb5br4p5RNWqlTB6fdMLK
	aRO+gi84lN6yEReDHOO3X3CJ8kRfE8vflpe2eyQ9td3VIyqw+8n3jepw6dh6er4X76Y1XWGfGxN4J
	2kCgYbWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3eYH-00AtUN-1A;
	Mon, 29 May 2023 15:12:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q3eYE-00AtSq-2o
	for linux-nvme@lists.infradead.org;
	Mon, 29 May 2023 15:12:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685373167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAnwAcNdkTaMG5xzQCOFsYecrSLUVjR/QAtiXocAnXc=;
	b=PR29rgKrHgqKFOYAQyqgSVjj8EqND5R5/08yjRJYjbW+6Bl8uI9oFTfq7qR191CEPk+5DF
	XsOwZCZBcwNA2C7k2vV0Z1rPmi54e209uGzeBw82IDsPKQrLTowOqn1G5NlgGviVg44IFT
	Ukb+2+900PioNwvhosKyYMmGU5/GaRw=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-iFaFCflqPr-i-uEQ3TPaSg-1; Mon, 29 May 2023 11:12:46 -0400
X-MC-Unique: iFaFCflqPr-i-uEQ3TPaSg-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4570322a2daso2586598e0c.0
        for <linux-nvme@lists.infradead.org>; Mon, 29 May 2023 08:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685373165; x=1687965165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rAnwAcNdkTaMG5xzQCOFsYecrSLUVjR/QAtiXocAnXc=;
        b=QLk2aLbjdqXFLh5xn8ss7WtDMmnO7erFzNzQxSjsyhwXhqBaI9YHo71rYx0mNRrEsm
         GmlhhrdPo6iD+xYY+nz0hzT+4qy1UF7fHWtqvm4f2W2D4TWNPuipv4XJXD4XSAgvl5tX
         fWC3IFGclUqfKYoi/BSdbZYHiRoSYGVrLRVYBXgIt8jsm4b4Q8F2W5429IxABnIZwRg0
         vs1Nnoxo7ABr3PAxglmX6PcKjx2AUuhvvpouoIjn6mkkciUL/yItq5C3c3BNvzd4OX17
         n7QaBlbD9jV9TxGYKWzMiCAc0AOCkL3n/3xzUopmz2J3jtxjyBBa3DCiXBdPmQvw7tUy
         nmcA==
X-Gm-Message-State: AC+VfDyd4zmkBOOe+Vq/+ExqgwidTn4tyLaSKwnMZQmS2Ed9fzrsITgk
	YgQGedj6M8EOkMLu21TffOZOg8bV3J7aOnfXyh8XV9jfoqWYhIHpMn/Do/nGgp5/9L8oj3wlZRT
	D1yLJL9XRCUQwLY8SI8cjrco7UBrNfFlZJSIrCcK6n7TXXJC6cW8=
X-Received: by 2002:a67:ad13:0:b0:42c:3baa:b0d4 with SMTP id t19-20020a67ad13000000b0042c3baab0d4mr3548773vsl.9.1685373165572;
        Mon, 29 May 2023 08:12:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5E7Y4TRm07rpeQaAz9Wl61Ne4kwFsoeDnDrA5omtuBBJP6hmIhBw3hcwAa+XeRIdbvbVdhaLfvM2rqXN2rPm8=
X-Received: by 2002:a67:ad13:0:b0:42c:3baa:b0d4 with SMTP id
 t19-20020a67ad13000000b0042c3baab0d4mr3548743vsl.9.1685373165315; Mon, 29 May
 2023 08:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230523155408.48594-1-mlombard@redhat.com> <20230523182815.GA2384059@unreal>
In-Reply-To: <20230523182815.GA2384059@unreal>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Mon, 29 May 2023 17:12:33 +0200
Message-ID: <CAFL455m3T4qrk0Uf5qK7-57Oh6L6AKionfs0mF-imUMYpbqBOg@mail.gmail.com>
Subject: Re: [PATCH] Revert "IB/core: Fix use workqueue without WQ_MEM_RECLAIM"
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org, 
	parav@mellanox.com, Sagi Grimberg <sagi@grimberg.me>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230529_081250_999011_A804F11D 
X-CRM114-Status: UNSURE (   7.44  )
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

=C3=BAt 23. 5. 2023 v 20:28 odes=C3=ADlatel Leon Romanovsky <leon@kernel.or=
g> napsal:
> > workqueue: WQ_MEM_RECLAIM nvme-wq:nvme_rdma_reconnect_ctrl_work
> > [nvme_rdma] is flushing !WQ_MEM_RECLAIM ib_addr:process_one_req [ib_cor=
e]
>
> And why does nvme-wq need WQ_MEM_RECLAIM flag? I wonder if it is really
> needed.

Adding Sagi Grimberg to cc, he probably knows and can explain it better tha=
n me.

Maurizio


