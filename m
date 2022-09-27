Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF2EC07E9D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 10:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7rrypiaUcA8uzUtUH/brCbHjrjfO4s9Ac5WPzUGQJgw=; b=GF9Jg04QiOBVxM8PLk9W6R6+6t
	m4Hn55XI688mX05ox+8f0wmAZbmdDRs25+mAlfA5hevNEhHJNPgvIK4A92YAVbr/Sd+X2KsczPqv3
	9ynniwV+DdTtjFYyESWdNdOQO0A7wS+17h4X5xIWfrI3ky5vQ/YKG3RUH28Crji/5gEX0rrv+vYiJ
	WvYUI9vktotbChq1Owd451dFUJnyM/dwXjwwuk3U3jCKAgTzy9AhhI7hvFiWYyyRUYWSVYsspwZ0O
	IdJ9aTIp4gOG7iT1E1WrnFslRw5V69yWikWoN+/lM8uyeTEekUWVOvpyxH+LOKtyo0oJTPAoGQXya
	zbvCyzHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od8Af-009yuD-It; Tue, 27 Sep 2022 10:50:37 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od8Ac-009yrx-5A
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 10:50:35 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R5xxmd017248;
	Tue, 27 Sep 2022 06:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7rrypiaUcA8uzUtUH/brCbHjrjfO4s9Ac5WPzUGQJgw=;
 b=wnoLl06nS3Ix9SNYxRfITQrfXOq1YX+/mTSrQxsYl4LrpKpE4QGDrkbtirNvjJ3GrJNM
 XUc2CnuoqVv3cZGn/6G2hOp/JAjCxxd2Kj+0l12YeuTVQEZ99jom4YUvG79pTYuRE0y5
 LG3XUjO//d3XheWPujkOETinq9xnxigtcBBLDtW2/5IO7gqchMNMnl1rvg8UKKatEuvn
 cu6lkzwRkxk9XzX7gff85xERvHjl15cLdn43hbItOmoUj+3GkePC+zb83098oI3etRlV
 9BUDe9Pc9ToNQ8op+GKSOnvYlojqVw69fRxmfPopObV/qaPClxfC2NwRJ6lbk5qPu9Fc UQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3jswwk3u5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Sep 2022 06:50:14 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RAhMCg037533;
	Tue, 27 Sep 2022 06:50:13 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3jtex886aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Sep 2022 06:50:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iasj+EXqwDfcHL/zN/k2wep+I8Hv0mNhmR62FRw8Pa2hcamqY0FZApKA4qiPDzEyrAM4wo7JvKN4Cia/D9oe9Y/rx3E3Fzav4rLrUfDusrXqJa0kA67NYYBF8TPy1Yl7Y/M43ryi05y9dqBka3Mnq/ENJBRej/fq7yN8ARtjALiZ4IxR6a0Ps46BxmfwEbzQYSqgXxsJ94UoAv0aYisEaG7/iB+WSn1JErt0KfWzvjGdnyukj71Oj99nZ3w8me3VbzJRx77mySI08fE5mNHDjCkotYz9NqjGF+7G++3/pSj1/KtEDaty9JcT2VGCfB7PqhFDs1KuvPrZJjaCud1gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rrypiaUcA8uzUtUH/brCbHjrjfO4s9Ac5WPzUGQJgw=;
 b=NzYkVeWrkIVHKs9jElQq48q0wwCFUS68zg0KYazDAUeWnAN1TrV2QXRA96BtV7pxFk4vqQ5kMEGCT5v6hdL2sovtEKbGUOsHk+NZRn0bIrHHXKCayB1DntTCFMB5Zye1TdFuEuUgN60PE7zlh09kxfe6N3tcqJz6t9nenPVaMP6nqAa0vc0cl4z2gx+PbxTOX9UvRvTFyRg47X2VhktKNuPBHKNYSaQDwh96kb7AwzMu7Y7ZbPPiJrA+FQTYdTV9aJC8eKGZfnPEu2PVJwf0a51zLPdpxekxW8Gvb9Td7FecsuCPXU9bqed0gj38X86TKmoBDg78ke4AQfHyHBUV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by CH2PR19MB4071.namprd19.prod.outlook.com (2603:10b6:610:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Tue, 27 Sep
 2022 10:50:09 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::9812:8a89:ecb7:12bd]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::9812:8a89:ecb7:12bd%4]) with mapi id 15.20.5676.015; Tue, 27 Sep 2022
 10:50:09 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Daniel Wagner <dwagner@suse.de>,
        "Belanger@carbon.lan"
	<Belanger@carbon.lan>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        James
 Smart <james.smart@broadcom.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: RE: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page
 when a discovery controller reconnected
Thread-Topic: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page
 when a discovery controller reconnected
Thread-Index: AQHYzlu0tedC6U3kP0+TPre/yIrPDa3y72SAgAAxauA=
Date: Tue, 27 Sep 2022 10:50:08 +0000
Message-ID:  <SJ0PR19MB45442FA5051872B841C308ABF2559@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-4-sagi@grimberg.me>
 <20220927075213.6idrtq4sbiobtr3m@carbon.lan>
In-Reply-To: <20220927075213.6idrtq4sbiobtr3m@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-09-27T10:49:23Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=c0fa9d47-fc4a-4a2d-afbd-de125def4b14;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|CH2PR19MB4071:EE_
x-ms-office365-filtering-correlation-id: c7065d3d-e87c-4a85-339b-08daa0760bc1
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  0Z9mdREl5DgqIVva2ZvjUuU1Ht0n03CCLsAuE71pzk7FEyeIc/Vh44ilUwfaGUJpDEZpprrHEksa1H6EAYM+HIRiWas7xXmbp4mR6rM5++LIwvAojYC9Q+znUrwwTJMhJVk4FDRfXZutF8RHF7sDknA1O2F8uwwo7zoK1u4xrK/33cpRxl0PX4keyPkj8OhGzsL57Nk+pRVgYphj8Yu1RpQWYc/Oh7naL+fc1O2mn7n5uUihP3zGaH/PX2xpP4Sh6cfD0lx2GdgfB0ul+kIyMG8rLGpHefIe6t4U9idMadqQ8CQ+AoV0zJ0Kl8eC7MEOY326VwbRCiBKhUoF/X43QY5JOubob4aY2dXD/kyU3B/ngk17sQfvXLMB/66+lP02FjOt3o3edn1yGvb9xV7mWXLuAHtLtFHT2+k4yD1chxDigUKWL3qAtq7fpuDGBTec4LO9ODHLOHMpOTc4oresNKDvRawUepxrLrA1bxohLLuBkgik8vcNvdvbYOi1xj4vy3Hct+v2SdUMBzWC2VuKZbMA9LprEx5GtisnmGNy/MByWzYHdxm0rkZEVy9tJ/0nIJ3rF48eQU6vemOV4Dt7d8iEunRyvy6tQdkBpNvGvuhBqRkBiqbgDiooeACD0XLFJEmrkml/iGKvZt5SiVMNubzJYlvEYL8g1b/XUdDksvG7W35tvCGiHTOhDc0h3FIorHO8P8Kj9HwbXzyiP7MObdoSI8o/Aks4xM3PX7hkOHKaTzidnInw0k69nEmWMPi7lK1bhP6Uw3sT0XylqpujyAN6pP3C/LX8k05/AGQGkM0=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(7696005)(6506007)(316002)(786003)(38100700002)(52536014)(54906003)(110136005)(82960400001)(186003)(26005)(8936002)(9686003)(86362001)(122000001)(2906002)(55016003)(41300700001)(83380400001)(38070700005)(33656002)(8676002)(64756008)(66446008)(4326008)(66556008)(66476007)(66946007)(76116006)(71200400001)(966005)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?l144nRoZJch1p3ZjBghNJRyMxOjX5+uRgqgfln8U4qNC/Jm0BDEfJ1unIW1W?=
 =?us-ascii?Q?46Iz2MOHSUacv6RYvVxHZe3TSeINyP4ceeX+u6Xfxmggoo9fCzXiwcJ4mjIr?=
 =?us-ascii?Q?M/p5VdvZgsoLuK8uon6OB4JtLVkbxUWPrsQAAxr5COaBQFs8z8CwzmiMZ4LZ?=
 =?us-ascii?Q?CVcheKXpcQTrg87NDjGG8mcJ/MTNUB/EPF3VkHWDPBMix7cUXrak0iLhybKM?=
 =?us-ascii?Q?gxTdzlDkkCFbpWvkzp+x3Qy5H3ZNTVUrqufx25Wj2LTvdwBg6FmJWfyaMTuZ?=
 =?us-ascii?Q?OrxMoH7YrFcMbSzghtCBFeCSpU4ApTVX8u+ldaVH/h3NpUWzCG+isTS0WF+P?=
 =?us-ascii?Q?QDPPlGuhp41un/Ko9JoHtK12kFd/jMsVGUs2OzmwU2IYYyh5dyD5mMg71StZ?=
 =?us-ascii?Q?z06AHqlGPhKJGXIGoK9J5n1YYzCt+kiIzgynKrCLinzLHCuWqDviFC7gL8Ji?=
 =?us-ascii?Q?KP+kMu6auPNSk4Dr1Z6T41E0XJwcdlsQx0Z3V0/AVdKwVLd7wbmDbiBAtzLe?=
 =?us-ascii?Q?Okk+Tgqlni/7gye+Scn51ZQN9x0lXPELRTug3DddsBYsq23U0KJrughqfckc?=
 =?us-ascii?Q?GiDuZn96LXxyuhoisgglhfA5u50RP9QF3Cdb7oE2PMliK5pscdbJKH0RBIZ5?=
 =?us-ascii?Q?88ZzxPsvQZT/95KHM6fa0Bx0lLn7dEYy+EFG5o4UgkKaEsMAvhpn8/QdJtV1?=
 =?us-ascii?Q?1ARky+sSm4V3R+VDGQKsQzX47DtbAZKEglkekqygeoh4o42yDWPnuiLzjc0o?=
 =?us-ascii?Q?r10X7L5JQ4u+M6yk0gDzHqiU/WwnQV//+ujuGGrBmLyjNQM+4jUAw7Pd3DJQ?=
 =?us-ascii?Q?TBQD0dq7paM/O6ZfEFyrzDrJfjyXgYi0//2nO3WRYBGYbdnnDWQwKot8rmOs?=
 =?us-ascii?Q?cvttL3XIADNAz/b1K7jdORhKGTxzWtjry63HQacwAZr4VlXJdRO6IpLisQmS?=
 =?us-ascii?Q?3lrwogg00sutVb3pnTxWf/Dy/T0miI803gtSjN0hvmJyPMyL6aanD2VCM2SU?=
 =?us-ascii?Q?IXROYEXmYnqzfdt2cvMUVRMiMERncY7tuJP6ji+QATzJ4EOwE94kc5U+vxWR?=
 =?us-ascii?Q?pAaK6dCLQ2hsuk3xHHcro27W+t2PFofuUeD72RMSuDKJOxFMm5BRuIh2EHcm?=
 =?us-ascii?Q?qhRZzTkHvBFX+LmdFKc/mJAsOnKCZ+G78AKndzWAl70rrxvDTaboFYK0bEPz?=
 =?us-ascii?Q?X/2j0Vy0QTl7M6Vb2kfWb5puO7tSMSuGdc+Icgb+tWra6eapmlMlZeWb8x03?=
 =?us-ascii?Q?/M6GJb4j1+ftJp1Kh/Dq2h+AXDixAaTSLGJYbr63qyuwjHl1DCepbik0PcY0?=
 =?us-ascii?Q?fY7PUzn/MuUG3eH4l1/BXCsPWeuDqXnrJLXGCiz6wk9cI0MIri7dd4auyOmB?=
 =?us-ascii?Q?SVpDRpMc+GbDl5LgY2h8RCYgGh0xC1QbtBMp0nU8y0vFp9etZbkIBNd0Sgrj?=
 =?us-ascii?Q?INIhu8P7YTr9AZLMOShWndQt7sBtqLTmxiD+wZOAXWVH+WBYrw9JkwoZ47L5?=
 =?us-ascii?Q?xNhNzc4EPXqV9ZVrhASEFSLXOCSLQiP7EvbzrzVGz+A7g77P0Ed4T6/kegQP?=
 =?us-ascii?Q?flCAFNq4e4up7xlaiIBFlWOtuHUMJKBs0ekZMCSQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7065d3d-e87c-4a85-339b-08daa0760bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 10:50:08.9659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mURm4FHpYRE1owIb6kL3znxvBG3aGIF3RM1d273J8VpwYDuSMas3izKHhlsHUjo1ivgWSjOEpZNCdpM+uMPNiC//TyWx5rxJMmzxqjuLdsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB4071
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_03,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270065
X-Proofpoint-ORIG-GUID: TaD4GUEgTmV0-Jeulvj0lxJWxkGpir5G
X-Proofpoint-GUID: TaD4GUEgTmV0-Jeulvj0lxJWxkGpir5G
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270065
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_035034_332206_6041D65C 
X-CRM114-Status: GOOD (  29.26  )
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

> On Thu, Sep 22, 2022 at 11:15:38AM +0300, Sagi Grimberg wrote:
> > When using persistent discovery controllers, if the discovery
> > controller loses connectivity and manage to reconnect after a while,
> > we need to retrieve again the discovery log page in order to learn
> > about possible changes that may have occurred during this time as
> > discovery log change events were lost.
> >
> > Upon reception of a udev EVENT=3Drediscover we can kickstart discovery
> > on the existing discovery controller device node that generated the eve=
nt.
> >
> > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > ---
> >  nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> > b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> > index 434cc080ffe3..93e438863672 100644
> > --- a/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> > +++ b/nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in
> > @@ -17,3 +17,10 @@ ACTION=3D=3D"change", SUBSYSTEM=3D=3D"nvme",
> > ENV{NVME_AEN}=3D=3D"0x70f002",\  ACTION=3D=3D"change", SUBSYSTEM=3D=3D"=
fc",
> ENV{FC_EVENT}=3D=3D"nvmediscovery", \
> >    ENV{NVMEFC_HOST_TRADDR}=3D=3D"*",  ENV{NVMEFC_TRADDR}=3D=3D"*", \
> >    RUN+=3D"@SYSTEMCTL@ --no-block start nvmf-connect@--device=3Dnone\t-=
-
> transport=3Dfc\t--traddr=3D$env{NVMEFC_TRADDR}\t--trsvcid=3Dnone\t--host-
> traddr=3D$env{NVMEFC_HOST_TRADDR}.service"
> > +
> > +# A discovery controller just (re)connected, re-read the discovery
> > +log change to # check if there were any changes since it was last
> connected.
> > +ACTION=3D=3D"change", SUBSYSTEM=3D=3D"nvme",
> ENV{NVME_EVENT}=3D=3D"rediscover",
> > +ATTR{cntrltype}=3D=3D"discovery", \
> > +  ENV{NVME_TRTYPE}=3D=3D"*", ENV{NVME_TRADDR}=3D=3D"*", \
> > +  ENV{NVME_TRSVCID}=3D=3D"*", ENV{NVME_HOST_TRADDR}=3D=3D"*", \
> > +  RUN+=3D"@SYSTEMCTL@ --no-block start nvmf-connect@--
> device=3D$kernel\t--transport=3D$env{NVME_TRTYPE}\t--
> traddr=3D$env{NVME_TRADDR}\t--trsvcid=3D$env{NVME_TRSVCID}\t--host-
> traddr=3D$env{NVME_HOST_TRADDR}.service"
>=20
> I was about to apply the change. Though I just added the change from Mart=
in
> where the --host_iface argument is added to the first nvme rule.
>=20
> https://urldefense.com/v3/__https://github.com/linux-nvme/nvme-
> cli/pull/1675__;!!LpKI!kH_mYipHgbqgVMaCaU3Jo03OOkaawd03WAxINmKpN
> 1LsV_CQAbAXkX24oxXLrHDNUfwUuQLFcN6KriuoJuY$  [github[.]com]
>=20
> I wonder to we need to it to append the --host_iface argument as well.
Yes, the --host-iface should be added for this case too.=20
Martin

>=20
> Daniel

