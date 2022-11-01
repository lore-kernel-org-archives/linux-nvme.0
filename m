Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFC3FA3741
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pw2G9MOWh1OyXUo0pGpQiXQ4yRQ3K3977mfFaR49pec=; b=hk/q9iyOzdt5SDXay6FukrATBZ
	B2oTJmiwmSR5imhhtuCI6A5ozcOTzNXA3AYKvJgSMXPmccImP567QyqQj/+pGCM6ZF8Vo5iELXehI
	HiIL4WkU7HRtEd6+2AWhRryBUR3Swg60QzK/DXnSSoms0BUNoDWc8ICLfIUOt/kLLEOfieyKZe17D
	P6EXeI/o/OiBRmQgb4LZ6MMw6vAdrpTNxvwp4FqOYBlFMpBWtEuv9IqrJ/flCLqngN9DxwAC4CP+a
	ojf24S6aNIJDnCH+NY2qJjoExGpWKDdRoU+DiY2OFnfxQsLX2uvrwg95RFDJzG7SSwkf0TtZQrebH
	sldDDNUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oph7x-000rWT-N5; Tue, 01 Nov 2022 02:35:45 +0000
Received: from mail-bn8nam04on2082.outbound.protection.outlook.com ([40.107.100.82] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oph7u-000rW2-Sr
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 02:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEgGmSEIGOlxbejRWeNZbDtl4hI2kfUfQCnSrrCUIIgtdS0TlZpmhW8nhxdqlehL5om7iKSEV2HWizYEdYwC5naqxHMjj6TbLSHsWZFfrWXoiLWxvzuA83NsWg6HMMfBwLJn/j4PlTnFMNWYbO8v0KzSYNxlOjNHb1DP4dHaWG8nXkGp15/l+dIOjUYHVZbDWZnGnJTTJ7xqIkeVzQ1h47mkVMH1y6W9L8YZGNUp0aR2Tv0tejnesYUCAkuTsdIEy9zuBnu87Gq+fB97dLb7wWgeUzKCaLf9pbMewhOClLX6iUBLZ91B4PAK/jbLO5U875bACLYApYocXuWg1Kc89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw2G9MOWh1OyXUo0pGpQiXQ4yRQ3K3977mfFaR49pec=;
 b=FG6GE0r7C1VJ9J7DEbyOWSskTKPu1PqGZiaeY/gzi1MJULttUC4/3dZj8SyJsPFqst0RCcfr+rzBl1yrFkKhujOaOTgNFnDqzNyDn7gxUJHV4jp8uiSC1j2goks8BgOpJU2XIOJS9iVEHgn+8Nbj8jDIRqeFpuvxNyTUSNzxO5TF+ua2G/toR5T0rrGDfWLkRNmN5Ug0Nzio0bzO4zncGFkQMTxsQVzzM+dTY36xnoEHJAX3eGnbk6pkdpyMYECV6XgEtVzYDDJTgoGDgamYevMMQJf8IIMLrtpjXbTUP/Dm/JKBVJC78/kLdJo2UmBCJUTU/VnFXhySl7FcEIXplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw2G9MOWh1OyXUo0pGpQiXQ4yRQ3K3977mfFaR49pec=;
 b=JJyFQOqGPeG9MGquM05SyiVHEmx3ikbBenUDVDmUBzfXXe7NLV0ycCmfm33pgpdux23lOgnIRSEzSZBRIN0pAMmlxTFqfab56e+xQVT+paKy2GkzerwgOkqLkobpHm3dUtWxyrhmHsbAFED09mjXTKcNTpd2Xtd9+Xg4ZiOpq4WGdFZ6HiLtn1s02ZjFReUYjyKTInIvYOa2gO1zBbE21CJRZGi8x7/t5jWkQMDhyFgW0e9bzk4HamMZwd1V98/R+CN/lqcBQJws0ofRGfZAyrLzOR+Lp+w6vNzTqP80j0zA6UKUDV3j8xJKpvzJPVvuU89XUrYiXwIAHuXoEobEwg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 02:35:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 02:35:34 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Kanchan Joshi <joshi.k@samsung.com>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: Re: [PATCH v4 0/2] Granular CAP_SYS_ADMIN
Thread-Topic: [PATCH v4 0/2] Granular CAP_SYS_ADMIN
Thread-Index: AQHY7UbL4t88ubFjpEWcKpcg12wfFa4pWq9/
Date: Tue, 1 Nov 2022 02:35:34 +0000
Message-ID: <787D611A-A19D-4B46-8D62-AC675C17E70D@nvidia.com>
References:  <CGME20221031163523epcas5p327b516ddab691c02d2e3ad2a80a7bdce@epcas5p3.samsung.com>
 <20221031162351.31856-1-joshi.k@samsung.com>
In-Reply-To: <20221031162351.31856-1-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6166:EE_
x-ms-office365-filtering-correlation-id: 713fb28d-1c92-40bc-ee82-08dabbb1c10e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  z/xJGlOcGeirmDLA/qLUdHep3Rx2jJSkuLPNXmjxS4W+quUhiCIai5bSFvBPuy+ZIfrT1LK+EjSSDEoPsoSYzkfiXtq1v4q80YaWnfL9emF/QG2wf9dt8NQecC73iUlFSYO2mrOhDoRPNZWsfIwEnvRtGe1IlLL3mTUyuzW+s90/smg7wWsA7+ExE+LaJ1NEPFQZNdRG+xu18BOm5n9PRm5QLSpTGWoznYgmUkqjEdUGEF7i8uGd0RksfDL0IFyluqDv+XUIgfECATQNXktzLuGFPEQQKFBflJeEf8JemUGU15aVGKTXLjGK1ic7VJ3d6sfGW2oEZGO/l5x0fOUGE31hP+DDKVUnwIkzOQ1ONHgCjHpaQgcSZAZU1Zw7ZcjNxlmvBbebfcd7cPqfPrXRW0MizIxfYaYTIuyf1gmy9IlfQRYekwUg+V3TtKDgT+GWtaoMTMIgrk5HKxEsqS6ecUHNOaFTU7+QXrqIOEf7NPc0AgHopH64cRhsqc7/0ZIr6LxYut0hNwLRMKGaPkIRF5bSW/e8WvOXdbNMBR8upmtPpE9aoiCPORRPI89M621Kc4QiVXGk7EYTbB5TOm+vqkmU1dacaDI8lSrNhJ+mpXu0TU9SJMVzEl3Jf2C/VWkATCOJIZQkALv8XLW6wTWiSjiDjVyAva6Dbl3ZFLVgB6b9pnmSTjkgUVP/A4cWi5/3apX7eqw2Bzb/1TRX5MEoQxdnFIHSDJ1EqAJ7+mIVaqkKyrHMn6Q23VWyAiibXFMRY1nNafLgl9EEtqt9eK1E8bXgKNbV0aYWHlvOJikSDnI=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(38070700005)(86362001)(5660300002)(2906002)(76116006)(66946007)(91956017)(66556008)(66446008)(38100700002)(4744005)(122000001)(66476007)(83380400001)(186003)(64756008)(33656002)(6506007)(6512007)(53546011)(2616005)(478600001)(6916009)(316002)(71200400001)(54906003)(36756003)(8676002)(4326008)(8936002)(41300700001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RmplaURFSlJRTm5WdlpEZHhTOEpPTTZPQVNvR0l6ODZTblREd0lKV1JVdm8y?=
 =?utf-8?B?SnNmeFdXRnlrOEFsNXplVllPSU9pa1NpNDRQMnNqRk1rdnRVYjRGQUpxc0Vu?=
 =?utf-8?B?UmdGT3lXczlEaEd1QitjdXFxbDlnWWk1S2NKSitNQWNBZm9URXliU3BrSlV1?=
 =?utf-8?B?MWkxVjIwN0UweHB0SjBHdmR1QkhnN3p6QkhlL1F5VE5MYUVMcWE1aXR3K21j?=
 =?utf-8?B?cmNtRnl2KzVHVmQ0aVN5cHVzbi8wWTdycWljZXZPZ1JZYVlCRWdOM0dpQUhI?=
 =?utf-8?B?QnpXaWM5YXkxdnR1ZlFIbk9XRkc3RlR5d2dqQTBvUC8rcTBtRzYvVSttZTIy?=
 =?utf-8?B?SVgvSXFtOGpiWDgwUlFhQkxSYWhrdG1JRWpXVG9keHdHQTRxdmVoVG1DdmJ5?=
 =?utf-8?B?K0NsNWV3dVA1UEg0TldlQlVZUlhrUzYwM1RGZGpSKzNxZjNtcWVSOGd5WC9C?=
 =?utf-8?B?SzRHVmJ6aXlpNFdVdjE4TW1Zd1pXQzNGSmM2cVJNN1FnQ09DU0VucnllY2hU?=
 =?utf-8?B?Y0RVbllZcXVBVysrN1VpaDczNTdQZFRVNGZkMnFlN2xkekYxQURCNkxUYnA2?=
 =?utf-8?B?OHEzT0VuaTNJc2xveDZLeGYzZWpmcW9mSUdwWjhTRVNianJWZzAzdnNIdnNT?=
 =?utf-8?B?YXZ0M2Npai9XdURncUM0eGpOM2hMS0d2Rk53S0tGNytYL0hoNzJOdGgvcUZw?=
 =?utf-8?B?R0FVbEEyRHdFTDZMOEdHaVgvUkYwVUhRazlJaVhISnVBcGRQQ0dQZDUzUjhF?=
 =?utf-8?B?cFphQVRISm9kRmoyYmRoWTEvcGFGWWhxRmNDdVhsWEFCdkR5NW5JUVdLelYz?=
 =?utf-8?B?NEtBcnNISWtxbzdCd2swc2dMNjUzbndCOGUzU0NCTFJqWFdNUHkzQXM3V2VD?=
 =?utf-8?B?aHBoY2dKRmVGTU1jcU9wUTc1QXhJRnRLNlZWNExyVmk1L1pZdmE2b1EzemU5?=
 =?utf-8?B?Y1VSNVN2ekVleElsdU9XendPaVFMa2w1UGwvTnQvY1c3ZXljelBpbCtSaHJP?=
 =?utf-8?B?SXdnZzE3WE9YV2g5U0tmUWk1VWRnOUZHKzVsVEJMR1Q1UEsvRkJDTkdIV2lo?=
 =?utf-8?B?ZlptUmhLRUNsWGtuYUlnam51YU1HM05YSDB3SzFnSTNwSmZtanNCcHNoWnF3?=
 =?utf-8?B?RU5XUW5mZE9DcFFrbEdxcVNOK2pibGU1ZWdCKzFPU250NkJ2WWwydnFLa0hx?=
 =?utf-8?B?KzM4cXY4K0lqeGkwQVlQQndIUjB5VGJkL05NaGJtQTludytHTFY4VHJ1MmFU?=
 =?utf-8?B?RHFvOS84dS9IanpPZlhqeDRTMGZQUENUVUtVdGtiUFpkcEJDenVWM1ZUTnRp?=
 =?utf-8?B?VEVEejVFeUUwcG5TQlo2RDIyQnUzZUcycDJJc3h6MkhwcHlMQytrVUhLSFBJ?=
 =?utf-8?B?NzhyMzl4VVVYNDEvaVlDVTVtZURkOXU1M21YLzBiVUV3Q2FKc0Z2b080eDhZ?=
 =?utf-8?B?YnBOSy9oQTJST2Z6WXlLd2NENUMzSDFLbzhPSmFLV3VNMkVFZ2hFalA1Lzdj?=
 =?utf-8?B?MEtWdkNjSVFGSHJqaHF2M1lNWHRmempOdVVTNml4T3Y3cmZBcXJzdjJ3bkpB?=
 =?utf-8?B?VW1PU3cvVVRseXVPV1JUdXJNNHlnNE9Ob0U3ZWRXbEtUYjZEaEk2NXBzUzRs?=
 =?utf-8?B?eHhUZnFWUHVXaER3MHZjendqTWViQTRzdkxudDNBMUVGaUFJZVpET2FlTUJQ?=
 =?utf-8?B?ejRMNTE0LzYyZHlwQjJ1RXkwYzZrRG1Pb3RrSHg5aXljd0kwS3pCcFVOOEFE?=
 =?utf-8?B?aGo1ZVErbi9KS2p6d1JmMWhaM1BpUFdtMzVHd1JGMDJ4QTlFZ2NNekJraGVZ?=
 =?utf-8?B?aHNXeGNzbDVOM2Q2WVpqZlc4ZklIeFZPUUhrVXluWE5kOUN2MUR1TVpKem5z?=
 =?utf-8?B?MFZoaVZPNEVMUkJEbVcrYlNGL0xHQ3RZSnNBeTZrc1pkTkVnODZtb2VjMWU4?=
 =?utf-8?B?YXF5MFpQVkxJeHFDd2owME5JdmhqcGVVMzcxMGE1bW95N3RXNUV6dXM5bytI?=
 =?utf-8?B?Y0E5R1VFOUt1Z3BobldmZkxVcDJkVzk4UXE4TUhMeG42VTgzTEFOZlJkUmNm?=
 =?utf-8?B?S2l0RVhpS3pPSElCVWRDMnVoT2dvRXluUHFrSVR5MC85YTJxMnlEaFgybVdN?=
 =?utf-8?B?Q0xlZ2ZGQjVnZUdMYmZyNWtwMmVsSW9rQ1R5enZwODdkTnJsRHJwa2prT01O?=
 =?utf-8?B?eTNHbURydFdySTMvZDZSZHREOWVscVdBSVhQK3VqZ1VTTFpnb0VDYmVnT1R2?=
 =?utf-8?B?NVY0bzFNQWJRWmxPdWlwZi9Kc1J3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 713fb28d-1c92-40bc-ee82-08dabbb1c10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 02:35:34.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xSvRKDoo+fZmMCFbjM/K8dQuQ8aLKD7HA+BO/3DSCyAxcku4IzHaXJsHEOqs+QCXe85JYvjqUIkY1yMyssvgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221031_193543_346426_494A8708 
X-CRM114-Status: UNSURE (   7.69  )
X-CRM114-Notice: Please train this message.
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

DQoNCj4gT24gT2N0IDMxLCAyMDIyLCBhdCA5OjM1IEFNLCBLYW5jaGFuIEpvc2hpIDxqb3NoaS5r
QHNhbXN1bmcuY29tPiB3cm90ZToNCj4gDQo+IO+7v0hpLA0KPiANCj4gVGhlIHNlcmllcyBlbmFi
bGVzIGdlbmVyYWwgYWNjZXNzIGZvciBwYXNzdGhyb3VnaCBJTyBpZiBzeXNhZG1pbiB3YW50cw0K
PiBzby4NCj4gDQo+IFBhdGNoIDE6IGZvciBpbyBjb21tYW5kcy4gSXQgaW1wbGVtZW50cyB0aGUg
c2hpZnQgdG8gZmlsZS1tb2RlIGJhc2VkDQo+IHBvbGljeS4NCj4gUGF0Y2ggMjogYWxsb3dzIGlk
ZW50aWZ5LW5hbWVzcGFjZSBjb21tYW5kIChiYXNlZCBvbiBBTFBTUyBmZWVkYmFjaykuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=

