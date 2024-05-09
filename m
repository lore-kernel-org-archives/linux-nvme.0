Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FC1C10F1A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 06:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5tjZkb1xEbjulPOqAqbeWuJeVgKtzpvbp1WvlMGcxs=; b=T5UQ1He9hxTMcLV2Heo5mfMZAn
	x6EyiYlz+NR603PyHG/M5dyK5E1Bd3HYPMVx3K/O37hFJNwjXxxbD//3A/0v3X0D+34GHjwy8yCp2
	Kj6SOFu5FiG9ONCYsMEC6XypSR47vhDu+5+aEtwy+fvtbIEV6Kjk7K1RIiN7p0ygXIMc8GKMfkifg
	a7bbMP1CPMxHdmksRnrULsvkX/9i74qcRkf3/bzpLeB31P22rToJB4esquw/xj6t0mQxdSTvPA7e5
	m+wZYTvYK7sLxLz0EexuzWX75FDN1SOnZYiFMzMgb4S3QzLayN8RwR3TsA2MHDqU6lhBnj9xQLMVW
	wgLOD4Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4x3w-00000000Xff-2ttC;
	Thu, 09 May 2024 06:15:29 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4x3q-00000000Xd7-3QtL
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 06:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715235319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5tjZkb1xEbjulPOqAqbeWuJeVgKtzpvbp1WvlMGcxs=;
	b=L6kxUkjMy47hDb22YWvjkCAk9vgyO9zLtfbLCOI4qho10HiysYPi6k8cDG2YSHcP1Kpwit
	DB4flmfap8bnc+O7zE6ZkqiU97JapwpFaADoBdIs8GgNwqEVFh322H/NqM37J97hV86w61
	XRz/V8uFMKaKLbeVLAYJNDtWE+7wDPg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-oASiwE1DOGCZSXz19CmItA-1; Thu, 09 May 2024 02:15:18 -0400
X-MC-Unique: oASiwE1DOGCZSXz19CmItA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-61eea13e924so588891a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 23:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715235317; x=1715840117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5tjZkb1xEbjulPOqAqbeWuJeVgKtzpvbp1WvlMGcxs=;
        b=sleWzwcVRxFfqvVGRajDXkvRzAjx4loysKTDi4YFVPekdLtGwGyVbxp3ANtWftih0H
         xvGAH358JSyodmlZCEAPvceWD03z/F1O16/OuDttXS7E7S0NX9stZVkvujFvVL9whAjC
         MtZ+jrLp7y4LNWz4yrP01S/VoJ/GHQxKEArXcjl3QwRXc9gvau/ECLAdx0Q05wpjcBcy
         S/cXqNQg0pivmp1YHIin53OJdxVV7YWH03xd/8ORZGVZVajx4cnqmIXWcjKCHiNUV+ro
         zPrX2P1Xl5Pmo8Rdy6l+emWsGnNtpcfEKILm8aJtGj3Dw34nCum8BxdEJyahqK+umcwe
         dlTg==
X-Forwarded-Encrypted: i=1; AJvYcCX+yZJdcVjF64EGGqdbhtwpcLhYnCA4UTazsZ5Sf4aEKyBhSFG058t7iedfY6vSf1nhUdcVEB6ssaCJjzhUcHABqfGKZ6XjEHAscq8CmOc=
X-Gm-Message-State: AOJu0Yynm+xwaUWJqBTW1TA/TQv3w3XbQjTbEjG/JIHjYRgpH6khpB89
	znZhwPW1GmqPGgy4skwuiPqmd2jslsLq+63aAzj1eaXgGIwejFyvt22HMBao1dionz46wRg+dF6
	66hEeQLAe2uFMkrOOQpdT1WROt7DtUlsjxsx3t3pawnJpwttDyfeSgtYN02q5DWF/IRLEAmczzu
	8Te7iMax7d22zb5hutbIQ/JbcogTHHWuIFCsTvz84=
X-Received: by 2002:a05:6a21:3d83:b0:1af:ab0b:1c08 with SMTP id adf61e73a8af0-1afc8d9938amr5296199637.46.1715235317002;
        Wed, 08 May 2024 23:15:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6IvY4S7f3az5NCB7DGqMhZ5hgkvbcffBBogyGjcywqeE+OgeoXdE6dGWD2sKHFjk+USctmLniTam+uNy+Zn4=
X-Received: by 2002:a05:6a21:3d83:b0:1af:ab0b:1c08 with SMTP id
 adf61e73a8af0-1afc8d9938amr5296183637.46.1715235316629; Wed, 08 May 2024
 23:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com> <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com> <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
 <e229f273-e3ec-489c-bf89-0f985212c415@grimberg.me> <76c17ab2-b3a2-491c-a6b3-7bd39d6d5229@wdc.com>
 <1ceb71ce-c4fb-419a-8800-8ebbbe1706fe@grimberg.me> <87d1ac8a-df56-459d-a2f8-bcf940aa9e0b@nvidia.com>
In-Reply-To: <87d1ac8a-df56-459d-a2f8-bcf940aa9e0b@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 9 May 2024 14:15:04 +0800
Message-ID: <CAHj4cs_+NaQ4eZQo1b8rRLsGPMgCKUyaOW8e5Rpi1AUW7vJ8rw@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_231523_030393_7901F649 
X-CRM114-Status: GOOD (  16.01  )
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

Confirmed the issue was fixed with this patch.
https://lore.kernel.org/linux-block/20240501110907.96950-9-dlemoal@kernel.o=
rg/

On Sat, May 4, 2024 at 5:14=E2=80=AFAM Chaitanya Kulkarni <chaitanyak@nvidi=
a.com> wrote:
>
>
> >> This is something Damien added to his patch series. I just wonder, why=
 I
> >> couldn't reproduce the failure, even with nvme-mpath enabled. I tried
> >> both nvme-tcp as well as nvme-loop without any problems.
> >
> > Not exactly sure.
> >
> >  From what I see blk_flush_complete_seq() will only call
> > blk_flush_restore_request() and
> > panic is for error !=3D 0. And if that is the case, any request with it=
s
> > bios stolen must panic.
> >
> > However, nvme-mpath always ends a stolen request with error =3D 0.
> >
> > Seems that there is code that may override the request error status in
> > flush_end_io() but I cannot
> > see it in the trace...
>
>
> I confirm that after several tries I cannot reproduced it either with
> and without multi-pathing, blktests is passing without any errors for
> both nvme-loop and nvme-tcp ....
>
> -ck
>
>


--=20
Best Regards,
  Yi Zhang


