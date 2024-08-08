Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED315C52D71
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Aug 2024 19:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w8MhxFx3RUo6PO/PIw8c+GH/Q+tl2KWVHSJsBUeLxzM=; b=2m8VRcfXcsDi9FMx7ZPgSZI1K8
	F7ABW+hqup0knCJs4m7spOyppZ5X1C9jHBgTI8w70lhVJ9AUoTc0GeLb9idTwzGAx3A/0QMOOB37J
	lWOqvgSruvTmFfPjnuszU6PF2SCB3ISXW1ZjjPasdTaAJ+TqfVkYKHWT2f2eHDhk0qPDMk1dThQyU
	0uDdn00s8YpRSgSqt4IySiKx7m+miQCz3dFDpAESGrLNrL9i4vgxwA4FfyC6wK9XhAj/j/aRWu8X2
	+1PJh8vIX4o9Qkb+xw4SPQosl3NpumBGilYaqyAjJrv6dc52JtbuIkRAqFnAqHT4UaLGbd1ek036J
	iDuqDbmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc8oQ-00000009KoR-2xwT;
	Thu, 08 Aug 2024 19:28:38 +0000
Received: from mail-southcentralusazlp170120000.outbound.protection.outlook.com ([2a01:111:f403:c10d::] helo=SN4PR2101CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sc8oN-00000009Kn3-1jZg
	for linux-nvme@lists.infradead.org;
	Thu, 08 Aug 2024 19:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBSdK8ah6ZPvI/VaBGteIGcQn7BMztKzr3Q02WIlEouS0gO9+vSekl5j2NhhmSyGd5qpRfTPYSOShUUiBTcdrP3cbNsvLM7zezR85Mo6cTLYmhXHbqwZsgObx3F4JCuz0qPvjLfz91sKJymzWD/1rtxlH3+oyikmoXWxAZtf0SIdechInfh1AJWK+lMq4MFxrBwe3iZ/eFfl8Tkp3OMt0aac6hrm38jO7vXoxyj+chuCD2WMuFN3p8JyFMOJpDqTElHZeNxppu5epqk0/WoFxoioliDvfaplPQGeIPAUWJcf8MALiZuJqZbHrLZEfFIM/jQVByYFOKq2UhFpTSL0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8MhxFx3RUo6PO/PIw8c+GH/Q+tl2KWVHSJsBUeLxzM=;
 b=FXvnBLBoz8tBvzaCbu7pTkjCIpJvWOe1cN9T//jpWlWQLF99ryskdbmRtT9rql7GlHnq3T6IL1kQtif17047Y0Cnd7Zm8XTrcWYhIdGnfqhp4yalnB/9NqynNfsydILlw7qDjTuapnUiU7rZdVb95IO8GJrTsS8VkJZ6KolSaaqvq8IBc7eDrSzSHCBLhNovSePxrlcqrTFUaClwODTt2raK6HOR+4TqJ3448Iw7Ej+pRPTvwMxp6VXGyn/ZUvsyQ26BpdvCyad6is+Fi2D2KPar2gZ2XmFaZeNXPNH9f8jgVpyg8dac+EAWJc7uaCtQZHmYSHWHcSkH7j5qJ9uxlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8MhxFx3RUo6PO/PIw8c+GH/Q+tl2KWVHSJsBUeLxzM=;
 b=Puo4KY4eXEgyyB+Q+eBCroxNkPWdenqjZwmGlvLc5+frX90J0Ef6pDxNO0eaZgJCQ7I9SQqVde+8114TPqqRTuM7omZu+uur1paqa9mReF2awZ3XCAbjUQoVJ8AoMqe1AvHlIxfFx9g8fGH4BNOPwLdw7ZcYoyvri09a1G08iqc=
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by IA3PR03MB7548.namprd03.prod.outlook.com (2603:10b6:208:515::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 19:28:11 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%5]) with mapi id 15.20.7828.029; Thu, 8 Aug 2024
 19:28:11 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: Eric Robinson <eric.robinson@psmnv.com>, Keith Busch <kbusch@kernel.org>
CC: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: Disk Says It is Full But There's Nothing on It
Thread-Topic: Disk Says It is Full But There's Nothing on It
Thread-Index: Adrnh75MzNJkXFWcSMupUSjuDERcWgAbfTgAAAMQYXAADoXcAAAAtK2wAAxXa4AAAjAxEABT4p5Q
Date: Thu, 8 Aug 2024 19:28:11 +0000
Message-ID: <SJ0PR03MB6501FFBE1ECEFC2E3047FB52FAB92@SJ0PR03MB6501.namprd03.prod.outlook.com>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
 <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <vqbcmbet5jfbhmjfuhr66om2ta5lw2octpynjdzyvk66ok47kd@oj7vhatyai3g>
 <SJ0PR03MB650188563CEBA3B2E6D2130BFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <ZrLZs2ZpxcM1XcV_@kbusch-mbp>
 <SJ0PR03MB65018D5649C7BEBDE4B8B75CFAB82@SJ0PR03MB6501.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB65018D5649C7BEBDE4B8B75CFAB82@SJ0PR03MB6501.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|IA3PR03MB7548:EE_
x-ms-office365-filtering-correlation-id: 5e464ac5-a940-42fb-cefd-08dcb7e03d80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lFE6v0gm+f2NIN2JIgfsbdhg4WrOj8liJ2tHVBoiFF9gKoV03xY9f6wbnQ+h?=
 =?us-ascii?Q?QANzYahstCvmMXfE+f9plUku6qhcYe3cxYQ1wL0I/osHsDXbow1orexfpwPN?=
 =?us-ascii?Q?d9qCt9cYUHPsOEpqZ6XeMrubVFASU7uKbOEdri/7GWS/PGQTkp7Araf0+0Ov?=
 =?us-ascii?Q?Na20SBrlUCWGJxTYe3xuShXbdrMvlm3hAVWaeAfJT7+DCx+DR5ZlfXKmwvqI?=
 =?us-ascii?Q?sQXvI53xV7DfhADtdcOTNiS844Ke4jYhqZUqx04mN8CvDajdXiEC5uJvdyyU?=
 =?us-ascii?Q?uWOo48Z/7nhSzV3hmx5mSUbJHws4W0mmjJ11QYULkeLTcKRPFhM0NSWNyDwX?=
 =?us-ascii?Q?nKrpH0PdaCH8tJsPgmO/R5f9uSSfHLBEiSJGKARwNAjat/xnkeWt/0bI4xIL?=
 =?us-ascii?Q?7adaOFKJ7x29cX/SuX3df0HuKC9hW237wYTjDB7IQf5uDZAfv0HY5oyr3WFj?=
 =?us-ascii?Q?HZ3F42K2Q4Fwnp5ipZqA6vFp0CTa59J9QRl3+AJFnpPbPWVuhuB0oetXTpQC?=
 =?us-ascii?Q?8ghZwOx6qZWqvVHew6EljEucX1Jjm68ptsT5xWWovGLo3KlO29a1s75QJe8A?=
 =?us-ascii?Q?jCJA+Cv3w58hOx4zjjybGs6gaQe941+0S2itFDzbhX1LoR/U56jESzgY4UAy?=
 =?us-ascii?Q?X5rmuYGzJUJiD4LiH8A/2E5lbjNgJSJNcButPQX/2izaOPKYccQgA6pM8DAb?=
 =?us-ascii?Q?l6//EoPv0pUDPn6LLTto/pf9s+JmDLt1tzqFu07MWGvKSPZPamZ3kQjxyAdF?=
 =?us-ascii?Q?LxGjdgI8G91/Lsirh8ZZpYHZF0Up2CxJK61IxAZS7Pn6Q8BCCfLGcJ7fPX0E?=
 =?us-ascii?Q?JRVURnN0ZXPef4lTmjjF8EwSSl1VyTU/PHwSjfT1N4OVPMQKTo53U48D3uYm?=
 =?us-ascii?Q?Fzt3Nvx3YucUjG8T5H6oMCx2tbIf1iGZK3Na3VjcOJH+osL155Gqw/kkDKp9?=
 =?us-ascii?Q?x7ZqZ04+/zUu04BpXQOWFDLT0n9tfsw1j4jIjyvOSil4xmSU7fAElDmWa/jd?=
 =?us-ascii?Q?SVsmMqeJNaNc1eQK5or+uF/pbT/ZEuwzkuXlxvqQkb+NAnx0I8k4o6hPZSEx?=
 =?us-ascii?Q?FtDVK7oYpIKV+QLktmKk8bKWMSiFoUtW6jG7cJveTCqx2cWRdcv3sTbrFBTd?=
 =?us-ascii?Q?nOPcyiXyX4bFsjLU4CPzDcaPWGldBUe8D6Nob2GEOjjsPhsjnoXTPS3A8Cj/?=
 =?us-ascii?Q?KukbpO1PypdU+N0gEmK+XTEZEREuUEoxiE3RiZVRSjyyrzP06phqgjUB8Wdo?=
 =?us-ascii?Q?LrnzBxrroM91aAyigvO8Moo8SAUH2GqGfpA9ifMm+ua+NM9bLmMPUnrmzhet?=
 =?us-ascii?Q?5SFUdd5zecR9XzzRthVfR8PCv9kkqxRsI4erRIasGdjssDVWi6T1TefZ8PJt?=
 =?us-ascii?Q?FVWh9xorq+Ej8lG1w9axC0BUSahCOke0LWO47SywPfscBdLcrA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8QCJefqlww5oCk3d0fz+kLcm+JgaF8nZ5+aB1Jpvn+9QWfIJyTwmSMBNPC5y?=
 =?us-ascii?Q?e05LZnWz51bapD03PWwdUBmLb53aZ08k/Dqj9K6J5rPHme1xvqg5oQc/b5yP?=
 =?us-ascii?Q?i2j6Dg1jEjw9qQ+l8MunAWUJqeLwnreFLFeLHF1mtDaqnjPHFvayX3G0u9vc?=
 =?us-ascii?Q?op6lO8xqf2BTtRJ10v2jE7eibpPNnANqjd2Orb0PX9RphkPEigKM/T7aGOZi?=
 =?us-ascii?Q?eDCEv39vUXpn1segwrjohUm+xhMl9KWrmdj/W5xm6cKpI55L5m3TrgVwxq5H?=
 =?us-ascii?Q?l7uSJcAexeJtLhqFRQk8+i9ptco78V1OAK+LHg84bDNadIf8ux8E2RA6agb3?=
 =?us-ascii?Q?U9KAKaOsOF3j627KWD2oS6mzVI4TxppAbi/KYT73zJ+lrzcQ6EQOxdoykAhS?=
 =?us-ascii?Q?/MywT9Czerd3TLi4Xm7VRt6NxGJH0f8FIcnhcNGKocOTosQxsaseUJv+mcw5?=
 =?us-ascii?Q?GHS8GcKljZUopuVlnijlcs3cu/74WddrClbvOfd+MJAvbaGAOU4FDlAqfnwp?=
 =?us-ascii?Q?VuFv+jfrtC0JivCJWOpNRXi8QOK1bNvnGApAXDETGdQAE6na+mWDlOAWXrOg?=
 =?us-ascii?Q?WGYxNQA1c0P2xwuUZ41sWmjZYq6YaYK2I+glsJekRZ+sTbBN7sljz8d8c8qd?=
 =?us-ascii?Q?hRsYrTimLuQTFB6+0h+hLmXcR3uZHSM/iCNdhTmFAKrUn/5WveLysLwJVL2i?=
 =?us-ascii?Q?Xlo6pcJ1tyyws21BggdfHptCnW2203A9Cpe5SPtBGID69nACnI0WHWdqcUHF?=
 =?us-ascii?Q?YOmYF8HkTFv9rLByBLAa6seQmhNyuu3HIK820siqKgkWnk1W2ql/rIca2GNw?=
 =?us-ascii?Q?NEEHULbirKjy4T17wpiePSDnUFwe3uFMwecvhkoBttI0Vbg+1f3PmJ0w8Zb9?=
 =?us-ascii?Q?oSaf3nr5gt4UybmjaknyWBaOG1ddP7iyFAllPloqYchLKLvn6UUaYnsPxZCW?=
 =?us-ascii?Q?DBZDjj0EWPXSScEn3rpQeKhOb6fx4qWpX4A4LJkJ1uf0tVDkYrpbuBdC/ocH?=
 =?us-ascii?Q?q85cbSstwg6eLis9q/PbtHWBR2okliVSE91OZX6bSGmIZN9PO/qLHA4Z+UeL?=
 =?us-ascii?Q?WYN0p6B7tZnawjaZJ0kdOtWG9eMwr+gJ6oVHPc9v8iuwvoZGx1i0WTSHMNeG?=
 =?us-ascii?Q?dsYlNGroIX8hwcEeKdXoCvz1XGgjLlGNZzW2PsuvuuAKmzRkH8Zuf4chjJzJ?=
 =?us-ascii?Q?XsmjuHfkqoHAOqgkXXrEL77sZO79R63r4Fn77ScZGVboGFzLbLt+FoQAwAlE?=
 =?us-ascii?Q?NCt+PYd2wXg5fB1snwgmyNh41xEfqWGff7nKk0j1jG59NT2f2I7XJxYVHJq5?=
 =?us-ascii?Q?mdXZm3ZpD7FRm5BzP3weDgPZbMdejc6kKg89hGDAy04MpNB0BA+DYFQv75PE?=
 =?us-ascii?Q?Vs4P9aWsrQbaqeyBIlLCDEaj2AA4vwSHZD2FJB/c1sBGVpKeZd41RbBNque+?=
 =?us-ascii?Q?BbA9D1TrjktHSDxPwyO11cF4Bp9prgaNhLCuHVKAGzO1jWFOtmeTBRcL/cNl?=
 =?us-ascii?Q?kDMn7yxIzEsjpVdI/OLDRf6FiCw/dS0Rlx7iHbx9fxRCUwQp8JXxNV0d/yzj?=
 =?us-ascii?Q?ELgUzKzr3x4q4doxZbZP5P6XSmMcBkio5/IexT5j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e464ac5-a940-42fb-cefd-08dcb7e03d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 19:28:11.1584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcO5Iz+qpF9LofiLTRdfGGhGg2/CZr0s7MotcDT9n8H9YL+ubmfiND5cbmCeoeDGGkJ+rvYRgcQpj2nZf0YUiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7548
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240808_122835_542415_E83662D1 
X-CRM114-Status: GOOD (  30.28  )
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

> -----Original Message-----
> From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Er=
ic
> Robinson
> Sent: Tuesday, August 6, 2024 10:28 PM
> To: Keith Busch <kbusch@kernel.org>
> Cc: Daniel Wagner <dwagner@suse.de>; linux-nvme@lists.infradead.org
> Subject: RE: Disk Says It is Full But There's Nothing on It
>
> > -----Original Message-----
> > From: Keith Busch <kbusch@kernel.org>
> > Sent: Tuesday, August 6, 2024 9:20 PM
> > To: Eric Robinson <eric.robinson@psmnv.com>
> > Cc: Daniel Wagner <dwagner@suse.de>; linux-nvme@lists.infradead.org
> > Subject: Re: Disk Says It is Full But There's Nothing on It
> >
> > On Tue, Aug 06, 2024 at 08:28:05PM +0000, Eric Robinson wrote:
> > > > someting bogus (nsze, ncap, nuse).
> > >
> > > [root@store11b zpool0]# nvme id-ns /dev/nvme0n1 NVME Identify
> > > Namespace 1:
> > > nsze    : 0x6fc400000
> > > ncap    : 0x6fc400000
> > > nuse    : 0x6fc400000
> > > nsfeat  : 0
> >
> > Is this after a fresh format? If you've no data on here that you wish
> > to save, run something like
> >
> >   # blkdiscard /dev/nvme0n1
> >
>
> That did the trick. First, I issued the blkdiscard command against /dev/n=
vme0n1.
> I then ran nvme list several times in a row, and each time I could see th=
e Used
> column decreasing. Clearly the drive was doing cleanup. I then ran blkdis=
card
> for all the other drives in sequence. Each time it took 24 seconds to ret=
urn to a
> prompt. At the end, I ran nvme list again, with the following results. It=
 is obvious
> that each of the drives is going through a discard process.
>
> [root@store11c ~]# nvme list
> Node                  Generic               SN                   Model
> Namespace  Usage                      Format           FW Rev
> --------------------- --------------------- -------------------- --------=
-------------------------------
> - ---------- -------------------------- ---------------- --------
> /dev/nvme0n1          /dev/ng0n1            6240A0Y0TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1          1.18  TB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme1n1          /dev/ng1n1            6240A0T2TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1          4.37  TB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme2n1          /dev/ng2n1            6230A0N9TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1          5.92  TB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme3n1          /dev/ng3n1            62D0A0FFTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1          7.74  TB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme4n1          /dev/ng4n1            62D0A0FPTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1          9.24  TB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme5n1          /dev/ng5n1            6240A0XNTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         11.04  TB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme6n1          /dev/ng6n1            6240A1BJTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.63  TB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme7n1          /dev/ng7n1            6240A0Q4TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         14.04  TB /  15.36  TB    512   B =
+  0 B   2.2.1
>
> And then finally, after a few minutes...
>
> [root@store11c ~]# nvme list
> Node                  Generic               SN                   Model
> Namespace  Usage                      Format           FW Rev
> --------------------- --------------------- -------------------- --------=
-------------------------------
> - ---------- -------------------------- ---------------- --------
> /dev/nvme0n1          /dev/ng0n1            6240A0Y0TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme1n1          /dev/ng1n1            6240A0T2TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme2n1          /dev/ng2n1            6230A0N9TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme3n1          /dev/ng3n1            62D0A0FFTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme4n1          /dev/ng4n1            62D0A0FPTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme5n1          /dev/ng5n1            6240A0XNTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme6n1          /dev/ng6n1            6240A1BJTCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
> /dev/nvme7n1          /dev/ng7n1            6240A0Q4TCG8         Dell Ent=
 NVMe
> CM6 RI 15.36TB             0x1         12.82  MB /  15.36  TB    512   B =
+  0 B   2.2.1
>
> ...success.
>
> > or
> >
> >   # nvme format /dev/nvme0n1 -f
> >
> > and see if it changes. If it still doesn't change, then you need to
> > check with your vendor on the discrepency because nvme-cli is just the
> > messenger and faithfully shows what the device reports.
> >
> > In my experience, about half of nvme devices always report nuse =3D=3D =
nsze.
> > LBA allocation tracking is an optional feature that many devices don't
> > do, but since you apparently have the exact same model and firmware
> > that shows it implementing this option, that's just weird.

I thought we resolved it, but one of the three servers refuses to change. I=
t continues to show the drive capacity fully used. I noticed that the drive=
s have newer firmware than the other servers. The NVME drives in the one th=
at won't cooperate have FW 2.3.0, whereas the ones that worked have FW 2.2.=
1, if that matters.

-Eric




Disclaimer : This email and any files transmitted with it are confidential =
and intended solely for intended recipients. If you are not the named addre=
ssee you should not disseminate, distribute, copy or alter this email. Any =
views or opinions presented in this email are solely those of the author an=
d might not represent those of Physician Select Management. Warning: Althou=
gh Physician Select Management has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibili=
ty for any loss or damage arising from the use of this email or attachments=
.

