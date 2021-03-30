Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B44C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:26:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 497BE619C0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497BE619C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1t1UBkHe84yEpeTVQrtAPhyX2jEaDs6rWjRSDHcHrCo=; b=a6WX5A2JSVEHFrpQv87UJPQhn
	Ji2+mjUjiMWFTFjL2kEE9yd1xlPoc2A7XUf0X052N2KSk0EX14k1RZvhFEcKDsani5MiBLElluBa1
	DZzMXuTYLE90i6JztU0E3zSbeJDZebjHx8dGKWrS7fFxYijAYjx1ma3/xTVQSaahr1Evr3xsiBavX
	BtEGqWkaqjbjtxxx+guZrbHGXLt3y5GGVgpx3BNSEP7FxtOIz6WZ5I14f6zxtE7m+xDFiq/LYIt0O
	+56jPPsCOU0Hlg8wYk4d6NIqgYDKeRayI6e59JkxL1hpD47KhS9iknLUdrj54UGO9Pdrj0OaD3X65
	jEg1GtIsw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRI8C-004RXN-C5; Tue, 30 Mar 2021 17:26:20 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRI84-004RVS-5n
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 17:26:15 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12UHMxZc026263; Tue, 30 Mar 2021 13:26:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=yocObInCcOTHbLqkPl110GAEJNj84hOIcJ5aqIb7YKk=;
 b=IUs3/cGaKdlxfmoazvQTmd+nd7S7jgwoqYobQDOLEFSQgil/r4oZ/8HiWb/i8Fv1nLlz
 SdjY2k9cOVrbRHdR324ybiwFkA42eSvgbabomWMZzHMb6M/jDycQlqPkpoALblRtenMP
 8ZH/oRoaXksvJZKOFonBlRUHvEV808INpTyZvhtb7KuORuTY89bMKFJKx3oqHJzDDm3X
 4PNau00eyQMuRCzUGhXbGwIXANgaTq0Gjduf3MGQ2J/BUXVSfoyf6RnwYkb7rbMizMUc
 jKq3ZGtXBS5z++d2F+XMa2tuzssYnWw8C2vFFU88xf4KYt42PInGDJbDHO+FKPp0bd9k TQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37kseduaym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Mar 2021 13:26:07 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12UHPMb6080092; Tue, 30 Mar 2021 13:26:07 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-00154901.pphosted.com with ESMTP id 37jhkqvu2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Mar 2021 13:26:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCYLiOrbWdujNPt5tj2uaFDoCpR+opCdUBCtpjqORFVsC66DGxu6B0MQ45wfIcK7a4UEo57hPegbBDSndrVtyfXyDzuHeWFPKMDWe/tS8NK3Os1AU/G097xqxRrdki2H1F9WoQJMixhihE4tTFPzYcOIzSCT1lgbNLsoFI2RFgH7RED5VQizgrbjCWhGLr6+jBLw80aEM0lyWw3rJr4uqIrYjUO0KfJBPZVjZ5PqwL+PN9e0sc2W7lrqCsg6i1mmM2RNi6rWPqfrr7N6x/d3loZpZO0BHH9xvKn7/3n5pjYBvJxeyAboJ2gEFNflW/S4ihPUd70qHuSWsahdFDheiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yocObInCcOTHbLqkPl110GAEJNj84hOIcJ5aqIb7YKk=;
 b=fPfNs2kuuwUtmWHUbchKMJQzYnmy57uJ4JevPPyMlmXDRXCsfkPYacR06k+j9CX0eWVNbR4/CD+P+2kuO9ABYSPk+FKlj9r0QIxmcMO6wabP7B1dnNrxS8fWc5pudnRfxSg7RTjDzerH0k03Vr5evehnRcZ9epl7OJp3kb3I1RFrNx2cjw1ie86rKsB4dt6i3YVQAUdE+7YUAbGckarKcsImiLRo8XJWoUlcCwtPT+plJUdYnqpSoDp1esh+C1PomHgMj8eV4AXISgyqYNJq0N511hpFH+rUWiNCmvg0HbUl8+/tHK2MsokyOFtXjDNo3bxFG75iTFxQEOd+vhaZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DS7PR19MB4549.namprd19.prod.outlook.com (2603:10b6:5:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 30 Mar
 2021 17:26:05 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 17:26:05 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXImnP12JJHSExREmbK5ZJuH7cCaqYyhCAgAANpSCAAzrIgIAAu/ew
Date: Tue, 30 Mar 2021 17:26:05 +0000
Message-ID: <DM6PR19MB4011C9FA8DA1604B4FC4EBD7EF7D9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210326175941.22734-1-elad.grupi@dell.com>
 <20210328040427.20895-1-houpu.main@gmail.com>
 <BY5PR19MB400413D837B52BA22628A888EF7F9@BY5PR19MB4004.namprd19.prod.outlook.com>
 <ef4c8620-a2aa-2fdc-3ae1-0e34e62ad78c@gmail.com>
In-Reply-To: <ef4c8620-a2aa-2fdc-3ae1-0e34e62ad78c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-30T17:26:03.5772844Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=64531a79-df24-46cc-9e48-05d345801ef1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c466ea74-bdaf-46db-7660-08d8f3a0e636
x-ms-traffictypediagnostic: DS7PR19MB4549:
x-microsoft-antispam-prvs: <DS7PR19MB45499CAB90CA9136BFC7F4B9EF7D9@DS7PR19MB4549.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIsmwVHem45PXSuh+vIhXdXgcJB1b2bSd0TU92YbkszIVFO9dvTUXRzfcu2+1aPXFd2Ws5ta0H4/7FIGSyRyKHL5XriTDno8EcNXv5gQsZ/2Cc9eFpj1TxigKYfJxUlh2rOQt2dqCKkGj12w98ZgUjsp/rEfbXpPg/d8I7kFfvXVCT0ZhoKSdZwgKtcVBQoX0+/kjlVEjeKv1UmymrC01vmswHBfHpq6HW/xxWsyE2tO+X309YKf4sSGCQwsph6jUMiM6ExmbFdyDOogTA5Os7l03C965Ac/X9b3+5Wr3Wbsqi1p3bu8ULonWq2e+P+vWTbNV5Uan4Ytx6wC4z5tguHpTIig5hVREyH+IRZ2ItXhM8KxeIAo1MbtfYXWUZaI61Hid2/jLo81lZZuJYBJC5YMuUWU8Rj1XFtqAE5lCXiZGNy4rz+rF+Sv50Abr3Yq9eKMmTG9e8qx4qeru3K1dGFiCH6mizUD6Wx1oYydCqEXH1e8zvlE+sEovDfYR05ehwwpigTT4wBtjFxelMwv18ofgskyfmSg7d+RUCBIL7d7yLvFB5gc+K2dXOxNLNT3qdqH7CYWryWeRwBGzgkE6n1p+HE0OY3LHS6Jm3oi2jAIK/QKbhxkhs9K1qLb1MGRLapr+hjVSNn7eCr5uFM+pZae9zNVQ0SBmMGYuVsOEVE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(9686003)(55016002)(66476007)(66946007)(26005)(66446008)(64756008)(66556008)(86362001)(76116006)(8676002)(2906002)(8936002)(186003)(4326008)(786003)(316002)(6916009)(54906003)(478600001)(52536014)(53546011)(6506007)(38100700001)(5660300002)(7696005)(33656002)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?SWtzS1ZwYkZjNk9PM3FHSFN5cG0rQ0plME1jYWdraVVaWWd2YmJZN1VsaGVp?=
 =?utf-8?B?V0FQUlNrZGhaRFlzMDVVa1lsTjdoWXE0NEZyWFRmWEVYMHNJdEg4aGZ1MVdX?=
 =?utf-8?B?YWFwdWQrUjYzaGVEWTNJdlIzMUZKQ0FPZ3BWa2FOM3FIUThLYjhyTDFvaFcx?=
 =?utf-8?B?cldzcFUyWjErbUxJUUZmM3ZIREdkOFAwRlZxYktEaThrV0JKUVlzdHhEN2Iy?=
 =?utf-8?B?bTk2bTZjMmpSTEoyZkxCMnkrTTFjcklYbFVqRzhwWlcrVVo0UlJqVnUxTThs?=
 =?utf-8?B?SjBvSERhZkpSc2Z0ZVNBalVMaVV2ZENEd2QxSFhxZ0JOQkNtbVVseUNOM0dU?=
 =?utf-8?B?eEdCSlFrcEFmOVZiSW5yV2tXKysxaWJPSEFsczBtb0J2b0t4MXhIVG03Uysv?=
 =?utf-8?B?T3JVdFRsUXZRMFgzcjM3WGxOTlAyK0YxM1RHNFczTVBYYlhzWWlvdkdwT01t?=
 =?utf-8?B?eVpPSno4Qm1hUDVDMzhibXFuK1pyYXJxenVIdUZ0dDNJMlNBbWhZVWtRSGpj?=
 =?utf-8?B?bmFJUVpMa0hObS9IbkN6UmNlTFBKY0hTUDRyRm1YWXZoMHUwbllza0UrTmtX?=
 =?utf-8?B?ZVRVNkxvNzBQYU43ZDlNbS9NeDdBTGJOd2ZyQjUvVDJBRTRjQitIbERhUGV3?=
 =?utf-8?B?Z3ZEMThBR2RLS2hCbVJmd29mQ1o1ZXpqUU5LL0ZXL3M2NzVwNWhtMzRNQU9N?=
 =?utf-8?B?RVNvbzEyUjZIOHc4RUlSV0VtMXJkSWpSdlpqM1JVRTJyR0c0QXQwaXdGdDlT?=
 =?utf-8?B?dDlPcnVuTVRrbzJZSmFmajE1VXZPSGs1cGdZdWN2ZUZQUGtnOVRKUmR1UllL?=
 =?utf-8?B?STFBbGdpZ2Y2clBNd1llZGVoYUIxK0tqQmZGd1ZJK29DWlNyZWdaWnN3NjJx?=
 =?utf-8?B?WS9IL2VUR25TOU9wTzNmYXFLdGhxRHVHVE42S2tQSklwNjczWTltWkhtUzFU?=
 =?utf-8?B?aVUvZWNMRW1KT3g1N1RmRmpIMHFnZkVOekJqOEU5aC81VjZRK2tqMm91M2Jn?=
 =?utf-8?B?ZDJqZHBtZ0F2dmlqR0taZWFmaUhBWFQydTRWV2VHQWN5bDRZNUJWbG00T0Fj?=
 =?utf-8?B?RzBISWt5S3pnLzZrdmlmUFVUbnZnNzRlY2psL3ZxamVwYnZVcldxWVJPanlU?=
 =?utf-8?B?eGtKOEVicEVTRGd6T2VYcmNOZXFvNS9LSDAreVhBNktRMS8xa3hFbWE1eGRI?=
 =?utf-8?B?Tmg1eEFkRHNQeDVIdEhrQWgyRm0rK3BtekdrblZ2YVVVVlVUdUpRY3JTRkw1?=
 =?utf-8?B?UnczUG9ZRW82UkFnQXFSMVMrVTRvRGFSTFhZaFhxR0JBSlIyTDQ2MzZjWHBq?=
 =?utf-8?B?dVJ3Mm5JMFMyalVSblMwNFBhMGhkVithZkpMeDFQNUM1VUVITHRVb1pDQTJT?=
 =?utf-8?B?ZFIyb04yM1hLSlFESzhBWGdKd296YVJuVnB2V1RqR2pJdFVzdGd2K0EzM0NI?=
 =?utf-8?B?Q09EK0prTE5IbENQckxySmVJdFc1R3RtcGhzT3A0SDNUMHF4alFRMWZiSXFo?=
 =?utf-8?B?SlFkUG5wODNMb0lEd0lkU0JhVzNOYUFyQ29sMnFFek9qWndQRy9wSjdZL2tk?=
 =?utf-8?B?cHRPdnlsWmJOdHZDVHNmVENiV1I0T09VSGxXMysvYU81UFZNRnNWV1M1RU9v?=
 =?utf-8?B?K3pJZk5MbEgrRHpZcFdTdTNRTG5HOXJTRkVoWSt2Y0ovRCtmM1k1WGRIUUNa?=
 =?utf-8?B?aDZnVTZyWjIzM0dyRkszRTlUdEVuN0w1blljWHRYb2MySlo5Q2lmaHpIUTkw?=
 =?utf-8?Q?IZvgs2CjL5qSOi1VW3ii84h/bjjXO/rzR3PVwuu?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c466ea74-bdaf-46db-7660-08d8f3a0e636
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 17:26:05.4734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBahD3AJJz02vgAkpEkLSOVdEtn3l9+kRjbncqI+VzwYb61MSQ08VSwTJ+c1bjAsgGEP0xVy7Vlo2ppQz+9jTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4549
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-30_08:2021-03-30,
 2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300126
X-Proofpoint-ORIG-GUID: _FaRX_n242uoUe4rXp8cY3a1xzG4yhiq
X-Proofpoint-GUID: _FaRX_n242uoUe4rXp8cY3a1xzG4yhiq
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_182612_594809_C4367CA8 
X-CRM114-Status: GOOD (  39.20  )
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

I sent an update to patch v2 which includes the -EAGAIN fix and another fix to prevent queueing the request twice.

Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Tuesday, 30 March 2021 9:12
To: Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: Re: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 


On 2021/3/28 1:13 PM, Grupi, Elad wrote:
> Hi Hou
>
> Even with the code below we will still queue the failed REQ for the first time.
>
> Please mind the code in nvmet_tcp_done_recv_pdu:
> 1. nvmet_req_init will call __nvmet_req_complete with an error status 
> 1.1. __nvmet_req_complete will call nvmet_tcp_queue_response 2. 
> nvmet_tcp_handle_req_failure will set the flag NVMET_TCP_F_INIT_FAILED
>
> In step 1.1, the failed REQ will be added to the queue anyway because the flag wasn't set yet.
>
> In the previous patch I was adding the REQ back to the queue on nvmet_tcp_fetch_cmd, so it was useful to prevent queueing the REQ over and over again.
> Now I removed that part from the patch, so it means that the REQ will be added only once.

Thanks for the detailed explanation.

I'm fine with v2 or the new version.


Thanks,

Hou

>
> Elad
>
> -----Original Message-----
> From: Hou Pu <houpu.main@gmail.com>
> Sent: Sunday, 28 March 2021 7:04
> To: Grupi, Elad
> Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; 
> houpu.main@gmail.com
> Subject: RE: [PATCH v2] nvmet-tcp: fix a segmentation fault during io 
> parsing error
>
>
> [EXTERNAL EMAIL]
>
> On Date: Fri, 26 Mar 2021 20:59:41 +0300, Elad Grupi wrote:
>> In case there is an io that contains inline data and it goes to 
>> parsing error flow, command response will free command and iov before 
>> clearing the data on the socket buffer.
>> This will delay the command response until receive flow is completed.
>>
>> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
>> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
>> ---
>>   drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++------
>>   1 file changed, 23 insertions(+), 6 deletions(-)
> Hi Elad,
> Just noticed that we still queue the failed REQ to the response queue in this version. Am I missing something?
>
> Is this still needed? (I think it is).
> @@ -526,6 +527,12 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>   		container_of(req, struct nvmet_tcp_cmd, req);
>   	struct nvmet_tcp_queue	*queue = cmd->queue;
>   
> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			nvmet_tcp_has_inline_data(cmd))) {
> +		/* fail the cmd when we finish processing the inline data */
> +		return;
> +	}
> +
>
>
> Thanks,
> Hou
>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
>> index 70cc507d1565..3bc0caa47873 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>>   			return 0;
>>   	}
>>
>> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>> +			nvmet_tcp_has_data_in(cmd) &&
>> +			nvmet_tcp_has_inline_data(cmd))) {
>> +		/*
>> +		 * wait for inline data before processing the response
>> +		 * so the iov will not be freed
>> +		 */
>> +		queue->snd_cmd = NULL;
>> +		goto done_send;
>> +	}
>> +
>>   	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>>   		ret = nvmet_try_send_data_pdu(cmd);
>>   		if (ret <= 0)
>> @@ -1103,9 +1114,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>>   		return 0;
>>   	}
>>
>> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>> -	    cmd->rbytes_done == cmd->req.transfer_len) {
>> -		cmd->req.execute(&cmd->req);
>> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
>> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
>> +			nvmet_tcp_queue_response(&cmd->req);
>> +		else
>> +			cmd->req.execute(&cmd->req);
>>   	}
>>
>>   	nvmet_prepare_receive_pdu(queue);
>> @@ -1143,9 +1156,13 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
>>   		goto out;
>>   	}
>>
>> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
>> -	    cmd->rbytes_done == cmd->req.transfer_len)
>> -		cmd->req.execute(&cmd->req);
>> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
>> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
>> +			nvmet_tcp_queue_response(&cmd->req);
>> +		else
>> +			cmd->req.execute(&cmd->req);
>> +	}
>> +
>>   	ret = 0;
>>   out:
>>   	nvmet_prepare_receive_pdu(queue);
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
