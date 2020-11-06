Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A215C388F2
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 09:02:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130BF208B3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 09:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="K4r36DsG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIGchvBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130BF208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OxAYaywLSvba+QbutP5u58v/eugYOH/kMML4QD6dtYY=; b=K4r36DsG4LwSnTsw1OKC428ap
	3jWR1QimJbXPA87UexlbUtWy+RCalh1GQ7MJZrouKICQ0TlNkWpW0Kr9OlibItrOfHMoNrr2wYpmt
	yip+zLUDFbJNuXiBl5k07HqUCbzwmIY17eu4R5BSg+6FBNQVz3zbdt9fAsIMG6ouqHXqAJi1KCajq
	UwjXQJC5Z7ALfsAFI2UgFMT2qNaNrpD2dil3Bedd4c0tbYHgpOiJt+2Yj22zViKKmwdadBSTR+HV9
	/oI7BMHb8r7yVr19dFhSMYo3vcngAmBHVmeTTT66+JCeI4KeubFDyGpvoRvYshhX71IHMuC7FtlAY
	aJ1XjOvYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaxdg-0004gT-I6; Fri, 06 Nov 2020 09:02:32 +0000
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaxdc-0004ej-7N
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 09:02:28 +0000
Received: by mail-ot1-x343.google.com with SMTP id g19so605656otp.13
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 01:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a+3xUK062fFuKNMB/parpK3A4Uu+fjNTmlMnzleKpBU=;
 b=sIGchvBs4yOl64VdqxLaZH2dFKXiI9iBVsjgg5tc4O0bPuk6yfL9UlxqwEVOa9OqQB
 Qmm88ymzBxY0YuQWug8Dait3jghn7pk8OyN56xcFRT0CapvNub3JCgCSHx2NDpzJcaL8
 mKfI/RlOj00zoMisPYTEotSXBuUfr71R2c6tI1eNSDDMrffj6aji6pnUhWxOofun7PIy
 4ObbL9lEZ917y7rjGqFSzrk/HmJBUTpACf3XAptdTE4uvXZCuuZ95UMTlqImNxNSdnBS
 uj3NhA/+459KtAqVN2B3AVh38Ez2G/Sy5AGZSU61k9hzAw5WbqhkreeYQ8S0PyB/zIY7
 yUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a+3xUK062fFuKNMB/parpK3A4Uu+fjNTmlMnzleKpBU=;
 b=rWVabGS2SLFeoqaPC8JPL6hkGytKZjndncC7aFgvLgaBz5OgyQDBjcGJRVsRkWYF8R
 FG+SKlfkGAS3a/RUJwbXAt9QMQlW7/dcyxh0WTJO7Vr8Cf9u3JDh+yG4E+3Nyv8DsUG6
 iTSm6Y0SZI0jrFZGOrBhwsPx3t5Wq3oqzp4qhqhP+L2Vu/dlcffi7A2AzCC480sNX4TO
 zIZ7NzPxWJep3RMUy2qjlBIpiCSjp6/b53Ees23lmJayBuU3yo7fm7JC2jn2rQnWPYqc
 zWFaKADMfSOFpd9Q+rIlhAGrqjfLHivHu1IZXWXhNZHCzEL7zTkSXcQGKj6GnFOhcR8i
 46WQ==
X-Gm-Message-State: AOAM533Rr4JsDGvYTJAiewKzCTg7q2uPYCGd9LxrxVxBzSQ4MAyZEZWq
 n3XyeKj7OM8ydynhUdmhQ/Eazrthhue+iQGIhE4=
X-Google-Smtp-Source: ABdhPJzC0nIlULMmh2N9PeP53hbSPtdJs7VhXdE7LfhgmjaTLzSjZwrb454phDoSo0nsQICOd+XQGT3wJ8wMNmci/Gk=
X-Received: by 2002:a05:6830:2415:: with SMTP id
 j21mr453485ots.221.1604653346049; 
 Fri, 06 Nov 2020 01:02:26 -0800 (PST)
MIME-Version: 1.0
References: <20201105142847.3500-1-minwoo.im.dev@gmail.com>
 <20201105161307.GA2210800@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20201105161307.GA2210800@dhcp-10-100-145-180.wdc.com>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Fri, 6 Nov 2020 18:02:15 +0900
Message-ID: <CAA7jzteLUojxVKQ87+=3EsKZ=FyiBpOw7bxCvDprw3oU-ob6ug@mail.gmail.com>
Subject: Re: [PATCH] nvme: free sq/cq dbbuf pointers when dbbuf set fails
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_040228_279716_5EECDB1E 
X-CRM114-Status: GOOD (  14.38  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 6, 2020 at 1:13 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Nov 05, 2020 at 11:28:47PM +0900, Minwoo Im wrote:
> > If Doorbell Buffer Config command fails even 'dev->dbbuf_dbs != NULL'
> > which means OACS indicates that NVME_CTRL_OACS_DBBUF_SUPP is set,
> > nvme_dbbuf_update_and_check_event() will check event even it's not been
> > successfully set.
> >
> > This patch fixes mismatch among dbbuf for sq/cqs in case that dbbuf
> > command fails.
>
> This fixes if host dbbuf was successfully configured at one point, but
> fails on a subsequent reset, correct? Otherwise, I don't see how the
> queue's dbbuf values would have been set to non-NULL.

Yes. reset_work() checks OACS with DBBUF_SUPP and if it's reported as
supported, then it will alloc dev->dbbuf_dbs.  After that, However, if
nvme_dbbuf_set() fails with sc != 0 then it should free for each queue's
dbbuf pointer to prevent being checked for events when updating the doorbell.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
