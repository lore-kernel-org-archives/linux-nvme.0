Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8248BC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P8lrlitSdrJJwq+NNyXysT1SBiotVgLJ9BcrNLyCWL8=; b=eJNuPVtPIpjoeFOo5Dob0nFGpq
	HYH8BfFQo24/cq6ojgUU5FodHohH8O9ftvQJhFJhx1/pCNgGsfY87CssFeuCd5qBmq6gySXEsEo9d
	jDNZnZ/Cw0OZQp63nOXJEZnmE2IBYa48jkbDyysTHQpPJ7v2hw56H4kP9FdiNEr/3YFwFuo/QqZRW
	CkxToeTeA5vd4cgnD8HG/c2WitY2yH3Vfb5y6/2NwmbbhSpgmXGLdVp7LKc48fXBttQqpvlw6VXdH
	UlM/zmI0vpZZ4RJD52MagaqNk7bSnmeLM4wsoSS6PuxhCOqsqxQxjOnCdewQMdnAVIOyo9uzw8cgo
	U9gOHsUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal4I-007CJM-7x; Tue, 20 Sep 2022 21:46:14 +0000
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal4B-007CFT-5w
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXItNPpsGamvdIBeWWJdkzK0RM/51Uopy3r3WVdWOw95DsiNX3rNJEtsXmwGmAVGGECSmti61SODlSWSwbFqbqlCRltAboPEhBjA72I8icQ5gPPfCW3h7jgLRi4IamYYPsRj8O5KKdCuR9eCFe81CubSiEIhl8nf9mQpsglgyO8Rhuf7nk+fw95jAUXCUChMTJ7zlNfNg4D/5dxKEal8RlvlKshWVONg7IobURVBwD0x+dBSb+1nZ4PGkA1sNZ6n9V3EfHpfvU+U/pdIu9h5ZCCHHTA11pOJg8qi4jZwKiw9+o54DCJZuCRezoP3TvVSCOfNZJ2k297kPigLnDB9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8lrlitSdrJJwq+NNyXysT1SBiotVgLJ9BcrNLyCWL8=;
 b=Bmz169Nf3h6huoOje1PIm0upJWbbjfzR+viXPOK3KOpTdkFMM+KwXbdgbUuW48x5Lu4o99GCkaND/Mce6Og17dGMnLzT/ENmGInUpabwmE7DDrDlkFHOlLYlgNIeIvgoOEhhGjuxuiqyM5tLqEDLyrMrFDZw3oIua17I6TNxkW/NhYUono3sJEYKkusyURCUBgDmHnWpQbuzHaN6//fZcwcTG/27Mu5oxV4W5wqYCzpjrfdea0Y9N1YRHQogR0YuNOZ0ZQsUgT7xOvjFnKbZ/EoKOxxWyZbos7dWpHzTxxVXtRUtHeVyRvF+SemriR47/8y5xaqHhTmPXJ8Vdb4eVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8lrlitSdrJJwq+NNyXysT1SBiotVgLJ9BcrNLyCWL8=;
 b=ZKX1PSHsAecdZWyy2CWhZyD2+qyg90P7eEM3CEJ00NwgPaB+1OyQ+06irQnkE9EQjA9v9FPzSBNEhmjux9sdMF3momvK0L/oBkoZ2+fskuAb4fNeobkDjzJlRcmjvf6IUYH9TgU2LL/eUUCmcWJ9VVAReIrtBYbNYg5snTN9zTD9oIgeK6uuAvXS9kBbw1zvIqBtOjYNMW/auECLWFhShGkSFriUXk52f1buhDB3hKDlbzKacAXFBmbYHLWqR4zKt8dVhWkTaY0AJjBJFJsGt5mhC7MxCKcDsbOhOzjBZM6QM71m0nXV4KnZEVxd30BaQnHwBXrP87AAH8aTlXMulA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 21:46:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:46:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 11/13] nvme-loop: store the generic nvme_ctrl in
 set->driver_data
Thread-Topic: [PATCH 11/13] nvme-loop: store the generic nvme_ctrl in
 set->driver_data
Thread-Index: AQHYzRT/+T752WvzBUquy1alxR7wBa3o2piA
Date: Tue, 20 Sep 2022 21:46:03 +0000
Message-ID: <d965a3c0-10b9-7799-cc57-31f7057b3c50@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-12-hch@lst.de>
In-Reply-To: <20220920171611.1289361-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5052:EE_
x-ms-office365-filtering-correlation-id: 026b36bc-6b15-4e5d-eede-08da9b5183fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  w0KSWGz9WRBcDNjDpJbwFK+6PDRRCXZQwXG1Z38muaqVf/MsOpv3XJTRRda1Ih7Klh7CmkTcg3Yef0WX2QORJdfpJu/1wDH/1gVtq7ozU3sfCdlOgDLNkMS+7YzGW8fpNYjeRLgmkFsMkhEbdcLKs+yehB1tT1uN9zxY5/kxI1tKY+divONwPfqXy69C3DxJHjyiyErGBI4vA7cZl+kfA6z0JwWo0Q/PnukxcP2uSGDMqNKHGeJNQboZtvYUIvu/ZSIKqBFUAqihRThMSfZMXW9GBC5Zk+bphIuVV1ra9hycVVzapmk/FgXK5AZ12EBp0ujTkaPqT0cnUy0gKVea1SxwbAxtle6Ek/Ls0eppUyCftvAzjR34TZRbf5G18SyuD8VLtmtW+/dMGRCHp+r5f5GliqIBdtR6CX93CrEFUXRZKlnkwg3N7ReoCy2KRowWEkOBS89vtDK5JbcyAVjJcAcNgYvMK/OyU7AEWdAbRKEqGFbFblrvWo8Hw39UbUJ5ERyMBxptq9J7XI4IJNz13CoaCLvEdmmdYzaCtaYZ/c3QCvWgHw2uit0/r9cqFuoj0YCV3BWYOd9algRY3GILBM3LKr1DWdU6eAZlrQ6EJpaZVGrifB8knZFzzGb3BCRuti78kGrJPYDcbeGeAuf5KZmXG5z4WAtkI63Ca33wSuqkuI65S61WPkA+IkNkBDwMB4S9tCzY8CCo6hQPrUChWb3dR/FSe05LADFiCJjbX5qwL6KMlJcAyLiwpb9LAE2IMQKTYjRZ7t6Vx231zVIVeXH3wy+yVuCHG/noOnjic5VKHOYfK5QPfX4JvnhLy8HqGHOCPwyme+w2BjiyIcFCzmXNMuEXH7g29u6QpQXky68=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(5660300002)(31686004)(122000001)(71200400001)(54906003)(6512007)(2906002)(316002)(6916009)(478600001)(558084003)(6486002)(38070700005)(38100700002)(2616005)(8936002)(186003)(86362001)(31696002)(36756003)(41300700001)(76116006)(66476007)(66556008)(66446008)(66946007)(64756008)(8676002)(91956017)(4326008)(6506007)(53546011)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?L2VyTHlvTk9qS05kNWgyRkpUSlRFUGhjTUVkRHpmVkRvL1JSZ05XQitna2tR?=
 =?utf-8?B?N2sxdU9LbXF1TjVuK3ZRRTFrc2N1Z2hLU1ZSRDYvWVNhMEd0TDkva3YzRFNZ?=
 =?utf-8?B?YzU1L2FjajExSGg5MnZObzh1SkVQbzJzMThweGR6NkR4RVk2N1dwcm9PNzdp?=
 =?utf-8?B?aWcrUHY3ditzWC96M0J5d3d0dVA4Nm5pTVZGMlJNaEx6eTJLRXlhR1kvVVN3?=
 =?utf-8?B?UmxUeHpQSDl3NXByMUFiNjBGTzh3Zkp4Q09BUWxnZCs5b09EYzdzYk9vR2tr?=
 =?utf-8?B?dk9nYVNabFBBbU1FWkUvQ3NNczB2RXVVd09uMjdJZHgwMHRKRzdNSEJNbjhT?=
 =?utf-8?B?YTlpZ3V2MytFVS90dTRYTUpSTWRpUHBLUUFNZ0JxRjhROTRuMFB0b1JuS0lS?=
 =?utf-8?B?OEh3KzV4VGJ4UHQrQmNkUE91M0ZQTmIzRFBOQWZGMEhkZVRXSmRTclhQN3Zn?=
 =?utf-8?B?WWNiaGtsUWxiZWFyMGxHekUwb1J0Rk5QRHhlbmw1ekI1L25JazBoRHEzTlhI?=
 =?utf-8?B?L210ZHlsYmpZTkVpa0ZKNklXYTR2U1BvMGo4djZFWlJzdm9MbWd5czV0Rlpq?=
 =?utf-8?B?cmxGdEpuOEUrS2FSOFB6U0VaeGJKVDJ5VjQwS1E5ZDVTdEdYMk1EN0xjcXhT?=
 =?utf-8?B?UzlhZmpGMzJ3dGVjd1R5blZKZkxHSWlma3V5V1dSR3FOWkZ2YWdzRnArOEl4?=
 =?utf-8?B?VUhpcHpSZjRtVG42SWE3dGs2dWR5cmNyQm9WTXdKZVliVCsrOHEraVAvRkl2?=
 =?utf-8?B?NElwai94ZFVsbGhMQTJXb09ZTFAvWlJhYnZtNjhTOFNjUkJCNHNSQ3hUNFRI?=
 =?utf-8?B?eXByMjFSMDNEemVUeUdXemFKVUpQZnNCcHhsTytwZThqa1VDMmFSNnFtbmpq?=
 =?utf-8?B?YUdWaWhMUi9yY2YvTVJiWjI4RzFyTDcydVF6cVkyb3ZSdzU0R0F5aGY1TTVw?=
 =?utf-8?B?WW9WL0x4VGRDY1gza2Y4ejM1MWI1dUhydUthclNLZmZyU2txR3ZpazNjSU1B?=
 =?utf-8?B?a2x3Q3Z0dXVxUktwaEZIVjJWdlhuRWJicEVkNGxBZFdvWGRRNzRQRW5KVUNY?=
 =?utf-8?B?bEp1TkxVWUdrQllUNkh3SWR3TzVNTG5xZFZ3Z1p5T2k2djNLa29GWDArNUVp?=
 =?utf-8?B?VzYyUjhHUWV2dThxRkJrRnRJYUNQREViN3pUK0VraGtES0NEYjltYmpHdFhG?=
 =?utf-8?B?cERJRXZya2pCWS83RVVmemZFNjRYZkxsb1pndjZDd2IrNm95cFR4ZmdjQW9I?=
 =?utf-8?B?bGE1dGJRajc0bk12QlF6V1o3dzh2d1o2NVJaL0pwV1kzcE5EUUZrV3RIT1pZ?=
 =?utf-8?B?QTVrY1dtUjBQQjhYQnNuOTJGaitoamNqcVBpaHhpaHlUSjVITW52cG4yeURH?=
 =?utf-8?B?d1oybSs0cy8vRFVmS3BsMDJHSE84ODNCUHZHcGhRUkxuM1VzOXU4bEV6L1dG?=
 =?utf-8?B?ZEFCNmhPUUoySFVGZ01yRUp6UGlBaVIyazg1cTNQYU5Wa2hSVnFFNEV6QURK?=
 =?utf-8?B?SkJZNE1BZHpCNVBPRHZsamhRK3Z0YUJPU2NUY2FTbTAwSXYra3liUnViUUhk?=
 =?utf-8?B?QUdoM2xHWEJJMVIrT3BmSEFpejFjbmx6K1c3bzZuVXNlbmFzRjIyTm5vOHRs?=
 =?utf-8?B?WkFETm1hQ2JMTGNXN2dmSWdmd1RRYTlkVGFUSEtJWG83eGNxQ3drNUh3aUU5?=
 =?utf-8?B?eGhSYVhxb05jVGRKTXkxMzdJTFJDR2FHSDdPdWplcHR6R2N6MlpoNmhUMlBz?=
 =?utf-8?B?bTBnYUFIRFkvNy9WMlJBa204bEZDcVBFZTZSKzlQZk5wZ3lnMUVVQkVRRDJ0?=
 =?utf-8?B?Y2d0eDZjYlVMcitDYWgyU25oNDZmMTdKUjFrUzdQM0kyTW1ndG0xcEV1Z2xJ?=
 =?utf-8?B?QkdmaDN0Nk1wekRHYTgyYjVDdnh6ODN1WnlXaEszUzRsRTUxMlBJYlIvRmV0?=
 =?utf-8?B?MUtzbEF5UlVSbzJSL29XdmpJdWdwcFN5eHdTM2xoeTBobnZzQkRXbmM5czZ0?=
 =?utf-8?B?NWtaeVRhODB0d1AxWWRhRlV4d1RPTHdpSWYyUjhxbjNtQXFmT3JFOXFCR1Nv?=
 =?utf-8?B?cEVLdllXK01rRzBYSWlJd2M3S0xlc0xYY1A1dUp5cWcyTlh3eGprV3lXc0FG?=
 =?utf-8?B?bDVweVNrczNzZjMrVkdKWXJpa00wNG1GdHN1RGJVdWVoY3pITE15T25pdkNB?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF517D5ED07E3B40A45C78FFD0529681@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026b36bc-6b15-4e5d-eede-08da9b5183fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:46:03.4769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9EDZIqt7Xv9srQs9hhmZyCydatz7gYO3B5bzWNI26+o5qB6QPTy9GLSvMU+qPdJQfUMD1fDWUbwC/Jk+d6Hrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144607_254957_D1BC1B55 
X-CRM114-Status: GOOD (  10.64  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFBvaW50IHRoZSBw
cml2YXRlIGRhdGEgdG8gdGhlIGdlbmVyaWMgY29udHJvbGxlciBzdHJ1Y3R1cmUgaW4gcHJlcGFy
YXRpb24NCj4gb2YgdXNpbmcgdGhlIGNvbW1vbiB0YWdzZXQgaW5pdC9leGl0IGNvZGUuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQpM
b29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0K

