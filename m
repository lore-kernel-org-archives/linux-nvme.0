Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD95C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:09:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D0264F60
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D0264F60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=EZxMsbANBYx2IC0Xlg0IhjTzYoB1hb8eAfbkr5oqBQ8=; b=YuctjLAA2p8dCQz7/c+kpibkv
	8lQlKKLdg9mPDmf6fSAzBfwhzKDKtQZQaXOmr3/dgGm7912kE6D+AM4ZpM9WWrz8sr3YN7sFweUuZ
	DLzbs2jvgcUdvcxSXO8AVtfv9miRyaLuqJpOXCicIjKVPkeSoMLG6A+RJHoMS/uHFeoaEzQMxlcTw
	cNBnGMBJe/4QPcYtQ00dOAwF7apie5VD6kD1iNM5k2RYcAiCUbiz97c0fCd9a7WVAm+YUmUfkud/W
	+uYrvvQSslmeUo3y/otaVvX5mM4m8b2JMnRLfgzZo7/tWqVr8OX3t0LVb6XZBNDXH3ZM6roGh5SW8
	FGqQX5Tog==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKDZA-008Nom-Vr; Thu, 11 Mar 2021 05:08:57 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKDZ5-008NoF-PP
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:08:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615439331; x=1646975331;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zp707FDG/FS8pQKECoK7l0NPZkKq96483Ew+WAhUNco=;
 b=Gm/1IueEbX1G9H1U0BFAg5GaT9XNSF+G6yy5PbFNTJF7D+aTzqAfQba5
 a9Zl81nnQnYss9qy7IAL5LCNXhdkOkE92ShE6rOQYnU2k/wAFi0IUmF4I
 9440DlMeuVaNw8AKa2sONwr0cKIJGPze5lYEkLJ4yuDyIv48UfnGUv0D6
 NohkmduJ9cJs4pGfFlJFarB5AE2Ef7poM+kRz1b22amKauB2LXvLp3TWh
 3QLxwggugfvPKSdch7UejmwGsZ6AB+AAQWxrFj/WZg5cbQVlYKfRslA/L
 ken0ITuzwZFer2Dr2IdM85Kz/EA0/rBggRsaWVB28KB9mGLIM/4cV4GVA g==;
IronPort-SDR: PvmcS5hE6hegZWuAz55UBn9WKS1mLDxBSotuKQJ3T1MTPgrPT+n6piJreYiRLnPIKO1AxwJJVx
 O/tRsZ7VTD6ZYILExbqLGqeb8Zkg8wKrirVWbII1nwICNuynOmB0AhVeQKlpShbcldPPtv4by8
 UNt9GRv4k3zBp8AL5co6Q4ujxj4TW5aR/dqc/y+EMRhUuOh4HH8sAAQHhEzR/VCmDEtsgiHTqe
 FPcKfoy9qVcbrPz4Td6LqxVXXtBj0F3A2cyTCH+LwsMwqu7G4D+Ipz2dn/D5S8U1GDmuNKwcbb
 9HQ=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="166380582"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 13:08:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0cw2vqgTSH0fgPOvoxkKIcU/mUUDWKe1EP2K8LAEFK+yFCJgltXJokXsUjjjAWfM0RQvrq2QMiRk6gZMUTcRqpVXrw1CTA3Elw1Cf+PciRZ0jQXXuFP+8QFxOly4kDqGdXB4eZJ7jjs+aSXD1EnGD4Pj4F3k6ICp+NcVCGYLp/PfaivXzIg9k3QcXeq00DFqrhNWUNcNFtrf5dGuQAfTQvSkc6Htg+YBleOVJrKqelSKWEk4y8Bzg76r/pGz73HWcxkM+5cGEznztVkHT4kZEdECIJibnX+pp+5vwfOIixZM31+Hlop3SGFz1XgIEe6efYw+78IFDhWKCubT0zc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSqE9Sxiloagyl4IMCEQTmVMrWxbq3fY916kRK+Biz4=;
 b=aDrvyr+bc4HarIhOykqSmb5YHMaW6KEzulU6CYiVQbFb2AXvCCYuEkjPQXG7RkWsxOXrz2Bpe9VUWw5roII4DNaVlobmu7PTCgFWQucV7dZkwKeSVmB06m09iMZ4RR70sHfef83s0U8TSUjD/xA7MBkjSwH0aSPhGYXgcjka2lou/XLIVEAncpU/fOauiVQfi/Eh/oMbQ2IBqFK8zpyJ7k5kq7kAWWjnPn86r5DRMBJk5PhrjtmQzX8wcw0A65NKaX21STYRkvOHmKW+cDReUXVL0m+MO5k+/8cxJyQrjAlKs12jd5Fp9YO3X+exCohqk66bCJZGI+MNvXTL6FDfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSqE9Sxiloagyl4IMCEQTmVMrWxbq3fY916kRK+Biz4=;
 b=Gvh5XIGluLh7PLqZUoVTymZ+aIh/FPGHEWwwAUfQeGFAPVsMIEgpGipS1cox59pxCzRLelCcJDj6yIDDHhpdyB+u7cvqgL6Mgj+7tCZNr8NHieIVk9l8cm9e3/txbpyWj5dHV1lqzmkog56Sn3lIutJNjgdIKC/IWI3urwGy/10=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (52.135.46.87) by
 BL0PR04MB5060.namprd04.prod.outlook.com (52.132.26.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.27; Thu, 11 Mar 2021 05:08:46 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3912.026; Thu, 11 Mar 2021
 05:08:46 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 4/4] nvme: add comments to nvme_zns_alloc_report_buffer
Thread-Topic: [PATCH V11 4/4] nvme: add comments to
 nvme_zns_alloc_report_buffer
Thread-Index: AQHXFjCXZNH2vH6kvU+hMx8DU9+2GQ==
Date: Thu, 11 Mar 2021 05:08:45 +0000
Message-ID: <BL0PR04MB6514516766FD5F343D4415AEE7909@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c1a6:aaec:6201:ec23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d2f8b23-d343-4f95-0d2b-08d8e44bbf91
x-ms-traffictypediagnostic: BL0PR04MB5060:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB5060B279F9DFE018DA061959E7909@BL0PR04MB5060.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkrlpOLclCaiuj27AngB1LzojvDclDAWzNbTHHEVajBCdXLusgYnM9wuvAJ0WRhY52QFhsv6cYtdpxA40Is7aOuexeShr/eHl69dtLlG2QTiDh8xhVclqDrO09xucMeJWR6l37haYy2NC0VoxLgKH/+GLuL1/Xx8RQNuBlZEBzhrG6GB3JVEZq0jwnCGd7M+TRfoLvSbbCBzcVCc1mQCRlf6UxILqHVpOGbGp6FBLjgE20YXJcHBjvW/8sJJ3+h4fMfjgYXgThaymg/cEBgq2mcKrwEUM2BKE+9e1DBrrg2hVjgakEbBs4+7H6XySrzJQhoL2KAEjCrGnhgkdifxk9Q4dQw7G5d5zmE3ZWvrItmRlP5QTjqoSE/yLuNEe0P097OnYQkr5T9Ma76gk1+NtjqgwPJRACfs7neQYtOHFBEhqq0jXthhO7oMbslggGNL+NecqhrJf8tdFDL43fXpu0FAPrz0O0cCth/UKknndT/S47iIRPrExs+U/qZu5r6tTGxakFNxd1HbeYckvuUAX51+DPuUSfAyti9taiaVFrydzHiUEvBr2oArRViZIxL2
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(4326008)(186003)(8936002)(9686003)(52536014)(55016002)(33656002)(478600001)(53546011)(86362001)(8676002)(6506007)(7696005)(83380400001)(54906003)(110136005)(316002)(66446008)(2906002)(76116006)(66476007)(71200400001)(66556008)(5660300002)(91956017)(66946007)(64756008)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?i4YCc3gn+aLif6uXP04/k7xa8FcCbsupZ3WnMTE1ON8ENsqxpsu3e+SEP8ei?=
 =?us-ascii?Q?HQ02Bvp2kaiwNrm8pI1T31sCZVCYmub4yJEYN5ZvODqs/4/g44rYXqTDW+yK?=
 =?us-ascii?Q?TKXjc/5c4YCfjgaSppmloiSqcRbvGy5axCmHP3Yn0KSJXo6NlOzBbQIjbvkN?=
 =?us-ascii?Q?X7gjYf/Vyp3T5z9H2Vr8bx1QONuk0vc1dSmLSp1LvLYgZFT+ssykz9dtFizs?=
 =?us-ascii?Q?VY9mcxl7U82hIddZamsDvbAf/3H9MkvmvylwMEZUIuJmmLt3D5gYErU+sDri?=
 =?us-ascii?Q?0I6KAgZW0v+bVXPGoRqhfViOYmQtyomwrqpgDZ2NItPQ/c3cCjKPE3oHWvdh?=
 =?us-ascii?Q?Wop3BzTqxWON1+gmuqUd3gNWdFdT14Dny7dp0UzN3PBikcls1xdbIeLjq1JN?=
 =?us-ascii?Q?BF9R0My7jQB2a9vxe9J3cI/Z9oGfy6Q3n88wGZNRiCZyYsI0wAfy5ZPqdQHx?=
 =?us-ascii?Q?99gxPn+p9IlDW/FE4sJV37fFtxS0Bp/diMUgl18xKa9Tf4pnCnlSOd+qnuXw?=
 =?us-ascii?Q?DwSV1fmAlI0b7LxhhsjTuT+Z5JkROQcx4nEGQqanMBJ1jnugDcEMHwmey+Yu?=
 =?us-ascii?Q?qEqcoaHo+HRNegA//6NoavdySnTBSybvLoqRhrlWY6tenWDEGtuA4GShSBdg?=
 =?us-ascii?Q?N/rHyC2QTmbU+p9H2ODjiRJEXnW6nrk6ztp5pYg5+lS9oYExaqkdDHEXXmGR?=
 =?us-ascii?Q?7Ka7Igt3BJYV6dzKVgbZr4+n0hfQu3s+raZZEP1xRhBNeCVnFPtJAuti76rg?=
 =?us-ascii?Q?YNrnzHYA7dAY6xItjWA6LwUptucLzjjnFbFF1TPdVkEEmMzIReZah4ffNuSE?=
 =?us-ascii?Q?sW1gac5ytsTFxCXmjvcLj/uG3iyyeL5DBNPoWj64QfOCzT7db4xOBAU85Iz9?=
 =?us-ascii?Q?AxH4Uws2lSdR6CeyGTDp4ZKAVemVE4IPz7rQfExvCH2C6fcJeNImYA5P3qQV?=
 =?us-ascii?Q?mctbxrdn+5cdK404n+BVjI8bFVhyQ9IRBVZBLC6kvI96y6vFaosTfbbKQN8B?=
 =?us-ascii?Q?hnM4ShiXAmfyGNtQIwhcKtcJ/VfeKQLDV1YcgjphfWmrPKmcbKo7sbWL1qQV?=
 =?us-ascii?Q?+shxUbSlAa7Tn7rF9Q8MsoaZ3Y/gssMsRuxVukZqr4uPSYFc6tnCcn1NCWaf?=
 =?us-ascii?Q?fPUv3lFB/gn1CLbrLaLUOXCDikFFjzUNCvV89SQRkWDbsYQwteejwsQh+ko7?=
 =?us-ascii?Q?+2Gw2r+I7AVZ8xxH9KxauTduoIOvJKD5kcwLSPk1T0FLbrwufYnEgCRGjz0r?=
 =?us-ascii?Q?2ujjc4wDHZO0JxyuKSJnVfWOfOkmSzUyNYSyebP9LIVWTECFhYN3wJxn26CX?=
 =?us-ascii?Q?3cGOyz0v7XQmPIBCkGc96b00chNh7gy2N5yk79qW9eyXuTg7w9mj0ChK+6s+?=
 =?us-ascii?Q?WzgO4wW7bV9mtu8r3Zeip09w4c+UgBagsRryS9oC9AbtWq/k8A=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2f8b23-d343-4f95-0d2b-08d8e44bbf91
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 05:08:45.9773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Zl5zt53Or9VDoBYj7kBLf9ohdUYCYxuFzraQYpitWfyUBpvFRY3cTGmYgaqxVfGg0iFOvJ4Z0pMENyNIlAm+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_050852_176134_902D0670 
X-CRM114-Status: GOOD (  22.60  )
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

On 2021/03/11 13:39, Chaitanya Kulkarni wrote:
> The report zone buffer calculation is dependent nvme report zones
> header, nvme report zone descriptor and on the various block
> layer request queue attributes such as queue_max_hw_sectors(),
> queue_max_segments(). These queue_XXX attributes are calculated on
> different ctrl values in the nvme-core.
> 
> Add clear comments about what values we are using and how they are
> calculated based on the controller's attributes.
> 
> This is needed since when referencing the code after long time it is not
> straight forward to understand how we calculate the buffer size given
> that there are variables and ctrl attributes involved.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/zns.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index bc2f344f0ae0..c2d08d9cc269 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -125,16 +125,38 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
>  	size_t bufsize;
>  	void *buf;
>  
> +	/*
> +	 * Set the minimum buffer size for report zone header and one zone
> +	 * descriptor.
> +	 */
>  	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
>  				   sizeof(struct nvme_zone_descriptor);

This seems unused. And not really useful anyway since if this function is being
called, it should be clear already that at least one zone can be reported, that
is, the report start sector is below capacity.

>  
> +	/*
> +	 * Recalculate the number of zones based on disk size of zone size.
> +	 */
>  	nr_zones = min_t(unsigned int, nr_zones,
>  			 get_capacity(ns->disk) >> ilog2(ns->zsze));
>  
> +	/*
> +	 * Calculate the buffer size based on the report zone header and number
> +	 * of zone descriptors are required for each zone.
> +	 */

This comment is not really useful.

>  	bufsize = sizeof(struct nvme_zone_report) +
>  		nr_zones * sizeof(struct nvme_zone_descriptor);
> +
> +	/*
> +	 * Recalculate and Limit the buffer size to queue max hw sectors. For
> +	 * NVMe queue max hw sectors are calcualted based on controller's
> +	 * Maximum Data Transfer Size (MDTS).
> +	 */

What combining this comment and the next into:

	/*
	 * Limit the buffer size to the maximum data transfer size and on
	 * the maximum number of segments allowed.
	 */

Simpler in my opinion.

>  	bufsize = min_t(size_t, bufsize,
>  			queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	/*
> +	 * Recalculate and Limit the buffer size to queue max segments. For
> +	 * NVMe queue max segments are calculated based on how many controller
> +	 * pages are needed to fit the max hw sectors.
> +	 */
>  	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
>  
>  	while (bufsize >= min_bufsize) {
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
