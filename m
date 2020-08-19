Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46249C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 11:17:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FEE206DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 11:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z/63ppIA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eInx34zA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vnpUlvO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FEE206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=NtIZkMB4QLnShM93YLFIb1brA9t5jDV+wEEQDZoq7JI=; b=z/63ppIA52O1hV7fht7h8J3ns
	KHtZPUWd+lU4h6PZf4+VJEhGsdYgRllRSsf1xHw2WJrCEVqV97Wn69LGYgByNSP7WBEg+GHRSOICM
	wvrjilKuaIopSkSrvcsLu8oCEk8AzuKCbIGJsmsq6bZ/+Hewj8D0UuS+/1hg5zG0fysc24azh9Z1Q
	Ancy44X+7Twplw8sE++bnl/zR1obu3k21Igg9M7gSuOx7wGzKQL2+zDdgntm+GIuKW4myNJ2bv7b5
	/JHLkSrqiIz5zdT5mTvwVM3bK0MG5HwofDPNqED47k4LOJ3DLMWRUHsRNKAWIv7ZEH9SW/80uCEO4
	VvdLlWCwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8M6A-00087K-0f; Wed, 19 Aug 2020 11:17:42 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8M66-00085a-Qr
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 11:17:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597835859; x=1629371859;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=hMq1oiVQRLzX4TC47DOEFHh+3BdCoKTIm0tRO0xUSTA=;
 b=eInx34zAOOjwWa0gXO9fLC4vCEXxBfwQMJQa0lANOjVOJ7tGrBunSnbp
 xNIU1t4oxD83781y8pH+gv+BHM55o7/AEB8oqbO3yKR2qoez541mdZ+I2
 2snWL4cqW2ap2B1TEiN5mXov85E5Jq44/UINKkN0mMumWyVtyugKiVkSj
 zdsLi8jxAlSz81/Sq6wRZPFnyZ3IBgbsVD58/cpMqhCB3MEtKbE2zanz6
 3EwprvAXlY0g2jkuvg76NPpMqofq8XrMIfehBGKjdaq0HEZENFRV8HYeo
 6T1ZY0eoPhjhwJS9BLWbxQrZ/XYPDXpZAl9yQMkSSHfrBeXC1/RJ0Yo7X Q==;
IronPort-SDR: P4IOIpyGx9el8iX1nFq7xBrJXrtIJSJsnyXfPJNG+Dhtva4PpEIxTH59c9FhxQ5ZtWjuxI3gqf
 A6YsArfYYeR3dm0bqUtjzxxN9vJr908COeKY2Fg8o7/rgevZl0K7cTkfKpDN3HXgELHw595JDd
 x4GqBB9le2YuuyD8mlgGa9UfroeAm7C/SIMZtcheQqvoin95KnDuLRFGwgRwvSpGMpYIcVtclu
 NjV1yD60ivweXFpFOC4LpRk4/sY1us/z8Yy00To3j5TGcBBfIVBSQ3zoXt7wjtoAKN1TtTVXMB
 LmQ=
X-IronPort-AV: E=Sophos;i="5.76,331,1592841600"; d="scan'208";a="149636131"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
 by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2020 19:17:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PigMxY2/oQz1q4OqSoqNdFkGm5Fj5F7xaBOFIhQOOGQUrDtRZgQWbIhEHZwlCduJ5rJbp/5HiOB5q6bex/hvoZKhXmKRW85Us3Qm9CwdYIiF5eZRF+kZ0TPP2tbs2QSgIXjv02HC2PzpMl5GOqgqwdvm4iIbf0CadMY29ZneD3FgNCNbMwFay27xda2Mi5uEFfReaff1RHDhh9iFRPUAGhQRQqc/YpqxcktRXEPOhJZzxiZxSVxiW5+M5leYRbONyUlKjrFn+M4ETS3Sams2dgLCT3e1ChnoFYr1e9LEHJNV80otAbHP25Z1oWJUJKE3VlSHKCF7GvzQQ+J3mD3GDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbF80ekpXZTXVthrpQxMqWZlcOOKaCnyZOvc/iPj5uE=;
 b=LD5mtAx0bahm/3vm441kRJ1oOAKNQk+OcRZeNRyiYg88NvBESN6moxf+iuEE7djZwDCVxg5QRiqPx8pKuRU/Ix7OKgCg6/uIRu6FJJrw0ikaigwAiaTFQMVY2jl/k6rX2QsSB2assfqgugbYinktR4a7GJXM7N1z0teFAImdBSxyMvbQHBMn3cPF96HkrRyt1HQa9xmX+Qfyc1cZxPpahvLCwcxeWzpR0/o+gJ+qq1AwVNRj+yuAR0l8Mt+Ow5y7TsbNbcn8gAy4xqXuyANFe26I2hEGx9CA0G/ILZkPjWzyl48/jScrn70LoJMz7ZUNmRAu/61PoclRyAWn3e0SEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbF80ekpXZTXVthrpQxMqWZlcOOKaCnyZOvc/iPj5uE=;
 b=vnpUlvO2924LXqUgJgBY4N3WSxnztfPV59Eow0psXotD79O+Jj5uwijVRyWpEir04z8Rqylolm9bHPu/0Q/YlcThLxkpksDPLj1vkvOT3fkNMaA5tqgEQkeilP67A17Y/X16UhhuUEO9dCYXVNUQXU/TFDrZ6XN9ouoKG21hs6w=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1175.namprd04.prod.outlook.com (2603:10b6:903:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 11:17:30 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3283.028; Wed, 19 Aug
 2020 11:17:30 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Kanchan Joshi <joshiiitr@gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Topic: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Index: AQHWdSEIMmCxi6h3l0CfpdyAr+vLMA==
Date: Wed, 19 Aug 2020 11:17:29 +0000
Message-ID: <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 105a9491-3659-4dac-9636-08d844317647
x-ms-traffictypediagnostic: CY4PR04MB1175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1175D09396A2BD8FE9B84838E75D0@CY4PR04MB1175.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtfN/YdFtJ9xqXtYL/V9umhdluOkYYv581DTB9HSKIpJ02ucGaocX2j6RPKaSlvVhJoPiCdwUViM551aszPWmUm/cTM+7Hks6YbLW4KXNzcP474yqK7KoI+bbV17WMJ2POcifXzGjzht9mhhFxZyWhnW49QIZXXJeMqqV8j11ilWxyNBR5lgb+FNA5Lrn2ao8PYJ51/hRiYIHSFse+HgKcUcdiLpejlTEvktv4amg4rmK3Rt7UlNc3j1NE7smgaBh5ylfgYrM7Iyz6XrgmFjc1ZIlLkGa8XfZ8egX0J3p+WUQCh1xKzFZm3whnVcLehgunIpQKTH9PkY5eUHB5lIEA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(186003)(54906003)(71200400001)(26005)(6506007)(53546011)(83380400001)(316002)(7696005)(55016002)(6916009)(9686003)(76116006)(4326008)(33656002)(2906002)(5660300002)(52536014)(66446008)(66556008)(66946007)(64756008)(66476007)(7416002)(91956017)(478600001)(86362001)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: ZUGclRIfuxoo2HHMX7t7PBJuNs5DveWG6FPm3Wzcw3t/DionWo1vYdwSEVP3KDASPm1lLRNs4GIMc0Zvr/ZQb1XSyOv4TRDr/H/2Ing+VM2lz96dOS6FvHP221a3zd4axdHKLCTjZLXMvR1TKjDRvxm/gktYQv9DNk7NBGUjKapXApHu/PtZDrLr1+wiV8SqBrTZy46kXzHhTBxeXl9o+B55PZ7JPfLuXHy6PvZeEr3LfnhyRVp+3JG0TSFVRCIIWTR50oIMk/xUrJQlAV0PUIHIGlHOCMHjrh0nKVdqMSMCeHtknooDYYJTWJ1aKoGpI1T2R7e1TgUtR7wvpnj189XnH5oo/uWmp0qOEhHxV4va7vohQIk8rZpsAWe2gBhWGqkZObJeIySdr8wBavUaKFlb90bVor+xNsNScxEerTgOGXBKjZPB8fIs+MqDw+6iR5XRb6UDRvdWC3WmldKHtCT2ObfkJFquHkyKRM3Px6bvV5bOwWokT3eNyXFflJwEBuuVCow0oA4SkGfb4C1KI7/61Z6nWNSs3iItEcP5krBefIhPSYj5wsmzYhcPbknkQmgHjZqnGY0VFJhS6Kx3Q91bix7DfXyvbiKyLWeuvnBFDk7QN2QBkidn7aOoDVo4ycK3bCaLlgk2x2EpE33a7g==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105a9491-3659-4dac-9636-08d844317647
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 11:17:30.0115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05sTsFfxoea8zZQ3g7SkRGx7BdHr5lCVm4iF5ZazoswAnp6zyevD31kzvNFGOe8+MpqQyz8IEFWps4M8EY2qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_071739_064929_7AA9B7C2 
X-CRM114-Status: GOOD (  25.75  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Selvakumar S <selvakuma.s1@samsung.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/08/19 19:32, Kanchan Joshi wrote:
> On Wed, Aug 19, 2020 at 3:08 PM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>>
>> On 2020/08/19 18:27, Kanchan Joshi wrote:
>>> On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
>>>>> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.
>>>>
>>>> No, it is not.
>>>
>>> Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?
>>> I see that null-block zoned and SCSI-ZBC both set this requirement. I
>>> wonder how it became different for NVMe.
>>
>> It is not required for an NVMe ZNS drive that has zone append native support.
>> zonefs and upcoming btrfs do not use regular writes, removing the requirement
>> for zone write locking.
> 
> I understand that if a particular user (zonefs, btrfs etc) is not
> sending regular-write and sending append instead, write-lock is not
> required.
> But if that particular user or some other user (say F2FS) sends
> regular write(s), write-lock is needed.

And that can be trivially enabled by setting the drive elevator to mq-deadline.

> Above block-layer, both the opcodes REQ_OP_WRITE and
> REQ_OP_ZONE_APPEND are available to be used by users. And I thought
> write-lock is taken or not is a per-opcode thing and not per-user (FS,
> MD/DM, user-space etc.), is not that correct? And MQ-deadline can
> cater to both the opcodes, while other schedulers cannot serve
> REQ_OP_WRITE well for zoned-device.

mq-deadline ignores zone append commands. No zone lock is taken for these. In
scsi, the emulation takes the zone lock before transforming the zone append into
a regular write. That locking is consistent with the mq-scheduler level locking
since the same lock bitmap is used. So if the user only issues zone append
writes, mq-deadline is not needed and there is no reasons to force its use by
setting ELEVATOR_F_ZBD_SEQ_WRITE. E.g. the user may want to use kyber...

>> In the context of your patch series, ELEVATOR_F_ZBD_SEQ_WRITE should be set only
>> and only if the drive does not have native zone append support.
> 
> Sure I can keep it that way, once I get it right. If it is really not
> required for native-append drive, it should not be here at the place
> where I added.
> 
>> And even in that
>> case, since for an emulated zone append the zone write lock is taken and
>> released by the emulation driver itself, ELEVATOR_F_ZBD_SEQ_WRITE is required
>> only if the user will also be issuing regular writes at high QD. And that is
>> trivially controllable by the user by simply setting the drive elevator to
>> mq-deadline. Conclusion: setting ELEVATOR_F_ZBD_SEQ_WRITE is not needed.
> 
> Are we saying applications should switch schedulers based on the write
> QD  (use any-scheduler for QD1 and mq-deadline for QD-N).
> Even if it does that, it does not know what other applications would
> be doing. That seems hard-to-get-right and possible only in a
> tightly-controlled environment.

Even for SMR, the user is free to set the elevator to none, which disables zone
write locking. Issuing writes correctly then becomes the responsibility of the
application. This can be useful for settings that for instance use NCQ I/O
priorities, which give better results when "none" is used.

As far as I know, zoned drives are always used in tightly controlled
environments. Problems like "does not know what other applications would be
doing" are non-existent. Setting up the drive correctly for the use case at hand
is a sysadmin/server setup problem, based on *the* application (singular)
requirements.


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
