Return-Path: <SRS0=+L5I=ML=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4522AC07E95
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 22:43:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B2061004
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jul 2021 22:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B2061004
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gn58k9JpxJbCej5oilHD9vwkqO5jHG1ONq50T+l3c10=; b=NKOuer5TWSxmP+1TmqrNnw7DEK
	hKF//tvj7lP9ofz08F4I222nOExsC/rF8oh7NldR9DUvgJQJw+0ObsTfMRTVZzGFBYXoeiTwbaGUH
	UImuLmzBwl0Etsjh3Ozn000TCbZA3QXsO9mdePi82OcpdEek/V1GiFAW+SS3JFWxlBSJLIJ+bzGS9
	RdUGDCxVqdBydwsuPJ9tjzfef7hvJF9DRrVomWpS+5TjYiRokXzwsOSJXukOJ0c8L0f3Aze2uOEgt
	iaIQK+7x5oUcYDQMWNA3R1FXCgj1w/KVh4E9E73LDYoq+s7XHGmKlhwLJOQ/YG7W69qhIEeEmPx9F
	Eb99IqMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5byH-00BSpV-3v; Mon, 19 Jul 2021 22:42:45 +0000
Received: from mail-co1nam11on2082.outbound.protection.outlook.com
 ([40.107.220.82] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5byE-00BSp9-DK
 for linux-nvme@lists.infradead.org; Mon, 19 Jul 2021 22:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bu+VCZ1ZMivoYtJwBSquDah3sb6e/HGNTWOCOnyVvSQuEkX+GssVICFhi2jreY6spglYWKLpCPQhcqwJIRYtdCI8AoFrzAXndInmo4W9R09grGmm5QPeFVXJBB3iPqmYftplmPrjibfW1wNjUX0UIh0qHYwXwoQdRWLPwkvYcIEKZVEuAY9l6wYxvX4ppv3cuZEf8QMO3E4j8sASQDlsLqEsU+yksjdNDS2xGR7MzrOoJcjWJk1TU0KXxGqA2w2jTkzbvBLqfbupPEGIy8KKw5cUh/Vo3hYPkO7WChTCxeffi7tiQ7yrwhAgz29XilOIXyt6Nem91koJiw0X3yW2rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8NE5MyEwTAPPDb1auDJGlKNUsLFwNA6pyCdJy5lEoU=;
 b=OXhQC4FDEqMpYGnE8iV5ytWy0QyyQqeZjX4tvG9CWm//IBfdYmEdh550bHkK3mrr6lwQFKM/GMsMI26LPQSYYqRfCMXiGbor3X1ZaG7AhUDAh7PbD2YkhiClnAnKmF5KxN04zQurMeFp2NXNIu9FAjxw18xpdAxioUS3BEVyyAOZ+vECUHoZbS4Carw9ABJubxvat6qgdtVfLttLxarZIJH9ILK5ys6pVS7Wn+KD+ydfUoszO94nMI4SDhOUPEbLmCWeVfcwiDww2bAQRTqX7N9ChR67NsT8lwJfyS1SrIGfxiiChQYSr4hXfmnEm8MeOKZ2kkRUyNI12DvvGjmSow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8NE5MyEwTAPPDb1auDJGlKNUsLFwNA6pyCdJy5lEoU=;
 b=DLowG0ztcgFiUpdWOO2su+M6dTjn0F9Ep106J/bdPrcotOIaOPY44ofKrwDuk0fVDxJFVQnAmQ0i/UlApRL2VXOHH8JOf7vhX4kSztt7qPqp9zdWXTpQNBEVfcKO8rXadeooRccJ0CZPlGnPHRk9ekacAiNLi3VtVOXpeoW57vr7lSsDi9SJyUZ8fmjjLsL03w1koH/MmzDaLiplpflhhUa5yuMMUcxlGejUhG8Yj0Pj2oiBxmkWJxnpoXb8rX+MeHdEyzzFf5/axykDcFal7NRtvfS26AuW44+WIlVZAUuoDDJVmyaCZawzOfrPPK/nPNLZpU51l5qoftEn5kZhBw==
Received: from DM5PR22CA0023.namprd22.prod.outlook.com (2603:10b6:3:101::33)
 by CY4PR1201MB0182.namprd12.prod.outlook.com (2603:10b6:910:18::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Mon, 19 Jul
 2021 22:42:40 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::7c) by DM5PR22CA0023.outlook.office365.com
 (2603:10b6:3:101::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 22:42:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 22:42:40 +0000
Received: from [172.27.0.228] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Jul
 2021 22:42:37 +0000
Subject: Re: [PATCH 1/1] nvme: introduce nvme_transport_sgl_desc structure
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
 <james.smart@broadcom.com>, <oren@nvidia.com>
References: <20210719095309.7777-1-mgurtovoy@nvidia.com>
 <20210719095703.GA1880@lst.de>
 <51a5f3c5-9360-f241-8fe4-6a5d53df99b2@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <08dab863-7c7a-c6ed-180d-f8ffcd3b962e@nvidia.com>
Date: Tue, 20 Jul 2021 01:42:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <51a5f3c5-9360-f241-8fe4-6a5d53df99b2@grimberg.me>
Content-Language: en-US
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db4e0ced-94ac-40e6-fe4f-08d94b0683b4
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0182:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB018216F745FF228870A1D98ADEE19@CY4PR1201MB0182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CvsQYoCrK7RsyafSRvsJ0PAxsc7/NTMP+ITDJ1m1gTbXKylH0QMFI3uJJhKxr8Zo2hy0BU4E7PgWOCbtDhjkggk4ptZh9GQUXW9s/htoyMqTEP2RwbMG6xDYpdbsfWwTLdx14+uL6YPZzTWw6/Qw348uIr77uuh4InDzORBp4RHzPfh8xJFMTcF1QyowWHxE5baLo+5z/2Vj4yE9VnlrwbxPZETfBW4D3X1QSmWjHxV/F1qmbjR7TyaOw6ynfArv/jeD3Nkrfh3ZEuGu6fxXK4Pvrb0q+vc8ZpgbW7bFvQoudSuUz2GdYKU/1CtV14hzGVaeSqfm7lUqx0bjlnXHUda0T6CJENkiN993FAhTCYBJpCJCp7050F0H9oKpWTL58kQ4pDn1yxqbTaOzdILTLtkH2bfbJ9QAcEeDtA1pxNEoug2HG5Ntq2qNFF+NcE3Xhrn4LgWLkpM313/RDgenAFm1kISGGgNETdhOhLIwEgnfXHPeWV7dHTO4qpdH/7mNWUZR9NifMr5XTW6CiPScK5X7bjzMmoJ/eemyVVgREM3hocmwEKIV4LEs8YZH8A6rGOq0JdJAA+gbh+GjKE+mLgEuahdVTHVGuqmoZN1ZFZXzzyhqifrdX3SKaeqTlu1MFVJTpMmsZFCBFvvtGk/SW87XS7q+cOInH5xWcwjBudhiK3R77vHiT9PK21r/uRm3AqkKUJ8bEGJMVExNjxlY8FNC0YP1VyXm6z5D+Y3oTj4=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(31686004)(5660300002)(107886003)(6666004)(82740400003)(4744005)(53546011)(2616005)(426003)(356005)(7636003)(31696002)(70586007)(70206006)(336012)(83380400001)(26005)(36756003)(36860700001)(110136005)(478600001)(4326008)(86362001)(186003)(8936002)(8676002)(16526019)(54906003)(82310400003)(47076005)(16576012)(316002)(36906005)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 22:42:40.0210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db4e0ced-94ac-40e6-fe4f-08d94b0683b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0182
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_154242_505779_B8198AA2 
X-CRM114-Status: GOOD (  11.49  )
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


On 7/19/2021 10:58 PM, Sagi Grimberg wrote:
>
>>> Currently the tcp and fc transports use nvme_sgl_desc structure to
>>> describe transport data blocks. Replace it with a new structure that
>>> describes the Transport SGL Data Block according to the NVMe
>>> specification.
>>
>> What is the point?
>
> I think its ok to be more aligned to the spec, and have the transport
> sgl represented in the code. Don't see any harm in that.
>
>> Note that we should probably still clear the reserved space anyway.
>
> Definitely we should clear it.

don't you think it's cleared already ?

if not, lets clear also other rsvd fields while we're here.

Each driver call nvme_setup_cmd before mapping the data and this 
function clears the SQE (if (!(req->rq_flags & RQF_DONTPREP)))..




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
