Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A24C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:28:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA73206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 08:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UPNAJG3m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="pS/a5Qt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA73206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3xRWx0LlPqirFPvVeIty2xWmeeUU1/0X8kFJHt5ldyU=; b=UPNAJG3m/kxIJcLQXxBp4zG9r
	Q++I9STKVUO04UAZ/dFTdRjTO6IbVKMj394UZSWvz4/p5DOXzUiUl0cNRWKKDYxtoaG2F7/6+FgrN
	Sz5bY1XgmY7ZXopTWOiNvVygHwurd1DViRF9yR0DmeO82Av6oMBFnlqbxGv9uBEuqTXmNJYYLtGJP
	voHo/pN1oPo8AAULzCfve+i+E6PbKIWZXAP/VTf9l/rhTDAMPt3OU4IXGi2mdWUTO4dv/HHgS/TYL
	Ge5BrWuf7XH+/Y1eVtvkks750k8oPE1HtLL1qWRoDqJw/hFOGjp+oJMuJ7nAu1qsJglnepXKqaMEP
	3Oy508vaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ9EH-0001T0-LI; Thu, 14 May 2020 08:28:33 +0000
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ9EE-0001RV-EE
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 08:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM7/ueNXSeUjHEilkTKVcZGqo8aKKKx4Byi9QVTrnEPUySvoacEEKS/I9XFK3DsiEbayM3VYFpyd2zqmi0egp/sBhKLa8KdyOU9BifApX92OoV3MAqTE7u16z2ZyggwWtNxF+Pu15DlAaIJCiEjyRrhWDfeHNC4uLjSoA17rCGFnF1gtx7fsIM3xqF/Hk2ftJarUpnAjPccofgb4btWz+qWStpuH8SOeYpEN0bwduK0MaTDastO3YGqkbO1cukQBh4S6c2TtrNJlDKR9cqbzzz+A6J3q5BNBDl/fTsO7ygzl3YYhAlTHIruxbs8cCtD8w8wPTWA4jJ1aaB/CKPhJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLt6jNbMRYMYKVwg2aPZj0mfONafY9dCyUy729rCQC4=;
 b=lCUD+WBdN1EqubR3ZgSnbxrDjKbI6yEt1T/SE3EmdKzOYufSUhgF6aaOeA7ijpl8IIrD7sMSeQu1v8UDLELrJbZiz9fQqFT6LdU87JFP1sn6bMmmRmQM2n5S5cNuGw3Vuj+nW8x8T3m5OKErxqPyv5oga51ZzX7hYYHjo/EIqT/nHiLR/9vHA6YepA7Zf9PrjVE2UBDsso6F88Z6ZC8oxwlCuxtqqAY4ta2VArolCL+SYDk/xXISKew0eqk6yKQfcfJTxGs1t7dxUkzrny1KfydS0Pkg2LoM/4sR1k49NCOo52LHEmaVwVcoFz2U5km1wahYlzSv1UmoVDXZO4oLtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLt6jNbMRYMYKVwg2aPZj0mfONafY9dCyUy729rCQC4=;
 b=pS/a5Qt9E+Mx0PgmPlbbBjSMlE1dKBeR9mvhQ/8CDB1Cc5A2sEE7+Y3tAwIsFqpW0nsfGPhU+bLoM0YewlnTkOhSFMoro/MYa1rW6RG9XEuM8wvrPTZ7vL79171Qivk/97qUkxr7aQHslYK03p9n7wV6wBAcBfpTWvV2EGc71xY=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB4913.eurprd05.prod.outlook.com (2603:10a6:208:ce::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Thu, 14 May
 2020 08:28:22 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 08:28:22 +0000
Subject: Re: [PATCH 06/16] nvme: enforce extended LBA format for fabrics
 metadata
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 James Smart <james.smart@broadcom.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
 <20200504155755.221125-7-maxg@mellanox.com>
 <33e04c87-f41a-e5a4-05f0-807d52bb78ff@broadcom.com>
 <yq1v9kzw7et.fsf@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <2ca746a6-0853-e5e2-f898-6ef9fefcbfa7@mellanox.com>
Date: Thu, 14 May 2020 11:28:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <yq1v9kzw7et.fsf@oracle.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0104.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::45) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR06CA0104.eurprd06.prod.outlook.com (2603:10a6:208:fa::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 08:28:20 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cbfbc268-0de6-4dae-df2f-08d7f7e0c36a
X-MS-TrafficTypeDiagnostic: AM0PR05MB4913:|AM0PR05MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB49136D7DDF2248F5BF35616CB6BC0@AM0PR05MB4913.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKTHc9+iJKlFwIZaZbZjs2TjvVCClH8p9Q7DUT0QlU38zgX+7rNlmV+PgYxTexSpqZ/2KRT6VWJfIj+tPuFajDr5LN+1J6LD18wdL4Uo7Jdceo7Whmo8VQBTLB3p8fAursD74KH188ob5wgymhR3ZZs+fSRIe3B6eyl58UVXmcpnkCBHq/hm1jC/4wIdB2MoDg6BIZyBcsZR1cpdHdQLxG2tU+DJ+TUZi1CIK8Hjat37+DrBxtRjIg9PF1Ny31J5+Cg/iw75iJ7fKn1jrIjJKysoUIyap9OSV9UgFx6sBfksHE+Me3vK32xD8Y6RgstGyrty9GFx1M/JKvFluPuesbar0Rwlv+70V6SnAAxERcVSpKVxNP58QY+NoeFth9ODg8tqOm2strZ9q3QAR4epTiFysqgKeDssKViOJggFRnrX+ul/WywxHsaYpKiVurDXaA0b2uWtHNFqxrPfUVpkWuu4N39q8eR4+m9lkqhAiiBO03orzIsTXfOFFdqm0THe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(107886003)(31696002)(478600001)(31686004)(110136005)(186003)(4326008)(5660300002)(16526019)(26005)(956004)(52116002)(6486002)(8676002)(66946007)(2616005)(86362001)(66476007)(2906002)(53546011)(66556008)(4744005)(8936002)(316002)(36756003)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: MeCIO1m0L7wWDS5R2bKED2k6DfQkz9Fxd1pp+8OosZ1vOhbEcS/VfMITRzfYzmejdjF63xpWZv/4VH60JapNMZ9xAJ+In0/1a9CV5GUBag2hN1h5YP4oQe8lDfZjQpYvnKp/35p6ka6fNsr2ZOavkGJuifDvGlJDQVJFRvahJQ0uLzAkyIO6akswRlEeC41Og68+IP9gaxiKCMdEkIW+XwbrOjUqfNayTNVpT8nu3MW8AI3jLjnbJdydDMgTmX4A04odB+hNC5qFwIZWxPwITGRhXxFBMm4I10Ppo2XLDR+c3yxc2eQ63ezwxHIRn02AY17XtueV71LgOEzaKJcIrIP9XfMePEJ+7t8WRmRDmDPKXYMtT+uSKlbwNZqmiulpaByrmBpOpPmiBKYwcMA4ijQj2z+VN/0LNj5qpP19DWceHUEjQmgcZ5CGKXUxlTCMif+o+Nkz6Faikvj2nhWMBg0ijDpg2Y4LKN9a+FfkX3jcz20lKBnctuNSr5S9Sfqu
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbfbc268-0de6-4dae-df2f-08d7f7e0c36a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 08:28:22.1489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4Zm1SghGa9xBpbnQGvFfkXlFDhAd2v933zeiRnRJ6vrFf5oyGgaUYlfgG3U8rbNwZ5fXH7TGWTpEq46iPzNyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4913
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200514_012830_574170_8E059AAB 
X-CRM114-Status: UNSURE (   8.88  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 linux-nvme@lists.infradead.org, shlomin@mellanox.com, oren@mellanox.com,
 kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 5/14/2020 5:56 AM, Martin K. Petersen wrote:
> James,
>
>> This is ok. Later patches will should deal with no block-layer
>> integrity buffer, but having the transport port auto-generate/strip
>> interleaved pi data, as we will want to protect during transmission on
>> the wire, not just PRACT=1 it.
> Yeah. Whether the integrity is supplied by the block layer is a per-I/O
> property. Revalidation should record capabilities, not enforce any
> particular set of I/O properties.

maybe the subject is not the best but I do want to verify that we don't 
have a spec violation for fabrics controllers.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
