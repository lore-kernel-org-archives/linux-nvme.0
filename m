Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E25C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 23:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rsvnqeNsDGoAQviuI/Ld3e9uvJVvWueLN+KoLv23StM=; b=jcSU4VijH/mzpP2HLQ4sZCv+d2
	mhyP5a2giRVUolxKSbkAPKy8HkNgaINGsHotb0DZO4ibbXAAqFFS5jKl4XrhgdtZW+zDE6UXMqh45
	VaJoho2KZIK5Hgn1pT7ewZZLGCIgalnVRZFX7W/idLfnpc32DoAqL8zrNAzhocPPJN0gxj2BQK95H
	owRaFThwpTd6tJq52edbuklIbNguB4sjD7mwtl1K8PWHdFfr4l5k7bdLTwI7zuyVEYGndlZfquEm+
	FgHqLWTwaj2PJ0k8HA5RCJ7NOLcAwzWr4A5WvvVBZPxls5Fk1YEeIw/WxeVl7JJ/mjf7ArHfbckyk
	Rfl5fVqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osuP8-000g1X-6Y; Wed, 09 Nov 2022 23:22:46 +0000
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osuOv-000fvw-FN; Wed, 09 Nov 2022 23:22:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAgIy/Zahd64RFVXJFdVzRZi4Lt8cEAKhHYnkkz7DWM6z5414mCmfZ9Ns3dQ4v27ZBNhi0lqsIDU9iA13CjwhKYJiHLNIWegi2LgyMLQOmOpHOHuc2QI8S3ET8PoY6wngiAedS5roJSoLLbxePSDl0EpxEPM7brIMNiJ37ajaP9gTrB3OEedChYFNTPdijkxRSRzM3OX1jxL2wg1WXuuoCkZP5bjq4/EvYZu0312GrDS3MTDbSZcjn6aOEy5k9fUEdW8BM77JUD3iqJV1iCD+pIxN8/bjxWLsamFFfGxq7S3q7WB48Xn/g6q84opzgYH8ykThww6CPTUuieYy+L+aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsvnqeNsDGoAQviuI/Ld3e9uvJVvWueLN+KoLv23StM=;
 b=cyx7Q8SXZsEMI50BEDlIqXTqWMHj6TMnzJ0f4GgSZe3RCUL6vBQyadLMEe+O5oZJJiGUG1lCKe88y1psXJYSrMEMHodW093OjMCncNTVUMNF/+wuyPMmITOW0P7Fvgh+ZjA7XcrvJxbDnaMrfhWHtHL+uynZW6rWgVvuqirKyhBDElb9UGU0IBA5hNI4Vrk83qoPtUEPOtLIzA5thz6OQuSdcS6ejGJUAyze+QmgkCVAHN5RnhW+pw4QhYtZLCyFD9Lm+TGPI3seSUVR3UE8b5rb/W5y+E80HlOf6xB3VQbVFdR6r9Q1wdGGmcHri2vVd6u/8FlGWhJmHjpR6qOWUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsvnqeNsDGoAQviuI/Ld3e9uvJVvWueLN+KoLv23StM=;
 b=qSKckxFY9Gkl8sYGqEWgPhi2kjHO7iuHaSrRafKclrtIw2FJIdYweSUg593EjybKJNOf/rRmw+4MQK6HnjtuduQMWdVpSjD7peWjfzkzJqxsFlPiCfm+VaiNfxPi/JmJWDhNXPBiNsYSmzC7+Snmwf8B9L2dopUbrqRLARyAJ61wc9uND0kXOBHphU//kUspfVbqh6VC+/JovBoZbCq2KTjZQGSuiSA9B9kJ+cJ1eahocVWTHpdZb+XOKgvoGFCmnyJLpQimXQhcO2UEuQGMAXDvpw3UxtBk3fHPYbHOViuQxPdWnpSd6kGoAjJdGEWZbC/yRplQes7P3BSylZBfXw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 23:22:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.012; Wed, 9 Nov 2022
 23:22:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 02/12] nvme: move OPAL setup from PCIe to core
Thread-Topic: [PATCH 02/12] nvme: move OPAL setup from PCIe to core
Thread-Index: AQHY84M2gnVGPezSekap+6lJ2dcwXK43EQUAgAAsNgA=
Date: Wed, 9 Nov 2022 23:22:27 +0000
Message-ID: <576b8902-0cba-3250-620b-fb5ef21ea6de@nvidia.com>
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-3-hch@lst.de>
 <Y2wRHHdAGHqJA/7Q@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Y2wRHHdAGHqJA/7Q@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5706:EE_
x-ms-office365-filtering-correlation-id: a4322e41-4e71-427c-86bf-08dac2a943f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  41iSo7MdsE3CMh/VJS63Q5ASI0HXn2ClUB06/V+nGiwUX/KEmQe+S80mpHVl9eueLq11t2r1jmOFzmGlz5J0xHUSG/QYYzwFlgeuHHTidzzBOXtzcoiCpshXRWtw/1DZ+sNruW7H2lVV1Rmo0jnHFh1GatD9UE+FcIpgDBDNyC2Yrl8qaKkzpZq4NmOnlOAwvfa8LtSNVNmG0CDzq2MbHyPlKF70mw1LvnoZ1AyemeBtRtXAGKxzNG6Xx8OGrFR/Q7az0thtyja6ANS32bk3D7O4oGp+JXg1hQlAQ+Rz+4siCE3OQiMQ3rLQjsvujtuH0ZINFRpTpjkujyCI6DLJ1YWMJBOv65/hQUszYPm3WlDxbgYiN0Llj68GEgJ9hpzY21SYlSfE/eIJM0kUaYQtStHxrIinOCV+TMsHnji9ikOIpEYfBSAF/pRZg3qu1MgCPzbcgvrLSaFuigATSIWpRVt7tbhYOt0EwFVysRJxY6IQUjO0oMW1veuOh1IMMkdwpxx+Jws5yOfv44sfqNrWiB7ztBdCuxJ/v5IV9SvwOZJn3p6qKFWlIJN9EBT6DiDSzzNciOU5OcBRvgFa9ABWwdytC5wUXwvgHov3nhLW/k7AxMAjzgn0T7oKaPCrh1Ww/5NyHhTgpvbHMG8vFURyH6X3V4tfm2c4aoQGys667i/mmZULCXcHvqwZfTSwklIgXF+UnTGgOqHCL/OyNAPRTAavyUeiznZjvjG578ycLgBHmUkRHNz3DjjJalsNW2nw1gmVry8rRoILEBXyHhIiKAiPIwEjdeBnfkDlbG/QXBAJcvhM/eBmQK9TAT9Btg1wSK07/mllrpEv3yF3Y5H7UA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199015)(71200400001)(54906003)(36756003)(38100700002)(31696002)(122000001)(8936002)(31686004)(38070700005)(41300700001)(316002)(6512007)(2616005)(86362001)(110136005)(6486002)(2906002)(83380400001)(186003)(66476007)(53546011)(64756008)(478600001)(4326008)(66446008)(66556008)(8676002)(91956017)(5660300002)(76116006)(6506007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?SnpPd3hIQ3BHUXo2ZHNjZmNkSjNadkVmVzUySDF4Y3JOWkNjdHArdkhlME9O?=
 =?utf-8?B?QkZLR2dJRVJBUEJ6cTFNbE1NL1EzWjlBM0ZPaDdWMnpnaGdtbDV5azkzY3JV?=
 =?utf-8?B?OTk0MjA0OWlVbUhBeDE4YW9YNlZZaWlrM0tLNXFOVHR4ay9VUHdQTGFlci9q?=
 =?utf-8?B?UlpCQVErZUVSUWNWVHowN2k4N0dxSjdDL0lCVlFIMzJ0Wmx2ak1hdFhxMUNB?=
 =?utf-8?B?aWhWMDBRYkpFMUh2Znk4aHphQkd4dTQ2RjRWSWtMQ0pvS2w0UGF6Z0tSelJU?=
 =?utf-8?B?U2ZjemhVNm1PTVcxSFdMVWpWbkMyRnhid056RVlCTkFnY0xiR0xQckMxNTZ0?=
 =?utf-8?B?U2pCWWhvNTJBU055NHlxNUtWWEhyUlNvUm9QSDN1S3dPblFheDl0ZEVQMVd3?=
 =?utf-8?B?VTZCM2xGNVg0YTl4L0E2VURJNnhMY1BWQnppcy9RZHprV28vMU1FUEhCZGFk?=
 =?utf-8?B?a3J3cFhHeDhrMjlOeEE0SkRSOTVqNTJHd3R3cDFjSHJvdFVUNldDSTlSOVha?=
 =?utf-8?B?d3FPdFVtWWhSSGRralBsZS9FYmpHcmlzUEpESjBTd2R4dUJGeTdJWFIzU1I1?=
 =?utf-8?B?L3hmMTNQdmpHRy91VnY3cnVCdTRJN2tjdytGZW5XNmRUMUNaVUZZVjJNeGtm?=
 =?utf-8?B?dUlGb1BMem9Jc0VQVXkxeGxRRGFibHJMN0pSRTd0SUkrRXFHc3hwdDZtL0xn?=
 =?utf-8?B?bjVEQzJjM0hvelpZRDVVaElzTVVoNERKV2Zpc3dJVDFBODFOejdueXFRNXFt?=
 =?utf-8?B?bUZEZ3FQelh5NzcxZVVXWHM0SnJ1WW1uL2x1UWlyUzJyL1pOUWpSRVBweEFs?=
 =?utf-8?B?UFJwRUlGSmhONnFzMHNvaXh1WUdoMVRiNm13UGc3SGFneEUvWDRMRHladlo2?=
 =?utf-8?B?KzNBUVJFaGdUa0JyWjJLWjJhZFFxK3ZBVy90MThHV29DbEM5Y1ZhdFpjU1JU?=
 =?utf-8?B?L2R1VzdRazc2N2pReEdlOWRWSTF3VXl4Y1RndXpVK0U5Szc5ajlTTVVWYjd2?=
 =?utf-8?B?bnBkQ2xzZ3lXVENoVUpaWWFJSVVDMGtnTXp4QkMyNGkwb2RNeVpJTVV6a21n?=
 =?utf-8?B?TUNrbGFndlBGckJyaFJXeG8xdGxuTGpVRHhDckszcHIyRHlHdjloVTdOTjBU?=
 =?utf-8?B?SS9YVHloVVdISmdQSm5iSStRd2ZSbnlIaDM1NFlrdWZ2MHNiWVRtVVBaZGRk?=
 =?utf-8?B?djNFT0pjUWF6Yno5NEdZZ3M1eXpOK0ZSYkE1cjF6Q0VTU0kwY3VvVzRKTkpF?=
 =?utf-8?B?aUwvRk00SDVoekljZFlHOHcyZXg0bnRzNmZnV1FhV1A3Wjd2QTdyS3ZJNHc5?=
 =?utf-8?B?TWdUc0lIQmE4dE1oQTQyUkcyanczTlh4cHh3N3ZmaWMyR0ZscjNocUVGQWo0?=
 =?utf-8?B?blEwTmJpUmd4amVvdTMzbGNOOHVwVjNJU1llZWxRVlpJekxvNVVVUkRhbjFU?=
 =?utf-8?B?U0Exd1dhaklBRklzMU1VZlppQlJuRHVDRnUzVDZ2am9kN3ErQ0VXbWNqbTNK?=
 =?utf-8?B?WGwrZnVXOFhJb01WZkRJeEZUR1didFlRMTdYQ0lKTmZ6SEI4ZlpBWG9QVTRK?=
 =?utf-8?B?SWZySzVEVEZpWUJHSm5Wd28wczR6RDBObXB2aDRqUTVWU0RIMmxFQUFkOUV0?=
 =?utf-8?B?Y0h3M3NpLzZHNEg2RnEvNFZ2RHlxa2VVU3ZGV3h4cUkyMkFBc2JQL2xzei81?=
 =?utf-8?B?em55SkRCdm1MdldvcHF4dXJmUldyczBPMExhckVBM3ZiMTdrUTI0bGFnNW1I?=
 =?utf-8?B?SStzVEkxVjlmYlg0QUh0M0V1S2RVSFFzSTBUcTVZUGxMdDVWQnM2QmdQM1pG?=
 =?utf-8?B?UzZGc2lvRjFRVndEbGMvSjE3TE9MaVRBdXMwamNRN1hrd1ZMYzlHVFN4d1ND?=
 =?utf-8?B?czc0ZmUrVGhmejRsT1BUOVIwWC92MlhiRVM0cXd2ZjhxWHNNM0VVOHZUeXg2?=
 =?utf-8?B?eGR1SDBvSFkxNlR4cG1Ua1FVMXpoRnVoVy96djBxOE9MVUtkZUErcU8vWVJZ?=
 =?utf-8?B?bUhxaHQ5WlcyVWFPSlBKL1RpMXQrMTNOV0FVNGdZTDNtTFhZQmJMYVZtcDZh?=
 =?utf-8?B?SE5NUDBhblZGQ1ZsRUxtUW9ZZ0puMGZSRGNHOGxKQnZrVDFETXNGM2tzNFRI?=
 =?utf-8?B?UFRmS2dSbXNzSm9IdWU4LzdSMkpSU0hXN3BrZjBheDhndEdsMHM2UCt5ZTV2?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26F9280134AEA84491F432A1D61C0A20@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4322e41-4e71-427c-86bf-08dac2a943f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 23:22:27.1107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yt2KxLcwWsxwD0S8xloZAXgKpNAudXq1ofoStuTBvova19k0ICGT736Vup7vm5KRbL0+9BEJ852Iuj4b4tEdIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_152233_897283_590D686A 
X-CRM114-Status: GOOD (  13.16  )
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

T24gMTEvOS8yMiAxMjo0NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFR1ZSwgTm92IDA4LCAy
MDIyIGF0IDA0OjAyOjQyUE0gKzAxMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPj4gLSNp
ZmRlZiBDT05GSUdfQkxLX1NFRF9PUEFMDQo+PiAtaW50IG52bWVfc2VjX3N1Ym1pdCh2b2lkICpk
YXRhLCB1MTYgc3BzcCwgdTggc2VjcCwgdm9pZCAqYnVmZmVyLCBzaXplX3QgbGVuLA0KPj4gK3N0
YXRpYyBpbnQgbnZtZV9zZWNfc3VibWl0KHZvaWQgKmRhdGEsIHUxNiBzcHNwLCB1OCBzZWNwLCB2
b2lkICpidWZmZXIsIHNpemVfdCBsZW4sDQo+PiAgIAkJYm9vbCBzZW5kKQ0KPj4gICB7DQo+PiAg
IAlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gZGF0YTsNCj4+IEBAIC0yMTk4LDggKzIxOTcsMjEg
QEAgaW50IG52bWVfc2VjX3N1Ym1pdCh2b2lkICpkYXRhLCB1MTYgc3BzcCwgdTggc2VjcCwgdm9p
ZCAqYnVmZmVyLCBzaXplX3QgbGVuLA0KPj4gICAJcmV0dXJuIF9fbnZtZV9zdWJtaXRfc3luY19j
bWQoY3RybC0+YWRtaW5fcSwgJmNtZCwgTlVMTCwgYnVmZmVyLCBsZW4sDQo+PiAgIAkJCU5WTUVf
UUlEX0FOWSwgMSwgMCk7DQo+PiAgIH0NCj4+IC1FWFBPUlRfU1lNQk9MX0dQTChudm1lX3NlY19z
dWJtaXQpOw0KPj4gLSNlbmRpZiAvKiBDT05GSUdfQkxLX1NFRF9PUEFMICovDQo+IA0KPiBJdCBs
b29rcyBsaWtlIHlvdSBuZWVkIHRvIGtlZXAgdGhlICNpZmRlZi4gVGhlIGNvbXBpbGVyIGtub3dz
IGl0J3Mgbm90DQo+IHVzZWQgd2l0aG91dCBpdDoNCj4gDQo+ICAgIGRyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYzoyMTgzOjEyOiB3YXJuaW5nOiAnbnZtZV9zZWNfc3VibWl0JyBkZWZpbmVkIGJ1dCBu
b3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dDQo+ICAgICBzdGF0aWMgaW50IG52bWVfc2VjX3N1
Ym1pdCh2b2lkICpkYXRhLCB1MTYgc3BzcCwgdTggc2VjcCwgdm9pZCAqYnVmZmVyLCBzaXplX3Qg
bGVuLA0KPiANCg0Kd2h5IG5vdCBtb3ZlIHRoZSBzZWQtb3BhbC1jb2RlIGludG8gaXRzIG93biBm
aWxlID8NCmFuZCByZW1vdmUgdGhhdCAjaWZkZWZzIGFsdG9nZXRoZXIgYW5kIGNvbmRpdGlvbmFs
bHkgY29tcGlsZSB0aGUNCmZpbGUgbGlrZSB6bnM/DQoNCi1jaw0KDQo=

