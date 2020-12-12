Return-Path: <SRS0=Hsw+=FQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBB5C4361B
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 04:36:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14EC123158
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Dec 2020 04:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EC123158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=SFr8DUPDReXmn0dSl2aemPuK/ose9XNbCU7BNRmt4a4=; b=K7lC0N8aJGva/0nVfiEs31W3r
	HQIVS3oSI5DTJ9QarmSGW9AMrTPhOvPx60fe50T8k4mArCIW/AlWctzMjSapdzesBRaTSryqAI0dh
	NJpZB1q2/3np50p3A38uLCuf+qwM3HXt/3HAegpq3/RMRpXybASmNpKmusisZKV/pnOzZI7vLy/5d
	lhfTqIwA+jpTkEUthC4mhgVgp4+NClUh2xT6ewKR3e/hATqoaRHBzit9V+w7bE8JRHC2R9j/Go0Up
	9ZiDZg/owr5q6RgjbbHgFUwhyh68CzNSYvf/npK7q7AC7Ep5IjPfiEOLxv6c9SmnkrzSmUfSd0LpG
	6/+eozC6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knweI-0007A2-Iy; Sat, 12 Dec 2020 04:36:50 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knweF-00079f-Ed
 for linux-nvme@lists.infradead.org; Sat, 12 Dec 2020 04:36:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607747807; x=1639283807;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3nna6Z52ksTAq4MysufUlTSRDGQgPKiPQ942E4RpWL4=;
 b=XJ7Mk9V5QPBj5mQ67VOqW13gfgaNHAQK0LIAdwk8MoqME8cBc+IcDN1X
 8lBQsgy4pro5/U9MU8/44JeP1zEfUiTqGHYk259A1nF0qiq+O2oGb1zE0
 5+yd6AGR7JmTRxxVg75Yki2SCA+zG4gbsDTNS9coYow9Q7hPYA4/VC8Yg
 uB4B2UhBXdHUmzm1fGP9wy+gm9pGGwK3RyfJVS8dwW0bR/xo3T6xluTaA
 F2RlJvcLOtwtJHNTx0sar/EV3uCNj+rV5t3SyhpGCfke1dPpIRenWg//k
 Om3tdcpxCyeIR9HoI88Cr0U+hnrYctlDnUFUn9PXLsMLcC84Ru0Jb/ili Q==;
IronPort-SDR: DiyPeaSrE/8RRAz6UNFMZt6qOOz6VKmHpT6Szg/acyZDp4hg0vEEWpZlYUNPOal18kXYwuo59X
 DEo9VyzoXL0RyXk20WDPJVqBC1cRPH85kMHCSzCthg5o6punHAiqYvdmudCtMfOa+CL6q7WBly
 Fnbh+driU4WQnbpm1NLS1lXkWJvHu/7bGg9kF/UKWYKh9gS8cXyKgt0qvv4bn+4uHvJ5yRunoR
 4lQ68PPQkechR9rEvjZEq9RNG+4YUXlSVs3CxaGTLgDPQTnvpvjQSZS0yHHTw/91aX/XTokK5R
 j2k=
X-IronPort-AV: E=Sophos;i="5.78,413,1599494400"; d="scan'208";a="159443287"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
 by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2020 12:36:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZesuiaQ+u1NOHjDKKJzN7yHsaoluDfdNf/MFn2CpaIVr7UIHs1anm5sLm3ipl/1oyMmdt/W0kqTUir2maMQari+iMLJVd536439SAD41/ThQ72YPM6gRyqvaTjUjHPwrqWuwKkc9mcyUnHknyALRrpHOy02w+846ZM2Wvk8JRq9Ega2+viZpMjoJWB/5EA8SdobF/wmFjw9ZRpkyDiitJivZIcVbq/eQmHNV/aj6wBle5XpssRUtpOGZTjTsn42Q3xoUQys5wQJ7d3QUlbVdYKl0MLuX10o/zD172iG6NCy7ouZ4gNOilbQCwoUqkasAIWOiFyz1tYgmWOCjybwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y8f8kjeld8s2nDccZlaQnB05zAuCgKpo9PGbfyo2mE=;
 b=fGan0ft+0QktlpWp2lHkxHVQk2o1O2034AouDKMXcfd6L5xJYHp6RnH+l6e72OL9Mgm+fQCi9pZNQeutcCwtVMhr8b2sDPoNl7jiKW9Xd2Kyz804OY2pC7PyCQZ1ZDpCKotoE2dF9cgy5vlePAv5jsyZsT49T7B6fWLiQg7l1SsZ8TRv74Wp/EGQ02aAgtG9ReRlHU+8aTkzKrdil50Ouw+lUX1eWeolx66yayFlQsj8cfkXRZvMQkFUJUexOOyYPQCU9Rb3lhqxaIsihMwoCNgo5DHlft/+ALgygGz9bJHYNd739UpeFlCJCXD/NCwrNCGrG7WKRWkFYPFO4SGWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y8f8kjeld8s2nDccZlaQnB05zAuCgKpo9PGbfyo2mE=;
 b=nkybFkE0qG0/QqXJa9ErY8OECw7geBlIrmJTyRUBhGYn9a3QPx1LFzXmvzTy06zojqPIQ9MehMj5n9ekC68xTkOXA7mPPvvx1anB8O/uco6vz63JRfNOdpUsn318tgpgewtVgWdxX0JNaEFsL52wSV/6Z3mNeCZvii6cmV0VMag=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Sat, 12 Dec
 2020 04:36:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3632.025; Sat, 12 Dec 2020
 04:36:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 2/6] nvmet: add lba to sect coversion helpers
Thread-Topic: [PATCH V5 2/6] nvmet: add lba to sect coversion helpers
Thread-Index: AQHWzr13f9+9GqQQ4E+2kMWDl1NOOg==
Date: Sat, 12 Dec 2020 04:36:39 +0000
Message-ID: <BYAPR04MB49654B4D7540896CFD9AB31586C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201210062622.62053-1-chaitanya.kulkarni@wdc.com>
 <20201210062622.62053-3-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB652229BB9545FFAB75F5A754E7CA0@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a219a7c8-fea0-4f85-6568-08d89e5784c7
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB655276D2B98BC3965F977D3D86C90@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFtS++djkIyB/40VU5zfkroUqsMITshR9b/crhC7eGHvJp9/u8ZC0XnOR2tBAEfQjn7x8lS3EGAWnLxNwMECEnMevxSx7aRY+f+8Zy1Noq/l6TA2xakJSKljLK8hrxVdf1ayBh391gfzSjV0ZssVp4l+216rju+yDQyGUZQLguE/lW0VyQg9uZSVrlYYsA/Mre+rgLw/qlw6HtlnPsr2JKNe5uN2cCaZfr2zDCj/yFteAGmoGg2oZaNufPhwo9/YUTJ07ZHmnYrwx7KO3Xn0DvmgnpYrDajCM+wOnfopFrPw7x2VtvLnEApUXjgszoo8f/+2wn4hss1suob1wLYPyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(9686003)(76116006)(83380400001)(33656002)(71200400001)(66476007)(64756008)(66556008)(66946007)(52536014)(66446008)(5660300002)(8936002)(86362001)(8676002)(110136005)(54906003)(2906002)(508600001)(4326008)(55016002)(26005)(186003)(53546011)(6506007)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bCQ5CwmE/AAsGM9ZcSNb7D7X0zQ1N+Zti3r5Xm48kWbtXr+omtdKTqgTaANs?=
 =?us-ascii?Q?uLCrDZoyud6LDxNu9XAhzHyzKgOZRTrGzbJ06naqBTdQfJOEaXDX7Oh+rvJL?=
 =?us-ascii?Q?2T1jXQp/DzPG/xnzNCDEi1L89JQDqKatapnTOFRIf+YgZx9zuaoHq0LqWrfH?=
 =?us-ascii?Q?W6N1A/Mr3RuIg/MOWmwpzBzLfWLbX7ecDRrpsBIcicO/dSkpehSAk+c8wz6y?=
 =?us-ascii?Q?ExSRX/P07IjcxOTS/NYf6Tnv6JuBUeARIGyLIk9bJJch5BP5+tbaOKLRULev?=
 =?us-ascii?Q?iZ/zEnv2+Q/9Jw/uTlaOvVkUktMmG6TIZAgu7jvTWBc3oMQVQ2tfTQdKFsnm?=
 =?us-ascii?Q?OoaQ6y17Mu2eeKtQlt4YF2ymrHsruxFNVljPYKnfDvwKO6z1/zwqjFN7oW8i?=
 =?us-ascii?Q?WWsNM8651qJr1gIwFaW4984T9EGSMsM/ycaKFwa1+SwgRcRBSVhgCWgWJjf9?=
 =?us-ascii?Q?M2kLLoDHEerCndCRb3agXdHHIxOE8XANlMmD8Jf3bp60m4RZDGmSuXARCaiK?=
 =?us-ascii?Q?/TTuUh76vHNpBbw0l5t3RhDKbfmaJbUw6jKLcx1obGkYYae0EyOioM8Ja1rC?=
 =?us-ascii?Q?xcR+vQ+l7Zmcw5CcurR7OB8kPCrrGT52EoLIsIptM16cdoO5ld7SLrDvyocR?=
 =?us-ascii?Q?vixErLFWCIkiyqFCzRpCPbENPEpGddl/AJ3FY8UlZ1mT5fYbUs5ZSe6XiIc9?=
 =?us-ascii?Q?v33re0q7oDsmzJ4X+V5KtHvfY9B74VfGRUHtJtW9MlHNS0wwCqwNXe89vGmc?=
 =?us-ascii?Q?uL+/mS+Y/vNYcRk9ZMktBtyIYjJMTY68JcCoRcKxqgos/btjrd/vQXHJyr1P?=
 =?us-ascii?Q?3sJJjSlaPieY7d2FPf6OrE6by7vnhwpAznVfudvoWN39TFArdaQGUTKPKVBn?=
 =?us-ascii?Q?Lhkey+Eo4qLn2nSr4DMbQRyy6JH72TJ90POYopctxWhE3qcvhiNdG0Tfb4RY?=
 =?us-ascii?Q?yHJ77fU4XtWqS9PxSyH9nXDVo32mNrDhHnB6WWeWzx357JG3IE+r6W15eTuJ?=
 =?us-ascii?Q?y/qQ?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a219a7c8-fea0-4f85-6568-08d89e5784c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 04:36:39.9189 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcLqU+T0EGhvzVw5lghdWSC0BNgmkeQowz6rXtLS48I7nOt6FJYOw4WOiAYrmz3wufuYMIKWKLoUzyyX9ripmaF8JgAVEDh0Fu8LtYJyqHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_233647_833630_DD9E397F 
X-CRM114-Status: GOOD (  15.45  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/10/20 16:50, Damien Le Moal wrote:
> On 2020/12/10 15:27, Chaitanya Kulkarni wrote:
>> In this preparation patch we add helpers to convert lbas to sectors and
>> sectors to lba. This is needed to eliminate code duplication in the ZBD
>> backend.
>>
>> Use these helpers in the block device backennd.
> s/backennd/backend
>
> And in the title:
>
> s/coversion/conversion
>
> scripts/checkpatch.pl does spell checking...
I'll double check, it did not spit any warningand I rely on checkpatch.

zbd-nvmeof/v5/0002-nvmet-add-lba-to-sect-coversion-helpers.patch
----------------------------------------------------------------
total: 0 errors, 0 warnings, 40 lines checked

zbd-nvmeof/v5/0002-nvmet-add-lba-to-sect-coversion-helpers.patch has no
obvious style problems and is ready for submission.

>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
>> ---
>>  drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
>>  drivers/nvme/target/nvmet.h       | 10 ++++++++++
>>  2 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
>> index 125dde3f410e..23095bdfce06 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -256,8 +256,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>  	if (is_pci_p2pdma_page(sg_page(req->sg)))
>>  		op |= REQ_NOMERGE;
>>  
>> -	sector = le64_to_cpu(req->cmd->rw.slba);
>> -	sector <<= (req->ns->blksize_shift - 9);
>> +	sector = nvmet_lba_to_sect(req->ns, req->cmd->rw.slba);
>>  
>>  	if (req->transfer_len <= NVMET_MAX_INLINE_DATA_LEN) {
>>  		bio = &req->b.inline_bio;
>> @@ -345,7 +344,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
>>  	int ret;
>>  
>>  	ret = __blkdev_issue_discard(ns->bdev,
>> -			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
>> +			nvmet_lba_to_sect(ns, range->slba),
>>  			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
>>  			GFP_KERNEL, 0, bio);
>>  	if (ret && ret != -EOPNOTSUPP) {
>> @@ -414,8 +413,7 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
>>  	if (!nvmet_check_transfer_len(req, 0))
>>  		return;
>>  
>> -	sector = le64_to_cpu(write_zeroes->slba) <<
>> -		(req->ns->blksize_shift - 9);
>> +	sector = nvmet_lba_to_sect(req->ns, write_zeroes->slba);
>>  	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
>>  		(req->ns->blksize_shift - 9));
>>  
>> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
>> index 592763732065..4cb4cdae858c 100644
>> --- a/drivers/nvme/target/nvmet.h
>> +++ b/drivers/nvme/target/nvmet.h
>> @@ -603,4 +603,14 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
>>  	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
>>  }
>>  
>> +static inline u64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
>> +{
>> +	return sect >> (ns->blksize_shift - SECTOR_SHIFT);
>> +}
>> +
>> +static inline sector_t nvmet_lba_to_sect(struct nvmet_ns *ns, __le64 lba)
>> +{
>> +	return le64_to_cpu(lba) << (ns->blksize_shift - SECTOR_SHIFT);
>> +}
>> +
> One thing here that I am not a fan of is the inconsistency between the 2 helpers
> regarding the LBA endianess: nvmet_lba_to_sect() takes LE lba value, but
> nvmet_sect_to_lba() returns a CPU endian lba value. Can't we unify them to work
> on CPU endian values, and then if needed add another helper like:
>
> static inline sector_t nvmet_lelba_to_sect(struct nvmet_ns *ns, __le64 lba)
> {
> 	return nvmet_lba_to_sect(ns, le64_to_cpu(lba));
> }
>
I'll add the endian version of the nvmet_sect_to_lba() which matches the
nvmet_lba_to_sect() that is anyways needed to get rid of the
cpu_to_le64() calls
in the zns patch.
>>  #endif /* _NVMET_H */
>>
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
