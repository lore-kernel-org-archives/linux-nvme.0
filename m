Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76357C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:33:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F522611B0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F522611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xq3jtXor4jVFu7+ClThT1vAb/iIpBQUmECjitg8ui4w=; b=WAj0txMGAL273M
	6CeG9fu4MFL8c4zYZo2wL1gJeqyHMLMb7hS26OjBFqc4LVPh2sbkZaO1EcblHc1NNFDaCUcFWtkq8
	bASGtSmlvrnIbCB3CkMugWIURQYWmfjBFy4kaG3JR42z6NZeQjYh2sE5jsvtAisOQpZMIcuhe8a3E
	Ws2yYXEDB+zqf7BfpQxa/Q+4MGyoJLAfPj87SXGA0qvjUJK6E8kO5CKdEj+4z0b37m9pOh3frf1Kx
	yfp3t6Q6o05su0rN9SJXPP/dQkjBWZQ5tRZkwILHUQyivcoM1/cEvOwWqPpwuTc3HkBYKCOWQy36D
	YKGEZIl45sPrxFkdUGdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2NP-008dYE-TX; Wed, 22 Sep 2021 13:33:31 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2NE-008dWh-5z
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:33:21 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MD7IOk021872; 
 Wed, 22 Sep 2021 13:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R5iUBLvh4QAMc1AWxtMS1RyLx9f3572R98DC9dZjTPc=;
 b=f75vgTErhJiajzAlxiFMfrO3vKTHr+oS9zHiBta3uYJtZVPvJAvaSyJcYyMIpChHX7Kt
 T6+R5ADQS29yHVXI9ir6LaFEMYi9ZQ0Mhklr9827txkP8NbyiFzQ63QCGtd9LIiqEKML
 A0kULtgGsPJLJZuSVxO1rh2istPipkQYQ9g3vR7MCQaJCt7RgM/lO2zvvoBue4jNoPE3
 d1i/hPI+kJZBX0F4aq8xUeOY62Sdp44h+lCDpQHWSHsI/P+I+Ju6bUYSotu9kjnbCet0
 AygtTQcI5mvpU8YKHTnw3qs0mfqjZHgcfFCd6b6CiXqBCzNKApZ/AANFEy8qn1Gx1qeH Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4p3uky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:33:11 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDUpTY125239;
 Wed, 22 Sep 2021 13:33:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
 by aserp3020.oracle.com with ESMTP id 3b7q5ap7h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:33:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxeOBy8Fm0KxfP4oyOVkb4nL85pQXUGEC5R3goLP30zbhflEejbqt66Hu92dMiUmB64n5+jJ6Hqt4sxGCDkjsUAjYHhTe4ar1Gkt8svy82sFJA27pblihNz2bg65Rq2YynEDr+pOn/osStcrzxWwbzavnvnfaM/i0RvmrToYM+d6eeVKFp+07AxjII8OnuKCMrHHCuAXEhV89AtfbdEH9l5/EdxlENv/oH1xXO6955UnY+Fn20wR3O7qK0uyGpQ9coxrWVsDjhjcOBn/a0qezCKv8fQrGQ8KMx0F+yCE9R6kvvI0QcKWsz6RrRC0K4Tal5loqI7eec2gqDPf2uiiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=R5iUBLvh4QAMc1AWxtMS1RyLx9f3572R98DC9dZjTPc=;
 b=dabmV6TUvCQKeA3OLRsPxbPKhtui8e1Aq4OoOoFpndyVNyGolUQvzPrksg3+6a9Lvo/TZOZGioCsF95yuAYbsbd307/catUR49Yfb2TTM1ajQDL/nxcY/QVZmN317GtHZJFarTac9+tmjAnDTm2G5TCdHEk5Rhu+m0KguTjnLFmvEg8Oe42nbfSEpkmMvKwcHMRkEx22eVtSVXZuYaiVCfcR10vMUji1SpKH63bEd2BZD3Fc1LVe8WRMFpfX8UFl+81YZ0iwDeQq56jByQcMC7zcu73SQJY5ou8mJNk6l1pSE7WFpKNeEO7yvZe0LMQjRyJrmZz/ZVwWn/xjJGddkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5iUBLvh4QAMc1AWxtMS1RyLx9f3572R98DC9dZjTPc=;
 b=z41BSBsD6+pGsmRKSS/ct7F5kRAFp++/q+aeHbqbEmMR7T2XtyPrQK9w2uMhFeuwpZUOwnPsAiKHSKtjgbDSD2IQWgCj3oSHBK2wzUXe7NPb+G7oy4XPl5cJd5zYwDFjEcB6F9v3Ny5/IoVBMWYLl5PUDTowvbjh2V/fWwQhO8s=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB3087.namprd10.prod.outlook.com (2603:10b6:805:db::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 13:33:07 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:33:07 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/6] nvme: add CNTRLTYPE definitions for 'identify
 controller'
Thread-Topic: [PATCH 2/6] nvme: add CNTRLTYPE definitions for 'identify
 controller'
Thread-Index: AQHXrv2D8iLIKdDhn0SZBNJ858r5bquwDsaA
Date: Wed, 22 Sep 2021 13:33:07 +0000
Message-ID: <0658F4F4-0838-47E0-A4FC-07835322DDDF@oracle.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-3-hare@suse.de>
In-Reply-To: <20210921151529.29419-3-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cd1c381-945c-4d72-c54c-08d97dcd8379
x-ms-traffictypediagnostic: SN6PR10MB3087:
x-microsoft-antispam-prvs: <SN6PR10MB30874923DE7E15FFF93FE5C7E6A29@SN6PR10MB3087.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4POqgA10GhHjG8VLXcxX25qK8L7Sqrmmi0knQo7b3AdDw7o+Uj6fYYyzDMs1JhLTdBAvBVrRXW2qigKNDTfP0XE1K/fIiJsIvWTM0BW07v2RB1xQ42d01NO1Vz1miOu6NF9048bc3BTZMt7H9Tv9wIBdYwBcp5OHGURFoAc3iug3UDaQVEXbZeNpDkLZDwe8LPXIymSVJLn8u3thQSx0UG0KkQiaYZQdD6NZut5POhalWDeiwEwMamkzmarjJb9NXr/CsYou2A1kUGSAmQEygMzowfWvBKG9kIIbBD4xsV7ldORdVNojMVKhPI+u0a/x9kQYu1Rkf2/uspzuEr6xgkmk2Zd4sjWQXwTL+Bz3AU10v/qjkpAr39j70xkMn/23Vy8cVYCcVGGwJB2Gd7pjTwWwTnLqK+NQUoSC7j8aCKuGCODBkltBu3Znhsrmpxw0bBhilJge9XJ+8aRnXXWrGDlt626+YEHD7QBdRm7IfcUdd38u7vGoJfMJ8QEpCkNH7dwmsksFM58P4NylJtjNeUMpoNA9NmtmHVbVw67D5Fi75uZUbq01h7PkFXIv84C0jX8Z0itszMRle6UXIkLCADK+OShBaS4P+IFRug8Qm7HC0qG8LxmZF1uKIyP7QcR4VbfEtUeF0usC5pDMGWNLpcIia4Ikb3OCX+pioGwS83x7Hd2jdiCKmTfQ61rMNKg8y01hxj4Jy/wTU+7SR87cChUNkfWw75+ChICfBwjbwTcwxgKisW2GcPdzpZ5FRLsJrslFe46CWPgWOIeMR9yNXUueq36zSfoOBqIIlWv5+J4K2OndD5WSx2o7gRlDtUAJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(38100700002)(508600001)(6486002)(26005)(36756003)(122000001)(6512007)(186003)(5660300002)(83380400001)(86362001)(2906002)(6506007)(8936002)(316002)(6916009)(2616005)(33656002)(76116006)(38070700005)(44832011)(54906003)(4326008)(53546011)(71200400001)(66946007)(66476007)(66446008)(64756008)(966005)(66556008)(8676002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O1cUF3JrqRHAKu/P+y4plJCXricnIaY6H/tFqVVKuFDSgQkdX9m5eS3awR6Z?=
 =?us-ascii?Q?ZikJrtW+WmvMInjImdEPBbev6zuwXnMgJOQXi8CtoZNTqJ/2FrfK8gjX2Fwv?=
 =?us-ascii?Q?25aui2cSe/tLBut50gm/SKHexoZ23FW4KBqaV6K1qi9qWVjAvfgvAjjMghOC?=
 =?us-ascii?Q?EtT7PaS6D+wDQh5I4pVGgXlhLfo+zuydbY9VMv3Ol7lzCLTnAFZYhT41hNO8?=
 =?us-ascii?Q?1gK3yE97duv9NJ3PeOTUL7Vqz5reGfELqDNe7UhJMRg9tRUeqvZORrBIgsE8?=
 =?us-ascii?Q?cCYMBPEEJRqNhI7sFatmmvEvNj5OsrqyTNMgs9IAp2jPVDCvFWFzZI/vAPBl?=
 =?us-ascii?Q?OJM9p0L5O7HrcK0MpgVsreqks1dhMDysibTppkc98EQLZjVzuXhQCllrHg1V?=
 =?us-ascii?Q?OnlCSh6Zzyx9b9hELsb1bbyHHZWoAyMe7a7c4sj1n+njugQxfox5QHVHyOLI?=
 =?us-ascii?Q?0BtAcBw/4oLR4JXnSPQ0c+51uQ65fOSZDFSnBvqGh1pskeivC4WpEeZKyNi5?=
 =?us-ascii?Q?7HWsKWBq9/f4a4DghtZt+eTLdpL58GCarjZYBuoGW/lT2tZZ6PiBPj3X8gRR?=
 =?us-ascii?Q?C0PvdeGBW1tGWeayA27HjJbAIfMfD+jlcA2bNu0ah52UjuT45q0dldSMYh7M?=
 =?us-ascii?Q?zx/y3Ys2YdKiZGUrGWaQNWr9VLjmUMuvrifOXYKnipgQOQWw/5JdB+Yil/jd?=
 =?us-ascii?Q?qup4DCfGvT5UDglBq2WWePyoIm7Yv2NMAgBXVJOX3jGw7Nj8XwfwZd/rsl9p?=
 =?us-ascii?Q?8U551JHICgoPtCWtYDHNDW1Tjyu3fbjZS6VigcepsyTI9ELGRwwLjYpCbqAF?=
 =?us-ascii?Q?nbqPg7StpIv3fo5D1moY1hW008sUoYZW/9Tq5h/2qLcKPtBhPMu0s08DGWRM?=
 =?us-ascii?Q?4B5HQA0GcoXr5mKJ55ahD+UW12WOsmaAzyPlOq1fYmqa6sV8I6SPxB/vaQGt?=
 =?us-ascii?Q?iQ4AfjTkfhPZkVmnbEbJKSYb7uASSLiWa1QrI92Gf5fZtmhM3TcnMuWgil1A?=
 =?us-ascii?Q?ZI3n6N1h7EDeUz4xsvtYlLNTM3Yh4HISzKnWCMI4w1zJF3w/xsQOkvLNRA6l?=
 =?us-ascii?Q?dwvd3iIDq85iy++lnVz8+EdkOGbt3W97iZupcdzKm5wfSlI2F3XKiPPKsVRX?=
 =?us-ascii?Q?BlUm1wgpiU5GVkYIJaDLuJkwE1KIDoWj4xAoTzJaxh4W2mwKPHGIrTqzzcU9?=
 =?us-ascii?Q?5HcFoU6dKZwX/1WT6fNQ4O3lrCsb1wXxnkvoS5HwRE7Nghj5dweGvzF+33nv?=
 =?us-ascii?Q?hmSv5FyOBU2zv7heASpVzyBX3EKhYHmmLPMfAEnNixp2rYoXlKJe/KqBmKHS?=
 =?us-ascii?Q?HXboC51hEEBOtKm3HNTRfgXEuTadvdfiCAtzOMywGSjHew=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <08B34ABE9013D644A2E74496E027B25F@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd1c381-945c-4d72-c54c-08d97dcd8379
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:33:07.5829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6G8xyKpp/l6Zy0AUm0KLq+tmMTFuO2CqVccPbYY7hRYjUuSb39Idsi/ho6CANzVhSNDQ43wwiFwtReGTxN0XwaRaCzdQOcjmVdgbSsue40I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3087
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220096
X-Proofpoint-GUID: ZL6aZtGYatPXoQOz1eYWAVGaltux0J1k
X-Proofpoint-ORIG-GUID: ZL6aZtGYatPXoQOz1eYWAVGaltux0J1k
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063320_395763_CCA67DBE 
X-CRM114-Status: GOOD (  26.31  )
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



> On Sep 21, 2021, at 10:15 AM, Hannes Reinecke <hare@suse.de> wrote:
> 
> Update the 'identify controller' structure to define the missing
> CNTRLTYPE field.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> include/linux/nvme.h | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index b7c4c4130b65..ed2428918bca 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -31,6 +31,12 @@ enum nvme_subsys_type {
> 	NVME_NQN_NVME	= 2,		/* NVME type target subsystem */
> };
> 
> +enum nvme_ctrl_type {
> +	NVME_CTRL_IO	= 1,		/* I/O controller */
> +	NVME_CTRL_DISC	= 2,		/* Discovery controller */
> +	NVME_CTRL_ADMIN	= 3,		/* Administrative controller */
> +};
> +
> /* Address Family codes for Discovery Log Page entry ADRFAM field */
> enum {
> 	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
> @@ -244,7 +250,9 @@ struct nvme_id_ctrl {
> 	__le32			rtd3e;
> 	__le32			oaes;
> 	__le32			ctratt;
> -	__u8			rsvd100[28];
> +	__u8			rsvd100[11];
> +	__u8			cntrltype;
> +	__u8			fguid[16];
> 	__le16			crdt1;
> 	__le16			crdt2;
> 	__le16			crdt3;
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
