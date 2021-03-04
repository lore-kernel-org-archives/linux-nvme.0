Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC02C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 10:56:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D085A64E12
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 10:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D085A64E12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PUcIH90eD0i6bpRczUa9hR44wi1u01nx98+spHE+w1c=; b=lpE//FU28gmWnv0iHWjEEuoFo
	o5TdwbIKKQixCTW2xC4mq7/UMyccqHlDEgp7IuNkY/CJb6rqo9lhUO2Diko2L28dWj5q2rV7nZFPA
	e8/zENExrcruqKaGv5OMoM/WQJ5CSCdJKSIAGKXgQ+DXK6YqeS3ztS4TKbyiBOLIJ0lOmtzdFf1Qx
	vsjRy/cWSllGQXtc0YTF5l4BNbeXtZPYgMpYG9V3rV/Q9MuOIMSGe/tVYeaYfNJPSFW97mD43NkVc
	LClO0b+eXjXS1IB09aA5jairb78mt3tdfk/lmy2aDwLcWqiFo02DmqDIvY8tzfH2POqgxWJBIIsFB
	7seJSoapg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHleW-008PDA-53; Thu, 04 Mar 2021 10:56:21 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHleN-008PCB-5p
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 10:56:13 +0000
Received: by mail-wm1-x32a.google.com with SMTP id l22so7626986wme.1
 for <linux-nvme@lists.infradead.org>; Thu, 04 Mar 2021 02:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/Zx3mVbBGO/ltzSq4EWhn1tzp/kggwYcL9Ay/uYDpR0=;
 b=f5iit4SlEbzOINEygGhb1lvyimtovEWNG1veqKtkPLOQEYVLh28Rnn5wRteGbiQaos
 +BWyKvTaZ/Zzkf9lsyx43ui8UDUFgZL52HlQxOXkI+FD4wL2zVDFKSdpexR64S7/uQJY
 osUd9bgZBycBkeoRSWpO8CJhLqPbyPxrGjNTw5DXBzDqGT8G31ZJqMx7MBr0Rn9kRDSO
 /CDUkPXIR6xd0jSg3yOiI0HglwqugOJjihvv06h2XFxwoiSjXnh8nCneMFgHZErcTqYb
 KsUVPOaOdSj3LgzIl6uVgAvCD9sjavg3VEbFDo2ZRA7mOfIWI55zwHJotG45Er6H6z9O
 HaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/Zx3mVbBGO/ltzSq4EWhn1tzp/kggwYcL9Ay/uYDpR0=;
 b=WGgNXecDaM7+PN/1fGjpO/pgANcz8JOh7Ola61aKnVUuAu/0tdK1huMexQXpmTrh8M
 vNmANKB7Viv92FYT2lpfr/CBgGwihID1S0Wn2c5F2jVjUjTuq+4xkO3oC8qzKESGNrO4
 +exSki9+uZus1bQLgiJ9a+ufT84U0GsLe8Lwspzqvfog4JkYXvjR74KcqL/kOKSbnLif
 8yueK4HmrY6um0UunYJOLraI5XYU9jFxC+zM/vcYHp/aQRm3Whj0oK0f8hUop4+DMXpd
 NQgOq3MQgeUK/Rlw9EK4jQNZuYa/5lOxdvBDuoyCoC//6GNo/VvqvEhb+p3vLMNWaewO
 e51w==
X-Gm-Message-State: AOAM532kjooCBrZ2+gRnnJpMMEoBdt6QzwotC/RowSolf7oPZ8g2h/1O
 GIT3dTxzgcvzzZFISdtsYtOvDVZ+oN0hy4Ru3oDLcUYN
X-Google-Smtp-Source: ABdhPJwLOl6wlqdJiG1KynLq50DWRdOIcAXNG6M8eJ2ixliHBGpelVu1zo8IjxoK+8GuYlX7En9tSFapP1Gz1iQ8cVA=
X-Received: by 2002:a1c:4d09:: with SMTP id o9mr3294240wmh.15.1614855369547;
 Thu, 04 Mar 2021 02:56:09 -0800 (PST)
MIME-Version: 1.0
References: <20210302160734.99610-1-joshi.k@samsung.com>
 <CGME20210302161010epcas5p4da13d3f866ff4ed45c04fb82929d1c83@epcas5p4.samsung.com>
 <20210302160734.99610-4-joshi.k@samsung.com>
 <BYAPR04MB4965E07D8D106CE6565DFB7386989@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965E07D8D106CE6565DFB7386989@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 4 Mar 2021 16:25:41 +0530
Message-ID: <CA+1E3rJZWkOw+ZfDGduQhdhTh+=JVe5CcFEZtfQ1Jmq6mKhbSA@mail.gmail.com>
Subject: Re: [RFC 3/3] nvme: wire up support for async passthrough
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
 "anuj20.g@samsung.com" <anuj20.g@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Mar 4, 2021 at 12:22 AM Chaitanya Kulkarni
<Chaitanya.Kulkarni@wdc.com> wrote:
>
> On 3/2/21 23:22, Kanchan Joshi wrote:
> > +     switch (bcmd->ioctl_cmd) {
> > +     case NVME_IOCTL_IO_CMD:
> > +             ret = nvme_user_cmd(ns->ctrl, ns, argp, ioucmd);
> > +             break;
> > +     default:
> > +             ret = -ENOTTY;
> > +     }
> Switch for one case ? why not use if else ?

Indeed, I should have used that. I had started off with more than one,
and retracted later.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
