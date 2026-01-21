Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACCDC44502
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jan 2026 09:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nP9la3aMNoAWVdP2WHQh7XGSfccjdpFKMpYPe5dyJ1w=; b=KPk+coR3bawkg2rdHhoD60gc5n
	xLO302ExCK+smanaeUFdgR6MIqwfHgv3v+TmVBIRfGjrHwBxIIPZ2uXZacoCxVGqFu7f6qo+Otfjd
	6Nb3G+8aAeADw7Y9i47qYlM/V5/GS1YY6ER5rxKaJqxEHdcYwbZn8xnh6NBgTOSZBPz4jyy6FGkaZ
	qXtvh9o2cJYYCDk+3sJmme9D2rcfWnXIRYR2fxcDGp7Sg7nzG2xGCw4jfZZ0GPT7BEbS5i/Dqugcp
	WWWA3D6ppM/3m8eBqaOAqe/8JPrdCwVRopbaKwR9MPfstK29odSAG4o7idRV5iysNynPUI6oY2FiC
	GxSAYwwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viU7t-000000059bV-1emk;
	Wed, 21 Jan 2026 09:03:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viU7r-000000059b2-0XAZ
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jan 2026 09:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768986221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nP9la3aMNoAWVdP2WHQh7XGSfccjdpFKMpYPe5dyJ1w=;
	b=bVIxc6qh9Iu7d6zkKKzyM0Zbg5+tfqOjQqn06+xdcfH76TriuXffCcTuwBLhMOyzKateD3
	dH/kB3Z92yoDRFCDj1p0oGBFL2vnrlYu8/Rv5AiHglgjzlvXhWHPXYe9uYyLvdwwQ9Z/dM
	/hDdespiRQPUnPJxYjPP7/q8fftdhpU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-nRqht0XPODu3XLHI5FDbbw-1; Wed, 21 Jan 2026 04:03:37 -0500
X-MC-Unique: nRqht0XPODu3XLHI5FDbbw-1
X-Mimecast-MFC-AGG-ID: nRqht0XPODu3XLHI5FDbbw_1768986216
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-59dd43af3f6so105535e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Jan 2026 01:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768986216; x=1769591016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nP9la3aMNoAWVdP2WHQh7XGSfccjdpFKMpYPe5dyJ1w=;
        b=Z0yFNVYVtkyEI8g41XHd5clWaQkeob6XZNjKO1u7BcXeuvHBwfBHDZ44COL+WZR3ls
         ZxTxrKxSb97HIVJQTPfxBwgZAfNvfLZoG7BSJa+BUa1cLp76uCENlRYm4G6FwnJSjfWt
         vKHMct9F+sI450ZPGLpM3eZkSGZR7VuWE8nYzaLcyVkLr4nhnvAe/pWs0t3CbpqiFrGH
         tNycx+GzeOu2TuF3+yz2+bhkeW9FU3wgQ6kMZOHXPUumP2boJYAhyxJ/3Mkgz0ImqBYH
         8iRJU+EusVIEIkNHoZXpef+oqbzxYObbLc/WPDrRIPhNKaIn8QsDIoUoysWSIFIWMQts
         kJZg==
X-Forwarded-Encrypted: i=1; AJvYcCWJVzXd3m4ijd3bog4z4S6LFQ9EQqljXxP/7JUZam1oiPNIE/CykuiN53xtqiwF5elUczBYI4vrTtnA@lists.infradead.org
X-Gm-Message-State: AOJu0YzSJP8iCNph4vExZ02CJDEi3JroImiWAPeE+s+SPL1eFydJtvJT
	E85HuVmQL+JlhvlT0m/QCseK1iCbzAD/2v8Vg8ZlkwkIw1aGM1uchoHBIMQAvNb8hsKQphbFMU8
	3DlFaGQrmSu5y209I+LHiqkPCY5lpH5awvEGJVAf5+cLU1MMP2kS+4RCfh0dyF4ZOXaF6lP0wkz
	X/x1WwRsTye5PsuvhcfPbrHNwqo03/JmHvE+65FhMGEL0=
X-Gm-Gg: AZuq6aIQvxeyXnxxtN/qxYk9DadlVGLayrf/IEGkajOadrCaForAn9MWgop+DWchdlc
	IvO4o3Ff3vRMxbcMicxTgxOvv7ASvXNakAjlOzsM+nNRxz6lhcQl1RCmu0+dihphhFmlK87lrd4
	NUqsyvtgjKzeo3oz6rIUDI6MaQ4ky4p1JD1puIn2rrYoivrM1aBvwTkSk8FozoFW/aEVA=
X-Received: by 2002:a05:6512:3b0a:b0:596:51d0:9373 with SMTP id 2adb3069b0e04-59baeef7cadmr6418640e87.24.1768986216171;
        Wed, 21 Jan 2026 01:03:36 -0800 (PST)
X-Received: by 2002:a05:6512:3b0a:b0:596:51d0:9373 with SMTP id
 2adb3069b0e04-59baeef7cadmr6418626e87.24.1768986215747; Wed, 21 Jan 2026
 01:03:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHj4cs9JJu+dDZqAvCd1qPM1CZuV-_b-AHxXpU-vJrGHHO-ExA@mail.gmail.com>
 <aXCT9sFChMdhwNYw@fedora>
In-Reply-To: <aXCT9sFChMdhwNYw@fedora>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 21 Jan 2026 17:03:23 +0800
X-Gm-Features: AZwV_QjzmfPDk7cwbCp7-iHngLSxmXDTNHSTGJfvptIwf4Q1GJXRD3Dli0WxjZY
Message-ID: <CAHj4cs-VK+W6UXeiiTdarw+MoFtn4xe9diU3CtHXaRy7kGQxgQ@mail.gmail.com>
Subject: Re: [bug report] nvme-tcp poll queue causes busy loop and 100% CPU in
 nvme_tcp_poll() on the latest linux-block/for-next
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IdWB6FBR1LB3B0Yl36d5h8zDuJ0jV6xdm-OMdnK2EgA_1768986216
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260121_010343_243608_E0C84C07 
X-CRM114-Status: GOOD (  15.90  )
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

On Wed, Jan 21, 2026 at 4:53=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Wed, Jan 21, 2026 at 10:50:00AM +0800, Yi Zhang wrote:
> > Hi
> >
> > This issue was observed on the latest linux-block/for-next during CKI
> > test, where enabling the poll queues leads to a tight busy polling
> > loop and 100% CPU usage during "nvme connect".
> > It seems was introduced from v6.19-rc1 and cannot reproduced on v6.18.
> > I will try to bisect it.
>
> It may be related with f22ecf9c14c1 ("blk-mq: delete task running check
> in blk_hctx_poll()").

This commit merged to v6.19-rc1, I will revert it and retest.

>
> I guess it only happens when `nvme connect` takes a bit long time, not su=
re if
> it can be reproduced 100%.

Correct, it's 100% reproduced.

>
>
> Thanks,
> Ming
>


--=20
Best Regards,
  Yi Zhang


