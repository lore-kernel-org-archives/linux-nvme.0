Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF04C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:44:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 105CC61426
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105CC61426
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z7TxqX+HYZt+abpV9qtl22WEJiD+zOwSk6qRdRzaAIs=; b=aqV6rK7Z89cBinzD8NHrRbgBH
	t91ARi4MHDWrQyeD6HGAg4Go4zju34lMsNh70MPFOG9nr1/XbJj7T3vROZMwF6ZssPb1r3ZkpaqVu
	j+DeBIThLDV9Duw3dG+9vP+p0OZw+TMm0fnGvZ8IM77BniJrtGO8ZCT5Fm8UC1A3a8rDu9Q4t6G58
	nZnJdDvaXuh8+oCdwA429ssDNc0NXDWycW7lyaWzU+t9u3tlRbE/5KJRSt1GTDxtZu4LOxct2rshd
	iGxBDkZCA2GtNr1WPW8iLhlhRhBo0iLoEBulcVqvEaqcTkFadxFIM7SECOciQ4B14qW/eutetxjgV
	It8CehJ+A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZUwM-00GIzx-Gf; Thu, 22 Apr 2021 08:44:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZUwG-00GIzZ-Qu
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 08:43:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=smyCvpphMJeoYdVmm7geKN/TZBi1TPJOMtHfFB9Xj3U=; b=ulYy+IeKHJz7+fhIWaA4VycVRI
 SMh2gzybkFWQYs8SVZ1JedOCc/vx56n58151+gERDHhnmxo3q/i5dsKgNF0aVloojRXz4SmBfKiwE
 LIzS9L+YORheewrtWtildzQjX7X5qN4ptTDCAZq/QWJx57CF9J81k2syxGuDg2D43fk8FoCOjuy14
 c5FoDeVbIXiu0rr4UYnplUIVHDxwRAUcjUdQkDWRh0Wv7Cg9/7FMaxGfNGSkESJHBQYUgWQTXZre9
 3lRJG0qfmAwoyJazXXSojc/2PNwPkG0u8mfLRiRYKg6UmVQaUsn6/KVDNvqy/nHjg6T6BaKYhcF6N
 Vls7KBLQ==;
Received: from mail-bn7nam10on2076.outbound.protection.outlook.com
 ([40.107.92.76] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZUwD-00DVt0-Vj
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 08:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ4av80d3poqGxAN89FLgQiYhAhoQZTYkq+VTuASmVad76X26A1ltdIiLWHF7frcC1oaWd6w/tX6WGcaVoFEVxOjdiBV6rUEVfeglJUTFA3bp5uD2x0m9rhGfXWbBXdJkOhZFnnGXZRVKHwB53z4XW+nqFOx22ZQvGJ+51I+oBCZk6KJYJO7Ccij73fHzXtUDfNw8B4MDv2oPLvk41+AvLRVZlZAXV9sfQkeZojp/fivPkSZnReMQLyazkGmOx2sPhPNaNV78tASzIXeK0bl1Wc8W1qnGq22QalLSWVhuRmuJDOUyNFINKMLqr6WVO0bVCNTk7bmcjwir3NQzYzwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smyCvpphMJeoYdVmm7geKN/TZBi1TPJOMtHfFB9Xj3U=;
 b=hriE6lLuA3JkhPCNWV0IAkG51WzalN0D3PsYtAKfaLcQO5neI089cImUh51l19xiGlRMqNeJl0pcybDapHBaYuGeBr/EqSiovLaKatDdZXwiNej8O2apf7win/c9APlY3kPo4cLe4UKcfOLQkl89d/Z3lRJlWBTf6FdZpNSbUOnTY7EKIpitncnTVS/qCOK1FNoPPb+4XHef21uZ1POpXo2QCeAcOQ1KSt2NLpBgFo2Q7aO7uRbYcE4pOILvUDIB/ahpU6dzLnTTF+kDboVLQZS2XxneBV6EJ01cDHr367uy9OwtrC3IT/lKBWAOuNx5tPEdLTOe6PutgN02SV+aGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smyCvpphMJeoYdVmm7geKN/TZBi1TPJOMtHfFB9Xj3U=;
 b=ox2lymR9I/guzZ0naoh2RIGqKgX7333nD+yMvUzxzhq9tcGACQV5PZCx2QVg01bvOakFfrs5srPonr26pWITA9UHvHmoPNqEUwB4R9b7FyO1Sk15+grzBR/IKJSFN5ye1U/f0gvajWJjpwdS8FcHCNOpT/WuaU5tRIkoJe0on0RxyJ2ip9Ze9Jj2xfYyvVWNpfM4XsmYZseMVSYn0Mql6Ax/4PHQxGlKHexUZEupgPU9hQzXA90PJ0BL0/uXeY3DURNdpqXn2ZckCYSu3YYeM1irdss3NDM4ubJSzewzQhflWA0SNDdBxYvT9CULfTYS7KS7tzvXY1cLx0usDlclSw==
Received: from DM6PR10CA0033.namprd10.prod.outlook.com (2603:10b6:5:60::46) by
 BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 08:43:50 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::c) by DM6PR10CA0033.outlook.office365.com
 (2603:10b6:5:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 08:43:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 08:43:49 +0000
Received: from [172.27.1.102] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 08:43:46 +0000
Subject: Re: [PATCH 4/4] nvmet: make ver stable once connection established
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "oren@nvidia.com" <oren@nvidia.com>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
 <20210420090903.595664-4-mgurtovoy@nvidia.com>
 <BYAPR04MB496522B82F4480CADD4FF34286489@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <be2f8d6b-eb56-5efc-1853-5279329f733f@nvidia.com>
Date: Thu, 22 Apr 2021 11:43:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496522B82F4480CADD4FF34286489@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 569857b0-e633-4116-8f6c-08d9056ac01d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5147:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51477A6AFEC04B4326ED3BD9DE469@BN9PR12MB5147.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R/CgV5xM/mbZOf+YyUL0nZOW1k285/Tg9t3M0BhEwJRbPq6bMeUSdDD4CplTqLbWfNZSqcb5oWipcrvYb53m3p0LAl4LvP7gmhVBC6zKskE/iIGX7I6RZc8LQb4T9uIqAV6HLjhVwY1CfB6E86MVcKW7stK7p+FtOnHBANbTiTlHO5G32wGhOu3Yk2b20avfIqQNtTBvHMKlbY92KigXujFSyxb1vjrkT6I3LDMNj8jFaPEhpOLZdSzPVYZeZq70dcUYMZeho/Ryv0ICfAgpN0oYSzI70wpSbDihFNUfdopAjqShIav3j+dRvgdz7n4DS24HQojrqkaUUdx6kOG3Uvvz7/m+FKkF60vJZmw3rsBEuXHKNqoMQ0e/D1UaeVs95zB16VdE0dLw7cj7VR+OH+0cUQJ8lA91xTG8s4rzRQF9Mwymb0gHSv7PVonsbB1FMSqmglynNdA96ArDBksdNo51uNw4coiYuEPGQjjpdzXUPuMFj/cfmTtWq7D8EZjTMskCJcBwrri0qvsf6TQWZbr2K7UXcZfcZwnj8COXvso5LfctoMT7sF84yEQFcnGY5ALlthPEiwv2hcIkY5mDG3HM9GndWS70U67rjIFwwqcakeLE91mlKlZ3ij1VCJbVdFjld/jkXBmGmPhAhXg5to1QlrTeHgLGNo1sX8KdDIxXFKqyDcTyPJ03pvyGZVaZ
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(396003)(376002)(46966006)(36840700001)(2616005)(36860700001)(426003)(6666004)(36756003)(186003)(356005)(54906003)(8936002)(82310400003)(336012)(31696002)(16526019)(47076005)(110136005)(478600001)(107886003)(8676002)(86362001)(316002)(26005)(53546011)(4326008)(70206006)(5660300002)(82740400003)(70586007)(7636003)(2906002)(83380400001)(36906005)(16576012)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:43:49.6331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569857b0-e633-4116-8f6c-08d9056ac01d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_014354_082479_3BFB7F69 
X-CRM114-Status: GOOD (  19.62  )
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


On 4/20/2021 8:47 PM, Chaitanya Kulkarni wrote:
> On 4/20/21 02:09, Max Gurtovoy wrote:
>> From: Noam Gottlieb <ngottlieb@nvidia.com>
>>
>> Once some host has connected to the nvmf target, make sure that the
>> version number is stable and cannot be changed.
>>
>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
>> ---
>>   drivers/nvme/target/configfs.c | 36 +++++++++++++++++++++++++++++-----
>>   1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 61a9a52da30d..2c7aebd4d529 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -1007,13 +1007,26 @@ static ssize_t nvmet_subsys_attr_version_show(struct config_item *item,
>>   			NVME_MINOR(subsys->ver));
>>   }
>>   
>> -static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>> -					       const char *page, size_t count)
>> +static ssize_t
>> +nvmet_subsys_attr_version_store_locked(struct nvmet_subsys *subsys,
>> +		const char *page, size_t count)
>>   {
> Seems like we lost the indentation in above line which was there previously.

We added a new line since the line was > 80 chars.

And we follow the conventions.


>
>> -	struct nvmet_subsys *subsys = to_subsys(item);
>>   	int major, minor, tertiary = 0;
>>   	int ret;
>>   
>> +	if (subsys->subsys_discovered) {
>> +		if (NVME_TERTIARY(subsys->ver))
>> +			pr_err("Can't set version number. %llu.%llu.%llu is already assigned\n",
>> +			       NVME_MAJOR(subsys->ver),
>> +			       NVME_MINOR(subsys->ver),
>> +			       NVME_TERTIARY(subsys->ver));
>> +		else
>> +			pr_err("Can't set version number. %llu.%llu is already assigned\n",
>> +			       NVME_MAJOR(subsys->ver),
>> +			       NVME_MINOR(subsys->ver));
>> +		return -EINVAL;
>> +	}
>> +
> Can you create a helper to for about error reporting so we can avoid
> extra long lines whenever itis possible something like :-
>
>          if (subsys->subsys_discovered)
>              return nvmet_subsys_discover_err(subsys);

We will create helper in the future in case this code will be re-used.

There is no need to create it now.

Long lines avoided by new lines.


>
>>   	/* passthru subsystems use the underlying controller's version */
>>   	if (nvmet_passthru_ctrl(subsys))
>>   		return -EINVAL;
>> @@ -1022,12 +1035,25 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>>   	if (ret != 2 && ret != 3)
>>   		return -EINVAL;
>>   
>> -	down_write(&nvmet_config_sem);
>>   	subsys->ver = NVME_VS(major, minor, tertiary);
>> -	up_write(&nvmet_config_sem);
>>   
>>   	return count;
>>   }
>> +
>> +static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>> +					       const char *page, size_t count)
>> +{
>> +	struct nvmet_subsys *subsys = to_subsys(item);
>> +	int ret;
>> +
> nit:- ret variable type should be ssize_t
> nvmet_subsys_attr_version_store_locke().

Ok. good catch.

Thanks.


>
>> +	down_write(&nvmet_config_sem);
>> +	mutex_lock(&subsys->lock);
>> +	ret = nvmet_subsys_attr_version_store_locked(subsys, page, count);
>> +	mutex_unlock(&subsys->lock);
>> +	up_write(&nvmet_config_sem);
>> +
>> +	return ret;
>> +}
>>   CONFIGFS_ATTR(nvmet_subsys_, attr_version);
>>   
>>   /* See Section 1.5 of NVMe 1.4 */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
