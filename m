Return-Path: <SRS0=kA4j=JG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94D9C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:43:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D76461028
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Apr 2021 05:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D76461028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=HX405JyTpJ9KZQwEjunA7mPOXeMsOizy2eGB4JAmuJU=; b=PmfY1jBvna+8x0ffECIMMHEmi
	wzk3ZG5FuSousvNHfed9sPbODgt6UBSEa0TVxtTM85v9xfyda8zrQNMkfLtiCbEGBvauC7MsbFbS8
	0qO/v+k8DzGlXWdIMM5pM1SboHRqC4TRGZz8i1MNvFlKnpoP665COeQsL07cP4+u6i4uAvlHFwN/3
	BVlpKTn0TliyeMGViMz48TqUcVbJZB2TPPYEaOFi+uDR2XOFkZvAQV6j8ThRk5U6cIszMt8U3PEhh
	3cE04WBztbOoeUh+YdlqlVx4KkqNPJBS7nxmSNQ1biA98ZVpUi5chr6oaQXEXfV+tE2M1+R/KZ9XE
	kkowrd6VA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUjvG-00ABHF-AW; Fri, 09 Apr 2021 05:43:14 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUjt9-00AArD-9o
 for linux-nvme@lists.infradead.org; Fri, 09 Apr 2021 05:41:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617946863; x=1649482863;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=rtw0kdbrCdtXdboWj62QK1ttz8u84Oaxn7QLLwZafMo=;
 b=LXqofG+wagGgt/8wKhkQI0WYAHnBe8csBnpAfgOtpbt1+mI8RRRRw0ce
 OJX8djeROftLUlC/TswYrTt6ScoR0Sjd2dYuMxyDByhtjNRa3Vfr6UTYY
 KKW0I/haA4WRqqeeHdnANyxck84hqNxzE3e/TKNqtkjBBsKsPdX2/mDjL
 7ZxfeXu1ZOXiHC0NtJrOs+zpuMVCv86DqAeqoA6sweXzjltR+yE/YpID5
 WxF/sF+HrrCzl9zKqep/5l6raQeEkEFGYhLOLlHAzNfoLHCMvOO8J3x/a
 bOEPY2ReRDojUrCsuOzSpikhpO6MUsw86z/kTYwdJcqO2wy6kXbmjx8qg Q==;
IronPort-SDR: 5J6uOA/TzHr8Auwk7Lbu2+b6r9nU9lEnGa2qJ0rZjlU0GZhtO8dw4lqK3MqKAe1+CYu5bQjch+
 3Rw3M/qiLJBEDMitzKmgMI7F1HSfiA50Y54enoBoNpVuv+POq2OS3Ic9z8uBhbRJcTstgEfGrt
 eMhEiI32cAeLJzePyW3h3YTjIpOdd+emA+QSnwBv98oAT+wsJjMjkRWUl3wabm4oyprxc847JO
 wQZ3AblXYEVonkA2nb+5YJv42mgKrkQWfWdywhnHXPWwb+i1L9bocOgurmz7RkcDVoUkmGEgKy
 Vms=
X-IronPort-AV: E=Sophos;i="5.82,208,1613404800"; d="scan'208";a="168772320"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
 by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2021 13:40:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tyxm7V4hyTyE+ddXqkqZBWK8JO75HlRDW099Hj8YgU7dgX+btxtuQ1EoJbcRWM+7guN/omCXTRA5oTiGXE2JEW+F7GR7HWYeNeRvWK98cR2Wo1guVu7dE7o44YFhcHCCZLvoZP+gNUjOm42VpIxeh0Gt1vz7pB+K2D+GK4b2VCV749SH+HVmbNsVId2fo+0/bVDkgoxKGbdG7OT863iYSAPERatODJMJ8Fe714OmW+8DLIFqCvMPvDXSFA7Ww9MoauBEpOL8N2pTlgpjTNpT3ybBrr5ml5mc8/vqM9y3W1bnmEuc9PR/FYgPhLxOU5cbw9Kzhxv8wS6h0PfiKr44Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtw0kdbrCdtXdboWj62QK1ttz8u84Oaxn7QLLwZafMo=;
 b=XYaGIWqId3B8mWmRPdjCu3FrLIccJRdAgDPHUF4V63IWI9TIThAPntHFtEP/9wbnWisw6mG5bWfUTEYhEZBW/NU/jGeW71th2wfhf9cksyY7SAov3rGSZMjEvBih7Oe4woRry32m2WUxUVLnws3PTWnbq+wgrS2iWai9WFic8FGofdofHCIpBy9yjkSus1sbpcYmJJ0Xdg6Sj7TMjJxjeXL5DDVi7W8kMeJvcPE64WG5aWE1niGoWHQpynrkPoCZZoCR7ZcvEC3qRMnsHV/pKGKSqisDWJ4JDTlx6J3Zu8f3crgQ49xt6q1pOya39FsyIdgKYvZQoE9k4mu8pEJrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtw0kdbrCdtXdboWj62QK1ttz8u84Oaxn7QLLwZafMo=;
 b=oVep5TWI6BVpdH8q8qzygASKoU0M+w91hbnO1da31cZJha4a9C4aFmIP93V0cbdKEKtyBblHv5nSWPq2h8sfujb0rMIQ1oZndr1C7ynaAsp5sogcOSUirzJpKxasZsAKvBQgqGRmiEhQVXZ+EoNI+4lWcpLhjnZeDLSqIQarX/I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4040.namprd04.prod.outlook.com (2603:10b6:a02:ac::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Fri, 9 Apr
 2021 05:40:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Fri, 9 Apr 2021
 05:40:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Kanchan Joshi <joshiiitr@gmail.com>, Javier
 Gonz??lez <javier.gonz@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
Thread-Topic: [PATCH 09/13] nvme: factor out a nvme_tryget_ns_head helper
Thread-Index: AQHXLHOnpSw6gjdWI0mzzQkvozx4/g==
Date: Fri, 9 Apr 2021 05:40:57 +0000
Message-ID: <BYAPR04MB4965789D16949080C8800E7D86739@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210408120842.1450092-1-hch@lst.de>
 <20210408120842.1450092-10-hch@lst.de>
 <BYAPR04MB496582CF89AFF355FC0738BC86739@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210409053947.GC2575@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ecfb08d-ad9f-401d-0b04-08d8fb1a0cea
x-ms-traffictypediagnostic: BYAPR04MB4040:
x-microsoft-antispam-prvs: <BYAPR04MB404057515B312FBEC3BE31F486739@BYAPR04MB4040.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mOWAKnP78y1huSgpT60INK+qP2n8uavnG9QfQylrfjF3ZLMdXd5o4u8E8XsfExyifMFpVIsq2SMHjI5RAu0SDOm6zlg8YktjW4qmipp636c51qnUYewvVEQMmIPgOkhgermKYuJJnU5jsU/g/GOUO8PD3Yq+I32/KAuQLPcTo+GIQp64izsHi7RNMXOjtfd8TpCIlxFRpEnoKNIeiDgZdIg6m3xS9PPvBOViU918RLta8mjPv+dhS/nfXlC80FghLVRSbk+Od8lHFNTWt/+kLRJdIr5l4MolQivDCmxHRwBPbqoKF1o93hsEEoqJWygRdv3dtQAVUMFHLk64lZ+VORyj6Kt19pVf0QCdWY1sBn/ccHLMAKahux6I5sKLFN+zVVzmo6kI6z4DJswKvkch0rPfYc0082p92OYXep+NoJMzFI4XwuYRzGj+castVoF1h65tw2bPZm3X5tgPDMcXVxTUxCZTSgBlJH9wL4SzyR7kca410w6rcDu5oGTOg+fUA3+U7aE4ujGsYXEqwlM1t25fLB0L07YzE8PZ4vtoGdVitNgdfBYHbuyo8Ao9QaMW9VyMuqTEUtsCGp9ejiMX11ehetEG2APRq5+/gQRHVZQ8MIMLOHB5/A8IDv5q0atQpXxktW1ell8VX5oe/vnh1bZcSRw5xMQiJFdwp1DBxKY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(346002)(39860400002)(376002)(9686003)(33656002)(2906002)(71200400001)(478600001)(55016002)(4326008)(6916009)(316002)(7696005)(8676002)(86362001)(52536014)(8936002)(54906003)(6506007)(53546011)(66946007)(66476007)(66556008)(64756008)(186003)(38100700001)(26005)(558084003)(76116006)(66446008)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?m+lAbI8UFop3j9mLLkvOIDSKtU0+gFo0ulSkCKxlI1jBUBibVvlJrr1Nofq8?=
 =?us-ascii?Q?RTv3wEU+CiCWg8twIKAhusB5uvkOdIWMXhq0V/CxXjDzbbEimXP02qS9lhGG?=
 =?us-ascii?Q?mWDhonrc98uONjLYnpNjLiQSsSXGlAdbotGEKmagw+uuenu4mNZAGWK6wKxO?=
 =?us-ascii?Q?wo5BtS4VPyzemcMDSmnyHfcwZTqyXw83/iBEanbbjxfnQDbHkgmQ+PTUQ3YC?=
 =?us-ascii?Q?hH3hWjNLR7yNkj718+wnlpUCTglVigqptnXjubnoy2BdTP2wgTduSsORBrrJ?=
 =?us-ascii?Q?k4uPRmLxJO8IqVhHgoww3ODF4BBMKtP3B5GAl/ZkQVxVhzTnSSQQdG1KTRap?=
 =?us-ascii?Q?0iMjt50vtEKuEbVt0X/F8yc4jXCG9RuteLIwruty1dH4mrqR8+Piv2pmpfU9?=
 =?us-ascii?Q?2KxnWEXNYI3QLHFNbd9B9O1/XlneUoUTxQYvSnZElvLc9w0VgL1fVoSNuJlW?=
 =?us-ascii?Q?sfP1dzcgkGZUR/EKYxOMOXONSwk51IyQ5VFG+nZPNq62OPB7Ks8Yfsn7H5qC?=
 =?us-ascii?Q?4jZcatmDM7wliYWjNjwasr3RgzP5lAwASp5tUbbbxqWDxovhO6eKKh7dG7wi?=
 =?us-ascii?Q?5xL7DvphtQYkdCOdosTDt1q/2JxKdUqKn9Jb3pMmaMlR2oxdGudkdopKMKVI?=
 =?us-ascii?Q?Iv377O0kaq6kEWJxj3FNwcqwUpGFH28eMph/8EiGtQ7FXEDtLwARurgz7qYI?=
 =?us-ascii?Q?C7UmHLm73+IbHgz3zGk6kdRbMeOXERrViS9vaDeZC6o44+WC2MkTyqwrJ84W?=
 =?us-ascii?Q?G+nE5tMHoMTkbbFRC2w2hUSHztCoBb27aKpBCmBx8NSszapTpHUXWaD7cPsy?=
 =?us-ascii?Q?RoYDoF+yfURhkxcXQVgxH0EuHy1R6xAk7mgu5aejzil5m7ND/bdqpjfw8cRv?=
 =?us-ascii?Q?J+pvEg+QejkjfMHxplRY4/oxJwZ0DWDbTY4fTqJdokdQaElcOHReqlBiGk51?=
 =?us-ascii?Q?8OFP6Kb2fGw4AZ03TcCvxRFjRMIOYQgkj7evejtSPwNt0J6wM6t46UpYs9na?=
 =?us-ascii?Q?QrWsFyqV95+9fZ/0LX0EYYF405F6aKxZqqLkp/NsdmI965Wk6cVq2ogG52Qi?=
 =?us-ascii?Q?Y91u0kth+2eL5B/U7Rjf2lWoWwDffU8Z/vb5kyes5uXn3v2T6BxOEC7l8xb9?=
 =?us-ascii?Q?NWL4qY6RO/ScUgYXWZz3n3a6njbSdqUwELFRkptM5LZXEJg0QW4RxkSg/DAI?=
 =?us-ascii?Q?uyqCaa2Y/RAvvSCaviezH3syST27cRAOLsIia4aRQEDXTFieCTd7zbTr1ov8?=
 =?us-ascii?Q?EvTbBUMglaPFyqIB17ThoklfvkpOvxmvuZS3kXgS84tcOV9gCgr94Mt+D2nx?=
 =?us-ascii?Q?1YEZoaHgwGXccpIVz6o3KLciUFUvgi8aGb5C1lClz/H7VQ=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecfb08d-ad9f-401d-0b04-08d8fb1a0cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 05:40:57.5572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMgOe53ClGuxm64QhLSLuUSL0cYDP8y1WOivwOPQ3V6dOhBcDKNb2vXjz04SajKVRIJxzJ7CH/VigC/Aa+S0R7BXUdcN9U4hImKSFkTw6zQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_064134_884591_71D00D05 
X-CRM114-Status: GOOD (  10.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/8/21 22:40, Christoph Hellwig wrote:
>> Should we wait to have a second user for this ? unless it is there
>> in next patches in this series.
> It is really to be symmetric to the put case.
>

Okay.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
