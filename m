Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FBCC433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 02:38:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF9A20720
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 02:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gjtfAMM4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ENiHfXfe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HyD3dqrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF9A20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=t+6WlwnjmVhTV4n+ggA9UADzZzRmiFtMuac7QHvhYYk=; b=gjtfAMM4wJRmfZeaN0Y/Ep3Uk
	7hj/34Aqy7Q2YkETb43SKy7MkHRKKUYPuQyArG/9dOseFMyJUTGGLRl1frQJVBeaQK+R/Nj7fAhM1
	UZcVlx/QBc0Iv6TgOF1V1eKN/4Gi1N+Rs053PsiaJoPxAUS2ZKnpnyf78IOdTKGmpxVlWO8UdsMmb
	AG9ZHi6R75UNJDs/4i6ANeobfaRZHnJYmZgPL0seLZgSQ7nmszJNf70IwErgSKy9CY1l2hAIE/T4m
	adMOdIzen1QLbvARB64y5SYw8fotXDqGanxhJz+PhgRAqoILRgU51DFK2nA/JU5e4FpDJszUiaVYa
	zdHXi82+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCZht-0005uw-71; Mon, 31 Aug 2020 02:38:05 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCZhq-0005uC-En
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 02:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598841483; x=1630377483;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MQ/jFErjD9tyvz87cpVtcBBUrQeu3OXZzWb8TsO2nMM=;
 b=ENiHfXfejaAcZmoB3XuX9vviwUKC5idhW7IX5py0bDhq39Op+9JiTnjB
 gADftOuw4FI3wvuvknK53wgbaVGTVM6p1aFLodH4JykOV+XguYA2giwSh
 J6jWrzSh0p87rlDYW9ew+JDkPWx6/mef0lZ0d89toT31lr4uyqNOBeu3p
 ur2ev7fwATR7yVntKV83Y4uF7NIOOVWiIKO8dViAa4I+9U5whP5xpcIHe
 Ks3mcIQ02Fp1hLJ0PNSj8IVQ7Vs03ho0LSYLgyNxqGOSbfhRcljrcEe6G
 mJcexMItfrimJT85us8H4h5Zl92NJvkwSzdQ70Hn7DU8dj+2Eu9lGCheB Q==;
IronPort-SDR: QofmrFs2YxX5Ej4g+QhrQkdpJdGSQAVOy+Vk5TG6eHTUpl99bV/NRpEQvLdczobuTkbNdq6ulz
 ogOXwtxaDgxXkIe7yo+2IkSVaNQrfr1B+jz8r4lzo3d5bF/+xH7expxPO3kz6w5B0+Jq4W1eqn
 h/Rime0XI8cEVTqOUW3WnxR7+9bWObfLbthGU2iaIhUgTTruz2ax6JGSkaQnRRtIbw0o87zstk
 uMNYTTCtet7lNV1h2jfT+9haspTZIwfoASd1VqOTshj9Bc+ouWjNiJ1Q1CRe0N2emaFiKWpVAM
 kiY=
X-IronPort-AV: E=Sophos;i="5.76,374,1592841600"; d="scan'208";a="150529306"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
 by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 10:37:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzPVrjBiFzwNenhKcLFJsurHq06/odBeijwFmSwuPpZ4lHbuyePC+Io+kZinaO9QYhXTtnVZ5aimQ8Vz8sqHHChVe+yuwRdqOfjxYRy/0h5DV3JHyXjNqpXAJSWhgCQZcKtqt/a0joBoRZjin3mNJ+2arrwfojFHOoxJThV6c6cFVIhPwR9vwhmCt4hhTvjin3kwalwOMgCPB6Rwx6du/a0ZrMC608V06FZLtRf6m03InQexMpcy4GIm8g3ZbBw3cv1rnDRDVWcV9mmS0QqFmhqNVp4nhuL0blAq/zzppgaW4HmiZKH8wevjtMvA/yoTxtJ2f+YT9hL0o52C8sRLeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As0wB+SUY3dQ2VFI9wmDRxgdd4AHoH+bwCOeKy79krg=;
 b=Ilc3bxy3DcbohhPoAtV2Y3rSXgwG/fuUrhfNlJRH/xD0Ip7wufCl5KW9kHDpWvfujcVLJb9u65/bzW3fEh4f8DCatAUDMIk8gSPO1VGfwnJmvxW2Vr1Cp2TyPlWze9NnPfMnVFSP/SX5QLR+0+pTCz+144qZh1RGLNRqz0b1jC+uB4cR3NDBeTu5xnjgEf5qGC5TnsIZsBtrPDcdAy4c8qxI+nvf9N8crGrvtV5eu3fglkoefSCP+lJEKeS0n61F6ouUaG7As4mXhnU5jrmzosATEKOiAVUM04G+rg+DgvUklrIOYbNS2K2kp+puklVxxKT2iL/QCg7lk5yku/lrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=As0wB+SUY3dQ2VFI9wmDRxgdd4AHoH+bwCOeKy79krg=;
 b=HyD3dqrCKqjxqqvU9ppNdOAGDzxHbEZnC1xpMM0YZtfsyTMZcTXhQ0Ofh2209eua5zVXH6qsZhPn/eaWFAWx8FOpKKNPCCWZ3c2z4VQ313lRJv6D0gfjGaPJVE5mTHIKUyarK/yMcjGyCnNeB6qjv81uOxlVhrRZsJM+e49mQh4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5893.namprd04.prod.outlook.com (2603:10b6:a03:110::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 02:37:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 02:37:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvme: fix error handling in nvme_ns_report_zones
Thread-Topic: [PATCH v2] nvme: fix error handling in nvme_ns_report_zones
Thread-Index: AQHWfrhhjHgqbqvkpE6Nkx4bbPc2Qg==
Date: Mon, 31 Aug 2020 02:37:56 +0000
Message-ID: <BYAPR04MB496523202727D4FCB38E46CF86510@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200830100010.1262680-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13212a22-47b6-4c4b-a376-08d84d56dea5
x-ms-traffictypediagnostic: BYAPR04MB5893:
x-microsoft-antispam-prvs: <BYAPR04MB5893AE1A1B38E62E6257ABA386510@BYAPR04MB5893.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HkeDcWrN1GLYqG64r9PCxqKh+ZVGqXCwBB5o2HQFpxEt+WN8qwOKdmCWRC5DUMBnw35Qi9MyFXPbLcM+g2pIe5J5DTGmniQBxQksHVRr0ConORIdDcGzupTa5MCo8kVMQEegWyq4GqBdTa7FJKjUxXTQXaYCcmFYLARLh0AVu61bAaoilWj+UtFynRKsftPBK/QpdrcINoYQUDSnB5uQux+fVZDJop0VL8+HaEoKCoNkEK11On/GKqaIq9r1rCcnxgdyA/YcPin5uI4vlkW5rXAtWY7or1vaz67X5/YrY0Tk6d7wmEYgH33o13SMhN4u
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(66476007)(5660300002)(66946007)(4326008)(7696005)(33656002)(55016002)(186003)(8676002)(8936002)(26005)(9686003)(53546011)(71200400001)(64756008)(66556008)(2906002)(76116006)(66446008)(316002)(6506007)(110136005)(52536014)(86362001)(478600001)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Oy8exTQrV81Hjr1MyiiosE+XAoRe83dYJW0IOVpjBI8djbbTH9g9f/XJEcZhzAYa/hIPqeH4wLPykRBtUU17LCOWYwyqsUNuWI1bx/v33pxz8vUYkToej8RamAwlfSO6Mm/IZF2EPP3oCJb/SDDwzXzF64n9LSg8DshaFgSGFVMhhBqai9BjBqnGVIMrf+lYEkzdeT3m+VVFLuFFDTYyEwYC8ROMXIyETNxPVbZV+RnHKDXDqKiPffFmgZgZ0PC13JbY+/rr+aQYTIbJZ6HxdhGVPB7zE5VVGM04NSCJ9w/Q/3c9RujKj6Jhg0lN11buoLic/++Tgh47lGhrWdzLNH1V1XeuzL6ZdcRNWGNuTdM86oPceNKkjdHKTabLLqG1eatJVwMGQkVW0SAQPRbYVGB+toRVzMRYmLEYKG97tW9hcy0UWwCVBpNdLDrHFA8o0TE+juTkSio7N7K8AYSnLc4mViC3mY/g2mFwjUjzzVUmfTGU8g+B7vpsVHkROV3Bi0u/o0ufphnOqYt+6Jn2IYBazbv9PyxR145DqKDC8ZC/gLf4gK017p3pzZ5vTfna/6fJwOiNqEL/vLEpun9O5F7QbeqCqcQQItn8+fL2F/vSa+ABbG53Oby68M8MDWDaBF7W4qyhn/koEE7NxsCCXg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13212a22-47b6-4c4b-a376-08d84d56dea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 02:37:56.9439 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6yJc31VUgXM7kxrU7qlXgAFyWVGjNfAjtC8hMQU/mOz9qozOFlKOIuGZ9PxW8M494CrLcBM5BKNRjxPnmnbCvmiXsI/1a/y8vK4qn613A44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5893
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200830_223802_842033_19ADFD89 
X-CRM114-Status: GOOD (  13.83  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/30/20 03:29, Christoph Hellwig wrote:
> nvme_submit_sync_cmd can return positive NVMe error codes in addition to
> the negative Linux error code, which are currently ignored.  Fix this
> by removing __nvme_ns_report_zones and handling the errors from
> nvme_submit_sync_cmd in the caller instead of multiplexing the return
> value and the zone size into a single return value.
> 
> Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
