Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893FBC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jul 2022 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:References:In-Reply-To:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8Qki0HVufDaKzMLo0NKMo8j+UvpS8c1/KtUoIeE8vk=; b=2YYF8d3IIneCNq134Ex8fYWcFd
	mGzNlJiq6KQkFWwtPKE23VcgR58ETbhXYNaPqLsLAo5ztJNx+5IcXM8ehvXhwThHrIhAWiQ0X4ogX
	ZfrxUX+vbtTQhO5scT7/t1/aLbaiofdmSU7V7vEXbvBYZixj6vsEomL4O4YMvaJwlpHzZsOf/em07
	Em3c+mlsYCTvE0F4W+clU/KgLXWQqVKbEQZ0CE36jcRv1E9bhHA5yH1ZokGARG3jbbvK3Q8mp87hW
	QsT4LcgzAEPZtw+JxDvhxuQOi5uGYsudKrfjxNd1sQAHeCXP9Ky1wsZiBHsIOkWPHErKyU9Uo4DUi
	DAmQiDpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE99I-005WTy-Jg; Wed, 20 Jul 2022 12:49:56 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE99F-005WP2-KW
	for linux-nvme@lists.infradead.org; Wed, 20 Jul 2022 12:49:55 +0000
Received: by mail-pf1-x435.google.com with SMTP id c3so15495993pfb.13
        for <linux-nvme@lists.infradead.org>; Wed, 20 Jul 2022 05:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+8Qki0HVufDaKzMLo0NKMo8j+UvpS8c1/KtUoIeE8vk=;
        b=7zy1gUMe3KGqvcPlYRoA7bdFW5xfhxkMC4zdcLTxML1mAFglVSHW24gB1OtcGQGOP4
         CIbeZ9TZKev2+ELSWsO1fIT94WtnQqPTD6p+DZsGpKJcpBl4OKGMUGmXlqiucKBu2b3h
         hVsdW+JtVdhWyH44l55jPHn5KlrutboTUMHrrKCwnmAz6O4lPnJuNwGDq+CSXy52srNA
         VQFH/2LNVKjYVivrdyDKrlw+LTLuB1ZCcMeI5nWJckaAexXgMGxuIEQ8iEihKFhF+W1B
         +DhMof2yGmfJNA6fSd0rwk5eojhDqjBCSgVZMWq6/ZfUw6f7ZxLgayj5x/yRdShn9HwL
         BOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+8Qki0HVufDaKzMLo0NKMo8j+UvpS8c1/KtUoIeE8vk=;
        b=0KpB1qQspUT8B8XLqcXziW1S0CxtZ4ceelH2qDdiwyvLbdUQYiNQVoGQyT0ao7pjS2
         p0VHlPDN8Uu5rnUmEWWmsjfRVBP7uRhMB94pgdgvtnNZ947nGFIcl2LQjUQRdmKI0AY7
         13Qi0GzPR4B3S8lC9NXMfDvSpyYApAcBPU1w71JxT+iEbdTqpOHol+TsrnzJBjjEAFz1
         QFcgrsCGcpQWBdE8INap2JZcqGAwCOxwFpW5FBHCWAZo4bu3ds1NMuCymi6YJ11i4sWY
         Bfh7UsF3XSzj9kViYO/WZ8YypgWm2/9B3b0gGpG7SnnX5ExCpOq4IznT1H5EHVa2pab1
         NqNQ==
X-Gm-Message-State: AJIora+6Nscas5pymHeFMtLPtvRmFBGMbHDCzmQAd0snB0CmIm9ZfhEO
	8619JS+SMXBFux7WmWtzQbaeb+D03tjQbQs8DWI1EQ==
X-Google-Smtp-Source: AGRyM1sJ0IRtAfVjzOEuE80nepn5SCDyj8LDLMHR3JuatXrCaXXV8Al7iww6kh4xv9Bn0EgO/UxrWdKUPkhG5yR1nmQ=
X-Received: by 2002:a05:6a00:b55:b0:52a:db7b:2880 with SMTP id
 p21-20020a056a000b5500b0052adb7b2880mr38284317pfo.22.1658321390471; Wed, 20
 Jul 2022 05:49:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:d06f:0:b0:535:c52f:e1cf with HTTP; Wed, 20 Jul 2022
 05:49:49 -0700 (PDT)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <20220720042726.GA5574@lst.de>
References: <20220720015538.15838-1-nbowler@draconx.ca> <20220720042726.GA5574@lst.de>
From: Nick Bowler <nbowler@draconx.ca>
Date: Wed, 20 Jul 2022 08:49:49 -0400
Message-ID: <CADyTPEyp4WXYW63gBCST+4J3nTYdV8XkyF5YFwZrMz0TcG=Qng@mail.gmail.com>
Subject: Re: [PATCH] nvme: Define compat_ioctl again to unbreak 32-bit userspace.
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220720_054953_879651_878319A4 
X-CRM114-Status: GOOD (  15.20  )
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

On 2022-07-20, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jul 19, 2022 at 09:55:38PM -0400, Nick Bowler wrote:
>> Commit 89b3d6e60550 ("nvme: simplify the compat ioctl handling") removed
>> the initialization of compat_ioctl from the nvme block_device_operations
>> structures.
>>
>> Presumably the expectation was that 32-bit ioctls would be directed
>> through the regular handler but this is not the case: failing to assign
>> .compat_ioctl actually means that the compat case is disabled entirely,
>> and any attempt to submit nvme ioctls from 32-bit userspace fails
>> outright with -ENOTTY.
>
> I don't think wiring up the native version is the right thing to do,
> this needs to be blkdev_compat_ptr_ioctl, just like we use
> compat_ptr_ioctl for the character device nodes.

OK, I will try that.

Thanks,
  Nick

