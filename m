Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B16EC27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K3bObn2HYdzZsPQsK/+7bsdRUNbYSCHbt5PS/gQ/0a4=; b=mPoJQtab6Suc4AgC18xiwbbiv8
	FzeknIV2/mEk7jDaku3TBV5vLOJ1TGHs0NzewjO+N07iPgQzWP8P1OpsekAp5BH5SnCMv4Z7A/CZK
	vXj5eDKtNfZJD/pA/9Vinyj/14z7U3xPPOIQ+f7zuibhSKlyzuT5OS2qxBAM4aC5t63aMoZHjodBl
	9j0ZZU8IZbwf71hOfrS09kMTnSCkYFWKBhhe5C7dJuUvY0YF8H05xGa3t7hkY3io2kpQ1hp+86sRq
	bqE8dbWxIkcrxNOwFUc2Z+xzXwNmJJNw2vVQ9NtMYZyYNgkt1fa2MoipfYBT2pXaj8kvlerQsDY51
	BmR98nsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD8yX-0000000BO7U-2jMM;
	Fri, 31 May 2024 20:35:45 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD8yT-0000000BO72-3Wyz
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 20:35:43 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso692666e87.0
        for <linux-nvme@lists.infradead.org>; Fri, 31 May 2024 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717187739; x=1717792539; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3bObn2HYdzZsPQsK/+7bsdRUNbYSCHbt5PS/gQ/0a4=;
        b=XLdIaQ1G6rDkqkkOgDX7z5i4fC9I0KY+hdLrwdNt1kfYMWQUBuz+k+SgxdE66Ypf5w
         VoYzFmdBgbVeScZEAPnSXF7dOJ6U4Nb6/7EAAIgkaMSKTeWl0ofDz8pcYFkGe2um9YQg
         6hLcwK6GnXyp0bmn9NxtmYmVZxcIn+iSZUqrEXqMtSnQl3YOH6L/b//bKctau3Qq2H/N
         U6id4AZIvno1PpLiEf7KIf0vA/bje9HeYkAcruIp+qDNphjpLoU0YeJHTilt7kIWQ1OZ
         4dUTKMakwALtr2A0OO3UUlMcvpci9qYsS6D7zyItWr59xWQ29PXFVM7nyoNwJkg6BTA/
         k82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717187739; x=1717792539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3bObn2HYdzZsPQsK/+7bsdRUNbYSCHbt5PS/gQ/0a4=;
        b=b0wmx7IU50bJ+3SgdNi3ZTk0jqycDSTj80gwfmNi7IIOKZpDgfQacsZ9Mls0wtOquG
         IOLWn1knw58BWZ8swge/6hqDsXLU0wAuw/32f6LY/3ci7XKYMl5I1k9H/Wa768pQVSaK
         mtPBKOQr3/G0bUIiJFqZoey4FSpRt5rBnNDZE8wt5yR+6ff9Gq8yxKpySCd84LM690Mx
         wfckad+ilSfPbtb1tlKq+YRAbqcLbLef24ANeCZLI1wVSCfPghJp+ELfA5fPGNMHKpNa
         kR9d5hmKF/RXEWP+iIeivQuF0nPPcfmlVIhorEsk8IyR7AyhTBctn1zPtAKHDDin+Ufv
         QxSA==
X-Forwarded-Encrypted: i=1; AJvYcCUTEg4cZlpmfEoyXEzWTxbTd2s0TRjYjW8Ei9e+l8jJ2FDv0YjXy8l1HyVHTUzzvzTENvKn8t2pzwRBQ3Pgse3Ds/KGygH7gcttqO7BowE=
X-Gm-Message-State: AOJu0YziKK9AUGHKNyrk2Zi0fF/Wd6LAFThY0hwbdDHX7nkPht0oF4d6
	p1xdEwe3alT12PoYk8Hu6CoVH6t+gtWY/qwloNfoWdCl2iZC5HhsJ70FHYUIKh89RxKiqdqE4pT
	Wn5MDh5v5YN6UJaxjU5SbOiuxz/U=
X-Google-Smtp-Source: AGHT+IEPEZTe85ma2n710NtfCYlQmJCM/+/sKx/9xMzB3Wn5S/worLuBz06Zmk2YjdZw5BwQykOfkrxtin/JB3RMFkI=
X-Received: by 2002:a05:6512:3d10:b0:52b:851e:256 with SMTP id
 2adb3069b0e04-52b8956960bmr2274835e87.2.1717187739001; Fri, 31 May 2024
 13:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <wnucs5oboi4flje5yvtea7puvn6zzztcnlrfz3lpzlwgblrxgw@7wvqdzioejgl>
 <6cd21274-50b3-44c5-af48-179cbd08b1ba@linux.dev> <b29f3a7a-3d58-44e1-b4ab-dbb4420c04a9@acm.org>
 <CAD=hENdBGcBSzcaniH+En6gecpay7S-fm1foEg5vmuXiVYxhpQ@mail.gmail.com> <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
In-Reply-To: <0a82785a-a417-4f53-8f3a-2a9ad3ab3bf7@acm.org>
From: Zhu Yanjun <zyjzyj2000@gmail.com>
Date: Fri, 31 May 2024 22:35:28 +0200
Message-ID: <CAD=hENdgS40CmZs2o5M_O71k07Q7txg9-2XnaHP97_+eC9xT3w@mail.gmail.com>
Subject: Re: blktests failures with v6.10-rc1 kernel
To: Bart Van Assche <bvanassche@acm.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "nbd@other.debian.org" <nbd@other.debian.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_133541_912262_CC4EB54A 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 31, 2024 at 10:08=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 5/31/24 13:06, Zhu Yanjun wrote:
> > On Fri, May 31, 2024 at 10:01=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
> >>
> >> On 5/31/24 07:35, Zhu Yanjun wrote:
> >>> IIRC, the problem with srp/002, 011 also occurs with siw driver, do y=
ou make
> >>> tests with siw driver to verify whether the problem with srp/002, 011=
 is also > fixed or not?
> >>
> >> I have not yet seen any failures of any of the SRP tests when using th=
e siw driver.
> >> What am I missing?
>  >
>  > (left out a bunch of forwarded emails)
>
> Forwarding emails is not useful, especially if these emails do not answer=
 the question
> that I asked.

Bob had made tests with siw. From his mail, it seems that the similar
problem also occurs with SIW.

It is up to you^_^

Zhu Yanjun

>
> Thanks,
>
> Bart.

