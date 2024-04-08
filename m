Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0299CC67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QanGiqYDM8tC1gAW5ntWfWKs4zQ8rKgPIhg1IOoDXCc=; b=x/41vPHpudShQWNWwr5bmJDoaf
	01GcpQG6JsMwjFjEI+1wX63FY3lSGHH+AipbCbdzDPi3Uuc3wxmyu79YYWxGpb/zIar4VWkyIM8Ou
	p/7IXxu5JqZ8CT+d6ONzRCD6npyang2AyFm/yVZrQzM4vVUkuWKwAAZ151WAHDjmhkYlY0lYEuATz
	izO2qQMpiykSULU145PvcPLo7vbgPkh5wRhsfzjyr0Oi0yjJF98Matih16GhLeV+67W5rQvhb3yYq
	bHr8FZuLSxVr/9K+qG/iBhn9a3UTVTTWCfGJF+mPxqBPnry46YSWBW0Llt6LYvc/g18IbyktGGwjV
	3Jpivjfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtryi-0000000GCzj-2fwa;
	Mon, 08 Apr 2024 16:36:16 +0000
Received: from mail-bn8nam12on20701.outbound.protection.outlook.com ([2a01:111:f403:2418::701] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtryf-0000000GCx3-1i9v
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 16:36:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZsS4QtoYF3ZAwjpJxYDPt8qKexKBTPaXWNyOx1B5ymw+o7sC1tFqymifutNbIfYevk5AjC33RVHa83yHv7hwjjVcruosM9f8UOTMKIN5/cxQQXNfoDYisNzjhNsbtcahI2XOLifXHJ0YN+DVWBTsFlR+y2mMMRmCVRqK9cFSOE4ss83VnCBkhdu0DAC3a1/Hc1q95VIGCm3zqbGHu99XFPEWevyJ7usWBon3pxTP/Lv75tcoIjEmPqKu4kXUdSdPtMSFbZjmD9TF2O5mk+M0kZivlwCHIRtGxP9VWCh9BdVOZNKlzySiRXIjTc+IyO6hX4sowQLMmap2HslZJ/7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QanGiqYDM8tC1gAW5ntWfWKs4zQ8rKgPIhg1IOoDXCc=;
 b=bObyoj4u60qC9/hH8Z9LXir4gWpv7PUWb7DxwdvJbBpSww5mHFGPG6tXfSVjTC+PQaxNdvak4JSJY2O2rjj+fxU8kfUNVxpgDK8Z80kcm1szcj750Hrhgi0L8tsfNXx3EYMYXSbyAeQplC5j+nhaMw+BDxpsb8g7jn516XgIjYBv1BIMvHZLemfe4BoZIfOEjZx7f/vg3YGPZeehiz5VOOcxP1J/vvF9UOqx1L0UWBOSdOTDSADD0KUpd/kGSX5QiHo1Mu4J5l1Z3u74tSZS4xEbpXe4Uz6Fn3xcnYaLBN9R4cGu1q7eKU4Vn2WwEL0YWGjtOmHAI+EACBigODZfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QanGiqYDM8tC1gAW5ntWfWKs4zQ8rKgPIhg1IOoDXCc=;
 b=PU7vZsyr+rtFUS1a2bItcyFum4vQOHOGCfx3fY1x/ksOURgkIoimDzpB/k9uV1RZK+ud0zL8liJvxzGBNfkuc27w6D8ZBtDERlhhVpuWDWuQZY9A+PJoUF04pue63j28hui0uHGQIMiG5u957Qfw1J9s5C+TiYz2vpc+clzhMy2lYNeKj8DWyk6DJ7qxRMXElWiMRmIIh+LLYrmYLL4QlrWrreJy4oaHWlRP749nNcpTH9q6EIvjKD1L+ow7GdHITd4RgrGfx7wGHjKua0XcwM166TOW4kmbnegNnrqr3VRZ84gHYDPLT1P+1UiHphZCrb4VYvCSzv99tqPNk10DKw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 8 Apr
 2024 16:36:00 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 16:35:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCHv4 0/7] nvmet: debugfs support
Thread-Topic: [PATCHv4 0/7] nvmet: debugfs support
Thread-Index: AQHaf3W/qaPNudHP5UuSIbM61KOWLbFKBXoAgBSZMACAAAgWgA==
Date: Mon, 8 Apr 2024 16:35:59 +0000
Message-ID: <eb421726-df80-4248-953c-a575ecc6a0f2@nvidia.com>
References: <20240326120342.105740-1-hare@kernel.org>
 <p6epmhukqjaiomqvxwgpwkoisg25yt46d5texh3sm4lkoump6h@b6ovzgutko77>
 <uvkgxqndcvgkphwuto7o6nimdsria35hc27v43zzo2h7kokor4@5olfmdazhi4f>
In-Reply-To: <uvkgxqndcvgkphwuto7o6nimdsria35hc27v43zzo2h7kokor4@5olfmdazhi4f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB7445:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Co3p2joMi+YR2I71so+5Kiwmr8pi+lVFRXNEYHN1egml+hdzl/5oItSqUDXW9h2xWKtMcpaRMASmoM900xChxgndgf8r3b5WXPbQYt4qxYH/KX0PW0sar+p0dK+eKFxUhH5nVTSrA55qVi7ns7RN8eU4rLL4nDt09VPiM/qVKI5oqNgBbZyvRQYyqYvsE9sfYSiZgwzWW+j/Xb/JrM+eK0jtKmrL4KbisxUEfginWjwLnsUCZu9S9G8jtYXS0s/RVujC7SDDpgMzn/kJ4BleJTbRWQ/MonIhcZ1noWhZNATGavK7lc5/fRtoMF2MKmtpeX0GvQSDN+2qt07P7BXjCx2FP6wclGKFOHIy0qEfG8yLc/SL1+KIL0pDDzpiYi4uWDJk62J6HLcyL2cSANvdwnH70CCD+U2wwaxxRr3B7q4jmgqMEyeaFKKIM1MUWNpRvZoOV9YT35jVtGyMpDaVZYF9fZHzNTG84xFp56twL7O+pW1wFm5IMT2Hk+eGUu8+PFY5//6z9MqAkF/B1M1t/mRlW+Z/z+2ineE3qQhNMafixbETEehW7vhjsMU7NYhl7zS4PP0jQgDR4lRGd8tHGcfjS5XQg2Ohh0uGrxIKCs2JzDWQscgPVPDCsfKZmljACvy1lrCQrv/dwscxmZ1bITMuUqHWEVDyxyGousiw91M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUhJU3JhWWNUc1lKelZmMjlaanpzWEhuV2VMaGJJbE14N0wrVm5uTkFBT3Vz?=
 =?utf-8?B?ME9vR0lWVzV3OVRyQ2lqS1p3TEJnZTduTEJkS1o4bVRWSDdZQ0RrQWlLb2gv?=
 =?utf-8?B?NFhmenpsUExydGkvSjRROU1oeWlqRnZMME8yYzVMQUNxV1dxOVl3ajh2ekU2?=
 =?utf-8?B?dGFJTWlFdmV3dnBTSGcrM0pPajVjUnhvMkpZdFRHNElkM3o1QU5GeWVTRFRu?=
 =?utf-8?B?SXFaUExZcEVUZjd5TCtnNnRRMXcwc3I5UUc2ZllHWTBha2RxTGt1Ykl3a09j?=
 =?utf-8?B?RWZHUHkxWW4ycmpjRU1LZS8xbTZWQ3h3S2l1WGVoUjdhdkNZdkJwOTBiWENw?=
 =?utf-8?B?akRDR3NkcUl4NzFQbThFRUJnZll0VUM4bWNTVEJVVVFHbnp4NUtKQkora0tH?=
 =?utf-8?B?ZVJmK1h4TmJJUHEyL2xFcCtsMTY4aG5PZkUzVGRZMGNLbUVSaWxFblJFTHds?=
 =?utf-8?B?eTVhaDZyTnZLM2RmaUQzdy9NT0ZEbURkS3Izd0FMek1pTm5HMzZkVGJUbnI5?=
 =?utf-8?B?ZWNlT3pCcklFSGViTlFOL0tNem9rejlCOUs3SEFhOEVPWGtONkUxc05PMG5y?=
 =?utf-8?B?QXM5SCtXQkJZMHF5RnN2SGpmb1l0UVNzN1hSYXpkUnFvaStaMkpHMjA3VHNY?=
 =?utf-8?B?dDVodDBoblB5Ylh5eVc2NG9mbWwyd2ljZHUyOTl5Zzl0aysxSlVGc3NpWlVE?=
 =?utf-8?B?VitSRmc4SGwvbVVNbUt3dW5ZM29tNUFFYnhGNHZuNjhXTzJlSjJhU3ZHdXk5?=
 =?utf-8?B?WHBGcGg3dE54ZW5UVlM4dTlHNy83Ulk5SEtscGF5VlZFS3ZILzZZSm8vLzdj?=
 =?utf-8?B?RFEwaXp4SWpBTjdZa2lWbVJUZnFvR0lQZEc4Vm9EU2dyMXUwQWpGU3hldUcr?=
 =?utf-8?B?aE9ldzRKRStiK1l3SFp2QnpmVksvMFZKcmZIQjEzVlJMS0lPeVNmUlRwaDJG?=
 =?utf-8?B?NDArUS9aOWdGdS95S05GMytYWW5meVpjN0g3U0ZzNjV3UFRqeUhLdGdHWUo1?=
 =?utf-8?B?eHJybkdnYjZFTUZ0Q3A2OUE1OElaNkdmdFZtN3E4cWlLVWlySDlIQXRuVWg5?=
 =?utf-8?B?VkZPTm4wY3FDVzdXM2ltczBnYmM4R2h1NWFVRlpLNjVUbUh3MU1FNGwvZFFp?=
 =?utf-8?B?UThPVG1KTEMzdis3UDVFM0FVMWxkdk0rRkJuOHB5TUxHczVZNnI4WHViTXJG?=
 =?utf-8?B?bEFSK0FLL0trTFB5Z1pvb1I0TFFIamtIMFNoOTBrZ1E3YWNFRmFZbnJUdml0?=
 =?utf-8?B?N3huRlVhbFR0eGR4ZEwvanZ0ankyTjl4Yi8yZG9waWIxRWRJQTg5YmdjWkpJ?=
 =?utf-8?B?ZnByZzRtWDNDdzNrdGRpR1JybVdwc2hCYUxNVEdFbThid0xWRWQ1YlBLa2RX?=
 =?utf-8?B?Qm9JQVluTzN5THhHY1NEWWpqMUlFOGlwcnFQdmdEQ0VaR0NIY0FyWFBicVFC?=
 =?utf-8?B?RlVuMWVScDI4VWVlclNlYXNmeFovM1VSQU5lbVRrL1g2SllWRXZrU0t3UDNN?=
 =?utf-8?B?cUNMbVU1cDhpSk40TmdONVk1cExhallGektnWmw0ZXM5SjZkZnU0cFZWTHIw?=
 =?utf-8?B?NXlObGtaa2J4UHNUb05IMTJERFFqVEdiSnk1QXh4WEZWdUtlUTZBaVRTMUtI?=
 =?utf-8?B?SmloNEFudVJjbVdMc2lQZDdnVDN5MVBYcEo4b0JGWmh1MTRJNXJjWWh2UFln?=
 =?utf-8?B?Z2dBdDRtLzJWTzljVW9PKzhmbjVoMDhmWjk5eldCQXRXTUFSVmtHbDg5MUN6?=
 =?utf-8?B?S1VtMUxCeElyOFVqSFdwTE1kY1AzMjUwSXdHWEhoaWR5MWdnTFZ4VVJlRzFx?=
 =?utf-8?B?em1CSzNtZm1WRDNzK09Pdnd0MUVMelh5WVdlTmw3T2dEelRPRDE5OTRQVXU3?=
 =?utf-8?B?U0FZSG1mQnlRVFY3Z1VqZGF6dWdja25vZGZzdnh1SFJBWjdSZ2N0T3RVNWxs?=
 =?utf-8?B?ekxXL0hOazcwOUovczNyVWpPU0I0L3M4Rk44emZwSngxSlNlQzFwWU54Z0J2?=
 =?utf-8?B?cjZZQVRhK1lhbkYyVllTeHBHQk1pSndEZ3NnZ3hMWkY1bFprcGt1elhtbTZt?=
 =?utf-8?B?TUZuRk9ySjRTVEVhcWw2U2pVVkNsZ1hxbGl2OE1TY1FpOTN2UWZGMVZPc1cx?=
 =?utf-8?B?NG1aeGxnSTN4N2dDZkF6QlZ4bEFXMnYyb3lNaHN2U1FWZncyZE5wNzZGTTBW?=
 =?utf-8?Q?OTnASr0oBfZ+XA1YyiSdHBpumYtQRRWQS2fdLgg5uV3a?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71CA6B31ACDD6B4B9DAAB0B0B3943576@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec4cddb-3eaf-44d5-e8fe-08dc57e9f926
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 16:35:59.8602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDCdR8Lj1eSSRR7gSepmPCTHg2uEy+aJKVJVGHnMZ7f7AM+hQXHT/8sXkpoZ9DvG+SlLKn3Cp8k9BMaUyk6RhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_093613_500026_337EDDFF 
X-CRM114-Status: UNSURE (   6.65  )
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

T24gNC84LzI0IDA5OjA3LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBBbnkgY2hhbmNlIHRvIGdl
dCB0aGlzIHBpY2tlZCB1cD8NCj4NCg0KeW91IHdpbGwgaGF2ZSBteSByZXZpZXcgaW4gbmV4dCBj
b3VwbGUgb2YgaG91cnMgLi4uDQoNCg0KLWNrDQoNCg0KDQo=

