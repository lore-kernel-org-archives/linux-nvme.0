Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A75C2D0EA
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 05:43:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4120520730
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 05:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHXJP1dy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kniqRnCm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hjLtrklJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4120520730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=iR2pHKsa14ClEe2u2HJN5noeSsHbNGpd3bx8qcnoOvg=; b=fHXJP1dyKp4o4q
	NU65VCZrsLPqLLomNFpTuqmVX+OY73O6tFUHPSt1e/givrsval4zxjDpppxR0P6acettboDPagGpO
	I/cTY+zVbJ/9grUXXZMBmDxanhlMvaymPrmb5IaXpXVYjVJ+HcNNlQomhmByJylvPBJa0RzRtmrew
	MYUMCs6KKDYg9ofOQSrQYbZiPAC3dgrmaxWzhJO3OXnH4PPoISxVcz8MFvbQh1UT3O4S8WzZQpWxy
	8xBpqGHdynE6GOBKT0hsxBrLsR2acunwj9qy01TW3bi+pt1gb/onWSzM7UplFq7lpo0vaAITnydf7
	urlmYf1xBa/ab8F3SMXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM3Uv-00083c-5D; Wed, 08 Apr 2020 05:43:37 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM3Ut-00083H-2z
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 05:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1586324616; x=1617860616;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=uUq2NXD6wUfeR9En5uhp53WGpvU0c9vD5JHe4VACfak=;
 b=kniqRnCma9FSKr81MayKywrBvt3oArIH8RpD7jNBqKdQ8jTcElpQFI+9
 POGxqn7pXNpg3oPEeK3beOtc4EShE7IuwyjHLc83mg1H2GyYdcQPJVpHt
 C4jyS6D1RYZAk+1ZAF4yLaItMQTBZt9zcOF7crXPY3C3k+u1Qf+azJvCb
 s5HO0x6Uz7bde2IajWldVBgFdoxVAiTSaBxBnJYRqPwZuWRzbtD4CY/+I
 LsJPa8hLRbKB04E4vjiaw9W/ws8PpBRxqCd2J6xNbegCcXvZM5GXkDCzK
 X+nMSzWtjfqXRzWivrajyx+PWxIb4NlZthE+GA9p0FM40A9B32ry34jjE g==;
IronPort-SDR: BIC7WtK3bOClcjHI/Qw73j7UiPwo/cbozGW6hwHc9VsYm+vWkbMPB0NoJvXxSZhrvJK8HtElah
 sdIJvWNfXMfZSWAMgv/Ci5ntWo83MDJiGD5z6qbpCrbmaKq7nsH/R5hxO2WyoDfk4/7Y0brle8
 rIvf+7QQGzhn3E9KwO9NELJsNKqekzxdo7IY94jMfdmSb7oHdK1XdzOkFPoBCkH0bRULgWvG4Y
 fTTZMlt3xC4FKnKui+rt0NKhGhhLtplRBN6XYNQiE5AuanHP74c4xfFAbfn4P4iUnFyMG/KSC0
 jNs=
X-IronPort-AV: E=Sophos;i="5.72,357,1580745600"; d="scan'208";a="139129379"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2020 13:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tx34jn+8xUY9kVHqWJC79Hp2tQVJrcCzjPhxPRDdUpmMpprJUAWQfUi8gHuUw3lBrh8mlO0tbzulDtL6NPBIEpE2F1K3u0FRMMZp2XEWc6CWeH6g2tQavYDcBqeTmxBcl+RJ9pE+d+QC0aZrjJ1E1vyuAjvqS1hOwhftgSZiEL2pquu7ronwk7fIyMEhM5JftKLr58jXhrMrfQwgf/JHcmeR6t0JIj9pjVnVZAEbJd9emvglw64gvDDP9VVklL5ldU9e5l7k2FCp0rbfkEFhUTnkY9z5xWOpTRu5Dw+uNNgezABhKuSAj4gJNs3h0HKGdsJSBJKFHiA9IPXlgymJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUq2NXD6wUfeR9En5uhp53WGpvU0c9vD5JHe4VACfak=;
 b=EhhWfjlyX2wp1qWcJ0oVsuAtk1ukrkVH1yGQZUOz+hM6BTh/jaGBC9D7hKFALazog6xVbWYNOZRgejSVOuR7tDmmH22ZS/UZpq25VEbZRbg1/qV2MWCF/hFYCVR7dcDymUzqB5rhMC5KmXRka09J0aaRAU6h1HfmF6pj4ciNtPFcefVANx9J9fmxnMROBNZEQsBZx26PMOGAcTfaaFQkS+/OUaCTCQmsQHOsHWWvBOUv4xxjoGISkO8+kl6qm9lWSXauMxOZhRxZh5XbZ/8tDmMt+J8k9bCem8gXVgk4c76ixkR8H8ANk0B9uZkGRqeW5uSSnqNMYT1J1neKpduAZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUq2NXD6wUfeR9En5uhp53WGpvU0c9vD5JHe4VACfak=;
 b=hjLtrklJfKU60aZY/CYelvWLNvYs17+lcERwA+ULjfFj22KoY/GGuKP5W9foU1a9uPuCDTHEkcBK1xclGxlqi/K5JZSLPDexlyCwDlSX8odVm8TmryuNxYLRk116BfPnicSBlvy/pAAf1e0gI7PJvH3rcf6IuHScGwrwLKfe7kI=
Received: from SN6PR04MB4973.namprd04.prod.outlook.com (2603:10b6:805:91::30)
 by SN6PR04MB5103.namprd04.prod.outlook.com (2603:10b6:805:93::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 05:43:30 +0000
Received: from SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e]) by SN6PR04MB4973.namprd04.prod.outlook.com
 ([fe80::b0f4:a811:73dd:6c4e%5]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 05:43:30 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Topic: [PATCH V2 2/2] nvmet: add per ns thread to generate AEN
Thread-Index: AQHWDVyGx1h1rDwyCECcI/Bh3Diljg==
Date: Wed, 8 Apr 2020 05:43:30 +0000
Message-ID: <SN6PR04MB4973BC935AE3BFD4CE874D9B86C00@SN6PR04MB4973.namprd04.prod.outlook.com>
References: <20200408041633.20632-1-chaitanya.kulkarni@wdc.com>
 <20200408041633.20632-3-chaitanya.kulkarni@wdc.com>
 <5e54afaa-7de5-a89e-5740-88df15c52bba@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4b6ba373-0beb-47bd-34c4-08d7db7fc4b0
x-ms-traffictypediagnostic: SN6PR04MB5103:
x-microsoft-antispam-prvs: <SN6PR04MB5103D76D884BB99A5994057686C00@SN6PR04MB5103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0367A50BB1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR04MB4973.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(8936002)(110136005)(8676002)(81156014)(66946007)(4326008)(71200400001)(7696005)(64756008)(66446008)(81166007)(53546011)(6506007)(66556008)(76116006)(66476007)(478600001)(91956017)(86362001)(316002)(2906002)(55016002)(33656002)(52536014)(26005)(9686003)(186003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: itgA9iHwdNOmgNISet0RRtYywAUmyIKCamqxPMvhXB6hhMYL6Rw+ZleVABIe46dAEPjZ62usi4bG08dniVdFwOu3J1vLq8Y1ptzSd9ru0vfGhHHciZrx3Kjh3v74PBNjN5GLDoaCGnxX4G9paGVvYkSZlK7jM30J+RYWQFgks+A2c9sGhI9/ar10b8mGSMGiYvSlFvbsSnhR6NZRackyJyT9CY4Pg3yKhMVR3bxaO3n4jUmPtRzsJc5+BUFCAyy5dZSyPn33lCQnnPESJvGx6Mz2NBiw0iHJN1GYP2i5+6KCIvqaAAnVS+CwOHVyyGPGfhBIzibydCWeCwzditeWR4GYmDhSgRyEploJ1pJmFwr9PA+y6A2XTACnleFk16CMOzyQZStH9AjHcGAh13UggwIHymRngnlvbwo+n3mqFHj5r6FEQaqFWerg/Kla5Cbl
x-ms-exchange-antispam-messagedata: wlj1S9VtuyLfPxCpwXhYgitpsRNvNv6LUg8fBLILz50XpchCadFNMH60cRF+m8uHUlU2ig2z6m3SpXMOPfD20Ors5Vx5ow328qkWB2NDTDv7G7MdMCXvBZXYNrRXSOaANTk4bTC0kJizbQi6P5QbXw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6ba373-0beb-47bd-34c4-08d7db7fc4b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2020 05:43:30.1357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NxpDlhK6hQPnxZ2gVYc81VqXhRJtSDJYI+OMESC9kjNsS4au6YgRVCnJy40uqdoY5QNB/LoEM958+EiXsZtVce3tuhTiV9pRsrqH7kyAVHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_224335_153896_6F808417 
X-CRM114-Status: GOOD (  11.61  )
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
Cc: "ailiop@suse.com" <ailiop@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/7/20 10:33 PM, Sagi Grimberg wrote:
>
> On 4/7/20 9:16 PM, Chaitanya Kulkarni wrote:
>> The change of size detection on the target should generate the AEN to
>> the host. Right now there is no mechanism that allows us to add
>> callbacks for the block and file backend so that we will get the
>> notification for change of the size for block device and file backend.
>> This patch adds a simple per namespace thread that checks for the size
>> change and generates AEN when needed.
> kthread? per ns?! I really don't think this is the way to go Chaitanya..

I hacked it up quickly, may be we can use a global kthread which does period

susbsys and ns scan, but AEN needs to be issued to the host either way.

> I'd suggest to expose a revalidate configfs attribute and have nvmetcli
> install a udev rule that triggers a write to this attribute. Balbir
> already got the udev notification for disk resize (see
> set_capacity_revalidate_and_notify).

Okay we can do that. So you are saying generate the AEN from configs
attribute.

Christoph, do you have any suggestions/preference ? otherwise I'll send V3.

Please confirm.



_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
