Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AC9C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:36:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8960A65001
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8960A65001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ySSVNAF1UqGeJHyWOWi+AsRic7qr5+YuR5aeWVEhl0M=; b=E2nR0WdWychP8Jl1P1I48z/gl
	D2X5AOdSl7/y2cqfNWB3lIJA/7xuvFJeonicnluOloxYn1i7G8Cecrw9QTDlmOvSx11lRikLQgqQA
	gH3vxMbKeai+zYO2iVrbbF9bfVmkMz3VjjLxTAUU/osBZyNzSWm6COJo1CiyOdbdhli8iU7QnTi0F
	U9ZUPKUrYpsd+Uwr6+vxuHNiZxDm2gheGk0HKWKkERIvnicc6+BjsYEA8yyWGm+g8GB43GBhXj6Uu
	K8hAMoiYtSpAymdS5fkLv3fvbOOswi5y+5OWBoDxZLk+elakPvUKWOtsXHwnYMhJJvFq0Tp09uXwW
	hRKG4oAiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM5BJ-00093a-Lw; Tue, 16 Mar 2021 08:36:01 +0000
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com
 ([40.107.93.85] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM5BE-00092t-QJ
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 08:35:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNXCfP5AvGJqhfZc8sd3rP9wuK+LtyUNosTjBYdSz0aKPuZ3kU4ChrVrvZ/Dc2UMOXT9Y9TVDklB7kB3aTlmsjVk09cAFPVtFwzjuV2IpK0h/vMSKqlga7qXhg6QbGFczvtu4xIAgabfEQzM8rDrfHdBmaY1TI7ZKZOD2cOuPpQ0Fhzz7+1UQx5mIEHsvitKJn92Fx+5hs1AI+oKBUUqmfP1+l8zA47Hqnp4h4uPSauFKsp/jRfy+G2VgmfK/KrpNg1IdLdCa9qHfygN//te89W+W3aXFyj7vXhYrxD3ssaW9MTYAWd5Cg8MEV8sFqH+BhaJphNlTZL45UvtGm/low==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiZxCr2AVj2j6UHm9W3R3FlePgYaGRyV/D/boev1dgo=;
 b=B14VZltPxsi5lh3uO6zO2TC4aqZK4Ar5BweWE/PE6L8dNZ8n/yQ1PWTCJLXhDbCbnHjSKxqJZDmyHrsJ80hE2aSRBnJkkaIWvtUXPiHPocR7pT/zhQZDkSwkhXizhsBHcF9/afi18g1FB2D2bXK/XaRqrUInCDJFYbl7+S74J547hZbvialOPlnq7Az797WnIxQvG3IFAtuUTDxNkyLDtK70Oxs98xWS7sUKDPrNFX9ydzyLpJe07TfB3uEZNSQ13fU1ofkXLT4PWSHWQESc8D3sfi+P+Nedv5OvXFcQHy9TTOKs/zwbLm035zVJjIbarIMfwKFoSd/OPo2/qo5n6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiZxCr2AVj2j6UHm9W3R3FlePgYaGRyV/D/boev1dgo=;
 b=C2L1eIx7BLOtXVf/6cVIbOGVS+jUptxKUWfp6DTyLElxOuoCmCrE0Rj7NXsmdFnaFGOIPeUNXu9Vw3DYEq2BQO+XfGk770SqTNDZJjkcvZJC0sl8UD98ZsJJDD6n3ZsTGf90A+gE2mbLUIXLm5Gb7yTNOq82gLx++b2NhjKZsGb8jdzTV04E0XblZSCL/BOvpV2f/1r46mbwVbmM8Ia1FaN3CmRE4lyg66nY1Whp6x+5YqoGq0U4E1JHQCDoAPQ+p/6p3ZFNtgQl/N6gqiMTgoJMmtux82tLob3MLb7MQpZ+v3HajU496gpuNb4Gfo9G4ZdDQjjDDMuMqD3aeU90eg==
Received: from BN6PR1701CA0010.namprd17.prod.outlook.com
 (2603:10b6:405:15::20) by DM6PR12MB3708.namprd12.prod.outlook.com
 (2603:10b6:5:1c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 08:35:50 +0000
Received: from BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::3a) by BN6PR1701CA0010.outlook.office365.com
 (2603:10b6:405:15::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Tue, 16 Mar 2021 08:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT054.mail.protection.outlook.com (10.13.177.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 08:35:50 +0000
Received: from [172.27.13.197] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 16 Mar
 2021 08:35:47 +0000
Subject: Re: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
References: <20210315145611.155972-1-ngottlieb@nvidia.com>
 <BYAPR04MB49657B5E84CDE72510A5AB77866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <4a4a2b20-af9c-0474-a5b6-734158dafcb7@grimberg.me>
 <BYAPR04MB496523CA274146559560AFF1866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <0b645d22-4787-e4c6-6872-c840ac7ed39f@nvidia.com>
Date: Tue, 16 Mar 2021 10:35:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496523CA274146559560AFF1866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00a7c964-447a-4957-6e31-08d8e8568103
X-MS-TrafficTypeDiagnostic: DM6PR12MB3708:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3708525C329AE59BC6D80EFDDE6B9@DM6PR12MB3708.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHhemkGiyDCGHzlzZzKWW0Gi9pWH/7IhlIxKib3LZmwNxlVGqa+LcdqQEdYQ6Lr2kpeLMyOgsQpdYlxXR5GsNz/W7az+1wFmrlHG3li430GyZA1fwJReVgncxRA/ZqNkRxYlQNEzLC7Ta1um/+eUObL29so3Nk4Mb5TJw1Uy+pDK9Yr3ODF5Zws297OGvrrKunWdhy/7+EvDTNqP+WQ5lpPpNwREx4EY3+S7WWR3svDZangRERjpc9DHlc+NzcFys9DiLsFgF3U+J53EOtEcwVdSVEZLOd5lw3R1p4bpk+ucyIu3XHghacuRvJub7MxP5g9qRscNpUkmjZBcVlALi9Pk99ycipTvgf3QzDAPlmp0Fk47+GF5WSihN0z1Tk3DqtlgWY3Ud7p7cKIvXPyfkFWS2vNFUI//ZAO5fGV/bgiw96LzZn1CNgsWZiOKZRwwR1X3bvyyQ9UzPWWZa/russmflmfcwRR7b4xLNQXSIoRJooyppJfeUyOHoVMwj12wjvXu3edhd7KULA4xd74UFPlg9CMkU4oJGL+2w9fXcVoP0oOFnlT/RHEz0I5ekRGZRcfga0XndUdMIu+/FNYYEIoZz6nd9Ixh/FT1dTQ2XeZ2olD1m96GtAcUSsbiLimQ5/0k5fQmBOdYWR++07oFEGzRN0+g3hSVq2x5zY89c6wWe2moyirrXkNWeEUXH0dzY1HgFleOy4T0AkHNEL/BfBR6ugytgQgzrCEuwzGxtUQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(31686004)(86362001)(478600001)(8676002)(2616005)(70586007)(36756003)(36906005)(7636003)(83380400001)(426003)(356005)(316002)(34020700004)(336012)(6666004)(5660300002)(8936002)(26005)(4326008)(186003)(16526019)(2906002)(53546011)(47076005)(36860700001)(6916009)(31696002)(82310400003)(54906003)(82740400003)(70206006)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 08:35:50.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00a7c964-447a-4957-6e31-08d8e8568103
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3708
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_083556_997531_49189371 
X-CRM114-Status: GOOD (  12.92  )
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


On 3/16/2021 5:40 AM, Chaitanya Kulkarni wrote:
> Max,
>
> On 3/15/21 14:50, Sagi Grimberg wrote:
>>>> According to the NVM specifications, the model number size should be
>>>> 40 bytes (bytes 63:24 of the Identify Controller data structure).
>>>> Therefore, any attempt to store a value into model_number which
>>>> exceeds 40 bytes should return an error.
>>>>
>>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>>> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
>>> The patch looks good to me, but is this patch not intended for 5.13 ?
>>>
>>> Since for 5.13 we have nvmet_subsys_attr_model_store_locked(), this
>>> patch uses nvmet_subsys_attr_model_store().
>>>
>>> Is this a fix for 5.12-rc  ?
>> I think this patch can wait for 5.13 for sure, maybe needs a Fixes
>> tag to help it get back to stable...
>>
> That's what I thought, can you please respin unless there is a reason for
> this to be in 5.12 ?

The function nvmet_subsys_attr_model_store_locked also exist in 5.12 and 
this patch applies on it.

I'm not sure it can't go to 5.12 but no problem we can re-spin it for 5.13.

I guess for Fixes tag we can use commit "013b7ebe5a0d70e nvmet: make 
ctrl model configurable" , right ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
