Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BA3C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Apr 2024 08:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GwoS6roGJS4Z269frSZO0uwgn9TLAcJHwh4SPFyzbwM=; b=sbaVIOBXhZROsdQE+jTKYjli1Y
	8Fsr+gf15554E09nUfIOCqWh9479w2Ch8jjua4ZIqBN4kW81h3XMFMWRrjJS+XBWEMTL4n5KHW+s3
	LQKczPlETrZmLZpcXR9psxQCpsOUkPhgLHiyI4HVtecXf96GKfe8deSD2VXWAfUihb0yjAHNtK9Xc
	itOifLQiSXnoA/EpHARqR+hudaZGkL5Zjtw6sANWw/ipizoHP4RtgYXxvB40dsyIV2K8abivaDyDF
	dUm4W9D8xqhvV72TdYI+xOguiKaKoWXlqqBi7JTCssD8MesHNwfr7EhpscISqzix1pBWCtOsR05K8
	n16q5D/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1jKc-00000005jjw-1L6Y;
	Tue, 30 Apr 2024 08:59:22 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1jKV-00000005jif-46Xi
	for linux-nvme@lists.infradead.org;
	Tue, 30 Apr 2024 08:59:18 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a58989cd1f8so693510266b.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Apr 2024 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714467553; x=1715072353; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwoS6roGJS4Z269frSZO0uwgn9TLAcJHwh4SPFyzbwM=;
        b=lcsWdd349crieqVLEC6bCgqYyp6FzEo/BcPWVdi6hbenelK1HXhjLhU6vWM08wb9Na
         lPIY5o1hQhbkgJ7ca4BaOU381I6eXpxctva9+q8TTA4M6fFpWZO1SVxDj1Ta2Kv7j9rh
         vlLbyuy4tLGllD1UmS/b7GSuSkULWs0bvj8EOHfC+zA1Qc6/YQscd47czHtD7V8J4/Cy
         VJA0RnowGi6IUBxobb/Otgh2PmGMTMorixFuVv1mDn2lTgKK1PBn+iykuTAmwKjoZadf
         9+l822PjKPZrxt/aDa9IG1U8shUmHuGdqig2JZXsQMwx1vso/Ac0fLMTHssR+nmdztT9
         hXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467553; x=1715072353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwoS6roGJS4Z269frSZO0uwgn9TLAcJHwh4SPFyzbwM=;
        b=ZqqGOkPYSLCFzLMuxj2YE5fEXXVj/krcKDFmm5/hlo8KmvctDisFs8noG4F1ZmV9VD
         b9B8mqHH+hw54stPRikSsIZtJpCebYGnjt1wba2Bv08TzXKsIsBBLyMOfnd3laanbeXo
         td0e+DKFqqCnbThlR3bC+J8q3Ub2jdi3oT98mVsP2opEJR2lhHFbQ03u/zxv2TKL/TMv
         4jAySJ9TId2avl6CPChRiJMD4uzlWR5L6JV3lhRMh518wTOw00uI4XDlywaVKJ+jmsii
         naoYPDoIiSx3IJRAjuViSHxCjx+TaemG5UA6AGbzrlYvqwQ2iEc0llXXKqJbuQFsVAvD
         cb5g==
X-Gm-Message-State: AOJu0YwTqic1IlZWgPIRK0wUHe9P7aDFxMIgV8yAFXgnL2XT5qsboTPg
	sSBNBMRgEgc7+3E2XZcUUsR7xmnfVK/xWbX/yrN0JpefLUL4SFGhrIEXpnIn4wMVivgwcEV7nLO
	uDOMtT7dzu5sZ8Y1NGeH0vNPW7Sk=
X-Google-Smtp-Source: AGHT+IEZohtI/5LTZiqwo7rznZUIE8iyJSNBnS8rQMpXNDtqEGP8p2WDFpXtRV8D0nNGk0vPJwn0jPmb0AfHIyExETQ=
X-Received: by 2002:a17:906:71ce:b0:a57:2cef:89c0 with SMTP id
 i14-20020a17090671ce00b00a572cef89c0mr6701926ejk.67.1714467552611; Tue, 30
 Apr 2024 01:59:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240430021753.385089-1-brookxu.cn@gmail.com> <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
 <CADtkEechcseDatdzoPDrYBapvQ5iTKo3E-tsdiwj2B7euLLwnQ@mail.gmail.com> <c5495a06-1edb-4097-ab77-280955d14a56@nvidia.com>
In-Reply-To: <c5495a06-1edb-4097-ab77-280955d14a56@nvidia.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Tue, 30 Apr 2024 16:59:00 +0800
Message-ID: <CADtkEefA_eLKTDOJo7GcoaYGhWXbyyA6WCTE-Z1aMpA7bpwRvg@mail.gmail.com>
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>, 
	"kbusch@kernel.org" <kbusch@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_015916_042912_67A8F569 
X-CRM114-Status: GOOD (  26.13  )
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

Chaitanya Kulkarni <chaitanyak@nvidia.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=88=
30=E6=97=A5=E5=91=A8=E4=BA=8C 14:59=E5=86=99=E9=81=93=EF=BC=9A
>
> On 4/29/2024 10:10 PM, =E8=AE=B8=E6=98=A5=E5=85=89 wrote:
> > Chaitanya Kulkarni <chaitanyak@nvidia.com> =E4=BA=8E2024=E5=B9=B44=E6=
=9C=8830=E6=97=A5=E5=91=A8=E4=BA=8C 11:47=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On 4/29/2024 7:17 PM, brookxu.cn wrote:
> >>> From: Chunguang Xu <chunguang.xu@shopee.com>
> >>>
> >>> In some scenarios, if too many commands are issued by nvme command in
> >>> the same time by user tasks, this may exhaust all tags of admin_q. If
> >>> a reset (nvme reset or IO timeout) occurs before these commands finis=
h,
> >>> reconnect routine may fail to update nvme regs due to insufficient ta=
gs,
> >>> which will cause kernel hang forever. In order to workaround this iss=
ue,
> >>> maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> >>> tags. This maybe safe for nvmf:
> >>>
> >>> 1. For the disable ctrl path,  we will not issue connect command
> >>> 2. For the enable ctrl / fw activate path, since connect and reg_xx()
> >>>      are called serially.
> >>>
> >>
> >> Given the complexity of the scenario described above, is it possible t=
o
> >> write a script for this scenario that will trigger this and submit to
> >> blktest ? not that this is a blocker to get this patch reviewed, but
> >> believe it is needed in long run, WDYT ?
> >
> > Thanks for you reply, I can easily reproduce it in my VMs by following =
steps:
> > STEP 1. In order to reduce the complexity of reproduction, I reduce
> > NVME_AQ_MQ_TAG_DEPTH from 31 to 8
> >
> > STEP 2. Create a nvme device by NVMe over tcp, such as following comman=
d:
> > nvme connect -t tcp -a 192.168.122.20 -s 4420 -n
> > nqn.2014-08.org.nvmexpress.mytest
> >
> > STEP 3. Buind and run the c++ program issues nvme commands as followed:
> > #include <sys/types.h>
> > #include <signal.h>
> > #include <unistd.h>
> > #include <vector>
> > #include <set>
> > #include <stdlib.h>
> > #include <sys/types.h>
> > #include <sys/wait.h>
> >
> > const int concurrency =3D 64;
> > std::set<pid_t> chlds;
> >
> > int __exit =3D 0;
> > void  sigint_proc(int signo)
> > {
> >          __exit =3D 1;
> > }
> >
> > int main(int argc, char **argv)
> > {
> >          signal(SIGINT, sigint_proc);
> >
> >          for (auto i  =3D 0; i < concurrency; i++) {
> >                  auto pid =3D fork();
> >                  if (!pid) {
> >                          while (true) {
> >                                  system("nvme list -o json 2>&1 > /dev/=
null");
> >                          }
> >                  }
> >
> >                  chlds.insert(pid);
> >          }
> >
> >          while (!__exit) {
> >                  if (chlds.empty())
> >                          break;
> >
> >                  for (auto pid : chlds) {
> >                          int wstatus, ret;
> >                          ret =3D waitpid(pid, &wstatus, WNOWAIT);
> >                          if (ret > 0) {
> >                                  chlds.erase(pid);
> >                                  break;
> >                          }
> >                  }
> >                  usleep(1000);
> >          }
> >
> >          // exit
> >          for (auto pid : chlds)
> >                  kill(pid, SIGKILL);
> >
> >          return 0;
> > }
> >
> > STEP 4. Open a new console, running the followed command:
> > while [ true ]; do nvme reset /dev/nvme0; sleep `echo "$RANDOM%1" | bc`=
; done
> >
> > We will reproduce this issue soon.
> >>
>
> cool, can you please submit a blktest [1] for this ? I'm not sure if we
> have any coverage for this scenario ...
>

My pleasure, after reviewed, if no more doubt, I will try to do it, thanks

> -ck
>
> [1] https://github.com/osandov/blktests
>

