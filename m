Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A90DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 11:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZknF5RuzrNIfY2NEiU+L+AiU/Sxt2xaumobJgpTribY=; b=dAUQp6rk8VuLRuYDfys40d5mo4
	7Z84hpfxn1BSH/sq+roJj7ihCo5EfbdbqxoWVUsMQu+QpOnP/PHatg+CaF9tgnvNgJfva8UroSe7i
	1ZJZEs8czgtWb/mfwOYlQBH5IKDwdEFQAtSThpyusAhYRtNLmLUL5Wlp6RKEzQoTQbBy5uAfY4rd8
	mQrbXhhPafU+t/ksXticlYWaM+/gTWUGQ5ih8JS4+QO4hk43e2Eoi8J7d8XeuR4FX67F73TEaFAGR
	Oye9CouBNYvucrem/kfhzynsujRocLCAWlreYgAX9gusoF4+VUYMHK0JROntVd8IYrVqQVCL9pTjw
	qP0cGz+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7c0E-002KDv-Bj; Wed, 12 Jan 2022 11:41:18 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7c0B-002KDE-CW
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 11:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9s3qYdY/HyEdgrYTierBhgse+MqcPthFl/9/WuAjeEUFNUysfdQFF2QKcIbug0ACMlBLQuxd9Eh58mPOQwGiH/uYXPxAllfphZeBnd9J4vyShElikFn1slIwgNWejmZSDBBUpKnOBjS/2ipP8i9buKzAUc6fU4mkqqg8LsRN2ABzqZdImkpTqh0o/J/v0oYexq8GPs6bsse2+R/uWTE5hs7r7GfWRK7arTnivCBsVjusxKgKUvaQ6pV1Ut9lhH8fRaBzIr91i1AisNAGAMhpVHSgaTpC7vzU+yKUGhWrwOdcx0eUo/lPdzxrvvAb50DvRn5loZ0phBgsO7a7R0tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZknF5RuzrNIfY2NEiU+L+AiU/Sxt2xaumobJgpTribY=;
 b=QMf0H4nmypqcFaDn+ZdnNp0Wcb386lVHcBolqg/0Fqksxsh5TQbe1mCZv6VaKgntE316pkU76RB39MesDtClE9uRgjWIC/DbeQdlTKgxtRp+xzouvMhavRtssgtOExBD/qQThlHq0/nIN4kdkxoJrvm83S6fXw8/yXFKDM32Rp6cI2kSde8DjvekH4QiLaVEWDCTw+EufNcdFxnULNDswL2/iRAA0QarjIM2FWtf30m9XmfAWVpQw2XkRgWk6m5PutEMCiuFyqpesFHRnOziGQ8yGBvx7hX0ZLJLj+ZFTEqDR9tlkrvKyR2JTiq+TCelHL3h3PVTl7imAf75epPAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZknF5RuzrNIfY2NEiU+L+AiU/Sxt2xaumobJgpTribY=;
 b=NrdJUiMOwRlPemRgYYf2AydEII+khEJlwsW/eGkpGYEM8+kQl0aCxCOXtK3Jx8r03v601Mm7rYNHyYPZHrsh+/PjfZB64nqko07cXwXTNgAM+/IixehCXQZhmlavK9p/r+vgVvcNrQEfCykpiGkFn/Dh9czUJoB0EQSvOE/1tezz3NBfYR0RI82Ubw+TijDc+tuk4dOX5fg8gtYAyDGgtoCygmXBFLYR54eBg+WfSWkbo4lI5qkMpRObp1Exvo4aj5hKelL2ZdzErDuVRKftsKLWEbvWmkYy4u2LFiUFknMx5tcg2lCIsYzYLn1B6lRyq6F0G14VKTiuiYVoRtV1BA==
Received: from DM3PR14CA0130.namprd14.prod.outlook.com (2603:10b6:0:53::14) by
 BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.9; Wed, 12 Jan 2022 11:41:12 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::9f) by DM3PR14CA0130.outlook.office365.com
 (2603:10b6:0:53::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 12 Jan 2022 11:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Wed, 12 Jan 2022 11:41:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 12 Jan 2022 11:41:10 +0000
Received: from [172.27.12.140] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Wed, 12 Jan 2022
 03:41:09 -0800
Message-ID: <ee28429b-27a3-6921-a2c3-face671d1f63@nvidia.com>
Date: Wed, 12 Jan 2022 13:41:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/5] nvme-fabrics: use unsigned int type
Content-Language: en-US
To: <linux-nvme@lists.infradead.org>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-4-chaitanyak@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220112062101.90102-4-chaitanyak@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e4b3b9a-5601-4259-8116-08d9d5c06eac
X-MS-TrafficTypeDiagnostic: BY5PR12MB4308:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4308BE94B92E7CDD4C22D0BFDE529@BY5PR12MB4308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YIyHarAMcIvV4bkW9iG1TwECAXRxRVVh4yLGv017Yta8AnJ2LGdGRYU8WbVTiTnsl9Kx/91PIKUPsRiVDt2DKm1gs/oqL2JJCI7hoCgmOyPIeO/vGNw1XlFglN7nZj2JEhLWZx5C2SN2YiowcElnlbvsQIsotP42YuTJe9HNDxdLtOmcPxX1ezdPKYvv6VwMaS9e98R/+VRF1eRSQ3jKB4g5AglHIoDRQpYGKDE7LW7hYHbTnM7fh9B3jjzQHdFE4c3bZqjvkZFTfbBBOlGjMJFdZyeBBepiYp4n7FLNL/4bWvhE86mxahqbVzrxbzD5IrLRWXwRCcSFasDQyilq0of2XcKjAnJzGNmCua1E1CMI3egZz6H7JOERnkCeLFHMBRlrJQnEb2AgRua3ZxooNpge6cW0CnRObO5J+itSzyoVPIFexy8p3Ip1c1edtZY+MVWwXgv6V7zZkqtIJRUurqH+5dsN/ry3h19TPKuZmtFuqMlXhixKpyFS9AjB+8InRUCu/T4BAR3z6eR3fIVViU1J5KiR/26EiMO49BuHy733xBh+vAhBTNHJY69H9w8m9AHYAfMNSUJNofzjg4c99ZGtuFDLGrzAKes/TWeDlcRUJ6dGIEbcok94qyx3HAmMzcAXgmo3d3EWeIU1tbnMHJLLcPpgD1THlDQQ475mlFUJsbWBlU7MPpLWfnCiDi14sA1C7spBUrtrIlGZ74uLYsxZLqHxtZTqGRRGULJhNJQ5AEZ1XPccHXnMzmepBjtD76UOiRSY0C1oXXw7EnNOcY/cEd9G2qw4add4mcOQ6DNnNX0xDh1csGxOI4bGXGzpkkkEvvppyzliLAyZCj4oQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(47076005)(70586007)(86362001)(70206006)(40460700001)(186003)(26005)(82310400004)(81166007)(53546011)(316002)(31686004)(36860700001)(6916009)(36756003)(336012)(8936002)(8676002)(426003)(2906002)(31696002)(83380400001)(16526019)(2616005)(356005)(508600001)(16576012)(5660300002)(6666004)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 11:41:11.5465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4b3b9a-5601-4259-8116-08d9d5c06eac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220112_034115_484806_7F45653E 
X-CRM114-Status: GOOD (  15.92  )
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


On 1/12/2022 8:20 AM, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> Loop variable i will never have a negative value, so use
> unsigned int type instaed of int.
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index d38a630ce3dc..90b3474ea276 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -872,7 +872,7 @@ static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
>   		unsigned int required_opts)
>   {
>   	if ((opts->mask & required_opts) != required_opts) {
> -		int i;
> +		unsigned int i;
>   
>   		for (i = 0; i < ARRAY_SIZE(opt_tokens); i++) {
>   			if ((opt_tokens[i].token & required_opts) &&

I'm not against this but this means that we should replace the entire 
kernel that uses int inside a for loop.

If we decide to go with this approach - patch 3/5 and 4/5 should be 
squashed.



