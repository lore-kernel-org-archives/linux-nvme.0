Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D37C433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB9C20748
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UgseynMb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hLd+QpFR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HWmq64QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB9C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=k54yYbAb+PnpBFUPeYTRuHqj6mAjYQ7RWxTIUgyjHHU=; b=UgseynMbtFGR7/Zu9Dectk+yi
	8dI7s3Vjd5pwaS7R8AOH3UcyUnM4qaGANbpjHriqlmXnpX5+1qPp2H66VnYmAwAgapoUXFmb5Ji5s
	tbCMsBhtR/tZzHkGwhV1HoLwEUYRtNrCjnRD6OOzRoCmCn/rz0eaiFu2NiqtWzx7GgU+uwToTOyDw
	DvRq/ip1KhgZmHSXv/VnxO2yzZF7DIf029/5ZMOkwFyqKIqyPEZWX7BpGRrlariRQmHkF+mj1VKNk
	7h31Lw94xWxzB8BIb0jTJX/qUziaE10nKgYok78VZr/dCjCoUkWxNKuYUtS6nU3A4A/jFfFlkQqXg
	71HTKPRlw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqhfh-0000Er-0t; Wed, 01 Jul 2020 18:41:25 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqhff-0000EK-CH
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593628883; x=1625164883;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=GaMM5p/iJlMpxumneNoOAYPPetZWIw82huwRsEwxoAI=;
 b=hLd+QpFRDxHjyYFyfztmTaUiT+oKUiuPnFvobmjLqgGL67fbRHVODYl/
 EyWrIw7L64TkEtQ8gBvtBnlqDFNrv5VyCf4cKeIpAyxXadAnfUR2U2LlM
 BXoztDI2cpttmH7nAngu4dLL/Fs6/RbU0AEQ1WLeEH+RDjCWaGBNpqh6W
 T1FLo3MhHCfWvJso8oWbeo63vsMNTSU3BaOq/z/9LF/4dIFygYNcQuR0P
 PWiJSE5IemW64fXXvR3RSKC8/INLkYnehhm/fKqOiRmzBX4uhIx+zIa5m
 A8Rh+n2iJlVuv1riaZjNDMqihU2llxrmvtgNmwSfqKT6Kj1mgGqWBUUJy Q==;
IronPort-SDR: U6zvzNjGixRUTqCZl4KVrIAaSXUjuZJjPLyPUH80m22szOgRFpZM6KibBGan1PfOzqDssG6fSw
 AXfnG9p1Yr8he5hYZrVr0W1d/wTboXtC3A6KWCTPXNexRL4N9kzfyV/rdih8RymLGVfsb+Ry4X
 8iMS9UYrB3J459ILCYpHBeRTTeC0Uq/4B3K+C+7H4kZMvMyoo/Idj8lOmDcJUs3Y+Th5+2+Kjs
 HIx3sGLMCSjV+80cSJfbwtGb+HhMcj3N47/xdj02C6kBPjyskdtu1pXTxU0bWoVsR/JCAeDza0
 1Uk=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="250642476"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO
 NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:41:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcUvpR2sGfLFHLvk11E8oafFj+VpTw1e9+h9z2F/gLA1xWEUonKSkgwawiAOFYzS3AAUIdSMa5mTDERTi0yqYIDEnURdituqAVr/OQpWnxUgYcDCCxsJuOzhRuGenHc/EfQ7FI2VNEB/3r0xDpYSFDCcwRXF+9kwAPByAD6gehl2+j+opUiD9ObW6xlzLfPmTRxcd/p8bdXYETDj34WANwYDwJR8ao30n4HCLvuEfq37eG6UkDEw5vUyzguaThz+4bE9tlTIP6FzXvzXHAxFdt4a+JbG8gpbNKg3DeimITCoR+ybimE/7dyMDY5FE4NGDDLX6n+slyf76WGvxpcJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaMM5p/iJlMpxumneNoOAYPPetZWIw82huwRsEwxoAI=;
 b=JE0swFrCAvDwcH9WuQT1y6ewTrBc7liPLaFtjPn/a7iMhgqU0Gw45u3F9exkuLXk1Al50hdxt5odMV/sD9Zt6F3V3gSnoeWOEkwjHYz7MzNW5ZHPBzUqm7GMsofWKHdyMw86YTzn9udW5yrPNtCKwRP7YEW2e9vYcbtsq9hYJhd3WNHu8vq58Hs9HNcTPuegb2pepEjFk/iOm9VmUeiKk1kKaivwDoECCy5IcTsE0SvHJ/mjmhZIDFVWoxRTO+F75N+vE5U9wy1ESXeYepY4lfDFX5B36chAhwI+p/T7XYHChq/cZ9r5LuVwAi8sicJW2gNs3UaqYn9yEHbLSFP25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GaMM5p/iJlMpxumneNoOAYPPetZWIw82huwRsEwxoAI=;
 b=HWmq64QYgqpvbLhw+GiKsXRmezLa18PdZDzoXK6c+7WXMtaGYND6VMr6FuHy4/zRKDtekor4NJZNzq91we+yiIttCt0fPA890X818qqJ8+Ww4XTySeW6X7DbALts8wpbDhnt5//CxC7heb8hRbEd0m+mRFkhnewdbde73YVrjXY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5032.namprd04.prod.outlook.com (2603:10b6:a03:44::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 18:41:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:41:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Thread-Topic: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Thread-Index: AQHWT07f2kc1pYF3pEmTYkfgZJ9VFQ==
Date: Wed, 1 Jul 2020 18:41:20 +0000
Message-ID: <BYAPR04MB496543EAC48207FED8B6E611866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701053609.GA28056@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b865a52b-7652-419f-4294-08d81dee58f7
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-microsoft-antispam-prvs: <BYAPR04MB503255EEFA166E995C9DB7AB866C0@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cthmLjtmq+DOtu4FaMY9VGldU7Ep3qjqh2+zP1MJH4caCgwpbxgrEPFXzlx6yJ6NkiRVOkmUDawPEoxoHiPIoNh9aCgKos+Lb2v8xSJuxVDuUHy61GjVzioLdJME02coHpHRpEIQ4iC/A96O6iVMMewBIq2HcNyufAWnqFsn+E4a8xvP90gYZVRUgnzstz888b7Y7lhotCdlIW4/PHzfO66By18qcC7OKBiDZsXJQNdX+0ONLMucncCSlYF6a0/Za2eUWogZEDi3GgAcBHq4D0QKlxceTMKbrJI0BRaHDqhswGywqXKX6oVWI4kNEZ2l
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(4744005)(8936002)(33656002)(26005)(6916009)(86362001)(8676002)(71200400001)(7696005)(6506007)(53546011)(76116006)(4326008)(66946007)(66476007)(64756008)(498600001)(66556008)(66446008)(9686003)(55016002)(186003)(52536014)(54906003)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6qEHjTdpYfoEbzKE+qLcRbFD0vHPLskxQBAevIqTTGLVEuc+0DnaQV+825/p4BigDltMRBPAijpMcvyMHZEx8qZj9jqxwfZWO6O/2qOkhkmF8cC5Cjx6IxX0PMtBHUkgZxbmcDT7N+xNmglr0zd9io0j7HvRTEPJ9V4mYw7KD8utXmJVZBp1dkIXM2xYSPTG0urZub2KeXeN9WkkDBIwxIqHudmp0L7a9oJuh0LFnlcyc2ztKfgoRoEhTfZcBm7WkW7pufbVeSAT22LLYz26zQSEi6n8yEPGVHh1NFqv38NNgGjp06bFZnmjzi60s0WRttnwyody3Aw1Giwm7E3H0joQzO4GDF+NCyveIdaVU68SeGCCeFf/urO16/pPkYL8bc/BAcAhahf46jH0dYtzW1krV65N39rcsNg9ZQi/VY2+CjvnxzoGm8jisWXxVvWnyaFwT1U/s8tAs/f6vJJjVnMJE8UxR6YslTcR5Up/bfbNyhEXsHt87cJOBQ8h3U8w
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b865a52b-7652-419f-4294-08d81dee58f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:41:20.3617 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlhU7kTquxKY/HDHDz4S4Rc1HkSDngc0Q5/ENf8AtEyGQj5t6OkqpNdWil+g7eW9fjLoaGptim/oDlM5GMAslcndjRXbWaxCQwd+LA9ns4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_144123_562272_C59C9736 
X-CRM114-Status: GOOD (  11.56  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/30/20 10:36 PM, Christoph Hellwig wrote:
> On Tue, Jun 30, 2020 at 07:25:15PM -0700, Chaitanya Kulkarni wrote:
>> Hi,
>>
>> This is a small patch-series which replaces ctrl->namespaces with
>> xarray for host-core and target-core. We can see following
>> performance improvement when running fio with 32 parallel jobs where
>> first 16 namespaces and last 16 namespaces are used for I/O. See [1] for
>> detailed performance numbers.
> Why would that make any difference given that we don't look up namespaces
> in the I/O path?
> 
This is for the passthru series which uses nvme_find_get_ns() in the 
fast path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
