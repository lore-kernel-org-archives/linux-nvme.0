Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898A4C54E58
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3K2dyY59QMbK45K27keA2V/f+oNgDgMOvqb1BGWGMic=; b=p4pi0BBtBPDmNillukychXA/Se
	oHrB5xdfO9km0vIzLT89GC6g7pi8BQl4DXxUjunlv76oLxQom1Do5RogcqBtyidSYZDaUdEWEUBTD
	T3eP0w60FoimEbU5e5tePRr/xmWvgmhtT/oiX9kndSknbdRpF+oCljYS/g/UFKJ2hK2dF56uTzPkE
	uqnv8swS0+CsPC5tZFN2X7Qb/TRmxSbfL3p1opb1uDCgstoJKjVUacVnEKzpGaCT2DLq8rewUqOiq
	YcqBQHz2qgKHycEfTn7eZmAsPHguCyOa81mKSypp0TSBzKpmaW5QGwppu3it6aO3YNkuujDKi/Luy
	ffFaYHbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rid6O-0000000ABUR-12hj;
	Fri, 08 Mar 2024 16:29:44 +0000
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rid6K-0000000ABPV-49c0
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:29:42 +0000
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a449c5411e1so302865666b.1
        for <linux-nvme@lists.infradead.org>; Fri, 08 Mar 2024 08:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709915377; x=1710520177; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3K2dyY59QMbK45K27keA2V/f+oNgDgMOvqb1BGWGMic=;
        b=ii9WQI7r/d0Tzufn9hW1G5n5GnLriQ5AaGiY7tJFMdP7kFjsVMFUJs4SfBrThsCTUp
         CVKY/pw9AfYcaFNpx+UG/+G4CjCfZ0HFqIhQ3NC/mfJ6NQSDiK9Egph4MDh6PTqaWp7J
         VkQuOfGK/ni9jGy4OdLc32Kucet40Mvr/CtvS6/8FQ5G5Xym49Ux70n+ljez6KzTdH1w
         NDu1NVGzBXE6FYFSyikT8QbbT+mwKXBNWRfbBowFWULlewCCnnb1WMf1H1C63GwdaJMS
         pgFdbUakmXrU0+xBXFVeIyTL42ScN8BoxD/SXPsChcGo5c+H0SwEE1X9U6SZdbc6uwcl
         vd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709915377; x=1710520177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3K2dyY59QMbK45K27keA2V/f+oNgDgMOvqb1BGWGMic=;
        b=WokWNIXYU/fXtcBNpIj2WlNgYoNgCuAX8g6tHnMTjh0sX878XsAAnQrvjZSHLvAtq5
         F01LIyRv+zwt0M7v3am4+K5lYbTK62wogEP1h7ZC+9MiMHxxtNWvUxn5xaEL1ZzpBC+e
         dv9CY7prwKocB7XSTmqkU89UXTdwQhBwdnCzbfvVMXcgg855Gw2AiEZAL9964fYh02Ls
         EUtD0hn+JEe8YAmZRd0EYaL2i8wXtjazd+HaQ23zwSUe+4yMepGKf3PkSgCFF6YofZH1
         9UMGXDYWYghhSKR2s2owr8VwSIlNYyzvocMEriklrzlaz89lPpGHKE/hQapdzq6ZFgaq
         avsA==
X-Forwarded-Encrypted: i=1; AJvYcCUpyWZkBw51llcEcGmuwewdQ0LLekUxrO08A6BqpNuHJ5Ny0/dqInjg3bM7sIOa4pjnUBfmLAvM6J1wqDIhv/UZji2TY9haOyT0Cs5Cqw4=
X-Gm-Message-State: AOJu0Yyd3tefaPTtR7vsK3VYakm2K4xTyTqAnJnf3/7IacwwMp2RWkrg
	R/DUjvj76f+rq4A//HY/nkwHQczD/czeVikXTv6PSUwjpbCh2mjoU/mVf4X7h8aoNlIktPSXLoY
	qPqb8dQLj6S+eUsEUmRoQTGsCq8s=
X-Google-Smtp-Source: AGHT+IE00X7/ws9uzFwHrN7Z0mQ0hIlgxafJNHRg9ehgnG0jJzoQqLAm5AHtPHV5v2UOY/jE33Ne3ei4Aq9Ewvx2Tio=
X-Received: by 2002:a17:907:c306:b0:a45:f866:4bd8 with SMTP id
 tl6-20020a170907c30600b00a45f8664bd8mr758753ejc.60.1709915376898; Fri, 08 Mar
 2024 08:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20240308015435.100968-1-brookxu.cn@gmail.com> <20240308144208.GA9194@lst.de>
In-Reply-To: <20240308144208.GA9194@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Sat, 9 Mar 2024 00:29:27 +0800
Message-ID: <CADtkEefTzbYN4qEAgAXDTB-+HMxfENw2m+xcoxzy83YW-bGEhA@mail.gmail.com>
Subject: Re: [PATCH v3] nvme: fix reconnection fail due to reserved tag allocation
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_082941_125772_A4C1EBAC 
X-CRM114-Status: GOOD (  10.62  )
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B43=E6=9C=888=E6=97=A5=
=E5=91=A8=E4=BA=94 22:42=E5=86=99=E9=81=93=EF=BC=9A
>
> The fix looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> But given that's we consolidate to a single place each for setting
> up the tagsets for admin and I/O queues, what about just killing
> the symbolic name and moving the assignments and comments directly
> into the only users?

This works now, but I donot know whether
nvme_alloc_admin_tag_set()/nvme_alloc_io_tag_set()
will be suitable for all driver in future, such as driver for apple
device not use these two funcs
to init tagset (anyway it not use these two macros too), so maybe new
driver would use these
value in other position.

>

