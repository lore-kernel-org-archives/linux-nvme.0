Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EBB4EB64DC
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Jul 2023 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g/XfaFa4JXlrec+gPC4cmzEJqTkvka5g58Ag230CcQs=; b=YC6lxEP2ZoIqEiVcr6G6mc6gXh
	EFotZCsPGAYPInMZuiwRTplsUnR47Sxva6uPa0PYmZymvcCIx7i0CUO+v98xY+YLtyqe0lMuShaTW
	/m5TaHOM/8ohMuHoYA1EeplRvtRpGcCofhcsVUElv455FX1UR+JB+/GbN6aFxHQ8Iq+oI0UOVFLgz
	w0GX/2VCESBpFGjZVqeWRYA5cAh0R0oe8ZFEg3FAPkUNuDJod7YpMWHDjqQO2+kU8ea6FGlMp7Uwg
	V1YO8Igpfc5RAmTzacN12iyjVvSCxU3bsEm/KXJTLpU33QB8MEFhDCffOzPXIrD0OFeQmdOp59UQc
	dQxCTd7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qKcIW-008Lri-1b;
	Sat, 15 Jul 2023 10:14:44 +0000
Received: from mail-bn8nam04on20713.outbound.protection.outlook.com ([2a01:111:f400:7e8d::713] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qKcIT-008Lr3-39
	for linux-nvme@lists.infradead.org;
	Sat, 15 Jul 2023 10:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7/iruCUYS2L2+IE1OQJYOubvJVM/ojpl/RaAo5UDDaz10ynSrHE9hH7N13+bs670xeg9NQqsoEr6nvqdwF+bwxe6/+XJKomCbqyNOMUpBJ3DrNaU85j0S26RKCSe5BkFTNh9wrS4v4b8qXcFMpZpWu1Tv+EZCK4Hd1PRPiU+gHlqQ4u85nDHJcrtk5Y9Rtkzgo75mUwnn/BYcC/oz/SdypySyqnHqXer8gZJddlexZsQLM93nTR7+PYbXKG7sCyURRJeHPWx1TMwQ8JXSgNM1QV0JAJGJ1x12auCDDwjM7GgSc4SnTP1nRekMczeYPMlr3YXK0oML+bQyFx0UHsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/XfaFa4JXlrec+gPC4cmzEJqTkvka5g58Ag230CcQs=;
 b=dkW8A4ueVNX18TWaPC2Qel6Jwts75eFGtC0+IALVyqAJfht+Qk0iRrzhg7Ba027pK/+cgmBwkO63EAAp1e//Vu5ey9Gdz6Ip9xXu8Ya5oBfInd3VSjut5RRplQzSFP/CN3y6uKHrzn16ArIOVJYZjV2NM7hbpYsxm8PntNeTSACRNWzUtp/tLiQg3F/as65LLEMXe+mLRvDCMMQsjvcBl1oCEsIqxIgjS0WPoV/K2SPqALPVn+h26pbZZV9JeAb0sSimRUXqvDDx1MMOiTaKzCwhE+dTsb8e+2bR/H2AdxLPB7y8eg+1sGJTpdPz+w/pCS911VtTuuF1dkLvu2GcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/XfaFa4JXlrec+gPC4cmzEJqTkvka5g58Ag230CcQs=;
 b=ejlU9DwduXhofwrDGvpgl8Z8IlOa31uf+LcgbMblOQDaQY4mxkt/F3W9zBvfwF1Dl/6eKbHtIlrewACVhBaRO9cQCyAUiG2u/t7RCkKC99vB5nDRZbNdZkW2tbE56q6gx8PXXXTFnlIi8fG0Mj9OEGiwsKhhNZKjS26BZrNZ1bU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SN4PR13MB5694.namprd13.prod.outlook.com (2603:10b6:806:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Sat, 15 Jul
 2023 10:14:29 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:14:29 +0000
Date: Sat, 15 Jul 2023 11:14:21 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 03/26] net/ethtool: add ULP_DDP_{GET,SET} operations
 for caps and stats
Message-ID: <ZLJxfcKFwGN24jEP@corigine.com>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-4-aaptel@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712161513.134860-4-aaptel@nvidia.com>
X-ClientProxiedBy: LO4P123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::21) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SN4PR13MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f197f35-dca4-48b7-5dee-08db851c4630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: deTRKiUmYNxh4IHswREuJDMP9bYjcJTWU/ML1vyiZVo0HdLjpPzylLBuo/28wPHPL80mkD7fbhLSmtevUGy8m+gvk73Q7QmwbTfU+J6OAlDtGsil9tMONtcAuiwCR8QaYjovIqH8FiDkz87CgxgEdwzOLXQXlmwjtjCENTnI3X8uWOck2Sk5a3KjVRioMiOFNBHSoI09R9Qinx6ErGlr8qOr6e+M6c/c9OULXCklNsxFHoo+mvWQGxjZkyt9f3PZtxEWBJJ/Q45ASSSkmnYB7G87ymNaCFPSTA3JWJrw5uB+zBeW/gYHdSCag/wHX3xbBZTU2+SmbNtug8CSylzbTUPkKXV9TCuBEjBo/RtsGF9I0P1LtzqqwWEsrUYjEXYeFrir6xVR5ZZjyzmruvSXOtGDU8XUllg1s7EgeqO5nmXpNq9ZMdGbNLYe2HksSz0tGu3t2Q3bLwQNayxYTzqzddXtoplXZcdU7lfhv92mYi42nOPy5xe5yCuczb04Oym8viDmKTqSg6kFpQJQEAUTgpEm1DJN+r8jtt0JpnVfPqb/nZ2HtFJwPaip0jXn8dn83WzXT46/MHQ7XALbNRHzaunslHsWXhjvWtYfBkNiK1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39830400003)(451199021)(4744005)(2906002)(2616005)(86362001)(36756003)(38100700002)(316002)(4326008)(41300700001)(6916009)(66556008)(66476007)(66946007)(26005)(186003)(478600001)(6512007)(6486002)(44832011)(6666004)(6506007)(8676002)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hZhaWudhmVdYx+/IzN1eEypT/D6FZiRiwIPi1G/D/qqtdJATf/EFX7am2FIs?=
 =?us-ascii?Q?tVQ3WwV9kfTjncQkv6rrz8EzOkOuoFjSTKYqR9ZgNPwHGu08jNsfTRtkg4r0?=
 =?us-ascii?Q?auiPi040T0rI1Aa1BHd3GZ3+xbw4EsRMmhpfX7Y0p7BLsa5aP/uyVizidsSu?=
 =?us-ascii?Q?/6JSi9RLAjsnwgl3VdXzi6H87deqO6y6Us6iew02cONNlia7nLO69hbCWehK?=
 =?us-ascii?Q?+hni6/eFqdelC8joO6N14V5+DtM1zTyG2rVcC6E4d4HSw2VpvNImUuUgGa5d?=
 =?us-ascii?Q?YHSXq+z8s7boAtmZoqNUufmjMNZVVHZcuSIsFtuy5k+iEbnCarnFbRLkNecz?=
 =?us-ascii?Q?57594pWv0Gv4fuoWNb8F7ZqPnb2kEUW6ulgpt51l5Seeg8kOs1KD35Gh1E2C?=
 =?us-ascii?Q?gE5RJsSV59BjOvMBSNOP8PByd8SbfxFUoi8lekHBdgOcPrWpbv4Sd6Xvb8in?=
 =?us-ascii?Q?chdEG/vISEdz09WCMN5bKlGWqxaKbjE4fZVTkKMdPpIe8ch0ADvaAWfcKl6M?=
 =?us-ascii?Q?gKJMcZ8pqRxzgpPPo2m7enIH2ERLNURlUpFL5npUvHSknPSrz0hwojEbhSeg?=
 =?us-ascii?Q?JIWtfdYxqTPgGWQxdcHFC7rJiNTbuoDhD++7mEcdYZO4hgSxV3AmksRI4el0?=
 =?us-ascii?Q?+5x+zaAujgqRQbs0kP5EbIplKwjsKjMcoKAWIqb+UDy17pSTJm6MWkEs/ZyT?=
 =?us-ascii?Q?om3wLno9jXQCVhsknrvsTJYYUBiuz2sDD79P+t4mAZ+0mLGdB0WdtJGZWcND?=
 =?us-ascii?Q?nG3XCDWJ6ZOp0lrCZ6JeZ1TJ3VVYQrTdvDDP9Jm+zutPVtdpAwk8Q0r5KLRH?=
 =?us-ascii?Q?J5yBOS2DeK7XqETsOznGMMyufHvrRl5t1xB3g3QCs4H9HC5cT9DMI8TVeZhv?=
 =?us-ascii?Q?4pn4+CozVcIdWVIajSE9nTWMBy2EBSs21cIzuDMbuTbTnN8lryuomiBKD3vo?=
 =?us-ascii?Q?zhb7c4NCAw76lnTGaz1PCvj6n48mD8WRpuDXkWFokkMB1fbHRfPt2r+rOv0i?=
 =?us-ascii?Q?4Q+seaNjsf/yqnD7H1dZrrzddIbhHPvN/9mnyckpGM+QM7Q9ec/QQrV9//wC?=
 =?us-ascii?Q?aYIQNTXdaxUFBexVWMkTnYZNP+dGEoKRirHQf9rScxC9XvB2gQ8HBKe5iI5o?=
 =?us-ascii?Q?OIQLyxh+U9N1gFnz7YY9lQfZMlpoB6Qlet7lPvhLLSvEgTTfKxd6y8G8+gb3?=
 =?us-ascii?Q?yCYqNji7MosCtPAuit1JTz0GtKcB/b2LTd2IXclCh1gjqQGfNa5AD1MfJtUX?=
 =?us-ascii?Q?Z+FFdbfAEAL62O6+jNNUOIn64cOHkGuehkBadJfXzZIzSj9w8Hm7yzDzQ3AE?=
 =?us-ascii?Q?uoOViSUAObfsObxvqEn9cB5WieNuM4fCcawUqkKaEJjuvygK+r5/K74oHdBN?=
 =?us-ascii?Q?3hTp3lwrUAuiSe7PxBj0Srwd8Wx2FyL+SV3fKmJxGZ34iBTDYU5SIJqr5at4?=
 =?us-ascii?Q?BadBkVHmv0NQffVaUEEZPY3WgQ2l+lU27GqnFlR3/1e4MUEKmMslrRsZquma?=
 =?us-ascii?Q?UXv+6iTzhajqTnFM0/1y9+m0l9A3yWc0vdVDU8a0AQLgOVWEahkdoaFPp3TY?=
 =?us-ascii?Q?lpFLbRBtI/5ZX0/CaB7uWFvlUEWbpWqCl1ebMEwN5++xbHk8D7Fc4YNjNJZF?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f197f35-dca4-48b7-5dee-08db851c4630
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:14:28.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hH/gtpwByMtT7tdTjHvwBRPGg8PLKQ+en7hNPU1HuwjAETGbZPcbVfmhBvWP92taEK9Mzw1mwE3pV19sup1mHtLvUvouZ1ayF4mCrh3o6/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR13MB5694
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230715_031442_037506_36AC32B2 
X-CRM114-Status: UNSURE (   9.06  )
X-CRM114-Notice: Please train this message.
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

On Wed, Jul 12, 2023 at 04:14:50PM +0000, Aurelien Aptel wrote:

...

> diff --git a/net/ethtool/ulp_ddp.c b/net/ethtool/ulp_ddp.c
> new file mode 100644
> index 000000000000..e5451689fef9
> --- /dev/null
> +++ b/net/ethtool/ulp_ddp.c

...

> +static int ulp_ddp_put_stats64(struct sk_buff *skb, int attrtype, const u64 *val,
> +			       unsigned int count)
> +{
> +	struct nlattr *nest;
> +	unsigned int i, attr;

nit: please use reverse xmas tree - longest line to shortest -
     for local variable declarations in Networking code.

