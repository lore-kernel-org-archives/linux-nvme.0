Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6ABC433ED
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 09:03:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DD9610E8
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 09:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86DD9610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DvMfmUJWP5acEv+it0RFWTt1wNFqPrW9J4DiPoOhCEo=; b=AGundrn7N50vC30dkxPEKP8ML
	l/TU6hTDjekudwtgxWuZ3bRdZ1qUQCTpfSp3ncLdSlq1jBYwNF3Av1rKVAeNq6kAQgdEb9MuFKasS
	rjwqBzPcnnnsRTeMBL+aSoiV0Drbp+iI7K6ReStkytMOFmp02h3/AtvrLoUyEIFgIxGw5mhQnMjCc
	BuF2gilvNF5Q2QWbLInfI+77viLw5cOsSjCUoedcTdVi2fAG7FFbMHMGfw8wwA/1uIBHU+rCnBKgi
	hzLTRMy6Howad5rG9z4jqIJHE/FuEvlmyDs5rTuFupZgG8r63L8fxaEq6vYDXnatjJ0Q849om3mPP
	snJvsJpzQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lThcH-001wPf-2p; Tue, 06 Apr 2021 09:03:21 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lThcB-001wNe-1e
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 09:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617699811; x=1649235811;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qJUK0EvcEpa2S9psZoWdPWPqLGKoCICO+nMHZKo6ESk=;
 b=BoWdcYtld+Z8DGtA1TKC/oH7/F4I0j22lZ0N4bFq4EriKL8QjQ134/OV
 uYZxtCJwBHT60OZWbZNiBmLQK+PD4doEYdK174mRH/Jfc84j/jzqGWv0B
 grtDarJVFmWZoEgIVQt5qGYijlNr2pJFDd7th9AF3ubdEctOsrMSMlpvL
 dj8x0r35/wNYA6+YtPosHlsQ71x6MWTl4waabytBnwP+8RhCQtbIHV1q1
 mcUCiUAM+FDHkofOjaH6g1L5DJYd6/aOq6LDg8Zcp7rSOif7fRWmtYffl
 Yscij32oUW3LPKBN/swcTriT01xnmNvrdyuGlIsLNWymLKDODpj6jXK3w g==;
IronPort-SDR: xjyC1rgFa3BbgCS76TpM0wNG2y6m5OkMLhe85iKRmzb4utLfCG2QOe2ox+mnjyKf666WI5nV8N
 QdZjAWxAwzgoqyXsA0INKiiBzqR7stWjYU9bWDraeFdoqY09kVSOFWp55PkvGesAkhIQ36hdxC
 B51lIrYFOv4F1RI0GI6Pp/7KTnkYLl1e9zOolIuGF9K7bPuznAtwtk7RCZxNMDAQAk8rJW6JEX
 RMmTIDhXPCtQebgok15ZN+gYI7t71hTHSaa512BqCzrC4Sohg1Az8aHVkp/vDIBAyIBltBZFJZ
 fTI=
X-IronPort-AV: E=Sophos;i="5.81,308,1610380800"; d="scan'208";a="268294366"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
 by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 17:01:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khk0bR7N4nneHiEpWjA2xBTdE5i4nnWAPL6OUfgxuOasAk1JNzPa0kkDKz6Of7Vk1yLo+9+hpNe92TRqwNWkvJ3jvuaaXOAxZurQ6RYktWoyTCp8uHjLfK3HOQAx6GSqaJO1DX5dRtEYuGGjdrQr8w4McAq7zU8zq5iXnGauHAnc8QGwrebt08KEozv5cMHUmBnpGTRx/MGJjLmmEi23vbkpCvfTcx/CxolW1KxWJfSpSYmoHA8xBJso4aW+Qw9T0+Ba2s2aUsHGSxtmQx1gI2tQYJDXOd6PIsiDTNB7aJSauhPeTZ//5H+Vop8vPm6xEB/hnNOipRWeYl4QSmpNWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO+pY7S8vNBBy9c7vfnZssWzpaiBpWzof/+/gVEaEVw=;
 b=iRxP7Pbt5Zlx92hXZM7pgFmXLKqqFtASe4aggV1o1DYAOOG2f3bHpmsHtWlZlhyDZgUSuezZ85VYMPFCCodGJdelkKafjBQGo2N8ugdwBI5ufgtskyw/G3JIrNolgY9AJqRlgHisELWTLyK+Cxl5Th+GWhMS6uBxVs4RmtwgrcGo4DNkyxuJ0ul9yWjypl/+icno/D4JxgkL2jr/Emnwy8tt6EUK5YuzzS6/5kGVuCKC5Dsmwxt6lK9U01YYzIn8Uzd25euPRY3tpKNmxyr+HSQsRqhjJ9GV7onRnOy3gxnJYZfFykyWO0yaIfGXUQVO6hjuAOrbc/dcaE1EMjB05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iO+pY7S8vNBBy9c7vfnZssWzpaiBpWzof/+/gVEaEVw=;
 b=OgpEyJV/lfLpxPnGxHpYlx+ZcWveou/GwfvgT659IaLWmJvid4NGlN1J+88bNrz4X9po0z7qklr+S6/wuo1adXBd3ouKdnzfNw65KueFS76eK5v6pNmAHR2bSdzy3+0HhxS+hlvpUIEx1RIx2F0KcBcHqbO50DHuWt0UWkQ+0YY=
Received: from CY4PR04MB0678.namprd04.prod.outlook.com (2603:10b6:903:e2::7)
 by CY4PR04MB0457.namprd04.prod.outlook.com (2603:10b6:903:bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Tue, 6 Apr
 2021 09:01:41 +0000
Received: from CY4PR04MB0678.namprd04.prod.outlook.com
 ([fe80::642f:22c6:66fc:24f2]) by CY4PR04MB0678.namprd04.prod.outlook.com
 ([fe80::642f:22c6:66fc:24f2%7]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 09:01:41 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Minwoo Im <minwoo.im.dev@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Kanchan Joshi
 <joshiiitr@gmail.com>, =?iso-8859-1?Q?Javier_Gonz=E1lez?=
 <javier.gonz@samsung.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Topic: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
Thread-Index: AQHXKsN1pjvW+Y7eAUiYEfo71YOF9Q==
Date: Tue, 6 Apr 2021 09:01:41 +0000
Message-ID: <YGwjc8rliXhvccPp@x1-carbon.lan>
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
In-Reply-To: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22774ffa-c25c-4f38-1d2c-08d8f8da9880
x-ms-traffictypediagnostic: CY4PR04MB0457:
x-microsoft-antispam-prvs: <CY4PR04MB0457D7F65778092F8BC8BCA9F2769@CY4PR04MB0457.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0ZWlpg4GWiwVsTWybGjIwtxRjYn2vixDobQqlEt1d29wxP0xjX1q7HxvKxnVmNzr99t6ihR6/Puu7kgQNoD0FxaeD6j8SK1okiVGZdogqk3dPZ4en/QBLfxnm1W8dRtDUdm5GaWVcVbJ9wn0/UT918MJZdLPWcu8mhzyFIMTYxHAUVlkh8OM4VTC+yQrnwVB1sbXeZux1YLejLr+qVieSoVi9XY9cm+O7cn6Wzj3Xl/LBjlkEMyLiYIiJlLGAIBqvsds8yKHKd1WSy6/XZLWngjdL9sbsUU/7YhrUfcSuHk5fOxB5xCEVN9AQvyHjL6EUQZXTrDQlS1hZlEdxpjv4brgrGSlPxbcCMDOZJGulhJIrW33S4qllvhuMAgwXo9o7CPfkkW+ccnC2fNJXAwjqkfR2QOrfvn85kPPj1KdYKN63x8LcmAv4Gd28kXJKpJx9Vo6NodG4hYFBtAXKrc5w2Tmw/ZMHtpUjAVxhpHkZhfjX9AtTbjYh1KxvRjBXLWVjjth11TAuLcm/Ai3g5gHgjTUzVgxPb0wnjkwkuwMOboMJqIgbGVGwkF3F5IS7Qn0TwnP5u7bLbRFo5ginQ2kFYkvrIrpwiuob8vDlgZJEa5a7cMdUppUKbW93BQDCMT/+KbyxV3PALjN07hi0q9G9SIeQ1QsWqG9d9PFEVrFc29H2gVAfL9/F+DmOxRYiL5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB0678.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(83380400001)(186003)(2906002)(6916009)(6506007)(38100700001)(316002)(26005)(4326008)(36756003)(66446008)(478600001)(8676002)(86362001)(6512007)(66946007)(71200400001)(66476007)(76116006)(91956017)(8936002)(54906003)(6486002)(66556008)(5660300002)(9686003)(64756008)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Q11jNrKOTwSDlWtCc/qDC3R+qQ02U6j9QlfLd/UVPxDt1M9DRFXY6Ao9el?=
 =?iso-8859-1?Q?U3iStK50cGGJSTzd3VP5oenT5J81wCebtjD6LlmaaABm7NdBFo04PVuPjC?=
 =?iso-8859-1?Q?EV6aB0wzngFP1AZUCG5k+o+V/CqDGm0hEP2wI4xY/Nk1LkHXSlg4gWind0?=
 =?iso-8859-1?Q?2T32wnvNWwyUEaLUmujt26Av6TkGVNN25UvRKQCfDu5VWeFi2fEEjZyQZc?=
 =?iso-8859-1?Q?GF4M0KBjULLA7irzmn1EE0Lt0k1GtI1SLdnL0ki7iTCfszx/dzIi6CiSOM?=
 =?iso-8859-1?Q?hzCqx7QVcwBj6t4r3zqnhKLKxi24JLpdl/xl11gtk85npWbzSSonX4clvE?=
 =?iso-8859-1?Q?+zX1wzs8wXDjRd4jEtJ0VwfkHdegeCiJ9eOLPzfyI+Tjfc7vBaazFtyXGE?=
 =?iso-8859-1?Q?+2OUSZfN6jXxFmkWpUxH7lKlhQhw1YKo45cwCJ+599BCj4Yajl4PVy+Jcr?=
 =?iso-8859-1?Q?P8ZjSyfnuFzYra+p1FNAEH7qvwk7OkkU2rkDecQDFTlb7wnvBniXijcO7a?=
 =?iso-8859-1?Q?oYopihhV0rwqt9y5tKfyxOZroTAzhFg0TIe1Y39UNV5xj3xFwOZ/HHhA/b?=
 =?iso-8859-1?Q?I5TDMf6ScWj/wYXYKA8h5XMNJPRdNVEDG34w4AFv/Yd9v0jWcG8Jo5zuAe?=
 =?iso-8859-1?Q?1H2nMqmjRcLX/2xjb2KPSjGWJHoKuoTLD/3sZiyrYuU46aHqAn8DUbga61?=
 =?iso-8859-1?Q?SwozaeXfuqfb83nMPs2d7l1+twcBw1zFyIG8RC2Wo/FMU5+XZ82k442pL5?=
 =?iso-8859-1?Q?QthwlA7FPpVCAZHupIOQ8dLVeUmdhpw7ClE0s7BZaLCMdaBAEbLgQdLvS6?=
 =?iso-8859-1?Q?HCGeOqGVw9StwfL5xfc1XEYja7a/djgE96gWcwG1dDTp322YetUhBfVOG/?=
 =?iso-8859-1?Q?BGx7at3twLQf6TMMfU7znRD+BeZ3VFLYqemrZMwiVRvraV7wLPf8OZ+qjM?=
 =?iso-8859-1?Q?qR8s4K/tN86Ekv8zziUKOG/rM90B+oXg2OX6CYn/K5HirQQCH6T2bafD3i?=
 =?iso-8859-1?Q?IN4SkHpe1h12rbXoN74lgNk2Lw9geGyq2fl1lbVFWB61OgkLSMwufJxncg?=
 =?iso-8859-1?Q?p1LLg1I7nwctN3zcH1auW0DwCkUw1ugFiTNF/2VaK6ACZCMHUrM29G7W7W?=
 =?iso-8859-1?Q?rHm+Cjf/S4lermbeiB22UiqXM1Y4QplhDPgofoLSSj+yEpkZGO8sowntUm?=
 =?iso-8859-1?Q?I7+GqnSTKlq7e6WpcrCoIkiNh4g8lYhnmAkd33pHTp0yAiybQZu4LNtvag?=
 =?iso-8859-1?Q?2IddZorvllmulbnPrrjINldicI4U2EWW9OvN6/3b9WtlpMJOHGxC0+s7Kq?=
 =?iso-8859-1?Q?y6YyVqo+Pk0HMTqNb5+H0gEs0tGlqgqZ7XXY0jq+SaGRZ3A73ITbdcBTdb?=
 =?iso-8859-1?Q?KnxauzQWpx?=
x-ms-exchange-transport-forked: True
Content-ID: <6FDBDAE934F6EF499012ED35D29656C6@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0678.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22774ffa-c25c-4f38-1d2c-08d8f8da9880
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 09:01:41.7077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOm8lK+wFzzJXLSQdN+5lDHbkNfkSuHp2W0+sCAe8K6TpEjiZORQBDTRu1cFW9dXoVCzU/MxIqzBBrLaOhCPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0457
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_100315_830227_8F93ADA4 
X-CRM114-Status: GOOD (  27.43  )
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

On Tue, Apr 06, 2021 at 03:48:40PM +0900, Minwoo Im wrote:
> Hello,
> 
> This is the second patch series to support generic ns character device
> to expose per-namespace instance to the userspace.  This version fixed
> code mis-ordered reported by Kanchan.
> 
> This patch introduces per-namespace character device to I/O in case that
> blkdev is not initialized properly.  Userspace applications are able to
> I/O to the generic namespace chardev even there's no blkdev properly
> initialized.  Because we don't allow nvme controller device to I/O with
> a specified nsid, this generic device will provide a way to I/O.
> 
> This patch is derived from Javier's patch series [1].  Javier and I have
> re-coded this series again and it starts with new version tag.  Changes
> from the previous series are:
> 
>   - Update naming convention for the chardev exactly the same with the
>     blkdev:
>         /dev/nvme-generic-XcYnZ  to  /dev/nvme-generic-XnY

Hello Minwoo,

The current proposal puts these new per-ns char devs in directly in
/dev/ (I assume since Christoph didn't like the /dev/nvme/ subdir idea.
Keith seemed to like the subdir idea, since he had suggested the same.)

For the absolute majority of cases, the namespace will not be rejected,
so the user will be able to use the per-ns block dev to perform IOCTLs.

For the small minority of cases, Linux might reject the ns, so no block
dev will be created.

I'm slightly worried that adding all these new per-ns char devs, in the
same directory as the regular per-ns block devs, will lead to confusion
from regular Linux users.

Imagine the potential confusion about what device the user should use
with e.g. fdisk, mkfs, mount, in fstab, what to specify in fstab, etc.

I think that there is value in reducing the confusion for regular users.



I don't know the best way of reducing this potential confusion, but here
are some suggestions (suggestions are mutually exclusive):

1) Put the new per-ns char devs in a directory different from where
the regular per-ns block devs are located.

2) Only create the new per-ns char dev for namespaces that were rejected.

3) There is already a new module parameter for this, default it to false.

4) Introduce a sysfs /sys/class/nvme/nvme0/export_unsupported_namespace
that you can echo the nsid to, if you want to create the new per-ns char
dev for a certain ns.


I'm certain that someone can come up with an even better suggestion.


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
