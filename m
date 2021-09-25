Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6597C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 18:47:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55701603E7
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 18:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55701603E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L4vpLQIbjSiF4Ey3ZCTwz+BAezqGUav4hvGGnaSYsnU=; b=g4hphPko2uuun8
	kRfOTs+EeqfOHLh3T4GjF9WE40UWAklxLqO7AK+GbXKbQVIJRPjJ1Qwdm2Mq2lVhEj8y1WrlOcvMb
	Z6dUHUo9XEgUk72z+ZkvHrivWs1TzInMevpi6k8/kzmB3y0Zx8D+Qdi0YquVhq7hTgdYxdp/KAikR
	UgVNMm2V4HXPm30mR+NIlClXNYEPUmBcJXwJQ7Lp2vSQH02flOwujBfQ6oni1rfMXCMLUbr84sQeT
	nAQrISOZij9S3jbxNg6Jq8IH1X2EAD4L0QuD4ZMAtorMv2kAGxVVwB4e/PT5zwlWZjqw/Dm6iaDlx
	JP/7zn3T0XoWqzbgK1Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUChz-00H3uq-BM; Sat, 25 Sep 2021 18:47:35 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUChw-00H3uW-A2
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 18:47:34 +0000
Received: by mail-lf1-x132.google.com with SMTP id i25so56146465lfg.6
 for <linux-nvme@lists.infradead.org>; Sat, 25 Sep 2021 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wgoRC94vJTmojEIb0BaRJLpkMpsX8zbbXi4qGB6Db6c=;
 b=eqDFmco1g9n0DNfQq4ygRAzUbZ2f059wEGshhTn3gE8J4vno32mQ/LiIN+tQFbQU1R
 VjNLj6p+qNn51JUF/EclA4sakOUD6akRDJSy8oRUDnjhkSF7CyH7O90g0sllAY+FxcJo
 XeU+EjW+KH1CF9RqP1xUCSEmLbTgd7T2/rBsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wgoRC94vJTmojEIb0BaRJLpkMpsX8zbbXi4qGB6Db6c=;
 b=CX4iR2+ku4+QIDRZ5kgBeUefhc6ULj14MOCkro9VIeVnn0AzoD2yw08LXRlD0wUq+Z
 7h+JYxgOEfZCayipLSIQaTh7OrVU5Zn89pIDROmkNxIcvw3yiKGf3Obk3Qm4BK6eYkt8
 KVGPwQnjGuSJc2ZOcYSHGc7nhJCz0WOgsxs+6S+kgmxuThmUMTQRIDSMmx0++VTE0fdx
 z/QZngg/Gy/0B6WTtTsAz5Dcdc0InkC3hiy49205CtzA11k1M2Vz3Ur5mhFewL7GbfnJ
 il7+wV8dXeRrmR8NxBvEycgrx6intwTMmXrznyv4YH4hdQxLessoTXw5B96bGHMBqucr
 vOjA==
X-Gm-Message-State: AOAM532tZroNxm/W3Av/VYAb4bfaKI+jJFEtVwDC+oGGr+cO9TmHNQNu
 9FwjJi/jF/flJXyAkSnEhvu+y+TpCuxMdxtz
X-Google-Smtp-Source: ABdhPJwZh8DSgNqubzJi26byqvDfvdRrne1y7ENwTsdw/2bbHchHfw8VpivlXdCNNB8lyPdxiaaVtA==
X-Received: by 2002:a05:6512:463:: with SMTP id
 x3mr15517970lfd.103.1632595647460; 
 Sat, 25 Sep 2021 11:47:27 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id s27sm1198399lfc.60.2021.09.25.11.47.24
 for <linux-nvme@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Sep 2021 11:47:25 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id z24so56435763lfu.13
 for <linux-nvme@lists.infradead.org>; Sat, 25 Sep 2021 11:47:24 -0700 (PDT)
X-Received: by 2002:a05:6512:984:: with SMTP id
 w4mr14706163lft.141.1632595644582; 
 Sat, 25 Sep 2021 11:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Sep 2021 11:47:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
Message-ID: <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
To: Aditya Garg <gargaditya08@live.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "james.smart@broadcom.com" <james.smart@broadcom.com>, 
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_114732_400822_6D3390C6 
X-CRM114-Status: GOOD (  14.68  )
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

On Fri, Sep 24, 2021 at 9:02 PM Aditya Garg <gargaditya08@live.com> wrote:
>
> From: Aditya Garg <gargaditya08@live.com>
> Date: Fri, 24 Sep 2021 15:36:45 +0530
> Subject: [PATCH] Revert nvme to 5.14.5 to fix incompatibility arised in Apple SSDs.
> Fixes: e7006de6c238 (nvme: code command_id with a genctr for use-after-free validation)

I think we need to hear more about the problem than just revert a
commit like this randomly. That commit has already been picked up for
-stable,

What are the exact symptoms, and which Apple SSD is this?

I do find this:

  https://lore.kernel.org/all/cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com/

which instead of a revert has an actual patch. Can you try that one?

Keith Busch replied to that one, saying that the Apple SSD might not
be spec compliant, but hey, what else is new? If we start demanding
that hardware comply with specs, we'd have to scrap the whole notion
of working in the real world. Plus it would be very hypocritical of
us, since we ignore all specs when we deem them too limiting (whether
they be language specs, POSIX OS specs, or whatever).

           Linus

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
