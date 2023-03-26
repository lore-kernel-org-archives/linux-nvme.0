Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2795DC7619A
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Mar 2023 23:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNQFG2STAdy63aKSyS++njIrKvDLbO8GJJMycUr7yyY=; b=3Bwu19nE+OohsX+v2nj7HdVJcA
	bfXgwATr27b2vZnaOB4mzjOQwPSnu0H57mG7khvXI3EON9I+TYJsIwKtHY4A5iK2Oy9INjRuk6ztF
	DDsSylA7EnHP5TdgboM7S2d6ouEDhrFAXCR3qXm/Rhjt9qoZ6O9mhCq3padSXTcAYQ7+Ju0JG51uN
	7F1SKbhnOe6UAPG1xp5AmSNmA7lvX+dgLHrQ+89lX6UHn/lFwlARxComxU/YIdrAb2Yn9L3SCKGQA
	5ncSyhYUsUrmJ3AnXaPk+XglSNPFSZNjdj2rXLoRCfUM4Vo76WB6gcv8bX+x68/qtF9tk7pIJKEr2
	7r7rSV/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pga27-009MUL-0t;
	Sun, 26 Mar 2023 23:44:19 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pga24-009MTj-0b
	for linux-nvme@lists.infradead.org;
	Sun, 26 Mar 2023 23:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUPt4xX3uxIiP6G9XYsYO/aY6BarjelbEH8nBubMbkBU0TtPfVVE/fNfNGCu1g3cAAfDU0EtJANwyXSTJ4LBwje4P4IlRXS+i/3c5sUbkSv8+RZ5uTXEF5GBe/oB3JhrQg0TFpr1wBjvCLSszIhW3gPfvbG+MczYVHnf/vpk15HWHlrL/T4mSeo+AcQubGNCq5qt5b8OZV9qp45dCojxF89YMt25Oa9j7mGdQ/xKuK/K/MyFxignnUT1ibRJ/lM7KkkLmoY31iYwvsLXnSmKWK2kOZHwJqJQZ+l4e95dh3+alDEOa2l/bYbDfL6TYaUkPhBtozmMsvXtb6UFQlYc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNQFG2STAdy63aKSyS++njIrKvDLbO8GJJMycUr7yyY=;
 b=kg1hlLR9vpja7k5WkDivyL72D9XS8FK438MkRQ1ctatWDcBjFID+JUgaIq28l9+YKPJDUk05T89K+P+fi+tnwbS1IJP1MZCoj/rjcJGWQnu4bGCoZXDbhrleqnuTeIeLdLsJ+GZF6E3/0J/si4rxCjKLcX7Jm7ThmUKQtFEjm1zkVk/yFrcw1z5MGodZ4oHmA3ZVzmqvONCiVWq5PAEulG88rDaqU277syBlFjRw1FiKZ7s4fWz70/FEw45f/603jxnekx/GbiIZlsmeXFiMiv7CPwIBjJFfxx8650yVevyT3JugbDS6GX4F9ssITFpk4sONQBgUuRzr4B2SK6GcMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNQFG2STAdy63aKSyS++njIrKvDLbO8GJJMycUr7yyY=;
 b=K7KuAYsLDeJrTXpegoaQWgXIuUJhLQrO69pkWHSaA1SsHbhniL6R3PQqU4+e2JF9pLR/YNFbjVXiMWOVPGsS1Zc2r1+twZC/9WaTj4YxqsrurnllKTxfRzIp764C08yZXXzlfivyFWzcccZf6sK3DBAE6DiggXkGLzb8R4lyoHwKA/TOg+O1T5qzK+SnIcYJXGEr7PHJyjMmwLLmzy9Er6sNcHAK+Pic5jwiKahv7UOHsi/SVHAzEA8PNi87ugaf7DYP+xqi5gOO7mQKiyxcomY/N0k4NwbAJ0ZqAo1i9UpiwT1WrSvRLFxInLjUTDP1R/jZ0WAgxOPFWenurE7TWw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Sun, 26 Mar
 2023 23:44:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.041; Sun, 26 Mar 2023
 23:44:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: debugfs message during creation of the NVMeOf controller
Thread-Topic: debugfs message during creation of the NVMeOf controller
Thread-Index: AQHZXWAXE1uJpCsNVUa2mewdBZUwH68KhtSAgAM4IgA=
Date: Sun, 26 Mar 2023 23:44:09 +0000
Message-ID: <c8c21fdb-ec06-2b4a-a42a-b4c8c34df673@nvidia.com>
References: <40baa75e-fdf5-cb73-5fa8-b12d65bce4e7@nvidia.com>
 <8ee89033-d454-072a-6fe2-e2bf24ece2fc@oracle.com>
In-Reply-To: <8ee89033-d454-072a-6fe2-e2bf24ece2fc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL0PR12MB4914:EE_
x-ms-office365-filtering-correlation-id: 61ebf256-2406-49e3-2f94-08db2e53fea3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  5XQwNT0gIhkFsomos76laT2SRKTTAkWB8huDGzdyTXiznlex9h3rBD+zi8/RoeF/rut/+b6dwn06fs80vpDj6KsmLXWlijk1pSVyhG7CM/sq+A+Y5PEb4IJWiN6nxhEmTiC5c6XVpkw/NJq4A2oCILbSZLDIz377C2sXjS5a5+D0wq/Dg3OARydRV3M40/08hfVAzq8SFixGIPkjF8aCZWpIjfGdaYiNcP9bP9hTlffqaA/TtEI7MQk4+BXS7FuI9Jrzk3Z16FlDJI7pwRD8THgxl8GgAVYOGnX5biMt+lEpNhkqiK5KM/nIGg3HZ2djTKiyXX1j0IYk7UZijFF3pD9whZFqPguz2KVkIeujBRzYq98mVdz/9Tcw0s3JK3JUF4n+6KFziWMeCoviN8BaY688Z7ni4o6av79XgatSnqu/rsFbamEaae+XpSKgTf5sBRlddMyijX9J6g3i0doFzbxz2IzUn4QptSUE/fNIGjiySuPC6zgJWmPJnfiFav1OnCNwBZUM9Vm4hy+55iKljXbm1Ez7r98Y9OR0CBgw2FaoAViPTIap+obruLNL/atuBnlwW5YU/Rrd/QCNs1J3fM3tBQuT8WoR+Uiogm9vlMnZAuwMJSskTRra+LuOJM2yfz+/CR9LPmAeu4yzYRB87vXfMQegZDtx2bxvzx9q75DNjjeTnbF6nxXjjmXLP7jy
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(4636009)(376002)(396003)(346002)(136003)(39850400004)(366004)(451199021)(15650500001)(6486002)(31686004)(91956017)(66446008)(64756008)(66556008)(66476007)(8676002)(41300700001)(478600001)(4744005)(71200400001)(110136005)(83380400001)(122000001)(36756003)(31696002)(86362001)(38100700002)(38070700005)(6512007)(8936002)(2906002)(5660300002)(76116006)(186003)(6506007)(2616005)(53546011)(316002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ajh2cUwyVFNBOGhkVndIUDVhK0ZzcGxrd2xOSXp2dGx5eHFMQUVCeTJFY2lR?=
 =?utf-8?B?MjVLajF4Q0JPY0x1UWhoejExZDJYU2lVRG81TXlHWUN5UktjUmkwcDFYMWRq?=
 =?utf-8?B?dmJITWlTVFFaeW9YVWQ5enhLLzdtemNHZkE2NHlNcFozN2VEZTVRQ0Z3RzBm?=
 =?utf-8?B?TVVwbFVIcVlUOGZPdTlQSXJXQnFjREdxU0RWUjgxbmtURmNoMmRJTmMwbXRp?=
 =?utf-8?B?RjZySlpQZDFsNy9IdHZFelV4dGxpSDZHMldUL3AvVlpNRGgvZUpnbjRYT2V2?=
 =?utf-8?B?U1FPaStQQkd2bnhrdjllNG90VTRlN0xmUzNBSmp6a0RNRTR0ZjNNMFJvUUpx?=
 =?utf-8?B?Q1VoMnN0VlI5UGpmaXNjdi83RUp6dXlJWVBuNGVIa0ZMOGZkNllHeHhDcDVB?=
 =?utf-8?B?eUs1NU5GVXhMekRXblZubjZMeGFtYjMzano2T0NKajRNZ25JY0ZUajBKMTlT?=
 =?utf-8?B?NktTN2lscW9ya3dhbHBoalBYYmlhMVZoY0VWcnpzeW5pMnNraDJnejhiVWtm?=
 =?utf-8?B?MUl4V29DN3pUbzMwSnlpT01mWjJ1ck1kODkySjRkSElTY2pGeW9kS3pUNUxR?=
 =?utf-8?B?cnMvYUtmNjd2bUlJY1NHNnk3WHNzZmhHTmVxMlZiWERLL2NqREIxakV1Tmxi?=
 =?utf-8?B?dlMzVDBUWFJZUTNBb2wvSnRrLzFEOXlHZ1JIRUlRblBlbVNFNkkxMUJEMSs0?=
 =?utf-8?B?bUZ6WFhjeHJ0YTVERnJMeDJTWTVxR3A0SldlNEJnLzRBNVl4MjFSbDJnTnl3?=
 =?utf-8?B?NGxyeXpHZmYwNHdQTEVheGg3eWVVL3RnZVRWd041MTRjYW52L09kdGZqTGE0?=
 =?utf-8?B?elNmN3BlelBvcEVwVWhLdEpDTWZxVWt2MnlYOUg4dHk3SitQWGw1TEdNWkR4?=
 =?utf-8?B?ajdhTkJoK2h1RVVSZWFlTHJWTEZIRlRlN0l1MVdxZmFXbkxtRlFKdjlzSGkv?=
 =?utf-8?B?V21CaGg5dHNZcG91R0hBSGNoRWpLK1hsZVJvaS9SMlptL1hpQnN5dk53T1p4?=
 =?utf-8?B?SDkxTmV0WTE1NncxcW5ONThhYUx5K0NCd1EwcXlsUU5MSVZpMWJpQWhyQTI0?=
 =?utf-8?B?RjlKd1A4S2svQ21aajBzcjkrd2gySG5ldE5odjBCb1IzaTVxbmhlY0FiNzl4?=
 =?utf-8?B?OU0wOEg2N1JKM2FXQUhCbWhNblN6L1YwZUN6R2x4eE1YY3NSZk9haFV1NjNa?=
 =?utf-8?B?YWFkcWRjWkZxWUlDUktKaDRMSjhxcUJIYTI2WEs5eWpQN013Sm5hTTcrcG93?=
 =?utf-8?B?K0RJN3dsaGZUVlhvTnFEc3dvbW4vUGlYdlhuaUJhNFhka1A0R0NRRWRrZlQy?=
 =?utf-8?B?d29zaitDdGJLQ1dZV0RZOWFRUzhCQmhudG9qbmlrejkyVHFWcjlxTjZWUGlv?=
 =?utf-8?B?UC9uMWRYeXAycjNtUGVUQWwweEo5ZC9QT3FGZWx1RXp1Qk5uSFJxRDlqUXF6?=
 =?utf-8?B?WDEvSFNNbVJIbldwUXdGdkJjY1RYei9YMHFONFhPYkZjbDZtV0lsYXNyZVB2?=
 =?utf-8?B?RW9pWUdVZTYrK0VWK1VMQk8wa2RJOGVJWlZxMU0vc3ZsbEFXenFBU05TMmxD?=
 =?utf-8?B?cncvU3R3ZWJSWmcyM0NlNkt6V1U0aTBCT09KK0JTTVZ1YzhUSERLdndUV1Z6?=
 =?utf-8?B?UUNKMUl3TXhGTlpJWUVrbWoram1teWZUR3pHb0doQUZCZ0JiYmZieFRtNE1m?=
 =?utf-8?B?SlBZamtVRnN5M0ppa1pFanJXWXBEZWdDNlJKMHdXZVd0ZWpkTkl0eFVlMVBW?=
 =?utf-8?B?bEljSWw0V01NMEpZb0tNZ2ppcFRsTXRDV2F6L2xveVFVMkNmNVVjMlRTRXZL?=
 =?utf-8?B?bU1pSDRSdnZaQ0JHMkhPYXdCMFpFREdvbWQveXdqc2srQU11SzJ3cGVrYVRq?=
 =?utf-8?B?Njd2TG54aHEzTU1pZXJQM2hrMkU3cEN1RExKVUEyUFVyMkJYVU1hdkUrUlBQ?=
 =?utf-8?B?TU5GQ1BPWnFsZkpQZGp6a2N5QU1GejhwQ1ViQ1JmR1hEQ1FYNjY2ci8xMEpp?=
 =?utf-8?B?Y2dEMmxURGZZTU9vb0hNZDZrQS9ZOHF1aUpHenpteG1ROTRWRzdrWEo4aDUw?=
 =?utf-8?B?L0pUTFByc3pUdm9Oc083VjRucEFtRGtBSWpSUDJ3d0R5YXl0V1NBNnh6S2pY?=
 =?utf-8?B?aTZFdHl0ZlRCSTc5SS9iRzBuVVZUbEsvRkZERmZBVGE1aERKNEdRaGtnV08x?=
 =?utf-8?Q?WsQ8dxhOBGBigxsyg2DfUlzQ5EGKDNvQcO4p4iwXGmqK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97F65E1EC396D0429519977EC9EF0303@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ebf256-2406-49e3-2f94-08db2e53fea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 23:44:09.2015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZFr5bhardP1zhv2GRAzn7K8EhYohf4XmXe6TA3q8C58YxHzLb99Jp8A/qyqbCR5cneMTMR5ivOqHt6Kvq5L21A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_164416_250666_77A36787 
X-CRM114-Status: GOOD (  13.00  )
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

T24gMy8yNC8yMyAxNTozNCwgYWxhbi5hZGFtc29uQG9yYWNsZS5jb20gd3JvdGU6DQo+DQo+IE9u
IDMvMjMvMjMgMToxOCBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gSGkgZXZlcnlv
bmUsDQo+Pg0KPj4gV2hlbmV2ZXIgSSBjcmVhdGUgTlZNZU9GIHRhcmdldCBjb250cm9sbGVyIHVz
aW5nIG52bWUtbG9vcA0KPj4gdHJhbnNwb3J0IEknbSBnZXR0aW5nIGZvbGxvd2luZyBtZXNzYWdl
Oi0NCj4+DQo+PiBbMTgzMTguMDUyMTkzXSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ252bWUxJyB3aXRo
IHBhcmVudCAnLycgYWxyZWFkeSANCj4+IHByZXNlbnQhDQo+PiBbMTgzMTguMDUzMTY0XSBudm1l
MTogZmFpbGVkIHRvIGNyZWF0ZSBkZWJ1Z2ZzIGF0dHINCj4+IFsxODMxOC4wNTMyMzldIG52bWV0
OiBjcmVhdGluZyBudm0gY29udHJvbGxlciAxIGZvciBzdWJzeXN0ZW0gdGVzdG5xbg0KPj4gZm9y
IE5RTg0KPj4gbnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDpiYjBhMjNlZS0wYmUzLTQy
ODUtOGQ4YS1iNDdmY2FkMTFmZTEuDQo+PiBbMTgzMTguMDUzMzY5XSBudm1lIG52bWUxOiBjcmVh
dGluZyA0OCBJL08gcXVldWVzLg0KPj4gWzE4MzE4LjA1ODgxMl0gbnZtZSBudm1lMTogbmV3IGN0
cmw6ICJ0ZXN0bnFuIg0KPj4NCj4+IEl0IGlzIGNlcnRhaW5seSBjb21pbmcgZnJvbQ0KPj4gaG9z
dC9mYXVsdF9pbmplY3QuYzpudm1lX2ZhdWx0X2luamVjdF9pbml0KCkuDQo+Pg0KPj4gYW55IGlk
ZWEgYWJvdXQgdGhpcyA/DQo+Pg0KPiBJIG1heSBoYXZlIHNlZW4gdGhpcyBiZWZvcmUsIGJ1dCBJ
IGNhbid0IHNlZW0gdG8gcmVwcm9kdWNlIGl0LiBDYW4geW91DQo+DQo+IHByb3ZpZGUgdGhlIHNj
cmlwdCB0aGUgY3JlYXRlcyB0aGUgdGFyZ2V0cz8NCj4NCj4gQWxhbg0KPg0KDQp3aXRoIGxhdGVz
dCBwdWxsIG9uIHRoZSBudm1lLTYuNCB0aGUgbWVzc2FnZSBpcyBnb25lLg0KSXQgd2FzIGNvbWlu
ZyBmcm9tIGJsa3Rlc3RzLg0KDQotY2sNCg0KDQo=

