Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 21:18:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EA6610C8
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 21:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1EA6610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aeekxNbC/Gx/IQvwB1tWCpVD3AULQsu+Z8oPkkhA96k=; b=Z8YYUaboDDxPLb
	lT5tuYMvVTBamG7JRn9TZ9LpYBfv1Ox9ig+59/L+USL2qXBrVnHZeW3DaaXV0zvyHfHOigF8I0vau
	c73HC0xsA8jjb5C2126irsmrPoETsYb48Plm/3LFF1GF4Q1Xtb2y+ptev5F5JtDelrJ6ckEUPcVk+
	9bf868FKcSbog+OCiv0Ep4s3haxE7IFGcYNNEBiD1MW3LzdArMe87KB2qqU56ri5yx1adGSAF+cmi
	V6azfm7HcQRzqNxBtWWy8al5MvNRDjmrvBPhg2MGh6m7pSXR3gB7kgAQlT7s1YLGAQpVZG21yUoM3
	R4WmTTXWxqKBfiQOOcbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVKUf-008psw-Ua; Tue, 28 Sep 2021 21:18:30 +0000
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com
 ([40.107.93.80] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVKUc-008ps8-UU
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 21:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIyevTAolixaKItcM0sO02eo9feQejJrsl7qLj7OLh5sNvLs+NzI6SIX0ZCqdM5XVe4zlcGOB9Y6B8RFT1tlXYysrTNu4nQV5uHWYM0qNUeV8ZJPOz8Nr3jIAp4H2iaLqAFiOt1PufW4tgxWR6pma0ctax0e9HxKm+3BG9xU26gmFTq64gQPVtGEuZ7gcKpQuSYZbZkRgdmLqYxM3coBff3ouQvJZCYwFlMD6+ew0y1vTDeucvus2Tvv9jsF6phPzIKEFXXwoXNzYMtPqoy4Ktl84wdkkoqST8l13+Z1z1uaa1nxRJdpRAtk9znM7EOc5Xevr5jIu35LGcvfORnjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=GD1mf9+GZT+kJcpTB1KcND5EaJBS+kHdYvmHkvX2bFw=;
 b=aQJ9xTlqLBuhZooruWYTPKT0WGqSDO2PMJPmGRku2iQq45OidqfOehkI9ubPtNgkjXW1aXQ+tOhjpTcI2CFrFjKB2qtEPoEKsFc7k2epxcc2uzh0Qlm43nF3RSPZ5gRCQfMIJ5+Sjz249doqZ2UM/9OJZeiPRx0NYT75488PDwl4T8j4TLwLTILzVp+O5G2Rsqpr/w3wqHKHTeDutyo9zfJB7yS+AyYd6uonqfi1tnQ4hLmwc7RDZLYH4ScZe12O68SubBTTDOoPJhoxneVoJeyFm2dQ8t/7fdHnpVbNlWSeHyFuqvzSGSO4TQ6fhJt/Up+lGUXBiunMU56E0d/7dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD1mf9+GZT+kJcpTB1KcND5EaJBS+kHdYvmHkvX2bFw=;
 b=rtcChG3eek6o9c09HHkxlqjR/FVOQkhwnohzXKwyE2oVYl98talEUKq00A8cT88BrfTVXKdoZRwgblGcEYLswgLNdA6W7BEvFOH501blPSXMgek/zA8d8Du9t9GEb9G/yaBX1EKKoTmid2Y1r8ldxbgu5XyQhrClzpnLC2Dypb1+hMU+UcnLo2sx0CxjNdOM4gml8MPVoiZplXpQOtR+GijcJkk6GThKtMk9p6hkoJ3UsqWugbaw84lYmWXVagny43SUMx4oVnVjg/EcpyNwobc16Q6wUj5DF1tbuCoXTxvDjTVC/hNCC2ch2267MIrvExqdV7hdOeZepHIVBfPUmQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Tue, 28 Sep
 2021 21:18:25 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::8931:3580:e129:7d15]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::8931:3580:e129:7d15%7]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 21:18:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, chengjike <chengjike.cheng@huawei.com>, 
 "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "sunao.sun@huawei.com" <sunao.sun@huawei.com>, "jiangtao62@huawei.com"
 <jiangtao62@huawei.com>
Subject: Re: [PATCH V3 nvme-cli 1/2] initialize disk "access" variable
Thread-Topic: [PATCH V3 nvme-cli 1/2] initialize disk "access" variable
Thread-Index: AQHXtEXzdzaFRTAuR0m+qJzbXmOzGqu56waAgAAJKwA=
Date: Tue, 28 Sep 2021 21:18:24 +0000
Message-ID: <4865cf81-9b27-d797-2c01-53904271221e@nvidia.com>
References: <20210928085050.4141-1-chengjike.cheng@huawei.com>
 <20210928085050.4141-2-chengjike.cheng@huawei.com>
 <e916dbea-8796-5ed1-06f6-4d89c72f3b69@grimberg.me>
In-Reply-To: <e916dbea-8796-5ed1-06f6-4d89c72f3b69@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f14c35e-0831-4a23-65d6-08d982c581f7
x-ms-traffictypediagnostic: MN2PR12MB4126:
x-microsoft-antispam-prvs: <MN2PR12MB41262031C3883D3210F1DDB0A3A89@MN2PR12MB4126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FgpfzfrXzfO5FZg5b/wRdS9wR12jdCP8q7ckSk9zZadhkP/GKFRxRACka9r/Lv2j8Ei+cXen5Gz2MVbFmbGCX95XifEF2RH0KbGOc+6OSIUO72+Oikn/hP6D4HCcw/K74xS6NGYiE0eGlRIfmXMR4YjuOnYO4nzaI7vbGdrGdVieNe+KzY3om82+SnVu3TsdYuzLCY1oeszNsH8lCFWity2ao5ZBFklCaZkpWyU17Zl+BKVvmKhyo0JbP+9C7Mu1yNo+nm5bNn/iwwr1bogrgRhktv39PCtfhlT40tOyLfjmr+kF4SNiWC9heeOwG54G3QTIM9uZFm4AVcVdVrb+Kf+VuZdpiyqW7hD0xmy1AEnW/BfKMuQuwTenneOQqfNN+DmVrfcFMeXLdQJJpd0Z6AWKnynGpMc1ovux5bvo04q6dR76OeZBr2oCasrzB5BCG5+19SvxmRhwRe/5KRlwix/HOJPSiVgDyrsjs4DDYPb6d18DLJ4IKFpMnBeSUVbgm+1RR+QGpuf7fDUnZFOokwgLVgXFwscEx8TnxyibigcveLfvEL0IT5t6KwnnlTE2GZz904+Gh0PC5JGE6jGmvHqgTvPxsKWyGAJxWaNjXQEQW6KaJqPx2s8qtSb6wLOCKnSQnBai9WHLMXuKF6W5dosDe89/vaWOY13D+ll50/56VWpmR2Mk0f6XUGgdrpSDQf2avAggteFoqbkHfWW4zr9lZKwnHw758kL3E6u90BxM8NBT20jmgbIIzbcKF0469SLNlM+XocUu4tm2R4YXlA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(66446008)(31686004)(4744005)(71200400001)(6512007)(66476007)(83380400001)(508600001)(2616005)(38100700002)(66946007)(64756008)(66556008)(316002)(186003)(31696002)(86362001)(54906003)(110136005)(6486002)(8676002)(6506007)(2906002)(5660300002)(4326008)(122000001)(91956017)(36756003)(76116006)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0gwWHowcno4TFNLNFRQR1VRaUJIUnZ2c21wc1YxNVZLUU1QNlc5cG1oL01E?=
 =?utf-8?B?R3BJbmdrV3BjOUczZC9RUExxOVd1NWpUZzVQczJycmJrUkkrQ25qOTRkOHFt?=
 =?utf-8?B?aFFUNnEyYXE4cDQ2UzJWK1pKTWw4Vis3ajBLbDl2MWNVQXk0cjVOTjlPMUFR?=
 =?utf-8?B?K21vbjRuSmVSZ1hWNnJaYW5sRUZoZmgxem80cHdGWXRyeXRqR0ZXOWNpZS9Q?=
 =?utf-8?B?QmhZVVFVaU90OHdnZTNPeVJTck9jRWtkdVZmZU45elo5RE1sZ0J1TUFlakdK?=
 =?utf-8?B?QU9nQ2JaVjRsaVRlL3h4OUJTZDRESW5aeE5YbGFxSTBSaCtuUVIvSUpxNUYr?=
 =?utf-8?B?MmVzVm9VWkFSL0ZrOUZSKy9hVU5NajlGWnlJTjVXRkpiVkc2YW01dHZ0MkNk?=
 =?utf-8?B?VVAwVnNoK09xSWp3ZWsrWnBFWDByY1BOLzdIVU1LSU15Kzg0KzJRYVpDbW5w?=
 =?utf-8?B?ZEUybnZuOWlmYVF6K3VkbmFLN3Q5clRVWm5oVm5yUlhHUmdLTGVHcVlxMVlR?=
 =?utf-8?B?RDFDR29SZ0psN1plWVJQZVZ4dC85MmM2NlFuYW51OStnMGMvYUUxWmxBeHM2?=
 =?utf-8?B?MkQvZFpaUDVJVFUvTExjTnI0cWdFVUp5ZHJEM2E1S0Rad3VoWTdMWWFnQ1Ro?=
 =?utf-8?B?MnNoNmhaSmFBZTBJK05qSkhOSERjNkpMTk8wbjFaQXZHMTVSUGNwQkM4bFZo?=
 =?utf-8?B?a2ZOeXRFZFk2cWZVeDFlS0F6b0dOU0RHL25lR1lsbHJxRTQ3VTE2blBOSmNx?=
 =?utf-8?B?WDFtY2JvTXlJSDhyY2g3eExNaHE1dkJCUS9hZXZZY2c5RWZaa1FFMDc3ZzlP?=
 =?utf-8?B?SEZPYzZ1aUdFc0VqRlpBQnVha2JIUFhNMmQzOG45SncyM2NqYTAreVJXb05C?=
 =?utf-8?B?akJ4OUt0TGcwU29YdHRWMFZWcUNBdTF5Zll6Y1V6a2JFZWs1OE5abDQ4dEVQ?=
 =?utf-8?B?a0hEcDQyamkvSUQ3RlhDNmhtOHc2QUhscXZuaXU5bkNGWFB3bWc3NzRrV0I1?=
 =?utf-8?B?YlZBN1hMMW5yUWFXem1ZZjBxUW9Fam4xa252YXR4OUd6V0RTUlk3eW1GSDNx?=
 =?utf-8?B?SE01em1wQzQ1RlN2THRuRFUvazJJK05HZi9nSjluTzhCcytkamoxbmR3SllB?=
 =?utf-8?B?bTJyUTZmM3MyNFJqQkgxeVNlSG1yVlRvVHcrbXlKNVJzR2oyeFcwOERTaHZ0?=
 =?utf-8?B?VjhYek9jTlhLTXJybCtvL3dDWStTMzYzdTlLUHhuZ1YwT3lROHF3SzcraFdX?=
 =?utf-8?B?aWk0Y1N1d3ZBQVVXVVZNYnZMNGdna3BMOU56c1drSmZOanh2dStBVEVjeFlE?=
 =?utf-8?B?SnNJWTBBUjNCYTdxc0hvN0s1OFFLNENSZnk3YTZHc0FmZGYvVjEyYU1lNHJU?=
 =?utf-8?B?Nk1NeUtNeW9HWkRJRzN0WWZZeGxpeHJKZ251WWxKay9qYnBVR1J3WTFnTDR1?=
 =?utf-8?B?ZEU2cVVublhsa3ZQczJudzlXNWx0NlphYUdPZ2o3LzIrTE51OHdxY3NoSDNO?=
 =?utf-8?B?eStnaEtjT0lpeEZLTjNBU3pCODNiYTJLTTJkTk82c09ad3Jxd2xBN256eEhy?=
 =?utf-8?B?RGVybmN4dVptbi9tTmlXWFdnUndyY05EMFlYNlcyK28xNHRTSGFlM1MyZjFj?=
 =?utf-8?B?UkRwY096Tkt3MCs1VnpGallWUjNOMEFJNlZIVmVua2JwdkhmVWtWWGVjM2kz?=
 =?utf-8?B?M2daTWVQQVIwN1BOTEx5NFExZ0tiNUhSMHFMSlBQK2VZeTJGcUhadCtWSDFp?=
 =?utf-8?B?TEZFU3dOUHpGTWt5SDVDeXdyYWxneXcvWmhLb1JoSzJjUS9wV2UyVnlISkVL?=
 =?utf-8?B?d0RXWEhQWlFBbFVXbzJXUT09?=
x-ms-exchange-transport-forked: True
Content-ID: <242258A42E11EB479F3A34D7EAD1B9B8@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f14c35e-0831-4a23-65d6-08d982c581f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2021 21:18:24.9548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xh7wQRoqgVuCurxCVzMYsfBZC/S2c3m/ZDj5TSp8XdoMuk3hWD2mavkaQyvBXZ0Rr4CZET8KHBpYu+vAUpA6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_141827_018105_4D0846E7 
X-CRM114-Status: GOOD (  11.97  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Also live/faulty is not a good terminology for path access.
> Maybe full/partial or complete/incomplete.
> 
> I thought that this was about showing the completeness of the
> path access for a given ns, regardless of failure of identify-ns...
> 

since printing the path access and id-ns are two different things,
id-ns can fail and we still can read the path access that is why
we should make this an optional print with command line arg feature,
if it has been considered yet ...


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
