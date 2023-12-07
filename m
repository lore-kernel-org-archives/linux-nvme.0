Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D0C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 01:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+rXWANny0uHO6nzvjRs3/MCtnMqv7CRSnXsSEhy7sY=; b=4qihnKeYeiSudtep9BdzYvEB5s
	67swMuBZI+D+BYSYb/Yc6ZSFSSNPFFaMeUfsnjoKe4CDZFGPCq8G6ct4QQh+CzuXrUt7XtiodEDLq
	4ll4oYMtQruBDG//DNvqnY5wdsqHuHxzF1eg6zLgW25tYQoHbWtFaoTRW4LzuFpXuXz/TtZaeD2Bg
	tRTw2+haX2N7e8S79N/q7W4mJE2oz95gHUtwKNV2Uj4N2AbojIimyVnmMLFCnmhXsKM2iCUN5pAOM
	eznVxZga+M5PMW4QRNUnJS1JyZsFgHm4m5t9qfNHcMfBZBGPp4kFjsjhZO3D/nM5OibdVmFvG9u61
	9L8o/GGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB2m0-00BbZ2-32;
	Thu, 07 Dec 2023 01:01:52 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB2ly-00BbYg-1y
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 01:01:51 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50be58a751cso115492e87.2
        for <linux-nvme@lists.infradead.org>; Wed, 06 Dec 2023 17:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701910908; x=1702515708; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+rXWANny0uHO6nzvjRs3/MCtnMqv7CRSnXsSEhy7sY=;
        b=bKjypXXuBvBFRmy8Owcq1IA4icX64vwcLr89T88wosdgf/PehDTi+QKUEKHnSWhzEr
         KYWNjrAJHnkIJgYVpnHgwgzdOpkTTKqMLjdWDYRi++YtD8iChVO41qBW3VHT4ZSip5oz
         uc3sGdSsZfqg1qFAHrgE89gwpsg8I1oI8V8IMoSQx3aDB/61Q3WDHmzo33c25AG8a9G0
         VPMhEO7nFV5BDsN3FgnfAm3HpfP0M7B+2pr2tOo5BAk8dp+do/9FGuYB5YSFVk+/HTHH
         uubM50BpRq10hONAwPciNvogw7XeldQjVhKWh9J5z7sCX4rqVqvvltB2IqJUVMM1tdSg
         cGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701910908; x=1702515708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+rXWANny0uHO6nzvjRs3/MCtnMqv7CRSnXsSEhy7sY=;
        b=IzHafdC0r/pqXN0Fa8KX3nJSd4XqEWIxelzShhuMQEW5gywbTD3ohproBqljUGddAB
         4Xkb8SoMRRedInHhDMDFC/VACNqBAuxyI/5Vxp4Y4Xv6ILZTF8nehVVRj6Q11iWDL29v
         wt800K29LCzBugpKuuH9UFeZerLRryofciyAoRf1j0gM3Hvy07gNOt1RNbwZ6ep7Dcko
         x8IKXf/UUXQBRYroJCSZPmg/KwBksEUNrOhcsPpUNX07madLN3MYdQrN4BtVFB9KfL5S
         ef/28pgj/V6MWlGpWsoTyMm8tarPXv37sOxe3my37SsXao5EwN4dTFHVmYYHln1ZuNqU
         viFw==
X-Gm-Message-State: AOJu0Yw+O86S0CbnlSB3OfNxjVM/6ReTsqF8edHIq7r7O5L+cVXwNQEl
	e09SC7YdLRxzY2RpWxn7eg/PH3rOaXFHLG1VFDY=
X-Google-Smtp-Source: AGHT+IHzckmNKtnZ6eOoTsOs5qzRVqSfymWQafrRaRBqut1JkaNqKTmN853YKpOXutnsE06Us3WYqsyaEY388hz5RGY=
X-Received: by 2002:ac2:44d6:0:b0:50b:e750:dd99 with SMTP id
 d22-20020ac244d6000000b0050be750dd99mr1007855lfm.38.1701910907996; Wed, 06
 Dec 2023 17:01:47 -0800 (PST)
MIME-Version: 1.0
References: <20231120083559.285174-1-ming.lei@redhat.com> <ZXEUyH/38KeATuF4@yury-ThinkPad>
 <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
In-Reply-To: <20231206165453.613dbe57555f41ab4b9b0acc@linux-foundation.org>
From: Yury Norov <yury.norov@gmail.com>
Date: Wed, 6 Dec 2023 17:01:36 -0800
Message-ID: <CAAH8bW-F6-uRHQ=c-C2pez365DbdRWn3izB9EmfBzvS+UHG3-A@mail.gmail.com>
Subject: Re: [PATCH V4 resend] lib/group_cpus.c: avoid to acquire cpu hotplug
 lock in group_cpus_evenly
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	Yi Zhang <yi.zhang@redhat.com>, Guangwu Zhang <guazhang@redhat.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_170150_691094_8AB418DB 
X-CRM114-Status: GOOD (  13.67  )
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

On Wed, Dec 6, 2023 at 4:54=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 6 Dec 2023 16:41:44 -0800 Yury Norov <yury.norov@gmail.com> wrote=
:
>
> > Although, it's not related to this patch directly. So, if you fix
> > zalloc_cpumask_var(), the patch looks good to me.
> >
> > Reviewed-by: Yury Norov <yury.norov@gmail.com>
>
> Thanks.
>
> I just moved this into mm.git's non-rebasing mm-hotfixes-stable branch,
> so I'd prefer not to have to redo it at this stage.
>
> Let's do these things (with which I agree) as a followup patch, please.

Sure, I can do that, and append to my series.

