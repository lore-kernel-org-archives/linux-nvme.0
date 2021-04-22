Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D982FC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:51:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04CB2613CE
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 08:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04CB2613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7smQih5mswr3Hce8Zs0sVVECb5k87JPuY79R3UEdREs=; b=ZjeT4uVgBwOGR/iuIpjQvBRgo
	b8dEoFB1e+CXWMV46eV6xYddtVXg785JXTZriso9+UQF3y42tojzNBwCSWeMyZdrfIvW5ztMl6qmc
	qFnWY+zQBGOfYr0gEKmTBSVpW13u220RLX897Mj+DMV2qcLh8nSXaM517wL8mt/bRG67TTodqiD7A
	ig/Az8PMsKMhXR2RH/rxjWNG+PZUjXkWdHZXLliL0DcmIpJx6Rx23e5ERuXXWe6egJwITUwaybG+0
	vdlz4l3fXAtNbn998iMhm+Ae2Fwc0wtR0v+h6M+QY+7MUx3gDj1781BcFtT2h9uN7O3/BZlvi5UAV
	vZMFUZ6hw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZV3H-00GJgk-BW; Thu, 22 Apr 2021 08:51:11 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZV33-00GJfX-GE
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 08:50:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=3Qv9zkEJ1n53k23prpY2RTnOOMo/VNM7SR+EJaU7+eI=; b=X+OLi7ufnpDepEkMcI+F2tEAQN
 xuuTAcPfVrM4JWW1eV5BcLFS5algIaQ349Zc34F1PzLgjldIjR8ouv4PhmYGlub7staMQ/FTBNJlY
 joEHbgYz5mSvD5F2DHJUGwJ9dZW0E5i+0Fg+bdnLFgfPej/9HfJganMDu3oPnhtlGPDJ+dapZyyNg
 jrTQIl2hEpwSw6PNZiyhO1NN3hOIz4AVOdji3sUsdCCKFiX8hk8Bf5BdL38QOrs2Ak3mQEwcqmUmT
 mv/Oo3EZF4gq2WJQYRvVP4NvtCLxVob3e0odL0QA+q5B1RbxoobDPSo8Syvjuspgnoew11B8K7EPf
 U2X3Z0sg==;
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com
 ([40.107.237.72] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZV30-00DWCY-Lj
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 08:50:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEjEWCDTyFAUfxNEIFgrCwZ6h/1U7LcAC3kLhCPAuLNU/C+db0cZZWmGy6OaofRSZJwChvq6Pk/iJn8yt9IISLbxP6lM81WkVpx2RZlLJrw3/DApRqUPG+OTO5mGdH0KA2izdQ1RuDbW9zDZyzIuq1bdY8KVgQ7oLdrOQulJYCjvjXrK13200st84rUTf0Qos68Iwt4+kCryAQRj23cPSOVTU18ysraBEtTjsl4KbNrt+NAPuiXTNNYHhMVTn88tu4TjC+GxUUDxyqHUAWSwwhICwX0O85ppQxOE9rZXw49iyhhFjf5dDMJll/bShP9G25Mt29QBwZf9uHMlK/L5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qv9zkEJ1n53k23prpY2RTnOOMo/VNM7SR+EJaU7+eI=;
 b=Fn9HcN8ZzGOYCzPnFI2cPGo70yetAdvYj9ebfWlaPPg5+O0eKnZmNR57UWqUwYgSlbS2uWAPRXhqsp2RdBtD3iHXAByHxliCI0HrdFBiSmGQW5egkXQmJ4heUtMoZAQRzy6PI1HHemkwN/ieT1pNbsb6I88Pdld8e/uRA8qlNbcRyzseoVvs29W2jzRUSzlWGnm0DVC31YLaZ9uIGStVA5DIx59cSLUyWQxeRy81bu3w1TsU6vPono3GJEJHzLhsEWHCuyVLLRFVfCAkQO3ina4dxr5SJtZTx/Jt01b7tqN/Ghk32CwGinzhMUjf1++A9G2XlAUVtm04Mh8pfO/WEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Qv9zkEJ1n53k23prpY2RTnOOMo/VNM7SR+EJaU7+eI=;
 b=q6JFx+pW1bBMjqoma1VsRnxfKucbHajnZRThAWo9mrh47nLVOBucVfHIcK0jnY+4/Y6MvsvXuE8Q/4piXX5ErZLYtohBosggHH/lit0znxILvxTJsqo5toOCUp7OXQipcsB8UKZ3GWU1yri5QmEN4CFDNZ2jtbSI1lj/jVRM9Z/7PaV0OBc+8D+HSkT1q9I97F7NcgR3h0Bdl+fjPov0GoGU8sGxzJVc+Aasb/1+2MfohzlUMROuhm3tEBca9C7hQsCAb861HNGCO92XTCJ6bIHJU2olxQBIPxWaj0FdBoZa77G+0dtMgVkRuEnn6larZaHGgtAfqOjOWl0AqU0Fgw==
Received: from MW4PR03CA0356.namprd03.prod.outlook.com (2603:10b6:303:dc::31)
 by CH2PR12MB3829.namprd12.prod.outlook.com (2603:10b6:610:2c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 08:50:49 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::36) by MW4PR03CA0356.outlook.office365.com
 (2603:10b6:303:dc::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 08:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 08:50:47 +0000
Received: from [172.27.1.102] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Apr
 2021 08:50:44 +0000
Subject: Re: [PATCH 1/4] nvmet: change sn size and check validity
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "oren@nvidia.com" <oren@nvidia.com>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
 <BYAPR04MB4965297F005A2E8EC059606D86489@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <bd1e5f26-8eda-d784-ff00-686190ed68b4@nvidia.com>
Date: Thu, 22 Apr 2021 11:50:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965297F005A2E8EC059606D86489@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aeed11e-f0c1-4498-55e0-08d9056bb92b
X-MS-TrafficTypeDiagnostic: CH2PR12MB3829:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38292A0DC9CAC5B9B87A6591DE469@CH2PR12MB3829.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irEdRPW+CKULuXuCK4uBUIcM1mYWWKwpjLE96blSoyJqGcqgKfze8hfHt+bYWPXusDSjIohCpK3G5lC34+plZ+Ph7et4HiOcTskhyt/uu+hDZK8YSiukzC3lTAhVJv6KAlLiFyfKu9bHyOMPTEq2JvIUngxqqlObPYrkSD9jdeGeJ/UsbDScauUIyIn3SCI19jAPYMCXRkRr5J6I/L00NZZ51TmeMrsUPomYnb4hP9mv6EyR30IEvATF/gBw0zSC4TbVtOAdVDqYeB5ItLxYpNlNQ0pHcUuTslSVXiF49Cx1srgqFnOLLvMpoEuYxOu2FCBj+TSyM30sDslwJCoQlsoH5CyZ2lvYDt4EMqnDjdUqXvvXiKfpFByHbIUweriVfIV3zNxYkKrCUWFpmcxqoO3pWE7S4kdURu0ao5CkTB9Uw3QEe36ntqq5MEdfKeXL9r94+LdtppShLCg3Ir9jfchmVizbvsiHUn/gEUOdkGMsueUFm2s1MeTm2K44bFmcOePptIyu7Qmn7F5o6/xKqfDSKBQpxcaBCyQB/DBZUKlbX6w8SSvmfWsUmRg2uV/dRPEeAgeLGw/dP8OzP2TWLvdt9ig7fnF3sRHRCF1700YhlM0mbnTt7z3LahJhj8SXbp92Ov1NGjklG7KEI8xgjY4Ou/1kUyamLIEsY2nlezy1B8+F70Mgxs9hY87R+3e1
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966006)(36840700001)(70586007)(70206006)(478600001)(5660300002)(316002)(7636003)(426003)(356005)(110136005)(31696002)(186003)(16526019)(8676002)(86362001)(83380400001)(4326008)(47076005)(53546011)(336012)(31686004)(2906002)(82310400003)(8936002)(36756003)(36860700001)(36906005)(26005)(107886003)(2616005)(82740400003)(16576012)(54906003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:50:47.4671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aeed11e-f0c1-4498-55e0-08d9056bb92b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_015054_753704_4EA30BF1 
X-CRM114-Status: GOOD (  18.60  )
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


On 4/20/2021 8:35 PM, Chaitanya Kulkarni wrote:
> On 4/20/21 02:09, Max Gurtovoy wrote:
>> From: Noam Gottlieb <ngottlieb@nvidia.com>
>>
>> According to the NVM specification, the serial_number should be 20 bytes
>> (bytes 23:04 of the Identify Controller data structure), and should
>> contain only ASCII characters.
>>
>> In accordance, the serial_number size is changed to 20 bytes and before
>> any attempt to store a new value in serial_number we check that the
>> input is valid - i.e. contains only ASCII characters, is not empty and
>> does not exceed 20 bytes.
>>
>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
>> ---
>>   drivers/nvme/target/admin-cmd.c |  4 +---
>>   drivers/nvme/target/configfs.c  | 36 ++++++++++++++++++++++++---------
>>   drivers/nvme/target/core.c      |  4 +++-
>>   drivers/nvme/target/discovery.c |  4 +---
>>   drivers/nvme/target/nvmet.h     |  3 ++-
>>   5 files changed, 33 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
>> index d2a26ff3f7b3..91eb7562a88a 100644
>> --- a/drivers/nvme/target/admin-cmd.c
>> +++ b/drivers/nvme/target/admin-cmd.c
>> @@ -357,9 +357,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>>   	id->vid = 0;
>>   	id->ssvid = 0;
>>   
>> -	memset(id->sn, ' ', sizeof(id->sn));
>> -	bin2hex(id->sn, &ctrl->subsys->serial,
>> -		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
>> +	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
>>   	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
>>   		       strlen(subsys->model_number), ' ');
>>   	memcpy_and_pad(id->fr, sizeof(id->fr),
>> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
>> index 65a0cf99f557..576540fdba73 100644
>> --- a/drivers/nvme/target/configfs.c
>> +++ b/drivers/nvme/target/configfs.c
>> @@ -1030,24 +1030,46 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>>   }
>>   CONFIGFS_ATTR(nvmet_subsys_, attr_version);
>>   
>> +/* See Section 1.5 of NVMe 1.4 */
>> +static bool nvmet_is_ascii(const char c)
>> +{
>> +	return c >= 0x20 && c <= 0x7e;
>> +}
>> +
>>   static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
>>   					     char *page)
>>   {
>>   	struct nvmet_subsys *subsys = to_subsys(item);
>>   
>> -	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
>> +	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
>>   }
>>   
>>   static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>>   					      const char *page, size_t count)
>>   {
>> -	u64 serial;
>> +	struct nvmet_subsys *subsys;
>> +	int pos, len;
>> +
>> +	subsys = to_subsys(item);
>> +	len = strcspn(page, "\n");
>>   
> nit:- we can avoid two extra initialization lines with :-
>   
>          struct nvmet_subsys *subsys = to_subsys(item);
>          size_t pos, len = strcspn(page, "\n");
>
>> -	if (sscanf(page, "%llx\n", &serial) != 1)
>> +	if (len == 0 || len > NVMET_SN_MAX_SIZE) {
> nit:- 's/len == 0/!len/' is pretty common in the code.

Ok.


>> +		pr_err("Serial Number can not be empty or exceed %d Bytes\n",
>> +		       NVMET_SN_MAX_SIZE);
>>   		return -EINVAL;
>> +	}
>> +
>> +	for (pos = 0; pos < len; pos++) {
>> +		if (!nvmet_is_ascii(page[pos])) {
>> +			pr_err("Serial Number must contain only ASCII strings\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>>   
>>   	down_write(&nvmet_config_sem);
>> -	to_subsys(item)->serial = serial;
>> +	mutex_lock(&subsys->lock);
>> +	memcpy_and_pad(subsys->serial, NVMET_SN_MAX_SIZE, page, len, ' ');
>> +	mutex_unlock(&subsys->lock);
>>   	up_write(&nvmet_config_sem);
>>   
>>   	return count;
>> @@ -1128,12 +1150,6 @@ static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
>>   	return ret;
>>   }
>>   
>> -/* See Section 1.5 of NVMe 1.4 */
>> -static bool nvmet_is_ascii(const char c)
>> -{
>> -	return c >= 0x20 && c <= 0x7e;
>> -}
>> -
>>   static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
>>   		const char *page, size_t count)
>>   {
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index adbede9ab7f3..3efd48b0a34e 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -1482,6 +1482,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>   		enum nvme_subsys_type type)
>>   {
>>   	struct nvmet_subsys *subsys;
>> +	char serial[NVMET_SN_MAX_SIZE / 2];
> This needs a comment why NVMET_SN_MAX_SIZE / 2.

explain bin2hex ?


>>   
>>   	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>>   	if (!subsys)
>> @@ -1489,7 +1490,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>>   
>>   	subsys->ver = NVMET_DEFAULT_VS;
>>   	/* generate a random serial number as our controllers are ephemeral: */
>> -	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
>> +	get_random_bytes(&serial, sizeof(serial));
>> +	bin2hex(subsys->serial, &serial, sizeof(serial));
>>   
>>   	switch (type) {
>>   	case NVME_NQN_NVME:
>> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
>> index 4845d12e374a..f39946615fd6 100644
>> --- a/drivers/nvme/target/discovery.c
>> +++ b/drivers/nvme/target/discovery.c
>> @@ -262,9 +262,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
>>   		goto out;
>>   	}
>>   
>> -	memset(id->sn, ' ', sizeof(id->sn));
>> -	bin2hex(id->sn, &ctrl->subsys->serial,
>> -		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
>> +	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
>>   	memset(id->fr, ' ', sizeof(id->fr));
>>   	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
>>   	memcpy_and_pad(id->fr, sizeof(id->fr),
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 5566ed403576..53999bd259ed 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -28,6 +28,7 @@
>>   #define NVMET_NO_ERROR_LOC		((u16)-1)
>>   #define NVMET_DEFAULT_CTRL_MODEL	"Linux"
>>   #define NVMET_MN_MAX_SIZE		40
>> +#define NVMET_SN_MAX_SIZE		20
>>   
>>   /*
>>    * Supported optional AENs:
>> @@ -229,7 +230,7 @@ struct nvmet_subsys {
>>   	u16			max_qid;
>>   
>>   	u64			ver;
>> -	u64			serial;
>> +	char			serial[NVMET_SN_MAX_SIZE];
>>   	char			*subsysnqn;
>>   	bool			pi_support;
>>   

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
