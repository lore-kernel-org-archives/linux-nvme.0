Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93C6C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 18:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SY7ebD/TvuhwcbgdwRC3+WUo2gnRCZasIbHPv1gCtZA=; b=LbtiaueiN7jsWbXHCrBZquWCzM
	wPDp/ULckGBgvEF3LuubRWaDMdWxqX8fYlOCyyx1zbeQ+JqdFmhLv3jVtHywN9anv3CdE+K10TtlD
	1JAg5E8eWzYkwHfZNRdyUT8IDqsYAzKU6gyc5k1mQYOz34UB1bnvafAchT8tltEocc+CXWL6VtQWp
	3j+e30iztvhEE5SQW4ht0KZy+u6Cg4h8TKdJ1cVH8adPjsgcrOUAqrrurCNPjbamfPw/I4B+uAlTV
	79TfRqN3t48ZkLQ/3MazyjY0vvQumTesvKWWRQorm6+zpi39rDXpjtOWbNq05Pf8GgAloLXyiIP/C
	V4If7Jkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paLP1-00BbPZ-1z; Thu, 09 Mar 2023 18:54:11 +0000
Received: from mail-co1nam11on20607.outbound.protection.outlook.com ([2a01:111:f400:7eab::607] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paLOy-00BbOP-Rk
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 18:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhMw7hPI7BfR/7YqJWUTxqHdQ8oyb4FAeNGwLiYTSknBFtvPW3K007NHpn+yTPXDbdYPzdoZ+D9x50/Ln5QIUxbn0pHBQbOfkuxIGTZqhObtWfQQDYd2qdKtM4Sjg5+ZQSzBWuQNs3TKJjx3syhLPd9OwH4e3GNR9M9IlzqnDZDz4e9f/MrgGKZ1jTah0HtA6HMjOywnF1HiWNf4F5QAiZeO24XQysD6Ki8YOIq/+Yw2QBH2qPG5CAkPs/F2X7bT9ksCXW5Dd7/LzHOv1CY3ERJwkqhfVDIfmLttpUo4N8UCBZH//jqxuHclbCtE9bHT5DY0OxRxxWLBdJuKUgRI4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY7ebD/TvuhwcbgdwRC3+WUo2gnRCZasIbHPv1gCtZA=;
 b=ASITkPr95Y86YYkkOlqRq+uY8yznjatAyl45a+JqcwvgJsyxZtPU7WedI+docghv99W91SeTAFpUphipQvSHXOcLqc7DkxYAq2whkVmNaqle/NmDvOShzAoim1PbuvVRgYOWItfSZiYbMmKrEiYqjaPv3FYoeaxF2CGIWvaoCuLBrry2hh3kJlTEDpFdz/PE+xHo5aeGSIFm/CYqd7CQd8nO/CiTPeM7ol4nU/r25mfHELfZ0erCq7W+AFkRNKDXOkhMpt52EjBeEAl8T9aQk6ep75zayoYrppJ27J31LPDQM7EES59gp7nABdTV/TKzjPIaXC/FhmPIkE+vObAsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY7ebD/TvuhwcbgdwRC3+WUo2gnRCZasIbHPv1gCtZA=;
 b=B87qn3n2kLRp1WTfpR+ZYN/g51b/S2GuqJO7NiQhNJ2mgDmoS6U37NGMDvRCa0gon+UJLDguB+7MMDcEFG1Wn62G+7BoFy9HsN2QiuqLs0FJsakbkL8zJan4Vz45nDyLR3XOjAu4zPUm98O4HmFtuwCKFbV3iIvBdJwOuEou3p1H9Y4q55DsxuZYw8mhu95PP5P11CQmF5kJA/J/0pNi4M0Cldxn+apzOEz8a6zF5/sMIyqUlw8i3Txw79ZrVZSXn+CFolN69g5WRQLRVBsz0IQ+urdYNWb1O6ZCY2AqlYRoALhoomci/lHx3U+YV44Lcsy1NRZYkEPAKIAxJYn1Nw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Thu, 9 Mar
 2023 18:54:03 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 18:54:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Minwoo Im <minwoo.im.dev@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-trace: show more opcode names
Thread-Topic: [PATCH] nvme-trace: show more opcode names
Thread-Index: AQHZUpTTzvD8hwSuekmSopU4aVBEka7yy90A
Date: Thu, 9 Mar 2023 18:54:03 +0000
Message-ID: <ccb2ff90-e90d-30c5-bbb6-2ca168020efc@nvidia.com>
References: <ZAnttt3/8EYeMn5f@minwoo-desktop>
In-Reply-To: <ZAnttt3/8EYeMn5f@minwoo-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB7526:EE_
x-ms-office365-filtering-correlation-id: d31fa638-2123-479b-fa03-08db20cfa6ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  y5tbHCDGTpyXIfEOcXPv4W85Ummbrw6d/L+iWUKshJdsKUZc3yyU76s7+38/MmNs8v3p6CNF4Ci9dOvDcfDTYZxD22Bt/R+BOJK0MpEGSVwULLIjLyrHCL3VCou9bg8uYEzyFF/FkO09xwBTvL6cyaOz+M/C48oY/ypgSmPHh6a0QQnVOlJJ031E0UMTyWb4kfHdLiB7DM3ng7Ui0r3eow4A+a6H7fbrlPRMNBhDOUN0rIewwRo427reOAoiWtu+W/Mr/Mh7c/JsIx98TaoUgnN2gTvNiw7Mxzn+dh3KaofF2T0d/9TE2yRNEJIox/FptdsnFB16+/Dhoqu6aO3uN3E+ax5G33unSacpHcicPu/XeB8Piwq9H12/QmcfldNlPSDtzMwfpMO1mmGq0wQQHy/A9c0zIUxcgpKYFPLmqjaGgilpbcdlmPiR2+f6jcnE5Wi8LxYULuNUE4msfWxoYPuAoj5eEYAjIPMfA4kZxKio/ciZ8gVa3FSmQTp8HRTxXw23O5E0SDsFhTWtPi+XtmLfnmdu9E1QiHDwSTUZ2vqXc7sQ6C7V9Qv3wu4vQFBvIRM4MBmhvBnIvxbW9/rTpwGGztKLW9I0VXYuMzsK31mtj3Nm43QlyXkdn+MTeaB1ggyyad7Cra6RLvaxwLat9/ZM0VdyMDmAOVsRFqtuZ5syyvRJAEZM84/ZsLU/48A6Kb09DeHhcYmLKdeoLf7uVm1MygHTAdoo6T9UNcIPEE2nZSL9m0f+IaLUI3NIrY5OwtMPy4hSTflj0gjb6eJTMA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199018)(558084003)(36756003)(316002)(38100700002)(54906003)(110136005)(6486002)(71200400001)(8936002)(5660300002)(2906002)(66556008)(66476007)(76116006)(4326008)(66446008)(8676002)(66946007)(91956017)(64756008)(41300700001)(122000001)(186003)(86362001)(38070700005)(478600001)(31696002)(2616005)(53546011)(6506007)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MHZ4azJjUlRqWDlYSnVjaTZYVk9oVUI5UDlBRjVLdk9BZXhsSjVadlhoem5N?=
 =?utf-8?B?OHBrcTBQbFhGc2I3S0dnbXE1MlU5UzIvdno2OWZ3YnhoU2VteEVSTnR1UnB6?=
 =?utf-8?B?V1k1UWdoWm5sRDR6enIrN2tSTVIzaDdZVTIrVWZjTHdKaWt3T1FBdjErMFUx?=
 =?utf-8?B?VnJlRHZNZGhSbFRHSUVpT1RvYS93dXR4NUxHU0RvRHJDd2s5QVg4L2dEQkxG?=
 =?utf-8?B?aVZtQmdEYjduZTVCVFBMWmd3U0tNODBGV3ZrZEQyelBHRlJES1VMZTlyVDY1?=
 =?utf-8?B?djZSSUdLTG9XdVB4eXkzLzUyd1JsbzdFaFI2emx3MC82RUpNYUJDN0VsS0k5?=
 =?utf-8?B?MnZLLzQ2OTJoY3pKZU1tMFUvU2E3U0U5cEVGUjI1WDgwdFhJeDd4MUhkdGtl?=
 =?utf-8?B?ejlzY2pUbmU5OWVZMWs4MkpqY3VTOGcrZzZNZ3p4K2hpbGwwSFBYRUJoMXpz?=
 =?utf-8?B?aG9sMUhHdmlTa201U1k4UEdiM1FYU2dBQ002NG9xV1orS3RHcDhucUVKUnM3?=
 =?utf-8?B?MWVrZTk1dURmMDBBbXdlMU9WSHNOWW92NGRXSEVhSGxLNEh3MG9yc2h0R2hs?=
 =?utf-8?B?WGk0TDhvNHBMMXJsTkg0VFA2QmJZVjBhOTl0QmVtYS9SbHB1cDhFMEpodWta?=
 =?utf-8?B?N1ZXSHNJaFRKK0M0dGMvaG9vYktQVGR1MGs3c2hTOUJqbTJrN0JmMzkvQ04x?=
 =?utf-8?B?QWp0Y3hUb1JHU0dZYyt2azlnbGo3TW9XRVlCeUJndEp0MDE3Nkp1ZkhMaGNS?=
 =?utf-8?B?NFphNnQvaHBtTy92S3RFMlg1TWlPNGNSRG1NazVPd1BOTnRjY1pXZnZ6ZFJT?=
 =?utf-8?B?VVlSbVhDN0FGWDk0OStEaHRmaG1LTmt6THJwcDFzRnZ3Mng1RjAySnpvVjZi?=
 =?utf-8?B?OEozSjRxR3hqaThsSWc5cDZqN01DT1hzdXhVMi90OVg0UG96VWNvQnZUK3NV?=
 =?utf-8?B?SUxIWnNQd1lGVHFONEFHYisrdGEzYkRldVcrcFRjcGNqWUYzOFhnNFBDaDBZ?=
 =?utf-8?B?cncrbGwzWjV4NEVPSFNYSUQ0ZWNYN0VZNXZrei9ONi84QmNJd2xNTE5WWUdz?=
 =?utf-8?B?S2ZBL0x6ZU9ZQW5CS1VpVUVZTktSWTgzNXdMdGVXMVB5YUNLNW13THRyZ3Zi?=
 =?utf-8?B?dStBa2JmRFY0bzNqNVVFQUpkS3A5ejQwMDR3TzcwdDN6NHNVOTJMVUo1Vit3?=
 =?utf-8?B?VFZQZFJuakQyQVBjNTFaRG1MS2hRbmppWjZKeUZPM1J4VkJLVFpUV04vREN2?=
 =?utf-8?B?YkVOQ29mS0VLVURjaXBhNW83NnhmY3c3c0drSnhnVFBFK05rcTNrQ2l3RGZS?=
 =?utf-8?B?WXVGN0tIekEzZy9jQ1B6dUFxa0JRT3FGYlZEL0VDK3YvR3FEQlVDZ3FVNkhx?=
 =?utf-8?B?UjFKN09mOS83MnF3RU9CbUx2ZkYxaXpxbmkzbXpOWE1PUEo4bjlFWHd1K2dT?=
 =?utf-8?B?NVJXLzhqdklaV2R4bnUxSFRTM1VVUmN0SXhmUEdDckFaTGlpSytIYStHeDlk?=
 =?utf-8?B?MkFqWW1uc1c0L01JN0cxcm5CTjcycFVyZHEyTWptdU9ydS9lZ2JFVkR0bmtx?=
 =?utf-8?B?SGdpb3hsK2lyU1dBVG82Y05Kc0JTUHZCakNJQXZURmIybnlFcDdCazNLb04v?=
 =?utf-8?B?d2k4c1haakRUSm4zYm9CYkFnZk15bWc1Y0RvSzlIejVpMExqc1NZbXZyQWxY?=
 =?utf-8?B?LytMT2h5bHVjQlpROUdBK0ZRQzNTL0toYlZlU3lnYVB0SHNaQWUvUGlUbVF0?=
 =?utf-8?B?Z2lKU0dvV2VyR1BkWk5MYW5TSmdkejE0MVk4U2gvMWZIcFBvWWxwK0g4WDhq?=
 =?utf-8?B?N1oxWXNMOUk4TlkzUEhPZ1BPRk1mOXM2MndOUDZ2dEZjMjk2ZGhRb0lGRzBU?=
 =?utf-8?B?bkNEM3RJdnhtUlRZMXZrWHlkUFN1RFBwTWhKNGZaaTJrSDNDUDdqMU9nVVBw?=
 =?utf-8?B?RERKSFdRc0NjU0g0d1ViVUZCMFhNWHM5YnZ3VVE4Tm9ta2ZRVzB3RmZETFBs?=
 =?utf-8?B?c2ZTNGwzNVhYZFJrUjFzNW91eUZ4V0VJajRhTVJ0RUpJbVltYmI5NHJRZWJB?=
 =?utf-8?B?QWlQUnFhdXlsdUdNajJrQllBSHdyWDhUVXRUUGdWdW5waDRrQ0ZZbTY2Tm9u?=
 =?utf-8?B?YzZHT0JGZmxGRHRNTTVUcjFSam54bWpyWkRRRG4wdi9lQ01jWGE1bDZERTkr?=
 =?utf-8?Q?/jHE0geqTBj0QCKlJlxA9ky1rEqGYNVDorG3EVmLSuNr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A32316A8ABAC44A852B6377C01139C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31fa638-2123-479b-fa03-08db20cfa6ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 18:54:03.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YTA6IpkotceuhxJDl4hDdUgN/O8TlwB4wxnhZCuX0iSiLSk67qJLovP/AbUuGKrLn2Tk/1kmcHKxSlmzrHO/pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_105408_917194_D5AB8B77 
X-CRM114-Status: UNSURE (   9.17  )
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

T24gMy85LzIzIDA2OjMxLCBNaW53b28gSW0gd3JvdGU6DQo+IFdlIGhhdmUgbW9yZSBjb21tYW5k
cyB0byBzaG93IGluIHRoZSB0cmFjZS4gU3luYyB1cC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWlu
d29vIEltIDxtaW53b28uaW0uZGV2QGdtYWlsLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=

