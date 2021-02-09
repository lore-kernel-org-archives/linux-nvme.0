Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6885C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:07:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2A664EB4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 15:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2A664EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4DSeeu6g6tWefMkfajocDFWFIZukeR3J+D78krhLIa4=; b=Akm6IcYHjjNo49ooqlhX/27Zq
	RcJnvPRMF1JG/gEAI4UNvRXAVImnlRVbaWkbVYHM01mZWKj4gkrot+l0jdnOSKAY3rIZIESU3lDuM
	DmtE8np+IpwE34BMzRQrJAihvuPz1WUEr6rdvThTq+OmAw6Buqg7MRen+pxAgLUrqnHuJsRhdjRrI
	PP2uxfaja778kp+KwFf2MJi8EnPTAc8lqfusZabqVYY3JPh8hsO9Dz+ShpQd+gkkaMQjGr+CZ1CL2
	drw/liQb47skF5ooXyHdEN3jsG4gnSFscQt9Nl9x1LfQ7Tu4VPwuTFBnOl+FcSQLZ5XxwZlOac2Ve
	MfbwwiAng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Ubk-00046v-Jt; Tue, 09 Feb 2021 15:07:16 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Ubh-000462-6U
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 15:07:14 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6022a51e0003>; Tue, 09 Feb 2021 07:07:10 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 15:07:09 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 15:07:07 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 9 Feb 2021 15:07:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xzk99+QoFIEN3bAep3VHPc6cF2mFKsfBDuXQQjPpF9SA+RiXobYmjy+n3SQyKhgyJ6Rz91svL9zxQ90tTqkKK2Bl/b+xu0OMa1lD8hK7uJQq93T232xRG34ZXuOA6+qwkNrZZ9h7h9/PIov8o2MZcbtDBVrtdmgzlMqAWtPlyEqYnF2QowqZwRZ5CI0pXlvFrv7eBtxpiLv3GASzPqKg88GyCEWq2kptqRcIwyVqAFgRMYOSB1lzFO/wP3++4/+ke4bS+YD9pBGXl7axYzlqwDWb0GfzuX9mS6XZSygnn5efV5/nQcTh8G3pllvVvu0/7ZGBYcOrjw3DuSSft8FOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J6JdJ7irXTcPEGL72V+HI2tpohIvrPiue29nlJ+c14=;
 b=TF9NDSu2PPupcnNtHt6R/mPhQ0s8C2PWG95R8d3DuEhYJ+uzt9TslUmCHjELvHoM49ODyc0SA5uO2OTwT7tCggdHgnF6btRf642Jj/NQF90ddVBciE+iLrlERglmVlwhpytA9k+ZHBMec3/f0ufJ4fJS+uYDOPHOe/OC6WbDXcN/BHXBxHbeGv0sQM5H+jMkVknRgapMI/JrI8i3cTp3iN5S1bURU7s7Pf7BuJCDhZ89xvXTRm4H0BmAzTpsjQvdmYA1Kir15LHbOKFI0OMiK8KJRB1d1sR3pf5FbttNMbnth7GYackNDlzi5L+wkUXTCwT6UqsfL0TqrFBTkTk78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3494.namprd12.prod.outlook.com (2603:10b6:a03:ad::28)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 9 Feb
 2021 15:07:05 +0000
Received: from BYAPR12MB3494.namprd12.prod.outlook.com
 ([fe80::d1c7:dc40:412d:e16d]) by BYAPR12MB3494.namprd12.prod.outlook.com
 ([fe80::d1c7:dc40:412d:e16d%6]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 15:07:05 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Thread-Topic: [PATCH 2/2] nvme: resync header file with common nvme-cli tool
Thread-Index: AQHW79U2U5OoVr6Ea0CKYk5QvvwVUKo7yT2AgBRBWFA=
Date: Tue, 9 Feb 2021 15:07:05 +0000
Message-ID: <BYAPR12MB349445BDAFCBD9C9FBC32701DE8E9@BYAPR12MB3494.namprd12.prod.outlook.com>
References: <20210121090948.8027-1-mgurtovoy@nvidia.com>
 <20210121090948.8027-4-mgurtovoy@nvidia.com> <20210127174717.GF28180@lst.de>
In-Reply-To: <20210127174717.GF28180@lst.de>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59e076c9-0f10-4caa-5c5f-08d8cd0c5cb7
x-ms-traffictypediagnostic: BY5PR12MB4081:
x-microsoft-antispam-prvs: <BY5PR12MB4081B9A0F8CCE8695917C3A4DE8E9@BY5PR12MB4081.namprd12.prod.outlook.com>
x-header: ProcessedBy-CMR-outbound
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X7dPRrd4nzLNBbTm7ZVVZ2PiFR0gqTliORmCVQGR4jh9BpdC7bV+xVvh3Tw2w+7vSl2t7K8IgNXUVrW6WzOmIB7Qoxqr0+mvBN7NhgN+4e/hmMlRhHaeGA7VHibIOlGg8yXzl9tYz+UJtHQ6ckh7EAJvTwz7JnQUilUvhNpl5ooMHsboBwijhsUT8vFMASBVBw6S47T62b+zrCTMyEqgzhHKEww1Ny1NpK8auRrkYCyNGGy+iqvGAl+k47dk5dxUADqDbymCKnvCQk223g0AlrWLBDICCca4sqs2mVnALK1OdA0rQWhLw2lYxij882USAGWWbLxvfSrhx4GdqT2bSgVUc0L/unWrruk+NFDM4+70cSC4NpMgVk0KFfD/+n7BS8U2/ayxZpMTINyXdVH6FT/uUOeFtwyLD04ZCsCKEicAmoJh8MY33mSkC1eKtP7nNb68cVClOfqy4NdR+EKmF7vtnknpfQPmW9Q/XR1iBjI5GeNe5a6U2QaRZmABNNIZ/Y3aKsmbyiyYEa/sLTNg3Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3494.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(8936002)(53546011)(6506007)(6916009)(54906003)(2906002)(9686003)(55016002)(71200400001)(83380400001)(8676002)(5660300002)(52536014)(7696005)(66946007)(76116006)(186003)(86362001)(33656002)(26005)(4744005)(66476007)(66556008)(66446008)(4326008)(316002)(478600001)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AYd3zoEmhTMp/Z9rwwKqMURZtjySR4QwqZS1bKKcLFUZcEpQZT4V8o4ZiXaJ?=
 =?us-ascii?Q?Dcj88UD6cw9omf/7qJqIJi8OAgiMIQCGTSnlfL8YNKlg6tGbKL7ClPnHY0yj?=
 =?us-ascii?Q?NhvGWrHMIDvtFUoIwhXsvRpVlIfHK41fbAbnzXkKwcZcpEs/P/g88iv6hafi?=
 =?us-ascii?Q?1mupI1jyYhJ2WXwNwSrVUtfpR83GFArUDJCLvvHzfK0FJXg+FlTkX3YYZAvl?=
 =?us-ascii?Q?MzLFaD4tPqz4pNuXEd35YoXML8p5TrhhgnENf+vYaUuZOVrEbpCoX1vclWRo?=
 =?us-ascii?Q?9sjl45M0klmW165EpCq4+TE2Tg58ZR6njqN/FSzboAvltftK/YINdqepvJJy?=
 =?us-ascii?Q?/W96oHe1oPFzASirBYK2Fz02Xb2ix0BnEh4ze/OdlIi/ogIszSEf4r5xZ9xW?=
 =?us-ascii?Q?MEcPgmU9IJGSHAuqKHxwQvgokG4+qFHOS4snG3sApbv+o+PJjpiPPXqNmLZI?=
 =?us-ascii?Q?N8Snsylq6YIpx4SIwv4b0Td70yAWt+bI6fzSuaBH0xukpzyUcgp0KtfhGm+m?=
 =?us-ascii?Q?DOOIN1gFtAyeKqrP2trB6GV+1DHWoDF6PEEBXI2HdMsfLUf3ZP9WxpnFCK/W?=
 =?us-ascii?Q?ROLSUjKLvOU28e6Dn/qrH6uI/RRk9ftgYMgnQ9VqLTGr1yuZTjc3Ss5+BL8x?=
 =?us-ascii?Q?pMIx1LRdMs9Mm/7CSwjsBEYff5maerD70u+opKVH0ormszoN1xmwDHsa1uzp?=
 =?us-ascii?Q?jXQ2o5Mnw2w+aeTrkTmOIa27M5CAGH2zs685quSzYihgkgAkUNgWtlFEzI80?=
 =?us-ascii?Q?9Z2xI/FWtA78jb4XFZzhSkd7aLIT1Cqf8MzLqcGyLtH2183X/PG9glKsITwF?=
 =?us-ascii?Q?bJhptgDImxcUvZ2MPASDKl6r+3ZyM/rPi/JrnFCroWpi9/dG+pEJPf/sn/FR?=
 =?us-ascii?Q?UUJwDx8iBj7Hcp8zo5KUUZrflx4CG2r8XicUuSF46B4pPskz5dKlXiiQSQ/c?=
 =?us-ascii?Q?Man0Q4uLFs3yZQrBzDf/LI4uTjdH+YD8c4mk05vQv6hBTPkADtAvVewu8kyQ?=
 =?us-ascii?Q?MpessM7Sh6SAh232+JSegHFIfL+NcFoTa2JtK3kNrbMPv/us90R+9NnZuknN?=
 =?us-ascii?Q?Ish91RaNfcDaz/HP9simENr1awZUM/Gmkz38uVMzgnxbBMveduyt6+bIsu02?=
 =?us-ascii?Q?Ux3Z4O59KMX+80FePmTN801A+f7NFcS6gwNfod3EqIe26hP6NsYHBN7JJ0EP?=
 =?us-ascii?Q?du4abDZuQNIhvhp48JnJRNCqNkUdznLVM4Jyzie/wY9my0IQ99FSbGV/jIrj?=
 =?us-ascii?Q?pH9m4HGmP50HxUmRcFti9tfmxHzGzVxeI2/Sf5Rui/2tTpmh/SAOXNbCCb74?=
 =?us-ascii?Q?nf1WevvArnAlGpScjjCXWlXQ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e076c9-0f10-4caa-5c5f-08d8cd0c5cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 15:07:05.1467 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 89eBF6Y2rV5m67ZuE2aN3ZlyeF3nDVJMA4UW2ddu6yoUQ1Nbe78dqKJQ8r/DCvZoKh5CPRR2LRKU3DLtQqq8gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1612883230; bh=4J6JdJ7irXTcPEGL72V+HI2tpohIvrPiue29nlJ+c14=;
 h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
 X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
 x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
 x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:x-header:
 x-ms-oob-tlc-oobclassifiers:x-ms-exchange-senderadcheck:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:x-ms-exchange-antispam-messagedata:
 x-ms-exchange-transport-forked:Content-Type:
 Content-Transfer-Encoding:MIME-Version:
 X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=VLxKeu0WT9TNyl/HHY2ZnAwEL6TFVsOcTBuPOKCvxzCvFfMAZYPRTkz9PrgQ/iix7
 vkDiRFBWQ1e83VxDaG3Eue2DCzzV9mmWnMUOqu/xHiM0Q66pIqXGEud/9XXiD0rFZf
 +CPfq6w6EM8JduGzTCTEmlkyLND0lEEf/tVFAC/Fdf75LPy+03eOn7/wxemmi+4Pyd
 Tb/2Mn3vPhG1DzEpU0Fg2bq70uizL1u8e/7FEBCB7DLDYOD92ZjKgb1CGHQKaXz/k+
 CPoh0ckFd3xio1gZ6jGB0PCSsPgmMKxttR8Y8fjhw1Nb8dxWAQD0OA7QGtsz8bov9o
 8fwGYEG5rz8sQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_100713_331703_ED3A849B 
X-CRM114-Status: UNSURE (   8.45  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

is this respin still needed ?
sorry for the late answer..

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Wednesday, January 27, 2021 7:47 PM
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; kbusch@kernel.org; hch@lst.de; chaitanya.kulkarni@wdc.com
Subject: Re: [PATCH 2/2] nvme: resync header file with common nvme-cli tool

Can you respin this against the nvme-5.12 branch?  As-is git-am is not happy with it.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
