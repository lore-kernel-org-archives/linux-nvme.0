Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1FCC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 00:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5A4j7FkinDRkoHfKlEOHHJZRHBtycSyI2cXSjgovYZg=; b=onGCWTNalmzMsFEHTLBssyRQ9v
	mEVKFiroVgsS/A2oNOJN0F/Po04ORlssDOUowkuaGd6XV6Eiiebyn/wcnydLrtBpQLAy8sGvBdRlf
	/sWUTLMyM7B/KceZZVFQFB/ZZxCzuXdr54nGLGtv87Gsi/4anucswjC12hVaKFs0jY9Tsb0iHFFts
	I8c8Cjd4sFfOUcrW+62fbW274RHEZQN6KyZsBi5Eqg9LdpSJGPENffoNIqeppSCGOLjBhuZrafMkh
	5o/BvtSRVWBlhdYPObE63JDMYkeC4ErCWWjGYRegBOAvffHT76gcIyB4FSatnduW6HjIt948nUJCS
	ZkmVxWdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouk5a-006SXW-DG; Tue, 15 Nov 2022 00:46:10 +0000
Received: from mail-dm6nam12on20612.outbound.protection.outlook.com ([2a01:111:f400:fe59::612] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouk5Y-006SWs-4O
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 00:46:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMTSA42fWOCRw60Q5lDDLKv0p8NEEtqcQMSpZL4enaR0SjZJZTlNYZVsFeC40iMXGTgzKzexyO5EUMjf/Ey8qNJIJgPFB2azOgYBiYfZVGdENn7kTZFySbRiGXhTxyD9MoWR+OWi3rIi91nzL7C8aOnvX4f5yWv6bKB75Cm4pqqwU4fk2uPMsy13q31E+ZX11Hj2HAohaAQXOC5RMnh51ZwY47CkeCY7UknPNHN5z3avgHfx3ezUvJeyt0f2n8dEZKwHzkusxuefqrnRfHP5ymJ2ShMFv0Rn/bpeRfxRzajEalgsfcWJpl5ZtW0i+N3k1s8o+Mi2mlrlKE1a/lCaTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A4j7FkinDRkoHfKlEOHHJZRHBtycSyI2cXSjgovYZg=;
 b=a55QNJX00T6yvrSIbG4z8PbzruyuqLWDrQjXIHi//FIkr4Ow6AXuRyb6uKy6fLTZhffREbHvzUMJyAMOfyb6ACqcxQC76anaC5dDJP4oV4hMmXnthBD8M0a99AfXMcw9ZKXi0PtJrdCv8438kqIDRk1xFblg5QdIopTz/9HFFkxiKRsCk/cZTbPMyLCGQOqxEOifxhB9wpjjuI6tQeiafSFNwVKLtNGZOtTcXxpUw8wpHffoSt27f/fYlV0FIJuj0NR6Pstmr3ITGlMUBVZEbheu2ilO1Whal6gGsMNApVZAKKsn3z0vreUe7xNbxpCtv9PKaeKK0Om+BT2LDU1Y1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A4j7FkinDRkoHfKlEOHHJZRHBtycSyI2cXSjgovYZg=;
 b=HoF3X6js9NyYRTmxhwz5c5Dhm9aeSJX3J5Pj/yIWN2F9yQdUIEQ6Am8dGfTfAwRkkzSwgglt+DBxKkI4IwA4xXAmrihltBKHfPfmrvVCyMvGIs2JBM+Nhly7t2ThMjstTCUc2PuWXpNqULUMXqAkaZ+lpYaKyXExFaDdJf3RjHx6scd92uyWCMC4OitbFIIxiNezGc6pb0/UKx28XTcGyMs3JReVolngSBwnLUXj+hvSk+L7PdAxIotRvcWOCcKk1+v4ndYeiOM56W+wd6moOzLf281iaImO5JKPSKFVQfrOMr96usLMJXt5rwtz+JRpp6x+k3cXlq7XeBzI5TfEoQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5095.namprd12.prod.outlook.com (2603:10b6:208:31b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 00:46:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 00:46:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Uday Shankar <ushankar@purestorage.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>, Guixin Liu
	<kanie@linux.alibaba.com>
Subject: Re: [PATCH v3] nvme: avoid fallback to sequential scan due to
 transient issues
Thread-Topic: [PATCH v3] nvme: avoid fallback to sequential scan due to
 transient issues
Thread-Index: AQHY+IizJhp43t2QKUqerpvDVxuzTa4/JjWA
Date: Tue, 15 Nov 2022 00:46:03 +0000
Message-ID: <4341ec12-338c-3cd6-42f5-db1b66c974b4@nvidia.com>
References: <20221115002357.3949804-1-ushankar@purestorage.com>
In-Reply-To: <20221115002357.3949804-1-ushankar@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5095:EE_
x-ms-office365-filtering-correlation-id: fb83c682-1a74-4a76-24a5-08dac6a2c617
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  dYjZ62wMtSyYxb9O7Pbm3YXdXEfws6yPcHuhKxOQvq6yi8wxHjlVry9ulEKphqWoPIOFSzAGMmQYXrtrBImaDlUPDx5NTNPwsyFFyARdx39dKwxJ0NcluFqGznifMfCfEWFtHabgSJPUOIbFVOrpUs3BRhH5WLqKVwb86XUm5ppcMn8s4igh0rrNexzpxsxTcKW3N/1tTnrmKfHJxqEAb7Q5TkcdfGeSrG4YEpXTe3RDtzyuq4lQ8MdDv/p8YCUf6s+laqY1jfzgSSPQBjZU0ftk2O+J5ovHCAwT8XRSvnr9I5y6t+FdpRMU/L7tVgpE4FNviiOOurTPKYz5acw4TPXh60X9JuFuyHTE7CP9JVX9cC3T/hj7zbvqic+1AM9INSidIPXdYzYf4rQL/t+BUVsBMujIGdf2JElRTKzcl+EWPY3AHVov8Ro/ugQ+UdjHZ14TWO3aApScFdo+rWBCYI6DmeWXK4qK4P2RA4iRWahhVwfobtTUYbzFite8gqQNmkvASHEHZ2BW/knO5chFAVE/KVUKbdXVYslL2cQkKmAlSYhoM9m+n8dvNWEGmMONuefVKZ6/iAEvcGCfJAJjp5SO1aH8QsuhEYgNHNIHSeDOjQe+b7SluwzmTsHt2gtlnKEwCTELhV7MScZWClTpx3/z5l/HdxjkgDqNZd3VTmjDdh8H2uR/F7o9vLRNusY5s3q9sqdsx8QSsY/dWievN5uXVoho5MOG9ZdSefVDjcp3h7fl80iIyZihOJETgmlycDEZV6DeDQXiH5VqWAb3gmYy3Ep7KdZz6yTBC+Qn5IH704/VtvxeZoKFWpv+miCMkxlniiCfW1l1oV36P00hpA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(31686004)(2616005)(8936002)(38070700005)(478600001)(6486002)(5660300002)(558084003)(2906002)(122000001)(54906003)(36756003)(110136005)(316002)(71200400001)(64756008)(76116006)(86362001)(66446008)(66476007)(186003)(66556008)(66946007)(41300700001)(91956017)(4326008)(8676002)(31696002)(6512007)(38100700002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WThJemJvalFyQlNwVjZSaWJoKy9EUVlydDdIbDkwWWhiTVJCYy9WS0JyNFdv?=
 =?utf-8?B?VVJCajl2cDNFRk1OV09KSytFbVhjVzBEc3ZZNERVYStKTTZnR3h2Z01RV1gx?=
 =?utf-8?B?RnJRbXdTaVRLL01rYWtwd0JBT3NUdkVlOEJud2k4NG56cS9rRjVIK09TN0lN?=
 =?utf-8?B?MTVXcFZtcGFZS2U1L04wdjBzdkpaSE51dlZRWGhRbHRGZFNMbEEyQlRLcUFM?=
 =?utf-8?B?blFTQVJyODZwSzRISzA0UmxvTWRFWGhnZlBqVnduRGxLb01yVkFDelhpN1lB?=
 =?utf-8?B?RWszcHZIc1MwUWV1T1FGaFpNbTlQY3dHYmJsQ2Rza2ZWc3B0amp0dlRSSzVS?=
 =?utf-8?B?UjVab09PVXF4UDhBeitjS20vaFVSbEtmYVIrcjFKalRVR1lDM0NpaWJSdldY?=
 =?utf-8?B?VmlHK0dvdGxNNUlpVWRtbXdhM2ZaTlNlai82bHJFTEZ5ZC9VbTFPK0VuRndB?=
 =?utf-8?B?V3doazVwaytEcVZtVDJtUGZHUVMyUDdIOFlvTnhWMGRaV014ZFBwMmp6d2lG?=
 =?utf-8?B?NDlsQXgvUm9uclFoaEszbHRBanVzZVI2bU5teWl6WEtEcnoxWS9KRS9vQ3Jw?=
 =?utf-8?B?Nmt0b2VUR284SzNwbWUrQmgrdHZ6NTgwRmtQWGhNMlRIYmdTMEZEckdSdkhY?=
 =?utf-8?B?dE5KTWlRUUw1S3JtOW1FNGpPOUtkSzgvY2JiTHoxaFR5SEtiazg2K0V3MXM4?=
 =?utf-8?B?VFZFNkdVY2Q4OUQ3Umhvalh4TXV1cjdVaUFLNXIydTlqMFptS0hyTTVCL0t4?=
 =?utf-8?B?MUs5Q3VCbjlWWFhjTWt2LzRFVC9oaDRPcUV5Yjd1RG8yWjMxaStmRFhCaWRx?=
 =?utf-8?B?NVdYQkhicTF5czFid1lqU2FFVVIyclV5eW5BY2JvZm8wbjB4RVdEWFljQmZw?=
 =?utf-8?B?K1pqRE96a0pxMXVYdjlQMVczSENuVDRwS2VCM3VORG5QMWsyL3pHWWN1WDdY?=
 =?utf-8?B?VHVPdFUzVzZqZzNNRWJYSFE1WWRkakJEcE9ORkp0SUh5UERIZUloMW9QVzlq?=
 =?utf-8?B?YnNDczYrb05PTEhRc1pCY0VQMVc0bWlQM2FDNUZ2LzUwKzZ6Z0dxSXpOZERx?=
 =?utf-8?B?cGU4cU9xd093UlBjaUFObk81VUVKQXF6R2VjZTMxZlhVbkFiYzBxOXFCMlZy?=
 =?utf-8?B?aDhNSXpJalpQQTN3TTFzaXIvTGJjOUQwU3R5WlZnVFh6Qk5PRGJYOW9zZWd6?=
 =?utf-8?B?SjlmNFVJdlVrTXg3dHExY1BJR2JDSGMzUytZMGJ3R1pQbWRUZzNCT3BZQ2lo?=
 =?utf-8?B?a1hoSllHdjNtV3A0bU15dnVRUHNGY0U1MUNPREVjZlZhMG9RcFNqS09NemVX?=
 =?utf-8?B?RnVyRTZiMUdUTGwrOG1ZdWxremhwKys4OHBwUFJhck02d1BaSyt1L3hIMzl5?=
 =?utf-8?B?eDBuZHpNSHdZZzVhTHhBazhIb3lKSW1MdmtzYlViYzdKcS9uckR4ZzV4RWVW?=
 =?utf-8?B?MmpKNmFXUk5OQ2lRUVJqWUVaVDFQcGZ1RTRBblFrb3htRlV3S2VZeUhjVG9m?=
 =?utf-8?B?Vkw5ZjVSRGx1MWFOU21PS0pFZ1M3YWVjZEt3L1F1ZkQ0c2dXS3Arcm5sU0w4?=
 =?utf-8?B?enJ5U280U0JSSVdXbElhNnJrNUlDU21ZRDBzMlVHand5Yi9TVy81UE1GOGM5?=
 =?utf-8?B?bVZiaVA1L1VodWxjRlR0MnNkRWpuQlp4b1RZeWVIQVlUQ3A3UHlybllIazIx?=
 =?utf-8?B?c29qRVJKbTR4OGdOb3lzZ0V3WFU3QXpsZW9xdEtEbm1LMDEwNW1SOHFHaVZj?=
 =?utf-8?B?YXUreG95eW9kSjBhQm9PTGZCM1lYempxeTA5c0V5WFd2emhFTDRyQXo2SHMy?=
 =?utf-8?B?YzJ2NTlsTEQ2emQzUVU0VFlXemNPRDdiVFdIbFpzcjQ5cHhMcVJOeTV3STVF?=
 =?utf-8?B?YnFhNjJXR0Q0TVJqSWs4b3Zicm1LTHhMVGRGMk84NjBuSWVRbHhkRURXK3ZL?=
 =?utf-8?B?dks5QnhrNHBwNjFOZFczQ1hZOXV6cmxYZHNCZllsZHFYWjlHamFhV09xK3c1?=
 =?utf-8?B?Y1VsL3hXNE9VbTBzMnZFTy85OCtteHRHRDJTbUxISGh3WkxuV1RoNE9BbXMr?=
 =?utf-8?B?L0pVaUpyd0dtcmNJWnJMUjBSTXJaSDhEZVY2L3J3ekxRaktEQUJxLzRHMWVR?=
 =?utf-8?B?SW0zTnp6dWd0TFd5em9FTWJJdGhwcVlnVUowNk5CK29JaVdjc2ppZVZYNXBo?=
 =?utf-8?Q?KrydZOwxu4pHkhUOmuIS8rsQ9pT3VkQKpVm56yb5eERI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E77447457733A4388299E3D18243DEC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb83c682-1a74-4a76-24a5-08dac6a2c617
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 00:46:03.6441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y58k+uU2WWzqufopVG5cRcMyFWmKAK87d9Xtui07oLilz1yNacOYPjU/Y7AUtsaP7wJvb8ULmiuajuZrw50XAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_164608_192679_CF759645 
X-CRM114-Status: GOOD (  10.30  )
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

DQo+ICAgCQludm1lX3NjYW5fbnNfc2VxdWVudGlhbChjdHJsKTsNCj4gKwl9IGVsc2Ugew0KPiAr
CQlyZXQgPSBudm1lX3NjYW5fbnNfbGlzdChjdHJsKTsNCj4gKwkJLy8gZmFsbGJhY2sgdG8gc2Vx
dWVudGlhbCBzY2FuIGlmIEROUiBpcyBzZXQgdG8gaGFuZGxlIGJyb2tlbiBkZXZpY2VzDQo+ICsJ
CS8vIHdoaWNoIHNob3VsZCBzdXBwb3J0IElkZW50aWZ5IE5TIExpc3QgKGFzIHBlciB0aGUgVlMg
dGhleSByZXBvcnQpDQo+ICsJCS8vIGJ1dCBkb24ndCBhY3R1YWxseSBzdXBwb3J0IGl0DQoNCi8q
Ki8gY29tbWVudCBzdHlsZSBwbHogLi4NCg0KLWNrDQoNCg==

