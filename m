Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36706C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FlEKtjhJR8XvCSKVfXC0Qna2OE4vsUeqQ1RxnFCBbj0=; b=3jLPj3lwY1ATZKb0Ei4ljUAts8
	aonf3PJQIZNd2643kP9yhlKWzKHh/inQG1ucrUfQjivFpK/IJkAOhPsfFaLb+mEXZRWKvDYz4rVb1
	CVU4WcDprHyvSFwp8XqxUvfJPJAlek8d9+hjqN7yqbuQC5gCVyxTqp2OUNv/cnQ4A4IJVkYJ69a6t
	5JKxMu6SGhD68MNJP7EiZsR5N+kaVaVnCfmz8ZnpGh9Q3Qqc0h1/5/RWlhQVqP2q/g4afds9b/NP2
	en9LpsbXPn0HwI4MtPy9UAHKLyfs8IYTkLEEpAmpdw+M2Nefv8ijnSGwN3r26vCb7F210V0m7RGEy
	leQ2+bGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1naKCa-006YeB-EQ; Fri, 01 Apr 2022 16:32:44 +0000
Received: from mail-dm6nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::608]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1naKCX-006YbY-7n
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 16:32:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9WwH9mKh994BvKY6Fqc/ih1DegBrSbNjyYpUxtP6CIoJna31Iz9qrPGGBZuSp3etD9GF9eISjUtJ3luEvIM0d6BAp3Yc9wvsMGZr8wM7agP6gydcGAJrj1Xwsz2WT3ICd/jywEsZuyyO1dneofveH4IbVBvtQecYZNefQtBHuddzRvKYJ77RT2h0f/HdOJ2y/cDqkD3Lf/PAdY/uPAxfCygdgjONA/cq/yHbQsM3FENw5MfUE3GUL/nVjwipaBrBywyQurUJKTQO+howgodPZNSPknY4JzlsMbRnpuhhsbRnso1K/a/8GdREdMBzJq0ZJ6iZhiD2w9qECbbmI82Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlEKtjhJR8XvCSKVfXC0Qna2OE4vsUeqQ1RxnFCBbj0=;
 b=H9nOoIOLaBGsxeLpklfljasVSpaUAJjfBZ2jRr4TR7I3IuQYPcX2aiUIQVRMTdeq9uTTakXYcWoM/eJEqpNrluSML8lgLKPU3Lej/uh6lusDbJayJV8vj1dGYKGqixvLQ6U31+7aW0ZJ8b77PEHVVg+hpXXNc2KT7povP6tlwuh7r5ByhfdHCrhXRM+PSyNA6GMZDKNe5CJnAyeSUWiO5G0aBNwhladTqw7zRl43CXWMTYy66SXcnHXfxAB9E28HlIbUKo4YcaYM0SBUFeNsfebwlStNK7tb+M8LFMFPZ8QL3IF74DxsNzcaeUJbzlHNv/DzTzwqnxVPELHMJQ4Byw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlEKtjhJR8XvCSKVfXC0Qna2OE4vsUeqQ1RxnFCBbj0=;
 b=qmmpLeod4eM/rvudLX2zQsnmewBfTaN/oaliQDT6gp9R3QhxSaQZcwNjtv3chKi77EINoiDrzjMWC63mr8RC/+yqwyAVk+ZYs360N/bwWXa1FKVIIw2raXNnbWH6kWL0h9v+WZHp2Hsc0BoYgh04gC0DQ22E157oJjreWCG5fl8=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BL1PR12MB5288.namprd12.prod.outlook.com (2603:10b6:208:314::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.28; Fri, 1 Apr
 2022 16:32:20 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::70d6:f6dd:3e14:3c2d%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 16:32:20 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Christoph Hellwig <hch@lst.de>, Thorsten Leemhuis
 <regressions@leemhuis.info>
CC: Jian-Hong Pan <jhp@endlessos.org>, "regressions@lists.linux.dev"
 <regressions@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: RE: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND makes
 system resume failed after suspend (Regression)
Thread-Topic: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND makes
 system resume failed after suspend (Regression)
Thread-Index: AQHYRZ3V68XuTiqqgUaaieIAsf4QmKza64WAgABVGpA=
Date: Fri, 1 Apr 2022 16:32:20 +0000
Message-ID: <BL1PR12MB51571269CB0F40E4257D2232E2E09@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <edba451c-1798-c60e-5d84-0a9f6a5d134d@leemhuis.info>
 <20220401112649.GA14810@lst.de>
In-Reply-To: <20220401112649.GA14810@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-04-01T16:32:16Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1bd51392-ff91-4db7-a099-36d4837e7b7e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-04-01T16:32:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9e5eb39a-b390-4a1f-ab97-0a845335e8a1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5048efee-b1ec-40aa-2709-08da13fd31b2
x-ms-traffictypediagnostic: BL1PR12MB5288:EE_
x-microsoft-antispam-prvs: <BL1PR12MB5288B967976EEDF60F522033E2E09@BL1PR12MB5288.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6OS3/4PChJXfcyYj0wO/lRAi7HsyVjgorfXmsy/SZFYT2TK1ZIfBkJuMGeaOmpGdHbaNfXxriqftZrABG7G9cFHG3cOQzY8MWeiYwvhJoxi8tcFaSopP33Rn6c9jBmyNA7ofYHeNW1NTcYXjTyQUa7SPJhGeUBL8zFlwwBj4onZ2+rj0wMP9gF3HpkGaI41yj3178pRHEQZhsN1rXPScbGNYK8rJeARLxWssrdZGE7r1SWsNKPKptF4W+kyPEmH20mlme86klTh6mbizIKGG3cUcm4qUybw2NEbfMZ43q+6VOlHE+Q72bZMAg9zO/YEU9S0x3wld1ov2uSm0El39qwdM1V9RlRWuW2i8vLhNdeGbxyuYfAOhhnCaQLv72uW2BcNM4sWgg5ho8KhIr27a9/fwZz9/Yfiudj1Yn4zx6/cXCLEhmojuuLrVEN8+gdhOm+67l+sV/gJk3H8eizYW391IJ9XYaf6zWL5X9NJ2F1K1sdHZKYMTL7BjXUKkr3FVbkZsv4OcXaT8eW9KtDi2fzfI5TsN7nHdSeyb7OycsUxV8G23Za2jKGwyjKk9CWucLlOQYGlVF20CYmaPRywF2MUjO2CJj5XEsze3OuDGeDhrVVu2ZkDybAUgh5j/YQ5jSLvqYZfNevWgMsCWPbOuK5dDdcyY+B5kcF8lq5w8jzbvLMrlMKu3HoueVmMz8qfvFkiUEa0tgds53fU3wI1RYg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(9686003)(7696005)(53546011)(122000001)(186003)(4326008)(8936002)(5660300002)(33656002)(15650500001)(2906002)(52536014)(8676002)(83380400001)(55016003)(71200400001)(64756008)(66476007)(66556008)(66446008)(66946007)(508600001)(38100700002)(38070700005)(86362001)(316002)(110136005)(76116006)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wh0733oUcF5aeAvV5X8OjLiJrRgkWGbBI0WZvpfeM39ozEIW4rWwfMcoFOs5?=
 =?us-ascii?Q?irNdt9t8dL1RdHqacqihoXNlbSh2cQuhoNHyS2mqffyW9/NbapoVYl6JquIC?=
 =?us-ascii?Q?LhiTKJf1va9rOHmGPLVnRqS0OzfSVZQiW7bV4oIj6Me6CezKEeJXtKG99l0t?=
 =?us-ascii?Q?jDzgEM8F2I81FTyo3/TFBaU7VJRxu+NWMuJvpLpR3V6u5WC8PhzZbtenSX6w?=
 =?us-ascii?Q?uIASkcFTlN7exvB5Gv17mFFTWlBODpkFL3/6lWUgP3TkV8dpA3/raWQzWPf2?=
 =?us-ascii?Q?w8w6cKGGDVGEr/wmw6vEUWART/2KsZKy/DG2ftHd/0RXVBtOpPnxhDZ9I+aj?=
 =?us-ascii?Q?szNIfx2iBo7FVq+2yljXQ++0GF5b+sdG6pJ1UbQq+x3ldZWy2uJ7HU9aBOri?=
 =?us-ascii?Q?TAwV4pIO1kLSOv5OioYrSI8KTfP5a6W25W8/SM5ii622OMgCrES+Y0hnDlZV?=
 =?us-ascii?Q?dNSEKJOp3V72FEc1FjpYZCBqKFALLNUjRKwAO+h9wE7bClcymITlZcYwiGVS?=
 =?us-ascii?Q?XL3meg7+TrMmOtqEeUDqzoOuqE+zKdq3/4+Dg7Ni7lq/z/X7tLx1CcSvBsg2?=
 =?us-ascii?Q?24vaflLVLWFDf3II7WHPeEuQmGGim4rbz1vWOo8nvo9pa4Iv3cDiHoJEt9TH?=
 =?us-ascii?Q?6dcwYBHLiKJZPU12TaDtXFgtT+xSddxy+Uh3l+/YohqEwFBEHrhvAjy+FExT?=
 =?us-ascii?Q?vqA0ROJqG4nC1ga289aZZB/xo0ziyUDNOBYOmDJXEMT1KVGrPWCtPy8dl95L?=
 =?us-ascii?Q?J69KtxJC8Cg+7Yul3u0ZaSKDyZkpVlPYzLwP6HKM56JTQ05KYpvzzEvnpkJz?=
 =?us-ascii?Q?ZVsRsOMj8xnJmiZzjaIXQsF9AJpNeG19bFPdbsyG4yOYejMBKjfKl+b70wPy?=
 =?us-ascii?Q?yqtQRWHhzBe3s1rciuB8X9G4Ckc7qkgre8iqBL/YTSZFG+Kb5T/60LtiI0GD?=
 =?us-ascii?Q?a/FhPgwno/eCdJRTu5JVLHbUzswXIYJkKtGMBbL4zDZsORGXQlOeVAYQBeTk?=
 =?us-ascii?Q?5L+2SvCrL84ENuoclXR6JB/BEDkIrBwMQMlK/IdJRpjLbcIiKz2qazvWVh8m?=
 =?us-ascii?Q?RvHrmVfniL/hdZERAGje4jJz3BRLR2HcGRsFShoKrypqEEp/DEYCaTG0gHMt?=
 =?us-ascii?Q?HtW4OSn+HjCaVhJOCsyxgnYYwGECCpkJEHx/3aXXe8H58TBketUNApmp8NA4?=
 =?us-ascii?Q?GyEFYHUX5zfEXz+k5aaz3u7VipKsBJy92EwDf4BEogUJjiJzZ2Mywekgf/oS?=
 =?us-ascii?Q?JgHcww5h8x/MofX466aHvDFWnx3w4iQatvK3LIpE2F+WJDBKs6vik5ZKXUOi?=
 =?us-ascii?Q?rRrgWtgVh5RjAVkWfIbZ3QbFsNz20HfPnwD9FV/Ik+SNcXiVVVELK7nBCWZ8?=
 =?us-ascii?Q?9X5uGy6MKLvDwi3wvQsGBL9ZlWlSeN3uEbMFP6zv9S1BsPZEwnbMsJALk8QO?=
 =?us-ascii?Q?CRwriNgGIt1TpXShyTpuoAYA7ljG4hznr7w7nSK/frHi/4P96VTuHCxh/MQ/?=
 =?us-ascii?Q?fYnPa1f7QUe4lRNd+ilrctdWzRP4xjfc4xcpq/w+bNW98occyxoj3ntu7/Tp?=
 =?us-ascii?Q?trZF9+Xrn2BUMYzUKtOSiViZ2vonb0nZUEv8jmJDyUz82qDJUe7JACvwJwmF?=
 =?us-ascii?Q?a4574EW+P+6L9IoMAGCbPyMjvepGkMYv7f9ml71F3AGetNxPt9FB+3XV4SpQ?=
 =?us-ascii?Q?GELrN3TJ7oHFV7BktyIEjOHZTwR+ftGTiQC92vDFvNKlb2Jpn340wTRdo97d?=
 =?us-ascii?Q?3DrFsoxTNVML8goDFMxJLB+1jJpwjfxtmP2oHO+8qN4AKxHlva9A1Pg1hTTO?=
x-ms-exchange-antispam-messagedata-1: tn8IpOtzCvvdYg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5048efee-b1ec-40aa-2709-08da13fd31b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 16:32:20.7446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: potIVK2bjqM+A5+c0VdhaRO6iuRMoDGzXrq1IqsXK7u40Y29pp5yYpre0orwYZMc221BdLxCrkpGHedMkaI8vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5288
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220401_093241_325643_B4ABD9E9 
X-CRM114-Status: GOOD (  20.37  )
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

[Public]

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, April 1, 2022 06:27
> To: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Jian-Hong Pan
> <jhp@endlessos.org>; regressions@lists.linux.dev; Christoph Hellwig
> <hch@lst.de>; linux-kernel@vger.kernel.org; linux-
> nvme@lists.infradead.org; Rafael J . Wysocki <rjw@rjwysocki.net>; ACPI
> Devel Maling List <linux-acpi@vger.kernel.org>
> Subject: Re: Bug 215742 - The NVME storage quirked as SIMPLE SUSPEND
> makes system resume failed after suspend (Regression)
>=20
> On Fri, Apr 01, 2022 at 09:55:14AM +0200, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker.
> >
> > I noticed a regression report in bugzilla.kernel.org that afaics nobody
> > acted upon since it was reported about a week ago, that's why I decided
> > to forward it to the lists and all people that seemed to be relevant
> > here. Mario, could you maybe take a look at this? Or is that something
> > for the NVM or ACPI people? Or was this discussed somewhere else
> > already? Or even fixed?
>=20
> I've not seenthe report.  Looks like the BIOS sets the StorageD3 flag
> in the ACPI tables in this system but doesn't actually want it,
> which is really strange.  We could add some kind of quirk based on
> DMI matching, but this all seems weird.

I've added some comments into the report.  I would be suspect that this jus=
t
uncovered a wider problem and we need to dig into more of all of the
circumstances to confirm.

