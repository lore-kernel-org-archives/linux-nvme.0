Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511ECC43461
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 07:00:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1DE7206A1
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 07:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fgMmbzT0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="puZHF31X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="Y0Xam0Cx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1DE7206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SfOE40YxwvsWEnhdWD4y7AP1bg8G3v+R0a3dPrehhSA=; b=fgMmbzT0xoJ7o4VGG8uKs/BVC
	geXVq/rSpbyceOWatN5Oawdxv3Vt7RKyoVRUytgVzLpxUlk8D3cJz33ckVQDq6iSXb70Ed2XirhyG
	wvJkrMPCQpnfIbh+4UI3rqsxGhs3rdn+ohNfrXnJHZEmRti0URvtFoT1uth4/+yyiMaCz132NCJ/0
	C9RaNHKDqQ1i0oETIacnyeQjFpqY72NTxqAU10Jg3h2l0BIy5abwMD0DZP7fWHupG0QlAW3rlBabN
	wfFMVuYlMs2c0WlmfJlORGkKIHPwnUhOqPin3tobNOseIYj+ZQ39oOpHo69XBv1SrKqwW8afWhiGV
	7BTgOWfGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI4x2-0005Gh-KG; Tue, 15 Sep 2020 07:00:28 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI4wz-0005EN-ED
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 07:00:26 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08F6po1o011077; Tue, 15 Sep 2020 03:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=4KUBK5Zd7tkUofx8Ncl5ed6UNbmqiqjrWDKH8otzh8I=;
 b=puZHF31XHO+oU8gx7mQ7OSjrHI9t7tt4GCrll5+5t0HQT4iaLneT6qnuNOsVObLONf6C
 Olzs3TwefmCrK5UboZYFUgV1lvFrZTKy8ubRcdsK48Wibmeyf7iPwQ/GrR+BJW3UlSvQ
 x3Qt5gsqxLib9/Y410FCfa3hmObVvoW3ZDPH8aImWkqHDENNJX6xejRZBuT1Q78/7GoS
 38JrZ7L88nysv31kxhSECtiPPxuVSCCfJ5bTh6dOqfs53WNYawrrHCAELufRliABzrzo
 F53iXmvwsPru3VdYH+VbhceHsC4ibnwOff05GFHHlo0SntMWDHrzsU64GdEB5LrZgOJc kQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 33gtbkg5y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2020 03:00:16 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08F6sHGa020984; Tue, 15 Sep 2020 03:00:15 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
 by mx0a-00154901.pphosted.com with ESMTP id 33jr7b0m6y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Sep 2020 03:00:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiRrNsLOnjceQDUCIbKOPdfml60WWWOncb98OO69eLjac6b3HpAJ+E1SrtC7I0ieHiry+HLu3yg64g3yjXAfq4qzGoabVi1PGziym0j0CKIFOBa0WBXkhbmxxdZjGh2WR0+Xf9fe/X17iW6/eiPnGR0EoQgKcjVHc9nruNvFQCiZW2BtApoJVLpLn9b/5Ffyv49UwQu8ziUR78oUjc86OU8e9kzNBA46ITB4YuRqeSj9e8I5qkSZNli/bXw4TZ91gBLSmUR/gnnxh4Q5AMIMtu3jVTZZuVCL48U5XEk09tvIR4V7yUM/GsxZ/fLraP7ZDa9CssO9Z68aLDiodGSlYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KUBK5Zd7tkUofx8Ncl5ed6UNbmqiqjrWDKH8otzh8I=;
 b=d4B/cAWVGJMHNz4BKiRLBrT/iGMt0xagSSTgPyU6XMe5dQfTZ8Z7Q3qQ3FstYKJ9q80z7+ntrootblsgW+k5EHzVBSKiqZSABYHA1GlUY7aUxgtU84F5izL45TWa6bG9jlwvi2fwq7qgUezout0pMwwT4m9CW/OApJUg4vCkmWoGNYuSmEID6FGpzXLLX88fr4p3GZeowuf+S3ztkO/iZZxSy4BDqzn3R8GM/dOm0O2mGqO5cbjFZhab6IKjdhWU259gQy59Qz1I+bfxfvBVtz6Xt/3hntbCZ+BnI10Ityb9Pcxab/78ke7Ue3Lb5bCh9hINDKKKdzZdgptoSUyIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KUBK5Zd7tkUofx8Ncl5ed6UNbmqiqjrWDKH8otzh8I=;
 b=Y0Xam0CxWB4xiajAMw+fkjcqOdlozwSlFGi+B/W/LH4nTld2+Ah86EzJA/LJdSsIjeVkM+DtUY8XoWxJtmq6VMGOpt1NaJM1mTxQtZUF3KppE2w2tdAaUT4vQSAmwaDKG/zV1Y5H6a0bvJA14SBpvM3RIdMXzytl2C8lw8t+P78=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB2991.namprd19.prod.outlook.com (2603:10b6:208:109::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 15 Sep
 2020 07:00:11 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 07:00:11 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: RE: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Topic: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Index: AQHWdSwQNt51xVzDuEiiv7DIlV0weqk+DpiAgABKkQCAAAEugIABJRfwgAAPwACAAAUT8IAnQxEQgAIi6ICAAHKbAIAABFRA
Date: Tue, 15 Sep 2020 07:00:10 +0000
Message-ID: <MN2PR19MB30051A8E477240234C31423DEE200@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
 <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
 <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <17f4ef7f-1a1f-4e0c-5219-117bc752d959@grimberg.me>
 <MN2PR19MB30050F8BE320428D55B32231EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <MN2PR19MB3005D217FD29FC88C64106F5EE220@MN2PR19MB3005.namprd19.prod.outlook.com>
 <4291dca3-618a-c6a6-8374-950f6cbb6af9@grimberg.me>
 <20200915064358.GA19535@lst.de>
In-Reply-To: <20200915064358.GA19535@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-15T07:00:08.5919717Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=6fa1f651-ff79-4ea4-8cbd-6de3759d1c2a;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 106c8194-fad6-47d4-9c4e-08d85944fd08
x-ms-traffictypediagnostic: MN2PR19MB2991:
x-microsoft-antispam-prvs: <MN2PR19MB2991AB8B6F31048A40727363EE200@MN2PR19MB2991.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +EaJi1kItzJStwPvU9V7W+dZMnFQnDgjVPwcopCiY1bjQmSGyAVdXiXOL9cHvVrZNZ/VvWpueQks49U9mCaMdoVlmgV0EznWRC8Ez/tWYIlEZVfETL0KtVXcMez8M5b9NaA1zsJVR3IDXT3nx851HL+7yGK2jeV1tMHaDap4gmroAYgA5lBm7v/P20X3zaVCunHLMXH6BmBeGa/J2gLAirihsDZjDe5zsx7uTls+XPdDTcc9jcGy3uvIIWl2TZDYE/QVPokHgDFGp0MBcx2mspwaIzGqj4jAF9DeOcXKvypppjhSWJb1VggWBSvM9dy5BSWHGP7rcJvZPIIwgQPNkQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(396003)(366004)(136003)(376002)(346002)(39860400002)(66446008)(316002)(55016002)(66476007)(786003)(2906002)(66556008)(186003)(478600001)(64756008)(9686003)(8676002)(110136005)(83380400001)(26005)(86362001)(76116006)(33656002)(66946007)(8936002)(52536014)(71200400001)(53546011)(7696005)(4326008)(6506007)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: bnMBW9nyYEYsmIS34j0z03bF/WSkIfAe86mkMemBQ4BJjNQh/KYPZrF0AuDmbDoARph2v9j0M3mQbu6VCd6pHLYYNO5qhHikuqEH27bNQ4Qj1lsspYypBx0tYCQbuTQ9IO4rRJaJJ4bHgZ+jnZn4d7aZ2OOmDkYxf7qOySEpDyBFHEvedcdYUvJCPBIRwLhT55C2ejbEGde4bL7PLzR6dy28/KaiQN4A7sHyl6o/3GJaKG2LPakXa63S2M0tUNCcQT/nSqg+UoQsnyFOvrxkBeCRKa5hmVZS4jr5wNWO7+xUg+0kglMDwcS+3n7OSCf8igDhORirxpvwjBcjHeTcWjC6zQyrrgIRXXVO/RDZpOmL2M4DFqsyqFrOOicScYLhJhgzQTeOI68eMkPYdbtSGHf6Y1qbTrhy9TyRaDGHnBoJH14JBwQ0yrhI/cMFvS5xZjXwXZoFwc0ubgOxmB3HLD5mM/hBg5YO8J0QTqVlT3RXRGp/tqNwDMDzdxgU3CJNH1KEgTmW3nd9pXSHH56ptPHAITU4qCMNbqPLsu80VijTbNr7YYiK00VZd/SRleqxAcDDXgdgD8Yn3lvk0+WV3af0b/TJcg1mUbe40sZHQPa1RrTM+h04/QLgespCjRXo/QRfYF4LCR9or3aAsGDnBw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106c8194-fad6-47d4-9c4e-08d85944fd08
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 07:00:10.9344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pqEYaXm9qrLsGGbODdjsUMYITKE528b0rEccKzfO9dlxvXR3B0jUvz5wXnIn3QuM9zp9uxadAfZdHFcbaKeDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2991
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-15_04:2020-09-15,
 2020-09-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=843 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=939 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009150062
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200915_030025_780470_6B20856D 
X-CRM114-Status: GOOD (  24.30  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

QWdyZWUuIEkgd2lsbCBzZW5kIGEgcGF0Y2ggc29vbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+IA0KU2VudDogVHVlc2Rh
eSwgU2VwdGVtYmVyIDE1LCAyMDIwIDk6NDQgQU0NClRvOiBTYWdpIEdyaW1iZXJnDQpDYzogRW5n
ZWwsIEFtaXQ7IENocmlzdG9waCBIZWxsd2lnOyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5v
cmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG52bWV0OiBTZXQgY3RybC0+a2F0byB0byBhIGRlZmF1
bHQgTlZNRVRfRElTQ19LQVRPIHZhbHVlDQoNCg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KT24gTW9u
LCBTZXAgMTQsIDIwMjAgYXQgMDQ6NTM6NDdQTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToN
Cj4NCj4+IEhpIFNhZ2ksDQo+PiBTdGlsbCBkZWFsaW5nIHdpdGgga2VlcC1hbGl2ZSB0aW1lb3V0
ICB6ZXJvIHZhbHVlIGFuZCBob3cgaXQgYWZmZWN0cyBvdGhlciBzY2VuYXJpb3M6DQo+PiBXaXRo
IG15IGxhdGVzdCBwYXRjaCwgd2hlbiBrZWVwIGFsaXZlIHRpbWVvdXQgaXMgc2V0IHRvIHplcm8g
dGhlIA0KPj4ga2VlcC1hbGl2ZSB0aW1lciBpcyBkaXNhYmxlZC4gKFVwc3RyZWFtIGNvbW1pdCAN
Cj4+IDBkM2I2YThkMjEzYTMwMzg3YjUxMDRiMmZiMjUzNzZkMTg2MzZmMjMpDQo+PiBCdXQgdGhh
dOKAmXMgb25seSBwYXJ0IG9mIHRoZSBwaWN0dXJlLA0KPj4gV2hhdCBoYXBwZW5zIGlmIGEgdXNl
ciBzdGFydHMgd2l0aCBrYXRvID4gMCBhbmQgbW9kaWZ5aW5nIGl0IGJ5IHNldCBmZWF0dXJlIGEg
d2hpbGUgYWZ0ZXI/DQo+PiBBZnRlciBtb2RpZnlpbmcgdGhlIGthdG8gdG8gMCB3aXRoIGEgc2V0
IGZlYXR1cmVzIHdlIHdpbGwgbmV2ZXIgc3RvcCANCj4+IHRoZSB0aW1lciBJbiBhIHNpbWlsYXIg
d2F5LCB3aGVuIHN0YXJ0aW5nIHdpdGgga2F0byAwIGFuZCB0aGVuIG1vZGlmeSANCj4+IHRvIGth
dG8gPiAwIHdlIHdpbGwgbmV2ZXIgc3RhcnQgdGhlIHRpbWVyDQo+Pg0KPj4gV2UgdGhvdWdodCBh
Ym91dCBzb2x2ZSBpdCBieSBhZGRpbmcgY2hlY2tzIGluIOKAmG52bWV0X3NldF9mZWF0X2thdG/i
gJkgDQo+PiBmb3IgdGhlIGFib3ZlIGNhc2VzIEFuZCBoYW5kbGUgdGhlIGthX3dvcmsgYWNjb3Jk
aW5nbHkgV2hhdCBkbyB5b3UgDQo+PiB0aGluayA/DQo+DQo+IFdlIGNhbiBwcm9iYWJseSBqdXN0
IGNhbmNlbCBhbmQgcmVzdGFydCB0aGUga2VlcCBhbGl2ZSB0aW1lciBpbiB0aGF0IA0KPiBjYXNl
Li4NCg0KWWVzLCB0aGUgU2V0IEZlYXR1cmVzIGhhbmRsZXIgc2hvdWxkOg0KDQogKDEpIGNhbmNl
bCB0aGUgdGltZXINCiAoMikgdXBkYXRlIGl0IHRvIHRoZSBuZXcgdmFsdWUNCiAoMykgc3RhcnQg
dGhlIHRpbWVyIGFnYWluIChudm1ldF9zdGFydF9rZWVwX2FsaXZlX3RpbWVyIHdpbGwgaGFuZGxl
DQogICAgIHRoZSBrYXRvID09IDAgY2FzZSkNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
