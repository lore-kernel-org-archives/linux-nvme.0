Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECD6C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:25:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D60056196C
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60056196C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NqvBIHgKGxAOd6vof+a3DOoXU4xuANaH8yNST2fqkNk=; b=bGaSnTS12YXIj+0qUormtQYw7
	GwTP3cVAWRfx7KjcyuEzNLUUVOWopd6j73p1WtSOEg2kRm0qUcGhbpB70RNZzCgvRH/NkD2HcnRiT
	9ytKsx8/Z/PZ/UulmIg35GCtMzk4WZdkC5t4GHfaCNaU9BWhPpr5oM3r/W7i3pvn+U3gP28etRsON
	bVIlvOqaGXpH5y8ZhQAXQD0MaIy9sDYhgNtMVTvcUGEdJUlZVVOhB2t3FVKNbZl1wOA7swX370n+I
	oafKUI6ciEH9Mlfz3L5/YLrYwY5Svph7sphaMij4drVkEfCkfqJDpRLn/HguwhO2QE0lBYG/gvhOe
	7jJK4r38Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRI7N-004RQ5-D6; Tue, 30 Mar 2021 17:25:29 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRI7J-004RPG-HP
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 17:25:27 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12UHMHS6026852; Tue, 30 Mar 2021 13:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=w7281M9vjpnsVWr7lWuM5xMgOx1EOh9QO5Nzt7HvrLQ=;
 b=WmRGkfpFPTREFiJUysNLFRsB4SMfWOlF4AzNmxjjUraTChI18wNC0YzHQWpvEbZ7b/sx
 Iw+6xIQEo4no/qJqYA0Z5DGW/0f0K9LmqQ/gB1TijQ7VTQvYT/EWx3gMXvQidItXZgzp
 sH9WATasBV3c6d9KDw5zlO3aghM/Euw6roUkGH6uv6iLTVdcFFVwwNTwIXsOkZi0ZWtE
 wCZZtTcnOX3R+oUzvHMZlh8QaEJk8NAT+FcfG7KIqmW2nCtEYr7ihF1iPa0qHXnXjTL3
 XucdgRcG8AshaMbIitrd5/gs65WthhlxU6i7E+BhRZmpCjW3iJ225lbW/dURT9cJF55R BQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 37kkj04ebn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Mar 2021 13:25:17 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12UHPGDE115355; Tue, 30 Mar 2021 13:25:16 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-00154901.pphosted.com with ESMTP id 37ky7wa55h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Mar 2021 13:25:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bv+6kQmrXs/fRdCcMTTyKvJU38tH0VfuhzvuMflOJ8eM2jQXEp1koI5PMvewW97iDfUX5wAC+hOrPgH+3Oi0ieDv9YY+lgZYwwuEOBOfV6+SL6vzHsVjFup3psWiEAwWMq3jgDHt/4ZGi0tgYGTUUyxwVDyU4i0EaEP6CEYY9Z7k1Hi5Dj3zTLppwR9VLphln3JNpYzIS8ebbrPbhv1KjHBK9q5UY1DKJ4lVkj+y/6izVege7SYbsuYgi/+7vkafe6rSYY9elPX6piIvGobOQtoCcPEgXpVTCqAcK1YgFb84TXmrb8To1t4AFOk5iwFXRbgwx+YxFgb7Eb52V+u2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7281M9vjpnsVWr7lWuM5xMgOx1EOh9QO5Nzt7HvrLQ=;
 b=DgRkQhS//kSsT1KGBMFqttykZeJbTaXtle9kvFHiBTzp+5jCgtylxorp5kgPN4pv3RnMNTuiOCb9M61KIkNENJlED5x7LvekWrjsuQ5mGajbX3Kfa57hFVT1QGcfbExp44gN/N5SpG1Kguo8lEWq5S22j8lmE/iWfShftaeL+bvjFM6fgYx2rNDneGp7sFa92pYBgYlAaVDJMSJQmd5lQNOjDeKZwMOSgYg0FimA3iGaCnCYF0iyXeZzvowqGo1X2akrw5GuG03w9oDmbmDmrlCzfys3kzWAKFxOBlvb3YI27giGL7oRgO+54tQzcDM2hclXtyE6j7JmG7nOcdF12g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DS7PR19MB4549.namprd19.prod.outlook.com (2603:10b6:5:2ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 30 Mar
 2021 17:25:10 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 17:25:10 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH v3] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v3] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXJMWPs/aSwM83jUKn/O3vcQenKaqb7DWAgAAa9oCAAMJsIA==
Date: Tue, 30 Mar 2021 17:25:10 +0000
Message-ID: <DM6PR19MB40114B267039D0A71B68658DEF7D9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210330041219.3069-1-houpu.main@gmail.com>
 <20210330054849.5596-1-houpu.main@gmail.com>
In-Reply-To: <20210330054849.5596-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-30T17:25:08.3350546Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=245ae987-4eea-41b1-b9a2-d61b946892a1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a9fec32-4a3d-4259-6e17-08d8f3a0c538
x-ms-traffictypediagnostic: DS7PR19MB4549:
x-microsoft-antispam-prvs: <DS7PR19MB454995D1F728DC576177AAD2EF7D9@DS7PR19MB4549.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/USQMrsE8NfGuzDEdM3umIvSjsrwqnwAF2wsB8G05PvelmhEDI0IzV08aGVXBoNFtev/y4YWyML0qjLcS+mixm4jafdeOZ0vO2JJDFP9+xeZAagtD14TY+u9QmOH9kbxVMYEGDeG2YGeO2yy1kiWWIfQC4ggXmtR4ed5C8X4t6taOo47KqtV4PYsNu6O0OH1On2O80fVtq4nCGiwTXOUdOheJz+2DcZjvSEy6FKJsz9l9D0+O/gaYU5+uPij+7IwFLAR/bI7SJALX7PJD81+QyVHNslvtQRX8DmXtk2fwbQVssDAo04Hv8gZzF76KaSAQIGp9txuZojYfHZ5iYYMXdBKSEiiCSkgC2/JwF9f4ocNuxRMg8iTU0wKdxY34I+GexE35IDK0yonfOkGr1azfPLrLvxE/KxZB8+whTE9vMonmMAg123VckDYlxHniM6zsQ1jUbA/bOg+aPlBcVaIhDjfFj6TiFqr4tlN4L+DXBt9+IA4Tppoca85E1aT91f4M0jrlLpXiB5PzyzZD0+F9LrRBaphPzBLPhoKPLbE0YyC75Mx5LB20BRKG5+8zYL5nkaozhxxV7zfzYJtnEVioT3Y1GwufJBvElm0UAw6Gbysmz48S9JOWti/V6MFTMOOR1maXu4Iwp0Bo62fWLbKuBomoVcW4FB+JPDpj+ooE0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(9686003)(55016002)(66476007)(66946007)(26005)(66446008)(64756008)(66556008)(86362001)(76116006)(8676002)(2906002)(8936002)(186003)(4326008)(786003)(316002)(6916009)(54906003)(478600001)(52536014)(53546011)(6506007)(38100700001)(5660300002)(7696005)(33656002)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?TWdNaktzMFY4T2ZXL1cwUmI4OXh6TGY0K2dOZ1pmZGNkUjZiMmZ1NFZHeG8z?=
 =?utf-8?B?cE5MQVFnV2N3S0wvNndISTFDQW5nWU8vTWJGWlFRSGpraTZWT2pmWGh4dUpD?=
 =?utf-8?B?Sll1T1NCZldyVUJPc1ZQTHdJNk9xV0tGc1lPck9obDFOa3ZVSzZac2dPWXRC?=
 =?utf-8?B?bWlPRWtYcGNaWkg3a1VwMmMvV2ovUWxoQTl0alJubXFQREgra1FSSHc1U0Ey?=
 =?utf-8?B?M1BENGwyTTRZdlQ5Z3VweVllZWZ1U1lneFhkMGk0U3hVcW9UR1BJMENLVXVq?=
 =?utf-8?B?c2cvdThXVnNMcW9BTDRaWTNnMWNrSUlEQUdNT05jRXNSSm1zVDI5OTBGNnE0?=
 =?utf-8?B?dVBFMDJtdE9aSmhDOEZFZ09KSTNoejM5QmU5aUFqbDgwVWprT3kvTXBFbDdH?=
 =?utf-8?B?WDFnOHZ3dDNmUjA3aCt2NFFSMS9DWEhWOE5mUWY2TlFnejJydnJWaDR6ZmZy?=
 =?utf-8?B?NlhINzQ5K01XZk1lZmVUb09ja0xOY0gyTk1EYTBDYVQ5UldUN2ViOTgvU3F1?=
 =?utf-8?B?WmFuTGI0dmF4bW1PVWdYMmF4aTJmUko4NzltWDg0TmR1Um9DY3pESUJmY0FS?=
 =?utf-8?B?MTJBR1U4RzVkYVF5NTVUZXB4KzFSbzBDa3ZCK29oTUF1RHJ2a1h5Y2FJTHZj?=
 =?utf-8?B?Z3VVTkVyKzNhNWhFSStORGdSWDVtd0x1cC9MRmt2aFdWeGcwd2ZwRWYyT2NI?=
 =?utf-8?B?Yzd6WTl2RElpWVl1RElzRjhCdThZeFdLSGpFSW9lM3dVTHFnSVNTb3p3Y2Vh?=
 =?utf-8?B?R2ZSaWt1UXFVVWZIZDNqREhtNDJUNFhiSjMwcVhEdnRiZHVQamhvVlNHTnVs?=
 =?utf-8?B?WUtqN255RDlkWTNEVHpaeEdNUStkRFZWeEVtdUZERThEWVoyUk8rY3J5KzRX?=
 =?utf-8?B?ay9ZUU5NNy8xZDE0ckkzQjhHK2dQazFycjJXVjkwZVFXVTZzb2ZIRUg0Nm54?=
 =?utf-8?B?RnFJVlE1WjhFZmZjbm9CVGk4bjgyWkVybGtEd1pld2FTcFBNOExOK1hYRGp5?=
 =?utf-8?B?aG5KaVVDN3dqYzRMZm5XT0lGWUpiVXdLTkg1MWlib2tQQkxOenlxalcyMTlC?=
 =?utf-8?B?WlpkanljdXRuQTdHME5Lb3k0eG50cklLMmsyU0dPMmVKZlRzdStiNUg0UW4r?=
 =?utf-8?B?b0ZTUUpCVldnc21TVklmZXNqNGlSTUdHZ3lSWFZqK0Z0Z3cxUEJwSkt2Zksy?=
 =?utf-8?B?dXRhUzlVTjVtYnRPalFxWTFiWG1ncE80SzB1YlVQMUxSSWgzL0RHS1NBQmp1?=
 =?utf-8?B?TDVJR2FaZk84YWYxWmhrTEhTaE1YdkpqcVJXVFJZMXhRY2xFblNGMzhhakZm?=
 =?utf-8?B?QXdCc1dOY3RNYlpDQnB1RC9SZTAwdnVpc0xmUnJ1ZzY5OHNWa21KaFBkSnN5?=
 =?utf-8?B?TVJlTmYxZ0VPc1A4dTl6MWpWVVpSMWpLdk9YVFk5clUrd1Ntcno0eUorWXNS?=
 =?utf-8?B?MkM4ZHJXTW9zOXc5WWJDejI2NU14NGJHdkNORWhnWnRabzdHSXhZR0M5OUJD?=
 =?utf-8?B?Q0orMitwbVpuSExrZjY3Ukd5eU10dmxTV1I3ME1hSStPNU5waHYwcWliR0x6?=
 =?utf-8?B?aCtXRDR1bWZRVFgzOVBjeXJPVkZvRzhjWG5kdldoY25ZcGpaeGlLNWE5cGFZ?=
 =?utf-8?B?Z2VMK1k0NVdEWUs1UEE1T0h0NTFLNGgzdFhTUGFNZFhEUGhwSG5kbEo2L3JB?=
 =?utf-8?B?WWtVSm0rV3NrRzd5dTVsSWV2ZFl4NlRVOHk1ZWY4Q21vejNWd3ZjN2E2bEg3?=
 =?utf-8?Q?Ec2uKfOZWJVTboLDH5SjHQ2iwVYVcf6dydHF3QI?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9fec32-4a3d-4259-6e17-08d8f3a0c538
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 17:25:10.1374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8If5CG027TDEx1idGwlQvln4DDKvXAGSNCaWUr6qhzRfcIUKMH0c3SYsbuq+1Ot/k3sjZeWG0hlVUoDeTMGdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4549
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-30_08:2021-03-30,
 2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300126
X-Proofpoint-GUID: AckC0kgeADM0tOtF-XF70CLA3BTNnXbK
X-Proofpoint-ORIG-GUID: AckC0kgeADM0tOtF-XF70CLA3BTNnXbK
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_182526_199716_5B1B6A3A 
X-CRM114-Status: GOOD (  27.99  )
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

Right. There is a race in patch v3.

Thanks

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Tuesday, 30 March 2021 8:49
To: houpu.main@gmail.com
Cc: Grupi, Elad; linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: Re: [PATCH v3] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

On Tue, 30 Mar 2021 12:12:19 +0800, Hou Pu wrote:
> On Date: Mon, 29 Mar 2021 21:01:25 +0300, Elad Grupi wrote:
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> > index 70cc507d1565..41102fc09595 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -525,11 +525,34 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
> >  	struct nvmet_tcp_cmd *cmd =
> >  		container_of(req, struct nvmet_tcp_cmd, req);
> >  	struct nvmet_tcp_queue	*queue = cmd->queue;
> > +	struct nvme_sgl_desc *sgl;
> > +	u32 len;
> > +
> > +	if (unlikely(cmd == queue->cmd)) {
> > +		sgl = &cmd->req.cmd->common.dptr.sgl;
> > +		len = le32_to_cpu(sgl->length);
> > +
> > +		/*
> > +		 * Wait for inline data before processing the response.
> > +		 * Avoid using helpers, this might happen before
> > +		 * nvmet_req_init is completed.
> > +		 */
> > +		if (len && cmd->rcv_state == NVMET_TCP_RECV_PDU)
> > +			return;
>
> Is it queue->rcv_state ?
> I tried this patch, the identify command could get here. And nvme connect could hang.
> We need to figure out a way to tell if it needs abort queue the 
> request. Or maybe we could use the v2 version.

Adding nvme_is_write() would solve the problem.
Also as we skip queue queue->io_work, we should return
0 instead -EAGAIN like below to consume the inline data in nvmet_tcp_try_recv_one(). Or the io_work might not have a chance to run.

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c index a10a3bd59..f3d117771 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -537,7 +537,8 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
                 * Avoid using helpers, this might happen before
                 * nvmet_req_init is completed.
                 */
-               if (len && cmd->rcv_state == NVMET_TCP_RECV_PDU)
+               if (len && queue->rcv_state == NVMET_TCP_RECV_PDU &&
+                   nvme_is_write(cmd->req.cmd))
                        return;
        }

@@ -984,7 +985,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
                        le32_to_cpu(req->cmd->common.dptr.sgl.length));

                nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-               return -EAGAIN;
+               return 0;
        }

        ret = nvmet_tcp_map_data(queue->cmd);


Thanks,
Hou
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
