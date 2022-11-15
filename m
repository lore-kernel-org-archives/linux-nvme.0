Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749B5C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y9WN7+b/Nf0JtQtQ7yGxf8hihyQAa7kdqUGEZScJS7w=; b=PW4XsiHFli9IjZAZt79O9oFia0
	uezxPxmkwpMXaMZ7vWk30rluAVYs5yFJcDw3dufMSEq+uWxY7ygGZt9HZ54lcFQY2/LC88Xt83TrX
	L2xMRk1xiJuAv0q9eOyhgfYZq7ydUHIBgCRu7ef3Mu2/6wZfW2C2keOkIFTNjnH1OCTO+XG8TUsBH
	BpkpBeFm5alZx9uUSBIwZRAwcpPd9l51QvfH2cjXWT4sOm1GfbHFKhaPJlyEyihGwAJv0znXpx2Hy
	dsPPiRat2vSLXQLzQ0mHX/iBA4nNnp0or8BZbNC9NfzodtQLbq/KTFM60i+9aefQf9FblF4Br/I84
	iYbcF4Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounP6-007ZOU-Td; Tue, 15 Nov 2022 04:18:32 +0000
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounP3-007ZNf-5m
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvgjkEKKMn6SJr2A5uKNl9ggV4ubvYqiUXn3W90gNl0qH9ibwWFf3aJSRLhOP54+xFni2IwvydsFZVqr3Dqdfehw3FqgxI6o3m53/scoiuHG9xIc9u7DzrE6KFTCvnLiXi+r1ke5enKzJktfVd24q0xdYKsBL9u/XvzmkhERwXoLF80qiCeFT2BQmYCZKkLZB0lng8A7ujzepwFNAUkfovzcmDk9R6eANGvAp6wFRhbL+3w58gGuETgHrDjs57ZAUofEWKy8XdQfX8iW5HRDPBU1OmHMrOf4arSqQ6+C/QWLcZQ22UXY12Tm02CUpZ+iwRv7hskzSsGfUC1qnTiX9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9WN7+b/Nf0JtQtQ7yGxf8hihyQAa7kdqUGEZScJS7w=;
 b=cbODkjbU4GlC8/1d1COfgHkL+JL4j4lh2f4O0cyiU928/416ayKTCVULU1WrjLx3P9urwLyDd6tlYG8lhn/uQe6Vx1hEUyfkeP/QYFRC9BDyjC3yw47zk0Dm3skRMJFY6vIVPxKzldy4WTys8AsgZGfA91PRaoPk00lWgSbpeHGDjeVxWTeVdqEIRALdM2L5BZHtLypHJTryZNhEYx4RFQg3yehfDvH/NBaBNI7LFVBZDTF3Du2K6vlSF7vMSjPCYh+czEwfLQqNN/e+EUUASSebPjsN9xQCGUNc+rgqZ1HNMTpjhEjr7XGTtBkZFqNYEnfoLt1BqU59Emuc96xe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9WN7+b/Nf0JtQtQ7yGxf8hihyQAa7kdqUGEZScJS7w=;
 b=YNJ7KgICkcbzKIsP/PUX2FFR8BaEbkJ88d3dPVASDbqeg0aDkpjAWxzHXHHxB4hGCUatAiVjdKYzHe3BDp5vzGCa0+G4+QeOHayfQOrByBNvtq2iSYmk4SsTyp29VgIOrmBnX1BkJ9gD8NCiZbQuBPWwgYKrXDgqAQ5wIq6VjawCplOqDHhsa0MuJJyq5gio/oSyDvvsdNQecsBkiG2bMH2fVzFqP+Y8IsqSsKyL5UCjsfq7HLSXHyvN0Eu3RWuG5stTi7HJCvSWq3Se3pSd4DbUN3oiCXKcBTaqK3E2BGznPdHpSRntqeg3LzrH8i0k9kLx0ki/WT9XtTsRh/6EbA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:18:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:18:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 19/20] nvme-tcp: stop auth work after tearing down
 queues in error recovery
Thread-Topic: [PATCH v2 19/20] nvme-tcp: stop auth work after tearing down
 queues in error recovery
Thread-Index: AQHY91Oa5tHrXjG/Gk2sI9gRb5XXpa4/Y/SA
Date: Tue, 15 Nov 2022 04:18:26 +0000
Message-ID: <1b8bbb13-ab1b-3fe7-f705-99347d3ddf73@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-20-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-20-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5068:EE_
x-ms-office365-filtering-correlation-id: 97f8f0ab-6d30-47d5-b4c3-08dac6c0713d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  2r1jIrB6J3b/PNVaaAPnPLC9XrsellZWmwSVweJngev+VbXgEcXtbFPKSIsxJ588OJLZqgiC+cLLrhAglf4r1b+OoPcIagFer3ck6NQjVAB2234oLSNu7ZegZdPwPmp1JtAITL7yT9nB6qcE8Wrmitk7jUGxSUnM3mUhajsVgohEqTYU82opkI+gJDkZnpMBkGFxFhb24NA2QybcvyTaB7eJBLTjefKC4h8UHv9Sx741GmPtr9LMk9rAtOz3YwNL0x8XsQqz4k8mKBA7gRCLX9xgBuVzZUZCSN3qCmCVOiaLyjPyVetGQ85Ka/2DFvdwV/EI6Sl9wPwOLUuWrfQDfmJkrApBs261TeLOgUWHQPXvAZnVwvHRkjvkv0+6hROfR/AW9zpmJAvAJ5PmcumeHoVEwZuaQdE1/rC5q5oBdYl/yzJzcEKD1u+DbjYmbJIYCKH83hifdPIwzImHmXKdMjzpDR67a4wYam0EPz7DryfV4WWWFNItv8uc2FKLLFkIuusAgsEpvoXR1IDbrMg+OZE/RE7LOSBA+v16DQeeSEK1gBCMHXeKFJrGVcEcm6FV9cwIWG7PUE3gUCADWJ6LC36u75o2xXhXJkLQ51Cl8Jiu75dhNmbl9dzQc5AWa2WBb2HqokvYVVJ5TlRlypALh+jCoTlCyI9KK2iyqyxyYJ64VGMBpmLgZglfk+FUz4V0fEtw+TnXq4t/KR1bQTwIGzWfozQnx3IKFSM2bnDbZXhnfFWJsnrcl7qGGynvGwzpqNV1YltCNhEOGPw1YdNJP234p7EJNjhSADxIE7iOKiWb8iCtzXex4a9MXPSO51WhygtuYp0/vq8IGqWu97lYiQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(451199015)(8936002)(31686004)(41300700001)(4744005)(83380400001)(186003)(2616005)(5660300002)(76116006)(71200400001)(6512007)(66946007)(66476007)(53546011)(4326008)(6506007)(66556008)(122000001)(64756008)(66446008)(36756003)(8676002)(6486002)(38070700005)(91956017)(478600001)(54906003)(31696002)(316002)(38100700002)(110136005)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Y2lkUjlDMmltaSs2OEFFRlEvRkJ4SkRyT21qeVphdWZOOGJxM1JyUEVoejVG?=
 =?utf-8?B?UGEzcmJpOXRsdktNd1dPLzhJRkxqS1pjbGZtb0xQY20rYk9jYm1JV3dUcHRF?=
 =?utf-8?B?enBMWGNuaG1QMC9oMWVaUFhPZE5LaVhkVWlVcUtVdHRZOVRxZVNZMXhkQ3hz?=
 =?utf-8?B?YzlKUm5OUWVkU0piRHJDenlQU0JycE8rT3BIY0ZQem5XTjNma2QzUGhXYVJt?=
 =?utf-8?B?aXB2MnhPMlhWMHNkb3VGKzVTUUY5WmhxcGQrcVlMaVVZR0EySlpuOFMxcTNY?=
 =?utf-8?B?Y3NSUG5YUmtwN2VJdUFJd1B5TkF3VFZReUFWREhWUG5OeHo5T0luSW15M1p4?=
 =?utf-8?B?cjd3OVlsTm03am83c0graFFuMFN5b2I2Mm4rNFlXdGxDblZVV3ZtU0lxSUda?=
 =?utf-8?B?Mi9KMUYvdVUrZC9iZ0IxcDVZTGRZV2JBU201Kzd4M1dWWXEvMDRXOXJadjg5?=
 =?utf-8?B?aXVPTzI2TXNKTW16L2prYTN4Wks2cjZ2V2FiVUZ0dXEzTHFFRjltWU5IOFhK?=
 =?utf-8?B?a3JyWG1BL0xDaE1ROGFoUEh2OWVZU055QU9MZ0Q2MllVNWhJYVBnTGJPLzBU?=
 =?utf-8?B?M3BHODA5dG0wVElSZEpXYkpKR0lHbGMva2IxQnZIK3Vrb0hZOWIrQk1hcE1C?=
 =?utf-8?B?eWlLQmJmZVJBdjRYd2t4M05hbld3dmJDdjF4Vnk3dnc0YTdnY2xxZzhkWFNn?=
 =?utf-8?B?Qmh1b0M1WWNkNzFHV1BPaEVabENNTjlpSWUwcWExbDFyUU5BSWxZTytOWnA4?=
 =?utf-8?B?aDROSVNnclFhdVFreXNlaGJOeGJmaTJaUlpRT25NdGlxM0dBeVRTdU9Mblp1?=
 =?utf-8?B?NHQ1Z0FQWVhkUjJIS3NtYjVxMCt4OHFtYTN3bzJFS2pHbStPNStuQWIxZWZR?=
 =?utf-8?B?Y1ZRMTRqYUZGakYzNTR1NGUvdzZkOGlVZlo5L2RudkNKRDBWVGdnRVBMeVNz?=
 =?utf-8?B?alcyNDdzdjYzQmZHMHpXb1phb3dFa0t0dlRRMUVLb3ZmcVFGSmhEL0lpWFYv?=
 =?utf-8?B?M29JMWl2NUdBUXZnd0lEWGY2dVI5bXlwUDBZNjJRT0pkOGx5eTN0akZTblg2?=
 =?utf-8?B?aDRSeFV5dG1OZ1hQSUhqN0ZBYTVaYlRiS1lndWs3K0RXVjlOaTFPK09nWGtz?=
 =?utf-8?B?d3VpeS94WWNncnM0K3ZCckxwMVEwQ0JITmUzOGlJM3ZQRll5ODNObi9uUFd5?=
 =?utf-8?B?dU5RZVhLRmpKZXlvTmE5b2tETUJ0Z2VGMG9QY0E1MnRrY3dMa1FwdW11QWxp?=
 =?utf-8?B?TjNnRnpxcTl3L2p1c21hWHRpeVRwc2oxQnZRWGU4YVBLZVc0aDVzVjdQaFdX?=
 =?utf-8?B?UTdPODlFelNMVCtibUdlYkhneUt4L0dCYXVTQlFJQ3hUWXhMUGlLSUgvRmow?=
 =?utf-8?B?cmtYalNWbUpKN2xwQ2ovMHBVVUIrRDRkVWRUSEw3S01sL2tMQ0VhbDhpcGtp?=
 =?utf-8?B?WmdYS3Z0NXNXZjVnSk1WVGdMdm9ocyt6eHMxeldab1pIbTZEYnBQdTVGVDRQ?=
 =?utf-8?B?N2ZjMU1US25xUXhpd0VpU3NobGMzMHRSL0Nqc1crN3ZVWVdFRmZaQXM5eHFF?=
 =?utf-8?B?Z0lmazlZYmNRWnRvU1dnS0VTQ0tsbzc4NWd2WnJIa1RtaFRnNnlmSkNrcnd0?=
 =?utf-8?B?eGVtbUZJcUNKbm5lWEpVVmVJWWt1OFhnclB3eldEdi9DdGsyTkwwUVFBMk41?=
 =?utf-8?B?SEhlQzYvbUQ1NlI3SzNEci9kTWRWZ09ZMHIwMU1HM0YydHV1elNWRnBXaWZR?=
 =?utf-8?B?SXcrUWtVZVZUR2lOTjV2WTJDZnBxdm1wa3g0d0ZoMHV0Q0FWdHE0cXFpVjBk?=
 =?utf-8?B?R25Cd3B0eGZSdGdNaWlUcDB0WjJobTV6ZmEvSHo2Rmp0UGl3VnZ5ak1sT0Zw?=
 =?utf-8?B?RHE0YUFQU2N3ZzlmaFVxV2xxRjJ6OVNxM08wNnhZbm40b2tkNFFaNjVUTHZn?=
 =?utf-8?B?eXNQWFpYOG5idVJXWm1LQm9MM3BwV0VRamFjTnlNMW1FaVcyZG9RRW9yWEVo?=
 =?utf-8?B?M0xpcGQxeU9LTm16S3dSaFFyaUdyUnJqOEVHNSt4QXZ6aUNnNkFXMzkxekpI?=
 =?utf-8?B?TlZ2L3pzSi9QTEhQRzNVS1ZnNm9XMGFEWCticVBrWjdqMllpMWM2ZVVPYW1x?=
 =?utf-8?B?VHdUeG9qbmE0UGNDUERLK2pHbGQ1QmU5MnR0aFhvMFB5TEp3SSsrVE4wbytG?=
 =?utf-8?Q?+QkpxxLkD+j6gOQAbHyeDqRnygsXFFrqpdfx6sCAXHLr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C15974C4FD6E9749947CE007A82DD57A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f8f0ab-6d30-47d5-b4c3-08dac6c0713d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:18:26.2080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENaLcismIbbrDe2rpHtFFD4H4E5mu90jXycq+b9/X3GCgIymQOAt93fMqkkz0hJ9ojoRfMcha2q4h5HmckHE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_201829_237149_3A2E54B5 
X-CRM114-Status: GOOD (  13.69  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IHdoZW4gc3RhcnRpbmcg
ZXJyb3IgcmVjb3ZlcnkgdGhlcmUgbWlnaHQgYmUgYSBhdXRoZW50aWNhdGlvbiB3b3JrDQo+IHJ1
bm5pbmcsIGFuZCBpdCBpbnZvbHZlcyBJL08gY29tbWFuZHMuIEdpdmVuIHRoZSBjb250cm9sbGVy
IGlzIHRlYXJpbmcNCj4gZG93biB0aGVyZSBpcyBubyBjaGFuY2UgZm9yIHRoZSBJL08gdG8gY29t
cGxldGUgb3RoZXIgdGhhbiB0aW1pbmcgb3V0DQo+IHdoaWNoIG1heSB1bm5lY2Vzc2FyaWx5IHRh
a2UgYSBmdWxsIGlvIHRpbWVvdXQuDQo+IA0KPiBTbyBmaXJzdCB0ZWFyIGRvd24gdGhlIHF1ZXVl
cywgZmFpbC9jYW5jZWwgYWxsIGluZmxpZ2h0IEkvTyAoaW5jbHVkaW5nDQo+IHBvdGVudGlhbGx5
IGF1dGhlbnRpY2F0aW9uKSBhbmQgb25seSB0aGVuIHN0b3AgYXV0aGVudGljYXRpb24uIFRoaXMN
Cj4gZW5zdXJlcyB0aGF0IGZhaWxvdmVyIGlzIG5vdCBzdGFsbGVkIGR1ZSB0byBibG9ja2VkIGF1
dGhlbnRpY2F0aW9uIEkvTy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNh
Z2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQpJdCB3aWxsIGJlIHJlYWxseSBjb29sIHRvIGFkZCBl
cnJvciBpbmplY3Rpb24ga25vYiBhbmQgd2l0aCBibGt0ZXN0DQpmb3IgdGhpcyBzY2VuYXJpby4u
Lg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

