Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074F5C2D0E5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 20:15:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C342720740
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 20:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rny9uhb4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="1bI5iX83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C342720740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	References:In-Reply-To:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y8fH90knHVnt0BM+h0J6sAGI8n0OsBmnbWOO2vfUpxQ=; b=rny9uhb4xvxcrx
	OVXg+1H8WGHgNQZU6S1RNyuM2OocakyE4TmxvtGS3kG16NB+h3XLwqDteVfkr4QOZEPwuzVtGsUQ1
	4plMnYv5jdAhZwInue8Um5Nuzn+HnqyyAoey8hZjU6RY9maAiH9hSw5UFSItGD139Wig2ikfeygdm
	MbX9WvcBi084ne8ac69bA1XRhZQO98OEONgoKR7lFPKJr+Jt3bPiCDJCv3vy7bph/IIIuf9vgkMDV
	FlpMlyZ+WQDFbUSjmR9ozOrt7uXM/hlx/ZUA9apwqtRXeWLH3ooPxYnzXe8ZvUdd2qYfIKm9NQb3z
	ddPq9YD0qxXfmSEbD01A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHCRL-0007zi-8M; Wed, 25 Mar 2020 20:15:51 +0000
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHCRH-0007zN-CS
 for linux-nvme@lists.infradead.org; Wed, 25 Mar 2020 20:15:48 +0000
Received: by mail-yb1-xb43.google.com with SMTP id p196so1949952ybc.0
 for <linux-nvme@lists.infradead.org>; Wed, 25 Mar 2020 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=draconx-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=U9D+d1lkDOvY3jeOBPuO7Icj5Xdqu64zCQHeR+0ymMw=;
 b=1bI5iX83n8BVyIBOKwYfKEvPXes98TPrR/QW4i5Fn29deq1p7emf99X6Hb/bc3Qqtw
 JHcZXgl0E2NbaEFIa0HYz/WeQUX8mdBQD8h3MFyHzRx4GUD9EpY7+lSRg/N55W4Xr4OQ
 1KVj+8Y5lF3rYCQaqyPCGC1Xg4SEqYMZsoWHO3GKoy3oD39aESDv4CgtDVV+z3ugy8fp
 BQ2IeOhpwk5GuDmYubtAQ3msYhq7UHta6UHET9Yfbno4zs0ssayAlbFHz/a52PfFnDqP
 KsZeYUyS/z7/wIIKHvST+1J+1V7NfcExSEANpwNJfsFm9sJJ/JZJeIukAgLYzMQUR7wh
 eFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=U9D+d1lkDOvY3jeOBPuO7Icj5Xdqu64zCQHeR+0ymMw=;
 b=cxgmHYUcaMMuIbpeDacnVJp5yNNc3sxPwD5LBcLcYximwU5r0iQcjQW6YBf0ArfFWx
 1ehvnsQgJlaSHis9mBtlzIAu2B4Elw/yD1ppD1czqHO8K82zH58mpeuBceUfMlTQmlAT
 Ji2dUShf8XtvLlX0J10So58ayZ7Gpc8a0MsEL83+4Q05IJearHT+g5xqy2FuqMxEcnI3
 tmhBA3RBNIAGLiyXsyTE4H5JEtQd27vXt6EyfU1ngzkhPHqsecejhZN9V3yIC0fq2sXh
 dz9QifMBoExJJJlcJYONfz8FMdTLG14hGRw/54QpmMEvwt5ABsoIO8Peyb7mtvnn5sgK
 MqRw==
X-Gm-Message-State: ANhLgQ2dMsO3deXds3K83CZ7jb4og/NAgsV61Uvx44yPppZDuWjwR7lY
 SLpqxWXu8C72xaYzZW0PvuazZnFiiIwuTcJMg+Dt+A==
X-Google-Smtp-Source: ADFU+vuM02H6ICaiZc32JwHkwBz3Mc9JSjcdyCVArIFiYz43WnMJm2z4Vf/i1pRiVxLU3WLvh9WOdTZSIGyheL3m46c=
X-Received: by 2002:a25:ba0a:: with SMTP id t10mr8734659ybg.393.1585167345773; 
 Wed, 25 Mar 2020 13:15:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:1941:0:0:0:0:0 with HTTP; Wed, 25 Mar 2020 13:15:44
 -0700 (PDT)
X-Originating-IP: [216.191.245.228]
In-Reply-To: <20200325191103.GA6495@infradead.org>
References: <20200325002847.2140-1-nbowler@draconx.ca>
 <20200325191103.GA6495@infradead.org>
From: Nick Bowler <nbowler@draconx.ca>
Date: Wed, 25 Mar 2020 16:15:44 -0400
Message-ID: <CADyTPExA+Ng=QR33ZMA9qffSOEMrMVDsgU3G2nLvA9Zn3DYD+w@mail.gmail.com>
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
To: Christoph Hellwig <hch@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200325_131547_483553_E763D783 
X-CRM114-Status: GOOD (  13.43  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 25/03/2020, Christoph Hellwig <hch@infradead.org> wrote:
> A couple of comments:
>
> No need for the "." the end of the subject line.
>
> I also think you should just talk of the nvme_user_cmd function,
> as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
> is a nvme_user_cmd64 variant that needs the same fix, can you also
> include that?

Fair enough.  I can make the same change there... but I don't know how
to actually test the nvme_user_cmd64 function because I cannot find any
users of the NVME_IOCTL_ADMIN64_CMD or NVME_IOCTL_IO64_CMD ioctls.

>> +	if (in_compat_syscall()) {
>> +		/*
>> +		 * On real 32-bit kernels this implementation ignores the
>> +		 * upper bits of address fields so we must replicate that
>> +		 * behaviour in the compat case.
>
> s/real //g please, there are no fake 32-vit kernels :)

OK.

I shall prepare a v2 patch then with this feedback addressed.

Thanks,
  Nick

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
