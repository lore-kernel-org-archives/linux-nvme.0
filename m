Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A30C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jul 2022 03:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tEa4h3AuCWiVLODFkT+rRGEj5LGAYoGPlr3UlbCOYw=; b=j7Yu19N++RQu49WaYqYN+VzcCR
	CSXG77ND3QYU0vWzPXvlwpU7xKFbwXAvIKXBmvxH03BFqUUGPNxqIC92+uzLwTZeqPE7lzaUdDkcE
	149WgSQb66R483BTB83hG0UUXVfuf3UCbLjysZb6ZNdGode7EexhAd6j31w6rzvcvpLy0R5pw7pM2
	U0nCEcvpo32UtKmxiUG2l8ANaOElkEIGeeETTKfc/zO/52IQSKSpCkVBLtPgFcG2GGHv6RtZR1Hso
	xc4Dvj+ZZ3/p6bK343e3si1teeRccGO+pOxyg5JeG/zUa0K8FR4CWIuhFKSwBo2wl4jNBvTol2HlB
	MEhlQaOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oA10i-006sXh-4i; Sat, 09 Jul 2022 03:20:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oA10f-006sWI-Cj
	for linux-nvme@lists.infradead.org; Sat, 09 Jul 2022 03:19:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1657336795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tEa4h3AuCWiVLODFkT+rRGEj5LGAYoGPlr3UlbCOYw=;
	b=FpT5AFxqL+I9faMuejwxFrwIt+2h8HOCgnr7E9FgwtDAd/SuJE3KoHqEKWyJ9itxdgmV60
	zUngDHHZk7u6SAw7+fpA80GZqHFcsOSIAaW4QogQ/vD1v6fxHzRr4dIAXeNzdSL5mXxF4b
	y9/2SR2HJ6TSCqXB5gJW1GdK+0STpNA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-bumUUnCdMd2MJV3u1wZ9qw-1; Fri, 08 Jul 2022 23:19:53 -0400
X-MC-Unique: bumUUnCdMd2MJV3u1wZ9qw-1
Received: by mail-pl1-f200.google.com with SMTP id b2-20020a170903228200b0016bf00c3360so275672plh.19
        for <linux-nvme@lists.infradead.org>; Fri, 08 Jul 2022 20:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tEa4h3AuCWiVLODFkT+rRGEj5LGAYoGPlr3UlbCOYw=;
        b=Lz3dcZ8yD0ZgLWv+67jGprUzp5m4yUtsb7JDvRSRDamv0Ng999yB4VyECGF8REY6ea
         ihNpW9DuOrq6DQOEbeeedWQDFPkolp+Pvz9BgodNznZT7PSNMwGmsbCeEBmUNqrxt4qB
         y/dBIPFtmbZ1t/Z4QKacI7mdnI16U229tyNuUw84euvEKGtABBg5nEiFtozEZQwnNTYp
         ngDIl2PxNbIMwrEDNx28uv06VwpRNniA8VFquw8PjvRbIHJaC/wZUG3sKegguuWir3+k
         22Ckj+BNjI3zbhs8W/w+FWKAGM3xChfj/XOyh4t+H+ltdKtujJiKXMqSw9gpXrgiElex
         hkPQ==
X-Gm-Message-State: AJIora/q9OBfg6lsg8Q82RDPsUONYxcXgs5WYU1PWhlmMKobTd7h4gxl
	yliiNEoC1ZCwkCwMZz+gRaGQWDjGs6ytWm/17DOQkOLwgj2ipQQs8zj17gd7eFv5V3hueswwU+G
	VkN61/rgCg7kgVTL4Fvg3dYN9m/jtgsm/0dyAe8AKYiI=
X-Received: by 2002:a17:902:7fc2:b0:16b:dc53:5060 with SMTP id t2-20020a1709027fc200b0016bdc535060mr6963796plb.95.1657336792550;
        Fri, 08 Jul 2022 20:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tJVTqZUrgGkJr+6RIms7c9nogEy1BpM0bt5qUl2JUpn+ksyqbgeDB7DA6BEla8M+7/b+q+bsw5N5dBmlbfJVI=
X-Received: by 2002:a17:902:7fc2:b0:16b:dc53:5060 with SMTP id
 t2-20020a1709027fc200b0016bdc535060mr6963773plb.95.1657336792237; Fri, 08 Jul
 2022 20:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9Jhg4DZRnck_rdGWtpv9nLTAF__CVtPQu9vViVUZ-Odg@mail.gmail.com>
 <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org>
In-Reply-To: <def01493-bd2d-bed4-ab1a-9b4304687692@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 9 Jul 2022 11:19:41 +0800
Message-ID: <CAHj4cs-xUroRHbvY4kBPCBFgch7d24yXDFLo4P_ym8KEkHCvug@mail.gmail.com>
Subject: Re: [bug report] blktests nvme/005 trigered debugfs: Directory
 'hctx0' with parent '/' already present!
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_201957_793722_E415F65E 
X-CRM114-Status: GOOD (  13.37  )
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

On Sat, Jul 9, 2022 at 2:59 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 7/8/22 09:32, Yi Zhang wrote:
> > I found below error log when I ran blktests nvme/ tests on aarch64
> > with the latest linux-block/for-next,
> > Please help check it, and feel free to let me know if you need any
> > info/test for it, thanks.
>
> Is this 100% reproducible? I tried to reproduce this yesterday but
> without success. See also
Yes, it always can be reproduced at the second run of "nvme_trtype=tcp
./check nvme/005"
I reproduced it on aarch64, not sure if it's arch related.

> https://bugzilla.kernel.org/show_bug.cgi?id=216191.
I tried block/001, and cannot reproduce it.

>
> Thanks,
>
> Bart.

>


--
Best Regards,
  Yi Zhang


