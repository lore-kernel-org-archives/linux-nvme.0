Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CE8C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DV8VykTlfYEay4JYWZz+3S/orVQV57jVe8+6o6hgukI=; b=TUSEj1SYypWhky52y0wK62dTmt
	1C81CM1lsWOT38crE+CcksoP+t8USRMObFMOUFa83mp8+86wtxcIHBqpKhw7XNGlXyYN/5Ye4o2c2
	KQEI9GFTSBJJhp9cW0/nLGRhI0vFlU8KZNveWLrrB3IQQiXEQKwseH6jDJ/22IvylZENDBo3Iw/Hf
	5B/GmXvm2IBlVTBeZvxiUFXT2LljTVmYWZocHPRA+zBwH4ryYEI11aYr79SuAPQ4fW8cXRXNQPI/u
	dByQrTjNXcQqlIBL4mjBHCREqryDXO2ZFXZqF/mMgqpWUEu2oQIWh1dCNgjDxhHpO9505ild5dKWv
	6uWs26nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB3N-0000000469G-2C0q;
	Thu, 07 Mar 2024 10:32:45 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riB3K-0000000468c-3NCe
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:32:44 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso711824a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709807560; x=1710412360; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV8VykTlfYEay4JYWZz+3S/orVQV57jVe8+6o6hgukI=;
        b=Eaptpigmnf/cn2udtBmkX/+FAuPzhSTJtBLofo8lt58FChK97bmaEWIggLrsjM7BTf
         XUwd4vELzMfql/S9Q11FceiuiqXoyt+7+E18JHsWlYxucEDk7ntgeI0zizGpwCTZDxb7
         OHzbbpoNeGBx6s0eZKr91TdTDefwrH2Wswvr64eapntazQ56nQ6xn03MDjptn/8uEO/S
         TlxDgCj9Q3f92dwV8MbJl2FOrcuRrNSLxQMrWkt0XJK2gt67wsrjvRou1SDvjTdB2VH/
         qgFnBTBHTAGEXTrmEgSn9UHqUORAcpyN8m9Lpkc+mjmWZxRQY1ecXEtHqtaRwWFUQen6
         GzSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709807560; x=1710412360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV8VykTlfYEay4JYWZz+3S/orVQV57jVe8+6o6hgukI=;
        b=GoJahVuMuNxr16XUCVFnbXqiLYC//pNSF7py9PK529pG+3qs62ZhGixRYQW0G3nYba
         SjNPzHExWU/9EWsePi81y/cDIoUt2UzGauRHb4PyC6gYREg9Cq73gw3ZqPb3kzfHXNDV
         q+l2vn10kCw+o8kv6wbUK7/35nVXZCNQ6Tsxj+WHBxpwMLBHqRAyjuwcSnQgB9P5Xb+E
         6bMwGJbYYN53FLb7MfKqDdZDuEqNkxhp4cJidQcdplsUXN/jZQ0O87f5XqaijN8wwAyJ
         9JYCqfrjZjdjY1K/3BYrO95ccXU2nzAERYX7MfvhE0ILrDdho6EA3BDE8T/9XrS4jsqm
         KMXg==
X-Forwarded-Encrypted: i=1; AJvYcCV/7Dg9P4o858kOfpKIWjtyxKAZUySjlFlLBuYxSdXauhZnnKBW1/0ga2SgaK+i6T8GNHedO8OXXbJwuFHf8HXgruGgIAFewNwgsPW8tjA=
X-Gm-Message-State: AOJu0Yxgj4sPHUzYEpFxPRGJdJ/EJh2hELeZftHORUxg0PTGOX1TwqM1
	gRMboaeTK8sCjEGBCTJKBLJdcdDW8eo5pfhfP/HKZn32XprXBM244NMSCUq6wnp7Ne4L/Rngh+Q
	yh5PiKSXX/OUz1iNrZ8UVE+mJKMk=
X-Google-Smtp-Source: AGHT+IEKtFy41Zi9l86FeDZm6p26SRwK8CTEeZ2dXozva1J6FKXwmOCFBMdGgGHCPc3OTMp6o5ORJETxtXVL13ssLTk=
X-Received: by 2002:a17:906:1693:b0:a45:a6e1:30d3 with SMTP id
 s19-20020a170906169300b00a45a6e130d3mr5335228ejd.60.1709807560112; Thu, 07
 Mar 2024 02:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20240228091417.40110-1-brookxu.cn@gmail.com> <6eae3879-f9d2-4fe3-96b1-c9e2aa939264@grimberg.me>
In-Reply-To: <6eae3879-f9d2-4fe3-96b1-c9e2aa939264@grimberg.me>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Thu, 7 Mar 2024 18:32:27 +0800
Message-ID: <CADtkEeeiNDO87L9MwC392gEp7YhhGGxojRu8nW_epkTe-jxcyg@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix reconnection fail due to reserved tag allocation
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_023242_868616_B8954614 
X-CRM114-Status: GOOD (  20.02  )
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

Thanks for review, seems that we should revert this patch
ed01fee283a0, ed01fee283a0 seems just a alone 'optimization'.  If no
double, I will send another patch.

Thanks

Sagi Grimberg <sagi@grimberg.me> =E4=BA=8E2024=E5=B9=B43=E6=9C=887=E6=97=A5=
=E5=91=A8=E5=9B=9B 17:36=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 28/02/2024 11:14, brookxu.cn wrote:
> > From: Chunguang Xu <chunguang.xu@shopee.com>
> >
> > We found a issue on production environment while using NVMe
> > over RDMA, admin_q reconnect failed forever while remote
> > target and network is ok. After dig into it, we found it
> > may caused by a ABBA deadlock due to tag allocation. In my
> > case, the tag was hold by a keep alive request waiting
> > inside admin_q, as we quiesced admin_q while reset ctrl,
> > so the request maked as idle and will not process before
> > reset success. As fabric_q shares tagset with admin_q,
> > while reconnect remote target, we need a tag for connect
> > command, but the only one reserved tag was held by keep
> > alive command which waiting inside admin_q. As a result,
> > we failed to reconnect admin_q forever.
> >
> > In order to workaround this issue, I think we should not
> > retry keep alive request while controller reconnecting,
> > as we have stopped keep alive while resetting controller,
> > and will start it again while init finish, so it maybe ok
> > to drop it.
>
> This is the wrong fix.
> First we should note that this is a regression caused by:
> ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
>
> Then, you need to restore reserving two tags for the admin
> tagset.

