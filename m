Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12143C54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 17:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FoneoGeWQjA4wirG0/VyNsyRPfJLD13XyizJkRT/ZYo=; b=WkVT1slBDZvxPDgjJLNDc/lLTk
	FcQzmoduF279E1mvZAETTzJpxO3mMdnhNOWVEFkBypjHUfqt5FKxhokcVS/k3qQaF2JQGAuSMsbHM
	b6v8rQZGxRfVH0lRbZNbokILq5Q86LM94A2m0Oclx1xCurGxBNPnoaB/47VwHPQllyJVqYUH1QlNm
	WYCIMGtQ1JNmZJXvpJaS3s25LkqMpZLZM6xw6mqTSOYzDoLzgm3jex691/KYDYfkwsmeSh+X2bJvS
	v97dwowugD6AlYkiPFhbrrL7rawJVh6Wp1Si6xwodKrpdxtRBsSHDOZgipjK21QbulYhxFr5KeTIh
	RTlXQsiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhYup-0000000Ek7W-2udr;
	Tue, 05 Mar 2024 17:49:23 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhYuk-0000000Ek63-44JD
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 17:49:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/yORY2Qq9O9k2jdo83hs2pszW6nM40dlN8EsSHyl5GwUALhHhuaZntGspd60OkRJUe0iiWv62xmYhl1Z7MWcaHtpznPDI6ZVBL+PpSUdxdZKKvzAa/oVsUAJbhRpz/P7ERA8VqrMLW4zdZrParhEch6AC0wup8f3qYnVlqHO1UKS+oGbhoT5K6xRgQs1RH2+U7/62uMc8nHbVQwtAZ3V5cN+gfpdIcUKtCpYE+SaOM37cyrgMCIL+D61NIdfIKW/I4JXmVn09nW3jLtk/jaoqLka5g7i7aiHPFt2IHdGLW2DABRgtXaKEu1Iv9grPtEamAGFMu/FwP7hYEZDyxiow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FoneoGeWQjA4wirG0/VyNsyRPfJLD13XyizJkRT/ZYo=;
 b=oRVcirSZvo4+fx/bLvhXbhWMjSKkkmS3i0DM2kteSNuCaiBvuyIXtgngZR0afd6mrxxzKJNzX/0T5AzXTCVcGQJWhrjFZH4w7MsJWGxHRyrUBAVYDzKqDczuDQ6daG38Hfwcv1KAczjICLvW4Roi0Jx6BM+EqhhEri7j8y1LVaPXLNprPsovB87sk2iioofUR2pcuARb1qHZ7q/JoYEkLJwgpmxRCnZGNn3fiSWLJxsfgkPgrvcbV5XMWtYeCRB+I5rsC97WkI75AE7XNh6fxZIYnejomCQQOAyqk5bTAJdF+qczJTmI6Hf9mmJHteeAEr8AmuhTxsNmo8N44pOTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solidigm.com; dmarc=pass action=none header.from=solidigm.com;
 dkim=pass header.d=solidigm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FoneoGeWQjA4wirG0/VyNsyRPfJLD13XyizJkRT/ZYo=;
 b=Ha2YAEvzd+7YiiaK90aaNvUpHFOenFAtjwYxlXUyj3CImX8AVdyJ5bvkNjMUCqfx3r2/Jz/VudYM0/9VvC2JV+zc1mjH7OH93J8YvhWYRtDn9t+kS05g+qz+BVd9Og2GTywNYt6Mk8wogOPwJO6btK3L5ZMJBxqJgf0CAsbJGcrsTkWAUd5qQFxNqzl7VnUQYmDMeTdxCevLGj0G/B8hisiPR1CEhZr0PCwIJSkvxBtMC3OPB36y8LQr/QPhC+W9pLgIRljuXsi186LQJFQJCAngP0sNYzkdNBfCjAt3wQPpelYkrIyPdOw9qbu+IThih4TaEdhqIn/4TTTySnOabQ==
Received: from PH0PR10MB5419.namprd10.prod.outlook.com (2603:10b6:510:d6::15)
 by SJ2PR10MB7670.namprd10.prod.outlook.com (2603:10b6:a03:53b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 17:49:04 +0000
Received: from PH0PR10MB5419.namprd10.prod.outlook.com
 ([fe80::1f83:27ff:fc3:cc23]) by PH0PR10MB5419.namprd10.prod.outlook.com
 ([fe80::1f83:27ff:fc3:cc23%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:49:04 +0000
From: Michael Kropaczek <Michael.Kropaczek@solidigm.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Jens
 Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: RE: [PATCH v2 0/1] nvme: Fix problem when booting from NVMe drive was
 leading to a hang.
Thread-Topic: [PATCH v2 0/1] nvme: Fix problem when booting from NVMe drive
 was leading to a hang.
Thread-Index: AQHabmIuJ8tu3MKquEW4YvrqynBX+7EpK4sAgAAYTYCAACnNgA==
Date: Tue, 5 Mar 2024 17:49:04 +0000
Message-ID: <PH0PR10MB5419A3132379C33FB29FC34E92222@PH0PR10MB5419.namprd10.prod.outlook.com>
References: <20240304182507.2601387-1-michael.kropaczek@solidigm.com>
 <20240305135100.GC2063@lst.de>
 <Zec3p1bU_aTJJmF5@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Zec3p1bU_aTJJmF5@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ActionId=be143add-eb50-4626-bfd4-c1797aa2bcb4;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_ContentBits=0;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Enabled=true;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Method=Standard;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_Name=P2
 Confidential;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SetDate=2024-03-05T17:47:35Z;MSIP_Label_1a4d86c9-6ef8-4c81-b7a9-15a3140c062e_SiteId=4bb44aac-867a-4be0-aa34-30794e8470dd;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solidigm.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5419:EE_|SJ2PR10MB7670:EE_
x-ms-office365-filtering-correlation-id: 9e577e16-7553-4768-0fce-08dc3d3c8c63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3XX2AWDv19U0uXdvSxS6RVrS8UDS8yRwJBJj6kaJ/isHTpgOya/Tp/WRoChFWfPFAd7YE4+v3FG+J7wYio/GeUZQHJ8TgQDY8SrdR0NMZmYsU8uORIm/3bkHp0cTSkQsKyw5Zh+Ry5iEuBJziuLKVK00qS/HIKOGh2qw3/oWc1CLEIIaZCc5DA+3+WrH2wzyBWQWacSQw9k06RgBaW8gJncCd7RYR3zmAmPwG4zZC9nbM9nIgqhNAjIjT0mxKSUwViiRGiHB870GmrFrkDbNlEo4XHI9ro0FdpE/z9kUp9qcRxUQf+6dwqQ+ZsQ54OxZSNEy8IlDI7BeSZ82pW/X9WpPb35fOHLeFaP3L3YS+fpww6Q/wgTBSxe9yxYJZqkNUyBJawAi37c9a9jgQ4yAdDxI55rHMVE1pkRLoZBzsakPCfo4cb6KW1BU35JDW1smJ1N8l6FP/hDWmhVSk4YG0QIb9bm0w1d1Er6IZE8buWzPXWVy6Dy/RhVk1eRB0iLJjJOkd4Bml8RVD8PcLGERX0s/NUa+HbBppcNsDli6rtG0jw8d8Mm3p+9vP+6OYM4vtc8x2m7e6xKELsFTG/j+Ty0GpFwkv4JZqdQEKUMh+OFkLEK1y/EVajvoGa0Diothmoq8iEOwFYwJ8WQ8pQEJBSoyu7vzCb0WS2YqV2iurpkA5o1QzeX4eWMtigkF4GaSKlMVIEcItp3S76ZCNjRDUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5419.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yqp4HRC8DUNrHhVTOCpCJ+OnIFpmYW6oU23jQNdlr2tvGrPZV5knLk3DNJi0?=
 =?us-ascii?Q?3j2EY11Pcuzg5uIR80+zohI94Ttg1BH9OPEuV2zF7c0Saw+sQj5dszufnBxC?=
 =?us-ascii?Q?zpq/lhQV3nfSGPZQiHb6BjUKQxARQFh0IoCjkuuuQ1T4znq/76FSnbn6qmqs?=
 =?us-ascii?Q?GFuhrgT3qus8VNnNi+jYhi7Q3ahKqf1hz1Ohf+neaNb+p2teI6AtjsUOclRs?=
 =?us-ascii?Q?EzItmQ2B6baBHySfreLpt9+KpNuxPPvMTEhknG6Q8omONNMH8WWpoMq/EhPm?=
 =?us-ascii?Q?R2U90yWNgH4q2l9lLkPb5MMPRD2JuSrD3XxU4MpmWWaztQvW5GOcl+2HynxO?=
 =?us-ascii?Q?rrGkh9cDex7tMyoFrJLVXdSZ/9+d7QFLRqbZloSQE2RveoxR+ObMwBU1wXlH?=
 =?us-ascii?Q?0f/RhvTFjtUENYiC4o5tXqagZ+TcTzh5lsIDLuAXFwkpLMZE2GHrHjwWUfx0?=
 =?us-ascii?Q?iAvne7w3SG6V7YlGhKS7fNMU69hZm9OkC9H+oSEyqlvFaWqe1/IED1/TH4k3?=
 =?us-ascii?Q?Py5vYNJW1awt7imCWN18uf+TsNp5leYaG7749UfLyQDckRFVGX+VftCU+TWv?=
 =?us-ascii?Q?zJ6l7r9hcJYK11LjJBWxmGVhT3jDp5nTWM5jQIdBsVRKd3cee8E53Zcod8wm?=
 =?us-ascii?Q?9MxESImCQvaLs3jlGJ8jB1S/C9VYrhk+k3ZKi/WqG8GfZL/vj21VY++hU6oD?=
 =?us-ascii?Q?dka8Bu5YSbtsijZat2nYc05AtJHUGcaPZslJv5lwQhQ4YXWK+oZNvhnrLkZn?=
 =?us-ascii?Q?sgbuqTc5BZ+yAQBdPDCzSlt5eb0cAQ2rkvZzeXdPXLMuG3YDrxyGQFz/iZUw?=
 =?us-ascii?Q?d6jwwQd9a6vhiuPXtmKX+YaZCTETL2FTaFHyu1dpcmZvwuww6XPhE+KhxvZH?=
 =?us-ascii?Q?68KcwKGlpwpzUXJZo9oDoYNi7Ks8yC48huc6T26ucgoUS29P9vUgz7wJMSjK?=
 =?us-ascii?Q?bKkXg0CMM/K20+koPyZfgF5H6fjonEHmkHTcO6GLlHYsOcDDfuJJGa7CXeYp?=
 =?us-ascii?Q?1MA9Bfe5cIXIpiQdRbobbs/A94ANvRhP/fw+zwUQb0axZRzOOXEgcVJflDTp?=
 =?us-ascii?Q?A4FmSUkiM5/J8cO1JvMZJu/6eENpEILaTgK6JFzq+PFx9DNtEadp+ivJ+drQ?=
 =?us-ascii?Q?UAasL3x1kgLZYVyZpn2qqDNGN2hq+P4Cy004ZtEdSyAy0Q06dWAr8ECMiCmY?=
 =?us-ascii?Q?n1+KgiXsedPCjf8rKQPHslEC7DQbIZzMOYggxK2GdL49HXSlGm5ToDpOnQ9T?=
 =?us-ascii?Q?zBLSQ5Lb+SYgSbu5FsXTYMOVFAFBxvHsECY5MAXg/yl+ENQIfLT46jLdi1K0?=
 =?us-ascii?Q?UWbINCx9UmqA5VTEyjLOdBkD+0NZcHGgO8VZ4VwUXijWQG1lPWnY6SHO/l7y?=
 =?us-ascii?Q?pr4eD+ZHF7hGX5s4IXrOutfdqR4wiQYAVHc/1Ef/cEwP2gjdbvoWZpRWZzQw?=
 =?us-ascii?Q?y+DBS4+R6dsWVipnd957wwqn+Kdb9S1vV1N8VlHKVrCDVq0fl177O5DO+6Qg?=
 =?us-ascii?Q?DtXVohtR+EUKpdqKw5X6FP2fwHmgaNri71v9KwmAz7OXtDcErN9k8bxmbMqj?=
 =?us-ascii?Q?OudeifIjXggmI+usahEXTnFgqQ8gyWevZ4D/N5IvNG8w4gspLSwA88FlHoqT?=
 =?us-ascii?Q?QFV7HBnsF5dtULLlOHvCyGI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5419.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e577e16-7553-4768-0fce-08dc3d3c8c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 17:49:04.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DEtWKGmG9CeAuJFPbJwBPe4JVFNyTzg83zyJzu9VdQajhMDug/+KwhYtgmdwp+OQOGaKI/fTCnHbck6+Pbri5ZvwC2PgvNsxv4prk6v+O26qIQPMmZpe7V6I9Zkw/5DZ7Wdm/b40WtNuKQ1mQUeSLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7670
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_094919_091894_E5FD7C9E 
X-CRM114-Status: GOOD (  17.45  )
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

Thank you, Keith, Christoph,

The comment will be removed in the next version,

   Michael

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Tuesday, March 5, 2024 7:18 AM
To: Christoph Hellwig <hch@lst.de>
Cc: Michael Kropaczek <Michael.Kropaczek@solidigm.com>; linux-nvme@lists.in=
fradead.org; Jens Axboe <axboe@fb.com>; Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 0/1] nvme: Fix problem when booting from NVMe drive =
was leading to a hang.

Caution: External Email


On Tue, Mar 05, 2024 at 02:51:00PM +0100, Christoph Hellwig wrote:
> > +   /*
> > +    * On certain host architectures/HW, DRAM was keeping memory conten=
ts over reboot-cycles.
> > +    * It was observed that certain controllers were accessing host mem=
ory after
> > +    * resetting which led to undefined state preventing proper initial=
ization.
> > +    */
>
> Block comments should never span 80 characters.  But more importantly=20
> I don't even think we need this comment at all, this is a clear bug=20
> fix and the code is self-describing.

It sounds like a firmware bug. Spec says:

  "The host memory resources are not persistent in the controller across
   a reset event."

Exiting a shutdown state requires a CC.EN transition, which is a reset even=
t.

It still may be good practice for the host driver to explicitly disable hos=
t memory, but as I said last time, doing this in the shutdown path deadlock=
s if the drive fails to produce a response, which is why we removed it in t=
he first place.

