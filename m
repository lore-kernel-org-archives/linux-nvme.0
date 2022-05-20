Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7C8C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 16:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QpGTKTAkwAIqu1/hlZDdOG18ZnF1crhH+GpWQ9297vM=; b=vytDYuvbepSU3vkP1pIkfzo/NN
	/U4OdI4J1MGPxSlUBEBslzbW6nE4CqaRaiLBUQah2EW72TnRwPztqdvQwKaUW98V0zBGF6/jKswWo
	uErDiyI4u7Pf7bJmRwXamG0oVdHU7mPlHYXzwGoQw0Pl2aW85FocOLh3iYobAMOUkkLpgNtnub5R6
	WBcH58rRJwQecIKFVNNl5jX6uplvP5kK1bxjUgCu6HcbBBB/H3b6ttn1EbWJpm8DTGQGJ+7JbD5X7
	HiYyznNL3Z+gweX0A/vgge3avggsymttPHhy69kk+MfKCbyhIxmC2PyDiJ3qBxmYCUBaeI4hertX/
	gpIJoyGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns5fX-00Dkgz-Uf; Fri, 20 May 2022 16:40:03 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns5fT-00DkZG-DV
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 16:40:02 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KFXRUR028585;
 Fri, 20 May 2022 16:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QpGTKTAkwAIqu1/hlZDdOG18ZnF1crhH+GpWQ9297vM=;
 b=ClIFV0mjX4WJ8RVsvQb1xqWFXqhAwgKhN9aWIvsP+k8Fw02AcRA+j1t75Fwqzle6mUtV
 XsRA5RoMRDQs31n8DD26tJTZ2xVRyK4JslHiC6bTM1iwLCVCVAfbBiwK2mS8f5DRB+p7
 v4f15bwqRQqP4Z5XRAThGv5unZM7MIzKrHno0N6J2+6gkfx6xwMo/u+AsJ1Wlx+TBtd3
 DuKbW+ovRkzhu+Kc9QaFtW6Flu6wA6hhwvKK1YViusiH0NX46WAXJameujRpIp81FcIl
 sYczAu25wwKRuykftgiUfoNoW+gT3cQjbo5rhoOYhIIw8uU141/uF7ZoKPP0abXOHL8o bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g23727sgs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 May 2022 16:39:54 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 24KGdreY028457; Fri, 20 May 2022 16:39:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3g37csmugx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 May 2022 16:39:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccAz+RLcb8/7OaEfdPtbyGGKLe0Ucm+AJxkf8OZNDb+c4hc24/f1g3VaKiuLIEMC79uB5TdMJH9Wu2FZnp2B+F2at/NBUE3kve8Sy+UrZi+s+WnpyUx7sXsKV3UaWVnpZMtXxBZsRwOSJ7tetj6edb9cVC+BCKs/lnA3ewzPQ5tjABEoHSI3fSl83e6hIZz5ecMj9iZ5iODWY7N37LTkqBzJp9kHfV8qmOcoxNHj2X11eWAER5fmNhLvucE/XZ/rJr4xSUfRiqYZjU9i0GKmmg3tlEFi2pwNIlikznqkj3iPmh+2/XO/+xr1ettLdRkJTKos1CRb81RE7Tvgsno2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpGTKTAkwAIqu1/hlZDdOG18ZnF1crhH+GpWQ9297vM=;
 b=U7OPobwdJBj16zzhDCOyAcktp2D/3nbF8yFFzsDtl8jlNBrMj8Vce78mgKTeVnYJ8VIL+/owbkfG6g1F0rrY12poyo9Wl4Xmh03JPFTCd9x98PrXZcXJP8gFg2YH5Q1hdNktMs/SKk1tk32akv4TJcnGFKBEem1v+YZPHuQjacA4aoAiuezuNcyd/Vllr2rHPa7gy8PFb8bYqMkzCFPMPeiZqSJxdTongIdlYyBMowj/TGKpNgWNfA0bDoDDWSHZEdr2hnWa1O8tObIscjmq4Yz9W/4sEn7RAfsLwpIP2G0I8sVBb4VwTWRT4PpO5yU6VQKRU1tXxzfXO/H9yGywaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpGTKTAkwAIqu1/hlZDdOG18ZnF1crhH+GpWQ9297vM=;
 b=DnZDebHMzp/BZGqYNM6BliUMDwba/ciT28BpWqC2sbRI+dykrNYATzGX69fOVSbE+5EQ7iIbmy8avhUJEbbOdbi31usFYHDYChv6D3Ui4TZUxGoY2VDG6KofvUvG3HJjikfw81fbn4x3TgidWVIz2RNAceUX/ZEmDMwXa5aAzHc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM5PR1001MB2187.namprd10.prod.outlook.com (2603:10b6:4:2d::35)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 20 May
 2022 16:39:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%9]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 16:39:51 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Alexander Krizhanovsky <ak@tempesta-tech.com>, Boris Pismenny
 <borisp@nvidia.com>, netdev <netdev@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC 2/5] tls: build proto after context has been
 initialized
Thread-Topic: [PATCH RFC 2/5] tls: build proto after context has been
 initialized
Thread-Index: AQHYU0RpxVnRY+Drn0ePT6rxyiRYi60oKekA
Date: Fri, 20 May 2022 16:39:50 +0000
Message-ID: <A3B90CCA-6C9F-4459-AE11-02AB93BDF25A@oracle.com>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030057652.5073.10364318727607743572.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030057652.5073.10364318727607743572.stgit@oracle-102.nfsv4.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ca1ff08-bdb4-4d29-cfe0-08da3a7f5c4b
x-ms-traffictypediagnostic: DM5PR1001MB2187:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2187169636DB235EDBAA66C493D39@DM5PR1001MB2187.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZjUhY78n6BdhVGKxjv30tQ01r9ZUUJH06uMFQ7IE9o03Gi9AZdcQBf9gV+xP/nysNCW9L7+Yk0mL1lJFstOpp+mAJRyNvBlC5hS72EConohj3AtvdiTDfS0+DFuPLZHQAml2Xnk4gRz1JStEfFD0iJEPqGdVpoHolMb91vhu8F1EiYNRZW/fO9sOjjcPTXzWDlHyVaRCzP8B5zwLs/UI2n9eXFxjAg3KxUVPhaZGLGIci48HD1GHmzuc7+MSHx89g0b7/rcmcTveK3k5uxnsM5HHKSHAPSDvBdMJ7FMMv9MMp4RVzoEFjw3eFKDr3ys4f4l7bBgtT/X4zEXG9oh4toiDNfnW0aJ0pPEcJCHlsel6AXNDI8wLvwodZ1WDOC48vFmyZQoKl3ETaoOpS0sapk3dymVbITNRDkAOZR/VTA+ddCunJnUIL9PRfj3Qpk6rkiBmxXIRvtMdqAydi8e9FCikiPH4mRWfQiI/VtY6h5l3zeAKcPTZJpQTiMXEN9v3jFdCewOrtybXTzuh48NzaEKwBQuk4l90o92Mmpsgcp6U9o89xexV7O7pQGGGA5eaZ4zFXeO7zMw9iwSFqLlMkFIzTcNGt9zemM2ouHX/ddz6mmYXtx+01Lkxj+ALH+wBW9j+t0p5CtwpO6DWdL9WyX0YuSXBzW3vQE5JLd4cCwvXBTciIC71pkJWHGs+Ph3VE+jEtR+01G1icIOuX68Fm0p2cb/ls0PSd13aYPqqsXE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5128.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(2616005)(66946007)(33656002)(66446008)(6916009)(66556008)(186003)(66476007)(53546011)(38070700005)(6506007)(2906002)(6486002)(8936002)(71200400001)(508600001)(4326008)(38100700002)(91956017)(316002)(36756003)(26005)(83380400001)(8676002)(54906003)(76116006)(122000001)(5660300002)(6512007)(86362001)(64756008)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gavfK+pe+qmPRgEK13WIk1Uy3yDeL3tkCqgSlhtnfGtcQdxyrtdACfqHONPE?=
 =?us-ascii?Q?Yoxbgap8dvTefmG65inK+6SrZkmn9PLv1iz9D5CuptuOZSZqfZUoqTXXGmYx?=
 =?us-ascii?Q?6MmNR3f9gPcIBKW8eyWLwvBWFWFmH/88Kndb6ILNCmZL46cQ7vwXBGsrlyBj?=
 =?us-ascii?Q?ofL+x++rigI1hy3dzMaZB6VhY5KDF7rgAPf7a03IkmlobRxT9UV/AjC4BssA?=
 =?us-ascii?Q?XkJIoljLBTBNh11/KhLWaJiROqoiW3vtOzR1KoJo44ICKC8w7YLbT0FeH8R3?=
 =?us-ascii?Q?JXyckdGq8oDj9mgiD45doY0giMo9DS2UKtdVKI9jxt5P4cziVSGEEU+UyMte?=
 =?us-ascii?Q?OP6FaOkAdjLcuUwk18m7OrHKYePY9TqQsF3jGeVCBzVGryaV1kqvnW2oeNLP?=
 =?us-ascii?Q?M5EqGHHUM9xMxJnhypzn5w/eReYesSjt/Oxd+dwx+LnHghwuzZhuRsnE4s/v?=
 =?us-ascii?Q?RF2n5iXpTTCPEuJftSQlz4cTPr9J5DteX2BGThYZ3c0zqZsYzADn71K5UxsD?=
 =?us-ascii?Q?WzPz4bgQW4N9lWiVHsWYuS3oeSMU2P7TltKfmENuAdua2My7UQ/zjhTjFw3N?=
 =?us-ascii?Q?Tb83Lb2nNS0sBnV5XwVuC6FCIz7Y5anoVHlPnNjgmfEUrPUYjXEbaYqBDoO7?=
 =?us-ascii?Q?jkndrS+H6mFkJ/1LYYmpz/tAle8x6Kp7oGIFuOYeySx8aDu94zNqNIaBe0P/?=
 =?us-ascii?Q?gNGWz6hZLASPP0sfaVnuE0W7PtgtpkzNTVzPQFUYdKiyMNZPhDmc0pwLYtHf?=
 =?us-ascii?Q?y6NuDGtxAatwGBxdOnMPkfKOw6H86HD1WrpSDp/fio9VRrr1vniq85R7r0nm?=
 =?us-ascii?Q?o8lgNwh/NuJ0JU2PJmy9LIVEtUpnzIGSlr20uYhzq4LO2KJ8brZA6ANyx1cJ?=
 =?us-ascii?Q?1PQ684GKIAW4o7z5qa//HZMxvL5AmzI5SlbWkxzlL0M67UGtWFkH3F4kBz9S?=
 =?us-ascii?Q?JwDyRHQxCBv8xZL8uTmxtIX1xtJMVoG8H03DB45l+8+2k6S/vs1p1bcXFhay?=
 =?us-ascii?Q?TwxOLSJshtvIxW28uBxOXB1TnJ/+VO+/cIIoz63pNFQQdytkrvfPx2hQGyTZ?=
 =?us-ascii?Q?YZOVY57JGjrn7amaGK8onkpU2SR/nFiQYqromKxrG66hKsJIr6qZBokRkUdN?=
 =?us-ascii?Q?aaomQZNsm7MYd+xCbZFaRHc2jPyvl0EvW/O4ttD8RyaeIEqH11freBK4XIfz?=
 =?us-ascii?Q?HW2zBbIxuH4/PmIUg6LFpYvaLjiiEUROJCWQcwsbUk3VcsZLqoGmI2lTFThi?=
 =?us-ascii?Q?BsrUptCSxuAY6cNCoLVX+rTOjAcSOviDRicSCbCASyJeHZj0YW1NBH3bbE5s?=
 =?us-ascii?Q?PylgS/YoitillsDh2NI9FsLxuAjobucM+/yfa5MUKb0VCtJLAk/P7lHESr86?=
 =?us-ascii?Q?K/0V/Q2MY0NttUnm4bwGFGlklBRZV5EmJ4v5g8tIy50E8egoUZIpbYsAeZGz?=
 =?us-ascii?Q?VVpiKxVsx5PHnSYgB+3DLp/P7giUQon7lGBzP5zw3adANwut4MYmP5Ocegl8?=
 =?us-ascii?Q?iyCsQTuDezHn7ZC92nyMBIKppeNpo/Lgi5h6a+Nwvw+f/GzuK/gN8qV22+zO?=
 =?us-ascii?Q?pmGb+MDwnsdEvPG65O0qCXRy5Xul2rWzWHFYJRLu4sxW1faWz+e8B20i2du4?=
 =?us-ascii?Q?Gjq8REASgSay56OUCpWHw+vObt+G9mVZhSnAgFMtDXoFMg2MPlEVbe0hDmst?=
 =?us-ascii?Q?ZV7nLdRqdIOEoOAJo5WOk4aC9g187pw+47AJjEWnsLMX+5GyypP1vPmbS1d3?=
 =?us-ascii?Q?UJetUoL/7GSW/r+V/CR50w5LM/LFU8g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DAFCFE3BFE05AC4CA4302D2BD70DDEDD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca1ff08-bdb4-4d29-cfe0-08da3a7f5c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 16:39:50.9763 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DYpE1BjmaL4Ai3piLFzQP68wi5GSC1IoS7AHpYzfngANoxWaMilZ2JPko6wdDiLUk1ccLcMAW89lvwiHt+TEMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2187
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486, 18.0.874
 definitions=2022-05-20_04:2022-05-20,
 2022-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205200107
X-Proofpoint-GUID: 9OCgjPpgICkhJtCp_3XBXst532OjXhQY
X-Proofpoint-ORIG-GUID: 9OCgjPpgICkhJtCp_3XBXst532OjXhQY
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_093959_777981_917D3BBB 
X-CRM114-Status: GOOD (  22.65  )
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



> On Apr 18, 2022, at 12:49 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>=20
> From: Hannes Reinecke <hare@suse.de>
>=20
> We have to build the proto ops only after the context has been
> initialized, as otherwise we might crash when I/O is ongoing
> during initialisation.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
> net/tls/tls_main.c |    3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 7b2b0e7ffee4..7eca4d9a83c4 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -836,8 +836,6 @@ static int tls_init(struct sock *sk)
> 	struct tls_context *ctx;
> 	int rc =3D 0;
>=20
> -	tls_build_proto(sk);
> -
> #ifdef CONFIG_TLS_TOE
> 	if (tls_toe_bypass(sk))
> 		return 0;
> @@ -862,6 +860,7 @@ static int tls_init(struct sock *sk)
>=20
> 	ctx->tx_conf =3D TLS_BASE;
> 	ctx->rx_conf =3D TLS_BASE;
> +	tls_build_proto(sk);
> 	update_sk_prot(sk, ctx);
> out:
> 	write_unlock_bh(&sk->sk_callback_lock);
>=20
>=20

While we're working on a better upcall mechanism, I'm dropping
this one from the series. tls_build_proto() can grab a mutex,
so tls_init() can't call it while holding sk_callback_lock.


--
Chuck Lever




