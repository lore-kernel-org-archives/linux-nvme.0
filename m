Return-Path: <SRS0=TIQn=6U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96A4C28CBC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 23:43:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93DD220735
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2020 23:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ECqlDEx4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RSoGo8vI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FSAPorew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DD220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=1izGl+K/r7fGlGocIhgWV9ZnToRTQwnFXCpk88dFpvg=; b=ECqlDEx4dzvyKj
	q0cuztW7EAXHW0TFP+LCoEUYBEngmOuMc8zoNH8eKo5QaPMobgLH0XLHbm97Z1/NG+2obExYlJ6Jm
	rPaNxGvLWX8xaoiSX3vWE60Pps9TeT9xeoI41XnuiuTAmMoCLNislrj2Mvw++st0jqGLS2ReBRbKQ
	M7xyu+5iOmAzByazo5sJ9EhwW4vE6KoJ+07jGT8S393PgsB/39F2vqf6cfXMUWz+i/Mji/JgyYUGb
	Pn5EX9ukBYpuY6/NW/2gvzK2Jsz2TsgBX/mClUMjYm/oLRltroKnQ8m/0LLcVfTRH8rEiqsRrtHib
	2iNUvbUEKQbbjW6Abgdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWThF-0001vW-GW; Wed, 06 May 2020 23:43:25 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWThA-0001v7-0r
 for linux-nvme@lists.infradead.org; Wed, 06 May 2020 23:43:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588808609; x=1620344609;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jf5gvOvuCwIJKcAS9JmJdrBvoSLZ/M51ghlrg+U4kAQ=;
 b=RSoGo8vI6wNi16dziFXb2aXliJofXBPnfo8LyahLDRF+I/p0y4OJ0Ffh
 9q834L/AUP4aXGGQmaQ6bRn2uYAwmZDEAM8LpO3SAqlMsXeWZCB8gKLFZ
 6sKUC8TbYlSVyQWH1n94Rg8nur0tIEDrG6MqtkKJb1S4817Q+g0yHovbA
 wjVlIkbT/CDoktGv3NQdCHpVUFX9+CHvgy7jf1pkr5glt6dRgO03Y9NI6
 T36wbKcudoaOjLJZ2HnDMTLS0hLhLURQ6iKNYpCP7gXoz1Q5xoDi+GwFV
 +yZgkJ6hsw+Q1X6jKNnXXli0KzVdscM9Asdu5HmACU1B7U0vmBuzOcF1w Q==;
IronPort-SDR: +mXuS2uXsaGqmNNxKP0Yfn7JaDVQ/1px2Rru/Zf/SHhK0i1QwodcfTBJvHgMFFuY/tqte+KZI+
 KPrOLipgDrqVn0SOtIA3WNuYQmYoFuTLvxNdX2noSLXVWhP9EXbO6c0OZmgBf3nf3oLfVH6nIR
 cOlKjXQJV6DDgGAwW7lAS7xauA0gNvbfQCxO+yYXo8h1BzRkuS918FGJ3kSGOLuJ/iDZk/Ui23
 sHcG68dt/mlOBe3N3BV1wcC7xIoKRXZFx4PG5Jbb3u4dEfF3DvZL+PZiBe4nBnNPjQKQs8Rcr4
 qEE=
X-IronPort-AV: E=Sophos;i="5.73,361,1583164800"; d="scan'208";a="239720757"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 07 May 2020 07:43:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIpnhJ1AdSykYv9s/+t/xlWKqh221kfwn8sEMI3oTjUJ74uUXXPd/mTb8Gl4V291oeqLZnjIA8SmqdYIzfJfW5eaYhYStRU5ziOsbfFWtGJ3OScPyx4yv8F4uf8qCO8bNKLiT4s+lYz3jUkDdvWabqDce+CfcWyvjF92XW1m1QnVNNZiA0zrbBIYjYZJHxmjk10KOYumSzCAUrA/O5W0pti7Fnu9uLsP1TjGSu/1esQxKI00ZnPEGB8PBg9ZJ8fIs1GNRIN7LpfyDAibx7JyfOdm/3pLOjWG0F0LWVX2mpA3m/rTkP1XVQfQFfR1fxalkUz/fazud5Nqg5ZjMQZO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf5gvOvuCwIJKcAS9JmJdrBvoSLZ/M51ghlrg+U4kAQ=;
 b=CL3M0jz1RP9pAlF4PVjpkxm8pbH3Dfc2hsENsMqTs+mNT+htvrpMHkJNHWgDJcJACtBgn8kGcvGED1g3y9/gSCqgcLN5JKcJl43n/T9nKSh8JYX9uEqJoOeLwG0vOtSZlCP/A/EeN6Oej7cjr95JKCj0hyEAEbpfOW98StPoG/ADV4wmiq5e5ZiFwFNnK9TK/o+e+UWsOWqsrbjfHdX+oisIvq+S0CTOjVTHGPjiDDfIJUA3t83wAWlzepK4SAl8yi98GBjLxHBrNFaBPiE2NtNpwnGZNsAl7jrkuZszB0B+gosqxxLFkpIe5ua3DzSWg1KlSXMoBA8P5Z/L+jR8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf5gvOvuCwIJKcAS9JmJdrBvoSLZ/M51ghlrg+U4kAQ=;
 b=FSAPorewJYrGkQW34URFs358ri9X33ROlnxBBXm6pINfkMkMv132V3hQmzaCIRtwrbrWLI877UKCNxYVxmF2pg5+gqeDTm/CTWosAW0H0V36Wnfkg24+pWwwRyQF9TJBFAQlevXP+lMMZwnYMImehsJjIc4Bdx5B13toeK0qcN8=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB4138.namprd04.prod.outlook.com (2603:10b6:5:a5::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20; Wed, 6 May 2020 23:43:18 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::6c49:dd56:97c3:3ae%6]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 23:43:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] nvmet: add async event tracing support
Thread-Topic: [PATCH 3/3] nvmet: add async event tracing support
Thread-Index: AQHWI0hKgskPTIis40SYpy97bBviwA==
Date: Wed, 6 May 2020 23:43:17 +0000
Message-ID: <DM6PR04MB49728E010F118220F271179386A40@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20200506014629.39509-1-chaitanya.kulkarni@wdc.com>
 <20200506014629.39509-4-chaitanya.kulkarni@wdc.com>
 <20200506071419.GC12145@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35525565-c6e1-4641-350c-08d7f21740c3
x-ms-traffictypediagnostic: DM6PR04MB4138:
x-microsoft-antispam-prvs: <DM6PR04MB4138C06AE37050A1BD95DA0686A40@DM6PR04MB4138.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 03950F25EC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nqcFLA9M9nhnELt9ZFqMk4+2JjiMN7WMXNKwgata6Ohc7/7TJ4oqKJuOEWdC3DbT15X7p+wcVLEKYvVyAG278NjWz6X3P+I2EjAyYRurCuMAoMYAgx+koyQnrs1YmtqSUWZhxjlxwydf5uu6bqlkHaxesXV9EaHIiiKqdkD7s+tdCFbrTtY09hyfFEhQ5O60t5vTPP/+mPJSWZQdQWppcR7FgQf185o2O21NlihOZ8fZyPiM0GE6TrYp755lRJKArLNY6o9dM0jBWtAWiSLaj/O/NyM8K0jKLN3HU1Qw6edGorhzBN5hy2Qgl/F58kfxxgPHgCU8DnkHSrr59zF8IMAww7E4ysFqeEUCtI2pNIJurGsU1Uon8x2P2yxEWgTBt+L8gGYRH1wqLaV1FueOKzeHemZkZKuHSRvdthJ2Z3+6ST/UEy2obFH4x4mIsZkIyFoYO/38fDj81UigzxGopeeNsRc/o/l79VP4jEU+AhVCqz6I3ttoG6xmGO6ckEUCY1VpFyHcWGEqU+fiuOy2Sw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(33430700001)(558084003)(9686003)(55016002)(52536014)(86362001)(6506007)(53546011)(2906002)(26005)(33656002)(316002)(33440700001)(91956017)(76116006)(54906003)(6916009)(66946007)(66446008)(66556008)(66476007)(478600001)(64756008)(5660300002)(7696005)(8936002)(186003)(71200400001)(4326008)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: nKHsN34hZ+wWNZOHissbxcmQxJszKneGd5JwXTf/qWnGg0smNkN3YunPHa0ebuRNEHKwB+IgyZXhiKQ6HKyEQ0b6wfUtBcuPpvTMMpBZ8brJtADN9oDybosapshtu0DX2XztWh7b6VECGxs8jjeWlWGvnI7CrWek94HA08BhHNR72I68CaW6n86Wplfm/igQnqoPotr9fs4pD5/dic6898LdZqK8yixgc0tuqJaG7K/MmlPWFC20qcYEurtNZKOPucOBlpAxNKevj6VLK6+AfJhCOpiO69eEn5XpnulPibf6RX+xsSAun4Ve6HG7Ge2M2T/iqdbosuAiNy6NL2W2SXFlVkI3EvqYBjasgEiRzSNneIjJq3lqpkG3LVOUem7uUwfm3uNl0/B3frS5JfdUAtbhZEoT1IJxTOyxFVRFCdqAs3sxBCy6SaijRGQw/vhLN0GqCvoom3NeH28MH5JgS5P2WiHfHYdkqdbTyhSb6BPQ3bcAbqr1JbLmkQlAENQA/iVMHf9GbBAlqUJ1h4cienGNawC+k8Vu0J8weOlUuWbIz4As9wxkQytN4c9DIOLpGFXuGjXNP9sWCzjkRy7/qokx9p24oHPBLlqbTmCOjGFDiCmr4Rm/shljMW8HBlOqvJXCM6K9Y+wu9CA+R62W4Bo0K1FF9duISC9ypF2AWm2iD9Z8nxZ251JZmLRaYC6Xy6ay5kEOWuOIZ6/jnvTCRk6KgD/weX14sqZ3SV6EfWSnHKSAVatqcZElva5lOFRdNS10bZ+cnyKFEFhmzSRLxgPiOJO5eDmxPYgMYF5lEwU=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35525565-c6e1-4641-350c-08d7f21740c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2020 23:43:17.9819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ETIrgtin8wFnSBLrTezMN8xi/RzyNHKSMatywXGFKELH0rM0BVK0txD2sJolkdnWeyKwANIH+REUkC69karMK1/ecLtL8jdV5nm9BjDKTx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200506_164320_154630_062AC184 
X-CRM114-Status: GOOD (  10.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 05/06/2020 12:14 AM, Christoph Hellwig wrote:
> Can you move the extraction into trace_nvmet_async_event so that it
> isn't executed when tracing isn't enabled?
>
> Otherwise this looks fine.

That make sense, I'll add it in next version.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
