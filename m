Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54580C52D70
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fliBdiwsDzvE5whn9F1vj179m9uk5w4SqTsg684R048=; b=AEnOir1h5J0gKhMIdf4WC9X4bD
	kUAWQZ+KV4Anqu/f6XIh1L5syTURuxpcdMac6RjQjaR9Fhp0+q0eZxr4mZhhEZqZKnucCfIpOk9Dv
	aepRNKRzRBTv6g1icdk7f/eyaKr9IVOwchwX6DGYX4LgCxkCt1vCo9cbkXMG535JcGq4GnxNOkaoD
	Jk/XxA/wPyTZKqZcCcvpx9N4+ki12UPYfhPgv5Yn746juJEI0hb3nndeKxhNsbuoRKudc6wqO0whx
	b9nXRdYiEFcEsuxUJPfxYTqBI48T/oBc2YMJJtl12tcNsvlPqRB9PondOOsEX0+cgwmLzESOi9F9o
	by14S6Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJzy-00000001fdj-3wht;
	Tue, 06 Aug 2024 13:13:10 +0000
Received: from mail-bn8nam11on20712.outbound.protection.outlook.com ([2a01:111:f403:2414::712] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbJyK-00000001f1P-2iLe
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 13:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWM+n6N59YVooYCFza859znS9vQ1MbHSDe5nLGZA2oZyyXRie6bKtBGmYOpD77O253znuR1VeN2Q/sqvewa/F2AB1q4cDyetNAExm6UuGBgkj3Tk55XeJf7zXNS24WGalVNBe5EWt47rlUoNt5L3m0FODuhcW6y3q+P4pAU0622kyjFohFmZl9DybSUUf34+Lan1Ds9cJbtzDGHKH6PEiRwPHr14D2615xLywJeaJqmlvyv965brBrJKwvka90VcziXCbjGWj5g3dYl2565tg+oiHQxqfLoNAMngAJ9KR6BNGa5q75A+PguhyJxqCLsHiW5nygEO9WfHJWssawVlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fliBdiwsDzvE5whn9F1vj179m9uk5w4SqTsg684R048=;
 b=Vh7v0LpXjbtOAv1EoS9vz/lGdngEJoH2kg20XwbSnt3YDNT1Cutas4twatzi1oBVUI0tzET0XOc1QIkVYeyl6YYhwvR5WQJ3uyyxkMlgeX4HxYu34vw6LuqMNusGOs3aAGbcWvS2HapiC1cwRHCFF2TpZhAiNk1oi6Vg4s4mm8IECzC2g2PaT6SDQtgtZmXvz72ykDhz7VP0MQiFmAsFfhxcktfObzaqJIq7RDghBUbESvHiXtqEpOyJaoJwHk12DKU8V3s2ap3EBKmywlAeXRrvxaN4NLEZT/vnSOIkc1aZALvVkL/eOoK9kkK6ukBj2RTs4MuIr63S2qg1aCxTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fliBdiwsDzvE5whn9F1vj179m9uk5w4SqTsg684R048=;
 b=aY5twMxIZt0h/DXvOhCVYm6cQGQfY8Bw1R39z8FPuHczyHj4M9I8H/XtmEsLLdVDz9van9ec8Z9rsmelXPFwfw01qfHjt0nQW0Nng/t3r9duydlrOiyhIkCVbDrR5enjorvxrF67ILlL0uAmTlAtuaK6N2AAwXCRLKC0bIXEEzI=
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by SA0PR03MB5513.namprd03.prod.outlook.com (2603:10b6:806:b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 13:11:23 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%5]) with mapi id 15.20.7807.026; Tue, 6 Aug 2024
 13:11:23 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: Disk Says It is Full But There's Nothing on It
Thread-Topic: Disk Says It is Full But There's Nothing on It
Thread-Index: Adrnh75MzNJkXFWcSMupUSjuDERcWgAbfTgAAAMQYXA=
Date: Tue, 6 Aug 2024 13:11:23 +0000
Message-ID: <SJ0PR03MB65010C717291244293A88CAEFABF2@SJ0PR03MB6501.namprd03.prod.outlook.com>
References: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
In-Reply-To: <zsyfgzmoyvjgvywkbkgtxchpfei3pyfcaf2mzu4gltraf34ymx@vocftyxjmedn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|SA0PR03MB5513:EE_
x-ms-office365-filtering-correlation-id: bb920e54-e9cc-4033-6572-08dcb6194587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4pa+aTdUQrPLMyynYV1+CwFn5/z6gqS7aj8d7vXb6kUGIy3WiBCIaBuGYD/g?=
 =?us-ascii?Q?DiTI8mNcFxpiarKOITQcdD36Xf+oMrWGLNkziep7Lutt02ne9d7GWm3ctu43?=
 =?us-ascii?Q?ajpkvN3HX7GhTNN2aHX90xE617paBB0nRXVzvERyvEcOxdFLAZkcMNqxZ0RM?=
 =?us-ascii?Q?RcbGx1bqNUdwU7ZdOZXW+GrVQVNh5r9TFMLB9NdxxXxjWgyPu3l9byHy3IXn?=
 =?us-ascii?Q?1iEVNlNM2YqpSrjsRDxCenY422870LQHBEp145QhBvNF18rDPvqr/eog3C16?=
 =?us-ascii?Q?g17xNSmO/eouV6k8EK5qK0K15l8+ZMHcdR5fLA11KTkU2t0fidEZ6AzgbFLn?=
 =?us-ascii?Q?T68eAUuCC0gBnamM77ephB+3OItqEt0o16n5veHM9vgszzuENmi9uzV4htNR?=
 =?us-ascii?Q?ZQZ0e9VInZP9ZM73RlbOuu5hUm+EvwNiO6H2aU5wN0CUhvooPk3ek/ueJu9I?=
 =?us-ascii?Q?RItGx/f9pQnKI+Avw93B6mrxew4nvCOUywzVxER26sVz0AFKNp0pDuZSkv+w?=
 =?us-ascii?Q?px6r/Fq7NR04LV4eT+RbC5wYiMIWUi4gCUCfovM0B+RtH2Bb9mBhvQlx9w/s?=
 =?us-ascii?Q?QvhSDThnfwnEqqJNWlFQqf79eTru5+ojUrm1Iz7r3lbIi6vXRD0Usw2izBbQ?=
 =?us-ascii?Q?RvzBUHnpdIjX48BNGpPGgdhQBmxAfKgVAalpJfHnX41Nsj9NzAIvzqIqUmyq?=
 =?us-ascii?Q?OZ0/22LJZlJ+DjLnk8WvodrGvIc2KXypWQeE4w29JdTXV7rzzsqUtZ5SgJHi?=
 =?us-ascii?Q?3S4ZMyouz2xHEK1JP1f/qh0HDiCTeBPSREJRKpzMz3dKlFMwD6z4oZxdJNwL?=
 =?us-ascii?Q?K64EvflzXQTchRhg5m6TY88FHULgGQnSBlD2JRiIjo1B9neZzv1d/RwXkM3e?=
 =?us-ascii?Q?1yHpED7K4mIpNr05X0ynIxZle7z2AXi2BYBC/L2MqA/CsmdVfjoKfFDKhuJg?=
 =?us-ascii?Q?0MbwcPpDR14QA1O+pFCI7JSuxNlDjo4Mu71EbsxhirlPO4vXAU8M8H50H8g6?=
 =?us-ascii?Q?ETSAX+HAK0y2fDgZmmAXPuoufVPt3+38rW9bdzNBbYRC/zjQOqd14xtrKjHw?=
 =?us-ascii?Q?JNjBSXhY1KCdPdYjq0RQhleTjRaalisOh+m911E+XNQgITjShNraymc+x6qP?=
 =?us-ascii?Q?1sWlXKp3OgnmXotChN0/DBuU6S+nznXMGZ11oePC1GAgpWC6IykLJ8yT/AMx?=
 =?us-ascii?Q?K+nKK/p9U+8x3ye+OKh1ehDGsxPLpaact5L9FPgtuR85XPhbMRWaa/Cmz+eq?=
 =?us-ascii?Q?2FcVMUMfpuqnk/JE3wYnC9eMlEFN+YoEn5skzlBT2JhbgPOTJPY4XqBBMIbD?=
 =?us-ascii?Q?k3Y9BoZjHZKOTjYBq3c8K7RP4dRQ86kQV3/cfcUkEpRa1VGqOD/HXIKGRnug?=
 =?us-ascii?Q?0AvyEZYuiMYLd67gCPuW3jI08HqeYoVpjefh9HMl4GZ65uq8ZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SRL45z7yLDImFRsdCLVfCIigb1e5GG6z7OFB3xhBFTEYVCDbD1t4dis+yXmf?=
 =?us-ascii?Q?d4n0Z0CXS/1lIeKoePZcR3rWbgF8bdX5RCDrmAxqEwXOmtfbPcANElLKJihw?=
 =?us-ascii?Q?shrP+Mb4Tr2Vk3ykTriyK/G6BaMhncqu2mM7pbWHQEx3nuv265UieVJT0CsH?=
 =?us-ascii?Q?GSQXvmJLJ1+7yaXhWrIpx6QRUGhm5SCcNZcKypeAtdGYkGV2gpkvyYmzNUeS?=
 =?us-ascii?Q?CQfzZ6q1hKD+ANM8whyh8jaYmgKALqYL8bVlmvsagyJ/hIh1463KpoBN8GqF?=
 =?us-ascii?Q?szsZYZgRyBsNGkj3zQAdoNaRCk/psdhy/ToMPcb6mkSrSL5oMiKw0WE93nnW?=
 =?us-ascii?Q?FNo1l+tl3GZhS8PJ/iukxjm8dR7n+BXdjczDtYx3dHC03lRkHMjONo4qdOJu?=
 =?us-ascii?Q?NBWVeEVu11Wn0JiBJyPGvOvAmidfIKQwSqSYCyY28UZVS0n98KBgr/RCXri4?=
 =?us-ascii?Q?XDJAD2W5At1HYde2MvV20je1fZvAl3AXmK6bbDVJHGwZ6VNqY92k4tdP+dxa?=
 =?us-ascii?Q?w2g+tD25fD0SD0havmPrVcUArsWRIwFW7pTAu4QHnVbk2NMGtJKy9KnLIuAt?=
 =?us-ascii?Q?+ME9K0XQo/EYjmNykesllTnlZecAw5LDlSQI6MJR1fSnQX16L0246TIo7zg3?=
 =?us-ascii?Q?BLPQPKMbinTt0VerhrBZtlmiuDQ4MUIrYhA3R8iaAJS8l7eQ4dGoC7VMRTgb?=
 =?us-ascii?Q?oquU1RmruvvhN5qdv8bOpm6zPsdXS1E8YCFgcEa3ZHUpqZGCVNDAjcFnMXwz?=
 =?us-ascii?Q?wxV3cfDEWP/gZ7tUDQZIwsPT8PFROBI/h0STQTrhqtyfmqJ0PStSBWAfmyZa?=
 =?us-ascii?Q?Dlwx+8tBog/FdMagX5MBB9gBpYRmczOSQor6HTSHWgULZqWVG0kLt7hHmPId?=
 =?us-ascii?Q?95NvVPW8MzsbjJGCbF9qDQuhFHVfYNrj8Mm7+rZE+ZSldaCEw6M57j7vvXZL?=
 =?us-ascii?Q?gJ337wM/jLK3H5mi3lnAuVGKplAzExY00YBRxJtl/as+i/XRNVBEKbeGvkOr?=
 =?us-ascii?Q?VirYwb9mpk6amo/9I1hpDrjBeOZ7O2r5OAPurzPYLtjkFRi2ZvoVT6+Wlw14?=
 =?us-ascii?Q?kOuNcBNtIfaxS+owbHjs4iD3wLqXlET7tiaNc6K15u0T8SrZJ6nXKwIpp+cU?=
 =?us-ascii?Q?0MHQSPpMaiA/K31VCJuMkY5jmNpzq3dattkPN35CXTjLZ4HGS5NDM6pQ0lhJ?=
 =?us-ascii?Q?0TpEkPn/K7jXxKiPw5TtgM+aKbPY6qMoEi2+p4JdJ3Lsu+gUSJdzbvsdipqe?=
 =?us-ascii?Q?2YzT7kyYsYNH4IxUSiH7W/ztyjII+Y7OpY7awG9QJKLW9MqdVYszm7ZEkkBk?=
 =?us-ascii?Q?g0DqEowCLkXtEDh0/gajAECDZ4/cU0EcBHt4o8sEwfESkUFo946fkcfxZWVS?=
 =?us-ascii?Q?UTti0yY1tIGWnYSotlF6hu99x13vBXI4mljg2QX3iG5rV7Zk924lvEo9oDf2?=
 =?us-ascii?Q?CNoV9bdlbJpBhJ3NWO7EafOd23ugh54z1SCQe7Tzegzj7tq+EUQ6/vqDDisV?=
 =?us-ascii?Q?IodNE996E8MNFCgw4U8uESd6v5C/82bQIukEsuGPxCnOirWQQ3pm5+BFz8Qo?=
 =?us-ascii?Q?4jdlmPRLsfhLtsGdJ6D490VSkMgSPBco9xrfR4dE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb920e54-e9cc-4033-6572-08dcb6194587
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 13:11:23.6529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IbMbKAImezlTMJGSvIADu4nv5rrUBdf2eeKdOxyWXldVpbVYEs/k7YupgbxzpfX1a0ap3mPeyBE3XfFtDGZmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_061128_785447_79E9FAF2 
X-CRM114-Status: GOOD (  15.52  )
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
> From: Daniel Wagner <dwagner@suse.de>
> Sent: Tuesday, August 6, 2024 6:42 AM
> To: Eric Robinson <eric.robinson@psmnv.com>
> Cc: linux-nvme@lists.infradead.org
> Subject: Re: Disk Says It is Full But There's Nothing on It
>
> On Mon, Aug 05, 2024 at 11:30:02PM GMT, Eric Robinson wrote:
> > What's up with this?
>
> There was a bug in nvme-cli which got the usage sizes reporting wrong.
> Could you check with the lastest upstream version?

I was on 2.6.5. I upgraded to 2.9.1 but got the same result.

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

