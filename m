Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131D5D6ED01
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kD5zvuLefd3mbRLAvjOOucqZAP10SWFoaFRpV12DL2U=; b=0Cwr9NdXXvQmcAJU3/1BeEla5R
	pQyRn7VqtpEdpZGDvomNKjUD86vKr+p0/hsKG46wb42gnwoIx8Yoo+Hkl30MslFW+2ER1l3t+yafx
	xUnwrhZEvyRD3AUJn2bUIgPV4tPeM+ZDTX6xRq/SDVTiLMwNXJabttx5oFBx1t2w5auAK4YFY0OY/
	neefhPcViCWCcGo1Hj7dTpodc1PGBUh9pcrNZk2f3Gixt3PbnhpyS+Uq/NWIYsCSVJSObByziUSql
	E7cMmiupY5SD/dFn4aCtCJLW9xK8JxWpV1QReuglxxDcZynUco/YV/rYbh19Wq/QDp2YFAWTrhMvt
	/b9weMIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE4gU-0000000HONg-0em6;
	Thu, 21 Nov 2024 10:45:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE4gP-0000000HOME-26DH
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 10:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732185908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kD5zvuLefd3mbRLAvjOOucqZAP10SWFoaFRpV12DL2U=;
	b=Ggi1F42sUTWOKwcSU6LXVlUvA/ds3Ia5mfBuq3wgsSy3aVqekwVu27cw30lNGjXRfl9v7n
	k1GCZw42ouTnj90Gx3NTdmGBhGPz4xIVp7LmQyO20QDAf0rqipr9m7zBTpSmYUDNGI4G15
	Ey6RTxPbuq3Gl3e1Amtr1nIbTfAZPPI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-i79w2jhPNqW2WPmx3sK1pw-1; Thu, 21 Nov 2024 05:45:06 -0500
X-MC-Unique: i79w2jhPNqW2WPmx3sK1pw-1
X-Mimecast-MFC-AGG-ID: i79w2jhPNqW2WPmx3sK1pw
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-50d6bc46348so301484e0c.0
        for <linux-nvme@lists.infradead.org>; Thu, 21 Nov 2024 02:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732185906; x=1732790706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kD5zvuLefd3mbRLAvjOOucqZAP10SWFoaFRpV12DL2U=;
        b=UPAdpoacv7IHp8/qRtZ5IRGEjQ6ccKGQkiMIMl7agomjNlVQh+IUBv/evuyEZQ4iv4
         0ZJS1ppl7C+RHD2gFZ+bc3rvLCKlnBIKzOEtvdaq/QdiUrRDmznJHrZ0h7QwQU7uogNC
         TDNS2i0oyooSEnYpgYyoP0T4Kqq85/1QiXdDeVLbXBOi0FVfcZiHOjGOmkAoLeW3sOTS
         SioHSyjrzoDK9R9rdo9gk9ngBYm+G4Hqey1/xqgem6YVpLrDkZ408rP06hZXRGFxdPL0
         cQ23ULEfEKmvtSNkp818fqbeqCWwViO+8yErtwMcnRjq8EgVLMNEET3AHqQEJhaztMlc
         fMVA==
X-Forwarded-Encrypted: i=1; AJvYcCUTYCXXZI1NI5Kfnq/pRgeR2BKfjOPLUyzm5B75cKRQL25ZP+IbyaBl7Gl1gG66BAE6fLcFLS+s4cPf@lists.infradead.org
X-Gm-Message-State: AOJu0Yxh/zSOoznAtE5T6vy7jhocxuhra58c0TWt5KCuKnpgyoIQXkC7
	2MomHGnXttdmgPCc9RAS1kb7Oza91TIbHpyRvxjYAPAGXpaLHBUe7xrLRqtoTHUq8ZwcXF//2nV
	Z/haPHPkUVDL+WioXipx2PGXrC63HGx486nAIbk6HNySnlbahhFhRnegAqdT3BxLjDNJjo7zpLj
	DhTD5QsB2oXHB3CTKrSbj354saz9OZdR2j4Y5CgMQ=
X-Received: by 2002:a05:6122:2a47:b0:50d:b561:33bd with SMTP id 71dfb90a1353d-514cfbaa493mr5697531e0c.12.1732185906400;
        Thu, 21 Nov 2024 02:45:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn0BsreCrPn+9IUh35v76rFMQrjLPHM8n7vR0PiFx0ktfglmIu9KLQ/0cENaUSSwkiuOaizEit/XYibqMyIro=
X-Received: by 2002:a05:6122:2a47:b0:50d:b561:33bd with SMTP id
 71dfb90a1353d-514cfbaa493mr5697502e0c.12.1732185906135; Thu, 21 Nov 2024
 02:45:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com>
 <7f35cbe9-9e12-498b-b46a-be1f570772fc@linux.ibm.com> <CAHj4cs91daKS2Sexvs3y_m=r=+a+gJdk9=Z+76TdsE6=0nNcYg@mail.gmail.com>
 <CAFL455=-5a34TYdwva912prQd93p84Lq1YSebTCUUsuLjZ5pag@mail.gmail.com>
In-Reply-To: <CAFL455=-5a34TYdwva912prQd93p84Lq1YSebTCUUsuLjZ5pag@mail.gmail.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Thu, 21 Nov 2024 11:44:55 +0100
Message-ID: <CAFL455=V+YrmZZhWX=Quv_6BDH5SD17KuUKvMw1A9+VfNw2=Tw@mail.gmail.com>
Subject: Re: [bug report][regression] blktests nvme/029 failed on latest linux-block/for-next
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, linux-block <linux-block@vger.kernel.org>, 
	Keith Busch <kbusch@kernel.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JP4WRdIJ3s5cBqqxhxRA6u9om5lP7GLViO5DbfP7Y2g_1732185906
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_024509_610459_300FC875 
X-CRM114-Status: UNSURE (   8.17  )
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

=C4=8Dt 21. 11. 2024 v 10:02 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> > 64a51080eaba (HEAD) nvmet: implement id ns for nvm command set
>
> I am not 100% sure this implementation follows the NVMe Base
> specification correctly.
>

Additionally, the nvmet target doesn't support the Namespace
Management capability (the OACS bit 3 is set to 0),
therefore if nsid has a value equal to NVME_NSID_ALL the command
should be aborted with an invalid namespace error.

Maurizio


