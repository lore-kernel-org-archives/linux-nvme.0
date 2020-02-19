Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A70BC34031
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 01:54:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16F5824654
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 01:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SMvWXxbm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c4/a4CTi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fhHfbZQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F5824654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=54NOrUqIyjYcZfr1RR2jpQRdEbNh9a82JmmH7lVUavE=; b=SMvWXxbml9fcOV
	yr1Gy3tf0SJMr75CHjJQWioNLUEzZh5gYuEyeQXAzmAjJK6Xu6bJBS8I1e8nKpduL6UFPrlSpQyf+
	LFRoDYMfZGS8CtD01Y8VI4CgO4Z3H6I/unRrRyT8LeHR7iQmA8YygFYxHvkpDy8d2uyNIuizgVwXa
	u2orkC/cFqG3XTfKsMJXdTXKdz/Fce0L2q9RfrWql1RQHptun2pMzektxpzvKwPmkXtYqZT7SQHVG
	LtUe3kINel/uT2Wz6YcFu0K6l5erPp83TZzVghBrFHnfpnSYL3GwLgB0x3fQ54HO1YxwAk3J7zKOh
	JB8e94AIejfCu80mfPMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4EYs-0007Jj-L9; Wed, 19 Feb 2020 01:54:02 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4EYq-0007Iu-2J
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 01:54:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582077239; x=1613613239;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=C4b5MbHB+/G8AHIkSZVnnaiTZrkK6rScfUNtJNqV0rk=;
 b=c4/a4CTi+DvgsGMkn3DvcZMPdZK7/tYzEQiGPQRWdw9tjL6ls6E2je6+
 w6KLduA9OBP7KeLqrnb5y0puVOW0VUgKdQOFsGqmV3kPNlYOcX1er7ZPb
 mFQSTNo76qF+a/2R+OYykUFqKBKYgObxRZuUeSPvNRA0GhVUFydlnmR7t
 TLCD8XGwBrsAsoeIkhzsJwFvL5JIwWmbqKFJd/S/1R4yrhP97Cy6QU3bG
 qbJbNq3xranYKq6sA9DaOhchEyH/XGMNyqIP85S2Kip2JIZgmmnlpMc3J
 k7fAIT+W6T6cQe25FgnxTrrqDvyMGK9Wp4nLRqfDPJvB88L+3H/L3Q4Nd A==;
IronPort-SDR: ZXDjF0MMVF9XmbsubOVkwHNV7d3eP2ycJz+QFBOoEgue1tsXg+RKWVoxz6wRL6SVJIWZDgc68b
 pBUCenHHVsDgayGZ3iO5RjzVqf69e4r9QoKxNwkmyLIpoYRx1PzIwTm4e66+hga+ibDoEdjV+G
 8C66MoNJmRmOB1/KoiLaRHBFVyLVg0RI+YZ3zdaYOpyhJUtO07GxBiJtBnGUBS4Mhqug3Vvua5
 L8pArMMrSwav+L1xU4gfRhgtSqHWw+uXGaCNsXtCgLX2H75VVqLo8sc9Lcdk9pk2h8WvAs1Nig
 mcw=
X-IronPort-AV: E=Sophos;i="5.70,458,1574092800"; d="scan'208";a="130137500"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 09:53:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdqjo3xp+IyNSAcOmlU4QZN0RLRHM5BnVnG3Via9jFKUDLWGgLLvrht0oHnr38gZsE7YAB5Waac/FAAagSRki6Xa29iN80l4RY0d7nJF49m6NT+OlU341BxegpiWoi49UMQ2sAf0GBnG1IuFT2tj+y2fKyTob0J8JJlzBc8PGAulDQtV/mRsxllGHS2azduE7VmdJ3RwKRfGXb2HDYT04I8hNfrJdk0fM0W9OFCCc4XCKu4jmolAStfJ9vbXCvBGB3JYkRg9QVYzZ3LNqotjWJeJIve++9nQf1jIs9kq7OPZzZhiF/kNSv+cRcUXHzt6u1cLff86gl5jqvH7q9wFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvxZxGHWq3pe705JX0ZYr7NqUDqcD3Lx5P/PsvXP0gg=;
 b=nFx2CL19+oOzuxYBnUlqb/9TwkxOcOBke8S91Wb3zsP1gaNblz0kvo4S/lEDk+N+I1EYpp+5xUJYKnfkvArvBrHL9FkuceopXaCKjxjM3EamuoGANQg+tdCMzXfs2+or3VEMPsICHy7ywXEiQCnk7aTPR7YcXEZLr0X++0KRl8vYejZuwXRNLZyIbKNg2J+jpG+NJz/jEK8od/PcEBxsZLtqmdEuRxA9DLmhlV9X73MUjEB7L5WoTA19B3Iz6Edazf9Mhg/tq+OLQJK7t/gtlPf1srOtS6Mtp2ultslkyClE+VO/DJxO5tCUCziAvLx38WMTn17HZuvRhMUCFpPVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvxZxGHWq3pe705JX0ZYr7NqUDqcD3Lx5P/PsvXP0gg=;
 b=fhHfbZQDHsydXP6IMg1yZz4khxZLuAB0oMyoAWwyZPwq5gJFZxfkiNgdfuLS5IaR2bXusYqUk5fKz+FALbJ5AHX2JSfKETV7a85DatrJwj5+6H0rpew2GLGVdYW7Fjsi57jrwvZlvMbzooXY0yBBKgjZi9Rt8y7i77j0D2YZTg8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4760.namprd04.prod.outlook.com (52.135.239.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.31; Wed, 19 Feb 2020 01:53:54 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::6daf:1b7c:1a61:8cb2%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 01:53:54 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Ming Lei <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Thread-Topic: [LSF/MM/BPF TOPIC] NVMe HDD
Thread-Index: AQHV4EctI/0h/tDOq0WOdKN0iYUQSA==
Date: Wed, 19 Feb 2020 01:53:53 +0000
Message-ID: <BYAPR04MB58165C6B400AE30986F988D5E7100@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <BYAPR04MB5816AA843E63FFE2EA1D5D23E71B0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <yq1blq3rxzj.fsf@oracle.com>
 <CANo=J16cDBUDWdV7tdY33UO0UT0t-g7jRfMVTxZpePvLew7Mxg@mail.gmail.com>
 <yq1r1yzqfyb.fsf@oracle.com> <2d66bb0b-29ca-6888-79ce-9e3518ee4b61@suse.de>
 <20200214144007.GD9819@redsun51.ssa.fujisawa.hgst.com>
 <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
 <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
 <CANo=J17Rve2mMLb_yJNFK5m8wt5Wi4c+b=-a5BJ5kW3RaWuQVg@mail.gmail.com>
 <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
 <20200219013137.GA31488@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 033d0c78-a9cc-484a-a91e-08d7b4de9322
x-ms-traffictypediagnostic: BYAPR04MB4760:
x-microsoft-antispam-prvs: <BYAPR04MB4760EB1B70F5A1BB8FEDD76FE7100@BYAPR04MB4760.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(71200400001)(81166006)(52536014)(81156014)(478600001)(66476007)(8936002)(66446008)(55016002)(33656002)(8676002)(7696005)(64756008)(66946007)(66556008)(5660300002)(9686003)(4326008)(86362001)(186003)(91956017)(76116006)(6506007)(53546011)(2906002)(26005)(316002)(110136005)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4760;
 H:BYAPR04MB5816.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eXp7Few2syXh/r5sKhOljXJKTPslk5L5GoR42Mwa25AzsviJ1QTdYxCDS0O8m1mYD9FPNGg/m8zrDSska49hrjyOdfG8hB1A1nYD6Q+NtuqaLtMwTMeowL8fX8WnWRJwKYqIoLbQR+4mV6PQW3O3487DXnJdStJDOlZrv4c+p2nTElHbRVTdr01mKYxeque39xinkxjFe1aOHg6Td1PDhkEXHRqRN+c/XlT6DONLqTV7kq897c7vRBD4cZDHktc26yC/HEkG+gGlSIIGmngH2h+AY0eWqye+bc8eBxNw2dFHqJzYZDGW5bNvabcLm7tttUy/M9d6hHhNbDrZfPK8I4764GKp8k/QuCyAr2l1PL8zJC4PsCI3z7900XBmylYhY+OXBmEARmFlGLZUWcel+D3l3bPTlEYWFlnBI9fFG+gf+NeaWsZeg44e7vAo7yaE
x-ms-exchange-antispam-messagedata: ZFZ3SS4ip2+WF1Q3SBOG1sLsxVQGdypxOPPXTK6sjTi4tD9YFoNmJ4hIxNNsgIn/n9LzXThHDRpbOFTzi9b/GkWoYqwmnR686GMrOhMHZm9eeB0VMT9RBPkHKfDa6ZBciKg9knPAbMOPIjfSq0+vXw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 033d0c78-a9cc-484a-a91e-08d7b4de9322
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 01:53:53.9007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xloStyw3MJ6IVVc9SddOgSeOwXaPjl+obzIjbHc/opHu7pvqy7ZCD/gb+VDPaMJ87WDOB0bi/+v8EjhONb+5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4760
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200218_175400_210348_068C4CEE 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>, Tim Walker <tim.t.walker@seagate.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/02/19 10:32, Ming Lei wrote:
> On Wed, Feb 19, 2020 at 02:41:14AM +0900, Keith Busch wrote:
>> On Tue, Feb 18, 2020 at 10:54:54AM -0500, Tim Walker wrote:
>>> With regards to our discussion on queue depths, it's common knowledge
>>> that an HDD choses commands from its internal command queue to
>>> optimize performance. The HDD looks at things like the current
>>> actuator position, current media rotational position, power
>>> constraints, command age, etc to choose the best next command to
>>> service. A large number of commands in the queue gives the HDD a
>>> better selection of commands from which to choose to maximize
>>> throughput/IOPS/etc but at the expense of the added latency due to
>>> commands sitting in the queue.
>>>
>>> NVMe doesn't allow us to pull commands randomly from the SQ, so the
>>> HDD should attempt to fill its internal queue from the various SQs,
>>> according to the SQ servicing policy, so it can have a large number of
>>> commands to choose from for its internal command processing
>>> optimization.
>>
>> You don't need multiple queues for that. While the device has to fifo
>> fetch commands from a host's submission queue, it may reorder their
>> executuion and completion however it wants, which you can do with a
>> single queue.
>>  
>>> It seems to me that the host would want to limit the total number of
>>> outstanding commands to an NVMe HDD
>>
>> The host shouldn't have to decide on limits. NVMe lets the device report
>> it's queue count and depth. It should the device's responsibility to
> 
> Will NVMe HDD support multiple NS? If yes, this queue depth isn't
> enough, given all NSs share this single host queue depth.
> 
>> report appropriate values that maximize iops within your latency limits,
>> and the host will react accordingly.
> 
> Suppose NVMe HDD just wants to support single NS and there is single queue,
> if the device just reports one host queue depth, block layer IO sort/merge
> can only be done when there is device saturation feedback provided.
> 
> So, looks either NS queue depth or per-NS device saturation feedback
> mechanism is needed, otherwise NVMe HDD may have to do internal IO
> sort/merge.

SAS and SATA HDDs today already do internal IO reordering and merging, a
lot. That is partly why even with "none" set as the scheduler, you can see
iops increasing with QD used.

But yes, I think you do have a point with the saturation feedback. This may
be necessary for better scheduling host-side.

> 
> 
> Thanks,
> Ming
> 
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
