Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB1AC00140
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Aug 2022 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TsXOVc0HE9dZm3Q3ExbVYmkga2zhdZ6GZjyyQSsh3Oo=; b=amn4Al6PPLVP/jX0SuawMpX/FE
	Yx27mccBIP666bKI0XzuaHpNrO5SscX221L11FBjAsRov9hHyCqK+XE0fNpznbK6iiKKDXuI/Io4q
	IOwpt19QNi+oMZJVxDOi8V9yUKpo09G4et5/ay2YOKPn7FuqS6AbdT23XfsoA9uyZ5T8v2fK8VQMI
	wMpau6ckYmspphXNvkERPdpPEesMPjqtSsJNoHNFsFwDfDLMWxT7Qh7J7Bm1AYXjWJD3SEwAU3suP
	tXeMSFxBzUNoybPP2kIoeUCz/ofNVqZwRWZCyDN9iSqatiLreGWObVmhIhJE/I48maOOoaBPzTSli
	3HOgDPdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIkw0-00AmVO-QB; Tue, 02 Aug 2022 05:59:16 +0000
Received: from mail-mw2nam04on2085.outbound.protection.outlook.com ([40.107.101.85] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIkvw-00AmSS-Np
	for linux-nvme@lists.infradead.org; Tue, 02 Aug 2022 05:59:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZhZwAZZmVHiYmSMxBKWKidcqW3ZojrhQ/aqMDC64s8+Ounx6pSCzOJwyzhmstQ7/FqQgVkn7q06KEC7L/UFkbBIsVuxhQq21sUXkv3jcPCTpYvXE+WmpumdD8xrNOLmnypvIiRW76izG8esNshsgL77JH/2f9pX+cFwIEqdK4Y+ZoV7sZFEXTfl82K39+HyCgJ5G0zcO6Z62BbThWvL+Rba9uOCJa/kN4PIXfFG9DTsrzxvMwDvNGMnbVUzQG47bMrCUXV+1MqqEOQcRROdkKVyNqSEt4/yfyeRik+DxDMHcRikkTXEKO1ZYjM3Z7rGASOsD4sHLTdHQqwDNIUX7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsXOVc0HE9dZm3Q3ExbVYmkga2zhdZ6GZjyyQSsh3Oo=;
 b=nZgI7WyyBdYGPJogtumEsIzYtEsdwqjE9qBnhpUksyCHJgDSJa9JUo1btCqHddICp3qaZV/fuoaglSWnvR6KcUqWm6d7R3hbpqgS18nZD4NpqI3hUF6PX6wZpxngr57RsVC63m7UbE5nsHTyQ6Q/Mdpk3izsrtNHpQFZH9c3b5dFhryBm+7+WTWaxi5dCaHjKAeTjZQnwLMuYYit4NgQ1aJelH9GSFkwMIZGAeud1qdB7nBJ17gwA03/fVPjX7xVBzBS4Gcjp8dLtOTLt822B7QDPmkQei3dkc0Q5TxeLPjM6aFHgY1VCj8/YYdnpAQz1sZnpFyqpWo8+Xm0nuPtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsXOVc0HE9dZm3Q3ExbVYmkga2zhdZ6GZjyyQSsh3Oo=;
 b=o8oZLqYzXPhmeaC2J+kktzoLnARy4u5e8E7AI+AYCJcbbm+oyh1Syopfs/zpGXtEWOhhc9tfr2Hu+i2Q7lgl6lHJ7yQjoIu+9l92RyX1zgFiucVVg2PG9LpDsvMcjlw93ZorDS1dVAJ50FeXPVLLD/NyTmVnCsNX8uTCo0N72cJUCxP3e79U6TVbbyQRMXIGv7qOALmq2/d2BfOMqGOvFCnspS9rou2A9TqX0R4hVVWR42EJsMLKCtH7fPWO+07yLrh+mGo1sqlz4EOdCsqCeiTXMS/4Y5yoXVhDpuYVghF5zDMhpnZm594UBx5Jmdn2hfjhepEMhrB/EPeEgz3smQ==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Tue, 2 Aug 2022 05:59:06 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5458.024; Tue, 2 Aug 2022
 05:59:06 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/5] nvme-pci: iod optimisations
Thread-Topic: [PATCHv2 0/5] nvme-pci: iod optimisations
Thread-Index: AQHYo2iBR0YeqSlnJ0qhdPZsjrLJtq2bIyEA
Date: Tue, 2 Aug 2022 05:59:06 +0000
Message-ID: <28caa98a-d1c2-f29d-0688-34bae09a7656@nvidia.com>
References: <20220729162851.1574210-1-kbusch@fb.com>
In-Reply-To: <20220729162851.1574210-1-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 914fa08c-1c73-4838-632a-08da744c1c20
x-ms-traffictypediagnostic: DM6PR12MB2985:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  SUvNE21ePQTvC/HXDmxV/4JTfWeHtw7H+bOPeOQYSBk0laXV6hkxd+r2+gKIIT8E0RO1rb2LsPolnF9ruS2/rO+GpjxHkl5+dj7cAqSAot0GFcKyQ0woCXZNqH8XfRuLWH7inaOATgNDNKJaMv95Xrcxcoc3ryyQxrQ58ZQsXTsnE9A0Ylj+kCmkOW0cXVnCctwJ0KfgIEcquH1D/xhgKYZT5m27xDymdxEvXP1WV1zsFWEtGT4IlHGBfl2s7KjgLbW83tB3r20L5qkX07rKQfwmVuSyx4Zb9VrDqElWzaFLsWInDnXniWHikIQX2SNJ8cP7d2S09GDT0j2oTEGVR/QL/KuPmGduc7T5L0hfn9k1rIwrvWAguDORblaCFaa8iJXYza8SmvLP9BxNWd+NghRO71ii21bDtuuUQZ2quBNNAL/RS/22/Nygs0OQXawHnrmDhCzmTzcCUXJ5dGS6xwt0MIXENhYAWSm95XJ6WT/TWDuKNWLdKyMP75O0qRv7a+Sfwy1QtcKBQd8DYp9ARWf7Lx/s30Ry8IBok1ZSjFGy5aZbDzgxRcWBy2pCOzMPeMJL5uSmuAgLEnArFXXwLSzTpiKY5vqJyO+6iJKXCxiU+6xQzLno3KrQ4HW2dOUysX3wqLbTchKVEARQ54ICLOnuybH7Vap2rbf1QX3L1W6cpbrAMbAsKiX6PmNimap7Yp3oiooMU2qyneZoKbVZ6rSBtADT3+n3kuuhD+TazADGiEC1vdVEh+c1uB+Nft1LvM0tZmBhJYX4AYRhKA4OpHQHwpAfaTLD9exA2EN2+EOKanukKu37p3qS8X0eKqLHp2xIRoP+Rf8ysQ9XQlJAadE4lZ+FJfj51qlxS7O+3wI=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(53546011)(6512007)(86362001)(41300700001)(31696002)(6506007)(54906003)(6916009)(316002)(71200400001)(6486002)(478600001)(38070700005)(38100700002)(122000001)(2616005)(186003)(83380400001)(4744005)(5660300002)(91956017)(64756008)(4326008)(31686004)(66446008)(66556008)(8676002)(66476007)(66946007)(76116006)(36756003)(8936002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?M0w0dkg3UmlxYTZMNVZEUnVlaFpQN1dRM0RBMUcwQTZORXNIcC90MVl5T0FB?=
 =?utf-8?B?RCtSQU5yL1lmaXlibk52WDRKbmF1Z0tJR2pKemhEVTRMc3BhNXVBUzFDNXQ3?=
 =?utf-8?B?N1lqdHFYUUk0QkFES0dIMjBsUmtxQkJhRjRDcit1OGhMQzBJWDF5S3lheHRL?=
 =?utf-8?B?UytOS3dsbFczY3hxMkw2UkpwTHNoTzk0c1NVVkhpNUdaK29POUFYZnB0aS9W?=
 =?utf-8?B?cFRpM2JMNXY3N0V2UEZzZkxZZlRxTFJidWRoVVhZVFljdUUrUmkxVEQxMllK?=
 =?utf-8?B?a0U0SXExbFg0MXhncUJCdkl1eHh3Y09Lb1ZjUGRjK1hQcXE3cGx0OFcybzFi?=
 =?utf-8?B?bm53ZFcxR3lZV2VTeWVmZ1c2MUlFdGxZYjB3RGNPRjZIUjFubFVXN0ZBd3d4?=
 =?utf-8?B?eTk3UTNIbEpSUHZtaVBPNWJQTzROWG9PRDlram00RzJudURhNFM0L0ZZaHBB?=
 =?utf-8?B?aXdYOXM0WmZDQ3RNeHdkNTV5WUlsMGl3L3VYZG5uRCtuZWtVajB0MDdKbHp5?=
 =?utf-8?B?VE5CZ2E4K2pqNDVGVmVKMlZ1aGZNZk5qaVZ3K09oczVmbWNPUUpzVWI4ek9q?=
 =?utf-8?B?UVVLNGpKN1JERW0zOXh4MVZoWjJ1bHlzRE5uNXZtQm1HbEx6TjY5V044MHNP?=
 =?utf-8?B?aE9YVDlmcFZkRkt4NDRVRVRCZVJ3ckRtQmdYKzlPZHZKc2hwWmpxaTE2WkF4?=
 =?utf-8?B?SGFrOWkyQjZ4L3BIRXlkUFo2UHJyZXZ1R1Z1MVA2cTEwSE5oVG51MzZ6aGxx?=
 =?utf-8?B?SE9lYmpEVkYrS1R6T3ZoL1pqZEJLUjd6cTBlVyt2d1VQRWJKMTlxUENFMjI3?=
 =?utf-8?B?ODlZUkJ6ZWUwQVVXeTVYdk1QWXdWT1VzUStuZzlvVHpsNEc3aDF0Zlg4cjJV?=
 =?utf-8?B?Skg5S1dGemh3bHk0b0hOYVJwMWlFdlVnLzAzRDNHNWwzZmM2WWx1TFI3RDJo?=
 =?utf-8?B?aWVTUmhKRkdOTWliK0FMSmIvZEVLWkhYUEo0dytDRXJ5Qi9vRlA3ajJSSlds?=
 =?utf-8?B?MlFlMUttaHRaMHpIeE1JcWlURHh0d0l2cjZaSUNudzhIam5UTWF2UkEvWTZH?=
 =?utf-8?B?dmVIK1U3dGo3TTlQVzB1Um9RM3k2VzE4MXVKUzNmVkJiRmNZcGprM2c2eTYz?=
 =?utf-8?B?eHR1TEJyaHgwYmk4VWN4T1Z6TGMwV0hTQXVoK2pDdEtTWlkxS0NTcjVvVndM?=
 =?utf-8?B?ajl0SVR0bVoyV0RqRmI0YmxwWm1scTVHdXRRaFVnTFJUQmppc3JNNHdPckx4?=
 =?utf-8?B?dUtkRXFnT1dkcG9rUjgxWGovbUpjS21LbkFGQmFRTUJ3NXdkR2JhOThPR3R5?=
 =?utf-8?B?dmZtclg5K3M3VFBEME1IWTJhOUtMcnY2eE0wNHBVSmY2VlA5S2VuMCtUZGVL?=
 =?utf-8?B?dzBQdFFMeTBXNTVKQXlpdUo2azJxYkx4UjR0dEhFN1JDOTVDTzB6dFYyemRw?=
 =?utf-8?B?a05uQ3IrNThOampRaGJkR2RHYTAzUDFHUXVmMTNLaFg4TkdxVFNGQXZOQWpY?=
 =?utf-8?B?SXlsZ3R3RE8zQW00L3BpZkl2akdraFIvR0xZVCsxcWJZMzJmUWthKzFlRGJI?=
 =?utf-8?B?UkxZNGliUnl0RlpBRHFQTWdoOWRtN0xCU3gwUHZLeEdFV0FJa1Z0K093L2k1?=
 =?utf-8?B?eHBIQUkrRVB5OXFmOWpySi8wUVExYUJWRkU1TzI2SHN5akUwaHlFWERYbEc4?=
 =?utf-8?B?NjIxVXd5MGxoQjVVNTVEV1JiNi8xVS96dHM1SVR6eWNwN2pLQkRJSlNTaFA0?=
 =?utf-8?B?TU5SQmp3TmZ1VkxnYXRmNkxGZkpBdFE0aWxnaCtjcy9hUlNhcXNNY2s3OG0r?=
 =?utf-8?B?YmUrcUpsSXRZUjNhNHJnNkpMYzBqV1ZUdENMT0tXbXZBbXJycktkQzFOTm0v?=
 =?utf-8?B?SWR5WGFOajhuVlEvd1RhanBRZDQ3U0FXb0ZLeVRjVVUrRHltcnJKSjlFOGts?=
 =?utf-8?B?V052akFIWUxhVlY3aGpZZUdtMnI2NEoxNzNyQjZWNHpGT3FQZ3p6VGRQUHNV?=
 =?utf-8?B?disxNHd1T1NqUEZjNFFXMmZMQmNVaG82NWxsZGY4dXR4S01VRFlyYkRueTNF?=
 =?utf-8?B?cXNPc1dCU1NaNHZsajU0c20rUFVEM2dRS2dwTi9meDhpS254U0xXNFhqd0wv?=
 =?utf-8?B?TUQ5eW1UTWxHMDJPNitaRHFUVUt1TElxRUswWG5xZjBVUXd5bWVTakZiWlhK?=
 =?utf-8?Q?GTm4wfvE9mXwD7a30Pd81edu6L6CoWR7iPVCbl1jaI+D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <173E6E92D83686499FE35C5404CE818B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914fa08c-1c73-4838-632a-08da744c1c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 05:59:06.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mFyT4FAmV67EFU1cX7frXM7ndR2j2IL1cjwDYWnjuRGCM+naVF8Unmrj202rfx+pFaVeQzarnX6Qwd9oJHojdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_225913_365861_5B59F6D6 
X-CRM114-Status: GOOD (  10.68  )
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

T24gNy8yOS8yMiAwOToyOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gDQo+IFRoZSBzZXJpZXMgYWRqdXN0cyB0aGUgc3RydWN0
IG52bWVfaW9kIGZpZWxkcyBmb3Igb3B0aW1hbCBzaXppbmcuIFRoZQ0KPiBlbmQgcmVzdWx0IG9u
IDY0LWJpdCBhcmNoIHJlbW92ZXMgMjQgYnl0ZXMsIGZyb20gMTUyIGRvd24gdG8gMTI4LiBXZQ0K
PiB0eXBpY2FsbHkgYWxsb2NhdGUgbWFueSB0aG91c2FuZHMgb2YgdGhlc2UsIGFuZCB0aGUgY2Fj
aGUgYWxpZ25lZCBzaXplDQo+IGlzIGEgbmljZSBib251cy4NCj4gDQo+IEtlaXRoIEJ1c2NoICg1
KToNCj4gICAgbnZtZS1wY2k6IHJlbW92ZSBudm1lX3F1ZXVlIGZyb20gbnZtZV9pb2QNCj4gICAg
bnZtZS1wY2k6IGlvZCdzICdhYm9ydGVkJyBpcyBhIGJvb2wNCj4gICAgbnZtZS1wY2k6IGlvZCBu
cGFnZXMgZml0cyBpbiBzOA0KPiAgICBudm1lLXBjaTogaW9kIG5lbnRzIGZpdHMgaW4gdTgNCj4g
ICAgbnZtZS1wY2k6IG1vdmUgaW9kIGRtYV9sZW4gZmlsbCBnYXBzDQo+IA0KPiAgIGRyaXZlcnMv
bnZtZS9ob3N0L3BjaS5jIHwgNjcgKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25z
KC0pDQo+IA0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K

