Return-Path: <SRS0=McG4=37=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19064C352A3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 10:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF99E20842
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Feb 2020 10:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TgzIuFor";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="TG+2XKgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF99E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AxRvNtsaLBkOuff6UVdaN3r1cDqYGmk2Q92WKRyV7ww=; b=TgzIuForq1gQ8XYhu40axJFos
	IPWUEqHiwylpzzSlpPXga3IaJAF9IojMNilM4eJIJdFZZ2Eejig/s7PkoVMsJCO2ogAnJtMBXJGV9
	WPKuO8k68Fyc4kvU/YSHY7o5CQBCrTsMC4cXqI4K6pLio0wmjQx0aLTGCrq7tCX81AcATMFEXzRNp
	vo1RQLAI1KHLGz0bIkKZo+KdYYiLgOyh8P0saOEsDVs2hEJn7rB07zc6w10TrQDQ38G9kxImf8aO5
	CPsYlUItvD8BPFS1TUrMrFPuhIvEq4XHroUJTxeQkVS79jc6dbYpHkRoHsm5k33Cs+G8oFUWhYPac
	MMxcBWlww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1SXN-0001Bo-Gv; Tue, 11 Feb 2020 10:13:01 +0000
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1SXK-0001BL-JK
 for linux-nvme@lists.infradead.org; Tue, 11 Feb 2020 10:13:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnZn8f4243q8w22oLmyg25xwmhDuK29RFaC0iC9lCzaSx8lD9i0Sv/Zfkrsvyubv/kecP+4PN9l4Ycj616CSAMA9ZytCbri+T7Aar3q4UJT2DPExzngOmfDDCfPYskoUr6yZui+c5oV2OmUPPklODfXFikRA9uWvH5UtH346w127tfEO9Zl6HsMnF11iO09AYidy6Zw+nxyXuURIMFCc/iKpOBR4ufWZbLKh8FHRecj4uASBJyCuCyqXUisNtTva9+TNVnsQWx5FLFhBdVSoWt591jCIuenfms2iNo6eoyXT+3/W7LbV0s/NmRKyteTNLmpZBT7TAVhW7FSGrQUkPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocC+fRQiSZhZto27wNSKE6akxa+pu4wZp9dR2hT6Uok=;
 b=CiGhNMofigOWbyUav8Ul5KqHokFdwPpOnQheAyvKnl+qw5Pv9ArBJlF5ImSDPqnuR6/dCreyOsFH8yAxKp230hitKnGefrw+E/cQ4/OZfOzfiUdWO+UGJaimQO92IOu4bqiyeJB25w5OB0Jc4n0tRt+uTc2jCvTCpHeXHJYoaYRfgeqftylu29zUOf0KRxz4C/HKhvCIZDQWbf6XC6epD3aLKNoV20vTR3qWcuvOXqrgk7V50H0Psk6kqfq1luLpgpvCQrFXgeqVuJ7f5CigldXqe2FOApDjJQ7fMdUzoYkTMvqnGc7lfThCuBykyGqmT0KoO8YVDXefrENfRW0kUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=broadcom.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocC+fRQiSZhZto27wNSKE6akxa+pu4wZp9dR2hT6Uok=;
 b=TG+2XKgrBaxlFgyFPv5bVYKpFFB/HWQaUyhFmKJ75bWvHnYZZGou/c1LzaX9piwDtws1uU9K7zt7vIdj0OjAOVYaEvMqN/XWwkqfwfvgvtpT/hBQ/hIfreQgAtdlhKpnDnXGvpiwgh62Ki5UQuvYnaxTk4bc9Etfx+/LODP5OxU=
Received: from DB6PR0501CA0032.eurprd05.prod.outlook.com (2603:10a6:4:67::18)
 by DB8PR05MB6698.eurprd05.prod.outlook.com (2603:10a6:10:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.25; Tue, 11 Feb
 2020 10:12:49 +0000
Received: from VE1EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::209) by DB6PR0501CA0032.outlook.office365.com
 (2603:10a6:4:67::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Tue, 11 Feb 2020 10:12:49 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 VE1EUR03FT028.mail.protection.outlook.com (10.152.18.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2665.18 via Frontend Transport; Tue, 11 Feb 2020 10:12:49 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 11 Feb 2020 12:12:47
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 11 Feb 2020 12:12:47 +0200
Received: from [10.223.0.100] (10.223.0.100) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 11 Feb 2020 12:12:46
 +0200
Subject: Re: [PATCH 2/2] nvme-rdma/nvme-tcp: Move err_work to nvme_reset_wq
To: Christoph Hellwig <hch@lst.de>, James Smart <jsmart2021@gmail.com>
References: <20200206191342.10190-1-jsmart2021@gmail.com>
 <20200206191342.10190-3-jsmart2021@gmail.com> <20200210170442.GB19584@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ec482da7-1794-eea1-555c-31c76e792e4d@mellanox.com>
Date: Tue, 11 Feb 2020 12:12:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210170442.GB19584@lst.de>
Content-Language: en-US
X-Originating-IP: [10.223.0.100]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(16576012)(316002)(53546011)(36906005)(86362001)(478600001)(31696002)(31686004)(26005)(2616005)(336012)(5660300002)(36756003)(70586007)(70206006)(54906003)(110136005)(81166006)(81156014)(8676002)(186003)(356004)(2906002)(16526019)(8936002)(4326008)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DB8PR05MB6698; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77c732cc-7a6f-4cbc-2e30-08d7aedaf2aa
X-MS-TrafficTypeDiagnostic: DB8PR05MB6698:
X-Microsoft-Antispam-PRVS: <DB8PR05MB669814347ABBF1FD5DAE9F80B6180@DB8PR05MB6698.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0310C78181
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U//ky26V16VdSInNHZ7Z3xzwhLcqsFJXqG5TGdKa3fjtczO0fcx1MGiN4x0qaeaW7arraMt1Y3JkYaz/fMG/Y7Y+BN/UYWWrUiVp0My32Q4g+BLLo+zA/gPKf0E2QWodoy6+RC3xCYmCXZoNSvkwQx0+faL33+Fa+jcyqX7ndz5SKtkE/0fJShKqgQlfiyHvb0Dsha9RGrOyOCftm1LdPvtsooxzBfDJP3KjuCNlab+sxjhEeP1XIi0hYkvrrz7JXGp7arCj9+UmYvETaCJLRk8tKwOi3T1OI+3+U7N1lnbOQb4tjFC+bbCZMKujrMzg/4M/S9K9wyP1lqcXbTEbxaK2lNKt6lPnBuQdKvpVK7eyWZcgrKvi79Iq39IGNZy6SYlgCUBN2tDJ/5O8T8HDe0u4dsktJvGDxXMnAXA6APd4/WmwKNYJV8MrvBF6GaKX3imVGfEp5rLDT1Rb6AZpTQxRXVaYFa5ykDqapeGH0TC6Uz6EvvvhwFeY7XiUkian
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 10:12:49.1335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c732cc-7a6f-4cbc-2e30-08d7aedaf2aa
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6698
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_021258_637246_1053F873 
X-CRM114-Status: GOOD (  10.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Nigel Kirkland <nigel.kirkland@broadcom.com>, mark.wunderlich@intel.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/10/2020 7:04 PM, Christoph Hellwig wrote:
> On Thu, Feb 06, 2020 at 11:13:42AM -0800, James Smart wrote:
>> With keep alive processing being moved to nvme_wq, it potentially creates
>> a conflicting position with err_work also processing on nvme_wq and needing
>> to flush/stop keep alives.
>>
>> To avoid issues, schedule err_work on nvme_reset_wq. It looks like this is
>> not only a good thing for keep alives, but also brings the transports in
>> line with the RESETTING state and processing work relative to RESETTING
>> on nvme_reset_wq.
>>
>> This change is made to both nvme-rdma and nvme-tcp which have like code.
> Shouldn't we move both in one patch to create a regression in one
> cycle while fixing the other one?

Yup, seems like these should be squashed.

James,

did you run some testing for RDMA/tcp that will trigger this code ?

Fio + port toggling for example ?

or brutally "killing" target during traffic that will cause timeouts to 
IOs ?


>
> Otherwise this looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
