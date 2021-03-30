Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCDCC433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 18:31:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0844A619CC
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 18:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0844A619CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rT4nXXrY4q50wR8xrfVAyWCkWoPb+DPaNd0NRDHpm+s=; b=AXE3y1jaapxU0jwwQxcmLGros
	VU5djQ84zvRkPvCFXjlip8/cOt06HDX/RMzsQEvagsSuFMFrNIY5JaetTu4EQxYCB0YCHJdnOZuZl
	pIJrAnBmIChhgF3pzEgOIATsK2h9smNMxT2Djqpy5m9ig7uyCVKYIoMSfIBlyzsnhWl/yMLD/avxR
	eUagVGsVTAjWV5jtjkyfH1GAVq2UyeoMI15ZwkZJcdaPVFC8/M5StJOhGAwI6T04D5L8vsV8ExHMO
	YTkNiMgS64YDxzAYHhmCimq60fRP3T3O1/v7gO+aUlnIxKh1FVbQsdLuPHuUuB7W7s5vomSgJFxF+
	7HplzxLJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRJ8a-004cbV-Pd; Tue, 30 Mar 2021 18:30:48 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRJ8G-004cZ2-Cz
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 18:30:30 +0000
Received: by mail-wr1-x432.google.com with SMTP id v4so17148263wrp.13
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 11:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7D0t7kKBUtNyEw7wPH5xr4MnNv8franh5ra+G0ifn8Y=;
 b=uymBmqVAuvj4Qc1pqUaBasAJTL6wtWdKO7YDd5Vdtxejwo3R2vYJm6UfnOa8nFH4i4
 5DXWRcIlnVOrJzetYhD+JDtaUddFcqG4W6JZjtvlE7HI2PtF5jd2VBsJ3rgeTTV0IuQ2
 xC0rSyUvcvyWrF9JgGMS7X5RtTxa14rLqdtsWMBBOzBjQ12uj5ouHGfBqXmrL80pHGee
 Ap16LpJUCg+7ZpjMspkLz4yV2MgGyPV+Mg3pTierWpphCd6u/Jb5vpuQc5OqzhETpLQO
 xe5Il9aWV/HIPV4rCVmPZhMUB+JXnjnFqhd0GOPhYMTy+h0UF2Jw/XsH4Xmwy4imncUw
 vPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7D0t7kKBUtNyEw7wPH5xr4MnNv8franh5ra+G0ifn8Y=;
 b=CMaGL5myTxWCs2qRwkzPXREbOwK60/2HMc9AR2XxBazP43WsvADiqval7RqT6/27gx
 +3xSc0zyYmOHyYllsH4zohhgMLYnm2brDlHY0q4nUfy/O9N0T9Gx4F43vvVQGoa8mhTw
 Imh8a1mBN0ONf0mDTZzHf6CH47Hpy2ar82KiDr5NXHEC4UBjvQoBPmI+TmiImy4Jhyn0
 S/wE4HKe/3iYiuYL+XszeFopdLpM5rt55fX9z85RTBMNKT4kjNO/JxmfvrPqPUjPrQsF
 4cHlG/F3WBlVduf0xHo61m1s4pZ3SJlAhLxqpz5IQk0p7M4IjhnnEpW73orfXrqsxLi+
 aKFA==
X-Gm-Message-State: AOAM533XTiSzzkqPYf59i3w67l+C+1Wu8J/HGzo2o95DxA8dEMmNCBq4
 mln+QFGNlO4T5H9ASNYj+AB+vw==
X-Google-Smtp-Source: ABdhPJymomQExG2eLXNKLB31LudJ7J4baachDCHVBba/qfYV3t5+/wnKwIiXS2YwehuQQUdsJEL7NQ==
X-Received: by 2002:a5d:5904:: with SMTP id v4mr35634271wrd.261.1617129025361; 
 Tue, 30 Mar 2021 11:30:25 -0700 (PDT)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id a15sm26149964wrr.53.2021.03.30.11.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Mar 2021 11:30:24 -0700 (PDT)
Date: Tue, 30 Mar 2021 20:30:22 +0200
From: "javier@javigon.com" <javier@javigon.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] nvme: allow NVME_IOCTL_IO_CMD on controller char dev
 even when multiple ns
Message-ID: <20210330183022.arjiqiufiuqkrvwc@mpHalley.local>
References: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_193028_724555_F9FE2DAC 
X-CRM114-Status: GOOD (  19.59  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26.03.2021 20:59, Niklas Cassel wrote:
>From: Niklas Cassel <niklas.cassel@wdc.com>
>
>Currently when doing NVME_IOCTL_IO_CMD on the controller character device,
>the command is rejected if there is more than one namespace in the
>ctrl->namespaces list.
>
>There is not really any reason for this restriction.
>Instead, check the nsid value specified in the passthru command, and try
>to find the matching namespace in ctrl->namespaces list.
>If found, call nvme_user_cmd() on the namespace.
>If not found, reject the command.
>
>While at it, remove the warning that says that NVME_IOCTL_IO_CMD is
>deprecated on the controller character device.
>There is no comment saying why it is deprecated.
>It might be very unsafe to send a passthru command, but if that is
>the issue with this IOCTL, then we should add a warning about that
>instead.
>
>Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

I think the idea is OK, but I have 3 questions:

   1. Wouldn't this break user-space when nsid is not specified?
   2. What is the use case for this? As I understand it, this char device
   is primarily for admin commands sent to the controller. Do you see a
   use case for sending commands to the namespace using the controller
   char device?
   3. Following up on the above, if the use-case is I/O, don't you think
   it is cleaner to use the ongoing per-namespace char device effort? We
   would very much like to get your input there and eventually send a
   series together. When this is merged, we could wire that logic to the
   controller char device if there is an use-case for it.

Javier

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
