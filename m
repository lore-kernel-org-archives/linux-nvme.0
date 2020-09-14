Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7985AC43461
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 23:25:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F072820936
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 23:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YnnnmosE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PQ1FD/Jg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FzjUnFFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F072820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=PrF4pDHqhi7oQh9EMdyZLvYTkClRn4hLVmt0NLzoPcs=; b=YnnnmosExLb91wSIvzsZDhRUQ
	IN+r1FqVknR3WyTIPRldELsr2tZLXaMgvC6lxv4UeACu/2duUptyXxENODemUptucQDRkNmTdm9mJ
	JbgEDMH35zCHa99VTfDXz/JRVrtXpoQXZGm5fWHr+qBDK2mYU6rr6sKis9MWxzfvi6WVTCptM/elJ
	hivZHGwwUnDp5MCql0pLRIL5QVPcP2tVbQZhQH5047DYPMRzzhkmNcbd3N8F3MufyVkphIz1zLCgV
	NFXYQ6Zpa4pfMzVGvdFYVJEQ52RGCw7bg8w17lZaFynSBXMfoDL2g41tJXHZlKejzYHEP7eTtyArw
	cSYxy3YYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHxqb-0000up-SN; Mon, 14 Sep 2020 23:25:21 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHxqY-0000tZ-HQ
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 23:25:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600125918; x=1631661918;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=O9tUmAEfeC/kJbgl+3lC50bQm4SDczVv/oOiHsOecuU=;
 b=PQ1FD/Jg/sivWHwTfDls2PMXMMMaxTWdHMsklFcCFLGudE/gov24TKVa
 pePHlJxmpM3SMvj4NgEnXhbA+dKC4rvICjyhZysG/TgBHBrtchHKNPj0P
 SrFz7TyNjPuiArqVznu2PiEFE7Ky/jPCKGKwFfNAfPtgGMYbWb6rVBQsb
 J+fbAMu9cyYo7hsHy/uDXaoU1nD7oqRv6zVq8/9LvFuG69mFMMnb1I1Mx
 7zBG5XgCSfJLR5hmGoH4oZeNo2/jAaYt2xD6yFqZdyonFIgk3xciSIbZz
 xy3C/JgEz776awsazW17cXSPfUfs/CdHyLBtgwKbr1x5G+n4Go8UG+IdM A==;
IronPort-SDR: yyO9YZtsgW7Mm0kFBNogBuZcO4I3y+8tqM0PCL9y5OQq4sLQCd7MVsU55LI6nV3z2qupz0zdtg
 /Xz57KDsQvCSz3IradgpQcsSkDTa+a2oBVLtdnMQTB3Zt99nFaKMrWhw6ZX7NO5c/RxmK9qhfx
 FveQ8vTGUmE8PRCFTmxYEhSO/+1iAaL56uZvMTKxh7qNJU35q+V7YvV++WearESBuwUTbuTaXg
 xkUW1UudqvXy+vO0+B8mbWJVR0Fm8BTl3cZZ2zjtrQth7Pj+UfgkzN/ueZ3oPP5ryNFKXKupuh
 EB8=
X-IronPort-AV: E=Sophos;i="5.76,427,1592841600"; d="scan'208";a="256992668"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
 by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2020 07:25:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU81WmnK+6VoJ2aqrD+U+DkwU9DfWPfwNM0HjEcks89Tvc3U0y19Xv2vV2wXl1kcJvFDR5JL2J0Xpj+ZkfCC0YwFOhKsTgS+XRbNeOedkDuBrRXekpeZVoaIGZCCfqDfg4eY8QLh+DJQmpHtfCdlyypbXVKA4U7cE6ZDdPDNzD896Fd58FjQdQBGta3wHzp8NrYRSpNf9MktKOrs3T/BVbLgwYZ4avBDWgu1gsRvu6e//aB1vlNSv+nR52IdZi8QSN2IKM00nFyKkf4DCnCx2kp1b9uLsMim2cUM9ZFaX8/VMADueKBIl1pNR1URJQ0bzo+cGTEJ9q7lLpyK9zm4UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rj0nIARttSHgoQuaqrcu/vVPsxwbe33MekWLuSiqDc=;
 b=KfEdxIc+e24l9zOIbqPMCgelZEASF/oMm6YqB1m8BH2SR8ZUVtDfwE9XL4HE3xuTMl38PFwaXfMpCgKvzxJib7kAxyGNo0+PBjoug3rFO1pjgsqu1Qrwmr5vTdo1zAP3KZsDSDxW+I3Lo9Uhk55zmT9kE+ZtXQBLe5jihsAZ5awstrahT44aA3oS/DQaURt5jNvwi4YUSASTBpokmB9sfxPRQC2u8q8BS/9cjjiYk05lEvdvQETq9mo5KxFpt27MX8rkdktMTxE23J7aqVfxcZPlExla8YrPAQUnIVZ5XNCwhB/VyTyM/7w6jD5oAFKFquOIykt0pSkEJMQcWwyh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rj0nIARttSHgoQuaqrcu/vVPsxwbe33MekWLuSiqDc=;
 b=FzjUnFFw2Z9DYSZLekz2HwmGg9jpSE/uoVZX/7oHBvKpPRgn3xS/kbpGIYF5FCRtBnmPt1tQSXjWCZkJpQQJuUIOXEGFsEH0/tJW2s+h6+5zx7eMGRY4YlpOaM6pNJTJGcx8sUuPNjw1zFmFPtKYk6c/XOgbPnNuhfcG/VM6rJY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0425.namprd04.prod.outlook.com (2603:10b6:903:b4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 23:25:08 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 23:25:08 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Topic: [PATCH] nvme: translate zns errors to blk_status_t
Thread-Index: AQHWhukkr+7z5FAjgEyIuorVxC+8EQ==
Date: Mon, 14 Sep 2020 23:25:08 +0000
Message-ID: <CY4PR04MB3751DB156A3A2F4663F49DD6E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
 <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200912064104.GA19223@lst.de>
 <20200914194421.GC10507@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f58c:fb44:b59e:e65e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fdc1488-b408-4caf-413c-08d859056ba7
x-ms-traffictypediagnostic: CY4PR04MB0425:
x-microsoft-antispam-prvs: <CY4PR04MB04257BD48A65F9A15C8BE245E7230@CY4PR04MB0425.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zVKFAR/NZE50IgAo2N/X/nYDOwrPCpOa87ShTxCFGk5OqyOp0n2/9IXiCenRanhJVLbIDD55pApECvtjB1zbqTKBnZ+xbyU6BokPRF1nmgl0OOHrcDAJOvlU3WeGA1Mpt1/P4+kwGw25Z7q8PlKwQOdgKQontomG0oD7rmHhe/tJgGQf72LI+4f2r1OFUzOZ3nj7W7NXy2vRvVxDcrP2XNTTmu0gDt1T3memOhhH+WDdb4RQMuNRMtRq55DY58kY4BusUQzWRYThDR9bGb+0mJfw5vH1LQHhn2Z4qGkUStjNr7Jo77IDGwdJf03bM0O9ujqWsbABTprmPRX0lZXsE2C9N7QJkq0czQdVKZ7hO+Bxr0J4p5T0+rNmYfX7wQIb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(55016002)(86362001)(110136005)(71200400001)(316002)(9686003)(4326008)(53546011)(52536014)(83380400001)(186003)(91956017)(8676002)(33656002)(6506007)(2906002)(54906003)(76116006)(66476007)(66946007)(66446008)(8936002)(64756008)(66556008)(508600001)(7696005)(5660300002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: GRf0SlS812TNGVulcmNpFE2o7kygjqOFNGsEncIz0s2lVCjhuOekzSX2HLrOijP5MCO+kGjpm2NXFV4vOOUcL0ITQR+Yr0v3/gq5bLBRCqvuAozmm/KII/g3ZzeYLP7vcshxGer8/UffgF3g1j9WP6YJswiP/bpt2DEz4TliWDCxBSjQtNd4heTST1ZO+7hig7IlRgMFe6p1kXeO4VFdANQAl3cnQ954/4h6iz/oZbOFTx5IvIHNNDAh66Siv2w0030VxxOrMpr6+mFhftnOOC0jJtKGFekj+s8wsDN2bgGLpCbPbEhkvPhywFblgtmMdXuiUmaXRXYJmhPyeXxAV9C5EQExcurcnuGjRuXwhFcOxsXx0dTiDQHJE5h6Z1HH4LHzoITnRtMJgTEMFZZh74uyQund1Y2ERhVg92WT0ySQIqoaQKB8IAc4VW1PZ2/o4qW9Quol2k0RefNPQkrmX57fM3wZGzMWD1D+8KAbZUYtjbtmrTas9KHCrVaw2CF0Q+ndMGcJ2iv1EMgNCJSjFlrddP6hdYKKFhPE61s1K3+N7JeySQRLX9KJqbAOIo+DiqhvZM5/1H7DE0OOBRXXaSBFiYJmiwsgtyTe7qHvud9WqzaC6JxqgoaoDKOIYQXh78sUUll6NXwRGAGYfUNk63Jd+Z3TjRJmt3baWv23qsS8w/hW2WluCrPTYRMB+8vUui3dKJMoYJHSS9GbiTIYMg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdc1488-b408-4caf-413c-08d859056ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 23:25:08.8527 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBLC16+Eua1IvCIFYPAaHcSM7S90eXlj6IwaYQlK+2vO1Thy8tRi8owN5DqtsjD4Wrxd3vzW+LcvvXWjChKD2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0425
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_192518_965267_A3796A3B 
X-CRM114-Status: GOOD (  16.33  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/09/15 4:44, Keith Busch wrote:
> On Sat, Sep 12, 2020 at 08:41:04AM +0200, Christoph Hellwig wrote:
>> On Fri, Sep 11, 2020 at 09:35:31AM +0000, Damien Le Moal wrote:
>>> On 2020/09/11 15:10, Christoph Hellwig wrote:
>>>> On Thu, Sep 10, 2020 at 10:25:24PM +0000, Damien Le Moal wrote:
>>>>>> I'm not sure this is the best idea, we probably need specific error codes
>>>>>> if we want file systems to be aware of the limit.
>>>>>
>>>>> Do you mean something else than -EBUSY being returned to the user by the block
>>>>> layer ? Or a different/specific BLK_STS_XXX code which translates into -EBUSY in
>>>>> blk_status_to_errno() ?
>>>>
>>>> My primary aim is a different BLK_STS_ code.  But given that I think
>>>> that we should not map different BLK_STS_ codes to the same errno if
>>>> we can avoid it, we should probably also use a different errno.
>>>>
>>>
>>> Hmm. Beside EBUSY, I do not see a nice existing errno that we can reuse. May be
>>> ENOSR (out of stream resources) ? Or do we define a new one ? EZBUSY ?
>>>
>>> And indeed if we define a new BLK_STS_ZONE_RESOURCE and map that to EBUSY,
>>> errno_to_blkstatus() will get confused.
>>
>> Yes, you need to pick a new error.  I don't really care which one,
>> most of the mappings are pretty odd anyway.
> 
> Selecting an existing unused errno feels a bit arbitrary for a status
> that is currently specific to NVMe ZNS. Could you provide a little more
> guidance on what you're looking for?

Not just NVMe ZNS. SCSI/ZBC and ATA/ZAC too (both sd driver) :)



-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
