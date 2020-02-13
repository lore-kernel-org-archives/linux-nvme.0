Return-Path: <SRS0=WUqE=4B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21101C352A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 02:40:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D1520675
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2020 02:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qAC1Lk2H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GFWV8NtQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="0FTL1Prd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D1520675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=sJkK+mSAQbwFq9a4ybIDUo7rjrKAQAv2iWhUWJ3cJIY=; b=qAC1Lk2HOohiYo
	Rafr59nwukUBfX4QiMaeQL2oaQgtIRtSyQBkrwaZg5jSFGtt93CplO6F/bIaCp5yUN95fEuvHgZAA
	2xJnTKIYhU/Kjgg7FPq9HX42SRwR/IWZWBzA3NX8aIQeqIA3uhEtkiKVgxJ804YXkoG7s3dYyDnbG
	+rKMeLNNwjv5RMRoGbtKjgIYfVPPHLb+nYtQaQ2lsTtJ7cIQsnif8Wt/pJ5qVHffKkviYvlFBGw8e
	mbh65wPJ2Nt+rt9wsF+5Uq1GqieLFILsrD/Gd5NFevq0bXVeCzgNEyh+7NtJ5bzVck748SUvsfcJj
	u82jQSX3WGppFbrCjJuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j24Qs-0003Qe-F5; Thu, 13 Feb 2020 02:40:50 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j24Qp-0003QG-LQ
 for linux-nvme@lists.infradead.org; Thu, 13 Feb 2020 02:40:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581561647; x=1613097647;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=u1J/9mBISALm+hIQt3XvnlreC77p/vfHN05dWI86Kng=;
 b=GFWV8NtQcRzLorsSuVTNTYad7t302lmMghupBX2FrBAinnYLblMY5F/f
 G09iK8NMWZpq7ZBV5MknpeJIQcYquv87Etp5uvGNQLwpWK9uz/Bp5grMz
 mEYlO7AUgqu9Mumo1xniDwd3KLijgD5u7ZwF1gkVHznOhqtWRtRNG8FSj
 jN57KpGsY+CgHkRWBLJQZJL1akIag10N/2lbgZMih46+d7BkZMqtXg+H8
 kgqyrvye4b4ES+cstZfqnV1BNHZ0vsw0Js4Z3SY88Ngw0Ni526sFolzOs
 1nytpZfXjm6y4zPpVP9XUCAFT58sNYC1+13/7IEjkxuSiU4SMemIvjIK1 Q==;
IronPort-SDR: M5hQS5JNxpW6+i5NKsbpO343QHDSh/5wVVnq8kOMmFgkl7e2UkcYCgwGMmFO+HKuw34FqWI8OO
 fHQnJ1G8T+jRXDr5Q/75ozUvU2jAoW94EQas3iLzs3yuKogQukVpad0y6th7OASUAqaZJ/fd4g
 rl5TEE3PRF+TbACuBG+znT80KF+Sd+E0+HnfpHWmq4z1dJopw1bmXgeGM7EIWgemQOJCnx6UJd
 QSXtnkAtZ1X/Wy0Eofef8+qoL1vKZdZEZa3eTNAlsdNCiL8ohBQyMCRImef6PJg2vk3rqNxiqT
 em0=
X-IronPort-AV: E=Sophos;i="5.70,434,1574092800"; d="scan'208";a="131185243"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
 by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2020 10:40:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMYrjrurPrLHdD+NePqWJe9agWHJg56aneziM3DuNocTc4qJHHiuvNOS8F1kMR+vYbz13Emnd+ZB/dsqBmSzcv3tJ6nu4vecwTq7fBsH1sstkdZDC2pTowQ+JKxpSrM1VWOKcwuobYOhPBrART1Mk1oRyfVR5sLaH4UIv/T9LNS3TcZgmzlSqDN7cEldCzXNPdQsrAMzp3M3zCUDK+osONgQfEiXxu4/+kBe7g2znir7fZPND4zmzS/XIvH17Lsd6X2hrsUDnKX0AfRXa+JA6efyryWLY803EWJ2H5s38zUSqBGFXq5PFNlQtvAByfexIP52CqCllPyn1F1Gb+UBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1J/9mBISALm+hIQt3XvnlreC77p/vfHN05dWI86Kng=;
 b=f6pMSZleQcIzmwLb1E0BZJTFx9/N9GYmtY1rctc6iIrsw15l9HBv9uSB/kBJHnfmm9RYqb7lI4j0p07A8qCJ1rlNsfAxpuw1lgmOMPNakQh3jkPp/Mu0vDVEs0pg9AROlKAapoRRZ7x6Kvf4FHtPfIuFVwhcVGkXCZjx+S2Qy5e1ZkUHx9j2s5g7p8P4NSQYj9dCE6054FqvyP4e2VL2Ec8hcFe5YM+ZilB1N0pdMc5Itr5wFTyVxAlcGG4n9XtwewisY9kqdDPhkSLBOLlxxu5PwHaWZBs7Ta7Dd1OYgG6lgbvL+LOBIRXfO874MCISUxC7kUx4ukpMOtsR+v5sdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1J/9mBISALm+hIQt3XvnlreC77p/vfHN05dWI86Kng=;
 b=0FTL1PrdnlQGz22+pIZVfTzm7m2usfqLk6qkyw7qXrMrVrlKz0bFA07yNXhXzlQEyoDdChmvW23wTDjj8kE5svq8FxVZPDav7Kwz/d8pmwmIhwBn4lelGYEAoyr+iCWiJHb9VoERGni6+E4zyxNY+u+/l5po4M3Bptp4Dq+rzK8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4021.namprd04.prod.outlook.com (52.135.213.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 13 Feb 2020 02:40:42 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 02:40:41 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Thread-Topic: [LSF/MM/BPF TOPIC] NVMe HDD
Thread-Index: AQHV4EctI/0h/tDOq0WOdKN0iYUQSA==
Date: Thu, 13 Feb 2020 02:40:41 +0000
Message-ID: <BYAPR04MB581622DDD1B8B56CEFF3C23AE71A0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
 <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200212220328.GB25314@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 78907afe-5a3d-496d-b8ad-08d7b02e1e4b
x-ms-traffictypediagnostic: BYAPR04MB4021:
x-microsoft-antispam-prvs: <BYAPR04MB402116FC6CB81871F7A0E83DE71A0@BYAPR04MB4021.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(199004)(189003)(7696005)(478600001)(54906003)(81166006)(9686003)(71200400001)(8936002)(55016002)(52536014)(966005)(5660300002)(8676002)(81156014)(4326008)(316002)(66446008)(66556008)(64756008)(66946007)(66476007)(76116006)(186003)(53546011)(33656002)(91956017)(2906002)(26005)(6506007)(86362001)(6916009);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4021;
 H:BYAPR04MB5816.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQy2nH55Pzlk4yal9gnsXXqtlqKJn0GdVBVu6kZti/hFnw0XSGGeFZF42m0S4HBxlxCqNFVgBSgFzIzCWBkVSwfG0ZHjX2CLrJ59pu+pMzV0o+tz9FPvPIA+fgkZtexJFy+GIwtY/keQfbpaVYizenA8p1OccTg40nOeyblpzK9YiJkUVwLVxMOyzPOots0t+psu0Nzahf5DUexpwly+zVFq5d8WIlaYmsdm3m+PZjbFWBYXXbhVb7BD83k8X1hDoyUTE2H7C80G9lmAPXoaeVfbPQMFJ7rXz9WcPeOBSChAXHz5bWHraCGWBrOlkY0Fa7gxjhRttkAcfM901qa07Rpv8KoZdrbiX+pRfV+6/jffb/HJEXJa1gD185/LEC2hSOYwmdv0jG4tkBi9b9X8xIF7BYINSCx/b9VIaqOO05GQ7C5ZR9QLwA8nWa4AOGtUILYeDSNvc4kvH6OL/bYXXA+yK7YLNOHG2Q714Ze14JwzboaCPxRNtdy/XULi2dItafIbig7eXMowizxsAlkc6Q==
x-ms-exchange-antispam-messagedata: Uz2dqrLkOoTrBC3xK7EiZ2w7wIykHQHC9QTgBfJcWf4fgWbbx/d3RBoq//cPXJQVaTUVnVglpPQN21l/YTffB2ve4VR5YLUWgchYCL8sNXe9s4hpfj1AXE8ZPwCRXSueR2v6V8ersiTnG4ADZDtFZg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78907afe-5a3d-496d-b8ad-08d7b02e1e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 02:40:41.7448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63VuXmQe30Nf15uKVRxTQ4ase/VpCgDcgxn3oDJFozXyAS6la3KzTICyDmiCVJzQCCbjfadae8WCm35bWEbGVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_184047_790669_500AAB4D 
X-CRM114-Status: GOOD (  19.99  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tim Walker <tim.t.walker@seagate.com>, linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ming,

On 2020/02/13 7:03, Ming Lei wrote:
> On Wed, Feb 12, 2020 at 01:47:53AM +0000, Damien Le Moal wrote:
>> On 2020/02/12 4:01, Tim Walker wrote:
>>> On Tue, Feb 11, 2020 at 7:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>>>>
>>>> On Mon, Feb 10, 2020 at 02:20:10PM -0500, Tim Walker wrote:
>>>>> Background:
>>>>>
>>>>> NVMe specification has hardened over the decade and now NVMe devices
>>>>> are well integrated into our customers=92 systems. As we look forward,
>>>>> moving HDDs to the NVMe command set eliminates the SAS IOC and driver
>>>>> stack, consolidating on a single access method for rotational and
>>>>> static storage technologies. PCIe-NVMe offers near-SATA interface
>>>>> costs, features and performance suitable for high-cap HDDs, and
>>>>> optimal interoperability for storage automation, tiering, and
>>>>> management. We will share some early conceptual results and proposed
>>>>> salient design goals and challenges surrounding an NVMe HDD.
>>>>
>>>> HDD. performance is very sensitive to IO order. Could you provide some
>>>> background info about NVMe HDD? Such as:
>>>>
>>>> - number of hw queues
>>>> - hw queue depth
>>>> - will NVMe sort/merge IO among all SQs or not?
>>>>
>>>>>
>>>>>
>>>>> Discussion Proposal:
>>>>>
>>>>> We=92d like to share our views and solicit input on:
>>>>>
>>>>> -What Linux storage stack assumptions do we need to be aware of as we
>>>>> develop these devices with drastically different performance
>>>>> characteristics than traditional NAND? For example, what schedular or
>>>>> device driver level changes will be needed to integrate NVMe HDDs?
>>>>
>>>> IO merge is often important for HDD. IO merge is usually triggered when
>>>> .queue_rq() returns STS_RESOURCE, so far this condition won't be
>>>> triggered for NVMe SSD.
>>>>
>>>> Also blk-mq kills BDI queue congestion and ioc batching, and causes
>>>> writeback performance regression[1][2].
>>>>
>>>> What I am thinking is that if we need to switch to use independent IO
>>>> path for handling SSD and HDD. IO, given the two mediums are so
>>>> different from performance viewpoint.
>>>>
>>>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel=
.org_linux-2Dscsi_Pine.LNX.4.44L0.1909181213141.1507-2D100000-40iolanthe.ro=
wland.org_&d=3DDwIFaQ&c=3DIGDlg0lD0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxC=
bQJZPWcIkPT0Uy3ynVsFU&m=3DpSnHpt_uQQ73JV4VIQg1C_PVAcLvqBBtmyxQHwWjGSM&s=3Dt=
snFP8bQIAq7G66B75LTe3vo4K14HbL9JJKsxl_LPAw&e=3D
>>>> [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel=
.org_linux-2Dscsi_20191226083706.GA17974-40ming.t460p_&d=3DDwIFaQ&c=3DIGDlg=
0lD0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQJZPWcIkPT0Uy3ynVsFU&m=3DpSnHp=
t_uQQ73JV4VIQg1C_PVAcLvqBBtmyxQHwWjGSM&s=3DGJwSxXtc_qZHKnrTqSbytUjuRrrQgZpv=
V3bxZYFDHe4&e=3D
>>>>
>>>>
>>>> Thanks,
>>>> Ming
>>>>
>>>
>>> I would expect the drive would support a reasonable number of queues
>>> and a relatively deep queue depth, more in line with NVMe practices
>>> than SAS HDD's typical 128. But it probably doesn't make sense to
>>> queue up thousands of commands on something as slow as an HDD, and
>>> many customers keep queues < 32 for latency management.
>>
>> Exposing an HDD through multiple-queues each with a high queue depth is
>> simply asking for troubles. Commands will end up spending so much time
>> sitting in the queues that they will timeout. This can already be observ=
ed
>> with the smartpqi SAS HBA which exposes single drives as multiqueue block
>> devices with high queue depth. Exercising these drives heavily leads to
>> thousands of commands being queued and to timeouts. It is fairly easy to
>> trigger this without a manual change to the QD. This is on my to-do list=
 of
>> fixes for some time now (lacking time to do it).
> =

> Just wondering why smartpqi SAS won't set one proper .cmd_per_lun for
> avoiding the issue, looks the driver simply assigns .can_queue to it,
> then it isn't strange to see the timeout issue. If .can_queue is a bit
> big, HDD. is easily saturated too long.
> =

>>
>> NVMe HDDs need to have an interface setup that match their speed, that i=
s,
>> something like a SAS interface: *single* queue pair with a max QD of 256=
 or
>> less depending on what the drive can take. Their is no TASK_SET_FULL
>> notification on NVMe, so throttling has to come from the max QD of the S=
Q,
>> which the drive will advertise to the host.
>>
>>> Merge and elevator are important to HDD performance. I don't believe
>>> NVMe should attempt to merge/sort across SQs. Can NVMe merge/sort
>>> within a SQ without driving large differences between SSD & HDD data
>>> paths?
>>
>> As far as I know, there is no merging going on once requests are passed =
to
>> the driver and added to an SQ. So this is beside the point.
>> The current default block scheduler for NVMe SSDs is "none". This is
>> decided based on the number of queues of the device. For NVMe drives that
>> have only a single queue *AND* the QUEUE_FLAG_NONROT flag cleared in the=
ir
>> request queue will can fallback to the default spinning rust mq-deadline
>> elevator. That will achieve command merging and LBA ordering needed for
>> good performance on HDDs.
> =

> mq-deadline basically won't merge IO if STS_RESOURCE isn't returned from
> .queue_rq(), or blk_mq_get_dispatch_budget always return true. NVMe's
> .queue_rq() basically always returns STS_OK.

I am confused: when an elevator is set, ->queue_rq() is called for requests
obtained from the elevator (with e->type->ops.dispatch_request()), after
the requests went through it. And merging will happen at that stage when
new requests are inserted in the elevator.

If the ->queue_rq() returns BLK_STS_RESOURCE or BLK_STS_DEV_RESOURCE, the
request is indeed requeued which offer more chances of further merging, but
that is not the same as no merging happening.
Am I missing your point here ?

> =

> =

> Thanks, =

> Ming
> =

> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
