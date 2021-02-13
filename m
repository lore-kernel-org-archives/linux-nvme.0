Return-Path: <SRS0=EhmY=HP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF68C433E0
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Feb 2021 16:47:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664B261494
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Feb 2021 16:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664B261494
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=is/qtIWEC1LGCbEDY4gEirJop6YpFLxu4MJD9/u0ObE=; b=zFp1FZW6iziTBR3lo8UumllqV
	CmVg5mO2qdv10t2QeNeA+vWaxQy086Oy7Uvlvnk9dpaYh/JW4A5vglxAJu34BSJ4ck7vYH4o1+ITX
	Hjv4cD+amzjRj4/dlrvW6SCGyLJ34ljHLY9hESYc1fmeSJ07fDnYlIcu6Rh/AKevu1M0ZEv9uh9SP
	/HkXXMA26fyp96ZVQ9qM0PA4AHt9jqMXQO76mCiyChGKKqrxA+WU7kA9HXlLWUOO8UzeJuKwct/vh
	kwOXHvMsfDh7GJa+GmVcOs2dXWq7FUhtV+jiy0VCc5tvqg0mRCw0qVrcvM3wDPQPw8QqRfZ/gyHeO
	iRXn1vY7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAy4s-0004wI-NM; Sat, 13 Feb 2021 16:47:26 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAy4j-0004sx-KY
 for linux-nvme@lists.infradead.org; Sat, 13 Feb 2021 16:47:20 +0000
Received: by mail-ed1-x531.google.com with SMTP id y18so3378326edw.13
 for <linux-nvme@lists.infradead.org>; Sat, 13 Feb 2021 08:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hpzftsUk2/rMHUGTQ1xA+pUUko30FNDsdd0NDmeqjv0=;
 b=RprEYt5FY2DZ2gm7JJgWqw3TSdPHEW7SqRTxdyPwDHC7sglhy1VGf61gsCPHETQSdA
 uQ2pSXO9xC+4GvY7hZjxBlluvK3poKW/m41eTQByXLDrCknUaAF6X9y1XD3xdFsT9Km6
 2iMoqZEoaweORAG+OfAW3MUFwimAw4OOc2m3ZsZCXdIWNIHtth433+Mp2owrZn2tdc41
 Y7od9jOS6ZyZJwimoIZvmxLZ2kt8Z8yPpN9TDjKo28ncDC5e4G5e16913b4xpreRa/40
 zKbTzfwH/F7tt2ANqabCoExl486d0PY3KICREEx2o1QJngAkg4qEIyESfHMd+n9XG876
 JlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hpzftsUk2/rMHUGTQ1xA+pUUko30FNDsdd0NDmeqjv0=;
 b=RbKrD0KOM8XXE85jzFNg7FUZZljDiOaiyubLMHKPwJ+EeP3zJI9kqUQLpvjMSRPC8X
 UfuJW3dGTIKY8fhIyv1CyPm1Sm5BMKhLnLTKz1VvKPO+ad8htzMRF5T02HMp2DO7b9jp
 ient6p2M6FLz57ZjwDEG3+rWfHKou1u1mTTESX5yzF4w8qScyFgYVSOmqVyAVf05uRu2
 241+wJ4f2JDCDoJS9xxHofLKo8ueRc+IFGGrYDii19YEzn9KNmFXAYa0E5I6d8cCqgXz
 rR+ecSECfzmWl64Q4bTeeggqIV5h21soRJDbkV9xn3YOw0riBRH+0g/HmJqgdR0uvfhl
 a0fA==
X-Gm-Message-State: AOAM531p/4AzWo+BkNP9q4JqEOIVXC4kK7qJ/vjk5WTMu4VcqBdrPcf8
 HzEAqE/Dh/Q6cgjpGxviBBx7C5f/vcVgIYAa0ic=
X-Google-Smtp-Source: ABdhPJy8mjEiLKBO4OsGl4+wG9+UbZ1yTLExMWS2oF/vDVpUZsdOZfkQX2vzMo0pB5RvCgX6yrwznmDF/vLkCrRa2ic=
X-Received: by 2002:a50:c403:: with SMTP id v3mr8358260edf.217.1613234834578; 
 Sat, 13 Feb 2021 08:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20210207181324.11429-1-smalin@marvell.com>
 <20210212180639.GA511742@localhost>
In-Reply-To: <20210212180639.GA511742@localhost>
From: Shai Malin <malin1024@gmail.com>
Date: Sat, 13 Feb 2021 18:47:02 +0200
Message-ID: <CAKKgK4yof3MsvUFAB-yjSBKtf-UhrTGb7vghOUv=ttYG29v1OQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/11] NVMeTCP Offload ULP and QEDN Device Driver
To: Chris Leech <cleech@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210213_114717_774827_2D51373B 
X-CRM114-Status: GOOD (  14.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Shai Malin <smalin@marvell.com>, Ariel Elior <aelior@marvell.com>,
 sagi@grimberg.me, Michal Kalderon <mkalderon@marvell.com>,
 netdev@vger.kernel.org, linux-nvme@lists.infradead.org, kuba@kernel.org,
 Douglas.Farley@dell.com, nassa@marvell.com, Erik.Smith@dell.com,
 pkushwaha@marvell.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 12 Feb 2021 at 20:06, Chris Leech wrote:
>
> On Sun, Feb 07, 2021 at 08:13:13PM +0200, Shai Malin wrote:
> > Queue Initialization:
> > =====================
> > The nvme-tcp-offload ULP module shall register with the existing
> > nvmf_transport_ops (.name = "tcp_offload"), nvme_ctrl_ops and blk_mq_ops.
> > The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
> > with the following ops:
> >  - claim_dev() - in order to resolve the route to the target according to
> >                  the net_dev.
> >  - create_queue() - in order to create offloaded nvme-tcp queue.
> >
> > The nvme-tcp-offload ULP module shall manage all the controller level
> > functionalities, call claim_dev and based on the return values shall call
> > the relevant module create_queue in order to create the admin queue and
> > the IO queues.
>
> Hi Shai,
>
> How well does this claim_dev approach work with multipathing?  Is it
> expected that providing HOST_TRADDR is sufficient control over which
> offload device will be used with multiple valid paths to the controller?
>
> - Chris
>

Hi Chris,

The nvme-tcp-offload multipath behaves the same as the non-offloaded
nvme-tcp. The HOST_TRADDR is sufficient to control which offload device
will be used with multiple valid paths.

- Shai

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
