Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF7BC433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:16:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C729610E5
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 20:16:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C729610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WYgsJdlZMIF0x7DPXmqnweISaKZFxEpDlj7Y7luozJc=; b=XR3mA73nJMkHVrx8Mx9edQ5IQ
	AMirbCTGcSi4mBQXbgEm/IvuSYdRz1Oy8H0gfOYGmK9DlHsNye8iv95L63ovTQzWzxsziPCAorrph
	zBlKswnARxIi5vruNAVe2PpHAAgX22MO467bsSlud0GfgsIQVZAsqjpzKvUR13Yv0iuUCIkzX8Hui
	+NxjFSOyej4c0iMpYqM8fq+If1qsrJdvHD7b3wC5PhLBnNMBzzGp617oL9SDVZSdQ7zORNNvLCdAD
	15oJop77mQgFYJg/BerDjmWtUfQy65LHhOUD448Hr8ve2lqoeGYfNJt37wzVqvqh2B1cxSKFObRZp
	xu7p64xYA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVK1M-003NwK-Dv; Sat, 10 Apr 2021 20:15:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK1G-003Nuu-HC
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 20:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=uPndd08/TYYTKce+vNu3BcIEMj7Pvm+Gq5uHNF/laQk=; b=ujWwXyG8OLvPCr4ktQZhaaOXCu
 5XU9jvNZmdfyy6UBmTzCZP/S75SuA3iYSjkvnvSK2RRHnI1JUzwsNA0gPQ0Zj6ZLdNwAy7U+YQCp7
 Pmj1IN/k96sv2C6Gx33htzzfTUDVVNyIIvZo5H/h8Qe7e7bBZWPFea3cl+TbY86WBr0n0eD+cBPeS
 AyBfIceacriUmQ4Py7uKA0l8lI15xfp/f/aR5Qn4FdTbO7Kjig4UUmrtTGzFiKPU5PkkwXOXrQkAh
 CwI4KOhEqYHe89PNzZ4yOhQTg9SZumzK8cqxrZzYKCH60SMUMHD5hQ3OxH4SOYJCJblIKcr8uyouL
 SullTzcg==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVK1E-005FMx-2D
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 20:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618085747; x=1649621747;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JdZ6yqoT+yY03EZdwTwg1+8ugf51kLlK5tL9m+KS1Vo=;
 b=kR9P/9+XijHyY1qgyIJrSDXeYC06VQ94+FiMJ3zq6WZ2eHccs6ecZ0d8
 8yRyrQ/Do5Lzxk990SxjrDv7tnQxnnMxQCsP2Zp7fSZkYnAlSA5mE4AM1
 NlGhmfyYCQEhEqRTDmncSj0F5eLuaQqMmruZHjNSRNIc/zoJKHMuwWnB3
 7BMZlF5gm7ZwHw+/OXhuFeh4AzogXTbja4Z//EUkrKRrVsKngDBlHUyQT
 6fdyJ/bAhx3RyPrj8JWBF2y8YFaXM+E2E97SzbXsNgbG9OLVaH3IhbM8n
 HSU4VglpqG8YqG5GIkntg9awDb7q0RPA8w0whanmO5MYmVFkswzI+fbjn g==;
IronPort-SDR: LMPm/7vtDzhX5RAaeSw6yi2tp59UZ+sziHiLh5AGYgHJKgjtIsTvhGWXo7+WvLVwUvbvy0eMKP
 mkuN4kD69tX+cQMsf4UdXYbyWpIrmrboyBmWy8xhQJa9SGYfzOxWGivZ8G5qrMmy5qq7G890hG
 kEFvFGsHUWNpofYg1K8UNmArEAci7jXH1rEhK3Y0nDBCeZSAPWaia80r3n7p+dxCpZPxJcNp19
 iF873s9jvX5cKyCuNjTQE7WeCiQ37s8a/1R12AS1jLu1p4BYh6Jl8hTRAIEoNci2EI92jKgtPp
 pww=
X-IronPort-AV: E=Sophos;i="5.82,212,1613404800"; d="scan'208";a="164388708"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
 by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2021 04:15:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHP8w1tWCUwRrA3NEcbZkee82QpWKnqRhJdjQ5i253FbvjRsiIbkcgKkxZSncLNZKwArNwy92h4JPfulUwMsZ1A102u49u4UGYcBlkNM7BnIQoiDVX3lNb736X/zijAZcjxVzjh68pyam3odyFyJ6E1U7LgpbGbfPnT2Hr8AL+gfWP72trXm+Ejs2aFcCrqCHRGlWhyR0jRNM7sFnP/X2wnx2eifbTYP6dg2dkpwt/oW7YBtfv5+wdNcOefsLymQzCwUT8eGUEyRUOSCwPvUOzsh3FGtTYbfck9h7NNtyhqu/9UtmqWR4HbyuLh1V0VOlkUIvct5P3XmNlicEiSMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPndd08/TYYTKce+vNu3BcIEMj7Pvm+Gq5uHNF/laQk=;
 b=S11R7zkskcq25N4bNpSfCk/SAHEygUC68MOhrcwfP+j4WfHQCuQvFn1Z7SSfrOJhQzl3UOMrFSoSnVdVME6nxZQULvCJ5MQxcsvezpjVK6MSi1r8eO0G9zGO2AX7lYi9kKDseuRxIy7NjUHuWjaBlYJhxm3XRq2+CdOwKi8sDAMVOKYnUtjEGd+wMQFl49Wy93/YnI+lYlGPZ+l7f88Jj8sLjOBMAZiqrH4GRYXePE9UfErbtEO6QizGSOqz1Xhy0tchKZGMciiaZ0FWOhEtnxMbD1ZWndGhnHEW2WC95v/3gpS2IzVzJ7vueK1zlWgN8UfKfdhFjAVl9V4tmvv/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPndd08/TYYTKce+vNu3BcIEMj7Pvm+Gq5uHNF/laQk=;
 b=Q/LwA66cQY9eN53yBkFxZFt0kF0AsaZcdKi026gOoyq8KQ1y9OxkH9FgFTVakY8JHB3VH3A34rUSaqBgpiw21bRdGGuaemkzDi1f8DfymWeECFlNQH0YlNwBrWG2H+34+1oI5wsUW88W9AWPMNyrHfT1/ZJDnYMHi6y25ectmLk=
Received: from DM5PR04MB0684.namprd04.prod.outlook.com (2603:10b6:3:f3::20) by
 DM6PR04MB6379.namprd04.prod.outlook.com (2603:10b6:5:1ea::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16; Sat, 10 Apr 2021 20:15:43 +0000
Received: from DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf]) by DM5PR04MB0684.namprd04.prod.outlook.com
 ([fe80::9842:455e:f0d:a1bf%11]) with mapi id 15.20.4020.021; Sat, 10 Apr 2021
 20:15:43 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Niklas Cassel <Niklas.Cassel@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] nvme-pci: remove single trailing whitespace
Thread-Topic: [PATCH 1/3] nvme-pci: remove single trailing whitespace
Thread-Index: AQHXLkZIw1PYvCEwVE65aGcDiNBgdA==
Date: Sat, 10 Apr 2021 20:15:43 +0000
Message-ID: <20210410201445.53061-2-niklas.cassel@wdc.com>
References: <20210410201445.53061-1-niklas.cassel@wdc.com>
In-Reply-To: <20210410201445.53061-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a193224e-3328-461c-5701-08d8fc5d6b84
x-ms-traffictypediagnostic: DM6PR04MB6379:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6379293A892781B8654E9167F2729@DM6PR04MB6379.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K/DIdl2tWIDXPoEVzKfMYBwiFrzTpvCuenP/lTsP787jfyK5Czu4OUeUxx9ChDBFYeWG+MBteHZWzqurqc3E9drH2v4aemvfyIVngkBqMd55dp6hp2iDp5GLTd+EW7tj3E0SSVVmYTgzKWqx+aHrtHzpjG0b8N0yrZ/bmPfZxcxJ+LUT9WtKyXIwL6V1prulP8gcaqjp6qmgBJQV5CeNSv1kvSSnUvXiBFxnHwpVi8YzBQJ+s9ezQgqkwp/NqNeABQ7AujcB0J3Ia59ltuwAud+AAGCefXtZVDGmvLntK4zGRyKQTzovWF1tBoEACW+I86Do5pkPlu5Wwm8u6vFOXZYa82yMU90ewBLYa1sVdkjE9oRzHD3KubmKJiVFW61jMA3PACOr2ZSMcjXB181bzboPtCeC+Nqm0Qx6ivP9LBjEMuuxtmzZvUcqSACvN3TtufhvFnziZaEnCNa45dCxsx0ISPMlYsA/MqEQB+m4qDqjggOjyBs3ZMYIvnMzrkhlSRPXJYbKr1G0Cejs28/eQA3Ir4/BPy1HvSPxGHEYRRxR4cbcrk0YC7C/d0MQ3ig5+FrFD0YNhYFYSzHdK9UX1Zt5eDqIrUD14z1v6u83GHE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR04MB0684.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(66476007)(8936002)(64756008)(4744005)(66556008)(66446008)(66946007)(1076003)(76116006)(91956017)(71200400001)(5660300002)(2906002)(86362001)(36756003)(38100700002)(316002)(4326008)(8676002)(6512007)(26005)(186003)(2616005)(83380400001)(6486002)(110136005)(54906003)(6506007)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?kRAkcKo3jO90AgjwatzGLPrB5t7ATWPHOv9PS3PlNbIsrXrXLWhN5a6t3g?=
 =?iso-8859-1?Q?zDBkFkhOA8JKV87WfejuUyZHYHSGfKelA6uJ8qtSBAyzyNeZsxdZAUyQTZ?=
 =?iso-8859-1?Q?vTCwqQKer5lnvcASIb8et+gnGPn5rcwpknY0yw9ldPxKILV906FgJDX5qk?=
 =?iso-8859-1?Q?mMJkOr7UcxhG6w/u3IrPw2xfjafLx5zFwZQP+ksFRlRjqRaQAMLOhATzqD?=
 =?iso-8859-1?Q?b8D15Qjc2Un/3ReUAlU/OzKERe0q3aww1a6d82e0682Ak3SDN+9La2lmFJ?=
 =?iso-8859-1?Q?Ga+mkRLdQDl7rJfqUBMug6Oo5L9+SWKjMP2KNzK2gS/npcCC7OXpYxuiiB?=
 =?iso-8859-1?Q?Vz2LzBPmFxqZcsGeJtIHe790by0dCtEYAPUZ8KKNeEzLZHrH5nOWjkXIJz?=
 =?iso-8859-1?Q?KGmfGwenAUq7Ebhli1dJ2U1HxxMYgw1bl4+3h9EIPHDnWpoDi85pNj/xaI?=
 =?iso-8859-1?Q?CIH6y40IhQ6uy7jVqW7DieXPihJCrIuQwAclxBtaHrGAa6bACZc3a23IAp?=
 =?iso-8859-1?Q?bIHCuedoJcL0euYxuh78ieMtCpKEobuZDQNfPXfBmvueS0lvPF2t2cwjKz?=
 =?iso-8859-1?Q?cIcCs7BYFwJWV8dzXL96efv9sFZpsxzDtbLKcz9/xg8bg1MoO0Vmq/Y9gk?=
 =?iso-8859-1?Q?8ni1w0isxgXe/uCtZ9BDdJyvZcGkwTq5hxqJQaPMtbKSv74WFZhrHnGefC?=
 =?iso-8859-1?Q?Ub5PsB5Os9vYWq3xWuw99Yxqe9kXQ9EotAIzcnTeql2b4adfqkxY+pZ5Q8?=
 =?iso-8859-1?Q?Hz+YecnNc2q1fQVgx788IBcM4lEvO/I5tv8jH5/Rh1bmDthtMAD/dldo3h?=
 =?iso-8859-1?Q?cRDnfWfB2QP7gzdlCvy6lgq4L13VuSkkUdalq51rCZu4pNJvHq3Ss3RWxj?=
 =?iso-8859-1?Q?lPR+Fiyep5ZrGHQeP7L8t+9ZKhxOQVm+qRMof2/IqAp1CK/vxNFBiHSMHr?=
 =?iso-8859-1?Q?lFYaluFTb3I5/JJM91OGK1LA2gJJW5Tk33S2YqbB5sSwS34QA5k28Ik6uj?=
 =?iso-8859-1?Q?avFc3QhAgT73XHuJFi69gBzWH9f2n5vJBBY5jjihpsH7sOv1uL6P2ZofTm?=
 =?iso-8859-1?Q?JqMqWGGBibw6f4Gwnqcv+AmacI0gLJ6hY7bGvy5nccbkschahs1DxxdqBf?=
 =?iso-8859-1?Q?+NU3+dvPJ8Pszut/Wvp0yEN3IDAB+osiEJF7O9gwHShmS+H7CvGupdmmcy?=
 =?iso-8859-1?Q?npnK9ndvx2KSHlI3M35/4VWyBnI6RW+WfQ2uumtju/uMYTNqSyklXNlObs?=
 =?iso-8859-1?Q?bowX6ssVMr0JvUWlTp8JT0xRNVC9JllGS65eVPcmCh8UTSKXq9WOljKfXS?=
 =?iso-8859-1?Q?R4G4cwD1agzDmUeH32LIdpVQzh9KiFdA7VTDORVRf06GAOL/Mcr09klCsV?=
 =?iso-8859-1?Q?Zc2lSrpRxX?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR04MB0684.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a193224e-3328-461c-5701-08d8fc5d6b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2021 20:15:43.7728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NRe6bsumMWSZwDaAaG2xuPTw+UR0VuSBon7qD7uKG2zS6gNO7fBTTEtTE9zwqVV3Y05X0jxIHcPW1duGtLCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6379
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_131548_223828_07BD2204 
X-CRM114-Status: GOOD (  15.65  )
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

There is a single trailing whitespace in pci.c.
Since this is just a single whitespace, the chances of this affecting
backports to stable should be quite low, so let's just remove it.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b06e685d1250..09d4c5f99fc3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2172,7 +2172,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	if (nr_io_queues == 0)
 		return 0;
-	
+
 	clear_bit(NVMEQ_ENABLED, &adminq->flags);
 
 	if (dev->cmb_use_sqes) {
-- 
2.30.2

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
