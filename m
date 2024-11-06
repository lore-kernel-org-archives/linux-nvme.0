Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1BDD3176A
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 01:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ooQJqlbYM/ySrgPiTM2o1pseu04s91YciPs6oL2YxA=; b=YnQ72vhQSy+n9w6ApHcX4L6GAE
	rwgenhUtlLyYE9TBA4ub3aCDxiUYx5CH31XOF/kfj2muHwrOInJWKwDh61cqz9vKmB+iSTtLfk4aL
	k2/E+6Hlzm/sTygiXcocqxdvpnQmhmZvxXnIEOV7OUqxKdlY4/pUJxjS15sEJ9jSREfLyvq9MECQM
	Q4i1nKQ/0Z5CH1FzN4a4BzllOGPUBrauwNv0OzXRF6QyYm9CaS6MryBZpunRw2BxZWwCl0uodsB8m
	a74JReJUsHrdeIiUrmmRIjCwl74vlPQnQZk/BXr6Nqpw6XJqXPWeibPDImiAm4Bepb4vVneLokY7i
	qrZuiYAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Uwq-00000001KYK-2GQs;
	Wed, 06 Nov 2024 01:35:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8UwI-00000001KVe-3Wp6
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 01:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730856866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ooQJqlbYM/ySrgPiTM2o1pseu04s91YciPs6oL2YxA=;
	b=N3DkdCvkhcZEAZVFsp1NX+YQiakzzPSErsYL2jqjXcV5Z3Dc9w3vpbyTcAmpbJbhJWCv9p
	pEdm1YB1CaIeGFYu7UTtXC2ODW5dvkSmvnrsQXal44wclCyQ9ftuvYIijIyAIUovQls8y1
	t6TSweozMF/bNslGeivZT32mPk5mZn0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-AzEWpKNPPVWDf-cD6elqOQ-1; Tue, 05 Nov 2024 20:34:23 -0500
X-MC-Unique: AzEWpKNPPVWDf-cD6elqOQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f759001cb1so50639171fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 17:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730856861; x=1731461661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ooQJqlbYM/ySrgPiTM2o1pseu04s91YciPs6oL2YxA=;
        b=of/GYkoN2EuD/BKTtutIEyzewo6SnHTLXd3E7loeF9fWp2xpNqucBrOvCritMbKs0h
         pyQskt2qccb+XPCMbAHUqlACvyKEbmjipit98/6SnLofbYKeU5vd2rIGwcISrTwQrWJv
         HWNQz8QEswBBtNd+nLxzbcLaTk4YMj9FLSyOG0mD1kbW9Pv8Wp1izmHWo+CpwabdTr0j
         9DFotLtnAP7ARlOLzO0yBYWb6uuOUe1npOIAEMPC5XQJk2TAvbNjR4Jy1ZqF9V+0/A0F
         J16YAc4I1Qm8WSOYHdmmmswaKVj+PUgwaH5wqOQuWfbwdZV6BU3SxzU06nPYoy7+XKbH
         z0mg==
X-Forwarded-Encrypted: i=1; AJvYcCUAQf++I42cr9EfUJmxOQVuJY9y7skm/mqXXpPuJvOHNsFDxM5TA++16Z9djIcWETC+4TANTS23jjBs@lists.infradead.org
X-Gm-Message-State: AOJu0YyqsQbq1Sxc7+APKftZmP7yBCYRAvEMja9VJRRUEyBSnyL6ejQH
	hgePa6vYxkRLPH6yLxmfqwN6DWdHGGHbYa2cEpN0ofsfxUHsTtR7W0zbyq5ltM3sFfO+WmTbrGM
	Bw5Q0l3q9nrbk+0pTyZITO6hmSSw7uevI2Is4DinS9ItokdAkS17dBrktUp9TAKUNoCO4Yn8zPc
	VQ9v5Dr+LJEN8DV27TpH6WLqcqBuueNthvV7bwjOI=
X-Received: by 2002:a2e:a9a2:0:b0:2fb:5ae7:24e7 with SMTP id 38308e7fff4ca-2fedb794b69mr137292381fa.4.1730856861602;
        Tue, 05 Nov 2024 17:34:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMSRjD0BFPGk6GjcQFn/YJ8mmHxPvY0pShjAW2ZDAdj3GD7z0cHCu5Mi2xlk2PN9cHVtQm4yFUcuq2RmGXogs=
X-Received: by 2002:a2e:a9a2:0:b0:2fb:5ae7:24e7 with SMTP id
 38308e7fff4ca-2fedb794b69mr137292221fa.4.1730856861250; Tue, 05 Nov 2024
 17:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20241105154817.459638-1-hch@lst.de>
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 6 Nov 2024 09:34:09 +0800
Message-ID: <CAHj4cs_g=qeZQzZO21ws8gx7iHEfGsSRDF65M_SbJSznKunhng@mail.gmail.com>
Subject: Re: max_hw_zone_append_sectos fixes
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_173430_994487_4CC093DC 
X-CRM114-Status: GOOD (  12.02  )
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

Verified the reported issue was fixed by this series:

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, Nov 5, 2024 at 11:48=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Hi Jens,
>
> this series has a fix and a cleanup for the max_hw_zone_append_sectors
> change.
>
> Diffstat:
>  block/blk-settings.c          |    2 +-
>  drivers/nvme/host/multipath.c |    2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>


--=20
Best Regards,
  Yi Zhang


