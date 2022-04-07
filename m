Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E85AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 19:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjEcO2ymgcy02NAIBqJKnqqNm+AE15+vmkjlJ/uzQaQ=; b=3Hlqxan5bIL/OPR3yEiuHebWiv
	fKD/Jx+SIxzTA28dsPWYGYeU5VdZpDHBn0xqPT3Ne8qzUnq6pU68178+laE8yWFsNJeTz3AI7/YwF
	h2xV8bkO6Sa7Cd3nCOsHE48sYL4kKCJkrEbAK5+CU9Hqsk78AWmfAkT5ImrNdfm9bY63Cgm+H77Ec
	VQA4D2KbwiTHxlQPbfo8rffIdCW/xdYsVVz+FX1mv22zNuf4YNDrMT4sDbnT6a7hzgSbHRf+bkj9R
	NNHF46AW3/BB5cxak1QMyZ0uVirKZvoIKjI0+6OS5oOdaG+zoRGvLc45iwn7HaeoCWJCeZI7N61Ll
	JxlBOSNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncXzm-00Dkqw-GR; Thu, 07 Apr 2022 19:40:42 +0000
Received: from mail-mw2nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::608]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncXzj-00Dkpt-SO
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 19:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmdVJAWdsZ+z7ouCRY2veDq7wzGwTh+xIk7rgFnwK4wtH9u65iz4qNnb4lB0EP6OYLgqNopb1srvu3ozahOaawPwMn4jwt6R494KptDJNMFzWRwCTiitmK/7yCQfcaWIzMtfc87o2u6oJxCWprWP+qVu39iwjI1h4aaG7YvhxzkcRq0MrfFf3/V3lwdctRLxpS3MWDIEC6otyYNRgdrwEFDQC0CPytuTnP01RSq1UMRRDbCUdssC7aJPLs3tW+NkUTfrL7yQK1sL2XnEc14g50PXmK01CANV4haZ4p/+RcU3Fvna9voD4nP9spWwMOeM/wCGrNo4bvw1m/vPbfp17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjEcO2ymgcy02NAIBqJKnqqNm+AE15+vmkjlJ/uzQaQ=;
 b=C9P5T6harjDkEu5TmQ4X37beshYNPyUP9m7jR9GQs18RGTaZpq+qqU9YzB+N5Al7Bn2oqT/+zSiD5a1CZxaaL1LG9gGWm0V1coFaz57h1PhPo6xvZtw4sFzr4UP3cSTb1hxEwcLKH7vjxW1V5ykLvCcp+2jYSZjF4dnJJT8p6oEz7WJm7lbpT4GQBQYveqo6DcgUDGWQfKB3wYJ0RBXhLoB5tNRWVmrpruIUESTC6kqtVrt769LlIHbGWCa8d1OLPMp2/29xH7Z/8Q3qXd1nnFXuIPgLrp1nYPw62TCPhCR3ccxgjBws1HMrA9W+ihfCfciXTJ1wntvsOlWVs6yRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjEcO2ymgcy02NAIBqJKnqqNm+AE15+vmkjlJ/uzQaQ=;
 b=g3/c0beVt1shXMna3cj80mD+Zm0vpz0UD9Bf3FF0kfT/Z3+q/yoFFRnOgUqGLcwKg5vlq3zdzFbFfi7ahbbCLtOVe0kjyJEUmSlPxa1nNKE1D3ONGFrYpHAThJKsCSTLrqpDtJpzq/XeRk6tMSvQp58emKDtQQ7t5dik5UbaxD/3d70vTihfIRx6mCVwfE6eFyT+p6IzIYIYQraGSy1P6sniFQIRdEBU+fcFDhH1hy6o/7k1yZm6EwYzvqXmhyWG/d2a8wiTWM0h6dq7RinwuwFVB2smh1oFqZGvKJ/E09ftPI18pFLjnS4MQnuRv/u0UBmAW/lmMNACGAoT3/+3vQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 19:40:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3dbb:6c2c:eecf:a279%6]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 19:40:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes
 Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUmD3brgDUei0iedZF8Ixk0L6zjGb6AgAAClgCAAAWlAIAAT2MAgAAC9ACAABRLAIABUmwA
Date: Thu, 7 Apr 2022 19:40:35 +0000
Message-ID: <f76b6953-2d1b-dd14-cf85-6bcd4648f12e@nvidia.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <feec0fdf-2790-1f48-9a95-88bf208784ab@nvidia.com>
 <34DD0B6B-F7F1-4BEC-B039-1B0DA9D36676@oracle.com>
In-Reply-To: <34DD0B6B-F7F1-4BEC-B039-1B0DA9D36676@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1b34114-a4f7-4781-8618-08da18ce7c2a
x-ms-traffictypediagnostic: MN2PR12MB4047:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4047A54B2BC7DD4E0A9C8966A3E69@MN2PR12MB4047.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 37OXnDgPRMYtfiAYjcgtK9ODZpdQE4JsgA7V5qjE9bemwtopoXUL3RXZHFSXCqa1JIGlA44gIOo+7gHcVRHdrWAVK3/zup9vekWY8wrSte9a1nnR/4rQ8opX4vVHX9XQbEeYqQ2DnEpF/OuvTcGGlAR+1cr5hCIR4rHyQqU0jrMQaLUSLdfehhhw/9dfNkzyzp6+xBB8RX5dmf4R4/zSgWhrqx9Pd98cjvU7Q4qvJH7xG6HBelujLtOUUPYP9XGOtB6nE034mAA4+kbuceckNcepGJT7yraWBNRxeNfw5eL7wCt38EUMN2g7c6W9o/YDOEMppmO2MXgK+SQKH2PwBzEkMoBl/3/KuameJtXR12p5PBTNmBRtKDNklxkes9ondmIWueBIzSrR94lHrIJ7+xULG+vnD95l2ICUOADpXmuamVYWsmjuEQmgWGTW1FN3jqSD4NkoFqxiM76pcrP0Hwf5BqHDHqA9WvMcOBp+is5ds1M6dYl6BboO7bqqnSKTlWojjRNKgzPECSH8DgPJBM7ae87Uj1nt9x2r/y4MfmK0tLOAj+mrcKX1u1nZPwnUO7A+9QyoDRc4WLY7YlUBbsStM3wizafpXBD2QOdcM6WAmInQvdVUrnd7dYsbCat+dq+M55VmJCclyz2E/6k4Z9TzU2E5frk3m/rtwEPLvjgI+I2BrPAOBtD2p0KucY1JGB0Rh6xHW0N5u+p8Z4z+TGpByRboEHowAn4VpbE8RUP2qXVaVWs9noI/APT/1U70QfidQoL5kNxNvvQrGrmoNuuwaqKoFZH0fVxF7L+YcqdpNPP/vU0acbF4CknLYcSrldP4VWnXIrDs9rkD02maE8QReTY9OjgFoOtHvKeWqoa6eX60rXHAeVeGSXdAV6Bg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66446008)(76116006)(2906002)(91956017)(2616005)(8676002)(64756008)(4326008)(4744005)(66946007)(66556008)(66476007)(53546011)(5660300002)(31696002)(86362001)(38070700005)(8936002)(71200400001)(6506007)(966005)(316002)(6486002)(36756003)(31686004)(6512007)(6916009)(38100700002)(508600001)(186003)(54906003)(122000001)(533714002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym1kWkZGVFhKcGxWd1dpNFR0OVN2c1cza1pOc0xCSEJzT01paExGYVZnaDdz?=
 =?utf-8?B?bFlod1RvRVNZeUNaVmMwSmkxWnkzOVh0OWZ2MlcvWW5keE9BMDY3RGRZdEhT?=
 =?utf-8?B?Rk5wUTlwWjQzNFBoYkdGc0VRMEJLcXIwZXlnZ0FNYU1IdXpaZ2t0WDRsZUtF?=
 =?utf-8?B?OFdwNk1xdVVpeHdac0N2NWdtYTdTR2ZPZEZoWkpiU3VTZ09FdUw3NVNPYXJu?=
 =?utf-8?B?ZnlUQVVGTnNOVTZhRWVNeUd2R2IxRldPeitZVkVJVGY1bUU4ZUhtYTFhSFgw?=
 =?utf-8?B?clRzQXlQd0l5ZlJ5eXZvdHd1cWMwekJjbndQMmVYdk1MZFdFRGVXRFM2T0tF?=
 =?utf-8?B?MkRHTmtaN1NCREFrMTVsVWxjR000V0xOb0dBaFA0MWhmT2tOcUViRnlVd0Q3?=
 =?utf-8?B?QjlUNk9MZGgxT3UyNWM0Zmx4YWpBNHVQbW1ZTVplaExFUGRQNmtBM0tENkla?=
 =?utf-8?B?dWdrTXlrTzQyVlhJN3FHMG5hZ09wUVgyYUFCcTdUc0R6L1AvVnMwL2Jqdi9t?=
 =?utf-8?B?a1ZHQ1NtcFh3eVRQREIvd0VRbzc1WlFjZEU1aloyZUR3emxIa2NxTUliQy9R?=
 =?utf-8?B?b2JFbStHQXEyYU5CSkpkTjNhYU4wRzlzdk9NK1dDcWpURWQrZ3NpdUgvZWtU?=
 =?utf-8?B?ZnBYRVgrQ0VmYzFhNktCejJIZDNDQjZjRDRXYkNNNjdpTkFSRERkQmNQYU5n?=
 =?utf-8?B?S2xHOEV2MnFGUEw3VlE1Qms4NUdjRGtwS2NNenU0MG4yR3FOWktJZEc2UzZt?=
 =?utf-8?B?YlM4aGNNNitJYzJXaWJWTGNLKzZSODB4b1M0clNWUFJNTDdKN0hVb1g4U0l2?=
 =?utf-8?B?R1J1SEZYdkl4OGJlbXJzUmdyM0ZVTmgxSWp1SGJKTWFMWGxPUGdZbnVLTzRC?=
 =?utf-8?B?Wi9KSll6Qjg3NXpmclZ4Mm9GWUVENnB3NEFKejVzWTBqTjRUaWlPSFNqRUNk?=
 =?utf-8?B?Qkg4TWl4Y0YySUdxdHQ4a0g4TGk2a2VTZ3dhN1R3c0NqUUxqMm1Ob1prRjlu?=
 =?utf-8?B?ajFEUHlXYS9YWml3SnBKdEg4cTRDVnFNejUxM0hOM1VYcDlQV2lvdFBGM21w?=
 =?utf-8?B?VmgvMTRLVlQ5c3VMYU5NL2gxM0dNQTc0ekdMMTVEMmluRWl3cjJIeUREZVR2?=
 =?utf-8?B?WnJzbnVNWDRxek9xQ2hOSGFobmt0aW92SEJRNjUrYURrd0lBaWhKTFpJTEdH?=
 =?utf-8?B?YXljblNpYWhBUHlOM25SNCs4ZHZ0b0hwTTB1SlFzMWhjZXpLWm91OCt1VjFI?=
 =?utf-8?B?QUF2VDBZVmF5TFJFTTZ2MVRVaE5RYld4N0JjYllyZk53K3ZtWWtTSWV3U1kr?=
 =?utf-8?B?Qkl2QWltTFFOUDlyN045UHJjVTBvTTZxL3RzYmlYbm1WanArdUFKMSt4cDFR?=
 =?utf-8?B?cUlnb2ZUU0dIZFk4SlQ2MUhIRDZZOHNMd2Y4dWQrNEhYZTBzbjNQTU5hZWtj?=
 =?utf-8?B?NVFPd3lCRVNPOHFOREl0MnFQOUVkSHhSenFtYjg1VnNoOUxmZVFrSDk0bkRs?=
 =?utf-8?B?NmZpOEdjdG5xcGxOSFNOTytnOEVWN1F2UGttUFRxNEtoNUpNYzBuT2RnUlBK?=
 =?utf-8?B?eHZyaFJacC85bGhrdjV5YmNsNnNBbndlaUhLc3dLVExXdHQySGtqaE1pRXhY?=
 =?utf-8?B?cUdpM2txUEVFcThwTkROTGRVOVdqMnlSTTNDTnVlZ2tUbkxtVFd4b01GUHR0?=
 =?utf-8?B?dTFQZ2lJNVBsL3d6VjMvK2Z2NjMzVzJhS0hUNGJTWlQveUdFTmRmbWc1TFZp?=
 =?utf-8?B?RkdDb2hoNUVLd3ZrZmNFTERVbGxuTVV0Ni9ndTlZeGk5U0NXMERFV1hudEdu?=
 =?utf-8?B?QUl4bCthSHdTL1RQZDlYMHM0eWdtS3ZFdnZ4TERRL1oyT1hvWms0VjA2VmNz?=
 =?utf-8?B?WHVNSW5Ia01ZSDV3MisvcnBVQXFGQ1BBa3VvRGVWMlN5eDZKZlRMUGNVczZx?=
 =?utf-8?B?b25JOUJEUkp4Ui9JclJoZTUxWnNZTlVhRE54T3FKYXZ1c2REOFFWOUIwLzBy?=
 =?utf-8?B?OGdJdlhEQVlCNCtzcHQ2ZWpXbzhiSmVUMWw0M2pxK3ViTm9xUnVXcGltOHlG?=
 =?utf-8?B?WFczbGI1NStYSTdVWHlQWm1Wbkd0SEQ4WWtuS1dvVzdMNFl5dnIyYnhYSWJj?=
 =?utf-8?B?am56TkNVMWxaOEFaTmo3bUk2elplalJ2c3MxQXlINWRCbHl6eGtCYkNNcXN4?=
 =?utf-8?B?QmNnTVFJTGlQS3lUQlk1VExyYW9RZW1aRW5GdmVGTU5JQVdPVnBuQVUvL0pq?=
 =?utf-8?B?c1RHQ0FJTTJ3N1VjSWRjeDNDakQvWUR5VTJNRFdnZkFFY0tESHNRaTZQNWlk?=
 =?utf-8?B?aFg0QUExMUw3b3JBbU4zTFRxYnhWYWY3QkhBM3htN3REZW94OFEremRNMlpo?=
 =?utf-8?Q?4uVUNPowDEVbHPdSrcakv6VfW3Y5BEBjktocoqJI3FJOL?=
x-ms-exchange-antispam-messagedata-1: KTfvWro21oP/Nw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E2EE68BFE6FE34480D7A7719165500C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b34114-a4f7-4781-8618-08da18ce7c2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 19:40:35.1368 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzxvF/2qrGYBJOzjxb/8rEF5CG6RaxPQacVwPCiG/oZ4szUekBO9dj29CO6FKah6l6repFe2CRlWcoeT785x5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_124039_963877_19253B6D 
X-CRM114-Status: GOOD (  10.95  )
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

T24gNC82LzIyIDE2OjI5LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IEkgdHJpZWQgdGhlIHBhdGNo
IHdpdGggbXkgdGVzdHMuICBJdCByZXNvbHZlcyB0aGUgZXJyb3IgbG9nZ2luZyB3aXRoIG52bWUv
MDEyLiAgTXkgdmVyYm9zZSBlcnJvcnMgdGVzdHMgKG52bWUvMDM5KSBub3cgcGFzc2VzLA0KPiBi
dXQgd2Ugc3RpbGwgc2VlIHRoZSBlcnJvciB3aGVuIHRoZSBzeXN0ZW0gYm9vdHMuDQo+IA0KDQp5
ZXMsIHRoYXQgaXMgc29tZXRoaW5nIHdlIG5lZWQgdG8gZml4LCBhbHNvIGl0J2xsIGJlIGdyZWF0
IGlmIHdlIGNhbg0KYXZvaWQgdG9wIHBvc3Rpbmc/DQoNClRvIGZpeCB0aGlzIEkndmUgc3VnZ2Vz
dGVkIGZpeGluZyB0aGUgY2FsbCBzaXRlcyBzZWUgWzFdLg0KDQotY2sNCg0KWzFdDQpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbnZtZS8yMDIyLUFwcmlsLzAzMTE2
MC5odG1sDQoNCg0K

