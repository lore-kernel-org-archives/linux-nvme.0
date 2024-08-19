Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72066C3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Aug 2024 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mFRXVOs+28Fy9ygKSbfDHO2Tzbo4oktc2bbiT2hn8/k=; b=KrB2sqYX0IBRIO
	FTmInfQxZo8PW8CwEremSAip7uU2mvytc7ZD7VL/JzKjs7HDJrQEZyDv1ceNzY5QwyHYIrBXFE4Qq
	IVRetXmK49wQjykaKxmYEElWrmmwjyxZZLTqXlZxhZ8/F7BlTcJ/YBGcp1GFsrRs3ujYpxwXk9kax
	FlFCFGHKRN33+3OhzJYvA9LCh4DbYC5Ny+xYXYCz9jjmXSQTFgkFdse5/tKu5Dw/wzba/jWkWaF3M
	IcQqPQ8fUW4aU6muOm61Qb24SNAyYQFTKvOE34lNbkmBy5tCHs8iUKKMdDRe4Oc0je4S6TFQ/xovl
	mUzLg/emAeI9YYsb7vYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1nv-00000001TqT-0Rm2;
	Mon, 19 Aug 2024 12:48:11 +0000
Received: from mail-vi1eur05olkn20801.outbound.protection.outlook.com ([2a01:111:f403:2e13::801] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sg1ns-00000001TpE-18kb
	for linux-nvme@lists.infradead.org;
	Mon, 19 Aug 2024 12:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u34dKwut3MExAldxBUepCTLkzxm038h4q4Xm1xGqIW3iU8Bme0aBPQcTgLBVYoNdEO2CAGNboJQai8qQJmRBxCRnF/cGjUWDvWQIvCAXjyYnKuDr0H4Of7IwpM4ActXQ5Oiewjvtwd4M7+QGRqtqLiNwbOt7mZf1Kbbl/+XuKmjlNVdwWep5PzRuMBgcNzEpwfQ/9bFUEdCt042m7YsuHUozSJ1fSO2Cn7g6osUCWniV+tCXOqNTrgdAzhIISVQEw1xmMvyMZEj5gkH31jmHrFXEEMWxDP/7Ef6S15BL7rY84tQHeFCVKGlnvWDMyyASAbFhNS51WEtQaNO/DCyYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFRXVOs+28Fy9ygKSbfDHO2Tzbo4oktc2bbiT2hn8/k=;
 b=i3FVJHLQCYkWL313tl6XxGC2PhzSfs1J1F1qKptLb+DK+iGSNjwzUCIkQgM2KXI1F7wTEHlva0jf5BU66mdI7YL4hE/RwmDTX4tC6uxJS6BR0ON4bvMRy1WBGUYUXd9LJDeh26dzl2MWo3u1YFCWuiRvYAZfig0Tzt3y4GGxEyFU41XkFJAAGCWz4jHFqAnKEPbWsajyDKQBTS0QZ+ovl6+qMBnmThoNHGGTFPJpd/kwLZxumWJkf0zVBmwZWQ7WnYf1MPW2h+G3f4Xwy0JTQCSaM+W0R+nPLuXvyn96eECu8qE1Bg+jLEkOPtYzL60TF2UijFJvSU/LC2++3Er35w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFRXVOs+28Fy9ygKSbfDHO2Tzbo4oktc2bbiT2hn8/k=;
 b=oBU+5njGxebIEa/ntPMD/5qbfJBiKPR8TWcJRyCdGWAC0EQKgSyYv+5QSR1BRydKKab965dy9rm7hrxShphPUlheyhlhTIia3G0zM/tuehltoZRDz/KayvfkGt7FPs/ElGRyvF8SeQiJ0d9uj9yk5uWNo2klr4GHe0LPSfvKEtKrFOuOxL9n21iiEUgWllPLmBayaTLCNz9Y39Alau0gwSbp987lEwwdiF7XlHB1nnA8SGpz/JXb/V3y3PSdeIqPTAFItzlUktEJHA7gMjiezeLNn7R1Pp701H3rWIGlP+afxSIbTLujl5sKHefT0chY+zqsYmBlJPwIugza9A4TRg==
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:a1::5) by
 FRZP195MB2611.EURP195.PROD.OUTLOOK.COM (2603:10a6:d10:137::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 19 Aug 2024 12:48:00 +0000
Received: from GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f]) by GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
 ([fe80::d7e4:bae0:94b0:378f%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 12:48:00 +0000
From: Jigao LUO <jigao.luo@outlook.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [Question] IRQ Affinity Setup for NVMe over Fabrics (RDMA) Target and
 Host
Thread-Topic: [Question] IRQ Affinity Setup for NVMe over Fabrics (RDMA)
 Target and Host
Thread-Index: AQHa8jXrSR/u4BLl90K0kcgN6o2SzQ==
Date: Mon, 19 Aug 2024 12:48:00 +0000
Message-ID: <GV1P195MB2055FBE89BC74CF83305CF40EE8C2@GV1P195MB2055.EURP195.PROD.OUTLOOK.COM>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [OepJrQOlANrqBuqLHOLn02o0mymszhGKs7ka4mUyT1wsrYXsBdk88Der57I4qd28]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P195MB2055:EE_|FRZP195MB2611:EE_
x-ms-office365-filtering-correlation-id: dcebf73f-130b-479a-b0fd-08dcc04d2877
x-microsoft-antispam: BCL:0;ARA:14566002|15080799003|19110799003|15030799003|8060799006|461199028|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: eU7v1+J/xzWfa+ZiqeWcGeCjdtynXsY1jwBZKz08sj2ISdlTUmTkAF0NRcCw3VSyn7hHXuEAkKF64MYnwcwgMiCnTqgUuLMis1SPkoUlYv9m09hsyppttWVG1SghuQk+i+jhWLX4Yo0mUURwz+T/TTCrNO/NtbpUFUN8nWAPGz1coAdvjpcGYm6w4eY819MzNeZre4vkUw38lMSC6NGAg8g1N+rx5teYdpE5Kr8hEGbBnZXrufV1H9zrYXVsMYT72q9EjTaCS+ysPaz9DWW2lqy7R89IfFv2tlr12sLoQIaOA3XJfWd3IeZu9WP7mFVF6YFucAyvMYB1dR6HYx4NCGc0xJAJhMhWILH9k063gLT1QHrC+qsvYz1riANCoIx5liGDdtPEY+9EWl3mzGEfe284g3/NUE3BHO1MliMpHf4nf1g6tx6Jmz7Mtv/IrAG+j9jCB7rt26UdLqexlXema/sFV04jswdMiWZoybPSgro0UGtqixuyKzAMzd8QZ3x914kWgX06/RZ9fcyL4L3FdHojlNZ72hTT69Iy82/L/u93md6M8kef1ycDpd31seJ0Qb0qf0gwfih7rJYTAVpyRtQtLahpnBgOj8OztjS8dizcgrmEgaEicDRM5UH9XN63lb0/JirBN3oIIjMGp2gatSXSCn5zbidiMRZfrh09ii6M+HQm8xFpMY+0kvMtUbVK5PQ70cxHtrDleBUTOw/oNg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?DCawsHReTn5YHQik3nyTOQfiBDwSfgN0hY8RNaZz8Hk4XHcRMVbZ0aSa?=
 =?Windows-1252?Q?FakDfWK6IgL85U1KYr6BJ/vSBooC+OSYpwzQz2EXLO12fG0u8fXUhGyd?=
 =?Windows-1252?Q?zsFc3FZU4QmjoMH6yaZmJvM8BN6iqWMkM1HOdpI+PJmtuKfR5m8hAAPB?=
 =?Windows-1252?Q?tPbwmy7MdmwVMlvIIX2osLJljopMM37zmOlcwJKnyk138bFniCD0Kc4S?=
 =?Windows-1252?Q?cgFAyiLk0PAjFF4Y1BFRfcwG+iEwUMQqxdLBzitw2BDzHlFwmkf95TJB?=
 =?Windows-1252?Q?Rv1jQtkBJ3O+B/d+ObiFfkAjczVFiJ5RO8tT0z2jlL6b2+j7Dj80Ekf5?=
 =?Windows-1252?Q?xnmV6CtLQCnsFolCePD9ryUZa/xd0HP65F48Sy3f3iI/cv8IzyXkwzoY?=
 =?Windows-1252?Q?ZmRBGR3OK1OIUfpJDotXOlakl4YFYR3doV1Lgu6U0obM3IeRS6hAToL+?=
 =?Windows-1252?Q?7idg8268IlLAu9foaW6/nmkS1dmC0JUAZVxvcbfJzC7/S3UH+Yuq7lZ/?=
 =?Windows-1252?Q?TcHs32G6kBGdLs9Z9W2J/WpvCzJ/4YM6pGrTawHVBHlkmr81YCrSLcTL?=
 =?Windows-1252?Q?ZrXHXB67B99ViZeGAy71fiV+jM55Ji+hzWJR56I5rD425eNu/PgdmKdM?=
 =?Windows-1252?Q?W4i3+5aXblALsq0ojAGQrM9XdgpGdLxaaPPlQug32cn+/EvdsRjA/djL?=
 =?Windows-1252?Q?joopUDGCrMU7h6VNUltyk38nt/3S4egnYGMbUEQ4DCxzFdKlT0i+9+Zj?=
 =?Windows-1252?Q?wmkYGdEN3QRQ+8rAEdMOZDJj/+Gsxg7Wla6YQfTToVLpFDzW7/s2CVH/?=
 =?Windows-1252?Q?z0xey7Wb3ZCp0jxb4IQ0tNo9X3ScX40bPsnnlwvnAyvPVBEcMzUiosMt?=
 =?Windows-1252?Q?UwkdNmd9qCM/l0MxGBqiCfag58W+YuhsIdkS+P2vmiDH+CI52DJ3XBuR?=
 =?Windows-1252?Q?CKKlPsOJmalmlDocula5o6HYOkXsXvJclabwwqbOf9KmAaqsge/hHeTk?=
 =?Windows-1252?Q?Zlj7dmXlgsQmtle7qwKut87aY3WA3CkhC119VbQ8CGchuM0sXHF1j6vD?=
 =?Windows-1252?Q?XVavyk4zZxaRlFG6XwLXhQmek+OXZDW6DWDcVy4rQEldNJRSelTCaxHE?=
 =?Windows-1252?Q?tLsixZ/08yU0VuSS0v9cT4LI3J5O3N+mAZcVhPbNMeVn0ahgpwsgfFki?=
 =?Windows-1252?Q?5+v+JqoFQTzeOFWuGfwIrZhU0myvDV6yuMtC+HLXZlFjNcUHAEhq4kRk?=
 =?Windows-1252?Q?CNV4AftPEhVK5ASy6Yii8/HyQ8RGOr3MWzb4cTnjq5OXF3iUFMcNp4u3?=
 =?Windows-1252?Q?7lv2ErLe7zhHsvMOYhsvu/aRrxPXACjj/VIA/YbGs18BFrbeMAFK3Jvt?=
 =?Windows-1252?Q?syctcd0ZSWOpMoXLSTrwHLMHKrBh/S+pKAc=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P195MB2055.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dcebf73f-130b-479a-b0fd-08dcc04d2877
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 12:48:00.3284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZP195MB2611
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240819_054808_340226_ED95D1EA 
X-CRM114-Status: UNSURE (   7.91  )
X-CRM114-Notice: Please train this message.
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

Hi everyone,=0A=
I=92m currently benchmarking NVMe over Fabrics (RDMA) using the Linux kerne=
l driver and would appreciate your guidance on setting up IRQ affinity for =
optimal performance.=0A=
=0A=
- **Target Side**: It is logical to place both the NIC and SSDs within the =
same NUMA node to minimize latency, and to pin the IRQs to cores within thi=
s NUMA node. However, I'm unsure about the optimal number of cores that sho=
uld be dedicated to handling IRQs. Are there any guidelines or best practic=
es for determining this?=0A=
=0A=
- **Host Side**: Most of my questions relate to the host configuration. Ass=
uming we are running fio on the host, my understanding is that both fio and=
 IRQs should be on the NUMA node where the NIC is located. Should fio and I=
RQs share the same set of cores, or is it recommended to separate them with=
 two isolated core sets? Additionally, what would be the recommended number=
 of cores to allocate for IRQ handling in this scenario?=0A=
=0A=
I appreciate your assistance and look forward to your recommendations.=0A=
=0A=
Best regards,=0A=
Jigao=

