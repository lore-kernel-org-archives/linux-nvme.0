Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8CFC4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 07:39:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAB76135F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 07:39:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAB76135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rUckqs0FEQ2+JL2CARzSUcs43wZ/31aWRZ5dcMohuaw=; b=eywOPbhNiabsge
	6zA/6fa68YmmAoErhJZdYgHvxYXOpciByPu1bs5MtSkfXtxo/kv5WOhO267IasPbxYlP20XkfV7hD
	FngzotF/50rS5P4U4iwUUmqw41JT5fyvn8ZSmZ19Q8Nwx81HmCJBangXGOt0MU/hGrZgIh9A04Lp7
	1RWkXlqxPCThmTFiGy5uGwtvo07avBGfyXW2ffXUR4/+lD7MiRWB3S6Zt7j1rJ8KartwD59pRaWkg
	iexROgYOeGsa6uY+J13kAGXPSnfm35Rt/dKG9I866wyLLCaupxej/bCB+TFDxaFN1mjEMQ1JJd/w9
	aYLHENm+5vTIg+87hG7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmAbS-003QwS-Tb; Thu, 27 May 2021 07:38:50 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmAbP-003QmL-Oc; Thu, 27 May 2021 07:38:49 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14R7WTY1012889; Thu, 27 May 2021 03:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=vC2OXWN88jLsic9NCNfgZtYHtHjozkX2tRQQXQVZikk=;
 b=ciwu0oTkw78HM6q3wP3gIJ8X/eGwhI64Gc4eJNhbKTVp5rLXxqK0Tmjh0IRhEQsWR4kf
 eoLDmwLahepaj+4ShQN1Nt3qZ51B6a6TB06iWq4Zn0IvVZkBk0tETcK3UAGEqpfEjGRX
 ALWexDed61Ixp7yxOpkd2jIvfNXssRnq1T5P/1kyZzAp5U2akvOS8VLk30wBmGrtfj9W
 EIu4QvmtbpuPoA075v3he5HJy5OJp4scROncTazgSFiCvId/2a69jt2gP6Eh7ussgEGQ
 SbrDXPV7yvt2U7r2QZi3cUIy2wHp9EbxaKw85omQ8AjMnXO9DkieHpqdewGzgr8TRgJ0 6g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 38se3g5pfm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 03:38:30 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14R7UUM2006776; Thu, 27 May 2021 03:38:29 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-00154901.pphosted.com with ESMTP id 38su52ry8k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 May 2021 03:38:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCn4tVH1Z3tRQrmuej/tGv647CKRxHNq+nE8GTV99TwZGN2cksR4w8M9gorawmC7E74XyRrVUnPYwy5xDzOPQgV4FrenehLyWVez/U5XDzlMDGXQNv9FB7WpV6Ivd6yY9+rBGnPnr40OvpJsjg6TU6Y9/5zd6mRikLWsGngjTb6qSHqs6sosbQstnZ8n8KfTlvpGAYZb2vl4mSXZFC6oInJcRQQrSKnl/SAw55MsI6UiJW+W/ZIxFCFDX4Fyfn5cgheG4DD5f7o6gjiB2WlG76eg6rz4Dyzbr4b1+6lCRIp0H9o6ryvEijKmTSriYBKwvuswX6L4kc+yauw8/qEKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vC2OXWN88jLsic9NCNfgZtYHtHjozkX2tRQQXQVZikk=;
 b=lbbUY38yWUzGqlPSp4OKDMEOcx5aE1mdqJLqM9yAwj+5G7o3CKpd/XIB05gFEQzD1Ih7YL8HPi+S5QWn78KHsdYP3JYJ9AIc52I1wPhhXY4/K02CRfDVJ7+G1Yx1DAXhOx9RFwfHwOeqSkG6mpZ6aFLjQSGaFktZo/AVKyWrRRLSJrNMru15oXTeTtGYtWKRECKau9Lbeg+3lLBqOTnkHpo0ZSEhskvdy+5oh8G2tr6Wmgj2/4yN0X/xv0f3s5VzI3oPmWsj7O9GVBHzplk8YTTctbKEo9dXJFKwbOagO7WbLt+ex1NbChNgK7yZrjXSMF45nq9VUuScw2ebBhK3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB2236.namprd19.prod.outlook.com (2603:10b6:5:c5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 07:38:26 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::60a1:3d31:62fc:dab0]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::60a1:3d31:62fc:dab0%7]) with mapi id 15.20.4129.036; Thu, 27 May 2021
 07:38:26 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] nvmet-tcp: fix memory leak when having inflight commands
 on disconnect
Thread-Topic: [PATCH] nvmet-tcp: fix memory leak when having inflight commands
 on disconnect
Thread-Index: AQHXUI9pzO/zVxq+W06FBcpHJ9+l0Kr1zymAgAEmFFA=
Date: Thu, 27 May 2021 07:38:26 +0000
Message-ID: <DM6PR19MB40119772494E2D8890D1634FEF239@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210524112441.27400-1-elad.grupi@dell.com>
 <YK5Vl75vgpi2FsvZ@infradead.org>
In-Reply-To: <YK5Vl75vgpi2FsvZ@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-05-27T07:38:24.1423349Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=36005735-07ae-4c77-8b7d-91ba0b7315b9;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=dell.com;
x-originating-ip: [87.71.40.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9ab551c-ec5a-45d6-0793-08d920e26a3d
x-ms-traffictypediagnostic: DM6PR19MB2236:
x-microsoft-antispam-prvs: <DM6PR19MB223654A4DD5DCE00F4E57655EF239@DM6PR19MB2236.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ab0MclCE5+az6QLSgzxI/rlm064aA2znl0cW3JjBmbIygjdOo+0h3Xnm94w97McHpQ2cwTy8Z4tWQiQ3jJriUYf013So2AfeAsFW45EegA6gYzR93Ez9w5V0d/wK1oMTV8npUtE5f2KbbMrIXiyWu/XLAjwuZxOWgSRkhGEXuVQsnswYKByMeAKX6pnNgGCTUMKxKpDBHei0mZ2z0WMvGVE29yR3GAHI7NjZ9K9iW54CkGxunU8smAE50xHaJ5IQXVny63n3uUsIwCaJrHKwfL6wT8Aqom6j9kGcE91uVzJtfu6KJ9Gh0Vtry74bYL/wn01KqZPjEvbS4dv41vSvM5OnQjBQh70MJdbsaTXt5qoULf8VF4e0F8eImvNEd+MMLYiOmucOsFAB9X7NUVle4KBq4WgNF43k5SE5EhZxFx9mTwKZ7HYhxBJSR99Yf+Vyw1QEy/TBZrQuVgk8BDqdkOuLCwu27SHPbtxgtbRrGT05FaUhqbT/jdfz71SiVTqV3gzNhKF/eMi9XW6XTDgk+UqwsCfZYlCo3rzpRGh2996TUvvAQttUtADqE0TukTDY1HPqnYjWtmZGDPGt/9SXZIHKJ0SQ046hctheNxinseM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(316002)(786003)(9686003)(54906003)(2906002)(7696005)(33656002)(71200400001)(8936002)(26005)(4326008)(5660300002)(4744005)(86362001)(55016002)(186003)(478600001)(76116006)(53546011)(52536014)(66946007)(66476007)(64756008)(8676002)(6506007)(66446008)(83380400001)(66556008)(38100700002)(122000001)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?L1RGYnNpSEluNGQ2bGE1TjhyRGYxQUZTVUhwM1pwVmhOWHFQUis5SnJiRkM2?=
 =?utf-8?B?Y1NobzFqZFdhZUdUOXdWVW5ZcnBHMDNMZE5FL2VDSUE5bjJ6akROY01EMysw?=
 =?utf-8?B?a3ZsMEs5ck1xQXdsZHMvaEVJaUlkZG9IVWYyTWJjbEE2U3gveDk4dWVkZnZW?=
 =?utf-8?B?MndnMEdaeWlrTGFmMUUzUXVReVlvVlRMbzBJZy9GOFZYY0ZnUXVMQTlzWWdz?=
 =?utf-8?B?RFJ1alNIZE5yR3Z4QWhlQjdKZEsvL1dkS3RwbHNtUlJrWGZ0cTF0OEVxem5C?=
 =?utf-8?B?b2N2dnZ5Qm41QzJPcXZUVG1ibjZDQWF2MFJDSk1DNHo2bm1wcVdsblF6VDU0?=
 =?utf-8?B?eEpBODVZM2JTMU9mcXg4Vk5TTTdNZWVwVllyRTdpamZmNkNNOFRURFcxUVIw?=
 =?utf-8?B?RjRSU0poeENhaHYrL2swREtYdlozNkowdVZmUWVsWnhGYVZvcGFIaVhMUklr?=
 =?utf-8?B?R3ZUdzNvbUZ6VnRXYjNZcGh4THl0dmtoMmg2MHN6VGhySHQ4RWFEcXJJWEFY?=
 =?utf-8?B?WlVVeVNIMHZKbFNBaUpUOENMWXZkQUhwemFibXl4am9FZWtxS1pOL0duVDNZ?=
 =?utf-8?B?b1ZJUzFxTTJwN3lDRGx3cXJLcHZjZmxuTml2STVRUWlRUGZCZWhlaHJnVTRZ?=
 =?utf-8?B?YTZ2TE5aWWlUemQxUnUyem1mOGdmbzZCdnZlYUtCMmxWNnhUbVl5SVhSUGx4?=
 =?utf-8?B?RTI2UXlRK3R5dUpiRXJUMzdPdUJHbm5hZTZYZGhaKzhBVUFsQkdRRXZMMHdR?=
 =?utf-8?B?c25BbFNDUUROTlNoek9iTlgvVjkyR0YzbTBuanlsdFZqb0tLYVUwSlRuYmtE?=
 =?utf-8?B?WGFoeTFydDBrd1FvN3NqemhoRUpFVkpIM09IbWNyamgvUS9nT1ZCSTdiMEkz?=
 =?utf-8?B?eTcrSmJrRHFRTno0ZFQ0SHh4aHJiejljWWFwajdwdHpRMW85ZGM4Mm1EWnVW?=
 =?utf-8?B?cGoybXR6bW55NGdpOVdoZzgzNjdidm9PdlN1dkswWnYrdGY5ZnhZMkV4VVMw?=
 =?utf-8?B?K0U1akZzVlFGRUxVckI1SHMwVnNwWXZ0dXRwVXNOMEVRUlUvRFZNcGk2SGd3?=
 =?utf-8?B?d0syb24vUTM2a09CWlBnNFBwdDJSeDlkK2NjZVRENGUzSDdpdElTeEhuMXpL?=
 =?utf-8?B?YXM1cGtvM2VOUVoyZ1FyMzVGY1BtYzRPZGZDay92T29GaElQeEthbi9vZVNv?=
 =?utf-8?B?SFBmQ2M0dG9vdXd1amVqUCtndFp4SkxGSU11cE9KK3hmVjdQbHNtMnordlFz?=
 =?utf-8?B?WjdlVU14T2l4cjNmWERqQ3JCOU5pOW1hOWtKTk80eFFxRzlLblRrZWVLZGsy?=
 =?utf-8?B?N3FVamRteE9kWDc4dEFkb004ZHgwTjBzYVdxT1hsSE92MityTGhZR0QzNjBV?=
 =?utf-8?B?V1l5VzdWanJ3MzB0ZHhhZ1ZJNWt4bXBiLzdOUnpyWDRHUFQ5QmlFeWNRWXpG?=
 =?utf-8?B?OWZiUk5CaHcvdFNseFZEaWJMRHBEY1BwOXFVUUFuSk1UcmhpYmM5dGxtcVVu?=
 =?utf-8?B?NVQ1elF6b05kNmJNOUpvSXBIbHp1d1BiMnVqVkRjWTVGYW5iZ0pTaXpBeXJS?=
 =?utf-8?B?NWp3ZjhWS25pb1FWYkpETTd1U2hDMUF6WjhsZUhvVXNOTVBqTUJMZEF3Uyty?=
 =?utf-8?B?OWo5NUR6bmREMVpEaHpkZWV1SWU0ZnlrbGZIZ1FVRU5oamtyMXUyUElsa2VJ?=
 =?utf-8?B?L0ZKNTYyeFJzYjNEaGY4YmFTVk1oaXdSaFZSOWIwUXQyM2I0Wk9SN3JXTkF0?=
 =?utf-8?Q?5GAozUUDBklsmb+0Iw=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ab551c-ec5a-45d6-0793-08d920e26a3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 07:38:26.4886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1ywqlIHs2h8uN/awAiSjWLqzLta+W2cdIgelpAY602gwPGzdVMGzSi2JEnLhdiqhO2UW4ueylPPnSxj/A9agg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2236
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_02:2021-05-26,
 2021-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105270051
X-Proofpoint-GUID: tdL6pL2z6iRen_DBQ8fiiN6BG2rxqzik
X-Proofpoint-ORIG-GUID: tdL6pL2z6iRen_DBQ8fiiN6BG2rxqzik
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105270051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_003847_998361_3C5CE75D 
X-CRM114-Status: GOOD (  17.29  )
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

Sure. I will prepare an update to the patch today.

Thanks,
Elad

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org> 
Sent: Wednesday, 26 May 2021 17:05
To: Grupi, Elad
Cc: sagi@grimberg.me; linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix memory leak when having inflight commands on disconnect


[EXTERNAL EMAIL] 

On Mon, May 24, 2021 at 02:24:41PM +0300, elad.grupi@dell.com wrote:
>  }
>  
> +static void nvmet_tcp_free_resp_list(struct nvmet_tcp_queue *queue) {
> +	struct list_head *p;
> +	struct nvmet_tcp_cmd *cmd;
> +	int c = 0;
> +
> +	nvmet_tcp_process_resp_list(queue);
> +
> +	list_for_each(p, &queue->resp_send_list) {
> +		cmd = list_entry(p, struct nvmet_tcp_cmd, entry);

Please use list_for_each_entry instead.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
