Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930D4C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 18:42:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CD5164E6C
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 18:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD5164E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2LEPPW7xP7YhGGWa8jbjdTtm63+xeuJ+CjQDtu+MWic=; b=WAX23gegkdWG/JQl8sAmq+So6N
	Wo73GEcPRuYnLsPVz/l6Nb2h3OK0IJ72Xh1p5YIfRNJVe5lN7V2ytmo3dbdEbQYsNW4+SSgFtHI+2
	eTn5Hgix14DAitWCs2613kAdbjoysIVSPs0Y7/UxGozFHpzI3EsNAVrLd3zEpSyZ1zMSR7jMMFsIf
	s0isp4KLzFsFggeO4PpKxM2CLVffclGLgILRpo58rV/3hJKcX58yTxOaFFvULZ4HFo7HP0k0NgL9C
	GR9woh3dlLx5tGhcH5tOJoV50u8FOYr7Gkd8X/vKhcAlygZ6YvigMlCdfOKkJiymm5rMfvPpED/IW
	9dv8+Ovw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFi3m-0004YP-Ke; Fri, 26 Feb 2021 18:41:54 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFi3k-0004Y4-BW
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 18:41:53 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11QIMurn026958
 for <linux-nvme@lists.infradead.org>; Fri, 26 Feb 2021 13:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=XwO82RKwnynsb8JqnpHEJe/ohO/9hB0Wn1IrwSOiNW0=;
 b=coflz29G1jXF2d3v8o9PdK/o2pRmoOt+0xwjsXIyQQHgnpV0Y75SIC5khnhl77bOeXqy
 8c8R/U6t2vxRtHb23h7m0zCeSrJfPIwuIPvyNJljJJVMdH0vEoYw0JygIPSjBXo/9YX7
 R60yWxepli22pXtmaxU7MBMBW5EEAlV+mnL3YncVfP3hM5WwvZC3Kn1aAoIHzgURiBpI
 PEo/QEpDI3PrFIYRMcZYcof5jBPgmKjPKvyZrHwDGTQgmDWWloe6O9Gy/rrgYxSa2Cbh
 byEwkdrBS/2qMS8g8uW+BW/mUFgq+7cvQ0Jc352S8HbbH5y4wa2DYDD16VfCEFwDONrv vA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 36tyyv6e1k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Fri, 26 Feb 2021 13:41:50 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11QIfMpV141933
 for <linux-nvme@lists.infradead.org>; Fri, 26 Feb 2021 13:41:49 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0a-00154901.pphosted.com with ESMTP id 36xb6y7cn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Fri, 26 Feb 2021 13:41:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UChbJlqOkOWJnLLwMKQKgSOKCrSmjOZYmimwOhb6FGXbG1X98UGm1Gwp3nTfrSnj7oYBtPYHTkZOTt7j3RI/+Vse6s85a+1ry6Pl3aM7CcMwkeGGUBy21NS5EcgL50tmmgVCTk7fLqGHTMcRmbnwLKkuzSV1HLSYm0Ada8dcrc6eA/0KOq9dLNx1kSnSEsvDSwNZSRmX9V80H+suTJcqUwaPG5JiAvggse7qaqT2YWzbdGn0lCxYgLXLpJLNTnxETK4okxjXWkkPm0cZSTiYHQUxPSFL/A103pr8VTIlk530CNcqVKo5ApSf29eVTZRAtBraD4uJcDctwnv3m7q0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwO82RKwnynsb8JqnpHEJe/ohO/9hB0Wn1IrwSOiNW0=;
 b=kOZKm860S7veWuIW3dO0xTN3SN78qJ1FSzK1m0huY8sgmcjCamKyrbzXrv6cfFZj7wOQOSzTD8+zEKy6Fh7HAVtvqpmKZBJu1ybhs5uPxH4Cw9+PkcGEnbhx1q0YSTbeQvBKow5UOPph1m3F21B4mpvanIXDpndMsx4lkrk8x1YLD9UqkB3Q0YJoQIaIzWG6RNd9nCsGuurg7hjDHP3U8KVV/z/IxBwaVDTnrX+84zl38XRB+z8hdfoF9K3AQSL5u2v4EbzRanNUB2yn1ooInmPQMD3LBywbY6NfKP1NebLkyY9m68eCDwzN9Pc6/4MNYiZWqrg7aL9aPF5vzWC7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BYAPR19MB2552.namprd19.prod.outlook.com (2603:10b6:a03:13c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 26 Feb
 2021 18:41:46 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2903:29b8:91ce:57c4]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2903:29b8:91ce:57c4%8]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 18:41:45 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme-discover: Computer freezes up when persistent device loses
 connection to controller
Thread-Topic: nvme-discover: Computer freezes up when persistent device loses
 connection to controller
Thread-Index: AQHXDG110OvEJ+VPRkuYgXzCViT0Gg==
Date: Fri, 26 Feb 2021 18:41:45 +0000
Message-ID: <SJ0PR19MB45442613CD5D226582EB6DBBF29D9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-02-26T18:41:45.312Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cd6ce76-c289-47b7-fd70-08d8da862b46
x-ms-traffictypediagnostic: BYAPR19MB2552:
x-microsoft-antispam-prvs: <BYAPR19MB255280D13A78A00F176C529DF29D9@BYAPR19MB2552.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gONtlrmLl/CtloXySeDmvqdlvS0dhvnCQWoWkFQy7cn3MkO+yXEVx2zVlmAHwkmD4AEyJH3aegIiSy3cYB9cKJ6sG8uVO9DXXpEeGNK436AFdP68omGfuxVeEQVJCgRDytZLmVQ3ThG/shBA/CKk0u1gJb7Sbg1QhCehFWMP3e5BgLWv0yXqiMgh7ccSQ3MZObuON/uwGwb8+U/0KEYDxZMjZULqBrymdChnkECXPRJFS86TifaVAjYc8gBZ7C+fC1uzr+VGphWM338T+yWwzxJWA/Py2qOpd3UEkCxVe7f7NOL3Sr28uVw1TgM3V05evtOpTogtqgWal6/q9EQLUIL8cW4AIaiCSPKVXSbGL43NxP8/jhUaEaK99UOd8+gFrChZcwJ1Q2xd0gbdRm9hjXZKkIguUR5R2XvX1/gygCSuW/PrenT93XFK/kTVGMmberl5wYKBO9dtNzTU/XRH3lZeHSTsdHzydm7S2pUUmrll1O/kobbzgH82jaW9fyhn7srELm7/2WiioFOfT4uuHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(186003)(5660300002)(786003)(6916009)(52536014)(86362001)(8936002)(55016002)(71200400001)(66556008)(66476007)(316002)(478600001)(76116006)(8676002)(64756008)(33656002)(7696005)(66946007)(83380400001)(2906002)(91956017)(9686003)(6506007)(66446008)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QxazcoSbXqhEIi637aAvmjypfmxPHrDsrUhxq9kpBPFa2xdHChjdKor5FM?=
 =?iso-8859-1?Q?ENKn7hxec83QagfWrPBHQ13O32UeIuJGHzTAVThDko/TLhwjngo7BPdmfi?=
 =?iso-8859-1?Q?gyWtmIYIjUwGJQDVx4IgKP2MdHYF7+H9JThmNPgW0YS/mDAJi559KT0A2a?=
 =?iso-8859-1?Q?3lsd+zst6Q0LHX8w8NSpmoNjQKLnk1jQnaXYYx/iC7HZvRoYhyxnqFFj8/?=
 =?iso-8859-1?Q?AsPnl4Et+WfK6z1x6jWjPLyzxc5hY0H7+A/33S27ybCyH4r7SIEPO/W1Eb?=
 =?iso-8859-1?Q?Q8XHs9q2etOK/810XvP+FfKKp7JpDHHKS6aNsJ+hdhcIsHoz5nAyRrYQXD?=
 =?iso-8859-1?Q?Yird7zfPZdwtD5+Z5+1trKOBerTypMNsZIDIDVj2RhtUChsGy8ZrMsd8mN?=
 =?iso-8859-1?Q?bv1h71zGNpv2BU+j2N4qLn8228DxoUVTjLVHaPAjL2QeKbGzQjJWxm3Cq0?=
 =?iso-8859-1?Q?1cESG2id2KJQYSK8gri9Z7iI83NQVvIsgb3CF5D2fMjY8TUQV12n1Q2/68?=
 =?iso-8859-1?Q?UprarOPqEwQkooKcg4Ln+S9pWheuw5UcZ4hHTLvU63kHOh/VqcXN/4TeDH?=
 =?iso-8859-1?Q?iWY2fpTdqMh57CNwab3VLd7ly4ivIlbyfRooNrwU20+8AJax6jNVvUCoJc?=
 =?iso-8859-1?Q?yYps66qYnHvhOOHPw+I/zegtiOoROdXIDRyx5kSp8HOXGzljEgHaamyv9I?=
 =?iso-8859-1?Q?nZAHkGODxf0U9KZq5B95kxlG8m/Dl4zge8NdoetQGRI48juH/3SToEc67p?=
 =?iso-8859-1?Q?dtNsXSeGOV5hOuEKF0Mv0ewBK4SRVqB/iHdFTbQxEIUy1spLS/CnJnWrqo?=
 =?iso-8859-1?Q?KzsygJ56yRuHwDOZgUCJNGtEDooXifqxNAU4uOExXgiHfcnAf83l/b8+jJ?=
 =?iso-8859-1?Q?T4Qro7mrXreDoaEQ1OXhQtc3Qt4+xw76awY8BFpH4Mzup2ruhLpLhO2FEN?=
 =?iso-8859-1?Q?iEO4uByqgG8/EeNC3F/f5uosnZoOea5y2VT3wgOyCysX7VElccuHzIUZGP?=
 =?iso-8859-1?Q?vMHplL+aNOSmj0Lv/iaD6i+17QUrq+dwca6RZNUMcR2yeYR1M2ABsAtA43?=
 =?iso-8859-1?Q?ko9tRuzIfglpNpGJaiuGeojsdA2SKspi5FCBRq4E2T12qQFv7x/tpJ9CfF?=
 =?iso-8859-1?Q?t+lre41ZwdkxuwyABJifQLpHLJwMBytgkSJQCUsI3tpLNvdb1aPWvuv6++?=
 =?iso-8859-1?Q?FJYbBVEO1NjL2nA5wOAf03NAmPGiBC2HkH5UbxHALMk68L8eSeCejBiaER?=
 =?iso-8859-1?Q?l69rKFFKGm3dSIuWihP002Ir6xH6r0ph18QCT9hrG1bwfjmuBp3z8wRf91?=
 =?iso-8859-1?Q?38Iopo08MhhFn5kCgBkvfCW2jV+keOYAgH4dDEigEJ9sGgL/6haj0aZjr2?=
 =?iso-8859-1?Q?0Y9NR7Q9FX?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd6ce76-c289-47b7-fd70-08d8da862b46
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2021 18:41:45.8514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pqKUffbRAl1Was0l9ytOWobF1GzYCin97vZfM1fPMydiFQPTAgToJ051Lq9E4cxFOrk8G1McMtBCAeIwXxGNeIbEiIoG/rKOLWCL+EepHM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2552
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-02-26_07:2021-02-26,
 2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=969 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260137
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_134152_502283_2AAF8525 
X-CRM114-Status: GOOD (  14.09  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I was experimenting with persistent tcp connections using nvme-discover/nvm=
e-tcp and nvmet-tcp and caused my computer to freeze up.

The steps are as follows (detailed commands below):
1) Configure nvmet to listen for tcp connection at 127.0.0.1:8009 and confi=
gure 2 storage subsystems.
2) Use nvme-discover to set a permanent tcp connection to=A0127.0.0.1:8009=
=A0
3) Confirm that a persistent device was created (/dev/nvme1)
4) Confirm that we can retrieve log pages from persistent nvme1
5) Remove all nvmet configuration.
6) Confirm that the persistent device /dev/nvme1 is still there.=A0
7) Try to retrieve log pages from persistent device nvme1=A0
8) Computer freezes

Detailed operations:
=A0
1) Configure nvmet to listen for tcp connection at 127.0.0.1:8009 and coonf=
igure 2 storage subsystems
# modprobe null_blk nr_devices=3D2
# modprobe nvmet-tcp
=A0
# mkdir=A0 =A0 =A0 =A0/sys/kernel/config/nvmet/subsystems/storage1
# echo -n 1 > /sys/kernel/config/nvmet/subsystems/storage1/attr_allow_any_h=
ost
=A0
# mkdir=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/sys/kernel/config/nvmet/subsyste=
ms/storage1/namespaces/1
# echo -n /dev/nullb0 > /sys/kernel/config/nvmet/subsystems/storage1/namesp=
aces/1/device_path"
# echo -n 1=A0 =A0 =A0 =A0 =A0 =A0> /sys/kernel/config/nvmet/subsystems/sto=
rage1/namespaces/1/enable
=A0
# mkdir=A0 =A0 =A0 =A0/sys/kernel/config/nvmet/subsystems/storage2
# echo -n 1 > /sys/kernel/config/nvmet/subsystems/storage2/attr_allow_any_h=
ost
=A0
# mkdir=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/sys/kernel/config/nvmet/subsyste=
ms/storage2/namespaces/1
# echo -n /dev/nullb0 > /sys/kernel/config/nvmet/subsystems/storage2/namesp=
aces/1/device_path"
# echo -n 1=A0 =A0 =A0 =A0 =A0 =A0> /sys/kernel/config/nvmet/subsystems/sto=
rage2/namespaces/1/enable
=A0
# mkdir /sys/kernel/config/nvmet/ports/1
# echo -n 127.0.0.1 > /sys/kernel/config/nvmet/ports/1/addr_traddr
# echo -n tcp =A0 =A0 =A0 > /sys/kernel/config/nvmet/ports/1/addr_trtype
# echo -n 8009 =A0 =A0 =A0> /sys/kernel/config/nvmet/ports/1/addr_trsvcid
# echo -n ipv4 =A0 =A0 =A0> /sys/kernel/config/nvmet/ports/1/addr_adrfam
=A0
# cd /sys/kernel/config/nvmet/ports/1/subsystems
# ln -s ../../../subsystems/storage1 storage1
# ln -s ../../../subsystems/storage2 storage2
=A0
2)=A0Use nvme-cli to set a permanent tcp connection to 127.0.0.1:8009 =

$ sudo nvme discover -g -G -o json -t tcp -a 127.0.0.1 -s 8009 --persistent
{
=A0 "device" : "nvme1",
=A0 "genctr" : 4,
=A0 "records" : [
=A0 =A0 {
=A0 =A0 =A0 "trtype" : "tcp",
=A0 =A0 =A0 "adrfam" : "ipv4",
=A0 =A0 =A0 "subtype" : "nvme subsystem",
=A0 =A0 =A0 "treq" : "not specified, sq flow control disable supported",
=A0 =A0 =A0 "portid" : 1,
=A0 =A0 =A0 "trsvcid" : "8009",
=A0 =A0 =A0 "subnqn" : "storage1",
=A0 =A0 =A0 "traddr" : "127.0.0.1",
=A0 =A0 =A0 "sectype" : "none"
=A0 =A0 },
=A0 =A0 {
=A0 =A0 =A0 "trtype" : "tcp",
=A0 =A0 =A0 "adrfam" : "ipv4",
=A0 =A0 =A0 "subtype" : "nvme subsystem",
=A0 =A0 =A0 "treq" : "not specified, sq flow control disable supported",
=A0 =A0 =A0 "portid" : 1,
=A0 =A0 =A0 "trsvcid" : "8009",
=A0 =A0 =A0 "subnqn" : "storage2",
=A0 =A0 =A0 "traddr" : "127.0.0.1",
=A0 =A0 =A0 "sectype" : "none"
=A0 =A0 }
=A0 ]
}
=A0
3) Confirm that a new device was created (/dev/nvme1)
$ ls -l /dev/nvme*
crw------- 1 root root 240, =A00 Feb 26 11:09 /dev/nvme0
brw-rw---- 1 root disk 259, =A00 Feb 26 11:09 /dev/nvme0n1
brw-rw---- 1 root disk 259, =A01 Feb 26 11:09 /dev/nvme0n1p1
brw-rw---- 1 root disk 259, =A02 Feb 26 11:09 /dev/nvme0n1p2
brw-rw---- 1 root disk 259, =A03 Feb 26 11:09 /dev/nvme0n1p3
brw-rw---- 1 root disk 259, =A04 Feb 26 11:09 /dev/nvme0n1p4
brw-rw---- 1 root disk 259, =A05 Feb 26 11:09 /dev/nvme0n1p5
crw------- 1 root root 240, =A01 Feb 26 11:16=A0/dev/nvme1
crw------- 1 root root =A010, 33 Feb 26 11:11 /dev/nvme-fabrics
=A0
4) Confirm that we can retrieve log pages from persistent /dev/nvme1
$ sudo nvme discover -d=A0nvme1=A0-o json
{
=A0 "device" : "nvme1",
=A0 "genctr" : 4,
=A0 "records" : [
=A0 =A0 {
=A0 =A0 =A0 "trtype" : "tcp",
=A0 =A0 =A0 "adrfam" : "ipv4",
=A0 =A0 =A0 "subtype" : "nvme subsystem",
=A0 =A0 =A0 "treq" : "not specified, sq flow control disable supported",
=A0 =A0 =A0 "portid" : 1,
=A0 =A0 =A0 "trsvcid" : "8009",
=A0 =A0 =A0 "subnqn" : "storage1",
=A0 =A0 =A0 "traddr" : "127.0.0.1",
=A0 =A0 =A0 "sectype" : "none"
=A0 =A0 },
=A0 =A0 {
=A0 =A0 =A0 "trtype" : "tcp",
=A0 =A0 =A0 "adrfam" : "ipv4",
=A0 =A0 =A0 "subtype" : "nvme subsystem",
=A0 =A0 =A0 "treq" : "not specified, sq flow control disable supported",
=A0 =A0 =A0 "portid" : 1,
=A0 =A0 =A0 "trsvcid" : "8009",
=A0 =A0 =A0 "subnqn" : "storage2",
=A0 =A0 =A0 "traddr" : "127.0.0.1",
=A0 =A0 =A0 "sectype" : "none"
=A0 =A0 }
=A0 ]
}
=A0
5)=A0Remove all nvmet configuration
# rm -f /sys/kernel/config/nvmet/ports/1/subsystems/storage1
# rm -f /sys/kernel/config/nvmet/ports/1/subsystems/storage2
# rmdir /sys/kernel/config/nvmet/ports/1
# rmdir /sys/kernel/config/nvmet/subsystems/storage1/namespaces/1
# rmdir /sys/kernel/config/nvmet/subsystems/storage2/namespaces/1
# rmdir /sys/kernel/config/nvmet/subsystems/storage1
# rmdir /sys/kernel/config/nvmet/subsystems/storage2
=A0
6) Confirm that the persistent device /dev/nvme1 is still there=A0
$ ls -l /dev/nvme*
crw------- 1 root root 240, =A00 Feb 26 11:09 /dev/nvme0
brw-rw---- 1 root disk 259, =A00 Feb 26 11:09 /dev/nvme0n1
brw-rw---- 1 root disk 259, =A01 Feb 26 11:09 /dev/nvme0n1p1
brw-rw---- 1 root disk 259, =A02 Feb 26 11:09 /dev/nvme0n1p2
brw-rw---- 1 root disk 259, =A03 Feb 26 11:09 /dev/nvme0n1p3
brw-rw---- 1 root disk 259, =A04 Feb 26 11:09 /dev/nvme0n1p4
brw-rw---- 1 root disk 259, =A05 Feb 26 11:09 /dev/nvme0n1p5
crw------- 1 root root 240, =A01 Feb 26 11:32 /dev/nvme1=A0 =A0 <- Should t=
his device remain if the connection is lost?
crw------- 1 root root =A010, 33 Feb 26 11:11 /dev/nvme-fabrics
=A0
=A0
7) Try to retrieve log pages from /dev/nvme1
$ sudo nvme discover --device nvme1 -o json
=A0
8) !!!! COMPUTER IS BRICKED !!!!

Regards,

Martin Belanger
Dell Inc.
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
