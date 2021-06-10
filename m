Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7631CC48BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 20:33:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F27D61287
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 20:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F27D61287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3tAa7LG+tFqU0jxRfTHNCXGMq42OTXqXgVVWXo//Gxw=; b=FdCj4z4fIh3j4Y
	/v+UtBtDeD2RmWLs8HC4jU4n4oqIUdfhZGS3IYV/u/8CllVOU8/n9DSyr6xHZ/gCLEc4iAOmzoL4F
	4R3sU998vBOgSZmrm41MEdVHsW1gqijbETsTFLxbM2dR96GoNBiuEHD4V6yIT60y2c45SfaD0Ybiu
	hYK+EABBcTekFr6hI4RTZ5Ova3kc95fh+iNs8ZRW8JCec0o/wmB9NJ2fZZwIlvu2DXeOZ/iFQbp73
	I0+Cg+KiOOEQp20vqNvoU9GhgOJAHbvn6H1C7cD4+dIyLlctz4fqxBb3YcwLY/136GBRRf9oTyVTV
	nLemsExT8oFoDqW4hKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrRMP-002PHM-IL; Thu, 10 Jun 2021 20:33:05 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrRML-002PGl-Id
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 20:33:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623357182; x=1654893182;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HdqWAnEzI6XvvsM+gDgENTG4qQxO7RQ5dAUE26zDLUM=;
 b=kL17zMeOx19pRBi3ogB2Obt5EvllMluh5aCkRdqy/gBq1FnyLsui69gU
 ZWqbVKFemZ0zeBky+cWAFL5nlU0R0HPjSwR7WQbFnDwjqZ/ciS+4MmG09
 VBDYsDIPPmfHeSlPIe+69JHGpBaXCyxskRB/kZb0lr0eCzvrb+OqkF6XF
 UTJFISt2pyUKNQT4uWXYB1T58Pch9yxvuEwMk58k6bcAN35I/edffYS/Q
 zEnmqVREoD8HKnpYN/jMWi5gmkpqxk//jxfR3xFgumeh8roaIWOLmdlsP
 C0MGaHTNmeh0873LSTbnFPYCb6IlKMliYV/f30S61q+H8eua0Yfy9ppuL Q==;
IronPort-SDR: AJN1/tR9eQXPG5sl+zp4wo4laz43c/V1MQvHtsm7QHVSb+c6Y4eLimXrJYyYtilcGt88BzqenY
 WQ44OY5IiD1ynTHbv8IJiu5w0SfEk/4GLTySiz13lGd4IpUFySduvYsYrMfZGnkveBwkHvVvs+
 EUfg6AebRjx+OMOzp9L9w+6Lx8ciqCFmXukpC+RQd4dIMs862SpRUTUt9vIL/cGSLqxY0Jlxqp
 ZzN1esqshyBGUn8iA3r9Dy/aSNkNEHlobXJkLl55vok5U1PYJiN/iCWCUW+N+bZh3dRp3V4vWA
 neA=
X-IronPort-AV: E=Sophos;i="5.83,264,1616428800"; d="scan'208";a="275301964"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
 by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 04:32:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TqkqorKAUWSHaErlxXikcYNirPe3IOwgWtKM4Z/01VlM91hbDiiEFgzNMgrUMjReod2wUwTIjE9QSYinJ5AJ5VpYWA1hctVb578XSAJ7RaCF/LHC8p8wRhou4XvUircG6bPMcHff6PVY2qn8XOS2Ew10tDdLhcjcdi3n/rrnqvTM6B+wBafYS3uzqGauoFlaJcodLs1apPj75JkQTckiXIKNJrgho4A7wltOqBIjZ7RagwzBDd68QKc7hT0eiuVZjliVNI0kgfIlebj6YOXSm07DZ6Pn6FBRnnCNP5syWuHv28O9V2obrNoiNUfhlhPDXNtl/9Tp2EkhvG1fWbDZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtBz/ywI5EwY7ox/zGh4g2Wq5XTEipd0MCGBJUuU+7k=;
 b=Q9exwJhteyujOwXMDN3gtbNwzwTI1xn7q/+RnafGWRjjL/OoFqx5b5UNxopUNEBj+OOga68LKEa9R5dkBmGin5l+QNQQOUC43S+e3/uV2DAxYUcCh6qXxm6FsoN08FKWsjsTwhLX9h4yQ3sK6Cv0PRS28sKm8K7F88tPgfgK3+FlcFJOgvAiX12vjUqzJPtBBxwNrQYGTF17ewugIE3du0j3bEuxd0YqOGgGsPt/CarM96wanwxQ0BAQHD6leT5iTObESfbHj6UA+3xtCTyFvEIRDZq3h5oDqeruJFj7dZcrlwTlrhCtm/LmA8DRAwD+fi+9rk8Lzb8CPPftFpDMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtBz/ywI5EwY7ox/zGh4g2Wq5XTEipd0MCGBJUuU+7k=;
 b=tjVuluu7ZchL2KhqNUzuXInw2qYBLXcAl82c+hpFNBVSyT3UZE6wdHLELuoJ1etjF7RxtSKMmCU/yclEhg4WUUY/jymhGhapKvxwaNha4ujv3nY3Efc1ylbZhNMpYQNfqjnNqikxwa/3IZucBuY+/TnQOFZg6YzChYqWNt5eXko=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6803.namprd04.prod.outlook.com (2603:10b6:a03:21a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 20:32:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Thu, 10 Jun 2021
 20:32:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Topic: [PATCH] Revert "nvme: verify MNAN value if ANA is enabled"
Thread-Index: AQHXXaK3o1g8yliZMUm7tWfZRJ//BA==
Date: Thu, 10 Jun 2021 20:32:56 +0000
Message-ID: <BYAPR04MB4965781915C1D4AFF2830E9586359@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610024539.28875-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655A9B821FEE29D7A89E3986359@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210610074546.jyqjalpldii6reg6@beryllium.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a86263b-3147-4412-d032-08d92c4eee0b
x-ms-traffictypediagnostic: BY5PR04MB6803:
x-microsoft-antispam-prvs: <BY5PR04MB680311CB45032F442E7B01FA86359@BY5PR04MB6803.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2BhTFhpDrXCw62g3qeFF7GFvOtwZdpArTIg4Fz5OdNX0l15yLPsCBUwxQu6wL3H+VJj9/e08NImbgwTLB9uuAvslWN2UX9qnBc+jWDq87lFhf7h8oy8kzbqO0C/M+n6kxb2RLacDCYHSTxZeqSA3EUBsfwXCEGx+tlsNMBNuYnJtf+WV/O9xe/vNq496O8ci18wNFDngeGcGJyokVbc2qGq5zdtjnLlrgRX735+UheKZZ2AR6cO3/9dKNGSjmttZ8F+HUsKJA7S07nvg/AhUWdUsU6n/XNcyX+KoRZcVl4hyW34/bxhjHr3VEe7d83k5HJzBVapjqS6hl00NZgdqL5iYH7hVD7RALPfbXy4yPlRvUHvvPsCXIKhYNVQQewFVxIggTR1hd/OfqRd6CoIRMt8WIpPVaFVWm3JYnqgOQGL4IV7GjniFH3PQH2aAOz5glyg0cskdGZj0JbRHH7f2KlipvW67p0lsPLYGRXrhCCk6YNBVEA1+LYrcBkgfdnwpcfwWDZkeTDMw5Ky5Xteumu3elFVWa7kehdj4rLMF8V7kNro1TBxWqjo8NtepqVq3LMfE7sbKG69YD6TchmaiJCo9PitOhVqJVfuPzf1J2hg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(52536014)(4326008)(33656002)(53546011)(7696005)(6506007)(478600001)(83380400001)(2906002)(9686003)(8936002)(71200400001)(66446008)(86362001)(66556008)(55016002)(122000001)(66476007)(76116006)(316002)(66946007)(38100700002)(8676002)(64756008)(186003)(6916009)(26005)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hHgP2UiHp0s2hn+RDzFcA+AT52/0cHqDzMW901YgGy+0G5e71gN1kxk5Jb4t?=
 =?us-ascii?Q?tOdI2vuSCrYqCzFIcm7hUNuGudfPAJ2o0SA6SC84Hh7L4HGqx1H7dzJ8kuLJ?=
 =?us-ascii?Q?csevThFfi54/pnesYh6UQ6+lg4xpoLpeok3mofxQR2cAI9P2QZo12ctfxNbq?=
 =?us-ascii?Q?IC5DuER0C6SFjhZLifqwamSInGPUgCM216asLyTM6uzUcQdGrqbVbdiZnTk2?=
 =?us-ascii?Q?/ga5MWWNQQYHYafgKa5a0seRlB7+Z+T0y7IigmGW5vZyCd6ZLWqgWnaVMOtD?=
 =?us-ascii?Q?bks/COA5gcLen0wLFd6P/eRch0Z+Hem3rBonLZIMrIqIQKVN0oM2qUfQhGrG?=
 =?us-ascii?Q?uLaqnl932mTdYrD+ZLPLjWrTx/OLhCIYUcJYi2WTyz+P6voyPOIiYpQH5Kle?=
 =?us-ascii?Q?LJM0VQfGICen+Sskn8t9w870n3kTB8IFXWx4/czZmcm7Qa/MxT9fk8cY9FPW?=
 =?us-ascii?Q?Tzkc7CxlM5rK4fSloJSWr7aekMwYDnj6O9FHquoPK0LcaDOg36tvfbHVpgtP?=
 =?us-ascii?Q?/Bi8JPKLhLlC+jwzTQTvP0L3wlsPnMsXU2INZGAj86wlkmyPSMEg3QZh3iOI?=
 =?us-ascii?Q?V1XUF2JKpZT9zsjJeV6nspgthHChz+/Mtk99+Nby+3yxDMAWOvwv3pYowm+J?=
 =?us-ascii?Q?6RPSqFo0lTPU3AdUdtmiK0mXX4bR6Wz0VQeJVZmtvLH6cypjtIkqFgEhJhHF?=
 =?us-ascii?Q?v3rPUoGxiw4IOC0IveZYEDQ4cP1hg3TFifbNF5bBX95dM34Ki9lspNuvRoKs?=
 =?us-ascii?Q?dg02BeItXIvnJ3maGnDgJWkFgrGSZ/z8agg6rFxqEr92I9Ct9IJnYbVSJWZw?=
 =?us-ascii?Q?m2wVcx9XlEi+pIyYYf3qsjX0vDklaK6fQ7Nd/bKZXNqpf2YyMspJWl6KMLou?=
 =?us-ascii?Q?pFm6gezUJuAX4GqAxJkMqqL8nw2/E7D2x3UoYb9GT6xSy4p+hRWIZp1aA0as?=
 =?us-ascii?Q?HntQjyHsTVkiCkHlOzs52F98EhtEJbM0gWin8UXoPtTO7Drte5jM477ZBGvv?=
 =?us-ascii?Q?/3Zb11TsAAGuaFgOL1MFsaa+yqyaFSODKlYLFOyphkkh4oVghhDDINUcnfXO?=
 =?us-ascii?Q?+bxc0atUYbv0MolhEuWO0KtgepKsba0uQGB+iREM2WpRYezRhV4MLmoQW6RY?=
 =?us-ascii?Q?TEjFSQoj7Ll9FRSpbfINgHETn6/HX/8GjXa1DTAImvxCnWU04JARD8DqPmJP?=
 =?us-ascii?Q?nNggOe2HmKAVGRwQLPotEo7JXWOUhDMHjOoF35UEKPdVHKUQizmvZEEU/QE6?=
 =?us-ascii?Q?afqnwGQhxBRUbNyxJyVLTyehtz9wFgO3RSJVADwDRX/qlQAlm0r8nRVpdo15?=
 =?us-ascii?Q?HN88ehxRcKTqSB2le028px0e?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a86263b-3147-4412-d032-08d92c4eee0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 20:32:56.1159 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E6K0d8004v4vy5lxR6w3P2ne4+TOtRVVlblZdEgwNm6aUHivObwXdOHwT90I+euX5jKVn/N/Bg4E/P1ixu0VAAsENQXB1mBFimvYw9xC7IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6803
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_133302_568640_AA3E6A77 
X-CRM114-Status: GOOD (  18.78  )
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

On 6/10/21 00:45, Daniel Wagner wrote:
> Hi Chaitanya,
>
> On Thu, Jun 10, 2021 at 02:55:08AM +0000, Chaitanya Kulkarni wrote:
>> On 6/9/21 19:45, Chaitanya Kulkarni wrote:
>>> This reverts commit 8872c159c7a83daf633768cee7a7ef7154010341. This is
>>> needed to move forward with the blktests for now, without this patch
>>> all the testcases result in the error :-
>>>
>>> [ 3502.072798] nvme nvme1: Invalid MNAN value 1024
>> Thinking about the code again I think following should work :-
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 23573fe3fc7d..4277f1554bd5 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -813,7 +813,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
>> struct nvme_id_ctrl *id)
>>             !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>>                 return 0;
>>  
>> -       if (!ctrl->max_namespaces ||
>> +       if (ctrl->max_namespaces &&
>>             ctrl->max_namespaces > le32_to_cpu(id->nn)) {
>>                 dev_err(ctrl->device,
>>                         "Invalid MNAN value %u\n", ctrl->max_namespaces);
> '!ctrl->max_namespace' could also be written as
> 'ctrl->max_namespace != 0' which makes it more obvious what the intend
> is here:
>
>   If the controller supports Asymmetric Namespace Access Reporting, then
>   this field shall be set to a non-zero value that is less than or equal
>   to the NN value.
>
>

Let us look into the host side issue first then we can move to target side.

Consider a scenario where ANA enabled subsys with 0 namespaces on the target
side. When host issues connect command to such a controller ctrl->mnan
should be 0 and ctrl->nn should be 0 which should be valid.

With original check in the code :-

if (!ctrl->max_namespaces ||
    ctrl->max_namespaces > le32_to_cpu(id->nn))

!ctrl->max_namespaces will return in 1 and due to || condition will be
true and code will report the error. The change proposed in this patch
with above mentioned scenario :- if (ctrl->max_namespaces &&
ctrl->max_namespaces > le32_to_cpu(id->nn)) { ctrl->max_namespaces will
return 0 and due to && condition will be false and new code will not
report zero. So I think above suggested patch is needed irrespective of
the target fix.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
