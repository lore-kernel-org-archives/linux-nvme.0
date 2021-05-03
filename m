Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D12C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 07:21:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB7A561175
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 07:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7A561175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V4/hrMuGje7ig4TR+tVzc5sBw5KPIDLl7Yx2Sx7EWGo=; b=RxCAK1aF0hIVeJSvC1mVS5PVQ
	/eE8z+8acKPDESvfIbc8Pg1IKY0RCTVNlSZLqdiwFz/eL672L2iBZeFsZfTmIl2VP7GqKceOXDipR
	1EG0t3lipCry5haMLsjg3yS635D0uo0eBe6nbCMJsP1IgPBLZdjijzgt/vsy7lEhHcGyhUuZic+VR
	qicdBjV6j048BeWxFSGnj8voVTo7t+//AVsOE/Ntp7N+6DJyPADrvOc6PwTUYAMP1rpLpO8yyHeEF
	OnCiD16PZRjSrNgj6D6ttR1kDbIv9xJmy9NG3/9lskOVwnnMA1rIT32gxt2Co88xS5J9tHK/FImqh
	JqQoJOwew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldStP-00DN1v-Mp; Mon, 03 May 2021 07:21:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldStM-00DN1j-Tt
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 07:21:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=JiyPOVuDOXJayt0OsGyInoVxgraf/cWYJ87hHpCMklw=; b=Alw2MmU6utT1VmiI9PJQcSvIlh
 xnyotzNTR9/PJjsTTxMDkXkZbm6VXGmm1DL1quMYgQ4+MIVnE5oxcQZ2tgb3XUeuVA2fwixszZCIY
 KzHGp1Lm18nTO1jY8+19JfnBNre3ObFDEjvBsQu//rVuzbhLtkSCWpALHtSGxbw2ryevzJxJeCaTc
 Vv1H1B2QLrTewkG9ypTyAsnCOCHdUlV5sFT0UQQWnskQBAE8TXLRMIpNXlzgo9npuTgYYMw/uhG/A
 pyUAyP1AIxG7uJHRi4vlHihMwrycITnWg4AopHPlgjtnDV6sFBkRr72Hsjc8MwhSMSwL5OO7P2zbu
 kEdtKzAQ==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldStI-002t1p-EI
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 07:21:19 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1437GOB7030632; Mon, 3 May 2021 03:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=JiyPOVuDOXJayt0OsGyInoVxgraf/cWYJ87hHpCMklw=;
 b=tqft9HAE9pkcvWYnjGq4ebkjCQXkKMhp1q0lzINCFskkMG8KzpaJVqjQjBkJBhZsUtKn
 0pz4U5zTr4MizBsS35SBoHAwd//yrGdKCy0uk4HwF0VfaMbnEgzMzKFRNCFFJZkyADcD
 7t98g9zWM+OS1R8dp1a+XfBZLYwoGP1pgg0X/mfNRByGJbQkMn3mnXd9zsHr/P7Lrgn9
 AVBRizzt621QacJV+Q0RdnOUcXm6HNvhtrxUvc8Rc/tlwpUdh4XUL1UCSzgSaZpsqTvW
 r4bCQjBAMuo7X5VXRJhUAw2CTmF650K+6KpawFG96xA2DB8kMv32H071rXlS533ItJf4 ZA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 38930m3d7w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 May 2021 03:21:01 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1437FFKX074844; Mon, 3 May 2021 03:21:01 -0400
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by mx0a-00154901.pphosted.com with ESMTP id 389kxk2wh1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 May 2021 03:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XO4tSsxxXO+Grq6DlMlFmyIBCuywJLnnGgkcMIUz+FFV1E/1KLUei+tP8lbWOcQZFYzpBnkkQweGBlH+xUXgwWSq9DH+tNQVA1MrTjKlmTThif0dovHDYH/ULsbM/GiRzzcO627ACW337vB6I5Gv7MbswZVNgwewDlBGyvWnsly3bnDfSZ2BraK99k0aMdNnIIBRilnK8gKrMPlcbxEINQed0XYBMt7IzvKWWgMPxvvt/zlA9M/qkM2WLi7h6LAUH38CIi+PVl92tCkVxwBNYqbnOHEq2yn0nFZ/op/v+uZlmKILiY4qGWeQrBLQcanjbUmYE38HvMTdAP65AHefdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiyPOVuDOXJayt0OsGyInoVxgraf/cWYJ87hHpCMklw=;
 b=bBzcGpQEIl78eBEKWS2Msis1vpI5E98dqSb+G3qldSNaFfKMFwP0X3oGdJk+3XuOLUYlL82X6tM5QhUtPT22IrJXREa7puFfC0wa4AauDSfRcKoRH46f/KVGN/2xR++dVKaNkXrVIpRsozQtueQBHvI+k5xTzgZMMUc1ykEVtdsENDVPlYG8O8AOvED3teikBFz5pIkzooYrKCe5fiSVR++U4VH0OKoPKJZNWM/VF8vPb7wwp9RyNOIq9O6+A6BBwDpt5HEuVo2dyuFTQ0saqUtugczmpnhn19qrHyvKCrq8proNEOMW9DgatDlE7cNLcFSoZsJX27iwRksghBaenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BN8PR19MB2929.namprd19.prod.outlook.com (2603:10b6:408:88::16)
 by BN6PR19MB0017.namprd19.prod.outlook.com (2603:10b6:405:61::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Mon, 3 May
 2021 07:20:58 +0000
Received: from BN8PR19MB2929.namprd19.prod.outlook.com
 ([fe80::8fe:c1da:4c1a:47b1]) by BN8PR19MB2929.namprd19.prod.outlook.com
 ([fe80::8fe:c1da:4c1a:47b1%5]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 07:20:57 +0000
From: "Rao, Vinay" <Vinay.Rao@dell.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "Belanger, Martin"
 <Martin.Belanger@dell.com>, "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>, Martin Belanger
 <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPGuycJt9Bz7cOUOllIRgoPqYsqrMhECQgAC8igCABBgqgIAAARUg
Date: Mon, 3 May 2021 07:20:57 +0000
Message-ID: <BN8PR19MB29290320440FE9740E699BAC8F5B9@BN8PR19MB2929.namprd19.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <20210503065235.GB32627@lst.de>
In-Reply-To: <20210503065235.GB32627@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=vinay.rao@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-03T07:21:00.2032277Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=b102288d-edd2-4688-b507-f747f09513cc;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=dell.com;
x-originating-ip: [49.37.18.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df8e4884-7a0f-4c38-ad8c-08d90e03ff26
x-ms-traffictypediagnostic: BN6PR19MB0017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR19MB00175278364B370FA42C0E178F5B9@BN6PR19MB0017.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SRRj5q3HYAjMLkxaupguNPLHKCZtUDGvawnkY0eFrfW5YsmdOFrona+EX8pHiGfaqdNqONDWY3IbYkVbg8UlryzsLZ/xLH+rjPWHkJ+fMUk3p+l+1n15GroyWbcSqn0NMUGBhphInP7Nccyu+vaeoBmw+EZeZkaNuyc1ctyEiD7DIakeYu2CDNRZjBJO/jZLzFrVX530kNMLlUZbJxKf3BSXJZFAt4m2ZUdy2euL8Ptg+5vHmN4nidgL5Ti6s4dcX+UgUBL+vD/RUQAdZXQfNk+UZ+56TYCD6WK335jYzkefCxx8fwwgw3NtWJZGMz7aOCdlxaxw8N20sGxqzFtw7uO5Hk8AOesP03oqyAeActKDo+sIIAIllU/CI/p58Xzz1ex2YVrfRPHhNs1LLtC9gI+WBuSJ7mMzA3BQO+w15fcSJYHJgEor6Gyvk1f9k3j+n7+PPtOR8Mlz0bmc/99nD/dQ58aTF7REbJCvh1NB0Bu0W7ekJgexfF+NyeJjUUl7tXEeMplAs6/RXqp21z9Uo+HzoiHqJijguagF6kZdqKCTIRSereL3DJnSarC5GIjA4zYSdhTKwXiLgnayFLmzETJmFOxT9R9mffZ5EPlJmhE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR19MB2929.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(4326008)(122000001)(71200400001)(53546011)(83380400001)(86362001)(6506007)(8936002)(2906002)(54906003)(7696005)(316002)(110136005)(26005)(33656002)(186003)(76116006)(55016002)(52536014)(66946007)(66476007)(786003)(66556008)(64756008)(9686003)(5660300002)(66446008)(478600001)(38100700002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FspEJ5zs5GlpNg49JYxHRDeSErpE/Qp4LoIVttxU9ubtf/Lb31zqgtMIqqkh?=
 =?us-ascii?Q?F5eFgwY9WNm6bgjBvk/AuXHgXwLruDA5shz9GasG3IgNZNZAbuTlNiuNvhXD?=
 =?us-ascii?Q?edyKtOxw2vzU6I1c9VUrMkBL9u/tsBtaPw7mRl/0MiUoimupceuZOBBtBUue?=
 =?us-ascii?Q?NnzzbjMYSY7u720a6/6abUDMQN8/QxB82QtycJMXpVVagMhMmKy3Lnd8QUuz?=
 =?us-ascii?Q?wu3YKTSysy4KvYOYWve6USB4uv8lxL9/yK0PVfDIpLYFHhsxPf/kwjIpfCgL?=
 =?us-ascii?Q?TZWj4bGHPCsFTrZOmMUyAQuGhRyC3Z9zx/y2chKEjbL8sAIG9ycufQFTuUKZ?=
 =?us-ascii?Q?P0SdT4TNry/3oW0kGiMcROqjG4GQl+IHDXz107HA+SMf+83NCeMEaNQS2q7h?=
 =?us-ascii?Q?zpcteEwdM6QvLdORNDeR9mpcypcUMdO++a/C6MaFYHSx9aQ5pmdaoCRzON+h?=
 =?us-ascii?Q?eLW3PiUFCszrxc1QfpAzdIR2Il0kgGcbw/51S/ftwClUFTxfS8GmgdVQe6Yi?=
 =?us-ascii?Q?mxBjinljB9JtkGeIVSlU0gqqlPeLJgZWrA2/kDfapcsXEM+rDFsU6FE1mlQ+?=
 =?us-ascii?Q?gFRO/OHhWEp/bM5X23XyEO8vV6NVGLQ984LYZGcpfFIsZ5SvQ3UiXK5acyTX?=
 =?us-ascii?Q?VFMt7Zi9Y0wIPTeZRSH2zf95WoP6BkRB1CVe+uSfbR4Fm901a/aQN0kFWh1e?=
 =?us-ascii?Q?fbplSEVoHc81vXd8yEI2cGf9XnF8i0BCgDpaS58zGMehmGBlr5xpVB4BPwC4?=
 =?us-ascii?Q?vZxgVGXuV38nZUc02MMmKXXsTi07bCCv7Xq4rV2Ie81UKUpxYwuybeOUWd/4?=
 =?us-ascii?Q?uZsVdTVW95r16PlfnmMMDLea+m8mWXjlLcbDKzwndLEmnHcdsRoRBt7IZeT5?=
 =?us-ascii?Q?o8VL5mCjTdCHpVNXUbBkqZ93ObfNOe81GE2z/gXlUR3Zqaml4RtCnUqFeToG?=
 =?us-ascii?Q?6/Hc2Z15TTQqtyxzLJAKLB+Se14iITNb5pVyr+Nk5TUcetSYlccqAFcz4DQk?=
 =?us-ascii?Q?sVddR12LTVDGFnXWOvAojMcJIfhWVGq1wb+mbWwCXGgIsS4COURpE5CnRRSU?=
 =?us-ascii?Q?lo/EnHO4hsj3/sAbReXPjaFh/O8reSWE7IT/FXRrjXiAsDSpXtNj12sXZHjY?=
 =?us-ascii?Q?AzDIPL2/5uI9Z5mVf2yFzDCuToC3SC0ZSusFMO/+cnwO5QvEni8CxkO/MVs3?=
 =?us-ascii?Q?CMDeTFycWTKOFAIjwK5yYXgOYukTEHcDD60O6Bo7O2M+pKeVCXWGU1haPg47?=
 =?us-ascii?Q?Rd8M25d8ERjgLtM4ywP61ceNb5p4Y19Xo03zOmGX6z6+q8M6vi7YIVwBMcRU?=
 =?us-ascii?Q?+E4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB2929.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df8e4884-7a0f-4c38-ad8c-08d90e03ff26
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 07:20:57.6782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtch7jzVIti3nETNNS/kQ4ha9SXlozu4GJ/UVtlBVBG7uKDHO+zlvi5C3wWmOuZgtD5/cCDw7sxyGR+QUbbsmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR19MB0017
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-03_03:2021-04-30,
 2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=785 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030048
X-Proofpoint-ORIG-GUID: yEtxFC-nO6YetjidHRLjtYpnJFp5h0Wq
X-Proofpoint-GUID: yEtxFC-nO6YetjidHRLjtYpnJFp5h0Wq
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=889
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2105030048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_002116_559180_18204634 
X-CRM114-Status: GOOD (  27.11  )
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

Forcing RAE bit on all the log pages that kernel cares about is one of the option.

Can we also think also think about an another mechanism where the kernel would generate uevent after kernel does a get log page. This would make kernel always to get the get log data first from the controller. 

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Monday, May 3, 2021 12:23 PM
To: Keith Busch
Cc: Rao, Vinay; Chaitanya Kulkarni; Belanger, Martin; Hayes, Stuart; Tarikere, Madhu; Christoph Hellwig; Martin Belanger; linux-nvme@lists.infradead.org; axboe@fb.com; sagi@grimberg.me
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs


[EXTERNAL EMAIL] 

On Fri, Apr 30, 2021 at 09:21:04AM -0700, Keith Busch wrote:
> On Fri, Apr 30, 2021 at 05:14:55AM +0000, Rao, Vinay wrote:
> > + Madhu
> > 
> > Hi Chaitanya,
> > 
> > Some of the AEN's like ANA state change and Name Space attribute change events are of interest outside the NVME driver. 
> > 
> > It would be good to consider these events to be propagated up to user space. I am not yet convinced on how propagating this above to user space is problematic.
> 
> The namespace attribute change event pairs with the Changed Namespace 
> List log, and reading that log will change the result for a subsequent 
> reader. User space racing with the kernel on a log access when there 
> are read side effects creates non-deterministic behavior, and that is 
> problematic.

The only way I could think of making this work is by:

forcing the RAE bit on for all log pages that the kernel cares about, and only delivering the uevent on controllers that actually do support the RAE bit (IIRC it got added in 1.3, but I'd have to check).




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
