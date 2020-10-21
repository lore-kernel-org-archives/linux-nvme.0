Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C06DC56202
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 14:24:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5C02222C8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 14:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d8QW5JMH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C02222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cKDqgrqpAnRtbMg45MpgGHyejyOdwWUav8CSRRmk59s=; b=d8QW5JMHcH4Atruve5SqRqJly
	J1TCJbnT6Wnm76ZeJyb7tXmBz054DiIrDFHJQDvVICshi55WWHlWadHCvhAR9l4mweWaS/5pwXxOS
	RbcmaHIycpzz8wGSb7BY9wR1PAHxFkJg/fzhCtazeDpVCKCPd2ft+PPt4mBB3vcbICbDdhW1I+eM0
	sdZOyA9jpeZZcPjk2TQ8ZjtRwccVcO4N2zdkgsvDCMuF0UDpHdrjd6nWV6xO5chJh9BcMf3wtAIpK
	gRc/EfAGYakSjltfL9At9Z2YSUkPey+9oAbXHpEY4PkeULHTZGolORN3bpaWJ1Uwh/p/2/BwUJ04g
	KX1NT6/sQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVF2P-0003rx-4a; Wed, 21 Oct 2020 14:24:25 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVF2M-0003qK-60
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 14:24:23 +0000
Received: by mail-pf1-f195.google.com with SMTP id f19so1559298pfj.11
 for <linux-nvme@lists.infradead.org>; Wed, 21 Oct 2020 07:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kd24n8fvExqkMZoTQn7ZLbjiXdKLPg+Z9WhqJAOkLno=;
 b=Jw1WaxSjcAd+9cO6il8aMJwRoslvTZUElroPhfVNsL3Psn84z09L0sR/XUGUdepVXX
 hBxDty6uC0hBX9SZ9wj+74rNxiQRnuwHB054oYoIHkYMwxL84Sj6uOO9RSEnqfmc20kr
 3MZHtHMkV2VXTJMNfxHNi2KMqMerDXn3AqrlrBdCAmkQ7fdDaPa/lHucePRfWN3r8r9v
 +W1oXQFVE+0EnjYAhLW2m0c/Znejai2R7ZkOY/2dBeOAnRl7888xb32P7kYk0WuRS0FX
 bwT5Q2dw9uypSWPrUX08qkP7Dbe7qTMOytnzZS6xevJf4a36DINqaVa/4wMDIne/LW2t
 x/jw==
X-Gm-Message-State: AOAM533UfcXTGkE+QefVkYYG8BTw7cA29l3DqOoUIyt4CtgpyIBdeUJ9
 CGO3gwm+QcfC7slJIyJfYl5gxnOEqdimGdz2iDI=
X-Google-Smtp-Source: ABdhPJzzUagLy2/wTR2reR/iEjOUzGDitwgsUDsCMI6OUJ3VjWJ4T7EinTswEywdjKJZfSeH/cpZeoxXijk2LTN0EIQ=
X-Received: by 2002:a63:a546:: with SMTP id r6mr3613847pgu.160.1603290258598; 
 Wed, 21 Oct 2020 07:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org>
 <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
In-Reply-To: <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
From: Mike Snitzer <snitzer@redhat.com>
Date: Wed, 21 Oct 2020 10:24:05 -0400
Message-ID: <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To: Dan Williams <dan.j.williams@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_102422_292362_8A1ECC79 
X-CRM114-Status: GOOD (  12.54  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "Steve Moyer \(smoyer\)" <smoyer@micron.com>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 "John Groves \(jgroves\)" <jgroves@micron.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 device-mapper development <dm-devel@redhat.com>,
 "Nabeel Meeramohideen Mohamed \(nmeeramohide\)" <nmeeramohide@micron.com>,
 "Pierre Labat \(plabat\)" <plabat@micron.com>,
 "Greg Becker \(gbecker\)" <gbecker@micron.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Dan,

On Fri, Oct 16, 2020 at 6:38 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> (nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> > (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> > convenient mechanism for controlling access to and managing the multiple storage
> > volumes, and in the future pmem devices, that may comprise an logical mpool.
>
> Christoph and I have talked about replacing the pmem driver's
> dependence on device-mapper for pooling.

Was this discussion done publicly or private?  If public please share
a pointer to the thread.

I'd really like to understand the problem statement that is leading to
pursuing a pmem native alternative to existing DM.

Thanks,
Mike

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
