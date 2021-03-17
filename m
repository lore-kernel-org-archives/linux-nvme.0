Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A41AC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 09:38:50 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBBA64F40
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 09:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBBA64F40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K0kKS0mnDV4pzdUGUsIMTDz39lCm35n7kpQDCiFPrmM=; b=D/sZ5F2eRLGo5FF+k7aQylTJj
	EacklfqaSNTJwEqZn25VnUIik7s9jqCPnTsS5pVIzCvioEXjSuArwIkvZOYPmPU1xq3i2bgKJ4TAO
	wPWYG6kZBtrd527dYn8E3ZCuYLfK9dym27EjW7a01Y3rQg+BiM54iuYTipYZPgrMOyXN6WjFSUiQU
	woZSB8tPjWy4ntfJF9N/KCZUh2hkvaTA8W6hmZ6mxhBnGXDJ12+XdF4/yg5b7qwCVqPtsw1XdGc4d
	is0ag3yVBi06Vo7xgiWJwc10yh55rEy0ovb8znqaV1NDyEvcM/Rxhg1UMADJPVdxvRscCu7EPyKVZ
	YckbWRRzw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMSdT-002rxu-J6; Wed, 17 Mar 2021 09:38:39 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMSdO-002rxO-PT
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 09:38:36 +0000
Received: by mail-wm1-x329.google.com with SMTP id
 f22-20020a7bc8d60000b029010c024a1407so2995689wml.2
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OMaDU1LssD4SRDotkuNIMUgfOpR2CMTm0AB19wYg3Ug=;
 b=TXy9pVuxXSuBL0zAf0OJju9+LlC9GMCUM9+rQcIQpLQU6e9gnSN4AsOBDf8s1pDGIs
 y47Nr3nCmIOtvUOtr5dQQCjD1UTicUhYWJbldiK6NNj+ChTS/r1vmZsWfX/M+gDJOL1b
 RLYpeT+wZnMMadfDtiJGWDZ4bk+yX+L9pm64dYZEuCQb68VSuoNVsDLmDIhtbWOiSg3T
 yxmeREGZIMXD6usmtz9rUfzjLx1nrYzWn3AjEFkHxl690dQ0nS9K/4dh0Pi6G6HvIafo
 UrMyZISYPL4nSY+RRMlsP25o2AM6DVvzLVocQ+3mm0VOmdUGIF/HsuvuyrpDDrMq3gLP
 ViAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OMaDU1LssD4SRDotkuNIMUgfOpR2CMTm0AB19wYg3Ug=;
 b=e7yTh7+/meO7s1JxYJY/hL5uYwzMjxoe1uzXzybtJ9Gj2PRC6R3rw4dvQVVZYAya51
 TuTh8TggX49VcKpq5Uf4WRFKWRtaIVFxF2hoDxsXRazdPygUqxjafP9f8YXP3KVHNLFO
 9DI5aiClAJ1bzP3C0Ofo77jIwCDbC2LqempDIWUeRXciUTQstoJbD2e3EeSCpeYqR5im
 0N+yVEJWwI6efhRqwNAbDZ0pqWdRHumR2xF11hRyDqdAoF9jDUw4GWod19OVMaR8vp5U
 a1zAyiBeWBJisM+iChCoAfxEA2mdiZyeYw5NX5gv6YWVYxZmkFztPSqJT67g9fc0snIG
 dHmA==
X-Gm-Message-State: AOAM530weOP7xOQb/KvPpDCb51W3bC77kexY+xGJYIXxXGT/phHG4Dck
 s7nC+sRgCpXe78yRVJt0zPSI7Y10sxWLP25eP6g=
X-Google-Smtp-Source: ABdhPJzlX3JiHmmQ7nxtnbUljuSZK2MyF+mqIL3SYHiGq1PMRWkKJbrDuRSpsgPYW1EFBg1sN9n/rRgsKgZi1SSm4Ok=
X-Received: by 2002:a7b:c931:: with SMTP id h17mr2876607wml.4.1615973914198;
 Wed, 17 Mar 2021 02:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140236epcas5p4de087ee51a862402146fbbc621d4d4c6@epcas5p4.samsung.com>
 <20210316140126.24900-3-joshi.k@samsung.com>
 <20210316171628.GA4161119@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210316171628.GA4161119@dhcp-10-100-145-180.wdc.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 17 Mar 2021 15:08:09 +0530
Message-ID: <CA+1E3r+vddNqqPh5=+U0v_mLA4=gUdJVhtv3PJzwXXtrfr2xCA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] nvme: keep nvme_command instead of pointer to
 it
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, 
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, 
 Selvakumar S <selvakuma.s1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_093834_944562_CA63F487 
X-CRM114-Status: GOOD (  16.43  )
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

On Tue, Mar 16, 2021 at 10:53 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 07:31:25PM +0530, Kanchan Joshi wrote:
> > nvme_req structure originally contained a pointer to nvme_command.
> > Change nvme_req structure to keep the command itself.
> > This helps in avoiding hot-path memory-allocation for async-passthrough.
>
> I have a slightly different take on how to handle pre-allocated
> passthrough commands. Every transport except PCI already preallocates a
> 'struct nvme_command' within the pdu, so allocating another one looks
> redundant. Also, it does consume quite a bit of memory for something
> that is used only for the passthrough case.
>
> I think we can solve both concerns by always using the PDU nvme_command
> rather than have the transport drivers provide it. I just sent the patch
> here if you can take a look. It tested fine on PCI and loop (haven't
> tested any other transports).
>
>  http://lists.infradead.org/pipermail/linux-nvme/2021-March/023711.html

Sounds fine, thanks for the patch, looking at it.
Which kernel you used for these. 'Patch 2' doesn't  apply cleanly.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
