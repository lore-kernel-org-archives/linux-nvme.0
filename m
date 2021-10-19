Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7F7C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:20:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A423E61378
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A423E61378
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E2Ut0a0vTLLov1JV9RiArJmLSM9mBdqNlfbIS18p3sg=; b=qhOGngMsCQLymOGJ1XaDdcyph0
	qIce/PMMcKNfxmY9oZAHvDtm+ly/LhG1/albUYrQ+wVJ3fW5mCYhwOXacZ2BXIDoKaF/qw4HU402K
	DnrehA63k1lhOqMmxhHSsD7iqpSSo0SbPMznBs4b7+KPoSSMmnY/jN0a78bNeIZg+nqi/AAsU5HCR
	1dN5czyVWIgNwvRA+C9bWjX340sUR/9+1bLrBYxZT92MW9nP9jnYuG4d8h6mpIWzbk5nokWdGONPo
	Sc8w5iWaYf6kvfdnbi9gdWvbjUUxRgoQzeWFraaLoPsqlcvisR9owsiTIQETl66r9O+6wf14a0WKT
	Gh/BO54Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcp2I-001OaH-61; Tue, 19 Oct 2021 13:20:10 +0000
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com
 ([40.107.93.59] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcp2G-001OZk-AE
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 13:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egAbNI5kNplCaAYmnZ0HPvwWcdpp6FeainDzt0NZuUuSsX3ANG/bAWRz3+cKVMnPfDFEHO1Ss5HGqEOM0Ug3+QD+A6GwOylnm872Diyg8m1VghKEtCCfXI3v1Hes1fs7veKjjTA6ulVcSG+kdAhq9xrA5wROkDKC2RfNRv/zjwN5luILIGcC/RSnIHn5q7BRpslB1V4uYsRI/heLoXyV+3MLLydKw92KwtnDRP+kzmwT2UHP1xKwGARw9tFT7GtDGD592573kLfo40bKhgLhGPkWRRTcAW1i0ZNrTqWnOjDVV48m+u9AMB0QU07XBl/Oy6lXcXS7LYFa/J2XMCmGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2Ut0a0vTLLov1JV9RiArJmLSM9mBdqNlfbIS18p3sg=;
 b=C5kHCaA0mF2Rau57Wt30XomB0FpST6EWanf4xaVkEKoF89fGCgKaWrUh1ytugZg/uF3LYCtgV08uEcyXo5/V2i0cLv7vVd8tL3Zttfw4B40OOBE4a9HSFQQykyKsS33xPgnZINehjdg2BCn5nYXsiso2a08lFtaO7aEQ5y5XzMiTqv2XyDKMu9Wr+XFvHmS1et4SjtSQYRXfLG2xJojScddljdeeDVvv1iAKTKaRBrKQIaquPKtIjdS5trZCG+d61RJLY+c/RERHiyNr03cnM+OwB5E6ZZ0Y/6Y25UqJIC62ZIZWPirTwrLBTd/ssmMkPgj0BCPJNEzMDrhC7Opv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2Ut0a0vTLLov1JV9RiArJmLSM9mBdqNlfbIS18p3sg=;
 b=bu+A68XaKDy2Cc/NAUnx0rWdaKEtaj0iaJUh7uiyZWZXSZmzd9+x5yd98u1eQtv9JF4PBZPG8pp/T6fFUavUZ9lqduW3ymtAW+d/7wB3c7gkxlio8ZwOYqynub0DaX57sLmnPE3C4jJxsbnKzls38bhQl+fA7qfSJUYbIEENloMtsH36K0Cz0Zhu5qA0b4eDOo7Ah/FrUIzjZUkXEx6BW0SVbXighyp8EgAcDCCskKq6hpVYb4Y4tHTYlcIdMrJ/ZmuBKw5DfysGV1hWTeBaJxgFw0fujere5oC3abFqJCEwS/HJHpCDgp7JMmEfl/XubybnxpF4wmHKygdJWFqc5Q==
Received: from MWHPR22CA0055.namprd22.prod.outlook.com (2603:10b6:300:12a::17)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 13:20:06 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::ee) by MWHPR22CA0055.outlook.office365.com
 (2603:10b6:300:12a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 13:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 13:20:05 +0000
Received: from [172.27.13.79] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 19 Oct
 2021 13:20:02 +0000
Message-ID: <a05eb226-36e6-9224-2ced-d5acb8c78ec1@nvidia.com>
Date: Tue, 19 Oct 2021 16:20:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 7/7] nvme-fabrics: add nvmf_init_ctrl/nvmf_teardown_ctrl
 API
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>, <kbusch@kernel.org>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-8-mgurtovoy@nvidia.com>
 <6cdd8b87-7d7d-d27a-1d0a-57f8b25ce71f@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <6cdd8b87-7d7d-d27a-1d0a-57f8b25ce71f@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81ea7b2c-4557-44e9-5e13-08d993032a85
X-MS-TrafficTypeDiagnostic: MN2PR12MB4176:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4176090C7B5EEF827AAEC165DEBD9@MN2PR12MB4176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsv719mjZBcIW7/i9pemDw3e3GdzHLMOkrVnWbJ7ekV628XWO1ICsFCD392bcEIuiTl4JGXcadVE9VuxQsT2WsAdxg99KDh7oTY0ckfdpvzVJMPOaDYzoAGTPxEEQpTBg4QS2387pLkdK2Q3aZsAgtiZwVptn+fYE4igHQTIB5/qonWPGX6QfL/5HHGQZLtpkNUfYaZeMhvOlfGCMwuk99qlCL8bilahd7Mzj0hDvfS66nFgUGk+jfTd7+Li8z197xIkVHd4WWKpYf9+X9TOaNjsb1EvV8paIwNoGj6ZKWgCRDJbncnV1R2I98CLZSZSdt1Zsmm3jltVkcLEpIwBjYdVTBENUbuMiUhVZW+3S4sa9RUFUAQ5XkYFGrKGupefdY+bZMAT2qTNXx9Yx1SmjMTFaXrJEoyHo1H+zrdF7jjRu4LHhMTdP4pozZmlIYnd1TCln0SzJzvmW0UIqfojP90ponNyqR87tROed+I/Z2jBjnRQ2rFx79oHtUZah2TyZ9wio6qzGBRe5LUWG91htbpuL7wOkyfmFB58B9fo1KFUUJ/r2/a1a7ngqar1UQ7UJZMDthbp4D0RxWpVxM4lj3o9LkVp3BPyE+2rLHhmgqEDAPfiTdXL9h5H5RpQUnFbkGoZbnuP4eIMiRFflsr5zg7yq522gBzQEqRqlLBtDM3H+z00UERUf0qQqmDOPkd4sWU1FFCujqtkAmA9ujM24voJjH+qMbmz8W/Koqh3Tm0=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(110136005)(54906003)(36860700001)(4744005)(16576012)(316002)(508600001)(8936002)(2906002)(4326008)(336012)(2616005)(8676002)(7636003)(31696002)(356005)(16526019)(186003)(70206006)(70586007)(86362001)(26005)(31686004)(82310400003)(5660300002)(426003)(36756003)(53546011)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 13:20:05.6064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ea7b2c-4557-44e9-5e13-08d993032a85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_062008_382250_CADC3B6F 
X-CRM114-Status: UNSURE (   5.25  )
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


On 10/19/2021 3:46 PM, Sagi Grimberg wrote:
>
>> +void nvmf_teardown_ctrl(struct nvme_ctrl *ctrl)
>> +{
>> +    cancel_work_sync(&ctrl->err_work);
>> +    cancel_delayed_work_sync(&ctrl->connect_work);
>
> Name doesn't represent what is done in the function at all..
> possible names:
> nvmf_uninit_ctrl

Ok, i'll change it to nvmf_uninit_ctrl

> nvmf_deinit_ctrl
> nvmf_fini_ctrl
> ...

