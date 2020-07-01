Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFF9C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 16:08:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DFAD207FB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 16:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1BNvEIHg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="sgyWg0od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DFAD207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pbofACVZgLCGdagDh7ZihP3llR2KVtgmzjlwOV8arko=; b=1BNvEIHg+i9luKcLlFqOl1jbo
	hGRUa73Xaj50KoiaDULE7ZPxtaHmOM/xdROlRfnzJWuNNZD3HEY72jQZWsQiL8AfkrAlTWduEkkSc
	d+Xi2YkbN7sIn8E05zN61ZR04qe/Zoyh+gU5mF4+UV7GTw4iRvtPHFyxuovzkWNNSFZWi1D+MdGJS
	zbwckTbOV1Zs9NjY4vAWD3plrQa3d0Dm1kg3IRTo8bUd1MF0p+ZmbQzKEKchliDNVbWnpHkwIkoEi
	30vcQ+FNttVhI/ljLg2jBbyFub4xXfwtRfYqYbXgWc6Vhmqw6u23qV7LNdMJLr/TESEmxGkIwScnC
	onx9MB2ew==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqfHm-00023d-3G; Wed, 01 Jul 2020 16:08:34 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqfHh-00021b-VP
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 16:08:31 +0000
Received: by mail-ed1-x543.google.com with SMTP id g20so20247962edm.4
 for <linux-nvme@lists.infradead.org>; Wed, 01 Jul 2020 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NgtGRFNzMUt8UwQnpVLH6Q0lK3Q/pmzbcISwUTSvZp4=;
 b=sgyWg0odMXUUNA+ymUvc43LaYs2s/aJwbFyXWRoPjxwdAxwM/8NDCnpUaFI4p3liR0
 gB3SPFv0A/WozVPJacrsy3TT9HIOMMCESTpphsqE92coNdoMTDE/jB5/k99TrA7k0WXT
 HwfvYQsx393r8hZTsu6RX5RUEhIafmeLpfC5Xxvgan8YQB6lIclWByvvZYmq9DcmZLWN
 JlL5WK7hHhUXeDny6LC8Ts2exiDWCHCRjEx+DVoYVUZMCGpeUSrXG6yeqYlDTXCkU+hk
 g1qHbmn4FwKHi5mTo+XYno4GD6wFdoeaM1etI9G0XSOMB6JxPVUPvp1yv+DnjQn7iHAQ
 vT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NgtGRFNzMUt8UwQnpVLH6Q0lK3Q/pmzbcISwUTSvZp4=;
 b=GE9H+Gr7Bb6tO60kYLy8zMDP3s4d8MVcpTw+zUQisgk0df3lX1puhcRxjMqBOh7gsD
 klMJqEJaaKeAdIscK04L1fxL4Cp8NPTr3ZxdPLHXmotZtHbs8ge1lMUslQySFKxNygzf
 Gvs3HGbu8078ZFRchWdWghxgk+Ffn0ZHF093znm3TymuhU0p/4WXubvFUKelgeFUm7Qx
 nxLmd0EAcv3CjGFbOv1tLdYkfTreBKFJ8dxc1WtadP3AebNyS6SBZaUB0OOKWFEi12uO
 lOndcBc5eHCCtyl0Ru1Z1r0zTaIMc7kPnJKhtpi1PDH3xiWKgIJkP456bmBGkYXC2Ee4
 +xyw==
X-Gm-Message-State: AOAM5325SuzHiQEfQPBC+6rzTR4lW4KbfyOoVgDvB1L2CBISrub7DYGG
 IgoWS+ia2O7dppcIaZM22O+sKXlkzRPP98KxwYJ7bA==
X-Google-Smtp-Source: ABdhPJwTtEaJeqUJmjVrnga0zb3T87bQXg/qHVHNHjeT7uurwTRSLAeKnsyE6dqNxhAJ1jQ5OrZ9KB+p0GzE9WKAsFg=
X-Received: by 2002:a05:6402:21c2:: with SMTP id
 bi2mr29609575edb.296.1593619707927; 
 Wed, 01 Jul 2020 09:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200701085947.3354405-1-hch@lst.de>
 <20200701085947.3354405-17-hch@lst.de>
In-Reply-To: <20200701085947.3354405-17-hch@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 1 Jul 2020 09:08:17 -0700
Message-ID: <CAPcyv4hELsX=dnqppbL72Tg2k8xMm-5ZaEsxM98eQ7XPoG5NGg@mail.gmail.com>
Subject: Re: [PATCH 16/20] block: move ->make_request_fn to struct
 block_device_operations
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_120830_160343_C4BFACCC 
X-CRM114-Status: GOOD (  12.91  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 linux-s390 <linux-s390@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
 linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-raid <linux-raid@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>, linux-bcache@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 1, 2020 at 2:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The make_request_fn is a little weird in that it sits directly in
> struct request_queue instead of an operation vector.  Replace it with
> a block_device_operations method called submit_bio (which describes much
> better what it does).  Also remove the request_queue argument to it, as
> the queue can be derived pretty trivially from the bio.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[..]
>  drivers/nvdimm/blk.c                          |  5 +-
>  drivers/nvdimm/btt.c                          |  5 +-
>  drivers/nvdimm/pmem.c                         |  5 +-

For drivers/nvdimm

Acked-by: Dan Williams <dan.j.williams@intel.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
