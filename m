Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5B8C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 06:15:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C7264F18
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 06:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C7264F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hLKjKBa2gn1KCI0QjI3AJw4I+1UQ7Tg/E61I5zBP6+Y=; b=XYP95Ya/TxDRxiqAMccQ2miHN
	5STnN1AUs0ceAsWEVkvatLClyykowwASCyn5quOY7g/ej9X6r5O5GZb9CQ4KKdr/3mMjGCECeMzol
	OCtOj4JKV+R2JmaZ52SG4DXyzfnBMVxcUTHryELCRX5Ao2wTimrDLTP6xl4fVuBC0obac9/yk/sLg
	v0yp8QDq0AHPSXjNDaM2DctqEarODlNqJcEXq6bDr2Af/N5q7KfPoj9DvW+GclrKOiEmnCRW2RZ6X
	vfpcWTcfiZd9feaqCtTgoYHofgbCfwwdedrN6mpGu47LZymxZomqAmZMh1C2tFKA3cM4UOr/JQuTz
	75cbFO0iA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMlwA-004bO0-VR; Thu, 18 Mar 2021 06:15:15 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMlw1-004bMz-Ro
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 06:15:07 +0000
Received: by mail-wr1-x431.google.com with SMTP id t9so4203774wrn.11
 for <linux-nvme@lists.infradead.org>; Wed, 17 Mar 2021 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nCsEa7rjIzQDtOdxS9bWwujiQOvTTGKfa9YG/w1Lgg0=;
 b=cLy1GCebIL5SFcSud4WCZMPg2kwGvqD2AAE0OFZinDA4OigCUKemHipOMxHHkT01Zn
 MgEz70eulLDLt7cZBkuiIuw2KCmIdaHm+jWom+rwU4msglUoRIqBFHyoc2aHj2MjPsie
 SSvKSGNjon6Z7+3T6Pw72hUKfKvFeQIuYxlWv0EtQPbMuRok2fO62D9DMI/SzviCaT8f
 zWr8CMDKf9rHv5usHk1VE9pCZ2jIWQ1ltjYWgqsof04YVjuco41MJdHn0meVCidAF40u
 9SQGBKZ2wGkJPvm18b/US8ZxrDncO7R+rCc00oGBnLJBbvRVOWxJqWeVq1JdoyUTaq9C
 6iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nCsEa7rjIzQDtOdxS9bWwujiQOvTTGKfa9YG/w1Lgg0=;
 b=KhC9osPlkG8BOhAKvLTvyOzGiw/1wHQmKsGq9hW+LW3zXTmSJGTkVWvgRKOwWkC4Wo
 n9hcBj+S8rN8Jk2d0Hqxzw337GEA4cxk+ToO41jJCLrNFs619vfV82raxjQ5A3f0HLJf
 wyXBfQ73jnf2aE3KERxr1mRiC9FVRaTEPpsL9f8NWMefabm9pv6Vh3WravEnusDI6nxr
 lj6V2Fr7vJL83v9atZfXmhkmIOId4vUQFJZbb9+HmCvujJqk3++cv2B1dPZ4gp+yPhpv
 8ci9Nq1DcbGQbOG/DRyeNDhz+UxOTzuofoo9yLsX/yO5NS7RpEpN/k4oZ66IpYqiFXH2
 ICSA==
X-Gm-Message-State: AOAM5318ISR/t1RKP6XolPRMaal4ucW6R4BecSCmrX5nOK/fpo9bNITD
 Em8cOsVuZ1RrM7yuVR3GFhQUBmE2ysG2fNocGVE=
X-Google-Smtp-Source: ABdhPJxQ66k893grC+tyfnJy+8q1d9Rw/d7KjcHEtAgzHlLJITbwHmBrfit/xqLii6Xf6ZqyzHXFll/il0lXRYaP3S0=
X-Received: by 2002:a05:6000:2c8:: with SMTP id
 o8mr7854769wry.407.1616048105247; 
 Wed, 17 Mar 2021 23:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140233epcas5p372405e7cb302c61dba5e1094fa796513@epcas5p3.samsung.com>
 <20210316140126.24900-2-joshi.k@samsung.com>
 <05a91368-1ba8-8583-d2ab-8db70b92df76@kernel.dk>
 <CA+1E3r+Mt7KKeFeYf7WY3CoKwnkXT-jE2EgJSTE6zaAfJX0dzQ@mail.gmail.com>
 <20210318054807.GA28576@lst.de>
In-Reply-To: <20210318054807.GA28576@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 18 Mar 2021 11:44:38 +0530
Message-ID: <CA+1E3rKfKaJ7Vi78o5nrG6BCpUf2zvoi8Y_=5GXhum8cBqPCzg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] io_uring: add helper for uring_cmd completion
 in submitter-task
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>, 
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, io-uring@vger.kernel.org, 
 linux-nvme@lists.infradead.org, anuj20.g@samsung.com, 
 Javier Gonzalez <javier.gonz@samsung.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, 
 Selvakumar S <selvakuma.s1@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_061506_087212_3CB30E98 
X-CRM114-Status: GOOD (  19.15  )
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

On Thu, Mar 18, 2021 at 11:18 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Mar 18, 2021 at 10:55:55AM +0530, Kanchan Joshi wrote:
> > I started with that, but the problem was implementing the driver callback .
> > The callbacks receive only one argument which is "struct callback_head
> > *", and the driver needs to extract "io_uring_cmd *" out of it.
> > This part -
> > +static void uring_cmd_work(struct callback_head *cb)
> > +{
> > +     struct io_kiocb *req = container_of(cb, struct io_kiocb, task_work);
> > +     struct io_uring_cmd *cmd = &req->uring_cmd;
> >
> > If the callback has to move to the driver (nvme), the driver needs
> > visibility to "struct io_kiocb" which is uring-local.
> > Do you see a better way to handle this?
>
> Can't you just add a helper in io_uring.c that does something like this:
>
> struct io_uring_cmd *callback_to_io_uring_cmd(struct callback_head *cb)
> {
>         return &container_of(cb, struct io_kiocb, task_work)->uring_cmd;
> }
> EXPORT_SYMBOL_GPL(callback_to_io_uring_cmd);

That solves it, thanks.


--
Kanchan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
