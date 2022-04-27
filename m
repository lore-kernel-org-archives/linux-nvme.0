Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB61C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1WG0VjZww1GRXMIGYZahPER2+XLYLQN9J5npafuJMJ4=; b=HxAQKkKBsSNqgMz/WAyQK2UVDQ
	mEaqicHyp9FvPPxsqC0YaaoIwlGKNlNu1ZX4G4F6PnDIqAeZWrqXQ5LaWLl9WEYHZai29xbF+ryR8
	apzNw2pS/BaslHVanuZmMyWpr+3T5Tw9pwx3d8Bcn7Gva2ntlxtFa1jm0B/gBX1Vgr+mKBQBkTbYY
	wzeHVzyXRW2UKjewWwwoR0iZvDAaStkxkCfrOjAH/kKg0vb65jefTpIQZy+fMuvtyv51v8VkWazXS
	QSMW00gJh50WLpHooif72oy6nByZU78M0qED2vbxAwOSzxWEgPxdlCBrzWvYT6pBS2CZwhPyI9deS
	XpH6k0ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njpn2-003j99-Gv; Wed, 27 Apr 2022 22:05:40 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njpmz-003j7P-36
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 22:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651097136; x=1682633136;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ltiub3iDq6D6Wb7M/70Y0VAAaW3D7ZlOojkFrPEHoeo=;
 b=ocKHGZrUuhJg99wQuDu05TQfqCRDNlzhfUF/SdVYGktL2AP85PrVK28j
 1+jp/qxT9H9EACV1QMd8kzBYYA8V2xaS2GVWpqTP/9h43kepLBml8pbzP
 yM6UfGX0LxdHUZI+klurJJOh/F95x7N9lZblnfx1ZMytNEjEqulI6SHaP
 tSFOjDMAMziHxSJp4U96jL+kiMZZcgSjkqbS0OLaT5p5oKByyI4O7VZu9
 dQoZGvxR2D7oiP1JN2gGSuDi9s4WlZFOTVZ8+0/YHOKlORRe9SBdZjMCK
 a6RxlbULkw4LCPcr0CapIqh+vVgtBPESQogEgSZ0ESwuGUZ/PzSgFPjZp g==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; d="scan'208";a="198996978"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 06:05:34 +0800
IronPort-SDR: smcrElssjhHmqlGvuqpVCNPr5ePY0C0koRDmCEdihFUK/+u+CIL/zjUItGuRxw4YRw6mqWL/ma
 xYyL7Hos+yHVjeWaSNd6I6wECnaFqsALI2N7l2QD3+VCLiO4hTSZjgp1pXlzogjLoeuQZv9JWI
 bhgwx/7O3pNYbv8AfrJE32+LHQho4Rsf7qAAp+tFQP2HGCNvGmQYCP3vWq8nFXvgTjSssHqH4o
 5JALyCSimnJP9UXg7LSCTOKDsKG5aWsvMYx1xoHvhW5EaMDhedW/yXlH3Cy8jgIFmIp0R+Z31b
 P/v1GhyIQ8Zl1L9AExxxt4Zb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 14:35:44 -0700
IronPort-SDR: W8nmOJ74ylZ0W1cR3+0MK8pz3bE2CwMLSHcOXrPgNDizExfnygoXvC21UWvhGBTovOatiCX4xm
 CBw8I8G9xTc9eak2/gT2JT1xHAmnQpaqmb2Ww7FEh8EEL7O7uKvwQwY2fjxrABJqIR1DLUmsR/
 G6E7ugeelMsu2suISMNZ1UA+//b0mgC6x9yS/X42qi4JhQ+ysHRKgJmiS8IbaO5BCDBWBiErrU
 mxeN19kmu4s5era6tCifWA2vvXFWzLreHDQEfzdoYvuRRLIH7jKzhq8kKmu1LwCqO9cXqE4sUs
 JKY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Apr 2022 15:05:35 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KpXqy6HMqz1SVny
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 15:05:34 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651097134; x=1653689135; bh=Ltiub3iDq6D6Wb7M/70Y0VAAaW3D7ZlOojk
 FrPEHoeo=; b=tf10gyOH0lx9kTAQMvmNEOqbTNS9DLTOZB9qsNe71qSj+MlslLY
 F2EMsRT1hYv8Uex+f8eyJX1V+hNKxnq0ZvLAwm2N9h1bKDM2qAdaXd8XFxq2OFtZ
 V4RlBXCG//INUr7wVIQqFsb2qymtVwVHXuxY8eD6UpYIYKBOcpCxEpfLcPWyOf+Z
 a1goiEri2UoD+WOlXIFCHSZYAnDDnYTLxwQ44EG/xQ6NBuYZ4KdX6hPN8R/IC8+K
 mjJuGAhmLtYWSzjRHY0sOUl5Yj3top3PIke6IkXYtsIwx8o7NXzckBhJqqv2uDvr
 xwDwWqUps86ht4CXLQyUclRDU1FKcwhVZrQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id bfYaHdWcqoUN for <linux-nvme@lists.infradead.org>;
 Wed, 27 Apr 2022 15:05:34 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KpXqx1gFtz1Rvlc;
 Wed, 27 Apr 2022 15:05:33 -0700 (PDT)
Message-ID: <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
Date: Thu, 28 Apr 2022 07:05:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427124951.GA9558@test-zns>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_150537_175528_8A9990F0 
X-CRM114-Status: GOOD (  14.67  )
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

On 4/27/22 21:49, Nitesh Shetty wrote:
> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>> The patch series covers the points discussed in November 2021 virtual=
 call
>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>> We have covered the Initial agreed requirements in this patchset.
>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>> implementation.
>>>
>>> Overall series supports =E2=80=93
>>>
>>> 1. Driver
>>> - NVMe Copy command (single NS), including support in nvme-target (fo=
r
>>>     block and file backend)
>>
>> It would also be nice to have copy offload emulation in null_blk for t=
esting.
>>
>=20
> We can plan this in next phase of copy support, once this series settle=
s down.

So how can people test your series ? Not a lot of drives out there with
copy support.

>=20
> --
> Nitesh Shetty
>=20
>=20


--=20
Damien Le Moal
Western Digital Research

