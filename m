Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F84EB64D7
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 00:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZs6dH4xlvJ918fhSCUdP0XfoUPZWo4ujkAmSZIqEjo=; b=Ut1mofIFMelkQ5B37Otxc4F2d1
	r3e+vtplCAhl5K4bg8Y8pyiq53NjuqMLopJCg1PfKkW7Gz1HVIH6UZym/nrGct+vev7NmOS/S8Ko8
	3IbLyFORtE4MqUjKJIyEaBBwpQbX9ywOtMETQVjwULMGIBzjX9T8OdelAbQx0q5Po3AUeEuobbyEB
	fhfq5pIR5Oer64TrOZ21HyrzMa7HHz/SzZXNkKJg9hRsD9JMxYyAJey6cL+MazFNdv1VvSyLYKqbs
	w7PVJvq/8SYmnkXe/6aZqLeDCRUFW7+4TEY5uF7vdBTq+LTCcLcWhpkZwiB+yDwfZ7RRuRQMuQexi
	4dD9jsqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEf9U-00H5Pk-0k;
	Thu, 29 Jun 2023 00:04:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEf9R-00H5P1-2i
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 00:04:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687997084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZs6dH4xlvJ918fhSCUdP0XfoUPZWo4ujkAmSZIqEjo=;
	b=REm8KE7Y14t4YqA+NkgA6Mg9Sv5dHlcmZQLoPkgYF8a4LCwG6UkA0RvsWvHSb94m2gkKBI
	x8p4F0yEbH/lCKKudm2ewzUcmxb3XcoasdzpsLwgRJktG7lqmub1U+Hkf2TWcbGbEoqAVu
	OwuxVagk2mCwZuGpHVyBcVlp0f9q6u0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-OrAbK0niMD2msA2NznXv9A-1; Wed, 28 Jun 2023 20:04:43 -0400
X-MC-Unique: OrAbK0niMD2msA2NznXv9A-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262e9467fbaso58231a91.3
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 17:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687997082; x=1690589082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZs6dH4xlvJ918fhSCUdP0XfoUPZWo4ujkAmSZIqEjo=;
        b=dFyCYvvj+Z3Q4vBBsU89zniFtIy8/LD29jJfr5z3q/Zjot1A0UO8m778A4LpqAbS/p
         FsQ9Cgg8iS1m7aGYKVJQ7/oIAOexr9L/x/FFzorlsk6tfWWgUPBxRlXVWKv5RV+dC2d/
         T5xHtzsEZBNYhoHu6RYMo5S6ZyqSfOE6VGjFFkcxMAQr+DA/jOTWKPnvg/CmqeJSxckF
         92beGB3u8bjFgqW3fggj7SGFTU8Xy49aKGKo0+fp8VeIE3xmWt9DnWwpzZ+zvEhCTdgM
         PTirUrN0HjyU2GjTlnep4+U9G1bnYBIurHNmHeZ2jw7Kmm895Q0mD4tr/g0Dxc708KzP
         j78w==
X-Gm-Message-State: AC+VfDxwmJx0hZ9Yo6IAZLuEREyJmyoSVXHqHu3P4IUO3YG35P7W0OwS
	4mypVdNH5RW4IFc43EpFh7xpJxXdancz4nStzQJ20p45YHnhv/q5tJ87NQFFiykVMnrcMAMAg0c
	KLm08KCx4hsfNKtDveAmaI6k9NmfnuP91auQI8OubOEo=
X-Received: by 2002:a17:90a:2f47:b0:253:8260:f9aa with SMTP id s65-20020a17090a2f4700b002538260f9aamr23080557pjd.6.1687997082419;
        Wed, 28 Jun 2023 17:04:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KXhLUvdRsUvi62VC3VaMrwpwDO1+/Ophi+reiuJaWrVy5ZdnkYveON8wAp0ooDS1ngZtslasdOUdv2bmFDAY=
X-Received: by 2002:a17:90a:2f47:b0:253:8260:f9aa with SMTP id
 s65-20020a17090a2f4700b002538260f9aamr23080545pjd.6.1687997082135; Wed, 28
 Jun 2023 17:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me> <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com> <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com> <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me> <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me> <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
 <0ab5d195-549f-342f-8c92-b7f1a4ca2d26@nvidia.com>
In-Reply-To: <0ab5d195-549f-342f-8c92-b7f1a4ca2d26@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 29 Jun 2023 08:04:28 +0800
Message-ID: <CAHj4cs-_9NtBujvOY=F7EZfTu5SfFX+PUx3YGbGaZaj2Lg5h6g@mail.gmail.com>
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux tree
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_170445_958147_96928E40 
X-CRM114-Status: GOOD (  19.44  )
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

Thank you all for the quick fix, I've verified the patch. :)

On Thu, Jun 29, 2023 at 6:06=E2=80=AFAM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
> On 6/28/2023 1:09 AM, Max Gurtovoy wrote:
> >
> >
> > On 28/06/2023 10:24, Sagi Grimberg wrote:
> >>
> >>>> Yi,
> >>>>
> >>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
> >>>>
> >>>
> >>> No, only one discovery.conf there.
> >>>
> >>> # ls /etc/nvme/
> >>> discovery.conf
> >>
> >> So the hostid is generated every time if it is not passed.
> >> We should probably revert the patch and add it back when
> >> blktests are passing.
> >
> > Seems like the patch is doing exactly what it should do - fix wrong
> > behavior of users that override hostid.
> > Can we fix the tests instead ?
>
> I didn't find anything wrong with the Max's patch and more importantly
> blktests are still passing on my setup where it has required files, but
> Yi doesn't have those file as stated above :-
>
> nvme (nvme-6.5) # ls -l /etc/nvme/
> total 12
> -rw-r--r--. 1 root root 183 Jan 23 23:58 discovery.conf
> -rw-r--r--. 1 root root  37 Mar 16  2022 hostid
> -rw-r--r--. 1 root root  12 Mar 17  2022 hostnqn
> nvme (nvme-6.5) #
>
> Let's not revert Max's patch and fix the blktests.
>
> -ck
>
>


--=20
Best Regards,
  Yi Zhang


