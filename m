Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD3CC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 07:24:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01F9206F1
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 07:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U+UIjULC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BZRJb3Cg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="muhTa93B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01F9206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oBeO0bwa0UDMdSLDE0sN1vBRRJ818tWAqrQNgaKHgLA=; b=U+UIjULCVzxO9s
	7xXWRlg7JiSpy4cET6slmEP2To6hPNFc5yIqwRq8Lb0c0U5P230G33xbgwkYFMpSygI74csdlqKW1
	A/V/Sl+bLn/q7Gwjq6wiId65738eI8uSvTK+3MKJwIJqc5F0lqXcBhdajX+YRT5k2pbsHeNOL5GxV
	T3Qx5HTHUVKI0B1tishkhUSgYYZBFtbJtpRkPYAm3UzO4jdlcqSo9WygD4NV+GbixHSRaM3MMQSKf
	aK7jG59TLqxSBzyBe8a0FHLRT4kwSIA3BWn3uUuDtYejxEKJeZHLDrqwHzJ5QWaV1EsFMcWgP5kz6
	SIh6clltb1q9WhVqNc9Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlSQq-0000co-9j; Wed, 17 Jun 2020 07:24:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlSQn-0000cO-4D
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 07:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592378660; x=1623914660;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pzffFWEFtj+kuHok/NfoUcxc0FUh/Fue9aIz1l2DtX4=;
 b=BZRJb3CgpD4iaGGmm9OCpMIpoykhhKmqEKW/q1dG4FgH0X0Ewp7q2ecG
 yPzh8l2PvsRm20UKIDbucz3oDyM7A0p8E1S32LXNhGST4TwNKzuP7U35g
 qZ3gUvTB9jzLAH5lFjdlCEbQ3bUZ88h2QxV+mVbLT+saJzyTCPnHbvASs
 x6qre1Y5r/GP2Uh2GEAkHvrPHs2qsRMK8Eg2ZKVCEj4Cfv8XaH2i29+W+
 2tSsPBwuusTJo8HD8lVOGVajuYWSRYBITtof5QNcyTyYvsDHaG37FEUXr
 9nz/qTSPsfJbk573UaU5hCmPV71bwFRrjM32O+Vt8IAjkQ3CCqzdXgs/g A==;
IronPort-SDR: Aw3wORuWWuXcxcCh9QxZGLjJTPfeZoc4UpJNSnh8AmPrBXgkzOBjVWafS0ggX3v3taZMPSZu+3
 xzCHvBGzN0WEsHQQPNwLQyAnCERZx26Ln2jzTpOnc/T93Ul7/AnBelOmGYgAd5Y+esZcxTijQ8
 Xd0Lf+2ifnF8GmJ0yx6Ccpw91zSVFZm3TANvmaxCYDBx7oltnjGL67d5r0wEp133Xz21FQN0iL
 Q5qmLD5WVMYyj17dftN2ZGoxs5IoRF1YY4hGOcyZN0T6yOII5bFJumzzzk02FWpvb1y79Z4hhO
 r8k=
X-IronPort-AV: E=Sophos;i="5.73,521,1583164800"; d="scan'208";a="140200088"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 15:24:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bpemu46OBvCBSmjzvo5kWQVpPimAVK6s7nWyVndbQI/bz9c2UytS48q8ai2z253Mjs3623WVaDu2a9814nkbY5w8icR6Ee1ZYq7rESIhXZdo+7wphZg5u+RvCUlBAoZ4YgnSUYf6HGRLZ3eStD2nRIRGscH2NFMlLwOBTK0V8PryfnPH4qI5Drh2WLqBZ+jM3MkCNkFpDz6w+KpsOtGbCxn99mLk0NlL6nPUSuUW1PFcMY+psXpqVMHKUEl4ATSFnLp0WEKJyVckqYRZ5tLDzVNPH+14i9wJdHsbRFKaHaFR/2MYR7ackTFNG5mcRbddy6GfiV1WNN6ugwTQ/iN5gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUE9nwnpwwBXhxZJxXi+dnYvntRTTl9Nq9xP3ErS9C8=;
 b=Tc3xgxDuO8RXVpnle3XhxMjBCjFn+ovD2dFsthoYmE/mygBM9bwRM5g18X++bJ7OvalgCCM0NT4yAxFEdKyQ3K2PbF2R3woc0gBfeDLRjDVJj8W4njLqv3Irlbk3Oh2E8Wm/yhzUCD+0q0fM882X8Y40IgOtCl0Hsabok2dUmqpz9WyWtfa8TYgG7w/Q9PYVUJrvEN+iioRBQ1VH9dKoDBI601jqxD6Pu5SOqkFCz1D/aGLfQjyTTmsE5xbEFAVfyCSP6DZgooJzDefzEDZ1HqxsV9sGnhfMgrXcm58RAnyQqWxbar9c+8cZR7/jLWnXJ1OCwfG9CKqUYg/MZs1QYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUE9nwnpwwBXhxZJxXi+dnYvntRTTl9Nq9xP3ErS9C8=;
 b=muhTa93B6F1JuLnuUgXGQkes4mc0kn9iJNgMMGYgu1y7IZTqUUu6Av86IRw+MjwD2xCV/d9A8ZC1w9Gp9M6/KpTOYQo88E12gR4iBfkOR9tIuKCYs34ACFY8J5hsalzMIZep/XQtp4yNuZijeXenM26EA+T7L1w9+VZXKno7jsw=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0761.namprd04.prod.outlook.com (2603:10b6:903:e2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Wed, 17 Jun
 2020 07:24:18 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3088.028; Wed, 17 Jun 2020
 07:24:18 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Topic: [PATCH 5/5] nvme: support for zoned namespaces
Thread-Index: AQHWQ22ncHPAnMo9ZkarXHo4UNlnAg==
Date: Wed, 17 Jun 2020 07:24:17 +0000
Message-ID: <CY4PR04MB3751827E66EDECCE9268F8C9E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
 <20200616122448.4e3slfghv4cojafq@mpHalley.local>
 <CY4PR04MB3751CC8FE4BDFC256F9E9CD1E79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616141620.omqf64up523of35t@MacBook-Pro.localdomain>
 <CY4PR04MB37512BCDD74996057697F5CAE79D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200616150217.inezhntsehtcbjsw@MacBook-Pro.localdomain>
 <CY4PR04MB37513B2D2B7AAE343ABF14C1E79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617060953.ypviiz75cua4bt25@mpHalley.localdomain>
 <CY4PR04MB375154B897296A3A4C82503DE79A0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200617070234.jbeex2i7hs5urbqt@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 134d96d8-365d-4880-4afe-08d8128f7257
x-ms-traffictypediagnostic: CY4PR04MB0761:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0761E5EC671340F718B8D647E79A0@CY4PR04MB0761.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04371797A5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1txJnA/OpC8tUYLZv0rWGZYF7KgV4AtaEp3j1DnRhIl3ul95GrABT4Wrd5AsdpTwdJG3T8fQ/mtvDn0TxmQwdOO1TIkcEfAXl28wNnS657Uo0VZKSeUi49b+iv7LQk+1kX1VUre8tVocqUA7jgbA8GzLMGCGL7HrJMwFwKZtkCS2ihDuhgFwOdVnusRwrkTiPX4olHGAV8W8mMV+J6TkckGw9erulFi93jRnZ8+uP7mz6desCrt3v6e50DkJ1utOFlKXXQzWLcbIJD6w6oQ0kJyBB0gQVKdQCf23GErFK0aY5JamoxtoNHoClwB7cWvdsh2XFpL0Qd30pvLnjkirjBBF89R/om93fiDyg8Ew9cnxwhRAczDHd4jfcqxCyM0iuxlLQ3vDbkR8LkDcq+BIVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(52536014)(5660300002)(6916009)(71200400001)(66574015)(33656002)(26005)(6506007)(7696005)(53546011)(54906003)(316002)(186003)(478600001)(966005)(91956017)(86362001)(4326008)(76116006)(2906002)(66446008)(64756008)(66476007)(66556008)(66946007)(8936002)(8676002)(83380400001)(9686003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OiuVzpRX01IBkbU/5daT9G5ML3j++OTmojQQd7BXSX7fm0AVaZxng7zBACNTU8JYFX/RHHQQSBEhFmFhRghtfQkJuwptOqfv8XhFg8MetUTrfqJi3fRljkhwi2fMJ4IjGDD6QOWlN8DjQL/nx8nNXucjYfLv5kkhAQJHJip8K3ya6X6ZPsVYiNjmeCidnjGZX1sms7qiCbPeWNcIvkG0CnE4Ww+56tRtZzuETCvdZhkESUyyUIBSyKYWYxVpo6gxAuOsmtTnRavnv3Sb4ggU+jALT4NaGpk/t6r0Xh17pced3md2QZh4VXrcolocEpr7CwF+apQ3zM319rSFShR3op/VMVCe47nlQE4TIq/dh4ybaVp9WEaI3URcJTMEGMaH/iPk8tmMiQdRtGb5zq6oPH4L5EEGllvQ2noT156HIsmED17PCr4vtCpEQCq3llzqZtYZlsMLlV+9/0Puewfq6eRasl/tvqNttatJHjmyxxdYS9v2uGRAtMQCEKz0cLMH
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134d96d8-365d-4880-4afe-08d8128f7257
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2020 07:24:18.0062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mJ9mjCCtzDeiu/ca4c3IUwz1InrPA9OsNizAkPSM03Q87xXijiN9EwYF+wLJfebeQgtQ/i8bKH3CdTAiQszxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0761
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_002421_288319_215A01F3 
X-CRM114-Status: GOOD (  19.45  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <Niklas.Cassel@wdc.com>,
 Ajay Joshi <Ajay.Joshi@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <Keith.Busch@wdc.com>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/06/17 16:02, Javier Gonz=E1lez wrote:
> On 17.06.2020 06:47, Damien Le Moal wrote:
>> On 2020/06/17 15:10, Javier Gonz=E1lez wrote:
>>> On 17.06.2020 00:14, Damien Le Moal wrote:
>>>> On 2020/06/17 0:02, Javier Gonz=E1lez wrote:
>>>>> On 16.06.2020 14:42, Damien Le Moal wrote:
>>>>>> On 2020/06/16 23:16, Javier Gonz=E1lez wrote:
>>>>>>> On 16.06.2020 12:35, Damien Le Moal wrote:
>>>>>>>> On 2020/06/16 21:24, Javier Gonz=E1lez wrote:
>>>>>>>>> On 16.06.2020 14:06, Matias Bj=F8rling wrote:
>>>>>>>>>> On 16/06/2020 14.00, Javier Gonz=E1lez wrote:
>>>>>>>>>>> On 16.06.2020 13:18, Matias Bj=F8rling wrote:
>>>>>>>>>>>> On 16/06/2020 12.41, Javier Gonz=E1lez wrote:
>>>>>>>>>>>>> On 16.06.2020 08:34, Keith Busch wrote:
>>>>>>>>>>>>>> Add support for NVM Express Zoned Namespaces (ZNS) Command S=
et defined
>>>>>>>>>>>>>> in NVM Express TP4053. Zoned namespaces are discovered based=
 on their
>>>>>>>>>>>>>> Command Set Identifier reported in the namespaces Namespace
>>>>>>>>>>>>>> Identification Descriptor list. A successfully discovered Zo=
ned
>>>>>>>>>>>>>> Namespace will be registered with the block layer as a host =
managed
>>>>>>>>>>>>>> zoned block device with Zone Append command support. A names=
pace that
>>>>>>>>>>>>>> does not support append is not supported by the driver.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Why are we enforcing the append command? Append is optional o=
n the
>>>>>>>>>>>>> current ZNS specification, so we should not make this mandato=
ry in the
>>>>>>>>>>>>> implementation. See specifics below.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> There is already general support in the kernel for the zone ap=
pend
>>>>>>>>>>>> command. Feel free to submit patches to emulate the support. I=
t is
>>>>>>>>>>>> outside the scope of this patchset.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> It is fine that the kernel supports append, but the ZNS specifi=
cation
>>>>>>>>>>> does not impose the implementation for append, so the driver sh=
ould not
>>>>>>>>>>> do that either.
>>>>>>>>>>>
>>>>>>>>>>> ZNS SSDs that choose to leave append as a non-implemented optio=
nal
>>>>>>>>>>> command should not rely on emulated SW support, specially when
>>>>>>>>>>> traditional writes work very fine for a large part of current Z=
NS use
>>>>>>>>>>> cases.
>>>>>>>>>>>
>>>>>>>>>>> Please, remove this virtual constraint.
>>>>>>>>>>
>>>>>>>>>> The Zone Append command is mandatory for zoned block devices. Pl=
ease
>>>>>>>>>> see https://lwn.net/Articles/818709/ for the background.
>>>>>>>>>
>>>>>>>>> I do not see anywhere in the block layer that append is mandatory=
 for
>>>>>>>>> zoned devices. Append is emulated on ZBC, but beyond that there i=
s no
>>>>>>>>> mandatory bits. Please explain.
>>>>>>>>
>>>>>>>> This is to allow a single write IO path for all types of zoned blo=
ck device for
>>>>>>>> higher layers, e.g file systems. The on-going re-work of btrfs zon=
e support for
>>>>>>>> instance now relies 100% on zone append being supported. That sign=
ificantly
>>>>>>>> simplifies the file system support and more importantly remove the=
 need for
>>>>>>>> locking around block allocation and BIO issuing, allowing to prese=
rve a fully
>>>>>>>> asynchronous write path that can include workqueues for efficient =
CPU usage of
>>>>>>>> things like encryption and compression. Without zone append, file =
system would
>>>>>>>> either (1) have to reject these drives that do not support zone ap=
pend, or (2)
>>>>>>>> implement 2 different write IO path (slower regular write and zone=
 append). None
>>>>>>>> of these options are ideal, to say the least.
>>>>>>>>
>>>>>>>> So the approach is: mandate zone append support for ZNS devices. T=
o allow other
>>>>>>>> ZNS drives, an emulation similar to SCSI can be implemented, with =
that emulation
>>>>>>>> ideally combined to work for both types of drives if possible.
>>>>>>>
>>>>>>> Enforcing QD=3D1 becomes a problem on devices with large zones. In
>>>>>>> a ZNS device that has smaller zones this should not be a problem.
>>>>>>
>>>>>> Let's be precise: this is not running the drive at QD=3D1, it is "at=
 most one
>>>>>> write *request* per zone". If the FS is simultaneously using multipl=
e block
>>>>>> groups mapped to different zones, you will get a total write QD > 1,=
 and as many
>>>>>> reads as you want.
>>>>>>
>>>>>>> Would you agree that it is possible to have a write path that relie=
s on
>>>>>>> QD=3D1, where the FS / application has the responsibility for enfor=
cing
>>>>>>> this? Down the road this QD can be increased if the device is able =
to
>>>>>>> buffer the writes.
>>>>>>
>>>>>> Doing QD=3D1 per zone for writes at the FS layer, that is, at the BI=
O layer does
>>>>>> not work. This is because BIOs can be as large as the FS wants them =
to be. Such
>>>>>> large BIO will be split into multiple requests in the block layer, r=
esulting in
>>>>>> more than one write per zone. That is why the zone write locking is =
at the
>>>>>> scheduler level, between BIO split and request dispatch. That avoids=
 the
>>>>>> multiple requests fragments of a large BIO to be reordered and fail.=
 That is
>>>>>> mandatory as the block layer itself can occasionally reorder request=
s and lower
>>>>>> levels such as AHCI HW is also notoriously good at reversing sequent=
ial
>>>>>> requests. For NVMe with multi-queue, the IO issuing process getting =
rescheduled
>>>>>> on a different CPU can result in sequential IOs being in different q=
ueues, with
>>>>>> the likely result of an out-of-order execution. All cases are avoide=
d with zone
>>>>>> write locking and at most one write request dispatch per zone as rec=
ommended by
>>>>>> the ZNS specifications (ZBC and ZAC standards for SMR HDDs are silen=
t on this).
>>>>>>
>>>>>
>>>>> I understand. I agree that the current FSs supporting ZNS follow this
>>>>> approach and it makes sense that there is a common interface that
>>>>> simplifies the FS implementation. See the comment below on the part I
>>>>> believe we see things differently.
>>>>>
>>>>>
>>>>>>> I would be OK with some FS implementations to rely on append and im=
pose
>>>>>>> the constraint that append has to be supported (and it would be our=
 job
>>>>>>> to change that), but I would like to avoid the driver rejecting
>>>>>>> initializing the device because current FS implementations have
>>>>>>> implemented this logic.
>>>>>>
>>>>>> What is the difference between the driver rejecting drives and the F=
S rejecting
>>>>>> the same drives ? That has the same end result to me: an entire clas=
s of devices
>>>>>> cannot be used as desired by the user. Implementing zone append emul=
ation avoids
>>>>>> the rejection entirely while still allowing the FS to have a single =
write IO
>>>>>> path, thus simplifying the code.
>>>>>
>>>>> The difference is that users that use a raw ZNS device submitting I/O
>>>>> through the kernel would still be able to use these devices. The resu=
lt
>>>>> would be that the ZNS SSD is recognized and initialized, but the FS
>>>>> format fails.
>>>>
>>>> I understand your point of view. Raw ZNS block device access by an app=
lication
>>>> is of course a fine use case. SMR also has plenty of these.
>>>>
>>>> My point is that enabling this regular write/raw device use case shoul=
d not
>>>> prevent using btrfs or other kernel components that require zone appen=
d.
>>>> Implementing zone append emulation in the NVMe/ZNS driver for devices =
without
>>>> native support for the command enables *all* use cases without impacti=
ng the use
>>>> case you are interested in.
>>>>
>>>> This approach is, in my opinion, far better. No one is left out and th=
e user
>>>> gains a flexible system with different setup capabilities. The user wi=
ns here.
>>>
>>> So, do you see a path where we enable the following:
>>>
>>>     1. We add the emulation layer to the NVMe driver for enabling FSs
>>>        that currently support zoned devices
>>>     2. We add a path from user-space (e.g., uring) to enable passthru
>>>        commands to the NVMe driver to enable a raw ZNS path from the
>>>        application. This path does not require the device to support
>>>        append. An initial limitation is that I/Os must be of < 127 bio
>>>        segments (same as append) to avod bio splits
>>>     3. As per above, the NVMe driver allows ZNS drives without append
>>>        support to be initialized and the check moves to the FS
>>>        formatting.
>>>
>>> 2 and 3. is something we have on our end. We need to rebase on top of
>>> the patches you guys submitted. 1. is something we can help with after
>>> that.
>>>
>>> Does the above make sense to you?
>>
>> Doing (1) first will give you a regular nvme namespace block device that=
 you can
>> use to send passthrough commands with ioctl(). So (1) gives you (2).
>>
>> However, I do not understand what io-uring has to do with passthrough. i=
o-uring
>> being a block layer functionality, I do not think you can use it to send
>> passthrough commands to the driver. I amy be wrong though, but my unders=
tanding
>> is that for NVMe, passthrough is either ioctl() to device file or the en=
tire
>> driver in user space with SPDK.
> =

> We would like to have an async() passthru I/O path and it seems possible
> to do through uring. As mentioned on the other email, the goal is to
> have the I/O go through the block layer for better integration, but this
> work is still ongoing. See other thread.

Indeed. I do not think that is special to ZNS at all.

>> As for (3), I do not understand your point. If you have (1), then an FS
>> requiring zone append will work.
> =

> In order to enable (2), we need the device to come up first. At the
> moment the NVMe driver rejects ZNS devices without append support, so
> either ioctl() or the uring path will not work.

I repeat again here: if you implement zone append emulation, there is no re=
ason
to reject devices that do not have zone append native support. Zone append
emulation gives you the block device, you can do ioctl(), implement the new
async passthrough and file systems requiring zone append work too. All prob=
lems
solved.


-- =

Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
