Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F25C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luvSECJ+cfeJjyJAlOZotnCqbea20QwY/dYT+moyZG4=; b=GxXfvfjvkIcdTrkGFNMmVCNN2u
	KplZu3Qj2fSv2cOgsV/BNfBGuftkGyfu5cWqYwSWeoT1vSE13IMzJIBSENXpsjvm02kihvLXpaJF8
	/GgO8j4ekrtnbheRZuaB4Bzx1i2M+yvfkHI2BddArdFgEw7a4RKi88XM2w+WEeGBqeFK/FtfgLaI4
	Tk+kdB06c1ZbgEu6JxC6VhNITCivu6uXess3+pJQyw5H+cxfnpLS8wsIVIs5aos+iDiEFHpp7Dynk
	IPWz5IWCGuL0pHSRCEuIkTSM48k5eVwDxJYjRMQVGPrCao7v9YaD34ruCJLz71VhmdvTuwngSegE8
	Tb85kUKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbX0-000000041EW-0dgk;
	Wed, 24 Apr 2024 12:15:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzbWu-000000041Dj-3t2A
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 12:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713960915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luvSECJ+cfeJjyJAlOZotnCqbea20QwY/dYT+moyZG4=;
	b=gl8J1qie9MYqyhz3DtnxxUZVYlhvYOnP9AFTtdhabCQzoDpK/BD22HEBXM3IsfmNBB44hV
	R/Ff11fmY+OQuTUWln5NAO1e9731+s7+Rb3jz5mI8IgNcMqcX9nt6ysumMErhSUZ/SifoV
	Hm3pcaApuzFM7nHOFY2EcAckHLyztjY=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-IwdhI6DgONq8ekGMaKyntw-1; Wed, 24 Apr 2024 08:15:14 -0400
X-MC-Unique: IwdhI6DgONq8ekGMaKyntw-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7e822eb3791so4987752241.1
        for <linux-nvme@lists.infradead.org>; Wed, 24 Apr 2024 05:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713960913; x=1714565713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luvSECJ+cfeJjyJAlOZotnCqbea20QwY/dYT+moyZG4=;
        b=lZIeiEITWOoxgzIGD33tYNrQpBQ4AXM0WSGa/+o3VjUMefjoHuEsROlauu6buHYPk6
         D6Td+bL505uJGTuqGXybFhQdZvMhajH9mJVbHdkGs7lILZROyxZQuTw2ykCg04Gjwtsa
         nUm5sto0tPWIyc8/A8nonialfa/31POQ7PdHOgaT7MwvBpgiUrjCE+lNO1vc1YoxM7aN
         3IFzJ19KI+Ru0t1wC3xtvExdP4q0GDNn/8c4wtXsTYhtws7NZt3MAgJVIkaUmD5ME4Mk
         Bag5sGxi6el8LfcDxZT/U+Zpd5iq08lFs+Y+ymZAn0MhQZubLs6Wbk28Di11d2A/B0Ss
         XsiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtEdo7sXPPp/OLIG4yF4wxSpIF3MO54LLtZky6kmS1Dzwl56636/A3j8L3iDUpNFDGqqdY4gORI8pUcyD4vu6agM84QkGRotH/lVm0GkA=
X-Gm-Message-State: AOJu0YxHE6SWhXR5Xr5qgaCP8XeedCEDZt77l/1J92NWx2XFvPdAwbat
	Hz8E+capL0qzjXrgttMOktV++jXs/l8o4rRHGLlGQTTiut7iBhsdKG0EJCE7l2l1bpfm0sv8l/0
	gftvaSV0vVSrI23KHQoLmxGpIuYURVm460DzsLln25Uf2bTekjyuNFnqbRZ5N9mOOxFf9V2V8WH
	Y/DRp81aYse0/7rUB/UywjcFNPwUeL2Iom/Y/b+Wg=
X-Received: by 2002:a05:6102:1291:b0:47c:1251:cf25 with SMTP id jc17-20020a056102129100b0047c1251cf25mr556145vsb.12.1713960913638;
        Wed, 24 Apr 2024 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEruhuHsIISu2jbiQkUGVSkso8sMRRmHo6d8O79mh/G/m4nIA/cLrKdlffWVr0l5Sll4s9Nij6EDXA1Ti6Z9A=
X-Received: by 2002:a05:6102:1291:b0:47c:1251:cf25 with SMTP id
 jc17-20020a056102129100b0047c1251cf25mr556126vsb.12.1713960913401; Wed, 24
 Apr 2024 05:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240424102428.1298052-1-mlombard@redhat.com>
In-Reply-To: <20240424102428.1298052-1-mlombard@redhat.com>
From: Maurizio Lombardi <mlombard@redhat.com>
Date: Wed, 24 Apr 2024 14:15:01 +0200
Message-ID: <CAFL455nEJ0xy2mWt0xyn612z-4Jtp6tuZmhmpU3XNjHfN6f4Bw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-auth: print an error message if the auth timeout expires
To: kbusch@kernel.org
Cc: sagi@grimberg.me, hare@suse.de, dwagner@suse.de, 
	linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_051517_067416_0F18CDFA 
X-CRM114-Status: GOOD (  17.14  )
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

Sorry, ignore this patch, this was a mistake.

This should stay as a debug message.

st 24. 4. 2024 v 12:25 odes=C3=ADlatel Maurizio Lombardi
<mlombard@redhat.com> napsal:
>
> When the auth_expired_work fires, an error message should be printed
> to inform the user that the authentication is failing because of
> a timeout, so he doesn't get misleaded into thinking there is a bug
> in the auth code when seeing messages like the following:
>
> nvmet: nvmet_execute_auth_send: ctrl 1 qid 2 step mismatch (2 !=3D 0)
> nvmet: nvmet_execute_auth_send: failure incorrect message.
>
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>  drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target=
/fabrics-cmd-auth.c
> index eb7785be0ca7..7436ebda9f70 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -17,8 +17,8 @@ static void nvmet_auth_expired_work(struct work_struct =
*work)
>         struct nvmet_sq *sq =3D container_of(to_delayed_work(work),
>                         struct nvmet_sq, auth_expired_work);
>
> -       pr_debug("%s: ctrl %d qid %d transaction %u expired, resetting\n"=
,
> -                __func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
> +       pr_err("%s: ctrl %d qid %d transaction %u expired, resetting\n",
> +               __func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
>         sq->dhchap_step =3D NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
>         sq->dhchap_tid =3D -1;
>  }
> --
> 2.39.3
>
>


