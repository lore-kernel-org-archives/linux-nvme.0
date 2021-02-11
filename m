Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DBDC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:18:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A820F64E65
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 18:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A820F64E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=lc39H5Z3JD6X5u1WmKr624ubdB0wmhrqeH8lcw62fzk=; b=SSBw6eYl9T/zKsmmn0DarAIfRX
	hNQ2W//6iWPOmbBFZKvp3X6SSQc5yZAJqCpiP7zbfc9zoVRG6JovrQ7xilwUudi4fqPzzV8RDZyye
	69PP5bWhC4cge67IYIqOiEX8yHIARC0ExpBVQAn8xrfXkEz8KH9vvf6x85sa/nX0TggmhkyCdrrcw
	Z9ymMFs7XeK2YXcyPkhsukWtIyIiAgli90Vr5VA5V0Rb9dKtqfSJqVij9UF+V/Y4CnfhY0HI3fRNL
	q03HgtaOmw35zEYFk7Vx7b1FwcrF36O2wbIBbqdKkS2V+72ZI+zFuJ4YsBnIzlUiQi89iLbQaS5FS
	t6EQdLsg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAGXT-0001DJ-Me; Thu, 11 Feb 2021 18:18:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAGXR-0001CQ-5g
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 18:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613067481; x=1644603481;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=UVgvzZkFvf8XtYhHKtinkZbGlzkZiAXyKY5wyDtjp8U=;
 b=gRMqWzZnaQVbQ/s1MbeOn1XLIm3rdH0Gda4XDcPWV7e1/TONWdQa6pU4
 Pr5B8fyPKbUjW1FxoKf9x2KbX+dakN3+TQorTrNheAOh4r3g6fP+YYefj
 1PtUq07FEIdOj/DS2R0ozV3MdO3Flbtmp2OgwF4S0LVTTDZ9gJzDNeclO
 P9b5YvDLXnInyozHwZgvAmz4o6Iva4KZB3qgjyY0J/aD+h4a/c88cusRG
 ZRcqAlVbxfP7CiOasYUUMP3+HHUgndMhEb4A6Muw0q/XxSL7x0yM3005k
 Li7KMiRtTbDFHDb4eHqWEZqlkp4L4UbjYgLbTU/h1F+SKnjth+RGxk1Go A==;
IronPort-SDR: a8MkUmcUAHs4OO8UDiUgzCP0O3dl7c2nUtpfhuITwTn1gLARFiD/Ha5sfUHn9E0Abx+WYKh6wd
 Rx9dMiZhIKCOp9n2PTTtc02A09g9HF0VEoTMs8WHB10Cpct0MPQIiNc7eTTk1Mv1d6otq2N7jf
 +L3wce5gxdBDj2cVfgKI5okYGa7O62bVQ/EnLg7Yvsy0D3JLObYPYtFBcAPHSn1n0hNNCE+nX8
 Bn2svX1tQags/39pVpw4dkSzGvlUecJzK8VtAtk7kYvlhBk1j+K6j5OaHX0wnwWTQ1BnaYYfc+
 F24=
X-IronPort-AV: E=Sophos;i="5.81,171,1610380800"; d="scan'208";a="159791157"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
 by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2021 02:17:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcB2tP88Na+9IvnYE5JbjTwEcSCxqFMClWQl83zCDeuz0n9wE7Gdll5g7m42RE+kH844KPDnjAyUCZbCz5lLi0hEdqlJRUFRAV5HLlnE4W6TouqCNGt+pkPYweUI7ZDSGAjyaHmRAfnl9zlk2Cp6ylDWGGThPxqPbGDN4rM+lGhYRNiVintMfX5cCjsUvIgCr/kvASjoxQr2HvfJ0NcBI99oNoNgMSTnrADaHSa/xNgTkYFbzo2BdGKvY1b0t7z2/a4yA42mtWFOQQ7fX3VWgceMmwCC38dUErE3u9f91YMb6DrgFAq1WT9stt2ZMAXg6YzRywd6ffUKX6ii1VNZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UFXexYCGjm48IV1HQe6C5XAuzgtra6kDpq5c57YWyc=;
 b=aILwS+IBore3/d14rmZ2zWdHv1OxVJgzr13FpdCLXDx4V0EKvxoN8uJ4804sNAQiCb42StF8Vdi2s66rgotx49yNGmmRO8D31PBOybPcX38kfyJ4JaY7MHv7QN/t6p3d60IyYLHurgn+me8R1VsDijZ/3orcAeiEMSYSbd6hYlkDhGHcE3vMEX2CoNlKCxvtWjSaiA7hnkSXExilJS67+/QhaEsnUzXcDVTa4iafHKOIc4iZWxeTxj78Kf33hxS3WtdeZipiPApDjdI4IufRkkcUyNmtvmZfkpBj6Tfwb6pWVDYQK70t58RMDNp9mz3k5F0gsJyomr4/W172MCNzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UFXexYCGjm48IV1HQe6C5XAuzgtra6kDpq5c57YWyc=;
 b=V50PbtgO6i1Nm9lEXwMHIuGW/1UrjLLGMXgX9sk+jSjgcanDSH7jlCXY0rGCryYUzc+Uqp1bLqvSQMzCx6PZ7jmVN5h9pBClsQWV+R8GWxKqeN4JLS8it6+IxgM1sulN8YCCiQntxIJAr2peO+osBDJ5068+WNCuH4xdLGYKYE0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6248.namprd04.prod.outlook.com (2603:10b6:a03:f1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 18:17:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Thu, 11 Feb 2021
 18:17:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: nvme-5.12 is crashing with fabrics discover
Thread-Topic: nvme-5.12 is crashing with fabrics discover
Thread-Index: AQHXAGHGX9ypV4/+aUmbh2zu7YHutA==
Date: Thu, 11 Feb 2021 18:17:56 +0000
Message-ID: <BYAPR04MB4965CD9C122653C1009F0500868C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <f4f56a23-c458-5a4c-457d-d9478aea854a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:2703:6e00:a1e7:39ad:c095:f42c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ee98b1e-5e22-4bb1-f841-08d8ceb95b04
x-ms-traffictypediagnostic: BYAPR04MB6248:
x-microsoft-antispam-prvs: <BYAPR04MB6248E3DB6E83CB27C31D9409868C9@BYAPR04MB6248.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:350;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybKUIuh06R5/AYNuKP516pAD6H2CSBTto32indOoTl5U7KBkrgBZ2a7CJAMrhwMbsixFTvD1o405A3vLas+RizLT4sXjHNWVZwCXLGPX0S0nEc4Xq3zCA9f8snEHItDfHOdYlFZFee99nCphxUCTbFhNx1ttZAjrJ78QbjouVuJtWbcbpQnyMQSuIJIQIr1eIr/2wMANVEpthdAcEdZfgmAr4mn6kb4V8+FQ5rdHUa/nlu5aocz3i74rRDuhp3UuxrhYALF3BL24fyueEb+J2bKI6MtGd8okpefZog8boL9pbRxDLd3tTarJOETOefRrmdgS4OVYwvBWWl++nTvjB/93wTwGeLNsIimm2fdTzcsC5EXtffkMeU1fhbabVOVMHQJ+j8voQC9mCqtVSQzjyAwxpg02oFr0jPNNwjiAewbD7b2FsTJf946ISHpnqmnOZlGVmdYumW9vtwpA062Z5L/8zb6TW67JmGIEBJOImGleU3+kL6BmSM3NCxv8cUbUoi8tqTNIn2fHPAXuixvFNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(33656002)(186003)(86362001)(55016002)(52536014)(8936002)(71200400001)(6506007)(66446008)(2906002)(76116006)(66946007)(66476007)(83380400001)(66556008)(64756008)(7696005)(478600001)(5660300002)(9686003)(53546011)(316002)(110136005)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Bl4hUCagSAZ3vwJC0SiZrZEKLEtqV96VId46I+o92lwny7utiFyCEWV25tFW?=
 =?us-ascii?Q?tqZ8ty48PIMgJF71un+8/ELrT4KKbk/6fBWyZLUMUSXOzYc+zn7vxMI+cERl?=
 =?us-ascii?Q?MgFzSfJBDxVSjaqTY9DTTLg1NdLzCjNxptf1CrNpQP0TCqEgG+EPsyH2d6jy?=
 =?us-ascii?Q?OSTAwd0Lb6o3pxfEMasu0sZAqp1dY4VQ+qGE28R12M1iyNBP3IeT0osJ5u3k?=
 =?us-ascii?Q?wyzXps5BbJAiv7hEMYwNEcmCaIj8GPX/wSYFG0oKIHyubBuSFEA9ifK6KFsg?=
 =?us-ascii?Q?orVkxu/LGx/MSPeB3s9JQ5t/ouipqz9+DXTN6JD2RXZZTZ3tRqkBZ7NVnbtU?=
 =?us-ascii?Q?Kr1HFa+3asWSTk69/IpG4vEBjVFO2L4pwXyPv9FKj9SZYdR6SKXtPcT8Dulf?=
 =?us-ascii?Q?FWgMYC+SBv82+kEiM4GVdNk0c1lfH9YP7jhv27zFYEt0UeVV0T+lIP12mcJh?=
 =?us-ascii?Q?vkwc4JB0x5PP00IwOcF6Fo6M20yMo9OlajFsCmwKUe7egiwuM0Izva4gvIAC?=
 =?us-ascii?Q?gxQz6OPMLY8zjodEEVS+jFmsK6TcHrGOYRCEIY+oJbCN+BZTkaW4sRuh/F+Y?=
 =?us-ascii?Q?wJgAK38TrbfUlMRozTnuGqlqjp8aF/oz2aCY1bf3D4f+f1kKFu5Bm29C8kKx?=
 =?us-ascii?Q?eeaJZddoP+ZIxvNlzvxTwXi3BcOX1E9aDvohVxsDjhyfQUKT0cijrlc702Jq?=
 =?us-ascii?Q?WLyIyc+2H75TQ/FEg48ONAy+rZNs+BBMfSOFle+44qvXMitzgoDyP+9b8d36?=
 =?us-ascii?Q?tc4UgNvrlTZtS6+JE7MC9Sju+Du0bQsWI8q/ekNtG+Skf4n6RYZvitxppDWV?=
 =?us-ascii?Q?kyIkwS+r7nOct96X08+okAqDSMjwcABR7qyhW1Ubx3q1kXQ3WKvppLLmNSRD?=
 =?us-ascii?Q?O4i63tynIL2Wvq/swGTQbcdQrPx9zt3STtq1cZ+vunmB2RyiTIJaKM7wQI23?=
 =?us-ascii?Q?NMkwiWH2UURLSLcJt+meo40WTBoXxKZwy3nli/XQAPFEWlN+UiS8oT65u7ic?=
 =?us-ascii?Q?r37UiE8oFtqlaKR7T+1HN2+TqhAILIASree46LGW82hyj1GMlXXFCnJI9KX0?=
 =?us-ascii?Q?ZranNDeel/gX0gCooqFem8fJookUiO+tv5YO2dfUOmFaxkKn0GiOB+l6uEyJ?=
 =?us-ascii?Q?Zsdddnc1/YFU171x2taq4559eaqGSbHMA0EfvJ75LF6f4Kr0yWkfonHfNEQC?=
 =?us-ascii?Q?K2z4XhCbzZnRrrfoCRnmKPRqL/anH0uaqPVKG1PrTFH+1hDBArd9VUPSprc+?=
 =?us-ascii?Q?afG095pgmqDz/qEZGZL9YWuJCB84N5QSYL5SLJ5KAGZcQ25cALO9gdS8WyNU?=
 =?us-ascii?Q?6tTF2HVXKX8YHh2V8pE/JsUqRkzt5nCIYe/pxydJHBWSmAy0CiqjEsZvSoxg?=
 =?us-ascii?Q?xXTXBKfgRz/c/90STAa4GVdU2McfmnRHODv0is4EC/03rCJa9Q=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee98b1e-5e22-4bb1-f841-08d8ceb95b04
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 18:17:56.2370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pd+ek4YhtAvZ6JcZMZARRNvOR0NU4pF4q0OHK0VaZZtdS/kgZmeYAc8Cg7NsaOuNybodVM0cvnKc3XSTA0u3bJki4T0h6Xljmfpy4MuhxwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6248
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_131801_353800_1F2D83C6 
X-CRM114-Status: GOOD (  14.79  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/11/21 2:36 AM, Sagi Grimberg wrote:
> Hey,
>
> Started seeing nvme discovery crashing since commit:
> a7c7f7b2b641 ("nvme: use bio_set_dev to assign ->bi_bdev")
>
> Not yet sure what's going on, but reverting this commit
> makes the issue go away.
>
> Trace:
> --
> [   86.901818] nvme nvme0: new ctrl: NQN 
> "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
> [   86.902223] BUG: kernel NULL pointer dereference, address: 
> 0000000000000368
> [   86.903345] #PF: supervisor read access in kernel mode
> [   86.904949] #PF: error_code(0x0000) - not-present page
> [   86.906202] PGD 0 P4D 0
> [   86.907020] Oops: 0000 [#1] SMP PTI
> [   86.908025] CPU: 3 PID: 1470 Comm: nvme Tainted: G           OE 
> 5.11.0-rc5+ #35
> [   86.909333] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 
> 1.14.0-1 04/01/2014
> [   86.910924] RIP: 0010:bio_associate_blkg_from_css+0x45/0x140
> [   86.912854] Code: 38 f6 c2 03 0f 85 de 00 00 00 65 48 ff 0a e8 12 52 
> cb ff 4d 85 e4 74 4d 49 83 bc 24 c0 00 00 00 00 74 42 48 8b 45 08 4c 89 
> e7 <48> 8b 80 68 03 00 00 48 8b 70 50 e8 0b fe ff ff 48 89 c3 48 85 c0
> [   86.915683] RSP: 0018:ffffbe6c409d3da0 EFLAGS: 00010282
> [   86.917316] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
> 0000000000000010
> [   86.919128] RDX: ffff9e82f3b60000 RSI: ffff9e82f0fdea00 RDI: 
> ffff9e82f0fdea00
> [   86.919135] RBP: ffff9e82c2769000 R08: 0000000000000001 R09: 
> 00000000409d3d00
> [   86.919137] R10: ffff9e82c2769000 R11: ffff9e82c2769078 R12: 
> ffff9e82f0fdea00
> [   86.919139] R13: 0000000000000000 R14: ffff9e82c2769000 R15: 
> 0000000000000000
> [   86.919143] FS:  00007fbecaea0780(0000) GS:ffff9e833dd80000(0000) 
> knlGS:0000000000000000
> [   86.919146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   86.919149] CR2: 0000000000000368 CR3: 00000000034f6004 CR4: 
> 0000000000370ee0
> [   86.919162] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
> 0000000000000000
> [   86.919164] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
> 0000000000000400
> [   86.919169] Call Trace:
> [   86.919243]  bio_associate_blkg+0x20/0x70
> [   86.923268]  nvme_submit_user_cmd+0xd9/0x260 [nvme_core]
> [   86.923391]  nvme_user_cmd+0x11f/0x190 [nvme_core]
> --
>
>
I think fix for this is present in the linux-block/for-next tree, can
you see if that fixes
your problem ?

commit 59c157433fbc6a7f63f3d708ca2966d0f56bcb7c
Author: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Tue Jan 26 21:37:38 2021 -0800

    nvme-core: check bdev value for NULL
   




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
