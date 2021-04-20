Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C698C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:15:02 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1FC613C8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1FC613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xYMbYaYTWtLj+h6IWIbFdb7L42mYBXhllEnVwdhpsPM=; b=dmUy95lPcmRvWNQ8S/bsuzq42
	8nAyAYYnY5PqFQXiqd6sO2ZB+RbY1GjLSM+zbR9244Smhe+/v37PfbxwQuNH3gCvJvE0TQv4jXfTK
	rOrfPSYBD0r9xVj+ABR+n7Mr7GZTZdfJeaTWC593LlxMo+R85na6cYL0IhNlBCIOvaVOD17mI6jLN
	cfRsLUcrX84FA3z/IinKqjVP9u5LajNop+rGOEZJhwArwgvUM05Q1ueN9Koe5oUptddhgqTlynoYk
	QdRp4n8IaRzJuHZS/1bVGZPVjc0vdXbjuG0uEjPRWEIC+s3KyUHXZjMF656I8qp3jCtEffqATTLWy
	kmdlfqekA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYutK-00CoLu-EJ; Tue, 20 Apr 2021 18:14:30 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYutH-00CoLn-LD
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 18:14:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BSbiQacIUh4j0t8bov52NXTJ8ysWrCxcQ9rKiHQ8gQA=; b=WmXjYg7yd9Hf2o6sPVQJKIXicX
 mmy016cISQ9A+Fa4m7XzA9fTW4DmblA5YKpKevG9pynx+Zpxlb7CGJ2gNQgKpME1YYI/ZzevJbP8h
 VfHSfESPhgzeqHjw/v+hUl3qq/aeL9SjEKlDGTcUmSQAS1+xI5sfT477KbAxOZBLo/wLjQkHjKJGa
 VKqfWqOR8J6rIYj/mlNNIWlgET6x5vHl4SOd6a76p2cM719TnXLdypUMsvnz6yHxeOyhwtZ4kxLCn
 rhM73Afn1OcqfmDpvkL15Vq5pDLIewdmlTGrGsFFeq7dMwcl5MsCZCBkQf5oMZ9QC6INI6FyvzMqC
 4hOApkrw==;
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYutB-00CL4v-Vu
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 18:14:26 +0000
Received: by mail-wm1-x32b.google.com with SMTP id
 d200-20020a1c1dd10000b02901384767d4a5so4625967wmd.3
 for <linux-nvme@lists.infradead.org>; Tue, 20 Apr 2021 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BSbiQacIUh4j0t8bov52NXTJ8ysWrCxcQ9rKiHQ8gQA=;
 b=cOU3RmO554LQ3OPmkDQHge7iJtkFHUawDe6ZNhK/+5QhyMRkWRqcFulbpFAogxfAxa
 a5vnOsS2nhSM7AxSITRCfXD6OiFtrcXfJ7S8exbC3+80gtN+16vKdpd4k3VQUmbusu1X
 kJFIHfrgSTXeFE93tncj5QGcWXdEfitACql7t710bzTmC6DUs0EknkCkoQFffQUpI2Nq
 azS0o9OPEqPA5kakb92pYFKB6xxUcnZVaGCxQmj9Fir7YDn+L0S9bcUOBh0ryQSd2Dpx
 vlsimR+62mCbBeXGUfo6mJj+W9hIkwUMM4himKTIGeWYKfsZpPMjTEDPzze6lP+HPR57
 ZplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BSbiQacIUh4j0t8bov52NXTJ8ysWrCxcQ9rKiHQ8gQA=;
 b=Et4SGMhU1QPulY7Lt7UYfW/eECJdSx/TWtlEZi86FGlbSuZBbTpXVeI2UPSozWcb/U
 qHS9GR6iyP9nezJPHBOSBEoW7y6zWA/tcT8lCiwQYPBgA4r+uhJt2zcP/HIyNKlsvpBD
 PqIW0j84WN7lp2jkBj459p3bMTdcX2FIFzbhNULjVcilY3KaWQI/mzGLl5gFad12DskZ
 Z0Jgg8LMK9e6KMkflJjogi2iCTOfNFqQA4aTVkGUK0EATLsWk5xHJBkDsWZo08GsF5MB
 c+/g5wvmR7ZLZUVQy3N52oCyXKOR9zIvhxOgisXgija/SZ1xN5b31bBv6bTuwnUtGted
 eMsw==
X-Gm-Message-State: AOAM531gl7bSmXM3EsD+ddY2ZoAMq3p5l4zdrhDY1PRx9jpUOJHW+HOp
 hK+y2CX26Q+3IKGV2oyCqak/i6gXLhLGchNTQ7M=
X-Google-Smtp-Source: ABdhPJyCJ8V6IK0KLzMzNUaJWHk4uYormPsKChUpmCYAPOTbK1gSGgFyfm3WrUP1L7AWC/sM3UEbNw0hrNDzqECTIoo=
X-Received: by 2002:a7b:c394:: with SMTP id s20mr5861930wmj.4.1618942458716;
 Tue, 20 Apr 2021 11:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210420100746.2801722-1-hch@lst.de>
 <20210420100746.2801722-2-hch@lst.de>
In-Reply-To: <20210420100746.2801722-2-hch@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 20 Apr 2021 23:43:51 +0530
Message-ID: <CA+1E3rLB5C+zP1xduzwq2uwWgEWFxUt5x=hostq5YOgj_QBNbA@mail.gmail.com>
Subject: Re: [PATCH] nvme: introduce generic per-namespace chardev
To: Christoph Hellwig <hch@lst.de>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Sagi Grimberg <sagi@grimberg.me>, "Javier Gonz??lez" <javier.gonz@samsung.com>,
 linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_111422_049938_C4A14F00 
X-CRM114-Status: GOOD (  13.04  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 20, 2021 at 3:37 PM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Minwoo Im <minwoo.im.dev@gmail.com>
>
> Userspace has not been allowed to I/O to device that's failed to
> be initialized.  This patch introduces generic per-namespace character
> device to allow userspace to I/O regardless the block device is there or
> not.

When an application uses this interface to issue passthrough IO, it
needs to know the lba size (at least) to form the command correctly.
But determining lba size would require an admin ioctl.
Do you see there is a way to go about this issue?


-- 
Joshi

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
