Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81424C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 15:21:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B9123A7B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 15:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B9123A7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JEA2N5VTbUWPM4p7rNL/CHXWYNdnjS5ZtiYqSjZuYtY=; b=Yr/gXX79z1be6ysHYXT+t04Vu
	WSq+LjH8GUv8xFkhgXkrg81UROkB7CLyqNnsvMUx4ZxzCTK7MF1YVlaUlVDghRldscqi1qjlQYYVM
	/wH2iriIEUh1Hy3kk0gl8CtO8iXHRmERYqw5JPBcJqCM9/oPGxx2Gbc5OffaJP4lWMOq2covr10bt
	mwYsQvu+63I50FOFtQJsnKJF4jb9QC9d6nwCsHfFPFKmSodV4o3zk6J5b2G14FimdBhcqe/1IICgq
	eiLUtO/Jqj5c6PR2HDhmNYBahRC6c3fR8HeL4dThUIeCyq0vUrn6T3m6tsr+lPNhKyNEe3miH0uab
	pSADzR0bQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kment-0004Eo-HT; Tue, 08 Dec 2020 15:21:25 +0000
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com
 ([40.107.244.67] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmenq-0004Ca-SZ
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 15:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZV+lFhsPLNJgDhsVyrplOO9gujYlMF/W+ZJ1XAy9zlk9o3MEdOUxmF8vJQFmyOFvd22qn61PIK3Qsc2+aVPat0BSeqD9dXlk9QUbPPtAWY+JYNwS/cwRefZhm9cBd4JG7rkFm69gx58fU+WwJbl/jzP7Zriuv8AKjuri5e+2FF1QYc7gEuJv/FnoJIoq2TpL7D0rukC5HN6MECerCnKNc6aS/onU0m26HUU6BZckq7d29ETM+xrSi58FHL6YXRcdzVy7BUWE4wxFigWxueJnAQHefLo+kEjrM3EOxDCiG22mp75dllKEg4e99mQIHzheQNdmvOhujspZ+NkgU1rgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6hgE17cUfBXmRyluIm2qF1ouDbgy1WtpzS7KzMph1g=;
 b=OU5wVJWd9I7BhHjoYwrkbNMjRkboy1TmNLy4jKeQeKPCDFKuFcZ5Ooc0zNAqCa8S79IKSTJJbeqkAaLRdks3LJyboUW4YjIfuOriF16fSUSnhH4e26MU0GRVU7E6KiQ9eLPwVWT1yU4cCjJrfVL/J9+HARnaHTg25e6MYXtetXP7L5N9fC5TzaxtcFqAMufjHc7XeEWdfR1kgEC6ncsZ5vrPzMptsGXUehUw3DQlq8rnL43DstHbdtjPVjOtIQyFzANGd50gUzTD+872GPOOFxkiKcDSfLgxvsuSJhevGTCnfySXhkP/BfE3FOtHQWJEa3Wu8BXl1OKywF71WJFQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6hgE17cUfBXmRyluIm2qF1ouDbgy1WtpzS7KzMph1g=;
 b=vn8OqwNaEPxbWo/TQEzbwqQN4O0QrC73pL4WldIrnLN38DBWFnfedbRl6GYRAZWKjFjizszQqKvCWP+exjPwFiuAe/UEzokdzLynevRPWIsZ6QkX79UhaNuwCVHZnPur/j2fNC4DETl85Au/MYEE6sbk8GcRKneCtBahtKzBVZgVi9Cl2To78V5d/3fVA/tEdtIxubAiQTpueuB8QR13wsEw0oKc37ekeTajhkCgMr2SEqOzd1rAcmJpRfFRk3ttcCoLWSsPUyTmKhvbd+u8xmH+ygC2HVUgSz2+4eSSbmkJqHrq/Grd8xiDF5B4ZH8cABTiVkBCjVaYUM73skyEKg==
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com (2603:10b6:4:7f::28)
 by DM5PR0601MB3621.namprd06.prod.outlook.com (2603:10b6:4:7d::37)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Tue, 8 Dec
 2020 15:21:16 +0000
Received: from DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610]) by DM5PR0601MB3624.namprd06.prod.outlook.com
 ([fe80::7512:336:92f6:8610%4]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 15:21:16 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQgBYJ9gCAAAOmgA==
Date: Tue, 8 Dec 2020 15:21:16 +0000
Message-ID: <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
In-Reply-To: <20201207152532.GA4527@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2601:186:0:56d0:5cd3:ab9b:a8f1:b122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8db18411-8edb-421f-b6d3-08d89b8ce85f
x-ms-traffictypediagnostic: DM5PR0601MB3621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR0601MB36217A83F9E1DA5BB31FFBEBF1CD0@DM5PR0601MB3621.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWqcuNHO64nw/cBaVYz+0Y87BpJPihA+fwzYpryScnnpZ71vNEjTNRij/vngMHjx0vEA8cFba4qbdPR6eofdvGQwdhf3xJRUw1ejFWLuL7155TF1Vr8B2GNe0Pm1iLEU0O6B/sqipWy0LAWOkD804N6LFQ8jo1UIEE/n3OImDkYlTQ+hx9AIux5TY00FwIY2BbiBRY1BZU7n+LucT5lpgDRmoDNrWqxFKz6jbwIR3u5TTFSmg4DaWBbmNXWTsOsoLMAgCE0PCBrYy5SbNUzOHw8IZnrzzgV/ToN5rqaF+wNOd8kKkf/A2ma2jJxP1Yg4hpgjGpgvadJ5zf6NaXIuIg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR0601MB3624.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(6506007)(33656002)(53546011)(71200400001)(4326008)(83380400001)(2906002)(86362001)(7696005)(54906003)(8676002)(64756008)(66476007)(66946007)(66446008)(66556008)(76116006)(508600001)(5660300002)(9686003)(55016002)(8936002)(186003)(52536014)(15650500001)(6916009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?d05mNzJ5MU5rbXFWUEtHc09sTWVocEdQa3dKcjBoRHFjRkcyNTNhdDd5K3Mw?=
 =?utf-8?B?NWhJdzNVdGZZdTl0eVFJQnhlOVpmeWpyUmN0YlR4VEk1N2ZPemQ2L3NHYkJt?=
 =?utf-8?B?NmhjemZZWEdHVzlzazRUTHVWbTlzSCtuYkRxU2wrcjJTeGVoZ042V09CdWQ4?=
 =?utf-8?B?My8yQ1VzT0pJck5WWWZ0SWpyRTlXaUZWdFZzc1NSRkRDNVpWK1FhT0pvZTh5?=
 =?utf-8?B?SzVCR3d0REtvMnRYaGpWRXB5RXRsT2N3cWJTS1QwUzgvN0RvbVQyTjN6aUNv?=
 =?utf-8?B?ck9vMTNGT05PVTlPaW1zUVNkQ0dqR2FocWhJcWpTRVlTOG8rZEpwOVBpbjZ4?=
 =?utf-8?B?OStOV1k3U2k5aEhrZFQ5MnJjOUxPU0wvNzlKdE9qMEt4UFlVdDJMMHEyU21Y?=
 =?utf-8?B?bUpldWlhVkFIRTRtWlBsQ0lUL2VlMnh0T2gzU1JwTmZNY092QXJERzIyb0Yx?=
 =?utf-8?B?djhYNUE5RGVGUEVuYmI1NE92OXYzOTdKTjNEbkxuMVlmSmdOWFU0UzdVNVdU?=
 =?utf-8?B?WHluMnA3WXpwQ3lScFNEUGhJVUZUY2ZOVzRZZGJ6VjNMSzRvSFRGSDU2cmNh?=
 =?utf-8?B?b3RBcnQ5MVp4UERTdmhTZ2lkQXNLWUUrbDBtbTBQaUhWY283aXJqdUp0Q2xh?=
 =?utf-8?B?blJSOUUwckYvM2tvbEJnbWpKNUQrd0E3L3N1dSt0dFZ5K1RZSUszZUlmM3dq?=
 =?utf-8?B?K1grR3hjRzdwZ2tJREFUR2lUSnBIVWFFL2xiekZIdEtNZkdXUG1zeXVWaUtm?=
 =?utf-8?B?Z3NQVzBUcmc1bTN1elRsZWdEb1RTSGJNYXlxQnA3ZkorelJDdGx5dzFFRHpO?=
 =?utf-8?B?MzZjN3ZIQzloY2tRdmdDWm9IbCtlcVlTalVHYlhFeFd2RjNKTVJxVHdkRHVM?=
 =?utf-8?B?R2doVGFiV3ovT1l2QTROcEtVNmlOaVZLeEppYlpuTW9PcE5IMjVKbzJiY1pu?=
 =?utf-8?B?OHZhNGgvcmROd3U1L2FBbFcyZmVicUlVOXZqWDA5WFk1Z05kRHNEZktlNHcw?=
 =?utf-8?B?Zm5wV1JkS1VNdi9lbVpZeXRycXE5eWhaRjNTc0tiTzh1bVB2MGtta0Y5TW4z?=
 =?utf-8?B?NkF5R0VVL0JHUUpVMWx1RWwwekxoN2tQTDJtZFRBckJOOUZvNjd3VFdhQ3hG?=
 =?utf-8?B?T3FqZFBWbjUzNlIxM2RBUnRJY1lraUx0K3QxWUd0WXdDb2xXR2htTDVXcUVa?=
 =?utf-8?B?SExHbnJodWMyRWZ1c2dSZTlNcXI0MTVEemErMUNCOFZGVjdPVjlZU3kvd2Fh?=
 =?utf-8?B?ek9TeTA0alFqbEpOTis4TlJ2cWxocU9ncm5qNE9DOG04S2IzeURYendyWS9K?=
 =?utf-8?B?RDlpcEVWWnB2RVZWUjZpMTlaV0RiWmh1b0NBYmRPRFN0aFdxRVBWWVJZYTVQ?=
 =?utf-8?Q?RDqaqpHDg4a3Llv2i91Eo6j4LBHX+14E=3D?=
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0601MB3624.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db18411-8edb-421f-b6d3-08d89b8ce85f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 15:21:16.7859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: We1TXClNMbriSSx1ERqABfxlaKqcM8F/8wGmN8gcW7MJkbxXpwaQ40ux9X3woto8vCgdR5cKf4CYpIx60OfK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3621
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_102123_191125_EE0ED2A3 
X-CRM114-Status: GOOD (  22.79  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SXQgaXMgY2xlYXIgdGhhdCB0aGUgTlMgYXR0cmlidXRlIGNoYW5nZSBpcyByZXF1aXJlZDoNCk5h
bWVzcGFjZSBBdHRyaWJ1dGUgQ2hhbmdlZDogSW5kaWNhdGVzIGEgY2hhbmdlIHRvIG9uZSBvciBi
b3RoIG9mIHRoZSBmb2xsb3dpbmc6DQrigKIJLi4uIDsgb3INCuKAogl0aGUgTmFtZXNwYWNlIExp
c3QgcmV0dXJuZWQgd2hlbiB0aGUgSWRlbnRpZnkgY29tbWFuZCBpcyBpc3N1ZWQgd2l0aCB0aGUg
Q05TIGZpZWxkIHNldCB0byAwMmguDQoNCkl0IHNlZW1zIGNsZWFyIHRvIG1lIHRoYXQgdGhlIEFO
QSBjaGFuZ2UgSVMgcHJvaGliaXRlZDoNCkFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2VzcyBDaGFu
Z2U6IFRoZSBBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgaW5mb3JtYXRpb24gKHJlZmVyIHRv
IHNlY3Rpb24gNS4xNC4xLjEyKSByZWxhdGVkIHRvIGFuIEFOQSBHcm91cCB0aGF0IGNvbnRhaW5z
IG5hbWVzcGFjZXMgYXR0YWNoZWQgdG8gdGhpcyBjb250cm9sbGVyIGhhcyBjaGFuZ2VkIChlLmcu
LCBhbiBBTkEgc3RhdGUgaGFzIGNoYW5nZWQsIGFuIEFOQUdSUElEIGhhcyBjaGFuZ2VkKS4gVGhl
IGN1cnJlbnQgQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIGluZm9ybWF0aW9uIGZvciBhdHRh
Y2hlZCBuYW1lc3BhY2VzIGlzIGluZGljYXRlZCBpbiB0aGUgQXN5bW1ldHJpYyBOYW1lc3BhY2Ug
QWNjZXNzIGxvZyBwYWdlIChyZWZlciB0byBzZWN0aW9uIDUuMTQuMS4xMikuDQoNCldlIENBTk5P
VCBkZWxpdmVyIHRoaXMgQUVOIHVubGVzcyBpdCBpcyByZWxhdGVkIHRvIGFuIEFOQSBncm91cCB0
aGF0IGNvbnRhaW5zIG5hbWVzcGFjZXMgYXR0YWNoZWQgdG8gdGhpcyBjb250cm9sbGVyLiAgVGhl
IGNyZWF0aW5nIG9mIGEgbmV3IEFOQSBncm91cCAod2hpY2ggdGhlcmVmb3JlIGhhcyBubyBuYW1l
c3BhY2VzKSBkb2VzIG5vdCBtZWV0IHRoZSBjcml0ZXJpYSBvZiAiY29udGFpbmluZyBuYW1lc3Bh
Y2VzIGF0dGFjaGVkIHRvIHRoaXMgY29udHJvbGxlciIuICBTbyB0aGVyZSBhcmUgMiBwb3NzaWJs
ZSBvcmRlcnMgLSAxKSB0aGUgQU5BIGdyb3VwIGlzIGNyZWF0ZWQgYmVmb3JlIHRoZSBuYW1lc3Bh
Y2UsIG9yIDIpIHRoZSBuYW1lc3BhY2UgaXMgY3JlYXRlZCBiZWZvcmUgdGhlIG5hbWVzcGFjZS4g
IElmIHRoZSBHcm91cCBpcyBjcmVhdGVkIGJlZm9yZSB0aGUgbmFtZXNwYWNlLCB0aGVuIHRoZXJl
IGFyZSBOTyBhdHRhY2hlZCBuYW1lc3BhY2VzIGluIHRoYXQgKGJyYW5kIG5ldykgQU5BIGdyb3Vw
LCB0aGVyZWZvcmUsIHdlIGFyZSBwcm9oaWJpdGVkIGZyb20gc2VuZGluZyB0aGUgQUVOLiAgSWYg
dGhlIG5hbWVzcGFjZSBpcyBjcmVhdGVkIGJlZm9yZSB0aGUgQU5BIGdyb3VwLCB0aGVuIHdlIGhp
dCB0aGUgbmV4dCBsYW5ndWFnZSwgdGhhdCBwcm9oaWJpdHMgc2VuZGluZyB0aGUgQU5BIGNoYW5n
ZWQgQUVOIGJlY2F1c2UgaXMgaXQgImR1ZSB0byB0aGUgY3JlYXRpb24gb2YgYSBuYW1lc3BhY2Ui
Lg0KDQpXZSBhcmUgYWxzbyBwcm9oaWJpdGVkIGZyb20gc2VuZGluZyB0aGlzIEFFTiBieSB0aGUg
Zm9sbG93aW5nIGxhbmd1YWdlOg0KQSBjb250cm9sbGVyIHNoYWxsIG5vdCBzZW5kIHRoaXMgZXZl
bnQgaWY6DQphKQl0aGUgY2hhbmdlIGlzIGR1ZSB0byB0aGUgY3JlYXRpb24gb2YgYSBuYW1lc3Bh
Y2UgKHJlZmVyIHRvIHNlY3Rpb24gNS4yMCk7IG9yDQpiKQl0aGUgY2hhbmdlIGlzIGR1ZSB0byB0
aGUgZGVsZXRpb24gb2YgYSBuYW1lc3BhY2UgKHJlZmVyIHRvIHNlY3Rpb24gNS4yMCksDQphcyB0
aGUgTmFtZXNwYWNlIEF0dHJpYnV0ZSBDaGFuZ2VkIGV2ZW50IGlzIHNlbnQgZm9yIHRoZXNlIGNo
YW5nZXMuDQoNClRoZXJlZm9yZSwgaWYgdGhlIGNoYW5nZSAiaXMgZHVlIHRvIHRoZSBjcmVhdGlu
ZyBvZiBhIG5hbWVzcGFjZSIgKGFzIGluIHNlbmRpbmcgYSBOUyBNYW5hZ2VtZW50IGNvbW1hbmQg
dG8gY3JlYXRlIGEgbmV3IE5TLCBvciBvdGhlciBhZG1pbmlzdHJhdGl2ZSBhY3Rpb24pLCB0aGVu
IHRoZSBBTkEgQ2hhbmdlIEFFTiBzaGFsbCBub3QgYmUgc2VudC4NCg0KU28sIHRoZXJlIGFyZSBU
V08gcHJvaGliaXRpb25zLCBhbmQgWkVSTyByZXF1aXJlbWVudHMgZm9yIHNlbmRpbmcgYW4gQU5B
IENoYW5nZWQgQUVOIGZvciB0aGlzIHNpdHVhdGlvbi4gIFBsZWFzZSBzaG93IG1lIHRoZSB0ZXh0
IHRoYXQgcmVxdWlyZXMgYW4gQU5BIENoYW5nZWQgQUVOIGZvciB0aGlzIHNpdHVhdGlvbi4gIEkg
anVzdCBjYW4ndCBmaW5kIGl0LiAgWW91J3JlIHdlbGNvbWUgdG8gYnJpbmcgYSBuZXcgVFBBUiB0
byBhZGQgdGhhdCByZXF1aXJlbWVudCwgYnV0IGZyb20gbXkgcmVhZGluZywgaXQgaXMgYSBuZXcg
cmVxdWlyZW1lbnQuDQoNCglGcmVkIEtuaWdodA0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBoY2hAbHN0LmRlIDxoY2hAbHN0LmRlPiANClNlbnQ6IE1vbmRheSwgRGVjZW1i
ZXIgNywgMjAyMCAxMDoyNiBBTQ0KVG86IEtuaWdodCwgRnJlZGVyaWNrIDxGcmVkZXJpY2suS25p
Z2h0QG5ldGFwcC5jb20+DQpDYzogTWVuZWdoaW5pLCBKb2huIDxKb2huLk1lbmVnaGluaUBuZXRh
cHAuY29tPjsgaGNoQGxzdC5kZTsgR2VvcmdlLCBNYXJ0aW4gPE1hcnRpbi5HZW9yZ2VAbmV0YXBw
LmNvbT47IGtidXNjaEBrZXJuZWwub3JnOyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7
IHNhZ2lAZ3JpbWJlcmcubWU7IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmNvbT4NClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIG52bWUtY29yZTogdXBkYXRlIE5TIEF0dHIgQ2hhbmdlZCBBRU4gaGFu
ZGxpbmcgZm9yIEFOQSBncm91cA0KDQpOZXRBcHAgU2VjdXJpdHkgV0FSTklORzogVGhpcyBpcyBh
biBleHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMg
dW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBz
YWZlLg0KDQoNCg0KDQpHZXR0aW5nIGJhY2sgdG8gdGhpcyB3aGlsZSBJJ20gcmV2aWV3aW5nIHRo
ZSBsYXRlc3QgY29tcGV0aW5nIHBhdGNoZXMuDQoNCk9uIE1vbiwgTm92IDIzLCAyMDIwIGF0IDAz
OjI3OjM1UE0gKzAwMDAsIEtuaWdodCwgRnJlZGVyaWNrIHdyb3RlOg0KPiBIZXJlIGlzIHdoYXQg
SSB3b3VsZCBleHBlY3QgdG86DQo+IEEpIGNyZWF0ZSBhIG5hbWVzcGFjZSBpbiBleGlzdGluZyBB
TkEgZ3JvdXA6DQo+ICAgICAgIDEpIE5TIEF0dHJpYnV0ZSBDaGFuZ2VkIEFFTiAoYmVjYXVzZSB0
aGUgTlMgTGlzdCByZXR1cm5lZCBoYXMgY2hhbmdlZCkNCj4gICAgICAgMikgSG9zdCBnZXRzIHRo
ZSBsaXN0IC0gZGlzY292ZXJzIHRoZSBORVcgTlMNCj4gICAgICAgICAgICAgICBJbmNsdWRpbmc6
IERldGVybWluZSB3aGljaCBBTkFHUlBJRCB0aGF0IE5TIGJlbG9uZ3MgdG8gKGZvciB3aGljaCB0
aGUgaG9zdCBhbHJlYWR5IGtub3dzIHRoZSBzdGF0ZSkuDQoNClllcy4NCg0KPg0KPiBCKSBjcmVh
dGUgYSBuYW1lc3BhY2UgaW4gYSBORVcgQU5BIGdyb3VwDQo+ICAgICAgIDEpIE5TIEF0dHJpYnV0
ZSBDaGFuZ2VkIEFFTiAoYmVjYXVzZSB0aGUgTlMgTGlzdCByZXR1cm5lZCBoYXMgY2hhbmdlZCkN
Cj4gICAgICAgMikgSG9zdCBnZXRzIHRoZSBsaXN0IC0gZGlzY292ZXJzIHRoZSBuZXcgTlMNCj4g
ICAgICAgICAgICAgICBJbmNsdWRpbmc6IERldGVybWluZSB0aGVyZSBpcyBhIEJSQU5EIE5FVyBB
TkFHUlBJRCB0aGF0IHRoZSBob3N0IGtub3dzIE5PVEhJTkcgYWJvdXQuDQo+ICAgICAgICAgICAg
ICAgU2luY2UgdGhlIGhvc3Qga25vd3MgTk9USElORyBhYm91dCB0aGF0IEFOQUdSUElELCBpdCBz
ZWVtcyB0aGUgaG9zdCBzaG91bGQgZ28gbG9vay4NCg0KSSBzdHJvbmdseSBkaXNhZ3JlZS4NCg0K
PiBJdCBzZWVtcyB0aGF0IHRoZSBleGlzdGluZyB0ZXh0IHNheXMgdGhlcmUgaXMgTk8gQU5BIEFF
TiBmb3IgYSAibmV3IiBuYW1lc3BhY2UuICBKb2huIHF1b3RlZCB0aGUgdGV4dDoNCj4NCj4gQSBj
b250cm9sbGVyIHNoYWxsIG5vdCBzZW5kIHRoaXMgZXZlbnQgaWY6DQo+IGEpICAgIHRoZSBjaGFu
Z2UgaXMgZHVlIHRvIHRoZSBjcmVhdGlvbiBvZiBhIG5hbWVzcGFjZSAocmVmZXIgdG8gc2VjdGlv
biA1LjIwKTsgb3INCj4gYikgICAgdGhlIGNoYW5nZSBpcyBkdWUgdG8gdGhlIGRlbGV0aW9uIG9m
IGEgbmFtZXNwYWNlIChyZWZlciB0byBzZWN0aW9uIDUuMjApLA0KPiBhcyB0aGUgTmFtZXNwYWNl
IEF0dHJpYnV0ZSBDaGFuZ2VkIGV2ZW50IGlzIHNlbnQgZm9yIHRoZXNlIGNoYW5nZXMuDQoNCkV4
YWN0bHkhICBCdXQgb25seSBpZiB0aGUgY2hhbmdlIGlzIGR1ZSB0aGUgY3JlYXRpb24gb3IgZGVs
ZXRpb24gb2YgYSBuYW1lc3BhY2VzLiAgTm90ZSB0aGUgY3JlYXRpb24gb2YgYm90aCBhIG5hbWVz
cGFjZSBhbmQgYSBBTkEgZ3JvdXAgYXQgdGhlIHNhbWUgdGltZS4gIEluIGZhY3QgSSBkb24ndCBz
ZWUgYW55dGhpbmcgaW4gTlZNZSB3aGljaCB3b3VsZCBhbGxvdyBmb3IgdGhpcyBjb21wb3VuZCBv
cGVyYXRpb25zLiAgWW91IGFsd2F5cyBuZWVkIHRvIGNyZWF0ZSBhbiBBTkEgZ3JvdXAgZmlyc3Qs
IGFuZCBjYW4gdGhlbiBjcmVhdGUgYSBuYW1lc3BhY2UgdXNpbmcgaXQsIGFuZCB5b3UgbmVlZCB0
byBzZW5kIHRoZSBBc3ltbWV0cmljIE5hbWVzcGFjZSBBY2Nlc3MgQ2hhbmdlIEFFTiB0aGF0IGEg
bmV3IEFOQSBncm91cCBoYXMgYmVlbiBjcmVhdGVkLCBhbmQgdGhlbiBhIE5hbWVzcGFjZSBBdHRy
aWJ1dGUgQ2hhbmdlZCBvbmUuDQoNCg0KPiBDaHJpc3RvcGggY2xhaW1zIHRoYXQgdGhlIEFOQSBB
RU4gc2hvdWxkIGJlIHNlbmQgYmVmb3JlIHRoZSBOUyBBdHRyaWJ1dGUgQ2hhbmdlZCBBRU4uICBB
bmQsIHRoYXQgY291bGQgYmUgdHJ1ZSBmb3IgYW4gQU5BR1JQSUQgdGhhdCBjaGFuZ2VkIChhbHRo
b3VnaCwgSSBkb24ndCBzZWUgdGV4dCBkZXNjcmliaW5nIGFueSBwcmVjZWRlbmNlIG9yIG9yZGVy
IHJlcXVpcmVtZW50cyBmb3IgZGVsaXZlcnkgb2YgQUVOcyksIGJ1dCB0aGUgTlMgY3JlYXRpb24g
Y2FzZSBpcyBleHBsaWNpdGx5IGV4Y2x1ZGVkLiAgRldJVyDigJMgQ2hyaXN0b3BoIHdhcyBvbmUg
b2YgdGhlIHBlb3BsZSB0aGF0IHJlcXVlc3RlZCB0aGlzIGV4Y2x1c2lvbiB0byBwcmV2ZW50IHNw
YW1pbmcgdGhlIGhvc3Qgd2l0aCBtdWx0aXBsZSBBRU5zIGZvciB0aGUgc2FtZSBldmVudCAoYSBO
UyBjcmVhdGUpLg0KDQpZZXMsIGFuZCB0aGUgZXhjbHVzaW9uIGFzIGl0IGV4aXN0cyBpbiB0aGUg
c3BlYyBtYWtlcyBwZXJmZWN0IHNlbnNlIC0gdGhlIGhvc3QgZG9lcyBub3QgbmVlZCB0d28gQUVO
IHRvIG5vdGlmeSB0aGF0IGEgbmFtZXNwYWNlIGhhcyBiZWVuIGNyZWF0ZWQgYW5kIGFzIHBhcnQg
b2YgdGhlIGNyZWF0aW9uIHdhcyBhZGRlZCB0byBhbiBBRU4gZ3JvdXAuICBCdXQgdGhlIGhvc3Qg
ZG9lcyBuZWVkIGFuIEFFTiB3aGVuIGEgbmV3IGdyb3VwIGhhcyBiZWVuIGNyZWF0ZWQsIHBlcmlv
ZC4gIFRoZXJlIGFsc28gaXMgbm8gbGFuZ3VhZ2UgdGhhdCBhbGxvd3Mgc2tpcHBpbmcgdGhhdC4N
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
