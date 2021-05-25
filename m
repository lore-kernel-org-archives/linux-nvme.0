Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13321C4707F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:11:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F3E61358
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 20:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F3E61358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ypDg1iAMwuCENO1cZB50n5mLozSIX1j65qCudA5ZTf0=; b=YLOei+AtDfRMjT
	srIASFZagGyaz/x69+xaHVw/Zl5+PTL11nlnQgv0P7I7NcZ/m8unkZdAOYaRRjIZvqImzacv58aNC
	8VZRGl+PcYOXH/kYRkCXgf0MSIWZZiL/eZmF6Tb6Zbbdq01qbYD3Q8wEBaEF1nMsS0Un8j7VQMg8j
	Sz1Ee4uAvo+D23QjOITDDbCe441sGKV7M2p5Cmn3HN6ZIPFG3aoPX6OJQQGav0wllRB59aB/dBZJ9
	j1iIJOsk2JJmmwUvAzfs05jrL0j1RWazkAgkcFkoPaGSKGS+rQa0Xt9venO1MlKu/eiyEoFX1+wcI
	DL/54zEbUSCzpdjj1WuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lldOR-0080RI-MY; Tue, 25 May 2021 20:11:12 +0000
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com
 ([40.107.93.58] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lldMQ-007zmf-MY
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 20:09:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vu0MFMDionUm2YnXGPuZ90+DaTrL7hL3LIKRn4zs45YE5ebh0H3KvDWPj0sYKsXwdqbgp6Wvixf/vR1WFJTysucUSEzLU2MgfKKqXTFmqFg6H2MvW/RDYG4bCLpfnKgHPC8EDAchqABr9CHoN0FyB+edyKlImLb6dib87m2UUFlJKPY5U/lm7H8lVptmWACuq33fHcZ940aMQbPFRfVl260MQ9p3rQfPHfltDGaOyQiRoUIJIfL5D9xV2omcyvhe/YEwvBmmIVHOHFjZk+T6ETWZhA8NOHAid+pegf4Nv6sfED9xfrrKnXtEsszde3chNoztf+4+2trDF4jlbwvA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jXNcpwTf2skLdNIcrEiejkGC+br6fHrnqu4Mo7SSpc=;
 b=I4aiwQfaoOaUnbf3alNi+b3cdi0gks8gfkrbTjyo/wmo2TAQ6w+BUSu3U64cJ9UCaPC/QA8f3XDYzoz/fbQhHdSb92+R0oZ5NsJrhxtDvZV/crAVn21yUjBHIl600s2eo3zD4UUNUrNrrtQVFg+6B4qhp2c6J6zrBcJBaDGPog1loavQMbYuzHki8lEUcxykoDW6m8FH9LUbpeem+U6qP64gXNysEDDgRhv/2pTBxGiPYGz7h+YsHTq3ctIDPogAZScBWMtDis6VtEWh7XyQklWW7leSrSSogJGgNI1Wrv+a82S5BV7tkqtMy+S0ANGTTXxqz5LTYU/iSlFh6zQgRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jXNcpwTf2skLdNIcrEiejkGC+br6fHrnqu4Mo7SSpc=;
 b=m/byNeVA4NaWY8DX0OvwqFQh4pW0Y3QE8c/yGCfI62X/6UheHmeF55uKu6WT9RpEe8xR4r1U5lnRAnf4Bza6+V3TV60wDwvUbjkLfePDwU0NBxVv8S/WzrMM8mGXFE8A18HtT4PHR/sdsu7AjWDzuPO5e8SRtka3gbCa033PEJU=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 20:09:02 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4150.026; Tue, 25 May 2021
 20:09:02 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Keith Busch <kbusch@kernel.org>
CC: Hans de Goede <hdegoede@redhat.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, Christoph Hellwig <hch@lst.de>, "Liang, Prike"
 <Prike.Liang@amd.com>, "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>
Subject: RE: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Topic: [PATCH] nvme-pci: set some AMD PCIe downstream storage device to
 D3 for s2idle
Thread-Index: AQHXURCj33ZwIr9nkEeZsNaCQKwCY6rzujiAgAB6bICAAAQggIAAAH8QgABleYCAAADcEA==
Date: Tue, 25 May 2021 20:09:02 +0000
Message-ID: <BYAPR12MB269360B4259CA2699A031AE5E2259@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <1621910939-24831-1-git-send-email-Prike.Liang@amd.com>
 <20210525062119.GA12561@lst.de>
 <MN2PR12MB4488679A3F04ECF3B8415975F7259@MN2PR12MB4488.namprd12.prod.outlook.com>
 <cd94fd56-7ce2-e431-4a4d-6c42e5b7a9a5@redhat.com>
 <BYAPR12MB26937AE0D027A84934F7D81AE2259@BYAPR12MB2693.namprd12.prod.outlook.com>
 <20210525195913.GB3704707@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210525195913.GB3704707@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-05-25T20:09:01Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=586bcfeb-ea37-4034-880b-7c4498a821fa;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:a1e7:c926:724c:a49a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54a99d3b-305a-4ac5-778d-08d91fb8f111
x-ms-traffictypediagnostic: BY5PR12MB4934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB49345FCBAF6AAF4A20C64E1AE2259@BY5PR12MB4934.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oerj2DAlNxlMmtzGl3AQNlTefz1WKP7O6a/c83/B1h09PeDt5Vbej/TBrKm96Z3jdZkxKNe4WEavdEW7CFQ9wQXhmvVapn3LYiNco3PoJcb8kTg1zQrO4/oWm4Lr4/0Gif5UkSGfyJu9gjB0+EaA6fcG5QwWyYv+VVPkQYpJS3SoH+6mjD7nTsoL/hDSkzrtr/P14nrkC33ZBqskjgXOqfiZn0QVuEl6nYhwwBacbbRW+z1GCs/U5pZ+/tzfVfEGLcg2AT+KTTtIokzUmCY8fkyiV3GmHD73SJMaAyPf/ZHe5mqfSgh7wt/OoB07gRJyPKEiKtq6yJlAjPqs1Ed/DhutZDfizAWEPjxi2Pzs8G0PgoeZwuuzbY8P+3y3LrfTn2RK2vehswWq1MrtG4KHZj4Njk8odsNdEm9hua/80HEOWeNDhHxDTeIiGmIfs/j+VLMnw1MKOpvjq23vRDj0TiAoghBMuqDOx++C6YwjNo76jk31j56urKwOOKzos8tlJWKXU0fubD9so8m8kYxXi0eqaKyIqxCby/I6TENDxR8Y89s6QTp0Na1oExjfRRKuC+4gwSKUjcsLybfBioXHpsqzeP2HFB5c/KwINXFYFF4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2693.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(71200400001)(316002)(6506007)(66946007)(2906002)(9686003)(5660300002)(55016002)(122000001)(8936002)(76116006)(86362001)(66556008)(64756008)(66446008)(6916009)(7696005)(66476007)(33656002)(478600001)(54906003)(83380400001)(186003)(52536014)(8676002)(4326008)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bDHsxkYi9esRvLBwgAOnUK9LvJ+clbWiQF+ZXquptV3UZAd3SXdLAgAtW5OW?=
 =?us-ascii?Q?RIrnMgzwFnvXnTvWxd/QDQbfvC593tymM9pjemKyGyOM2WYAo1QUma77X3TI?=
 =?us-ascii?Q?kqEuNDu/68kB5OVoG6oy/HBlt5z1P3GX/D/gZ8zyHSk4gjTajZzmuoqzYLcy?=
 =?us-ascii?Q?Bl673g1eNxVmnTAmPHwj0F19ylGk7MigrEf4uK/6jY5MW89kMEYmy5/EBNqN?=
 =?us-ascii?Q?RxDqQD9lNoYOHaoVHxxUe7ZbdaT8/VaKexS/16rZ/CIikR8iWDZL/4yrEm9I?=
 =?us-ascii?Q?OTau+5Co0Vpt1OPxKpGcWsVqXpXfhY6qKlO0aSvDnSvfcPY3aPs50SetMDEK?=
 =?us-ascii?Q?uJyrnEfXCk6YSkUv8UKY0TGICYOBnBmwRMlHwkB72a1tO8/4sD9EjJap7e9s?=
 =?us-ascii?Q?cgyWCoqOquMmDkpHuljglnwzWUq5OV82L5M9AamTplTAY21gJ2hGCpbuhsO6?=
 =?us-ascii?Q?3J7gtOMakM46T5u+IVovBzFuyU756QYfA7jTs0EMgW94Ea76pNI8TtCw8imk?=
 =?us-ascii?Q?3VezayHnOUWV6y09NwtW3Z6tALbDgaERgS3TtFLlsbQnOxdi+04gb2779ccR?=
 =?us-ascii?Q?0HyMjJt6P+rG+xeKaydgNs6yD6luor2HZGrod81N1vI0n3N1RJG/fsPJ5MIt?=
 =?us-ascii?Q?EvJrpVc3KlE3EpBzNGmxY/rub80J/9UZ2GqYRG20bkbuRqFmtViPS1fexzLH?=
 =?us-ascii?Q?seFos2aZxK9+npoC8dlY7O1tNv+iOtHmPegmQNqi8mXGpJgIeY+fGrfrDCoW?=
 =?us-ascii?Q?h1P5SbvUfBsvjXzG0K/GTwWFmQX8zbSO0aZrDc/zHMly09zjprHkOb8weibu?=
 =?us-ascii?Q?aDyZO26MxhuPQqWsHD93Hs+gD3ZPW5aA+8b9NXVynMxlvNVEd6ZfnOlJzzRm?=
 =?us-ascii?Q?fpolNmkVHtjES/fAnCDm8SkudQkjbFN6JNZwsy1iKLrxtFbxJFGdaAP6Gwjf?=
 =?us-ascii?Q?x6KdDgvUT7gbZYbmtEBKVXKROY7+UhvJup5I2o5JMMbM5MrQKVqqjNWf9KJy?=
 =?us-ascii?Q?xrV6Y+0R21xLTaOhCctlIcvilZTiqQUfnNDgltxTQ5kZrTysuR4Q7/lDo6AF?=
 =?us-ascii?Q?DQS6MXky4sxD0WYyCtgoN6+abQATaqpGRMz3Rodctfow1pfXt0AVvah7EvpV?=
 =?us-ascii?Q?YqPfKOgFQ9JLsRIk5JrtzvhHx9Iur+3ZHsg1UsWrEHYjIBj4EzNoRW+PaPgk?=
 =?us-ascii?Q?kErt6ulZqG2It9kGriSBEjPqE+huAEVmiEJoWJg7fiaptIPnbESkfWhjpndg?=
 =?us-ascii?Q?F+R3ou7VtOMRSY6id7Z1MnwYrlePVf3l6nRESQdJBKTuMlrDq667z8D12Fuj?=
 =?us-ascii?Q?dczjyJvtmYRsD1xJMak/kS16zIac+NW8AS+EkPAmFMDrVZG8qho6unRwdpOp?=
 =?us-ascii?Q?kWMsGxk1kyN/Q2NoBUNY6aa1vxud?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a99d3b-305a-4ac5-778d-08d91fb8f111
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 20:09:02.6983 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qcsgh/SEGcxHMJKfO518xtmNvV7CLrmDtAJoKF9YGO9b7qovADwnVw2g1xdrboIuM7KzF1f5LU9ly5QhrrHeAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_130906_880367_8599B824 
X-CRM114-Status: GOOD (  14.28  )
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

[Public]

> On Tue, May 25, 2021 at 02:06:09PM +0000, Limonciello, Mario wrote:
> > "Then the NVMe device will be shutdown by SMU firmware in the s2idle
> entry
> > and then will lost the NVMe power context during s2idle resume. Finally,
> > the NVMe command queue request will be processed abnormally and
> result
> > in access timeout"
> 
> The nvme driver explicitly checks pm_set_suspend_via_firmware() in order
> to know if firmware may manipulate our device after completing the idle
> suspend. That is returning false here, yet firmware will do something
> anyway.

pm_set_suspend_via_firmware is not set during s2idle - from drivers/acpi/sleep.c
it means ACPI S3 or ACPI S4 and thus pm_suspend_via_firmware however would
not be used.

Overloading this definition on these AMD platforms to solve this NVME problem 
would have unintended consequences.  Just glancing through the kernel I notice
the following drivers make use of that for decisions, which I would suspect to be
problematic:

* cros_ec/gsmi (on any AMD chromebook, EC might receive wrong event and logging wrong)
* tpm
* i8042
* amdgpu (would break DPM_FLAG_SMART_SUSPEND)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
