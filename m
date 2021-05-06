Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F73C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 03:23:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3610C61185
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 03:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3610C61185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FZRueGL/fZX9VbAqBpvYq3vMlHZgAMM4hd3vfN00O4A=; b=mzJwNcwObo0Lswzg92UJJNQO6
	OJHXathbsWM5NzGuxDfvm1/9UwvM3X6zoCfe4sPUny9vHiJcEjmxBCztI+VKbWc1yA88/HNHsSdsE
	kOunWoRuPF4CQkwovpwUXFrieAcfviPGmmBFDkD/pITHh7kC6gGfiW8qCMshZiXtHeLTHjJfOxdOV
	UVqMrgW0Jvvgt6JbahpGBOkwRL1ZR9OzgjQEGNXg+xEBZPVwjV50TRShAfwjP96WZxfKt2YyJHysF
	f3UjrgL80cdwjhp9MUmsxKyg1tDFtdTrWO3a0qEmzxJRM07dkl9aqJ9PJVvJ+8LZ1nl2ir6gwR+gr
	CbnBdpgPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leUbA-002zop-7x; Thu, 06 May 2021 03:22:48 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leUb4-002zo2-Eo
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 03:22:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=rrpBLI8bECFiBcFNqCQOQPP5XwU9XbuMVmYh+J/9CEo=; b=Dcre5RbQxLIsS3abfrrZ0pEw32
 eKgK5s6yZ0UzFOEaqS/3IXjnTSXG81M5QbkDWC5vR+hUhIc+NWwaqrH54jXW5xxNxKIKtkm8DLpDT
 r9jNKejsRRV+4t/zDW8BHf5oqzo32Bm8OxxZvKyN22aiE0z5tIYCyz7nys+t8ga/I66x7cjURKu5q
 JUwxfi5tMEG6Pl8Pax54ts4fOxQk6QPtHLyo9AyaahCvKn16g5yv4n4F1BhBAsGqOVPzbjSTfGhYP
 vpP2FBlAtRgf4WhFMwptaJUL94U+W7SQnAhQWF5pvL9gQne4U30cGo/InFCTWdfAHDoRRavnBo2Wu
 xTvYEPMg==;
Received: from mail-bn8nam08on2083.outbound.protection.outlook.com
 ([40.107.100.83] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leUb1-005Y95-JR
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 03:22:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udo2ZNhkUnsGjJ6CjTdGUTbLIEqrZrL2EhFRGojRB3NfOkRcpuLixak91lqSNNRZLvKQFvJEn9fpSS9ncibwttcMhyuKlTGJxb5ibDJAw3rWXZ8c7Y2UEcQO66I6R8Mr6QUDmibYTvPh8TzjlsLBH3U27lnA+7sLw7iHKyH7XolYOMH5LbuKnAP/2/FswlUp3vkQqoUz1jMPY6hza1/n1SmFz3VGwtvcdvdrVaRM9IytoQNXS/IomAEf3Uimoa2f7evMvU2bjF5syX2HlqAAotbzPGfk9KkjFn657N1EImCh3Ko5JXCKZyEcO+vMK2P6y2vNMptju5EHFwPaafTb/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrpBLI8bECFiBcFNqCQOQPP5XwU9XbuMVmYh+J/9CEo=;
 b=VXhiLQSbUjn88yxcfxh0JEWt2iinGYqnRoFjSFM3EQu7x79z+BjRssIx2ttB0EeKDAaDEr9soHw2fvhxnCsWOJD4fCtIwca34hLcnLhUthQhDKSpjIyaCBJtitFwTy9ApBuguxG2bzVtCQja6BRWzgjMyoOnVPo6FFz/oBf82L3xKHKKQMLE6f1s4hIi5bovDAap0yrc8cjlQtQYz7E+v721faS+5jeQHzNz3JwKW3U9VRpd8dvhUu4rJtpXD6RJ6DpzVn5JwNYKxuNFLAtxA86gvwwYN4ZW2XfuKottYf3sBg3y2UkUNuYJW3gxZ5ro3+8UMIgLWrY91G+WL9XbCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrpBLI8bECFiBcFNqCQOQPP5XwU9XbuMVmYh+J/9CEo=;
 b=GMRZHWNd6yTxCtCodfW5+G18ACKatzsyHHY81o4TKNFyiBcQgmrLta9xDfzItbHXFFgddRQPuSmGAsNDIP5V7wmBL/FTMP8J5d+mliPYzNRQloZhR9ut/v2KvWNMIrjx1Equ53TEvYvLDhjTYZHbVEdBqRp/Rp2JyKRAuI0GCZY=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BYAPR12MB3384.namprd12.prod.outlook.com (2603:10b6:a03:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 6 May
 2021 03:22:35 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::ac06:4fe4:c52f:bdd7%7]) with mapi id 15.20.4087.044; Thu, 6 May 2021
 03:22:35 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "Chaitanya.Kulkarni@wdc.com"
 <Chaitanya.Kulkarni@wdc.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: RE: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Topic: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Thread-Index: AQHXMarUZvDSGRepoEyCkC/coFRS7qrNb1+AgAQFGoCAAIFXAIAADuIAgAPkOnA=
Date: Thu, 6 May 2021 03:22:35 +0000
Message-ID: <BYAPR12MB3238EC0676A8A7AF84270660FB589@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <20210503145702.GC910137@dhcp-10-100-145-180.wdc.com>
 <20210503155018.GA910672@bjorn-Precision-5520>
In-Reply-To: <20210503155018.GA910672@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ea4ef123-ae11-4910-8235-29cde4a038cc;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-06T03:17:18Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77d61698-7ed6-4a17-5c87-08d9103e3163
x-ms-traffictypediagnostic: BYAPR12MB3384:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3384FC2076D1BCA6D1DABF0EFB589@BYAPR12MB3384.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TQr9wH8FNBMmJb6GOM/rNqpOlXOiw81ixGRHNrhHt9w3F4gxez5VCEZ3Of+17fB3x4CGcV1PBGpkTx6mZwxgAchpQLaGlFJAQE2EAcz74w1eS5FAPzQtIkvgahMv4qgRDlcIHXFkDaLtmROLBto0TndjoDrA4Ss7adi5yCVpn/PJzU9W6+zlRi/BbcKmb8JUHFQ/ygyCrdn8wIMfVwqdzNBDFyQT64qRJeK6XZhOVl8ygXa2epf6tjdzN/iWR8FBLCJgUBX9eBUyjEnmC8kpYppEe0k11nIAfcCok0HUAh6Fpeov/m+jIG9ndgR9mZh0e6HKDs2WiE0aaEF4Uu4H3lBtn8RMp3jOSxD9b7dFWsPh9V/CMA3A7BFnFPlHZNOb1VxVM9GsUUg9tgale8JV74WCqHV+xWWaZDk716uTdDgsiYVmSICSXjum2o/SyCuazjG/zhO8Qvi0xCbMN5RlkHllaxmXfhChbzDCKRsn79LkAE25et841JI9GwYS+K3ppRj78pzTYIDas7qBo/P40wybmAyWH8fYkRJM/sbTlFys5bTWxMKKl7nvsCHslV89DRcPZvqhIc9H/KbA+gDYAN81+pL0hwoxe7cnHLyQfiU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(53546011)(6506007)(76116006)(66556008)(64756008)(83380400001)(66946007)(71200400001)(66446008)(66476007)(52536014)(478600001)(26005)(4326008)(5660300002)(55016002)(186003)(9686003)(110136005)(8676002)(316002)(122000001)(86362001)(7696005)(8936002)(38100700002)(33656002)(54906003)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YBeap9HwhYbNpzThK/Xls1cOU46eUN57zd9TkPRBcHiZ/ZAlNF4SxEhh1NPF?=
 =?us-ascii?Q?Sft1Llkt63vM6iYyaF4MlMwzBwyT7SB+Jx2JlhRE9jM82wsHzCiSt8N1K3ip?=
 =?us-ascii?Q?frrVfQp5JdQanx/OBE5L1K4aywIaaJ+RFaLwL7rD/UPwas1AmMeQ+xNdKGxn?=
 =?us-ascii?Q?jB/jKG9omOjOs6/ZUycrdz/XCXgqddLURtOaoqsJdRldIXaB8rAyPQN9MgOU?=
 =?us-ascii?Q?w64i/coH+QNEesj5oNhHvxhGTjbQf8r70Beka2RWv9Z943LgMeuL8yJM+dW2?=
 =?us-ascii?Q?qgJnku/ha8CGobYPEg0vDKdY/TgBrtmb0SKSntWx4fRPUKwgFByHKWnCaOmM?=
 =?us-ascii?Q?pAGDIkljMnWYYxIgwmoJgFS5fxHRAhfAPhujQiqIRfF4HEkRuPb4gYsnKzQn?=
 =?us-ascii?Q?4smuq6ARjpqFxj4XrP/kJsV/zboYHgI1d1QppSkNgNY0sf4ECMhQONUfWiga?=
 =?us-ascii?Q?oEIGD1kPO2Fh8w0B5Yx+4hvBh9BrNZd8H1m8zQCOkaoaIHtvPQAmh9SVkhyL?=
 =?us-ascii?Q?Am1OnDE5Eu+wiFfh5PmmUv9qHz8ISC8/w2rBmwu9CD/J4gOPF+n9N67o21mY?=
 =?us-ascii?Q?T1Ew/1r4AbVnQPbjLK6YH31DVePzZpKHw8w+fp30zpQnCoBNvnDHspxSxMKr?=
 =?us-ascii?Q?rwlZNRZ5Vr6lCkY1MFu26Fvzh2J+oM4aRFDYkhEaWpGXQP8bgWKxerVWMLOw?=
 =?us-ascii?Q?gQZaT9P7BLRFKipTFnP4mCxM3RnSjDj1CSgsfo6VlLgobH5ymff4/tW6utfy?=
 =?us-ascii?Q?euHlb+RQSFfWcCw6EAynhS+tOTzpP+Nz44i5vmXiAk91yIFcSuNtx72FNz5v?=
 =?us-ascii?Q?knITRQ4QAvTaLHa7HCVqCsHSaNtIdYnidG5AbvBDUiVjZZvV7Sx0f1mmAxVN?=
 =?us-ascii?Q?h9RjgShciH+O86yaGfa4RULQmKjdkjc/4kgHyhIsoIWCQu6kTC6NMcwkWdIi?=
 =?us-ascii?Q?1vlgSabuCVql/ATZ+Q1FMfAfI9Ln6IJEGFOtgAxgabCAx+mbSfh8SScx8WFy?=
 =?us-ascii?Q?qexfalRRd5oAxYX3S+ga74Al24agxMOEQFXtzDq1QN273H5uVLpzCjt8hAas?=
 =?us-ascii?Q?ECwsYU/ppz7XW4/O5f9RQU7lglrj3G6yjky6ONT6vPUbkGJ2VGFqujxldDLf?=
 =?us-ascii?Q?veUu+8ppapmDwAXMO0BZrPeEQ83YMIUhEOIjUo5b7ubSa+A1xgNR8s4HhY3P?=
 =?us-ascii?Q?H8uIsNm+o+F6Us8sW3iFtSS5sP2J7JphfWzSBsrQ2xBa6jRQUd1Q7SQB/Iay?=
 =?us-ascii?Q?vz0XnnHKgiiGGTMPXgvEBAb/E/Tj8rZRL4F4KVymT/ggyDgb3u3uVjhBrIXU?=
 =?us-ascii?Q?25oLlfT6jnOTJdv3NsVFedIK?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d61698-7ed6-4a17-5c87-08d9103e3163
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 03:22:35.1208 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: teMlW+QzDz8D9jwIbmd0HzAhWDBXODeM95fF7u81d5N56+dgWQOSN55/4VcSp3Ws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3384
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_202239_659749_7A048E3F 
X-CRM114-Status: GOOD (  23.88  )
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

[AMD Public Use]

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, May 3, 2021 11:50 PM
> To: Keith Busch <kbusch@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>; Liang, Prike
> <Prike.Liang@amd.com>; linux-nvme@lists.infradead.org;
> Chaitanya.Kulkarni@wdc.com; gregkh@linuxfoundation.org;
> stable@vger.kernel.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>; linux-pci@vger.kernel.org; Rafael J. Wysocki
> <rjw@rjwysocki.net>
> Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
>
> On Mon, May 03, 2021 at 07:57:02AM -0700, Keith Busch wrote:
> > On Mon, May 03, 2021 at 08:14:07AM +0100, Christoph Hellwig wrote:
> > > On Fri, Apr 30, 2021 at 12:50:49PM -0500, Bjorn Helgaas wrote:
> > > > Patch 2/2 only uses PCI_DEV_FLAGS_AMD_NVME_SIMPLE_SUSPEND in
> the
> > > > nvme driver, so AFAICT there is no reason for the PCI core to keep
> > > > track of the flag for you.
> > > >
> > > > I see below that Christoph suggests it needs to be in the PCI
> > > > core, but the reason needs to be explained in the commit log.
> > >
> > > As far as I can tell this has nothing to do with NVMe except for the
> > > fact that right now it mostly hits NVMe as the nvme drivers is one
> > > of the few drivers not always doing a full device shutdown when the
> > > system goes into the S3 power state.  But various x86 platforms now
> > > randomly power done the link in that case.
> >
> > Right, and the v5 of this series uses a generic name for the PCI quirk
> > without mentioning "NVME".
>
> It'd be nice if somebody would figure out how to cc: linux-pci on these
> patches.
Thank you for your review. Sorry miss that and now linux-pci has been added to the v5 patch.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
