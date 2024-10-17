Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF2D3C52C
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 18:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vEVSrXb7Vkp9JTRO/9k2XSu/s4ZMm6+yKyw7GARTfQ=; b=bUvohTLmLfEfKbt5rU/FnUdwaG
	puKPTuuu3L3yzxGGMGAwSE6kGQ0ifISlafa7WNHhcp0tw1+fMxU6p4c6psgp17gWwkQnQMu+wyZYT
	EEEU/dFVCfU4Ym/1mJ6bCs7Okod8X1hnFVhg6PGjFGIixe6BImAPN/i3DMheG0phSW7ZMQoSE4MbI
	SlJF5SlnpNBUBxsn7ig7IxMBImk0oF7c+Ua8774VE6Gyegwic5lcFeWGsLWYGCCuJ6lgYQHRZviAH
	N397Hc1iTYnLQPthTZu914e9K5U+Zk6f8ed02GMO4t0w315XuWy3Epxwkjt1phvmAPcEG8XLhAZjH
	9j5b/6Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1V2Z-0000000Fqf8-0iKs;
	Thu, 17 Oct 2024 18:16:03 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Tt4-0000000FdH4-0mH4
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 17:02:14 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2e2b720a0bbso202137a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1729184528; x=1729789328; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vEVSrXb7Vkp9JTRO/9k2XSu/s4ZMm6+yKyw7GARTfQ=;
        b=E8EJ8h21Jl02/AqWeL9WH3ayaxYULoFmo+q4lcvo9kGRxS5ck7NU5FmZCSxDa5fvK4
         ZaiAQDspaEq9Yz/cyKnXrmfuDrLYJzHoaULWygZLtEG3rUfDmleDiv7gFD7DchUrd9SY
         dk3PnPA6eyqwReOjDrWw8MczSpVDVX66pJb3jEhWVfaqF8AEelyfnVB38ZKMiARqkQLY
         lj/RHENCG8R9xStu0kVa6wtuqFh6awPdq9V4/JFbE6yoCISx/DXbBnFrlMF3VKrj5hf+
         Q+8n4ni9pZ9vdjnxIGVkp7ipXpQUUxKSrmeFI77/UyoFBXEdstRZoPjPwFVqZiUebgZd
         /K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729184528; x=1729789328;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vEVSrXb7Vkp9JTRO/9k2XSu/s4ZMm6+yKyw7GARTfQ=;
        b=Aee8FtRF4RYP4jKC/8wtwmbw7ynb6/WSqGB8u6FeNTS6A7/9ee3s10SKqS0PJCgxfO
         hWw2tlBbDZ7qD8W59l/WRw7dS0YgNxcW0fQEUmXkh+28c/huoMjiRy7OCftre52AMwXJ
         ZUW42SQcjWNuG/6p4rTxKZ+lwcUWzhqiJjlNeZrCZOaCvewOc1VqkgnRJ41wGkbNoP0E
         eDwuteTDT6IjT5k436vDdjA7qZf8WvHAOj1lFHU4aNOZi68aWFB5SrmZiUTK+BKHJP34
         ZbX3JHjDEMK22FGqK5kpT9Vw4Pkb8/Jv9vrGVD+X9d1212/Z06S1ccAHfmv3mqZ5R9tG
         iXdA==
X-Forwarded-Encrypted: i=1; AJvYcCW/9dSmMfb3yvZfY0DsHV2dRAfPwBuAIG//LVSRztCDMtnVB+20Ze18GWNHK4SLsxlvV9MvnJPNX1gO@lists.infradead.org
X-Gm-Message-State: AOJu0YwoUFm7loGOC3BNHDGa1nZc5CifidYuRnmYMtmF3HEvmKDx6fQh
	UBtMX01MlLXci/lhBhnzKfHOZJ6VLqT26PSJm6Wb3lxlw4Aa+eohq2yS67slRge9CG8Uo69Hadx
	ZjS3+nZj73oM+jh+aMou/o2znJfIAxmHNnnSPVg==
X-Google-Smtp-Source: AGHT+IHkxHHcRBdYrEyk6gHLJhWuuIDP4JRrLIRP9fJlf4vh+KGsBy//sp1vV+aoB7B27XSZBievJGZmdU5L87zQViQ=
X-Received: by 2002:a17:90b:4f4b:b0:2e2:cd5e:b25 with SMTP id
 98e67ed59e1d1-2e55dd697e2mr29221a91.6.1729184528131; Thu, 17 Oct 2024
 10:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241016213108.549000-1-abhishekbapat@google.com> <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 17 Oct 2024 10:01:56 -0700
Message-ID: <CADUfDZrvGJ8rNmwTu8WQYy9R03DLZwnMqRA-nWuVUzy1kXHXvQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring namespaces
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Prashant Malani <pmalani@google.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_100210_274229_57061131 
X-CRM114-Status: GOOD (  19.52  )
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

I agree it would be convenient for the kernel to expose a generic "max
data size" limit for the NVMe controller. For example, nvme-cli
currently pessimistically assumes a controller's maximum data transfer
size is 4 KB when sending Get Log Page commands:
https://github.com/linux-nvme/libnvme/blob/8cdd746b324bd84a0666e7a265aa253d=
bda9d932/src/nvme/ioctl.c#L330.
Fetching large log pages results in a lot of Get Log Page commands. If
nvme-cli could tell that the controller and kernel support larger data
transfers, it could fetch the entire log page (or a much larger chunk)
in a Get Log Page command.

Best,
Caleb


On Thu, Oct 17, 2024 at 9:46=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, Oct 16, 2024 at 09:31:08PM +0000, Abhishek Bapat wrote:
> > max_hw_sectors based on DMA optimized limitation") introduced a
> > limitation on the value of max_hw_sectors_kb, restricting it to 128KiB
> > (MDTS =3D 5). This restricion was implemented to mitigate lockups
> > encountered in high-core count AMD servers.
>
> There are other limits that can constrain transfer sizes below the
> device's MDTS. For example, the driver can only preallocate so much
> space for DMA and SGL descriptors, so 8MB is the current max transfer
> sizes the driver can support, and a device's MDTS can be much bigger
> than that.
>
> Anyway, yeah, I guess having a controller generic way to export this
> sounds like a good idea, but I wonder if the nvme driver is the right
> place to do it. The request_queue has all the limits you need to know
> about, but these are only exported if a gendisk is attached to it.
> Maybe we can create a queue subdirectory to the char dev too.
>

