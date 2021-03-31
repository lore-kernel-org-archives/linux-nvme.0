Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2FBC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:38:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFBA8619B9
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 09:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFBA8619B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=S6w1D+SvoZDOAzSn1Xyzr23t0cSJKBfDdmYSHmt98H0=; b=eMqfdu4H77v2dap8Ax4e2z0im
	Ydqn60VJuo/Gn2Xj5wA5ngGbOCXYUNYC/F13G6z/KGLuW1v0pLWnFNKfFo8tVGAxqx1ePTYsZY0Tm
	bNazgL/2pszAaZoZ8LJSYPgaBHA+v9MyURiosN17pJQen3iHazkVHNJN+A8kvYG/NW+C3132oWZHX
	bQIiMSARb5v8wVaTdVRqDXFLAAKQOTVvSIKEqaKdnvv/13LAbG0SU05a4qUhiWZQv37GEnJafEJHA
	xCnH1HOLzkkKYQfxlhACyEqNCqiJJYtKfTomhkv2MgTZljDu5ccfVmi6l9nHCT0D0JP08BN7uUPim
	XVM6P9h8Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRXIo-006AkU-PQ; Wed, 31 Mar 2021 09:38:18 +0000
Received: from mail-co1nam11on2052.outbound.protection.outlook.com
 ([40.107.220.52] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRXHu-006AgN-5r
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 09:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nxdwsdsx8+vGLz5fqUxjeZ5loo/T2nd4PCgfseNjVc9Az0Q6EkZRVYdKonm+3AsFnc1fXalq9kOUrTan7UoFKUvJeeI7wmb/Q6aFqSjRkvqk4f4uhCJod23hJfJr4wjIzWJFh/UT+3jtpet+1CRiXRR7kEVsjdzbU000dnqEtiRksx+2dpw+OuBjzh2dZ1HPZTDaGNCMtf9MnHDfwa9iS0rStx/u3G2oOg2i+QhMnmqQCcJefqj9YH2Ur6QXe+dLxhhZWUrCdE/cp7nvW12paBLQ/ZIjg9Ufcs6OkVJCjoKlSZSQAVllRk4mKWmb+wI/phJBUs83ZGVP9q4LSm5Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2htlFYzHVLyTbXDOehB49CRzWuPep6AZqAEgqC6KtE=;
 b=PEz29C5vwZK9fQ6WAyepXajhJpMlzW7qKWkdMPDRgi2dc295C0g/JArtEmRFslrzz0uKYkzgKXQYQqTk7OwNRDALVdjc9kjJwMtKUuU/IQrtAhkF7mTSVle9y76yiS6hM8tsiRcU3gVJdmvAAATF6/m9gzx0YTs8ckNJ2W2LkGZne1AGSKAorC3VlRqeobt9duvQdlRx9/SkxQ2HOcezEV8E3G/Egznxzh7UJKFbxKRG0WyyYp/6zhhQTQq9Amq3cBKvHsslUfHzARx9Rn3FEJPmmz2H79nA1fgiVdmRkeBOwETmiXanmRRNljUXm4HUDlggvgfwwZqDkOaxYykyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2htlFYzHVLyTbXDOehB49CRzWuPep6AZqAEgqC6KtE=;
 b=nYmNAc+soK+1p7qQbTwbvLJKZSokh1XsTmqmjVuLS7yG0auWEXp22mekirsgUePuF2E8CM00VXtXy3sUvtHMbAMvCWyPggLV/d5DKNaQ2HzlFjIcr825JEp1+y+oC7Afm8dDX0bNEKhPlJ/bbDi0moA/lFQmj7qc3BucRxEfxOslUA1lw2iE44V9yWVUSC3QhDaubQIMZgTedexJTC2IhT6jI63GEaRm5axq45+9/zQbDz6wrsZI1GUwYgbPOXHck2tE4qCNuhZNAjL3Skr9PTWCCCCTojBK9ygwI7mtsGYQSzqjjeWTHcAFPt08NplH1mKHCxiZ8cjb93hZqnsTmw==
Received: from DM3PR12CA0068.namprd12.prod.outlook.com (2603:10b6:0:57::12) by
 DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Wed, 31 Mar 2021 09:37:15 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::31) by DM3PR12CA0068.outlook.office365.com
 (2603:10b6:0:57::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Wed, 31 Mar 2021 09:37:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 31 Mar 2021 09:37:15 +0000
Received: from [172.27.14.204] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 09:37:13 +0000
Subject: Re: [PATCH 1/2] nvme-tcp: check sgl supported by target
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Keith Busch
 <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
References: <20210330230120.268671-1-mgurtovoy@nvidia.com>
 <20210331002952.GA23886@redsun51.ssa.fujisawa.hgst.com>
 <BYAPR04MB4965DB825E1EDF0EB73827F2867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <58e03264-aefd-84f6-ba72-e8343f2e629e@nvidia.com>
Date: Wed, 31 Mar 2021 12:37:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965DB825E1EDF0EB73827F2867C9@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7891192d-50e1-4ede-e27c-08d8f42891bf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5086:
X-Microsoft-Antispam-PRVS: <DM4PR12MB50866A6EBA9651D9D266F471DE7C9@DM4PR12MB5086.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MmjfHWpWuUc4s29pO5HN0vyF3ZSeA/rjTvQKW18P2AygiudYaDhtAf2rdebwJLfUWeoonEaU+LzX1cNW+Exg5FuhD5/mskEQH4vVDtymuL+jezn3xQscVNWIfADtjxcpY0fwFEzUzcvIAf+Crc9uHtV9EFcPsvg6ywNQJuy/SzUMU68GBMFtHBjXQw/vtclLM7gWppYaidTCL0sLIBs4cDbMEXbJsE71J0Gk4WS+9WNRhnyPOGzvOA3NkhslsZxC4YZtQVwbjKw58zgcty7J0zsi59u4v2mRW2cJGyts12tq5hPtulgI3L3nR/wA2TYY3kywjJXWwfkVjpP+Lq4DN3NI9nAv0dl/5XQjs3wzBIHGb5rViZq6u7Bj93kiHnk2gGnGpQJjdyewn9h323vRznF5VITff68+qaOMDcaQbAA/P3jf/hJeLhGJksGTHqdvgPdFrQUysomfc6zjhf7FZ+QZLctAQbe8eSho+8vBexU6EqJkfBfHaRIpkxLQIJaozcSmuLw/Y2XMkvrhLOThyIYzFuDlFCI5Tw+B1estKp98sH+PM69MWRLdUqxRq729Oxrb+l59QbA1iVjs6SOOTbkmJibld1XmcphJEgL2azOYorPhRXWb3UMOB4q48zR5MiNF8/XzGuGLLEYxOuhvYbhS9D1KggFNWxIPSU9cph2PCpW0nikafv1cEl1m9DXF
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(47076005)(110136005)(70586007)(16576012)(70206006)(186003)(2616005)(31696002)(16526019)(8676002)(53546011)(82310400003)(8936002)(478600001)(2906002)(36860700001)(54906003)(336012)(426003)(86362001)(356005)(7636003)(31686004)(5660300002)(4744005)(82740400003)(26005)(4326008)(36906005)(316002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2021 09:37:15.3076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7891192d-50e1-4ede-e27c-08d8f42891bf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_103724_969813_F235CDCC 
X-CRM114-Status: GOOD (  13.51  )
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


On 3/31/2021 4:12 AM, Chaitanya Kulkarni wrote:
> On 3/30/21 17:30, Keith Busch wrote:
>> On Tue, Mar 30, 2021 at 11:01:19PM +0000, Max Gurtovoy wrote:
>>> SGLs support is mandatory for NVMe/tcp, make sure that the target is
>>> aligned to the specification.
>> Logging an error seems fine. Are there existing controllers that do
>> this? If so, what currently happens? If they just have a broken Identify
>> Controller structure but still work with this driver, should we proceed
>> with trying to use it anyway with the existing assumption?
>>   
> At least I've not seen any, in case they do exists should we consider adding
> a quirk if at all any of those controller's start showing up ?
>
I also haven't seen controllers with broken ID-CTRL, and adding a quirk 
in the future is better than ignoring the error and hope for good 
behavior from the controller.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
