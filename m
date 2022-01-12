Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2ABC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D1KNKVI44z/PsvFst/TK173wi7+38whGq+x5398gON0=; b=UeqnyUrcN+gBKuOWzkf282tJaE
	r6EwiCGXKhRXhTQQV4xY1qS2gWknoSmVRvOkfE2BYx8tFnBN8a4rDOVY7hxVD3D8X54BosUIOY3Tc
	eEvSGwyYxrJvj3nw/5uXnOU4MSdyqE/4IjggxaHIAJxWGai8ydZ+SKojhHzY2E+zpP8LYpzVye9nP
	trtvQgkoevM3NcMRGthYQH7264JS2tVUZruS4ynxPJNGL2p7TyRzVd7FJ0ZIylD47b0yOZqXVzZsa
	/kJP2M749j+l4DbBboLnV5y4Vyz2ijAkKQTrWKK+/hWpki4oXzN5/stRbsAp8s0V/VJ3cIVzHCDLm
	xS2TO9RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7d5b-002Vm4-Tf; Wed, 12 Jan 2022 12:50:55 +0000
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7d5Z-002VlY-5S
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 12:50:54 +0000
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4225B3F1EC
 for <linux-nvme@lists.infradead.org>; Wed, 12 Jan 2022 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641991846;
 bh=D1KNKVI44z/PsvFst/TK173wi7+38whGq+x5398gON0=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=JopNeE47KEvoxm4NCN1RCmzwDftFfmdF37ZnIZEMUVjwC929IYfszBVbRSuFkQNhS
 gS5hH884G/xyEyzrKioPnz7I2+tH/hoOuqcU2AndlQoMmq+f9gfYmdXmxaSbQrrQ3L
 mwjVmDtjAeBbe1K/Kit4jnfeVREQlIepdEDTpMY3wBrT8C/lN+mOmOyyHzxaPsO4Ud
 RdfMVyiMvbDvDuAhQmX6Xbgyoo7XXXCaBBknXsRzy3p16c6aL1H0Kw2feVrRZhO9QG
 wUhC/P9C2UstQHIYvsOwSVKMfyhzfPWeOPEhT6forpKxejP6lvtafh6TgGjFJ5IqBq
 PHS44/jM5JeOQ==
Received: by mail-oi1-f197.google.com with SMTP id
 q130-20020aca4388000000b002c7f7bcafabso1636794oia.2
 for <linux-nvme@lists.infradead.org>; Wed, 12 Jan 2022 04:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D1KNKVI44z/PsvFst/TK173wi7+38whGq+x5398gON0=;
 b=RIoa0vM5qTZoh9FdC9xxc5bpHJeE6CcNhDVuYOwG7x6z5KcZcim7ImWWXAimf7TdRh
 5uAhDqh+6BhL1r1SuYkepi0MexZEVUkW2K5+Yvlw+xFxFcxHQLlsDqxR4qTij8askHv2
 /GGFBAABjlA3EA6DPMw43nqA8c+Qb9IhWYb8aNCjAxpyu1g2rYPqkzOq8cv2so1b0tfr
 35FKVgB0BQG3OtEXALEZO2UtVp75PTEf9meKyIWT+VZGjKRlFdoSIeYv1fAbSq+L/i5m
 gW7py1MqgkRZMmhbM52aZd016UNcXmgU3NW8fILx3ITsV4SHGzkdrZ/Xie2Opk0WWyg8
 nS0w==
X-Gm-Message-State: AOAM530xhiofHdpcxckpQ+xWvR8DPj58BTBIjw7pkb8R2I37p0lD7DPW
 f8Hd56FgU2iCEtUMpOvLMF+jNYWuQHXFDxjobHAKD5TdnjjEuOdEt34TJH4HaDG7JgLBGs6dgdY
 l8YH697Cz/M5c4UWDS7o+Zfc6QPeg/Bj41dD42G2F+lEuLtSlODUdOe3r0fC/
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr6458445ota.11.1641991845087; 
 Wed, 12 Jan 2022 04:50:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM+H18459QT/pnZUF17RGyfujL4v5cngiYatRHZMiCD1d/ynvUX+jBq5rww/cWUEn6F5jL1h5ES8nPHbI6LoQ=
X-Received: by 2002:a9d:24e4:: with SMTP id z91mr6458435ota.11.1641991844824; 
 Wed, 12 Jan 2022 04:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
 <20220112071659.GA4502@lst.de>
In-Reply-To: <20220112071659.GA4502@lst.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 12 Jan 2022 20:50:33 +0800
Message-ID: <CAAd53p4+WjhPM6VKZOZKQ4WcgNWjR7Eh_7Kjs1HZ_wiKov6Ctw@mail.gmail.com>
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me, 
 Rajat Jain <rajatja@google.com>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220112_045053_437766_30EC1FB8 
X-CRM114-Status: GOOD (  13.93  )
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

On Wed, Jan 12, 2022 at 3:17 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 12, 2022 at 09:31:54AM +0800, Kai-Heng Feng wrote:
> > Commit c037b6c818c3 ("PCI: Add sysfs "removable" attribute") can mark
> > entire Thunderbolt hierarchy as removable, if system firmware provides
> > correct attribute.
> >
> > So apply GENHD_FL_REMOVABLE for NVMe if removable bit is set, to make
> > userspace daemon like Udisks knows it can be automount.
>
> GENHD_FL_REMOVABLE means removable media as in floppies or CD-ROMs,
> which does not apply to NVMe at all.

USB thumb drives also use this flag, so I am not sure why it's not
applicable to NVMe?

Kai-Heng

