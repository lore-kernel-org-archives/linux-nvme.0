Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2604C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:19:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E505610E7
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 13:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9E505610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Kc1sM4/GrgoJ4/xHBFQlq+GBEGW0bbLUByN8YQYiQA=; b=EguAKzR60uDtiHyz0sIEZFZj3R
	7e7UGshUwxvSGA10ZYtL8blolW3ORxNz5Ggm75s/zH8Jh6jIBBXddq2XMGUNIH4fS7J0OXJ8x4qN2
	2XhS3oKlWggidzfVWKczJff9Bva/EAiVd54Lb4gy/QhafbT2+vXKG4O5J8g4WIofetxb98e0RY3/s
	7tPjMKP3NXCOnSZFVJGgrJdA0/0Q1TuU9bYoyBTHRSGfzdVaCnQXz4J80/jPYn+Pt0cNAerNxNaZx
	y7KRwfClYwInEJ4eSbQYc/v7iZ633cc5Kg4YM3v2S7+BhhxyjRSB7xkFFugVajGpMvSlODuspqMQC
	25lodbYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcp1O-001OPu-UJ; Tue, 19 Oct 2021 13:19:15 +0000
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com
 ([40.107.93.76] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcp1L-001ONk-I5
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 13:19:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drp+KJgYRI7IlWwHAJccmTgRhNYMOJy7HRRLDXLMEdAUsdwujddN1K7M2v/lUoA5ifbWHIRLT5lO59oNz50QK6FHh/rKHZmbUzyizg2Zjs2ySY7TBoaJoRFJ6cC+bb3uOmXIIcOfLmTcYwz/Czbg7s6RqkEO8ft3TxlFAEzFCdrB/nsbo7Gjg3Qx1ZAMpOBfWUFEvXLDaN7XDV1sq19+hPgoxdAaYDgdbaVosoyiOEN+viWATud6bLNbWlk1rFuKu5TJ/PweaeptuOcGRXlW17c7xb8iX1UA1XIcj+UlZTp7ccrwLPuAWx5gl36QSYDVyWE9nYqZ9eBOB9sP81FrLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Kc1sM4/GrgoJ4/xHBFQlq+GBEGW0bbLUByN8YQYiQA=;
 b=Nt1Pvbz4om62plf4qeXclAMdwj55DE6XfaCJq5W9jJwxITDqfQd7BSvc87fJDRB+rihPHjerxHY2GoMTWLTeYTKEBixhL3lLoGfjpplqDFYYrVkB4dDsn8cPVihgpGbmWmP1ekcd+UjoknL1TXt6xvIgjUmFZsHQuDHfF3RL7mor+ua52WNgRdz1WDcvdBYi0Lt8KsEQ0A/VMaZf2MTEV4IKOA0GajRXNLRFYOPSfEhjY465EXjTirke8b0iKlviWWNj+5WuOw8RAjg3/sh7afkjDIz66aTA40GJNw6h07PBFwAMPhlxqV5lUj5z4CCiYOIaapeNWrms6Rpf0i7KHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kc1sM4/GrgoJ4/xHBFQlq+GBEGW0bbLUByN8YQYiQA=;
 b=SS+ziUHhjphYNdPNaOS55aDlTTJRE0ODsaDg1axRTspEE4dZrR2mP7t5yVl0wpZOnm253ovSFBmIiunfiLRhgo41IFwkyu0QupoVrL0jfmwiKWp58IMZywohGIgMe+FOf0KER0UYlQj/Opo28vkZUy3YpH3Du2nmi3vUzwrTkwd4Mei2IVJh6BSoFyisQpnuzRIatGi0Mff0oAAGKc+CQCRIPsSpgDhnFiZ0TofiRMBMJ63hkPv6qrvz8nxHWSnN7WPjV1Iskk7NAfnsJZsftKLUf8NdqMAjt6VUl5lpTJ/lFAVR2BWI2MTqCV/xbxFJarQsnvevbRxO/39xkqPJJg==
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Tue, 19 Oct
 2021 13:18:56 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ff) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend
 Transport; Tue, 19 Oct 2021 13:18:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 13:18:55 +0000
Received: from [172.27.13.79] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 19 Oct
 2021 13:18:52 +0000
Message-ID: <39789097-1636-fbb3-ab72-c382975953f7@nvidia.com>
Date: Tue, 19 Oct 2021 16:18:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 6/7] nvme/nvme-fabrics: introduce nvmf_reconnect_ctrl_work
 API
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>,
 <hch@lst.de>, <kbusch@kernel.org>
CC: <chaitanyak@nvidia.com>, <israelr@nvidia.com>, <oren@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-7-mgurtovoy@nvidia.com>
 <56d9d289-53ee-75c4-37ee-c37d630fd226@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <56d9d289-53ee-75c4-37ee-c37d630fd226@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d1c65aa-d804-4f3f-8dbc-08d9930300fb
X-MS-TrafficTypeDiagnostic: BN9PR12MB5225:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52255D3854441477C5A50B71DEBD9@BN9PR12MB5225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpcwwFQkAdGbfx7jP2NCt1Ba3Urotn2BUUN+5eu5Ku6gMTsDKa7DjLV2eCqkD+XbgbpA0W17AGeiEk/MFPyBKb6YAvmnLYbZ+7DfbvgBeiYe5fMj4PLfEjQJU1K8kEfHUdtJn5kkOrBUqwcvMfxML0kUnFxQdesO3fWctndL5IJpEE83a4wCHITVtuC8LwvKZqSDrHQqHOP8gDulw8QJcln+4b0HN78OZHmO8bRBqrUnFpqa6/4nvTIpTd8DBOG9Ge8/omOSwxbHoD8MzVNSsNYmy9kRh+ILA7PqkHP7Hf7T0aJgB1WQnYfzn18AK+hh/JREhrd11GD9J0QAySSmaHLNvazFFvKkOSskBUWIRpKn6mREE2YnGL6gav1ZBSsHgzEaLAkmylNmgUSNnqNCr1ZBMAKMThfEB6K0kxMvAuDTWRKXmiJbeHpjkwn8LKuhHSn6Logi85HLV7v9ZG0sYfuMrLg7kqqhQv93dEttg3jBMRS8qOMKPg7o6RVw/jWEcoy8D2ClxsdnteZ9DCKaDixO+uG8Rsqapf9Tp8uXF+EfM9eod/tsLPA2LbpFNOKa+yqcbYWQcMMM4c+vSh6NxV2lM7GwW4V1RkIDSdeChFTiOwt7awnR0MA2Bw69d1U+kdR2RPaNuM0Yvp9dRgP108jYOk8nm5nHQvn2XnDNfWAztIzhtdxqPXyNqpD5mKkGERZF154QUavSiMYKnmCeFrkwuM6iPrjqeIIB2VUsYNE=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(186003)(16526019)(54906003)(26005)(110136005)(70586007)(70206006)(83380400001)(336012)(2616005)(53546011)(16576012)(316002)(36906005)(7636003)(508600001)(47076005)(36860700001)(426003)(4326008)(5660300002)(4744005)(2906002)(31696002)(8936002)(86362001)(8676002)(36756003)(6666004)(31686004)(82310400003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 13:18:55.6169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c65aa-d804-4f3f-8dbc-08d9930300fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_061911_627584_D34D4AEF 
X-CRM114-Status: UNSURE (   4.95  )
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


On 10/19/2021 3:44 PM, Sagi Grimberg wrote:
>
>>   static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool 
>> shutdown)
>> @@ -2435,6 +2416,7 @@ static const struct nvme_ctrl_ops 
>> nvme_tcp_ctrl_ops = {
>>       .get_address            = nvmf_get_address,
>>       .teardown_ctrl_io_queues    = _nvme_tcp_teardown_io_queues,
>>       .teardown_ctrl_admin_queue    = _nvme_tcp_teardown_admin_queue,
>> +    .setup_ctrl            = _nvme_tcp_setup_ctrl,
>
> This asymmetry is not great, what made you choose to go this way?

There are more duplicated flows we can work on in the future.


