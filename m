Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FFBC433E6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 03:28:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB672068E
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 03:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yPKpjXKD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZZ/Wkxj4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eIJfNpV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB672068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nx5JN9Pm4s59IGXNQCuT/FTTx2j75vFWXbY6v1ppxvA=; b=yPKpjXKDLm6oohrpuqCFNwjqv
	CpRJsF/dnvIfJGDZSfI2kSMSwRCGrFlS44/6Vn4JPotOnyHc/qpjRVaaV4msvGWlX/oE0YPDMPgIu
	/LWTwFQOeP36Nret29LCFTxko2us+uZAqK4+Oej17ooBXCvyB84HmNcXm+QS+R88b4/3NJY/eyZk1
	Ex3bm8NE9czJjPHepQjV4+5Ek9UxM/l52UczY17EcNq6gYokFskx/mOG6MjBJxrCktlpqjfoYEAdw
	V0fsGOex7eSb/wyA4aSnc/BqCMxnIs5MXPH31MwLRNj6ISgpLyCjVcrR+JH/HfbeGEqG1KtR8kQ4k
	DoH3ajdIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDJRp-0007JL-Fd; Wed, 02 Sep 2020 03:28:33 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDJRl-0007Iw-Mf
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 03:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599017309; x=1630553309;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=zAn0tFaB+K1w1uYObys+smHd7pvehShc966V8uXImb4=;
 b=ZZ/Wkxj4sXQ+8VxBcG/SnpC7f59aWgK11mgwF0vewJko1OAyKwtp20NA
 5OPjDbjsQoDV1Y4UDijh242FzU/lM1OfbS8wI9xXvZrKmAOT4y62Tv2Az
 Jt0gy0n8m7fjTcDGuHBdtOAvYGxCzh9XjXiNrluCHawQZF5gAn4Q7rGDc
 ozWRLAtJmhDj19s5ssx5ospfdf0U/hV2PC4QeIZwWQcIgER8hCgMvCAcc
 oPNNHaMc7d8PZJWR72VuXvSCGorM1xskUC/nLZAnJyvB5XcWLqnMXc2+B
 3PGjaJE6B/bla3qI4AIhzWYnznHoFv/sJt1joyWBd9cN3oyhqwDMQ4Xfa g==;
IronPort-SDR: xwkCQa45GTCOXE3U2PvhwP6mHeR+z4orZIWmk1TYNORim7S26PGTQ6RLmacEkmXSB90XseMcqk
 1K4ci8V5XnsGoPamzQnif6HGjpApLPuVpoYIYKdB/ejXjB0AlZIB97T94+UdPE4BL4v/NQBEUW
 8p86+JP/g+s9+sdiqIg1yys/hofXMNKBJ7Z/qzYF+naP0ALXKEHZONdS1gYltgabitXeoeMgBC
 o2fGzayUNwmOtp+HgY4asWT1xoB90n0Kx7AjjKRE+iYXbJgDnD0OffUoC165rJLoNo8KLfUgld
 DT8=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; d="scan'208";a="255904260"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
 by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 11:28:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyqoPiSwQeiRAgWs0Y29wHPtZwi5BzoWqlJYGF3y4wSmY9vgeSechvXxabMEAiLP1qkvHeCfEfofzCqvpO6cvLmPwG17vq1glmm2NbrjkIdrsaUQTbkS5rzFafcZ4ojQRCXF/OPyAhj7iKf49qMGy3FkVCnc9+O8cnuRQbTpcU+ltMrDSPjeiEJxarkfN1JFCFuqIazCN3PUbDNvKirJaOvSw0/3NEYJn1gQS2BbZoWcrDHM5Kl451j52aNEeEYo5PFtYxjCfj4SXgJmPxA8ULL3EEPCLIwJnHtTuWU8pp0b8I751ResYZ/wJOyFSc1Y6LTIw2dIpSySW1LsHnFxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew6VgKRHP1uIN134ZB7cOUeN8FJBPI3bS0N7nDdyE0E=;
 b=AWgJ6MNOq0fFNWkAUE5nevXFOUHkgkAs+dsIIDm0NzqprgRHh/yQ5DNS0RwANRlnk3bo3qgj/Hoje+ducNFCQ/GPr1UVjaxJZtSLvBiTniWQzw55lKZafLumgb4UknR6qr2MsMwjXO7vQf+5tsMtT7KczDrAwYazQnQena++BtL2fyiVx8Z/ZpL/5VhO0Msnp9Mu8wIaaO20F9jp085b+rwbuPhyLtDOkYhCt8xpkVVoc7xWohqRuVLUD0l7heu5AL+4Su60xcFk1h2gpVhiwsOBcAgi+0DkJuw8/UfaNePZaUTWgByFSQVDYIgwHlxZaDTi5Q+ro0xJSh+R/iPvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew6VgKRHP1uIN134ZB7cOUeN8FJBPI3bS0N7nDdyE0E=;
 b=eIJfNpV+tEv5FAPRAzgoPJmlCY7d9rMhn3i8JvpVjnXlVLN25axCsiALYrBIs5qjSVtDDuBGtt1dzimPtMl4PjFhRsxvSnndMdsK0+y0NqOIcZRdim3YOFZGx9xCi2ko9G04aH4C84gL29S9fW4osVZYfIDk/SrAbAdaGlrMEks=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4232.namprd04.prod.outlook.com (2603:10b6:a02:fd::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 03:28:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 03:28:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Topic: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Index: AQHWf+XlK4Ms7t96TEedzmnzF2kEwA==
Date: Wed, 2 Sep 2020 03:28:20 +0000
Message-ID: <BYAPR04MB4965B93E7452C6088442235A862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
 <20200901015659.GA4398@VM20190228-100.tbsite.net>
 <74008ef5-f54f-ab08-011e-0ff271b1f33a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8ba47aa-abb0-4ec4-8460-08d84ef03de6
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-microsoft-antispam-prvs: <BYAPR04MB42328125A870D795F0CC2DC2862F0@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:374;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxVFdl3V1shh0bNFi17H3D1BMXB6iARWHMNP6DyoyTjoq5sbcR4pAUgrXbHna0ettaXMfbYHRemrsp2RXvqS7brtR6392YBTCvnKPsKZex9mJPH6qkDO2v6GpiMkU9KV3bFvTlT/imFUs1x/vxXRplobUiTv2p0oldtRjlFVII/Z4V6GjVhuBd341Uqfvs3qDilZz/h5CXbHoRHMpkIo2epS6qvB2KqnO76sjBRhc2/nnnhCvhOM4MZMbIlAatuqCfW5C61R43DsTSNstLghfTonB3l/PYSsSZrJuEWgZX/pEXjJJu6Jfd7ttK4tEq3psibAC7gag7pvyZA7FWfDig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(54906003)(6916009)(71200400001)(33656002)(52536014)(5660300002)(53546011)(7696005)(6506007)(66556008)(64756008)(66446008)(316002)(66476007)(66946007)(76116006)(186003)(86362001)(83380400001)(4326008)(8936002)(55016002)(9686003)(8676002)(2906002)(478600001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /j0mVriGqm5chkdfvSsEgZMOV4wgosOY17fO/igR4ragGzIStwVi+g49/wc5TTjYKaBAE/wSbroNZRxlA/6agJ7Wotso7VVtzSw3/xiZbKo9U2RsfeMZZR8gfbUkR6iJTv+H3AK44lYrPkSnJBKDs7NGi/rig8BkZmlJ2MW7S3WM8PX7aolt8iHgcENPaUhVEiGuJQZAFlWfm6H+zDSXSKk/ktTgWRkkIJNtWkLUt/Wcyi218qWq4X7Ed+ROU+8Ej25T4wuWylLrgJTXDsSbxvP+nJlkoaLYV/o2vSWXUCRIN47EfuStVl3INKXpoJLRTzndKX1ys/qIXCI9W5sbN7g46lYQRq0bQm+t8jTkzTmudlQQsXY6bjNYZqGNZ81wHm8thiSLzFCgA+o0LsVrmFgo1eaWZcuOpwLwXbFQ0n8385AFgV1hq7Xkuo6nXB91+9RxSCjQdU1YFY613GVKLgrhZjUgoyCNKrUYmi3oyW5/V05kJrQSf8/I/NAWDL6QhagbkOZ6jOKLUad2II8/2lq7wm6OQDKskIfkLM2uzQnAU65+BU2GH5anspOgunS9tnMfV+8K3I/MJuo8gpBjHFUYfc0Z0ZdXTH3LRgRzCi5jPKfI/GIpqq4xKYH8Q+6Yym9YGctdLNSAzWlCq9uYNA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ba47aa-abb0-4ec4-8460-08d84ef03de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 03:28:20.8281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHnu7a4sIXBAkfjQPATWU3IBznp44YFyPksd8BNeM0ggBqapI2XI/ckYcYk1ryGwd+Nvd7HkEtsOxVWX8EBgm0/ElcIwrpqn8sDRL7lz8DA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200901_232831_178461_4CAE3442 
X-CRM114-Status: GOOD (  15.12  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sagi,

On 9/1/20 10:21, Sagi Grimberg wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 5702a3843746..a62fdcbfd1cc 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -508,7 +508,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
>>>    	unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : REQ_OP_DRV_IN;
>>>    	struct request *req;
>>>    
>>> -	if (qid == NVME_QID_ANY) {
>>> +	if (unlikely(qid == NVME_QID_ANY)) {
>>   From your commit message, this should be likely(), right?
>>
>>>    		req = blk_mq_alloc_request(q, op, flags);
>>>    	} else {
>>>    		req = blk_mq_alloc_request_hctx(q, op, flags,
> Chaitanya, can you check the objdump that the change actually
> resulted in a different machine code, I've seen patches of this
> sort lately where this annotation didn't change anything at all.
> 

Agree, that is why I've added performance numbers.

Here is objdump for likely [1] vs default [2]. The generated assembly
is different with likely if someone reports performance regression
we can always revert this patch as it is very independent and
trivial.

With likely [1] :-

  00000000000008b0 <nvme_alloc_request>:
   904 {
   905      8b0:       e8 00 00 00 00          callq  8b5 
<nvme_alloc_request+0x5>
   906      8b5:       53                      push   %rbx
   907         /*
   908          * What a mess...
   909          *
   910          * Why can't we simply have a Fabrics In and Fabrics out 
command?
   911          */
   912         if (unlikely(nvme_is_fabrics(cmd)))
   913      8b6:       0f b6 06                movzbl (%rsi),%eax
   914      8b9:       48 89 f3                mov    %rsi,%rbx
   915                 return cmd->fabrics.fctype & 1;
   916         return cmd->common.opcode & 1;
   917      8bc:       89 c6                   mov    %eax,%esi
   918      8be:       83 e6 01                and    $0x1,%esi
   919         if (unlikely(nvme_is_fabrics(cmd)))
   920      8c1:       3c 7f                   cmp    $0x7f,%al
   921      8c3:       74 53                   je     918 
<nvme_alloc_request+0x68>
   922         unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : 
REQ_OP_DRV_IN;
   923      8c5:       83 e6 01                and    $0x1,%esi
   924      8c8:       83 c6 22                add    $0x22,%esi
   925         if (likely(qid == NVME_QID_ANY)) { 

   926      8cb:       83 f9 ff                cmp    $0xffffffff,%ecx
   927      8ce:       75 34                   jne    904 
<nvme_alloc_request+0x54>
   928                 req = blk_mq_alloc_request(q, op, flags);
   929      8d0:       e8 00 00 00 00          callq  8d5 
<nvme_alloc_request+0x25>
   930         if (IS_ERR(req))
   931      8d5:       48 3d 00 f0 ff ff       cmp 
$0xfffffffffffff000,%rax
   932      8db:       77 25                   ja     902 
<nvme_alloc_request+0x52>
   933         if (!(req->rq_flags & RQF_DONTPREP)) {
   934      8dd:       8b 50 1c                mov    0x1c(%rax),%edx
   935         req->cmd_flags |= REQ_FAILFAST_DRIVER;
   936      8e0:       81 48 18 00 04 00 00    orl    $0x400,0x18(%rax)
   937         if (!(req->rq_flags & RQF_DONTPREP)) {
   938      8e7:       f6 c2 80                test   $0x80,%dl
   939      8ea:       75 0f                   jne    8fb 
<nvme_alloc_request+0x4b>
   940                 nvme_req(req)->retries = 0;
   941      8ec:       31 c9                   xor    %ecx,%ecx
   942                 req->rq_flags |= RQF_DONTPREP;
   943      8ee:       80 ca 80                or     $0x80,%dl
   944                 nvme_req(req)->retries = 0;
   945      8f1:       66 89 88 28 01 00 00    mov    %cx,0x128(%rax)
   946                 req->rq_flags |= RQF_DONTPREP;
   947      8f8:       89 50 1c                mov    %edx,0x1c(%rax)
   948         nvme_req(req)->cmd = cmd;
   949      8fb:       48 89 98 18 01 00 00    mov    %rbx,0x118(%rax)
   950 }
   951      902:       5b                      pop    %rbx
   952      903:       c3                      retq
   953                                 qid ? qid - 1 : 0);
   954      904:       85 c9                   test   %ecx,%ecx
   955      906:       8d 41 ff                lea    -0x1(%rcx),%eax
   956      909:       b9 00 00 00 00          mov    $0x0,%ecx
   957      90e:       0f 45 c8                cmovne %eax,%ecx
   958                 req = blk_mq_alloc_request_hctx(q, op, flags,
   959      911:       e8 00 00 00 00          callq  916 
<nvme_alloc_request+0x66>
   960      916:       eb bd                   jmp    8d5 
<nvme_alloc_request+0x25>
   961                 return cmd->fabrics.fctype & 1;
   962      918:       0f b6 73 04             movzbl 0x4(%rbx),%esi
   963      91c:       83 e6 01                and    $0x1,%esi
   964      91f:       eb a4                   jmp    8c5 
<nvme_alloc_request+0x15>
   965      921:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
   966      926:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
   967      92d:       00 00 00



Default :-

  00000000000008b0 <nvme_alloc_request>:
   904 {
   905      8b0:       e8 00 00 00 00          callq  8b5 
<nvme_alloc_request+0x5>
   906      8b5:       53                      push   %rbx
   907         /*
   908          * What a mess...
   909          *
   910          * Why can't we simply have a Fabrics In and Fabrics out 
command?
   911          */
   912         if (unlikely(nvme_is_fabrics(cmd)))
   913      8b6:       0f b6 06                movzbl (%rsi),%eax
   914      8b9:       48 89 f3                mov    %rsi,%rbx
   915                 return cmd->fabrics.fctype & 1;
   916         return cmd->common.opcode & 1;
   917      8bc:       89 c6                   mov    %eax,%esi
   918      8be:       83 e6 01                and    $0x1,%esi
   919         if (unlikely(nvme_is_fabrics(cmd)))
   920      8c1:       3c 7f                   cmp    $0x7f,%al
   921      8c3:       74 53                   je     918 
<nvme_alloc_request+0x68>
   922         unsigned op = nvme_is_write(cmd) ? REQ_OP_DRV_OUT : 
REQ_OP_DRV_IN;
   923      8c5:       83 e6 01                and    $0x1,%esi
   924      8c8:       83 c6 22                add    $0x22,%esi
   925         if (qid == NVME_QID_ANY) { 

   926      8cb:       83 f9 ff                cmp    $0xffffffff,%ecx
   927      8ce:       74 41                   je     911 
<nvme_alloc_request+0x61>
   928                                 qid ? qid - 1 : 0);
   929      8d0:       8d 41 ff                lea    -0x1(%rcx),%eax
   930      8d3:       85 c9                   test   %ecx,%ecx
   931      8d5:       b9 00 00 00 00          mov    $0x0,%ecx
   932      8da:       0f 45 c8                cmovne %eax,%ecx
   933                 req = blk_mq_alloc_request_hctx(q, op, flags,
   934      8dd:       e8 00 00 00 00          callq  8e2 
<nvme_alloc_request+0x32>
   935         if (IS_ERR(req))
   936      8e2:       48 3d 00 f0 ff ff       cmp 
$0xfffffffffffff000,%rax
   937      8e8:       77 25                   ja     90f 
<nvme_alloc_request+0x5f>
   938         if (!(req->rq_flags & RQF_DONTPREP)) {
   939      8ea:       8b 50 1c                mov    0x1c(%rax),%edx
   940         req->cmd_flags |= REQ_FAILFAST_DRIVER;
   941      8ed:       81 48 18 00 04 00 00    orl    $0x400,0x18(%rax)
   942         if (!(req->rq_flags & RQF_DONTPREP)) {
   943      8f4:       f6 c2 80                test   $0x80,%dl
   944      8f7:       75 0f                   jne    908 
<nvme_alloc_request+0x58>
   945                 nvme_req(req)->retries = 0;
   946      8f9:       31 c9                   xor    %ecx,%ecx
   947                 req->rq_flags |= RQF_DONTPREP;
   948      8fb:       80 ca 80                or     $0x80,%dl
   949                 nvme_req(req)->retries = 0;
   950      8fe:       66 89 88 28 01 00 00    mov    %cx,0x128(%rax)
   951                 req->rq_flags |= RQF_DONTPREP;
   952      905:       89 50 1c                mov    %edx,0x1c(%rax)
   953         nvme_req(req)->cmd = cmd;
   954      908:       48 89 98 18 01 00 00    mov    %rbx,0x118(%rax)
   955 }
   956      90f:       5b                      pop    %rbx
   957      910:       c3                      retq
   958                 req = blk_mq_alloc_request(q, op, flags);
   959      911:       e8 00 00 00 00          callq  916 
<nvme_alloc_request+0x66>
   960      916:       eb ca                   jmp    8e2 
<nvme_alloc_request+0x32>
   961                 return cmd->fabrics.fctype & 1;
   962      918:       0f b6 73 04             movzbl 0x4(%rbx),%esi
   963      91c:       83 e6 01                and    $0x1,%esi
   964      91f:       eb a4                   jmp    8c5 
<nvme_alloc_request+0x15>
   965      921:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
   966      926:       66 2e 0f 1f 84 00 00    nopw   %cs:0x0(%rax,%rax,1)
   967      92d:       00 00 00
   968
   969 0000000000000930 <nvme_end_sync_rq>:
   970 {
   971      930:       e8 00 00 00 00          callq  935 
<nvme_end_sync_rq+0x5>
   972      935:       48 89 f8                mov    %rdi,%rax
   973         struct completion *waiting = rq->end_io_data;
   974      938:       48 8b bf 10 01 00 00    mov    0x110(%rdi),%rdi
   975         rq->end_io_data = NULL;
   976      93f:       48 c7 80 10 01 00 00    movq   $0x0,0x110(%rax)
   977      946:       00 00 00 00
   978         complete(waiting);
   979      94a:       e9 00 00 00 00          jmpq   94f 
<nvme_end_sync_rq+0x1f>
   980      94f:       90                      nop
   981


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
