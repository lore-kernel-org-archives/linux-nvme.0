Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D626E9A02C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Feb 2026 13:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S2SlkcRqb7QLXiC7P+amY8KjN5Z25fMFewVuOFV8NZ8=; b=RZdaY92RNj3/HaKBnqurhAwPjx
	FTbb18ogNZ8QC15QEr4epP1JvuvPQu1ujPOHUN9iqeBaO2LRPSC350xu1qwzZgsv1kCgMF/pnt+1z
	idM8NwPb/BhKwMfVSbjUO3EtH35t6mJrgg5jwHALLNxxxfGpErB+QC6L/82s0vtTMeGa+PRKN+jEa
	UXqoe9sC+PSxKP45xifiGXIcwkldmWjfa67Q3uKMV62WdpI2hzBX7dqDXXyGU0hAElyhnx5cO552h
	P3z8403Hxn60k6vFu4dEw7Ejco2zk6trroawuttvKaqBRZpEx3wig9G/dsaYKUvx8CtX6kx3F5K7W
	SGVyVlXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vshKc-00000009pkI-1v8g;
	Wed, 18 Feb 2026 13:11:06 +0000
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com ([63.178.132.221])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vshKY-00000009pjl-092O
	for linux-nvme@lists.infradead.org;
	Wed, 18 Feb 2026 13:11:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1771420262; x=1802956262;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=S2SlkcRqb7QLXiC7P+amY8KjN5Z25fMFewVuOFV8NZ8=;
  b=NIdWC+rC10OFqXaw7z5tzkNZc1TjYKl9kQAK725dUypict7d9h3mMSFE
   CBBfyiOyIpSZCKDPK3FVtZw9Kib7pEWUuvXmA9YngE3cTNfYfEuD97AbT
   0UFF25MX5SlkgUWdtUnzUYzYlM2c0IwtjCTOgu3E8rseeXXFrzWnxyS78
   ZGXXJRoGWtXjVzRA1kvwKVhO0AgN+RVvmHb73c4PrNZeWG/KRoWibiS64
   zEBFB41Ea4tAzxUK7WO8Z6oWzlo4zUxP1z0EPFTevJSBV4nAP1J5QB1Sr
   WmxBmRcnR9rsN7/BtcS75XgwvvbFmePV76VXrIx3V7qrmTwq0txlHH1L1
   Q==;
X-CSE-ConnectionGUID: mMptmnszQVWEGUceiMDgnw==
X-CSE-MsgGUID: RZjEZ+HrQnChokU9BfVSlw==
X-IronPort-AV: E=Sophos;i="6.21,298,1763424000"; 
   d="scan'208";a="9511121"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 13:10:57 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:6677]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.228:2525] with esmtp (Farcaster)
 id 63bef8c6-1bd4-4bd4-a365-2a014ce01900; Wed, 18 Feb 2026 13:10:57 +0000 (UTC)
X-Farcaster-Flow-ID: 63bef8c6-1bd4-4bd4-a365-2a014ce01900
Received: from EX19D008EUC004.ant.amazon.com (10.252.51.148) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 13:10:55 +0000
Received: from EX19D008EUC001.ant.amazon.com (10.252.51.165) by
 EX19D008EUC004.ant.amazon.com (10.252.51.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 13:10:55 +0000
Received: from EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1]) by
 EX19D008EUC001.ant.amazon.com ([fe80::9611:c62b:a7ba:aee1%3]) with mapi id
 15.02.2562.035; Wed, 18 Feb 2026 13:10:55 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: Maurizio Lombardi <mlombard@redhat.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "emilne@redhat.com"
	<emilne@redhat.com>, "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"dwagner@suse.de" <dwagner@suse.de>, "mlombard@bsdbackstore.eu"
	<mlombard@bsdbackstore.eu>
Subject: Re: [PATCH RFC 3/5] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
Thread-Topic: [PATCH RFC 3/5] nvme: pci: use admin queue timeout over
 NVME_ADMIN_TIMEOUT
Thread-Index: AQHcoNgDoVzHBwjik0KdrJ9CsX/SPA==
Date: Wed, 18 Feb 2026 13:10:55 +0000
Message-ID: <20260218-crepe-bambino-1b6d82d0@mheyne-amazon>
References: <20260212120951.79738-1-mlombard@redhat.com>
 <20260212120951.79738-4-mlombard@redhat.com>
In-Reply-To: <20260212120951.79738-4-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.253.68.42]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <000346637A0F1B4EBCDFF3C7B0E5B832@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260218_051102_565014_E426251F 
X-CRM114-Status: GOOD (  16.34  )
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

On Thu, Feb 12, 2026 at 01:09:49PM +0100, Maurizio Lombardi wrote:
> From: David Jeffery <djeffery@redhat.com>
> =

> While tearing down its queues, nvme-pci uses NVME_ADMIN_TIMEOUT as its
> timeout target. Instead, use the configured admin queue's timeout value
> when available to match the device's existing timeout setting.
> =

> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 58f3097888a7..853cd57e4480 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2911,9 +2911,10 @@ static bool __nvme_delete_io_queues(struct nvme_de=
v *dev, u8 opcode)
>  {
>  	int nr_queues =3D dev->online_queues - 1, sent =3D 0;
>  	unsigned long timeout;
> +	struct request_queue *q =3D dev->ctrl.admin_q;
>  =

>   retry:
> -	timeout =3D NVME_ADMIN_TIMEOUT;
> +	timeout =3D q ? q->rq_timeout : NVME_ADMIN_TIMEOUT;

Skimming over the code I think the check is unnecessary since
ctrl.admin_q is only changed in nvme_alloc_admin_tag_set. Only when this
succeeds, we'll setup io queues. When they get deleted we will still
have the ctrl.admin_q being valid.

>  	while (nr_queues > 0) {
>  		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
>  			break;
> -- =

> 2.53.0
> =

> =




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


