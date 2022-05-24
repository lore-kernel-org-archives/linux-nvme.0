Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74342C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 19:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvT09gprI5TPBIn4iJInqmfbvAnB8nw4DQPY9YaCr7M=; b=u/eCjIRGp429G4fjxPe/OfSUfC
	+XYpMMxn8oxQ/f6Z6yU9zAMTKfZdEy7DvAaoCVUbGYIVsEbtk3m9j2BUoCooLDUs71cKIR8BG0JZ5
	ltCaMnIeqXu6r/zdO/5Jw7zSITI0W/wOo13jwEurseUmIXpbwG/yFKQbfs+6sI9CgmWto4O4eQPMk
	Z8QWcnWRNCZj29lX3LzzxM0ZBEJje+qIf1J3zKjwB6MHI7+QfquziqUGqQJTeCmAAd2ybIo+zS31h
	C1F8AWbtHfAX0A/V/y4Vb+4SEfWbs5ET9Ll42i5OgCZuUT+dSCCiye/PzhA9LV/gOd+uLenZKMuXN
	yMkHfjxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntaMZ-0092j6-Si; Tue, 24 May 2022 19:38:39 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntaMX-0092ih-Aq
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 19:38:38 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id s14so5321723ybc.10
 for <linux-nvme@lists.infradead.org>; Tue, 24 May 2022 12:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockbridge.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OvT09gprI5TPBIn4iJInqmfbvAnB8nw4DQPY9YaCr7M=;
 b=g5e24XjicFfG60cHt+5k4KCGdh1e+3RB1UQO7eNCUKQbF5Nqa46ugOI5k/KfigBMM8
 u046c5YPVHty1vKlTAlxzy2UXnMLV5Nt68KpeIoFayHN1OCEDlmdnznSI097zZ7JIfzv
 mitbAj/8fPKKBl+9pXghbzBGE984cbD7ZaBWi6xF74+KqQZvqD+y6KD+rHRBLyxlTWAM
 LxYxyqpmfFNUZbCk01iQVG5NIB9LVe0oxR4q7l+ZbVOwXvfdTdFm/ramD7sr+2PcB9wE
 SKuAJYe3EBAz9SfsAEKkpELYDmWDu1RpXf7in3ekuVOy8MnmQZbx5gI8ohZ38D7yRZ4s
 EMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OvT09gprI5TPBIn4iJInqmfbvAnB8nw4DQPY9YaCr7M=;
 b=ZwsmI1ILenmTcJaYbdtqy4tXlFvEZnuSjH0EObOCzPeMHMF3Kv/mABrkk7HXGYhC/A
 6IvBYQzJ0qFLiM8bR28GQ+SkPYDs9xcLpBz0wbM1gGYtCbES4NlCKFy4IH68hkf+VDfz
 YQqsASe4e059RRIZ+Fih+5Xw3WhUXmiLQ2oLlXurECMkzobX7h0VsgKQGSVXKVufd2GQ
 mmw6PwPOyj+CMNyKyVwX6ZbPnrsJZJnWt8S3NM+Pun7UwQc8vv3Hx78Yc9CEYsbOy5JB
 UTMahHQsjzRp9ZF6J0uTM+sX3orjpF7BvH0Gf12Y4P8LaiAt9VNanoFwhpgERm58P/dc
 KMLw==
X-Gm-Message-State: AOAM531GzYWVvGLrBcTj1dlM5rpE3usfuKZ4knvjvzO/FkQ2U5oKgVmo
 v8RFWlWVzsB7IdQASC5+rje59FoymvB6tTblSb439A==
X-Google-Smtp-Source: ABdhPJzWdYwn0GghYaftTVUhnIM5m3d0SWSTlb/+H59flHTgAcIkKmiwl7cTFn5Re8rLQDNbDUINx31FdVsGl7uFmWA=
X-Received: by 2002:a25:ca44:0:b0:64f:62fd:6182 with SMTP id
 a65-20020a25ca44000000b0064f62fd6182mr20003375ybg.97.1653421112528; Tue, 24
 May 2022 12:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAHex0cqo3ChdXgaXRAeqZaVWSZBDaedCd9+M7Krdw=St6q6cyw@mail.gmail.com>
 <3989a511-c01d-f108-f8d2-0b6cf83aebdc@grimberg.me>
 <CAHex0coiL6GoBnpiigDmc_K1KKxP7APNpAS0hFFFdOZgAb7Org@mail.gmail.com>
 <Yo0C5H5jF5WLNVJ1@kbusch-mbp.dhcp.thefacebook.com>
 <CAHex0crZ85BFRwoENCUgD=UVK=E-Xm2Zoypmgq8FCm6hYe8S5A@mail.gmail.com>
 <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yo0xE5g3bowmF3H0@kbusch-mbp.dhcp.thefacebook.com>
From: Jonathan Nicklin <jnicklin@blockbridge.com>
Date: Tue, 24 May 2022 15:37:56 -0400
Message-ID: <CAHex0cpUNdb3mu+9pHG2oDfBmgmmCMQAo13axqO=jL5fwr_QJA@mail.gmail.com>
Subject: Re: nvme: split bios issued in reverse order
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_123837_424410_83EA1DB5 
X-CRM114-Status: GOOD (  14.54  )
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

On Tue, May 24, 2022 at 3:25 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Tue, May 24, 2022 at 12:12:29PM -0400, Jonathan Nicklin wrote:
> >
> > The command lines you have are for read operations. The behavior seems
> > only to appear with writes.
>
> Huh, I'll be darn...
>
> I think it's because the writes are plugged and the reads are not. The plug
> appends requests to the head of the plug list, and unplugging will dispatch the
> requests in the reverse order.

Thanks for confirming! That's about where I got to. Do you have any
ideas on what might explain the difference in behavior between
fio/pvsync and fio/libaio? And, why does this not seem to occur when
only one nvme queue is present? Perhaps the in-order cases are an
indication of not being plugged?

