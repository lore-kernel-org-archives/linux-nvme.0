Return-Path: <SRS0=oU3s=W4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB198C3A5A4
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 11:20:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 930C52190F
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Sep 2019 11:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="slbijMsM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mKHYjGSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 930C52190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nIlwAmoqMM/MyN5zcLipfPPX8815UCP2VqnRLM9aYjw=; b=slbijMsMPt1BXlCYKwH1140KS
	kogPnZYNtkvJckO+rSlODxdY9H/HnfEuDLynIewNm0BrpifZTKpDC+ksQr/o9Ya1J18XudIPf/B+C
	SSDJoG5HA0yTIkAwwJ0UJ3UUwKwhpXAaBFOdCdZeTtnjUaeNtRLBSNeg4nDwLWjNhwd5FyJUyQ6q2
	DTP8NyYUOWhkoApV1n/KNpvF8b3hoCXH+8kieQ4mwcXKNiW3YfJJSuaTpMdBx6lLTa9q6Wnx8Jtia
	4NrQCh51wDvZHvFnqLvvL9FUNTuq7tWCfK1cYa1idCtkIWu7Q/VtVHRcxce+aW3o7mTVNiNIJBBcv
	2qWKFAAGA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i4Nti-00066j-WA; Sun, 01 Sep 2019 11:19:54 +0000
Received: from mail-eopbgr130041.outbound.protection.outlook.com
 ([40.107.13.41] helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i4Ntd-000667-6j
 for linux-nvme@lists.infradead.org; Sun, 01 Sep 2019 11:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLq+KJuIp3foHcL1Leltsv9Nh71FXJlyKDCeMlBqi9mc8F7zxMZsr2z5LhtJC7mHvq46hQy62XVBLUFev4YtrXOXnQwnpplmdkDrY1lSK4ND2Ysgs9Ov2l2bXZ/Gq1GCqhLjM7S95Kgs8kkdWKrko/87XUIKGOfPRkCaWqDOy+4Q3hv6yBKLI+hY4uVwkJrD5b+JWh4hP2ypwtqtC3uMM6w+iZGb7lCq2WII29JWq3AN7xqxqKisiCszqUA2Ta2uNhSFdES4gKCUQuZd7yaAzQAkgAD9GXdqxktaIOYYfPcTJRH2yTyqsFDh/1IF8JnO/Xmd3idgh8j9ordVFJEtNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keDdz7Achhb06ccu/bqS1DVuxRIwAVXFbNlOt9dvhAA=;
 b=Or6WmzK1qU8KfJmjy/0N5BfJ3Kb5pfi5GQFeiQ+35C1+dfSZDlHWRJD5brbpy7NChd0ARIvFGO4Y+MFAuQv81G/ws+B5ca26h1Tem5lOvLuuzWlHlQeIJriYx8PsD/CWcaS2soD3+CY4bj5GtKEl+rQQeaVuEn+aO6kofIZ95QThnoQkKhLlfHN2f/meYcGCuH0giHNbBEE9fuV+yealn37vw9SC2Aew5/iZh9CZ5AYFjd6HR5h9WAREAytDpkjdZ38xtrq5EaeGP+PTwXQR7DprZJuLqKr4g2M1JPcJLU8VNY0Hhk2L83FgyOnXJVqF9IHMTYjO4fWkOP1uWXFOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=lst.de smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keDdz7Achhb06ccu/bqS1DVuxRIwAVXFbNlOt9dvhAA=;
 b=mKHYjGShS5uXGVLX+T5XO5yWorchHb9rq8w7w9hD0PJ1oC3D51UJB4YlkF7zEAakIGmcbQWoF02rjkF03YGEIQ0j85zy4DHckgeM0Qf4jCH/Apj2WnuU4UlG51Ua9Di56nqYSoY9uiTvOqfT3cFCDweKbAUJePIw8pRzzoFZPRI=
Received: from DB6PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:6:14::49) by
 HE1PR0502MB2921.eurprd05.prod.outlook.com (2603:10a6:3:dd::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Sun, 1 Sep 2019 11:19:41 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by DB6PR05CA0036.outlook.office365.com
 (2603:10a6:6:14::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2220.18 via Frontend
 Transport; Sun, 1 Sep 2019 11:19:40 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2220.16 via Frontend Transport; Sun, 1 Sep 2019 11:19:40 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 1 Sep 2019 14:19:38
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 1 Sep 2019 14:19:38 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 1 Sep 2019 14:18:51
 +0300
Subject: Re: [PATCH 0/5 V5] nvme: Add type of service (TOS) configuration
To: Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Keith Busch
 <keith.busch@intel.com>
References: <1566119335-15058-1-git-send-email-israelr@mellanox.com>
 <054fa45e-a2ee-d291-4c71-75f7a1872f9a@grimberg.me>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <43fd7638-a5da-1ca1-0a3a-e86c3e287f4e@mellanox.com>
Date: Sun, 1 Sep 2019 14:18:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <054fa45e-a2ee-d291-4c71-75f7a1872f9a@grimberg.me>
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:NLI; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(2980300002)(199004)(189003)(65956001)(65806001)(356004)(53936002)(47776003)(53546011)(4326008)(31686004)(50466002)(76176011)(26005)(36756003)(186003)(6246003)(5660300002)(81156014)(81166006)(86362001)(8936002)(31696002)(70586007)(7736002)(6116002)(3846002)(23676004)(2486003)(478600001)(16526019)(2906002)(8676002)(230700001)(336012)(446003)(16576012)(110136005)(58126008)(36906005)(316002)(486006)(305945005)(126002)(2616005)(70206006)(558084003)(229853002)(106002)(11346002)(476003)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0502MB2921; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de4ce5d6-8a39-421a-b3a3-08d72ece4859
X-Microsoft-Antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:HE1PR0502MB2921; 
X-MS-TrafficTypeDiagnostic: HE1PR0502MB2921:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB2921557B285AA08362CFA47DB6BF0@HE1PR0502MB2921.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0147E151B5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: uPMhQN7WRZLTkbzbJyE32dfPnr+nScZixAQ3T1uSrGhUBaTUY2qtFsgiJGJ1x5/imgKQMoOMaa8O4SkNcsHLXtdzo4d71BRSa4Q3dTyCT7VF9BZ4cR2sshW1FLo++gtSon0QlD2exIexOMShG3S4ClizuxZJO/p4//G9N0PSLCfQzjguliYl883Wf51Zfk36a+TD30YduS/Cg7UYEpYBYJDKDZojRD1jPFQ0/itAkmHQkII5JSo9l3VHxFwWBY0uEUo1nr8N6v6s1k5F7/sTVpgpmmnHQiOFkDtyGPDexj51WaAV7eBA6em0NG9lzMQK2b21uzChs8cmQ4TYu1wm+IqBoaMG3WFCYzYQ53Lw4KSApmsV0ceRtnSNjCKVYMnwDOmKlOEpPu0ODgA40amJRLn99amL4WEMM5RtFGz49Ug=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2019 11:19:40.6191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ce5d6-8a39-421a-b3a3-08d72ece4859
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB2921
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190901_041949_314626_E321FBA6 
X-CRM114-Status: UNSURE (   7.37  )
X-CRM114-Notice: Please train this message.
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
Cc: Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 8/19/2019 9:49 PM, Sagi Grimberg wrote:
> Applied to nvme-5.4
>
> Keith, I think its safe to take nvme-cli patch as well.

Keith, was this merged to NVMe-cli ?

The series was pulled by Jens for 5.4 merge window.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
