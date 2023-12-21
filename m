Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8FBC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 09:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B8Ll0dnbDHHAFyxiuQaI9ur0a9apvsComXLx8ZntsKY=; b=mEJkTFvENimTKKiPkfU64FxiPP
	DMkQJfIwVJlThciAeX7PngsOtg/VgD6xYsdNa8vsUHVlV9HxXiRWuXY+BJIG5qLxFl6zqb1LBONWx
	LyH3xxJxZX8W4PSbTgJiLbPjFnqeMG5OuptAXpvYKSMotjf3LyhEFww8uSykB4AVNGvBKcPiyw2rx
	REVOyGFQA2pzKW1VY4wW/n1hSPDRBVs8bLC2/TXE0a/8+Fp/ETykKT6L/4fwtX8GCGAOprCJod9Cg
	jk5SVx5v1CDTHSdtnhv2JgkINdDoELcHHqKHtZCZeZ6aaGb3Q9hYVaGuXaO5RuJnupvszpiPmGJvX
	7GuMP7wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGFGS-002F3p-1e;
	Thu, 21 Dec 2023 09:22:48 +0000
Received: from us-smtp-delivery-120.mimecast.com ([170.10.129.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGFGP-002F27-0L
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 09:22:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parallelwireless.com;
	s=mimecast20180910; t=1703150562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B8Ll0dnbDHHAFyxiuQaI9ur0a9apvsComXLx8ZntsKY=;
	b=bHbbcsBAmxunCTRsKXhU1M6bIcGZiOu71oDIR2Y6/R+6jpeP4nfEs8iPoFVvPj9pcHrVMb
	6cDCSaEped1gdBh+ru0y/CxeBpRuFqLJQS9EwckS118V6fQbLs6dXTuLbSMMBX80PRA1j4
	+W86NOaJtdIH+pnBAZKL6Rio73BU3tw=
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-dEIWJAWgOVS97jTi_friaw-2; Thu, 21 Dec 2023 04:22:41 -0500
X-MC-Unique: dEIWJAWgOVS97jTi_friaw-2
Received: from SJ1PR19MB6257.namprd19.prod.outlook.com (2603:10b6:a03:45c::10)
 by CH2PR19MB3991.namprd19.prod.outlook.com (2603:10b6:610:a1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 09:22:36 +0000
Received: from SJ1PR19MB6257.namprd19.prod.outlook.com
 ([fe80::7319:5d0e:d827:ef39]) by SJ1PR19MB6257.namprd19.prod.outlook.com
 ([fe80::7319:5d0e:d827:ef39%5]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 09:22:36 +0000
From: Sridhar Balaraman <sbalaraman@parallelwireless.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH] configurable NVME IO queue count
Thread-Topic: [PATCH] configurable NVME IO queue count
Thread-Index: AdozbORtu98wW+LFQOGvoOwIqJcflwADa7OAABx0hTA=
Date: Thu, 21 Dec 2023 09:22:34 +0000
Message-ID: <SJ1PR19MB6257898FF77C8409DA173CDEB295A@SJ1PR19MB6257.namprd19.prod.outlook.com>
References: <SJ1PR19MB6257DF963B8EC038DBA9111CB296A@SJ1PR19MB6257.namprd19.prod.outlook.com>
 <ZYNAI7hJFGXA_9ep@kbusch-mbp>
In-Reply-To: <ZYNAI7hJFGXA_9ep@kbusch-mbp>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR19MB6257:EE_|CH2PR19MB3991:EE_
x-ms-office365-filtering-correlation-id: 5475fe84-c8d4-4505-d75c-08dc02065e01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: eJm8f8DJyJ9qIlQuwULs/5aduK4SyetRw1yOGhjBlncTaeMtaPDaC7t52DIJlPs+QeJJA2MxMAdAiwpMW2mz8e2nDfAI0Zc+kITU/Rb1YWrBerMpjUCwrzUSrvZte1hhayG6/0hLaDrJDKwiE4cEtiqJlomGBREnEkTdjRJXbf1CyYLEtkAAt07JXs+bMcACOgwjH3yTM0vFXBWyON9ziM3cJAPlzf8WjGEEuIT3FxklY145z14P3njbcvLFovtaBsJRN8mfY6HYM+ANl0deLaZ9wMp/9pB5lPgsFfYRIKJ7Vwzz6RHwrEVWrTfDsem5wBXsw4UrIhN9EkVGbF0kLFim35XyPYfVjYTzfM9CLMQ6rHgaKL7e863du+G6XkRpNvB3WZQT6HdWx8PC6jC5whG9Ru+6Qz4lUnsYRdQNMinE9cs5KNAy2Eddvdf4yMvgwZqOn+U9ya5FSlLqmTTqi1JHBxvhw2b9gxJ15SMcptP243L2keRb5eqvnZ7glWvpAU3EYQAoa4jyw+jb4NdKMd3QX5KrAD7Y33hYjPxY2ooavqF/gFyfRfatm6sD5HoV/Cu+Gy5X8dr1ufT3RoD4eNXdwz3vW9/z0RU36tOTexXmrxItqrX59llqGJTzR/Ro
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR19MB6257.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(39850400004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(64756008)(33656002)(66476007)(38070700009)(66446008)(52536014)(66946007)(76116006)(316002)(66556008)(6916009)(55016003)(4326008)(8676002)(478600001)(38100700002)(71200400001)(8936002)(9686003)(122000001)(41300700001)(2906002)(53546011)(7696005)(26005)(83380400001)(6506007)(86362001)(5660300002);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NlK18vEOmSZeOF2lGNWFNdbm8gUh5P2mCkMVmRYKGPsObW9h+yEl/1YioEqM?=
 =?us-ascii?Q?ZH1xlVVOkPjQez8KCd4xw+uMGAIMej60a+EfujQuqyjtiOjEiP9MH7MxSM2p?=
 =?us-ascii?Q?Bp2jsGktOkqT1dViVXq6H0BhLWT1alxLg34rVk8253ljVwqxUTlskuXkodYy?=
 =?us-ascii?Q?Y77zUHDZrw9h2AXHF3Iod6koFR1Tb+YFHJnc8wv1By2SfnIHozdf1k3aYLbP?=
 =?us-ascii?Q?A/jQHtk334eKoAqc0njbbO1T9HKH3lak6PcyFDIBz/PsOirZw8K1L6R8tV6L?=
 =?us-ascii?Q?JAEC/Wk3fb8LroLmb17G4V8j8fNFUf/svmS/4aXqF3SrmDIKUUSn+HA6fMMH?=
 =?us-ascii?Q?Arks9m4QoNEc5E78vGkLLOJQHYNCfuo1cCosJ3yDhqB33CjHA0gDGKj3+5vz?=
 =?us-ascii?Q?RiOlJbHhSUH/h4w6b9QhvmJOexhbXkxD7q016Uioq/4Xel2jsqm8N6Y2pdgC?=
 =?us-ascii?Q?Ews6IktjFh85om1yH/WbL75ZmY7nV6s7aKdZtum/4YEEU+EIr990kwn+qHZi?=
 =?us-ascii?Q?Mw/wVfASB/9gRKhP729aINUNKxQk3zzgBr2oxgKucQ+zM1K7cPLmaZmNpFxc?=
 =?us-ascii?Q?SwcATtqHga2bGbi/RLLjvtZLa4+QPeZL2D7I4u1d643VTfGGivB+QCsbgQ1f?=
 =?us-ascii?Q?MxEUr7i4bM8fH5vF8+YAYAdZv+TI0987ApbNmp5gKv0nEG58aUZysGYnAg8R?=
 =?us-ascii?Q?MNXhyz0hhC71P9p857QdMsDnubtnJoS5Xoa4DI5YmRxYNMqRHTgKnOdUGPwV?=
 =?us-ascii?Q?o+HAa0oA1F0DEfpAhRHtiGSO7uCp2QfbVPJV/wD3Db8xYKjAl+vZjlKK6TWT?=
 =?us-ascii?Q?WPNPpp8U4E6RrIRn1H4SfINn2hAiw5FWVJlruKT95OwzjQ27BM8V3ruRHg9N?=
 =?us-ascii?Q?B71nzl/cBf10o8mVKJIwh4w8g+68GKhGP0Leehu9Yov961u5vcsdi6vcXQJx?=
 =?us-ascii?Q?+uWX/9C5NHuxQu7cVg1sFXtzQK9qAFbkihd3u50ik37ikbx/HosSMyMEKfHW?=
 =?us-ascii?Q?CuhWISxBI2R8RzeutA02zkOhut3qmNdOzA1rjfw1OsTCCLmb5u/5DPqzkqUg?=
 =?us-ascii?Q?dJCvhHXEpLwyW/4ZIlybjANkTZZs9Jm+ylq6W8NFIkC/3mnnA2X3JqCjmFu2?=
 =?us-ascii?Q?c8SsIluExXswCadqh5Pc6mdgcV0i6X2c/C75Quuam8xKzdi3JYvOON6p8XZv?=
 =?us-ascii?Q?2s7jx9mp80BrPevTZDHzAtGZ1XpQ3zhqKJAHX0ArynOBWMrMiMrS+KGPA6Se?=
 =?us-ascii?Q?lGEJhx60fmvHMThXpj8VddHHzaCeaRf+gYe2sriEeuBf2hoA+9FscBDv+80J?=
 =?us-ascii?Q?PtbQZKujMpVCc/yyqJ6FhoHZ+kn+Y6Z67JMduHJFfnOTZPyxlspSAQnSRacn?=
 =?us-ascii?Q?+bc/TrgOXgHSF/9nYHDTyaQ4iQhnoXKf7vky4Ypkl1lpglovFiBXQzlYr8BM?=
 =?us-ascii?Q?3qswsPqN3+Ca7gaBIhu6S/50OPG10QLZvjIkRNclpNVRhwJ6wConN1Qkrqrm?=
 =?us-ascii?Q?MF+UuFjqAGfzQ8yupg1CXw/JBBdOgxKgDzpiumi+RWAa1eBZTf0AIgH91Obu?=
 =?us-ascii?Q?ZE8dNSUc+SrAk6Lr9fiNRIr9XTcIKZ6P+BYMMC1gdSANOCGffDnhLR/VU2RO?=
 =?us-ascii?Q?IQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: parallelwireless.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR19MB6257.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5475fe84-c8d4-4505-d75c-08dc02065e01
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 09:22:34.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 991bd471-bf03-47c4-af97-0c3362264c70
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kZTjczb4UwbbRbAq0zK6I6ytazPivAo5AudohIceB75S/9m/YEMWqLI3zSq53kpi2JBpDBI4LujHWbg92qONeTRrrkBR8RQEGXDtRFwZwhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3991
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: parallelwireless.com
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_012245_233587_CF428B98 
X-CRM114-Status: GOOD (  15.67  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,

Thanks for your time and comment.

At present, we have below parameters at PCI level which are related to queu=
e configuration.=20
  io_queue_depth:set io queue depth, should >=3D 2
  write_queues:Number of queues to use for writes. If not set, reads and wr=
ites will share a queue set.
  poll_queues:Number of queues to use for polled IO.

So added below parameter to control number of IO queue as well.
  total_io_queues:Restrict total number of queues to use for IO.

If system configuration is defined with fixed NVME device and Controller, b=
ut there is no configuration to control number of IO queue.=20
So we can restrict number of IO queue from driver if configured like write =
queue or poll queue.=20

Thanks
Sridhar
-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Thursday, December 21, 2023 12:58 AM
To: Sridhar Balaraman <sbalaraman@parallelwireless.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] configurable NVME IO queue count

On Wed, Dec 20, 2023 at 05:53:16PM +0000, Sridhar Balaraman wrote:
> Some NVME products are providing more number of IO queues, so driver=20
> is allocating queue based on number of CPU or maximum number of queues=20
> by device, whichever is least.
> At the same time, corresponding queues would be mapped to IRQs.
> But in case of RT Linux, where we need isolated CPU and free from IRQ.
> Unfortunately NVME IRQ couldn't be reduced due to more number of CPUs.
> After making IO queues as configurable parameters, we can reduce=20
> number of IO queues which inturn reduces number of IRQs.
>=20
> Before configuring queue count:
> [    4.384566] nvme nvme0: pci function 0000:05:00.0
> [    4.450307] nvme nvme0: 32/0/0 default/read/poll queues
> [    4.457427]  nvme0n1: p1 p2
>=20
> After configuring queue count to 2:
> [    5.920776] nvme nvme0: pci function 0000:05:00.0
> [    5.939455] nvme nvme0: 2/0/0 default/read/poll queues
> [    5.941487]  nvme0n1: p1 p2

This sounds okay to me. It aligns with existing io queue parameters and it'=
s not unreasonable to limit driver resources. I think this should be enforc=
ed in nvme_set_queue_count() with a nvme_core module parameter instead of a=
 PCIe specific one, though.

The effective nvme irq affinity will spread out to the unused CPUs with eac=
h additional nvme device. And maybe that's okay, but just wanted to mention=
 that this patch can't guarantee nvme irq handlers won't be affined to ever=
y CPU if you have a sufficient number of nvme pcie controllers in the syste=
m.


