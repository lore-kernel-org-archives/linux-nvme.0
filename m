Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC46C35242
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 01:48:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1402070A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 01:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dU9/+z+F";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nG08CPOd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OjqR0TKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1402070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hqmp98wkTjOyqxDSk6TCg0bC8r+NRlkyREDObGqlwFE=; b=dU9/+z+FvfpQVi
	6xOBfT04mppRx/uSDvkcZyWDlYOsJlXLmy6KwKGzSBE17nc66vKBC6a/m058lIz8f3zwpsLzcR7BI
	rsQ0JTdeB1v0FDk91qtANR2TYJjQfTS7b7F8ZEL07kftacN97vWZvBPg17rSgo/g6krfK4SWz9l+Y
	XfJ8dOV5vvdzz1mb9Dc+d7lRlpBEEAitcd2z+T2g1D2jnn90YmjZ26mXMxg2ysXejiXGjdnPIxwO4
	noVV+0MDr/AYzo+14/Fl+yEK5TkFQogO8hSqucS7ih6XVrrnUYHG+tz1HcBYKXvFiKgPiisJ3LT2u
	C2baFYiprEPpSQ0Fto0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1h8F-0004Ac-Rn; Wed, 12 Feb 2020 01:48:03 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1h8C-0004AC-Bu
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 01:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581472081; x=1613008081;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=9e6H/fJIqYn74cSdWIiFWfb8fJ5e83HYFyFiBwU3TR0=;
 b=nG08CPOd+ul/OoCKTAq3XwKM2MN4bh7RH4k//v+KzyLP2kBqFrslL6TF
 hytkA1s07jgJanU3E2p/dnt6ibp3XS27Y+a/jx3kBmiJr7YlXeOsKEAYF
 sA/LHtZj4iSI7vCAr1WHJWJwRc/X8KjN82/nAizm+utQhPnVJaItibF0R
 +et98IBjTGu6Jco+yhic+0MmYHQGZFxx2GlwZeuDqD6fhMuWkY4l7jxPU
 0jO/BO0SPFkQLTJ0KUh85KGmkpXAorvVhZx8vLFfoBF7PDfQeZ7szE4g7
 GaiHm2gMap1AqTsCD6JHW9G6X51sZlYzttmElnkh+rfsbRyF4T/7zHGCZ Q==;
IronPort-SDR: P5R04omDlltTXJ0Ax1HroYtOqrMTVJJzmWk0m6fWDdxt+5uz3RmitDmIhdKSMo7U6p4LUzk+hI
 Bal9GcArnItv149tE3BZ0LNt9Qc65aWV9Y5IG2XCy0HKW9dco+rNW7kHiQugKd9jgkwtP4s0LC
 ehhCuHQryEcIByGTLenltC+BmIrMtURGsBFtp9zlIQEo8hJm7z9/4BQ+G4MPmuAbHYWSegCqEY
 Ex/ZsVnlySP6fUBetlbM8OtHaUDUVhRLCqebr9lzlD6c5bAHZnXvca4essr5FuT7Z+Uo4bW2z6
 Xzg=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; d="scan'208";a="133988267"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 09:47:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSls46g3CtCqZ2j6fGWxK4VubJEF314T7DzHpypE1GXqjF6RdozvzZH9KUjjUG175v77kWtQPdAM04B20dqUNiWPBQG7mjuFp5P0c7k3pGaXIjaz1cRjwbUFsIEEI5tIVXJylkb+X2kIqLEDvt0dUTaBaQfQCkkUJ9q2kCcod9E2ERSqpVI3uK0FMD+braMHHV/N+PGaTvUgN/AiqHBRW5tEA/nxnT2vT/vn/hZOQza2zzMo/AJikXlzZz/By8eqed8YJKPtsKZ+8tN1y7hQTU03+qbU6RU9AFRXCVdT7UaZpyyfgzylfm0gYLoO6IAQ/e4R6+Zth8fvPv76iqf0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e6H/fJIqYn74cSdWIiFWfb8fJ5e83HYFyFiBwU3TR0=;
 b=LzSSuqpf8Qem8p9FINY87LBHFYB6G+8kSZBXCziCyMGaZhY5PDvKt1GoUzWkGr0+yAxEb1xpypJGO31Gx5MVKOkllm/7XBiWQ5ttOGJgV0CW38qFs6ZLglI192g3+cPuGBQv7Jrykwk6HBQNUh50PXb5NTaBhcS6XrxtHJDe+bnpnOZyxHDivZEdAGq51GL5f8nYuvIkV6WU5KgnZsM3BTvRa/dt0JDzDk1ni+TbgDe+V23b/ulR+oxtNYpgdXZxrrhuvbb6Nv4igZ8+I/WVpGmBvLwUkH3Nn4wnVNcHjHoOitW5VVinHWas8hnR7HOSaMG3kHWhw3dnENxdpei/Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e6H/fJIqYn74cSdWIiFWfb8fJ5e83HYFyFiBwU3TR0=;
 b=OjqR0TKH4UGSb9Ba5t7dUryhzZjC/vZKUBY1McivYEV7i5Q0hFyyE3KVHlxUSsVwvjHY3KB8gYP1Hm0GY+IcEUGDby4YLJ488VNhQsPeWoc/TgvHTiwRqDivJ1gmQZyLG3JdUKcZiJ1A3qh1favi403yv/+pdiJRB1y41OjzN3M=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3846.namprd04.prod.outlook.com (52.135.213.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.25; Wed, 12 Feb 2020 01:47:54 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 01:47:54 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Tim Walker <tim.t.walker@seagate.com>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Thread-Topic: [LSF/MM/BPF TOPIC] NVMe HDD
Thread-Index: AQHV4EctI/0h/tDOq0WOdKN0iYUQSA==
Date: Wed, 12 Feb 2020 01:47:53 +0000
Message-ID: <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <CANo=J14resJ4U1nufoiDq+ULd0k-orRCsYah8Dve-y8uCjA62Q@mail.gmail.com>
 <20200211122821.GA29811@ming.t460p>
 <CANo=J14iRK8K3bc1g3rLBp=QTLZQak0DcHkvgZS2f=xO_HFgxQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 291d8f55-320c-420f-e7b9-08d7af5d93ae
x-ms-traffictypediagnostic: BYAPR04MB3846:
x-microsoft-antispam-prvs: <BYAPR04MB3846B7AD273BA2F9384DD183E71B0@BYAPR04MB3846.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(71200400001)(66556008)(4326008)(66946007)(66476007)(66446008)(64756008)(76116006)(91956017)(2906002)(52536014)(81166006)(316002)(26005)(86362001)(5660300002)(7696005)(53546011)(966005)(33656002)(81156014)(54906003)(55016002)(186003)(9686003)(8676002)(110136005)(478600001)(6506007)(8936002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3846;
 H:BYAPR04MB5816.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I9vp/R68yWPiUg9PkZy+V1lOtKfYwQInBLXBxqNm4CpgLcFBGgPjAV8BBi1bG2OsI7HUsVpy+wbUsgbSRFRSqNYWhuPjI9eibZJQWy517HJZQXHKzaqWA7Py76NgMvuVVaXenhaHIRkrqcqCUgNfbtM0BT7cna2pn2kX3r8+cIlJV1Fr26YLGO6FbnP2c66Bq/mn5B5eCCPE0Fb0iuCled0a8F5vd08Yq00Y6/TxXxOtaiqftf9xWe5fmqC0Qf7hru/5nu0+Qcw7esAjMK2fUhggU036Kbi8doVf1D0zDAGa//CTLWAfclx12K+etBub7cngnGGProEPauJP+f9RV2U9lEzMkxDlByYs3TBXDzmq5mvvoZQyiVclQtkiCKAuVmIW5aezNb/AmwHZYhmdR81RLBlZil2IP8xAKRum5kE4pLnmU87bUuk6psPpy5wXUhOgZQm7AtBGP9yglKeCxaMy6EvG6UC7agsHa9Em4bGcpbuwvIvLh6Nmu4qm0PnhAEnkw+eDH/O3rGkzDFfIEQ==
x-ms-exchange-antispam-messagedata: A+/8b4R2oyBEUXn2fUKLin4M7/gSrHDhy22JdxqXb2OOBq4xnzyg4+gkyDt/nZS5qB6pHb9wj+pBxOYDtkvKHuwfsJDkzGfsjCxlC3Jt+kb21j2waPhad0aN4gl8OFXTaH7748xySDj7/A7Tj+5rFA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291d8f55-320c-420f-e7b9-08d7af5d93ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 01:47:53.9268 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9Jv9X8E9UP1gqOoMkOXfJJ7GF7k0jebQnRhp4myXvaqHV4MattThf3A+lWqzjlFendqF8XS+k7Jkr5uPcvrEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3846
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200211_174800_652104_EA63ED0D 
X-CRM114-Status: GOOD (  16.39  )
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
 linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/02/12 4:01, Tim Walker wrote:
> On Tue, Feb 11, 2020 at 7:28 AM Ming Lei <ming.lei@redhat.com> wrote:
>>
>> On Mon, Feb 10, 2020 at 02:20:10PM -0500, Tim Walker wrote:
>>> Background:
>>>
>>> NVMe specification has hardened over the decade and now NVMe devices
>>> are well integrated into our customers=92 systems. As we look forward,
>>> moving HDDs to the NVMe command set eliminates the SAS IOC and driver
>>> stack, consolidating on a single access method for rotational and
>>> static storage technologies. PCIe-NVMe offers near-SATA interface
>>> costs, features and performance suitable for high-cap HDDs, and
>>> optimal interoperability for storage automation, tiering, and
>>> management. We will share some early conceptual results and proposed
>>> salient design goals and challenges surrounding an NVMe HDD.
>>
>> HDD. performance is very sensitive to IO order. Could you provide some
>> background info about NVMe HDD? Such as:
>>
>> - number of hw queues
>> - hw queue depth
>> - will NVMe sort/merge IO among all SQs or not?
>>
>>>
>>>
>>> Discussion Proposal:
>>>
>>> We=92d like to share our views and solicit input on:
>>>
>>> -What Linux storage stack assumptions do we need to be aware of as we
>>> develop these devices with drastically different performance
>>> characteristics than traditional NAND? For example, what schedular or
>>> device driver level changes will be needed to integrate NVMe HDDs?
>>
>> IO merge is often important for HDD. IO merge is usually triggered when
>> .queue_rq() returns STS_RESOURCE, so far this condition won't be
>> triggered for NVMe SSD.
>>
>> Also blk-mq kills BDI queue congestion and ioc batching, and causes
>> writeback performance regression[1][2].
>>
>> What I am thinking is that if we need to switch to use independent IO
>> path for handling SSD and HDD. IO, given the two mediums are so
>> different from performance viewpoint.
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_linux-2Dscsi_Pine.LNX.4.44L0.1909181213141.1507-2D100000-40iolanthe.rowl=
and.org_&d=3DDwIFaQ&c=3DIGDlg0lD0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQ=
JZPWcIkPT0Uy3ynVsFU&m=3DpSnHpt_uQQ73JV4VIQg1C_PVAcLvqBBtmyxQHwWjGSM&s=3Dtsn=
FP8bQIAq7G66B75LTe3vo4K14HbL9JJKsxl_LPAw&e=3D
>> [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_linux-2Dscsi_20191226083706.GA17974-40ming.t460p_&d=3DDwIFaQ&c=3DIGDlg0l=
D0b-nebmJJ0Kp8A&r=3DNW1X0yRHNNEluZ8sOGXBxCbQJZPWcIkPT0Uy3ynVsFU&m=3DpSnHpt_=
uQQ73JV4VIQg1C_PVAcLvqBBtmyxQHwWjGSM&s=3DGJwSxXtc_qZHKnrTqSbytUjuRrrQgZpvV3=
bxZYFDHe4&e=3D
>>
>>
>> Thanks,
>> Ming
>>
> =

> I would expect the drive would support a reasonable number of queues
> and a relatively deep queue depth, more in line with NVMe practices
> than SAS HDD's typical 128. But it probably doesn't make sense to
> queue up thousands of commands on something as slow as an HDD, and
> many customers keep queues < 32 for latency management.

Exposing an HDD through multiple-queues each with a high queue depth is
simply asking for troubles. Commands will end up spending so much time
sitting in the queues that they will timeout. This can already be observed
with the smartpqi SAS HBA which exposes single drives as multiqueue block
devices with high queue depth. Exercising these drives heavily leads to
thousands of commands being queued and to timeouts. It is fairly easy to
trigger this without a manual change to the QD. This is on my to-do list of
fixes for some time now (lacking time to do it).

NVMe HDDs need to have an interface setup that match their speed, that is,
something like a SAS interface: *single* queue pair with a max QD of 256 or
less depending on what the drive can take. Their is no TASK_SET_FULL
notification on NVMe, so throttling has to come from the max QD of the SQ,
which the drive will advertise to the host.

> Merge and elevator are important to HDD performance. I don't believe
> NVMe should attempt to merge/sort across SQs. Can NVMe merge/sort
> within a SQ without driving large differences between SSD & HDD data
> paths?

As far as I know, there is no merging going on once requests are passed to
the driver and added to an SQ. So this is beside the point.
The current default block scheduler for NVMe SSDs is "none". This is
decided based on the number of queues of the device. For NVMe drives that
have only a single queue *AND* the QUEUE_FLAG_NONROT flag cleared in their
request queue will can fallback to the default spinning rust mq-deadline
elevator. That will achieve command merging and LBA ordering needed for
good performance on HDDs.

NVMe specs will need an update to have a "NONROT" (non-rotational) bit in
the identify data for all this to fit well in the current stack.

> =

> Thanks,
> -Tim
> =



-- =

Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
