Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E0C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 18:59:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA247613F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 18:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA247613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MD5oVBFz7nsz7PnrdCYCAM1VXvp032nKPHMVIISXXvo=; b=oeTUf9t/ksEI4x9fP23jhULUP
	oH5smoko0aS6ZKV1QaVz8wn2Rlq2c8EEHwlmsXcWrINs7FV3TkWFSBv0pqiXEtX0Yydr9hDD5zPBL
	QlK6jwduVxYiw3WWzG0MX6TYsEaD7Pi7y57YxhqEUX8eXEkkUTyzZy06WD4vLO562S6OfqnWngjpK
	WMhetYPVXt6Z8u7UQ1/D8PcLD1Zp2wAfAKQF/hLXUvmuUYoryLsxBPf/J5wYh6YlqG3LcPS1p2F/9
	aMookcxRIgY8NbAMrcJCoMUxBt0EK5FEo8i7xFk/IDBv25QYJo3COXlu97aoh6hQFM9JHRxZ2y10t
	VCaQcSiJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llFmv-001Zad-4C; Mon, 24 May 2021 18:58:53 +0000
Received: from mail-mw2nam08on2061.outbound.protection.outlook.com
 ([40.107.101.61] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1llBhS-000ztT-TE
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 14:37:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVrr22HXWC/mZ3Y2qsZnAIwNEYms6cn31nGNb9ZQ4VM8aaCmRYps2Y6AbaWiQDxFa/2S07fUko6jVNLzIlNkUO3KEgRYKo0CTqORT6Nn5PtJwuBsGQYILabM2++XtQG/gpBM8qMoOgJKJWLXl1APobRL99HZaPkJ1AJiza09LVevg2cFg2iBqsZ8jVcBHp6ziUvpCtH6k+9rpqnfluv0sVeU6XE/Pjj0SdblTeQIl1L6+25J+Gz8593gSKebNVWh1EEow07KydiKIuXhgt/f6VM9FBZ3/XDHKz+2wXg9KnYF2wQgRPNgWGtGwYAnh2Lkxp1OnqnPtvOblZ4z1+1LFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtDTPEGb1J845xc52GEsKcfGqOiH5xMxltKmGa+/QZ8=;
 b=I1oIwb0YZqpSXp3k7QUQiSq2ggRDU+aQOnxKxhTK3jqsHqVPcUniLWgsl08fPYbfEGtwx1oFR++XAB7VsbhBRYywy2ByBkws/P3oxnHQ1NkgKDy1ccnjce49UsPIt/IAegJ9dvY4hITOUFBEIolxHH9KZsOLFzj1QpkG49hWk972sTi3V/e2qjHEjzXdJzHXFXkeGI+BkIweN7e6+kyDV/ltlkrWw/pmH0RxL92MfPwGYn/qLOaClsLUYfisXyGA5utTTIoM1MmZa8WNu24Ap7Sj487JrSPIt8EanlXSIH1zpO8nFsd5+7GcIrhuUwRyl/DPCyNFd5nMSl53zsOeHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtDTPEGb1J845xc52GEsKcfGqOiH5xMxltKmGa+/QZ8=;
 b=lipTL9yJapAX0oFV4rei92P+5TuwxvaQGdn3W4gRVaq7hpSZ4mfAevLbo4B/rJU6kNtNpiYjnUINU1jYqSyrMqsYIZLLRwspqSKpkmUF2AaJ1UaKg2gj+I8haPJf+W0beTNMiPaUVJ5Q8LKu7iAHbcC4vqnmfQ95AudnR8QBo5hEdyX68LRRxC2Mku4zag2EvXM1X7N9JSmBDdEUjJcDUsNdD5MbTJWAFkC5x1rRi+H6MwlJc9QfnxI3oYKIZb84syDFePF2p9PyXz28wZuXLJ5umkG2He7ArqnwI4b2mXxyrrUfKu/P+TBv1ejSzcDI5zIkgByIXIbdxtSHIGYjQg==
Received: from DS7PR03CA0180.namprd03.prod.outlook.com (2603:10b6:5:3b2::35)
 by BYAPR12MB3301.namprd12.prod.outlook.com (2603:10b6:a03:130::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Mon, 24 May
 2021 14:36:51 +0000
Received: from DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::8c) by DS7PR03CA0180.outlook.office365.com
 (2603:10b6:5:3b2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Mon, 24 May 2021 14:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT058.mail.protection.outlook.com (10.13.172.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Mon, 24 May 2021 14:36:50 +0000
Received: from [172.27.15.6] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 24 May
 2021 14:36:49 +0000
Subject: Re: [PATCH] nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20210521215115.1901970-1-sagi@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <8bbb3207-819a-464a-47f4-723a217bdc27@nvidia.com>
Date: Mon, 24 May 2021 17:36:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521215115.1901970-1-sagi@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63e6fd6c-8415-40ed-34f0-08d91ec15e62
X-MS-TrafficTypeDiagnostic: BYAPR12MB3301:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3301F49C68B79CC9EBF530ACDE269@BYAPR12MB3301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:165;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YP67NTtiCkj/Te6orVkGqTZvIwCwpH1Nzk43DtAHSHZuZ8EZgY3eauaxDrfMjrGwfPDUWg+uOnP8/xj1vh+wtc7zVYTRoFp3HqWd/yj20tbhLVR2OaDr4HrzoMP1CuiKSW/RvphKORM0/KfxF95ZUqlX66MqdeqG/GDdI7Q5MVJ/PPiiCx5/9cU5XIacsedosf2h51UyFmgvvLCCG4FvAI2CyO2aDEsElE+nibwTqycL1WT+kBSuoSDR7NKNE34zDAFP+ANVvOEkDdNI5+OYbaHtVgifs33Rk2put69hpzKQpdymwI1W4YhpK1UZooAGzqKqSH6mNjCnEYJFEGIMT6Te0RQ7w9FJS7G/ZgEx1/TKFyByM9b9cl0+SLDVgv/2aahoXMeIu4bU1ZZeoOzoZYOgZuvY6fbI6FoL0jSr8wK4wP5vpbAvJxA7US6gfMpqJSGDl1tO1NTa2+YwdWeogpoLghBnEf1d3wrTvF9utPCJVKrTbhxZhr5CuLzgCIgbErLgDtHvLSq8uofhvFDVkQLj2l0/fv1f9/dxl3pyw1W+3RHcYLATE3KL+R3X/14DgVFKrxa2iyE6YcGSMAWaxVtL/F19NxZXafY6rKUBmsOpjpUERehwLaPqIvkoQROSNfgTHp/YolYCDKw+9qYYlzRfhpHq047+9/FV7VZ/ZE6UNpypG5Y8HgtVhPN1mz4s
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(86362001)(2616005)(47076005)(82740400003)(16576012)(36756003)(26005)(316002)(70586007)(70206006)(31686004)(4744005)(31696002)(8676002)(83380400001)(82310400003)(6666004)(53546011)(110136005)(336012)(8936002)(356005)(5660300002)(2906002)(16526019)(186003)(478600001)(36860700001)(36906005)(7636003)(426003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 14:36:50.9422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e6fd6c-8415-40ed-34f0-08d91ec15e62
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3301
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_073659_069272_75039388 
X-CRM114-Status: GOOD (  14.88  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 5/22/2021 12:51 AM, Sagi Grimberg wrote:
> We need to select NVME_CORE.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index a44d49d63968..c0826b3c617c 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -71,7 +71,7 @@ config NVME_FC
>   config NVME_TCP
>   	tristate "NVM Express over Fabrics TCP host driver"
>   	depends on INET
> -	depends on BLK_DEV_NVME
> +	select NVME_CORE
>   	select NVME_FABRICS
>   	select CRYPTO
>   	select CRYPTO_CRC32C

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
