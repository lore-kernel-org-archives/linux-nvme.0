Return-Path: <SRS0=t83a=6I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD84C5518A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2020 08:34:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5398120728
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2020 08:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oYsTQ2Pe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Uz8hgn/K";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gi1tNVsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5398120728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=9uqtLBGF7dyNrcWHEcBgECtENSceyB7kxfQFhtIMkYE=; b=oYsTQ2PetY6b7J
	d8Y7hxTFsR7cpbYOdkawNvH8MGuHCdxYHE2zSiM9lpMFXCP7KpQIIeXAAeNnFxX3do7fBhhQ+PzeB
	UvWdMmsIasC4c4HfbmT0lDA8TduwXSIT9kUMuM6REcutlAcr3g2D2iLi+usnpb8+FGwHVvRrc7slB
	0X9xpwi69BML0u1MsLNkdRWihRtefGNl5ivQ5yEnkBp2xFo2TKGyG2xxW9KdZ0/PN50pVM233K/Zd
	cAAg478uh9fFnHXxLTmGp1Fc22SrStudRHH44nUNQ2fT824vTYOPrD8AX+b7egu3jW0MWofhJq1c/
	w95Ac897THNTXKuhCTkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRtmt-0005ve-Fe; Fri, 24 Apr 2020 08:34:19 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRtmp-0005vL-Hj
 for linux-nvme@lists.infradead.org; Fri, 24 Apr 2020 08:34:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1587717255; x=1619253255;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5IABURRJPyZ73yEfY5qQDljmITwWssk03US8k6HSpkQ=;
 b=Uz8hgn/KphLauDllbiNy67Wq+xKXrNlYcZgC5YlgkE/QwbBZuUtuEHa6
 YMnI1akK+9EPf+8CYWztAP9Q60dSmF9hnPTnz6WlunhvjT9vh1ozxb6X4
 Lm7NHiNteCRMfVYkzlk3e40Nzlba95iMN3hDk920JxmqCanW3uW3NQEBm
 PQC7kx7WxeilyjCjnEJnKQm65fl2D5NUc8N5Mt5ywO81lRX1YJ+K7irp6
 Hq+OYtPBMTD2scdO2Ko72qI19PDBkrx7A8PmtFqP26P6I1HPt0xy+D35F
 O53YdqTfJoXaQq4HcaFKdfo7ucMIzZmQDEysoFd0SuUPjXoxhzy0cdnhW Q==;
IronPort-SDR: v/OpAOTfANUE32OR56epshjMwwjgS3LZevIn+CchJ8ed6e+zUaLqWb/XXVFJsoZMejyYT55m7A
 fKKW+wxSFWSAZdjJ3crUNvVH8CKt0MPADyrHtszO5tTCWUgi66/hNZsgA4W33gS7DfI8KxHYSS
 HtPbchk5A+E4xtDZY7N+/cqloubW6H6Q5cfSkmT59S7oNO9d7hlR1gQ4LVdQfZVk8fR3CNWV7w
 WbVhx2LxXwYar3oG7QnKgTEVTNAJrYsE7tNfnS/npFciKjANfvT9dqNXqg8mUMkSK87WIvH3Uj
 /8A=
X-IronPort-AV: E=Sophos;i="5.73,310,1583164800"; d="scan'208";a="136367850"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2020 16:34:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB8Jx/kMbAMxbr7KKZZuj/wV+qMOSssTlGpULjDItfK1XCiz5WroWKp+/XFKv33QkUMO5frFBvbfyHVxFTDR+ZFo+kzkfVT5c8fgBUFKNTLfDffjOgGcLHg8Itxv+joIp9RDtJfrnPnuPu47EWkOJWZzpF7Ipv62M9ebiIZ734xMRxDjYfxy4qPjC5Y+S8fhvosXrtSJTj83gFai52GR2SOYZhjLE4rSKPNy0/EaEuSNr3ga4XlswAtZ57QFKbM38mMjaiItU4uKGC7Ki6FtkWAvmDDUVHGclUr8U0pA98w57JI0qMqmpCgR9nZHl2op++69HJzPtDzFGl8Le2cRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROg3xlIiMFqI4KzwtyN7VZ3FYm/fjf9Q/lk/z+5fnt8=;
 b=VgFnO8uLMSDJy6QRYLptFDhqIw12hlBqBvblMMvL2+4lPsA/TP573JNTZbjYCBn6KtSqvTsEZPodjGDZ8xz3JOJvJkEhb2BVWfWspJVZcm6NGBMCGMcB40z5gTaTzKZPGFVJqFKjknyiqcDT6AV7JCJsZWPTj/y+yo/Z2+CSIFKGEwG3EdxnXElorJMUYhWAAhfXPxpaN9BtC3ZzndN4xwoXjBWSntl7/xAFVhycexDr11CystveWl/v7cm7RxE2vnx3He3Eh7jToiLD8ugzv090Yjg9m1K9Vjg5hx/FjZ/cNE7wWWQORhTRvmxInryaue1vHLbycWreyIu/nBqJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROg3xlIiMFqI4KzwtyN7VZ3FYm/fjf9Q/lk/z+5fnt8=;
 b=Gi1tNVsSMrv35w7HDELTdQuqIJETi83cx/vjNRCpzXVfenAtNsAOEmY6KGz8jWTG/zHC7CWI69itxC9+hwfMcR0U1LuwNmw1iQtHpb6rRzlgsgJXt/sQay9EhJLkr/GhPfGtfkci9LhdzCdfFdZvRjeZMfhrUTLnHhTNm81zeoI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5494.namprd04.prod.outlook.com (2603:10b6:a03:e6::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 24 Apr
 2020 08:34:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::28be:e964:37e5:44b6%6]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 08:34:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V3 0/7] nvmet: add target ns revalidate support
Thread-Topic: [PATCH V3 0/7] nvmet: add target ns revalidate support
Thread-Index: AQHWFqUc/6G4R90/W0uFjlLgMy0bYQ==
Date: Fri, 24 Apr 2020 08:34:11 +0000
Message-ID: <BYAPR04MB49658A68BE0CEC09E761B95D86D00@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200419234856.59901-1-chaitanya.kulkarni@wdc.com>
 <20200422081936.GA25035@lst.de>
 <BYAPR04MB4965850E7D094ED44D1C360786D30@BYAPR04MB4965.namprd04.prod.outlook.com>
 <3f112b29-91cc-620c-6262-de3e322a29fc@grimberg.me>
 <20200424070502.GA24059@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e40:3000:902:c06c:7e6c:8fb2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ce9d938-6aec-4ed1-7b76-08d7e82a434e
x-ms-traffictypediagnostic: BYAPR04MB5494:
x-microsoft-antispam-prvs: <BYAPR04MB54948303F1883F1923B9A44E86D00@BYAPR04MB5494.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(86362001)(5660300002)(4326008)(110136005)(7696005)(53546011)(316002)(6506007)(2906002)(9686003)(8936002)(478600001)(186003)(8676002)(81156014)(71200400001)(55016002)(66476007)(33656002)(76116006)(52536014)(66556008)(66946007)(64756008)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ucW4cnMKWDnE0GAdNisn4fIHSt+ZAwVcb7fibneYNtFl0t+726EaylwdGtprulPMGImotydALeuVCTMJYkF5EVgbdmM7E66r1yfCrlcBFVkx2fK/YAEeQ1v9dRbDjh4ii95EeLPj5HSzdFZSoz5lJ7ZYpxyaABsnIpLn90OhqrNqoxA/O/Hg/bZQTqZ/JjJfG+huVjbaDuY/OTEuA2Hm9MfZ04RkHCKbuguMiVm2CgGW8tJf9hl87S0viOBvIxf3bNzpYlWdM51tK6ptWyp32336zhY35Zl+aYSAgRDmFPrjteavBGdPM7GhALLmisSzTg0Ib4pu6uHEiuYE7BVSPdBqU/JKmD3CIQTXdae0Fq3Ua4M31V9iwlCYZWfvW4VrL5KdN5wgnI6L9nlBBliCDnJ90H2q6DW3W0vwwWY9lsOOgGGuODdGq0nNHbKnJf2V
x-ms-exchange-antispam-messagedata: gK5hO8gLu9fYpHfke1GNjpFTctRPi8Lf12Y5Ic65XzFUeQ1J5eevof/6j6l7vTPq+jlTxWnDT9wH6prTW0v4dI5mxSRqXyC0DgXFs22xbmncYTDlqKFuK0fN2AKhELlojMaDZnxtEmnIUcccibGT7q0lMxIZAzClXoSZNawNHKuX917rFJpScJ0rwnfohZb60jFGWZN/PwGDOk/elAvOYA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce9d938-6aec-4ed1-7b76-08d7e82a434e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 08:34:11.0402 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GLNOINsBquaVBF8w2zFepU+IJZOvgFDW2ycAqlW5v55AlNo3JmNs9nazIZYEHOHcAnu4i6m0FFUnVUvBmDzSMISq7QXGKabAM51fxt+paa8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5494
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200424_013415_713910_D4DE5CA7 
X-CRM114-Status: GOOD (  14.56  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/24/20 12:05 AM, Christoph Hellwig wrote:
> On Thu, Apr 23, 2020 at 01:20:25AM -0700, Sagi Grimberg wrote:
>> This is cumbersome in my mind... and the polling part is
>> kinda bothering me...
>>
>> I still think that having this sit in userspace is so much more
>> elegant really.
>>
>> A simple service that watches with inotify on the device_paths (files or
>> bdevs - which are also files) and trigger revalidate via configfs when
>> it gets an attrib event.
> Eactly - plus udev watch for the block device KOBJ_CHANGE notifications.
>> We can even have it watch configfs and automatically add watchers
>> when new namespaces are enabled and remove watchers when namespaces are
>> disabled, so it can be completely zero touch.
>>
>> This can sit as a simple systemd service that nvmetcli installs.
>>
>> I'd very much prefer this over the proposed approach...
> Same here.  The idea of having a kernel thread poll things for which
> we have notification, and an easy userspace way to handle them just
> seems like a whole lot of bloat.
>

I see, I wanted to avoid any userspace dependency if we can. It is 
better to have it in userspace so we will not bloat the code base.

> Also remember the use case:  shrinking a volume is a pretty destructive
> operation and not really practically relevant for a live volume.  So
> the interesting case is growing, and having a little delay or even
> a manual interaction isn't really the end of the world there.
>
Will send out V4 with configfs per-ns attribute for size check and
AEN generation.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
