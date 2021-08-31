Return-Path: <SRS0=iyK+=NW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C065C4320A
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 13:45:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D9D61008
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Aug 2021 13:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 23D9D61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6/wUvEyoCwZ+7BaXtThr0OjULaw4pG9Gx48TzOVDBZ0=; b=quJ5nWjz925IzJ
	08a3lP7517OfaeYCpuN1/z9MdJ3+3cyMSaJ0TnBmmBm/INady7BIAi41FylEqKKW0cjIgqkzNI0iw
	4v2viRaTTWugWkVCh0OKOJPgRweIjvPs8BHrWEcqx65oiFsRwT9+/5BU0kYDDk0Fo0YSl+FhAivA5
	BKb0BX7NgLdy8bzCyiPhh25xtNEt/qZf2espUfHLPXShimGIbfUNa/g9mAj9xQAmn077RYv3P4kJk
	r/HjOn9Ykt80Nt5rVTSDd2LT9utSCnJpN2dpebxnf3rQPa4cHxYIy2gq2vSgNWj6VOObGRyrlRtdl
	I88O7U3NZV7ZH4ew+2Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mL44z-002OAv-Io; Tue, 31 Aug 2021 13:45:33 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mL43Q-002NJw-Um
 for linux-nvme@lists.infradead.org; Tue, 31 Aug 2021 13:43:59 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17VDXLcj030876
 for <linux-nvme@lists.infradead.org>; Tue, 31 Aug 2021 09:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=aCQZiRTf5GrlWZc6gIsmJLPDrmPpL/wVVszneX6280A=;
 b=VBM7oRIYNsYa3bKoiWplxVP3Vh7aYGYwRGMYAe++bMTvlW2bF09Pgp5zI22SGeSP4HKj
 NWTuiVDkgxfW/APquNNohzjELsE1VJqSeVkbiggMPqMZovMAFde7KnBPAbIMVsO0AqMi
 yIxwOzqM/tPlxFY1qgUy03RNNHdclQ30dYgcK2Ruo4lyr5DeA2yDDJedvb81YCc0xsZE
 Q9nTPtHNhSZ7AlgsfdEhckzl3LAG0p58hLWhj04BZszGUz1QQXjas2O5Wm29e9Q6lqVM
 54sbP1jvfIFpsm8kbqrDpVMe088e9sOc9DOygPzPx3Xzvbs1ya6s32Wx8AGFCcVrOARQ Mg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 3arvk5w81n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 31 Aug 2021 09:43:53 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 17VDZ3au171223
 for <linux-nvme@lists.infradead.org>; Tue, 31 Aug 2021 09:43:52 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
 by mx0a-00154901.pphosted.com with ESMTP id 3aru6j5ttj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Tue, 31 Aug 2021 09:43:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5TmLg+bjuu2NDTAXW5CcbGLTH/G7LkaLdCk+fR3iDRSGGhEQ7AxmLIZG1w1njRI1tuaagWvyKHbjq+tqKfRynGJTHQnPqKrbxRqJS5aTXDkBgzIJJ5KGHBQ9bZ9FRIFyUzfUPFJTlkbkNre4kfFx7VcPI0t0nIKG7OPHKZwIlhomDoIpaYFMF/hbP46+Z6HB3OCgynzbRLXvZqPgM1oYlflzPOGblY8/05tARgiyhuqv5J6p66meSAESdP+MmgYDOYic4mwR2DcRkwAn+Ke73pwCOLOtK2eS7ETdP/AYpbuP8TPQ2jVzVzhKUQRxIHSTRmKAlO9sEp2Vlh/urcB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCQZiRTf5GrlWZc6gIsmJLPDrmPpL/wVVszneX6280A=;
 b=lluZzu8sqBjEqBvSICZoSS/PEB3b1OJ5uc98VKWhnYNIJqlFvb8QDGbv11FoakU0EdOzvKKGltvw80BeKevA2e+uQy3Ttn52deVkl+enNV4ZDQmGOUuKiPggvUT+7AlUA2hjJzmJrrcnCq8VAPVYX3ein6cRe3Vixx8XBBbnRnYWYPThhOoCCiBAjwlOxPl6g/qeGsRgWm6bCx2noNdx0FYFiRmOPm2Zn0V3jx8C6Onhilq9Sq1iDE99lZOJYrItiyDkmQj8RqlbM82087qVlKTPYW+IfPgaSqm9gGSHwlmKBdKIZpd8tjS8XYvPzkimr8H4LGdLrY++FcyiXPxeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3841.namprd19.prod.outlook.com (2603:10b6:a03:22c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 13:43:49 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::88af:3327:6ca7:e439]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::88af:3327:6ca7:e439%7]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 13:43:49 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme: nvme-tcp shutdown when remote is unreachable
Thread-Topic: nvme: nvme-tcp shutdown when remote is unreachable
Thread-Index: AQHXnmftir4Zi/+qcUG6iNtqtmNhVg==
Date: Tue, 31 Aug 2021 13:43:49 +0000
Message-ID: <SJ0PR19MB454404CDF46273442694DE19F2CC9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=True;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2021-08-31T13:43:48.954Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=Visual
 Label; MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard; 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bef76a3-2baf-4872-1e6f-08d96c855ce6
x-ms-traffictypediagnostic: BY5PR19MB3841:
x-microsoft-antispam-prvs: <BY5PR19MB3841AA99CD6F155467567178F2CC9@BY5PR19MB3841.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QBBUD+IbeokrXijyU3VrskFrPf2C6zppfnnxBOM/C7Ae97ptqQFtfe0cJ1IdN8DGvGogCzZ+KiBCxFEmhBXLYNBJpnYNWjghHBFllsIyZ+ip+W4YHnAauKv8FUG49ppaKz+cn2Rji5/LPUZCCuPQUAiHuzvr//GLKh8Q7T0L/Z9QfLfF6ukx3KMsfg6zOOmwfttjH9OaFqAZnsJ4qHEJqSC5SjSSrZqVngpjUIpnN2kczj/9E+NEU1ZncZoux+n8YPgMKd8zcSWJBMCH+ia8mq5qiMTZQ/8N3UQ8RJWXSXVJhOByLtFnHI2+uN/9zW2501zE5iw8nCBXgKc8kgLZ8MpfAuim8Xaag2GmEEMIFUYMrPB18CoO3lhAVxVSCAK8hJggW1IuPVSUB8CnTnZnf7DYvSseZSqw1//1+aw9JSx5QXxktlEmSZGmJYHCYNWS7Kb+QiTSMfpJamuHcCVgx8KHc5HCYsyuTUAGwBafKjJtuhv62V7oS3+CVHZVOjryceXlLcgDn9iBg4hR/UPsKDhx3UHFFUckBow3afyjt3pLwr5qibqY9JQ8ichnXIvEyeI/zP9BGjBPFp0YNQ9zCSD3RV5sLjBymHfIlytzEhm0jfxhd/hoslVVPguNtOFUnKDKYy5gz/UB4i4fN2hZ9YPukIDwx/0zAWCU3TOIebk62vjQ7WiS+MBUg5nXfntN/pzAi2rWUnniDHhMs1aZ1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(91956017)(2906002)(316002)(508600001)(66556008)(6506007)(66446008)(26005)(66476007)(786003)(186003)(66946007)(64756008)(33656002)(6916009)(52536014)(83380400001)(8676002)(38100700002)(38070700005)(9686003)(5660300002)(7696005)(86362001)(76116006)(122000001)(8936002)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aAYKYBUkNQWicwUzn7bFRafcevAT716KKbWebP39DxEKOvGshrzGu589o5?=
 =?iso-8859-1?Q?Zy8iaKrNNIcmxoOU92wJvvKbJAAQybI8SwR9OG9BxSYIWaH4Ec5TWCmRj/?=
 =?iso-8859-1?Q?XN38ky8sP8AOkUfCeb62ud6jYEkdWknU3evMPjL+dpi5GbPzg5oDUI4y6R?=
 =?iso-8859-1?Q?QeEkCox7cweU6QfIH19ULNSjfldF6abi61HQhUrumU6a5gabYfDDrA2m9F?=
 =?iso-8859-1?Q?FoEpJuPnMeIQ6rluv7AN6+WP+RmukqP0pCEyvm58OXOq9XFJVwIA3JCeb1?=
 =?iso-8859-1?Q?Ym+GiaD+G7m094layLjE7in5Gh8U7dGI1mfd+G0Py5QLPa3i9ybNRlYcfo?=
 =?iso-8859-1?Q?J9glpWSr3yHr1chE1JMmrRZFlC/0FQgIYPfV5oH6jZ4LRQ9Hpux1wFW7o1?=
 =?iso-8859-1?Q?dJzr29gJhAE4FOWdQtpH9nsiyFmX/Z8Ya+QPI4Q0+2FUgy9z6U9btqtlqY?=
 =?iso-8859-1?Q?sjgBCYQzfe5tIAEY5ABKd59OwgAT0uK0+TqWJ+O60n/sgD7OFzMpoZ+PeP?=
 =?iso-8859-1?Q?0nxUTDeoJ0PI4hA/ptmK9NzhblI2dZQqAhBFJq5wAaeKGStVuiO7yYN1Aa?=
 =?iso-8859-1?Q?obDBwmmQSsGaH/YthZqLhfivLT49XcxnQJLW7zF/0JIDt/VX/sRcvGaETg?=
 =?iso-8859-1?Q?VI/HJdfNy5HeSSjWbKgt+KZCbJI7oGmDBGu/HQ3/hLEeKNGaw/GhW5g/2g?=
 =?iso-8859-1?Q?5u3mE9PU1JdpCtB5CZ/ZsbYp0JDBHp0eY/AqBSEZtNZw5BSUYQ5BRmtiAG?=
 =?iso-8859-1?Q?5Yw8qrb9THOOSJg09iBmTCxvcTQrjTLI6qnInBrmThyo+X7+ErDtGX+Yf3?=
 =?iso-8859-1?Q?l46Leb+wRChlmDkwdqNs3P2XPGw7R5XGlcQgYGygeaOKRoLyzSU4zKxuVB?=
 =?iso-8859-1?Q?BbyW7zL3wsOui2gnTc4TCbrqhmIJfRq4sLCXosE4u6wBitGbbjuasBjzqg?=
 =?iso-8859-1?Q?v9QanwcTbaECKCnsbFhA8n3T+I+FoNBWqr/y/kQQsK0R4fICobBcKfi+M3?=
 =?iso-8859-1?Q?+4RyrpIC+ZM60o1b/1OCcArcU1acyqO5CVwWOmpfMVPjGEHSrc1GztrHIA?=
 =?iso-8859-1?Q?j68FA0OTPHVHWlhUtQA5yI8Tgpk6BvVyRsizoPuATKXlVvcHcQm1aBLdNz?=
 =?iso-8859-1?Q?CBLFSqVucKviqXCVTmQKtrnV3cdXXf1BIrrI+Zuv5/0Xp4Q3XWrF0OYm8H?=
 =?iso-8859-1?Q?TdaqQESOFpaBXvzLA2vJjCYIGIKRFkVaq8HtAuYbRugiQD0xSSkGVFE0iz?=
 =?iso-8859-1?Q?oPzEQuk7rFru4cdRwL99+Vafw40ngVOqkxWCpHF8JMVGds3tfd/n26bwQ0?=
 =?iso-8859-1?Q?cXGknCXYblaZIjdbkcyp1lZ3XWtUiHAW12dSQ1qNQBV8XKP3NM9ukZlMC+?=
 =?iso-8859-1?Q?hwYTjl2Gjs?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bef76a3-2baf-4872-1e6f-08d96c855ce6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 13:43:49.3386 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M7DECcgww35ZhklOugSxPCk7dWfghy3hf0t/mjgLYpt5eWJxzFrRmKURUqc6FT7pwdAxmyDyHzw3Gi+RmxfDhkWENueuxn44QWnBh0vgLNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3841
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-31_05:2021-08-31,
 2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 mlxlogscore=682 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310077
X-Proofpoint-ORIG-GUID: HXXayOW6U8T8vgjVDZBJ4Cmif9-IJkaZ
X-Proofpoint-GUID: HXXayOW6U8T8vgjVDZBJ4Cmif9-IJkaZ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=823 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210831_064357_201334_5638CCF6 
X-CRM114-Status: GOOD (  15.67  )
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

Hello linux-nvme community,

I ran into a 1 minute deadlock trying to disconnect from a remote (tcp) controller while the network was down. In this particular case, the network has been down for a period of time shorter than the kato. So, the kernel module has not yet detected that the network is down.

After further investigations, I found that during a disconnect we try to clear the NVME_CC_ENABLE bit - see function nvme_disable_ctrl() in host/core.c. However, since the network is down, this operation blocks until the 1 minute timeout (default) expires. Therefore, the disconnect operation blocks for 1 minute.

Interestingly, nvme_disable_ctrl() defines a 5 sec timeout for reading the status (NVME_REG_CSTS) from the controller. So we have a 1 minute timeout for writing to the controller, but only a 5 sec timeout for reading from the controller.

My question is: On a disconnect shouldn't we use timeout shorter than the default 1 minute when writing to the controller? At the very least, shouldn't the timeout for writing to the controller be the same (5 sec) as the timeout for reading from the controller?

Thanks,
Martin Belanger
Engineering Technologist, Dell Inc.

Internal Use - Confidential

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
