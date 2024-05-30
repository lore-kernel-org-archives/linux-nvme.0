Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED5BC25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 07:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xz8U5y1+ck2hIWPenWUt2lk01gSd/hFRlBRmHZOOSwQ=; b=4Kzk8ft6AtGpC9xNjUPquN9lFc
	LuOJAz0Nyn/jLpdOKesYYQWzaPvJNPyuyrqxkKrbhjEJPkm+wXutHqUZ/SJYaFOGPN1Cswzzi0UZ5
	5hsRGAOhoAClXlt/2ItP3OvX95uIDnfGFqhyG3RPvSeaeaoBorwrZEbT7462gMLxoFAQ9h5Wn/Ovv
	Luw1AmF08C0XkAi/+kfhXhyYwomF3R6FTGlsB6rVZJeBLwq0iV3SCCQT5semM5VFF+unNZ0ysK8ui
	vDdy5halwPLHZUUcijKeno9Y4glS2DNynwc37//NUOEqUCZ5/qQEr655lsxae2rsQReELoTwxIVgn
	x8uhcSuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCaAU-00000006VXy-0zQy;
	Thu, 30 May 2024 07:25:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCaAR-00000006VXR-2sqq
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 07:25:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717053940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xz8U5y1+ck2hIWPenWUt2lk01gSd/hFRlBRmHZOOSwQ=;
	b=X2RxSliPl3+Vvty9GL2NKrlAN6m6DzNntN0h/oc6eO6P3Qcm/bfPb7tmiEoJjB63QdXKrN
	AijbMFM17e1z7/GptnvXeabBfmpiryCIFPmqOniW+uFC/S7h0UfY3hXFwMsCXeEU9JiCwU
	oftKUWePVxZ7vFotGtOakFgJfj/GFOM=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-2PRTbCasM6aaBAyeWV-k5w-1; Thu, 30 May 2024 03:25:38 -0400
X-MC-Unique: 2PRTbCasM6aaBAyeWV-k5w-1
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-4e18db22cfdso317124e0c.0
        for <linux-nvme@lists.infradead.org>; Thu, 30 May 2024 00:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717053938; x=1717658738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz8U5y1+ck2hIWPenWUt2lk01gSd/hFRlBRmHZOOSwQ=;
        b=RQO/b3YC6BOhZoT1j8aEgMvdB8jxiqWRn8Ne5Lx1HkzrhP2pPiz5A5Qsnirn4M4fNa
         0ipON9yEPJr+TtZygjka9DSDYVNh/sFkc0YllogztMCQA80sB2REzcXKMQ/EJcgSbXhA
         D3niqsaASsARx3AxhUzBp7r5Hrs1PMaz+wTmV1VqpJKEogl154oJ0V/YLsstCYeOd3j7
         Vl51YG8IylrR+mX4K8RxzZeizI5J396ecobfoAqiqmVY7SuwXId1o53YdRVrAIDHF8hO
         +nnaSiOS/gCRZGUdrCQ9FRbrp+Qqi3/b4sYtA4ww81UrWYlfK/wTnKDpC9nGhjgWCpcH
         kV8g==
X-Forwarded-Encrypted: i=1; AJvYcCXO1Lrtw2NoOtVOe6E+xCOHxbgT0FCVnKVolgskCCIIjvo1ypYBbENbb0ALDNqbSj6pFz06GQM3B6L+iXRxlf03eiq5sl0ERqzHJGQSqV0=
X-Gm-Message-State: AOJu0Yzxxe9wXUAPaV7/LSxff9U+jAZ4ofW0/9PfB/W8k3eI+8klL2+5
	1xfmWX6tmquN13vT1PPippcLwa1zSXEiWXcI+X62Knn2uqtPHWUQ79Ghs3bBVSJP9pdNnHF/9Z9
	JOhyh3kjAy4CSDHBrnSKMvKFjpErhJ5WHhmYG78l6MNLZplp0YVlehgye/geBX0H49ZF/lT6F+Q
	bHVlUGa9x9/XKU5lyWlmB+hdQ9gyx/P/tWS8ONqDA=
X-Received: by 2002:a05:6122:469c:b0:4e4:eade:1965 with SMTP id 71dfb90a1353d-4eaf215952amr1585770e0c.3.1717053937583;
        Thu, 30 May 2024 00:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiFi5IZgtwRzOsoQpoR4EHY+JJkRomcrx9v1SmutoohED6kELlwHS+hSdGwLXphapTHVzH66IeAAmjGdrmROc=
X-Received: by 2002:a05:6122:469c:b0:4e4:eade:1965 with SMTP id
 71dfb90a1353d-4eaf215952amr1585712e0c.3.1717053935915; Thu, 30 May 2024
 00:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <c4050a37-ecc9-462c-9772-65e25166f439@grimberg.me>
 <CAHj4cs9fu9-OcDAHq=WijeCia2ndphbpgA0YiPSSHQQLKBXBZg@mail.gmail.com>
 <CAFL455=iu16d1xkE9-ReZOrtcOQJ22Lt5vtsiHb5uTwCKJh+hA@mail.gmail.com>
 <CAFL455mZMka2J8d008JH+WQhDxP6D4dweFOWVQc58rOQk2ybzw@mail.gmail.com>
 <ff85fd7f-efc7-40d3-8c9a-e0189e3d71f2@grimberg.me> <ZldW7nNrqHCTYTEF@kbusch-mbp.dhcp.thefacebook.com>
 <93883147-490d-4065-a741-3e49288ea3af@grimberg.me>
In-Reply-To: <93883147-490d-4065-a741-3e49288ea3af@grimberg.me>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 30 May 2024 09:25:24 +0200
Message-ID: <CAFL455=ixC0S8aU+AouQFtDFN0bFdNgSXH0d9a2-VXegj8dPuQ@mail.gmail.com>
Subject: Re: blktests nvme 041,042 leak memory
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_002543_844456_11B42C4A 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
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

=C4=8Dt 30. 5. 2024 v 8:59 odes=C3=ADlatel Sagi Grimberg <sagi@grimberg.me>=
 napsal:
>
>
> Lets just do that... and add a comment that we don't want to add
> function calls that can fail post cdev_device_add() because we have a
> cleanup problem (with a short explanation), so this is less likely to
> come back...
>

Solution 1 will work even if it's not 100% perfect because after
calling device_initialize()
you're supposed to use put_device() to release the instance and not
free the dev directly.

(The nvme_put_ctrl() call in the error path just releases the
additional reference taken
by nvme_get_ctrl() just before the call to cdev_device_add()).

Maurizio


