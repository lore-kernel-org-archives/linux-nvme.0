Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C4C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 23:07:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D2B64E2A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 23:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D2B64E2A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TpXukFhbCqQ8XMDV3gyr8FcwQaPL63HO15muK4gatH0=; b=rTEKwCAQ8M6lYRHyF/RkYjlwy
	fc0dOqlEdSBOmXmgpi52yrY+QTSv39FOpDcoDUA3gW1rneLLwrmStKEtHT5LhgO5yfFCdvnZatbzo
	fijZBFFVYwsmJcpM6veKkpyzDf4pCFDUoceo4299gLjaeSO1yWbibEAYVHByiHdgXjDLpfQ0UC8QQ
	PNqtrTvsYsI9P5jorrBzsZI+LY4DxR7mNqL7UhXULqcA4BSeiiJBd4oPy9xH4MUdOWHooeQyshLnS
	UesYoSJ3mtmCk6falIY39Vn1HBkRpA5O0DPqNSffxwqSOQjII4afoqvBHeVWitHIfZ7UEowYvI/8A
	//ANRV1pg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8t8k-00064X-V0; Sun, 07 Feb 2021 23:06:50 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8t8g-00064B-0W
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 23:06:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612739205; x=1644275205;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=sz65s+21TlT5cs8tLIsDvXiCKU/jarLfgFMnfWcjJVg=;
 b=TENchudT/H04Qoz29DqKn0FcTHHes9AuINB5g3anavPURrzYUESSGWL4
 OWTNbUwfyeuto2OjH5DtU/rlZU7xaFxRU+NZIwLyy5UE/SCrwktCF8ucH
 D3jcGRBRXXexzBDi0OKLRA1DFoV9Ds7Hmnmr10M534VkbA+6Tz/ibVEa9
 I9Gzgq1RlLqIWVZ1mRuIfXaTXkj+Ig5wzvpuiwuA1lb9LJoOYgKovjgwb
 UjbSFS9IsSyWZMTVIbIgWMM5wTpJJyAd3BuV7G7CZU8UvOPfuJLVAcef0
 K9ieYeLC1REBHfCdb5F6xMPFcwn41o1umxVF7rLnMFudUcxDXFyC8k8VA w==;
IronPort-SDR: aWLB3+q3sLwZ25EESLL1Nd1m8QgSi4NXNbV2WaxXAVHVHhPnaGWmOjlQBuriTx5iyDZijtZvAW
 DuRcg59uAT7tGin5O9994SoWqrNrq6nzQYeRsoMa+/8+G5aaGvCDGX/mtzASmQPwCi1/jckn9n
 lRnyiquAiISwLKiKTZoIN050+h3WFZUt08JMSjefqewFYG1iy5meBGFqR6dCbUkUmWt9jr/8z0
 ocQaV/jx4AirK1mYaY1NcC5MBdScZfYr7TwEsOUX/ac/G8P9pljENWfGTdNvA/cuNhNpPtTCxA
 MRo=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; d="scan'208";a="163861080"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
 by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 07:06:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEnwAZ0NcYrIWC6uy+e9gtykcb6jjp5FFuQ3AjTHx76QlnRcl0Sknxa21Ks4lE8UOrZDsGXYvj67qqdQGS9QHrSj2uFHpEkMQmLA40dHshGzg4jm7pq6cc1e8xXz99dg9Pf+RSizJuZ8Vh3KsMLPRWYiI2WEEN8qAQMwK3Mx1QZqLcHstEWolmbf0ajYDMg677gFSr5XjXjkuAgTdKQB953Gdp9oJaAxc1zlrLg+CJ74d2tSg4K2+fQBmWWOGMOU40Rmpvzafpl8/y+1B5X4beYL3e1A6svUHPHvMwbpc9kJ9PHtLAT+N57OQn+dMuy7rsmdZWaFmyzDlRmcZ6wNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C0A0OzslZ7lX8IhscPW9y550BNO0UrU/UK0MWV2ueE=;
 b=aIjFwX3NZhFPGna5D6tghjfGMKJF5uL5QIwxPBFJjK9LCcMQtO6tyIjLQ4Dt+XGEWebZxfln5uLf7VHzetBHqrYMe/kZAT61JEulHlh9Bg6hOurieCG1JO0mIXU16BiPfofoFvnJt1Z8i3xL6JStYb78BvpHjOaS7I/zCn6Mzpw05DWR6HBw7Gu8Qp/pE5DnVRgyL3zUXZr7Xd4eWLZAz0OV5ekwaKLtFLQ/KHJR4TwztkJPCOMSVWUkwvOtJeYoiPGq6ROT29iRfy2ho3gPxdC8Qazi6pB4MLEqDsD9cL4LIt8LJo8RHk3NHU3dxJIpfU2cVq+SOh7ntdsSyOrpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C0A0OzslZ7lX8IhscPW9y550BNO0UrU/UK0MWV2ueE=;
 b=tyKEd181sishOu56JMLEf9yzVwl97yJOHkmHtM2vjxIt1Om6fXd3wR5mpPdR6D0hRfTDakN7O9IKztjNAGL+ABAXR7+IkGS4j7lDeyCLtckx5xKIVHLFMf2zXOTkRZxCVAkvH5jFKzlQv+pDxPphRXp7pgvgE1yrJUi9HPIJKqA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6595.namprd04.prod.outlook.com (2603:10b6:208:1c5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Sun, 7 Feb
 2021 23:06:37 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3825.030; Sun, 7 Feb 2021
 23:06:36 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Thread-Topic: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Thread-Index: AQHW+/gdUltcG0/QqECHms/I6ixNvw==
Date: Sun, 7 Feb 2021 23:06:36 +0000
Message-ID: <BL0PR04MB65147CDC426FC6345B2048D7E7B09@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210205195002.2657209-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:9d22:7ad2:9f1a:e44a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 978ab76c-d5ed-42df-5758-08d8cbbd051d
x-ms-traffictypediagnostic: BL0PR04MB6595:
x-microsoft-antispam-prvs: <BL0PR04MB65953211AA22A7B1E097ED2CE7B09@BL0PR04MB6595.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uT/7t63y11qoiAlOw4oskhT4RTLKjDqSlbrKC2UurxFBMTAzHHUlgQeG70EVS8+i5GgNJJDGz4bkDm94UL6dVkaXyx/v9w+sM9QbjQIVEvkZBV04kBc+oQpjAyFTSpMGrw/2T6Gw6PMPzjEWeW5rJlYJWRY/xFK/KJaHObaHtEDqIm4j+2LmYx7IkzqQH6Al+7+OAPSxaRPh/jptVFM7NcUJ84cCDH9MGXSNc6cO/kgZCKtlTGJEboSq4LuEOtTbhgMlq6i/KC0L9VwaeobHqI4rcq0KESXoLYy5ZfmZB7tb83+lYjvZIJ2ib00Fcu6DEsl3NyV5Oz0st/GoAhOyoLIeRgDDTMwvVUmNw5hZr1KeTSEMOkS2aPK5wLiUwU0DgNgtqNsniQGUeihN1tXIgj4f1abEvVFoVcGQiwo1Sn0b8VtISITj0aq46LopQZNt5W+dScjy483l6hktNwSj9xP9QPdJkFZiN474g/Uv4VzNlvrS9XmHM8U/jDsEecgDC7jocbzS0Y2teAmtMBk0ow==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(186003)(110136005)(64756008)(33656002)(316002)(66476007)(53546011)(52536014)(478600001)(8936002)(83380400001)(76116006)(91956017)(6506007)(4326008)(7696005)(2906002)(5660300002)(66946007)(9686003)(86362001)(71200400001)(66446008)(55016002)(66556008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h4+eX/7byqXMwUSXiguY33CudGUuzfRK3ix4sMnrv3UZCr0O3ahTdgRqmCeC?=
 =?us-ascii?Q?Mc2gowM7e2hJmHNx81xT6AoyyQYOcVmW/vLrPNUUuuuLL6Ay6+7XUg41dzc2?=
 =?us-ascii?Q?t06jBZBaDn5XLkdnf/o4BwT6ZAit3l2m4hBI/QTWsvctrc5Ig6bq7jthgoyC?=
 =?us-ascii?Q?tbAwZf6ApnaSfSbS9VnY48xecO/273eGACBtq2u3O9CbhbwugK6GuAZaZNE1?=
 =?us-ascii?Q?GlhaRIRzyRi4NfQTgaWz9OZ9IlM6zfeqxNfLDchgu/2EoLNNWHCF75C41bI/?=
 =?us-ascii?Q?s6fpgxOrSaGa8vh+eAlg10Dq1YkDi+To5qrNQMQ2ZHKAja2J5i7lKVuvkOGv?=
 =?us-ascii?Q?M9RQE5eMp4Bs5zt6Mu+iafKf7xWkzRz2VWBv1a+MZnk6Ylcz/3xK0KrtM0TA?=
 =?us-ascii?Q?FbJQWk4tuwYoFpBJNOgjWvUB2S4F5/DQtCTz10uf87hnJy6EzhqPq71wKYHI?=
 =?us-ascii?Q?1UpjgJ5A5npLwGWRydp7EsJxVlymbYxNlPm674NQBFHZWq/HP9endvPSHZmJ?=
 =?us-ascii?Q?vhojcQAUJmHPxri3+4dX9Cdpj0XVxXqrTBMNZ9bwIw9xwxs/uIvdW1BI4q42?=
 =?us-ascii?Q?Qn0wjqPHwuNfoFO5oEYDNDFeyJaOCeaDSDiT8WldXj3w+TGLwZwMbDsUU2Fx?=
 =?us-ascii?Q?NPjYnqe8pPd1rHvfTQEmqUxulFv/iXhipDBMF5CqO68c/ahuzmvS+vYYWcvX?=
 =?us-ascii?Q?9tNcEtTEzmYFOpSg39Q/jOpIPWY1e5xFrWj0NMIFcW4Axlls3ee2QIwuU4yo?=
 =?us-ascii?Q?SZ1fPKV9kJM8l6dexbXfj6eon+QKsufRq/S7pUdCotZijlHFA/qK8idmSjay?=
 =?us-ascii?Q?cyQbqzwCXTxXZl/YoNb12Z1EDEjRxUOsV8x//yUN7zWl23uRVrJMuyNX9GL3?=
 =?us-ascii?Q?PmuuYfOxndBQxCI39iBWDaAdWqzVxfo82X8tXr++lHC99PUCyaF2O4L1+/tJ?=
 =?us-ascii?Q?NC6dOe+vrPACFEcDILf1tlNEeYRM6tb1yMLZ9EfiaJsBD8CBJh14LM6hRfEv?=
 =?us-ascii?Q?P4WjCGs7ntkg4HsbTr5EoHkkWzehPLHJ8iMK0KPRZgf8z+0l913D5ZgYPTsR?=
 =?us-ascii?Q?ltNpIm45MpemN7nkPQg/JZag1ags30zpBvtHJi2vNZYCWVXGko4/3yyoXYDF?=
 =?us-ascii?Q?mgIFriQRs+C8cyR479oEoGJiA5tFA8qwIOkDxT9fW+xcExSZk1M/LXzPQddW?=
 =?us-ascii?Q?KOHpP8aqNCOnUm9BlW1VvQ3h2ETOB4P8MTA1v6XHQUryTj3c18w/LBCiwK+1?=
 =?us-ascii?Q?qgvZRGIK8FoxBYr5ghkq6D0PXcw19gd6df372F2lpA/nssIOjbZEJbXu+QWS?=
 =?us-ascii?Q?vZwItyAaamVpkp3D5iRHrf1JHwFup28k7bSZieEnKVtqT7X3rd9aoXQSTfoi?=
 =?us-ascii?Q?ZzNmmjqA2xPiF517dyEHP7/Rr72nFWqFqYXyML9AdQnrbWdRnQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978ab76c-d5ed-42df-5758-08d8cbbd051d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 23:06:36.6219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RRgWasLFm5jStGhw2MpcXBpUn6818i+pRxPbIlaV7EJZesWt42Fgck1p7fDkRJKnDaPzMhhXgQ86QOdOqqQYGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6595
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_180647_192743_08BD073D 
X-CRM114-Status: GOOD (  12.98  )
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
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/02/06 4:50, Keith Busch wrote:
> The bio based drivers only require the request_queue's nr_zones is set,
> so set this field in the head if the namespace path is zoned.
> 
> Reported-by: Minwoo Im <minwoo.im.dev@gmail.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Shouldn't this have a Fixes tag ?

> ---
>  drivers/nvme/host/multipath.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 1427c9555cef..a1d476e1ac02 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -677,6 +677,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  	if (blk_queue_stable_writes(ns->queue) && ns->head->disk)
>  		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
>  				   ns->head->disk->queue);
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
> +		ns->head->disk->queue->nr_zones = ns->queue->nr_zones;
> +#endif

Is the zone model set already ? I have not checked...

>  }
>  
>  void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
