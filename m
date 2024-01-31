Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E52C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 22:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xK06fXjx3cE/aZ05UP4X3oefJhQ8xjFdIOObghqmerM=; b=ww3iYIEejjkKkoj67FoVB22lho
	VatPubFQDlA+DliWm87gqJc3kbnO1YnbIrCwbuWkUwHLP1t+I9DGN6Zi6r/L9Dd9zayq1GY+rbfk8
	e8PGxFJuix0kMHQs9h0xFRupGOdKQv1wFW60iTXmFywQwtk2rLixfsYzCAPb4Mp0nKo0+sYtZE4LO
	V3PihKTiGTi9dyo7tuj8l/8PgpjrkDP2jlfQyuYDfwaN8+Glt/D+rK+j2bdp5BsKz81u4pOhAgaB4
	qW7UUGmeioD0wQowPhnzwzmh0BbE3xxwQNSmdK9KvrTgR2M7Nwd6X+fDdTyE/fAPiqDW/Wh/tBEOE
	yh7Elzug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJTK-00000005kzt-1MMd;
	Wed, 31 Jan 2024 22:54:22 +0000
Received: from mail-dm3nam02on20601.outbound.protection.outlook.com ([2a01:111:f403:2405::601] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVJTH-00000005kyQ-2YI5
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 22:54:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6UeUXzo7y65JK9bCRaEnq/Xl1UP6cxSL7Jr06IIs6fZugRGE0Axm5hZGzWK7hY1jiIjgGhg/aCSvaLzg8Wk02Kk8hk0daiN7nyN0HkTrXqqBUvvztymwldbeWhOd62iBCUATSFL+zKnCfLSgcmhS1RXV4BlUQmdhLp8thuq02McL7HZNWYl1lK4QT3oNucMRm+UVLzPr5Ntc0u418YCAjaJ2Ux1GygG+/Z2qC1F3CRpsBCWBlo5zKFM9jlsyKU6pbIJ3ce4OrTiyFz1kfGgmZaxZAfPycpQzI6t3hBZJVGWP5E1w/jpTkT2TyuLbBPq1heTOxJQD4vZpLVW+aJOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xK06fXjx3cE/aZ05UP4X3oefJhQ8xjFdIOObghqmerM=;
 b=hPW9o/JWTgemBXFCeSDjOzyDEtlnMj8F4xV53ChJdFpV1REHdhHm48cvfMAWBrcJOhGDoX0asPC5DceVsSBpOOY6A58oZAEGzK5JRAMmTk//xvieYdoyxxJS9Fa/E7DEEA/NVXXuIchgkd2O+UzFN55PtspPAbuXdZagx3eq9KtcFXgvXqWwOaJN2he2xaMVkrcVmZub5sQJroT6VBoWfHcXq5DyBVL2vSAkHVuhHxwEaf5cVKLF/fUjH5wDl+qMhG9Yy/0TwseD3xZM9a3Bb2y6DDloi1zABTc8rotBvGpcNIEXS3+sqAbn31puE4f6CkNXSrfOv6TbgNgg6NUdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xK06fXjx3cE/aZ05UP4X3oefJhQ8xjFdIOObghqmerM=;
 b=eQgoktg5G+SsVXV1TrdRPqKTGtkhqK+7GekRWLeKJmOqxxdCxdMHe0YIeRBeJAmlpLAxGHHGITFd0R0eg0REhaHNI3GZBD1aZyEtGSz/PKds40AGYBAJZvpUvN7ziNyuQDQ3xAUlJnHxPF+qQTtVSbP9EjICBwXKpzMRCLiN/qHPeMUbYVTLHlqy1idVD5ymiRTYpmsMpbnAH/QSkqzvJHuvs+Dn4NLbLtvpe68wbB7B05j1Pe4cB0vr2LJe1QU9pSDG57LvNMbZYoDp5KUD3QZ172bPF0nE+yik+5YPedCErG/rselmjSnGyBjG2WtYhVZkYMyy3cDN3ahlLHSStQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Wed, 31 Jan
 2024 22:54:12 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 22:54:12 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH V9 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V9 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHaUxHjtzdxRBDP9UW+pNDn2W0/crD0iquA
Date: Wed, 31 Jan 2024 22:54:12 +0000
Message-ID: <efc53006-6174-484b-8560-fac7b3ad3448@nvidia.com>
References: <20240130001938.1103354-1-alan.adamson@oracle.com>
 <20240130001938.1103354-2-alan.adamson@oracle.com>
In-Reply-To: <20240130001938.1103354-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN2PR12MB4207:EE_
x-ms-office365-filtering-correlation-id: 26195c2d-e203-41da-b2ab-08dc22af8abc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jn6iMSa4HxEI6tHBaEfniz7TFkp1yxpih+GtUYPcDwe9PofxjCs1y8eX6A7nxmYvCvEge1er4u+uMlSzkys7Skjw5TulW4labJhTnZD8yLoFoHM7mdRBqLzbZeEtu/UqTogEj2mIkWWkfZktFOB9nFAX8rYW2wbGt5YNGQz2ESpBUd3wxNCgmarTPwk6i++xwZWm3hJPlNTHRU5+A/RQd8WYLVC4Ry4Z3asPWrRRMPgFn04whJINnMrRgsKjapt6lQ3WyJ9Jy3LyiXLka0LPB/nfBgGBmqa2vrtt7raSIWaHXew3BXyKId6oV9XsK0/DCwaUlIUc15Gw2vL8d8iRptsnqXCOydXf+pzp3MrB1leQW0A9bvyH/W0YRD+vD7/3SKTUZnhjEB2ZF+20cFHaBjpLQsdM64ASlGUr9BixBWLac63mlCpgndWbYveJbX/L3Z3n5YDsVK0OW+m7u1MDKaoYCrK66N8ws3USGUYROrkPrRl4r0kC/3GtZngU77ep6x5nhgKaImwE2l6F0b3O4Hz7OM1bST3NJ0TPD4O18HcubkSGi7H7wKv2HIV2nnt4xFdpyfaXtzSqwhJ0g8bsNgPMgSkpeGj0WMXOwS2OOyJWJXZGmU8lAU+WgoklPRKAhfJTx1Mx9+GB4yOR2xofwNoR9a96r6IN/T18anjVSq0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41300700001)(76116006)(6512007)(8676002)(2616005)(38100700002)(122000001)(8936002)(5660300002)(4326008)(2906002)(478600001)(66446008)(64756008)(66556008)(4744005)(6486002)(6506007)(66946007)(54906003)(66476007)(316002)(91956017)(110136005)(71200400001)(38070700009)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHJQWlpQVzlnTWp5YmUvQ2liRFlCd2tlR0FENXZGWWNObUJMaGwvcis2NzA4?=
 =?utf-8?B?cDB5TEZQemMzdzF1SWxxQ21XTW9xckZJOUhFampINXZGMyswNWpDS2RsUnF4?=
 =?utf-8?B?N2x5V045cFVRSnZIdUJ5NEp1RDJSY2ZtNGtKeU1yNjQ0RjRGcXFuT0o1aDZR?=
 =?utf-8?B?UWkwTWRvREtpZFpBZzJLZDhKRWgwNGlxUUpQUEVwNXdERFdmMUlrcU10TkRC?=
 =?utf-8?B?eDRGU3pOUjFydmdsQzRVZTdNci93TENUQ1FnTVdldS9rZCtOc25hUzJGdHZW?=
 =?utf-8?B?a1dQdTJpTzUrWG9RWXJ3UDVOYVZQNFBGNHYxUkxzRHR6TEZ3MW1OTnc2cTJ0?=
 =?utf-8?B?aVhhNXNsZzBXdE5zMHJQbHNXVG1JU2lLWDJOWi9RRWNaS3NnSXFveUJVeEFT?=
 =?utf-8?B?Wm4vNDI3TFNOYjNYZTJVQ0duNnZqUDZjVlJ2a0J4NXZkTDZuck94TUtRekpp?=
 =?utf-8?B?S2RJbWtyMWlOWDg4bmtmeXBFUmhRb2JIa0FQMHNEMW9ZM2R2aURDWHp0ZTd2?=
 =?utf-8?B?NThDSm5QYm14VmwrYmNITjZTVFRmaFNoOGZwWk4xczh4Z0ptdzJJbnNwN3JE?=
 =?utf-8?B?UUNjcjJGUkZ2THRsT0tSK0dpYk1BYnNOQUFYcy9FT3dLKzFEMzZWaGJvVndV?=
 =?utf-8?B?cW9mdHpXR1luYlpzN2QzdHZuT3k1Y0pBVkdvNGEzam5kSjJvenYwYUswMjht?=
 =?utf-8?B?U0RNbExqc0ZrVi9VZk0xYjhOZ1FUakY4NlgzeFZ4aGZvZXdvbVBVUzRYUzlF?=
 =?utf-8?B?dExNUjRJTmtOc0tmYkdiV0ZGZzNsSHpDRW1CRk9Wc0lpbjVoQWtHcjRxZy9j?=
 =?utf-8?B?b2VHMEZCNDgrdFpKeXpUT2JmZ0xqSkx5elZ3YnZlSlZVODUxaVpCWkdrak1S?=
 =?utf-8?B?YlhVZVFhenJob3NocS8rdFhRdUFVdDBTdm9tMitUck1KWVh0WGZ3b2l2eE45?=
 =?utf-8?B?aGo0b3VhV2N2aFdHUVBCS1MrVWFPOG5oTUVtN1g4aFFTd05LakY2ZklGeUVu?=
 =?utf-8?B?eEpoMUFrNTExWmF2UHRpaXRWT3lRa2FsRnlaNDhQYVpTQ0dYb0xLaGxnek5k?=
 =?utf-8?B?dEl4Y1kxTVZoKzVXS25VL1lRWms0M0duN29yeW45NTgvbk93alBFOGZHV29r?=
 =?utf-8?B?VGhUUit0dW1jODJ6UWc2YTMzak92ZS9ra0NHNmJsbVlNeG5NRDFCaXBhL2ds?=
 =?utf-8?B?Q2YyVm5ZczhhTDNzMFVEbFQ5emx5cldudC9sZm1IWDl2V0lIeFhoa3NWcUc2?=
 =?utf-8?B?YjFsSDFWaWNjMW45WjY2UVkvelFmbnBYSmtiQW9YR0JlRW5OVDdZQ2t4YkdT?=
 =?utf-8?B?OFZhb0hoZXRibFFjOUtTNElpSkRjVHRGMGpPUUMyMlJmZUM2YnIyaERTaEl6?=
 =?utf-8?B?YUg4NzA3WHVwajMzQ1E5d0ppNEVFbXVOYTNsaXo3ZENyeHpzcjh5aitTZHVr?=
 =?utf-8?B?YkNkNE5HOVRsVytBL2oyalJDeWgvNHlodzNYQ2VQbDROM2d6NGgydjRwVThY?=
 =?utf-8?B?MjNYeDJyeFFUSEpsWlo4NXBvV1FjVlRyRnNQcDZHbXRjcHRTYnRpSVVtMHZv?=
 =?utf-8?B?NEhqbmNqMnZtNEFkTUh3RG9WMDlPREpKUm5laWEwWmM1bGFJVVVtSlRCWm1O?=
 =?utf-8?B?eWxkWWpLVUJ1YW5vWWM5OWFlSHk2THk3a0tsOVpheUxhKzBNVUx2U3Y5OVI0?=
 =?utf-8?B?VHVPQ3Z1SVlETzFKOTRuRE1HeDB0a3phV3Bkcnh6UHAzUEZKeWFkRTUwQWhU?=
 =?utf-8?B?b3NZS1pLcGxsMjdwUU83alJmVTVHOXBxNUZIU1oycXE1R0lHdFNCS0ZEN1J5?=
 =?utf-8?B?MlZRRGlOYlh5dDRzeS9iWDA0NmJCUk1qTk1FRFl1VXlOL3NnUmk3SUc4MUhG?=
 =?utf-8?B?S1MwVXhYWC95akpQZEY0YmEzdG1aWE5RbW8vQ0VCRzdNR2tHamFFMy8zUEZi?=
 =?utf-8?B?bUZkWXNvTEVkdUdpRU55K1pUcnlzS0tiRlpQdExoemM5SjBNbitsZWVXdU1E?=
 =?utf-8?B?bHBHcEtDRk91OGZqQUF3V2pVRTVabWUzdGo3ZjExR0tQSGhBMTFBUUVpNTRp?=
 =?utf-8?B?SWowY3hEci91YmdGeVhiOWdUUDdoRTFmVnlEMUtqRjluSS9jaUlNc1V1T2dI?=
 =?utf-8?B?ZzMzMk5Ja01aWEo5SXRJaXQrWjdmVUJvZTlNb3FoaUp3YXJ1MGdZSHNDdVIy?=
 =?utf-8?Q?E9rexH6Q/42ZGP7ozRylzy0B5rL7bwTyQX0OhI+95IjB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5F3A496F0010F43A923660DF62A687C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26195c2d-e203-41da-b2ab-08dc22af8abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 22:54:12.1756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FTB8w+0ljpeAPgXN4FlbRe/IiCbccZy3xxQWKSkLEzIprbtaJIrNjs2L4riMvn/K55gxbpoftk065y3RRifH4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_145419_682711_531A40E3 
X-CRM114-Status: UNSURE (   8.09  )
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

PiArc3RhdGljIHNzaXplX3QgbnZtZV9hZG1fcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkX3Nob3co
c3RydWN0IGRldmljZSAqZGV2LA0KPiArCQlzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwg
Y2hhciAqYnVmKQ0KPiArew0KPiArCXN0cnVjdCBudm1lX2N0cmwgKmN0cmwgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gKw0KPiArCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgY3RybC0+cGFzc3Ro
cnVfZXJyX2xvZ19lbmFibGVkID8gIm9uIiA6ICJvZmYiKTsNCj4gK30NCj4gKw0KDQpqdXN0IGxp
a2UgaW4gbnZtZV9pb19wYXNzdGhydV9lcnJfbG9nX2VuYWJsZV9zaG93KCkgc2VlIGJlbG93IHdl
IG5lZWQgIlxuIg0KdG8gYmUgY29uc2lzdGVudDotDQoNCnJldHVybiBzeXNmc19lbWl0KGJ1Ziwg
Y3RybC0+cGFzc3RocnVfZXJyX2xvZ19lbmFibGVkID8gIm9uXG4iIDogIm9mZlxuIik7DQoNCndp
dGggdGhhdCBMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KWy4uLl0NCg0KPiB0YXRpYyBzc2l6ZV90IG52bWVfaW9fcGFzc3Ro
cnVfZXJyX2xvZ19lbmFibGVkX3Nob3coc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQlzdHJ1Y3Qg
ZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0KPiArew0KPiArCXN0cnVjdCBudm1l
X25zICpuID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsNCj4gKwlyZXR1cm4gc3lzZnNfZW1p
dChidWYsIG4tPnBhc3N0aHJ1X2Vycl9sb2dfZW5hYmxlZCA/ICJvblxuIiA6ICJvZmZcbiIpOw0K
PiArfQ0KPiArDQo+DQoNCi1jaw0KDQoNCg==

