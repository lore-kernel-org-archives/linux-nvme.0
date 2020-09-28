Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707B7C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:21:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA06721924
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 14:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RIhqluo3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TpfKTrzC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IzuSobcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA06721924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=crfpEBAWcSqW6EtX095sFGzDX9wVQPk1QWHItaVrK+I=; b=RIhqluo3dP3XsoiyHW6qdilPi
	TD7txadvxMjZ/WLPyI7kM/AiiEwVIjOZAjekF65s0Uww+wMzjZgDEQlWYSjThKnoW6XpMi7f0bTTe
	RDYyshchyBstxGzMlpMbx8pbpojuw8qyCYchPTWqssRPj3a1O2DsGaLES3WgFk8uYbhoBjZ/Nw9W/
	SBUX0LBGwOs/VKPr4CCB9Vk5bJfCeakOTPViRsyl42vsuOyLKHOZKeHhpYmMMPm6csGQ8/XCMdqJL
	KTLntcA3H4aFznDzxIQV9Ol0YC8fNcWVdx20FpKszRhdZKilovaWGbtf++P3qvwVTt7/wOtZ3ERf7
	LHaPO7j5A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMu1l-0002AB-B9; Mon, 28 Sep 2020 14:21:17 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMu1h-00028W-K6
 for linux-nvme@lists.infradead.org; Mon, 28 Sep 2020 14:21:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601302874; x=1632838874;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DxKTxHbzj+v1DjVCsiXzF+2n6zHdzt9Tpf5yWpngLIc=;
 b=TpfKTrzCCz3Uz/om3E1UOv6N2MeaXC3W25wIcJ5DEBuXy1H0yUEMXZiu
 QLPFGhdyCDHjZGE4o9iAtdUsvBkCTe2O7RTVdXkLYwZVDiIeZCFOs965l
 QhpBAJtOQ/lksVtfNKUoDAMnqT/SIwtTl2PY8frRw1QeleCaVbzcMbD4R
 kzLxZHIDfh0vEKqeBh3J8nhKgwHDf9ifZAQZ9spqeDB+lJ5QAe8Qp1FHe
 VzZfRpaoGSZxMSgFbWYawW+qQ0CEsW1plwoMh6cc+ygFDZmLsVa9I0V7s
 avOpUuSs6KsFy5fyI8AH0XnAqCTSP9aL7cQZdldfXOA3YYM6zlAPY5+nS Q==;
IronPort-SDR: 9cG8uk/eKdfrAHBwP1wbfaZWaCXobdDFig7AZ2xn9yaHiEaoTwFqW6bK/UfvRRP5qXQRm79RLh
 jDqOK1dFsYDPRrZEsGst9JCD3LypK0uZ15zK31+iiDD+TAZZq3UQZfY+Zi9pJEXTK6M6U0CEFR
 ffvdk3QY7jVHL53Ig1V+hM+orWZ2TswL9+KpZWd4llaoSNgXMm5AQbCixP3ljhEQ8SsHo4TWRf
 fwIM9KN/DZYXkUyK0LLHdpWP14BqL+xvlRw/sF0s/y+lcolN6HojrU++cqTrtiYN2Ds2kOX20R
 aj4=
X-IronPort-AV: E=Sophos;i="5.77,313,1596470400"; d="scan'208";a="148469381"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2020 22:21:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSHmVb/H7riNl1gQIqBkpvoHkO3RVruuXtQwibp5RU+cfTQsBHrUs6wcmIKCUDbkyXh6zT4qEXeW3LhTnh+RPPkrvi3/NZ0pKOwR5EYW8flydCLswW07uWwYB191r3n62I0ePpNJBE+oLVHUbpYuOV2hov5RAf28pxQ5PWhhSizJP2kFbgCr2UwzEt7cyyxZU0eb/oKaiYrZBRKqi2hKQ3MaUiXBxOIvtBEIK5l/UqpQcLKzs/AsnB1bHWXX2tABJqrh8p4JqDdSnwdnwqW30BeUwrV8O99/5enFNIKkrHw2DBEIJLpd5S2y6fZMAfWT3XMuKt7kkjVQVzkYJHVl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdF/OZWDN+cvhd5f+oV3MEfaKb5uv4G7gCD/MaxI8G0=;
 b=aVZdq0bZA6QQ6uJp+VGIR/XGmgGNn4QVYOZes4G04eof+as/61Amxzd+MwV7zDvIc8c4WZsq/HlY8SaD9X3h48NtHCA61+QdQoYrr0i8xphPdEsMfgdDVQWpTmHnlXk0qsW900RBk2uprVfnpX1OfOPi+WKiEgplEJoMoZJFnQClQCnGKcE2HuLkCcy1sViQtj41zvfFWkHAH6paHAb+m4htTQQsyJR+95adIxNzjGhm04BpwX10sHHqjBlsJAH/AsQJPYbA5M0a4/9HuPWpE7Wnam/HvtEa2Pc03avjDadl2lRz/3QuY9UkknPgVAE4dw1dGkTW2jeqnzUp4Njcpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdF/OZWDN+cvhd5f+oV3MEfaKb5uv4G7gCD/MaxI8G0=;
 b=IzuSobcGaZgVFhrYwZrf2MBpdyQG7yJIULl2h9gBjHXH1YvbYGuQFd2ETZbyp2gVvKSO9sTa8m1BdiHL/bnraGPpYi2ZCTx8poYeGk8b8aTCZlkmAN0AXw+5CvhepUYVNsSdF4h0vvZkkxUODwn583oFl/79l0bTnB69If9HYQw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3636.namprd04.prod.outlook.com (2603:10b6:910:91::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.26; Mon, 28 Sep
 2020 14:21:10 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:21:10 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/20] nvme: rename __nvme_revalidate_disk
Thread-Topic: [PATCH 06/20] nvme: rename __nvme_revalidate_disk
Thread-Index: AQHWlZPW0BjwMTyHE0uvH5ASReSbpg==
Date: Mon, 28 Sep 2020 14:21:10 +0000
Message-ID: <CY4PR04MB37519177478BDE3BA831A120E7350@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:809d:4e2f:7912:1e64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fdd68c5-81d0-4226-ced6-08d863b9bfb7
x-ms-traffictypediagnostic: CY4PR0401MB3636:
x-microsoft-antispam-prvs: <CY4PR0401MB363636912E18D3C27BED712CE7350@CY4PR0401MB3636.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oItC/BF1lmNoGqmw4GrNXgw+ZroRQcVJ+LagQbYVMjzE0fTzJ1xwnkwWts+LmhAu/q5uqDQ7AlWO7L2ZEw3xMFhKtJoV9XJvk8v/8rw4xuzeFaBs3t+zTBel3kepptX35Y0OgJBthdRKXf+hmohFumLvhmO3HA1ZMaOZyh2Sa4MxCDF5MaXZEef+BV5y7DxOg2mxzTpn03g2N6KAW04SWRz5+SmIIwuYZFvoPqrhR7oz3ZKCDRIrNVhB22hgbug0/p7jQo4NJbEayOtFO010wczM6gvIGMfSnQlrR76DTfPrvbXu62PD7Abb1EH8ORdAqOI6DDLEnrz++nsFZW5JJPtoHML95dm6gsKLUDhw/ptxI9poEq/G4UswnlC+YPJG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(2906002)(33656002)(52536014)(8676002)(9686003)(4326008)(55016002)(8936002)(6506007)(53546011)(316002)(83380400001)(5660300002)(186003)(110136005)(54906003)(478600001)(66476007)(66556008)(64756008)(91956017)(7696005)(86362001)(66446008)(66946007)(76116006)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: J1ExutMilZcEPRNq9REpvLB/PX1Rpa20pF2osnXf637/RPYmXuqX/9R90dAyzAz3BuH9Ze7ts8t8jrg1EmDhwcxqHEByzrR8MYpOwbzvy3S3W+1GZDxs5PtLzLJzJy1lvjJZu7XAobRP16bd0xC2+s6L7Wl2dammnI8ivf6/ty/eET2VmMKR8X2seLVdfVZPzO7U3hlcs/J1J7DEhXI7IrkcPlITFvzL1vhjfbfavNNzgTLs0ABpMG7oidODVTuNZNj/MWLBGYqGUFJaZ/JhOcRsM0RO6G/JxOZyRhRo1NJBOeTLQYXbJiQLa2sKdFj4NtyTE/gk0GKSbDFGBgG0jVXXIwZoblcGVtwmgfyXiOPGAnD1o5JiEiVFbguRD0RvlMrWfdsJ+gHhVgbxoySFuGQSvMDIhWTmlAdPJEWMS9GGXy44svtXCUg8FTV4tnvGVqeIt9HLDJ39qYCQOKIKjQY1Etn8fFUdE4xsLijt11uDo7mU0tDY2e3o2IiwI8meY1w69EZlD9G98rENWfPxpqh0FmHwXBG2+V4M+/Ln+89Z1LquV27vRfCm5UQfCrr2ZQ4l5hPR1GyhmyX63ZhLftMgalqmNCx+URvrpielbQKuF5s5nY2rUzf55+eEmmK1Nu+vBVYkbDUdATt+3jU13w3fFkCALmXMpEMamdD6QvcBrXtMnZt89g3Ho9u5VaKWDzGJee5M1KgMFnErfxIMHA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdd68c5-81d0-4226-ced6-08d863b9bfb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 14:21:10.8329 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTAWMoCd5i8bB/lQlsUlclkg0V0IJxKXe6m6xgtcNscWv9ECrzgk9VyCwL1HJ3hPF7Q8U9ZMKisMfyZtcJU0ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3636
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200928_102113_824895_B38BB7BA 
X-CRM114-Status: GOOD (  16.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/28 21:35, Christoph Hellwig wrote:
> Rename __nvme_revalidate_disk to nvme_update_ns_info and pass a
> namespace instead of the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c04043a94e6496..fede487f6e043f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2076,10 +2076,9 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	blk_queue_chunk_sectors(ns->queue, iob);
>  }
>  
> -static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
> +static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>  {
>  	unsigned lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
> -	struct nvme_ns *ns = disk->private_data;
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	int ret;
>  
> @@ -2141,7 +2140,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	}
>  
>  	nvme_set_chunk_sectors(ns, id);
> -	nvme_update_disk_info(disk, ns, id);
> +	nvme_update_disk_info(ns->disk, ns, id);
>  #ifdef CONFIG_NVME_MULTIPATH
>  	if (ns->head->disk) {
>  		nvme_update_disk_info(ns->head->disk, ns, id);
> @@ -2186,7 +2185,7 @@ static int nvme_validate_ns(struct nvme_ns *ns)
>  		goto free_id;
>  	}
>  
> -	ret = __nvme_revalidate_disk(ns->disk, id);
> +	ret = nvme_update_ns_info(ns, id);
>  free_id:
>  	kfree(id);
>  out:
> @@ -3933,7 +3932,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
>  	ns->disk = disk;
>  
> -	if (__nvme_revalidate_disk(disk, id))
> +	if (nvme_update_ns_info(ns, id))
>  		goto out_put_disk;
>  	if (blk_queue_is_zoned(ns->queue) && nvme_revalidate_zones(ns))
>  		goto out_put_disk;
> 

Looks good.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
