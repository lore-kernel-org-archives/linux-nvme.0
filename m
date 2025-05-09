Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9211C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GK5qqRVbMcvB/brQMjStEH/NMLIHWsRNkzNOdSfPMYw=; b=LwcbY+FucEmGF4
	0m10tSqwe4lvLIhRtNo4y4Jr7Xyv2akuUNeoUCX9BPVpqWyYwg9GPDghW7j/2QVp1Hk5u83r5hiMs
	HVWEmFg2d4Z6xGrs7OUPvBlN/HqBv1TrtkAFB5Yq5IWihwFNSuJRVSnW2Y8bZUMIngRxfx43C1bXo
	4p9ue8gDkk2JB7NMxNVGe8CIEJs4jeUchyWXapm/Mpn5H+r0wg3en9gbwkgKc5aRMayRw8mUWuwIg
	jU+wLk7uQNhyMKCPCuu0AEBbyZk8JXbJOrmYgvDF6onOdf4HO6Zffr4o6Qr0ch7meIuL0OIzdGG2+
	ErA+YTQMA++8SAPqQ2NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRtE-00000004UhH-0rsF;
	Fri, 09 May 2025 17:52:04 +0000
Received: from mail-mw2nam04on20729.outbound.protection.outlook.com ([2a01:111:f403:240a::729] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDPvQ-000000049GI-2uAo
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 15:46:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzzFRv9HRKoZbRWZsuyR0yqECzVE45EoR+VO0czY/JLgFZacpdcEIB9zi8Sd1xKsuk89cqkEPqY2lYPNJysWq+MJSk2a7jZ/YSYKOeg7VsAPa7hdTFnUKPmbhCa3CfiMv/+oVJ8l/YWw6BU+RJDoyFI/QqayIm65ni4qLV9KkDhpZEsawdwfTYLznnD5ZgJjeUZLmrZ/u4NoN+cJ0wFziT9RJVLsZx0agK/ZcN97moRFFVkoDdkPJUaUgBpT3eM9KfTf0PrbqJtDKUIdYDlWZoaare5Ows5o/M1QVYL9+5GFPWSrkI8ol9Y0yAKXaj26h0/dPkFzXWeRO610OLxLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK5qqRVbMcvB/brQMjStEH/NMLIHWsRNkzNOdSfPMYw=;
 b=E5v0HkbfQUYxmG6FMedh6SVvPGAd0Gzvq32omaC80WJsr4bdg1OfoiY1kT7xDLky4fi5mvfO76/CmyLpkdmQ0fgSipv8KK4t0KUXiPUhp4KD97nmsUbHdp6JMk6KayexNCax9CiEE0pHr0dcwbmp368lZRqN+gcEGTIcRaOJXEr7jwi4CkQiYYwjY4nXKgDHSHfEjiky8TDSUQLP/CJoC58u5YCYBz/dZpmfxqRCTRXSVmI/FB3KalLcUaHyGwhtRLM6aKU0ETWLNe+Qt9YMTB+EBN8Gba0ITQwjrXFpaBeZQXqMCnQqYaznTVbU7bBCtOplfAZfFTo6CaGo2WcIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK5qqRVbMcvB/brQMjStEH/NMLIHWsRNkzNOdSfPMYw=;
 b=qwwtOeur8/YUxk34lRbaT1/bZjQVl8JGxg+0oGbdBXDzZc20dX5jupNhzS6E02ArtHpTgbIncbE21c6Lv4N6l0Db1rMUECkBFw9VbXQOl8h0gtaH1pn5ETSubfu8QnEEF47ZVPPu1rC7YG79br29+tEy984cwdPSMs0UmqyRJfeSFd0raT6CJasaXpzhqImVaAiBXEdjQ76mloJsl34Kc1kg4wPjqwS4zXo8A6zPvNTa4kD8bfuGiPqjIKGSVZfCOzGjFf+OuAFut5Ybyc2BqG4iJi57REhxd3q+59eGmj7OVXXxYsYPnq0HfHXHoG2sLc6CpBxoK/PDTdoFWqMzRw==
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by SA1PR03MB6369.namprd03.prod.outlook.com (2603:10b6:806:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 15:46:04 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 15:46:04 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: 'nvme list' shows 100% usage on empty drives
Thread-Topic: 'nvme list' shows 100% usage on empty drives
Thread-Index: AdvA83kFx6m6RPjHS361DwMdkX+71A==
Date: Fri, 9 May 2025 15:46:03 +0000
Message-ID: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|SA1PR03MB6369:EE_
x-ms-office365-filtering-correlation-id: 2ea0cc1c-ed87-4726-d950-08dd8f109b00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8Fb6PvogBNA/NzeuKApxlYTs0kmJXlpE2HYcFvocMzTm0yp71t0y0sEr69?=
 =?iso-8859-1?Q?i5UzoB5Td3Za5UamCZ8abl35Twxl64mgwF+nrWC8yL/Z/J6U6AoQpvvOPj?=
 =?iso-8859-1?Q?X7Ltte4uPnZPqB1IZ8pCo+ZXzca9qh/V09wvu2KFrMWm8ebvW7sNc4uwE7?=
 =?iso-8859-1?Q?PfR5vv+7CS9CLlM6c85UBQGuorfZEESO7Ief5QWeLVgkE9Dx8LWlm6PzTK?=
 =?iso-8859-1?Q?/M8YDMX/dvoryiU1xJeToz6yUQPc3YO84/oCo73Vrw0qnm8tQCmtyuJPe4?=
 =?iso-8859-1?Q?Bu4fHFPT21XpOoG8/P0Tt2KcIFkvPrz78tRepslkv6sBFIUhAovnH0U2E4?=
 =?iso-8859-1?Q?RQrfBuvLWQNoaoyWrYlAWodtxW0w6rLADO47xPSFcewJ4tx984uC+iZC3x?=
 =?iso-8859-1?Q?lN/lVpD3cdiUP0IspslnWmqBQxT2kQYP8bXQZ2IexUTH7GB6eLQydZHSQ/?=
 =?iso-8859-1?Q?fvP9t6LXMoKaoo8nTiWNjw3zdv2JltfptcaBWYINPw+N9ezyq/eFg08t1I?=
 =?iso-8859-1?Q?l00m1IQSOdrgOP41rB97XFsjxjAJFb5iAWq/+lBCahT+Lh2DFTdgHATLfG?=
 =?iso-8859-1?Q?uVJoE2A+AMSFO7e3o5Da7OuUakLLcQZaEuDfFsAUGGHm0ST4Vxro/5K4A/?=
 =?iso-8859-1?Q?6+3re/VkoctzZn9Tsr4RXds56N5ku/lHBWnMAhsDsc5KK54tS6DuNft0fF?=
 =?iso-8859-1?Q?SS4E7Cl88bPbAYHS91slaFRwGjREVBaKvMWNLy4hznxJZe9lm/N7eCso00?=
 =?iso-8859-1?Q?sUo1XQz6hwtkEeFwNGpqI+tkwIW5ToFJdbBDjcD9nZK93VEWdQq8mTEDAc?=
 =?iso-8859-1?Q?vkJZLgXooyjDmW28JF5SPBIZw/EUKY7IfScHIewCpbsvrlPCGmlHb7Eay2?=
 =?iso-8859-1?Q?veXUDDYAFlQaHD68LMy3OOyAbl99hNanuMMYNgVR0GFemB/LH06YmhPgnH?=
 =?iso-8859-1?Q?v/E/O6rJBYExS6tqU+RUFVhZ5g03mvuNtgbOa+vUKe05GM9lTwwHQLsKyx?=
 =?iso-8859-1?Q?XljXpjPaIfgShmPIkF/hli8jiX/ZFa2PEElYxM2Y3g2NJwgV/VJmp5coyJ?=
 =?iso-8859-1?Q?97hz5skclbzCkwllo1NGzHKveun8okce/fmHkKDMvUE806jQjODPnKWHa/?=
 =?iso-8859-1?Q?nrVnjzfje82NhM81kByochTRdRYm+luaIzgJ7uV+ce/QAkhJXVE8U7qCWs?=
 =?iso-8859-1?Q?U1TeFrgtZUBB/zXcW51+W3Rb6C/91RyaBZWZ6R4HCnGzkPugupEMqcBtUP?=
 =?iso-8859-1?Q?0kbQxCy2L6BCabGhJ9sdrDyFOwlRqeDXeYVzL5rxmFQ4mxSpwp24SkJgho?=
 =?iso-8859-1?Q?DEQ0YgTppAiFso8pB3ZPvprJj2zvRI6f/gTlSN4tNWPdGeoq3XiMjoELlJ?=
 =?iso-8859-1?Q?K2pCjjaF0g5LIzc6fzW18ij0A4/K3gTsvvPirjO1on98B6XOkOd5BjhfNU?=
 =?iso-8859-1?Q?Y5wvYhwA9jBWsB7COnhSP8cfSttpSpdJJFwb8Nt26K4+Q3rAW7GPEz+p5K?=
 =?iso-8859-1?Q?Q5G4OBcymSzMjKISgEQ8D2tN2t73ZevoQVhqz8jQsEbg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gKeYHRYmDjRCLbfg7BQa5IEnQdhDoIJWG/GRpUFyrlfm17tZqZXCnmROxx?=
 =?iso-8859-1?Q?3vx3B+TAFVNzo8kdkPE5EsMB7Nb0H17u5OUaaTi+XHtPxuLQ9lm0GhZS7u?=
 =?iso-8859-1?Q?atrSKpQZk7ooW9MMZeCkaf019o5Z9xMN5BAHtvJ2a70lcGjz6Kv3NoLLuT?=
 =?iso-8859-1?Q?XuHKIClfAPTUh353/SI4jqbiIqJxr6OUv9OzikICkftPjzlvcdUuOpghGQ?=
 =?iso-8859-1?Q?kAx2FVYxFW6tTzIEA5gd7stosL8BX6XLw0w4gZNnsRl9x23+c1Rz5yqb8a?=
 =?iso-8859-1?Q?j0JvPiJtf3fbnRFGw05HsynmosXKZYC2veoKKsQo7loxaUe4VtSnvyM1Zg?=
 =?iso-8859-1?Q?6TVg1GxW67S6vwbOHT+/Y9A8mSwgEa49uCUNnuDenvizw3qf1+77L+kMlS?=
 =?iso-8859-1?Q?+dBT8LUEEilBN7Zd03XNenUCsT9UVyjVYOfU51Cr5Kqdo7Nfju652jZmgI?=
 =?iso-8859-1?Q?BGaZ0/eLSMlPzrbc990RIBghVYFaegFB30Eav8HDLUe1Dy1qNmoSDDRpUJ?=
 =?iso-8859-1?Q?AVlrzdEheTqCbFMihOioeelY/PlhZcQd7Ml2Qd+VUbn3qa8sqaGaILV0rP?=
 =?iso-8859-1?Q?94FIYzUkga4YYldtGmgVqcliU8uaRAA/juCyQ01MaxX8UbEZiOEm08x8dE?=
 =?iso-8859-1?Q?1K+0KCb5f9NNKVK4/7FIasSaL/N/0iy22WSeULWHOTyMtRLmwwlBpnyxFs?=
 =?iso-8859-1?Q?MmY+W6Gdf53LDfT4985/NBUFculW8SHelDd4ZVuahy4qmQ5gLZdyXuo352?=
 =?iso-8859-1?Q?gtmC/EN+18T4WlllX0HhDeAF7CW78NLrcAFJDmzTa6Y9L73LLeSeC3BPMH?=
 =?iso-8859-1?Q?QGD3/1mvp6sUaxsIfrRepIUM4HmLwSpOf8kJcHD+towvH3MLZJwpsG6Zjh?=
 =?iso-8859-1?Q?CrvCUNzG7BaumRuRTPEX8Tid7ZqYmtMIjh1arleU28uE8TQNMKbOQC/5Ho?=
 =?iso-8859-1?Q?hkCQfeblkjyO1ogGPRo2yg3OSgGjKQsyDaC7k7xA60aeGR4HBYBSajFeqV?=
 =?iso-8859-1?Q?4MRtKZ57IZ/B+MupT1gr8Ryb8txrWVvFy/yIwIbi2sjeq8KJ7HLRBWrIQL?=
 =?iso-8859-1?Q?d/apDc+62NtnGZiWySASYSrX7zjx3isqk+YbW6Csu3S5WnauvoQyrBPXrY?=
 =?iso-8859-1?Q?H/SxFWCQRhZQRC2df0UzWgNV/9ssNnGUwUWXNh8cSIww2mqaISiAwwHXdy?=
 =?iso-8859-1?Q?ZAHZ9jqXuS+HfizLLEXikWMsrgU4RbbUTGVvK/gmj5OO6SKb5LkdFXg/sX?=
 =?iso-8859-1?Q?OWLw2HbhN58pRIaNbakY6hDKiXu33GTQenUOLZcu3/8jhcH7ofw4Lu8qvA?=
 =?iso-8859-1?Q?PRrVSVHHnP/thrtK97pFRTjs3F0m1Zzcv8MTDoEgk3ADoTZAgUi4PuCsch?=
 =?iso-8859-1?Q?8dlbUf2TExd/zIZlFxnsbfq50hzaUXR6wWWYBolxjPsW1pXSWzIdlC9efM?=
 =?iso-8859-1?Q?XDXdoZIIXZ8xs/tJhVXHvrRWD+dNBywq7CKnDo1o/8j+gZ3Y2xOMEkoRqO?=
 =?iso-8859-1?Q?/pC7mRAUePPphmNCUDWh0F7Qh6Ex/PQHrs3PSi+uUesDwD2pZ++XViglig?=
 =?iso-8859-1?Q?Jenf47tLtHBQVfNiNyftiuuMYLJIw+V4NduHWYuIVi0rRzViN9ckrPbQG1?=
 =?iso-8859-1?Q?4Rhx/YZpNFDZEVzGHtG4/EEXMwyK50OlkI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea0cc1c-ed87-4726-d950-08dd8f109b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 15:46:03.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z9fNLLC3n+7MUgmBcTbsZRkXm/tsoehD/1y3UJ14URzq1wcqpzvuCFFZaaol7Jm/HapSEhFUdiisnYfl4HgSIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6369
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_084612_729631_E29E5A59 
X-CRM114-Status: UNSURE (   8.06  )
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

Why does 'nvme list' show drives as fully used when they are not? Note that=
 4 of the drives show as fully used. These drives have been secure-erased.

[root@ha54b ~]# nvme list
Node                  Generic               SN                   Model     =
                               Namespace  Usage                      Format=
           FW Rev
--------------------- --------------------- -------------------- ----------=
------------------------------ ---------- -------------------------- ------=
---------- --------
/dev/nvme0n1          /dev/ng0n1            PHLN112302DB6P4CGN   Dell Expre=
ss Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512   =
B +  0 B   VDV1DP24
/dev/nvme1n1          /dev/ng1n1            42W0A02NTCA8         Dell Ent N=
VMe CM6 MU 6.4TB               0x1          4.10  kB /   6.40  TB    512   =
B +  0 B   2.1.8
/dev/nvme2n1          /dev/ng2n1            PHLN112201RM6P4CGN   Dell Expre=
ss Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512   =
B +  0 B   VDV1DP24
/dev/nvme3n1          /dev/ng3n1            PHLN112302BA6P4CGN   Dell Expre=
ss Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512   =
B +  0 B   VDV1DP24
/dev/nvme4n1          /dev/ng4n1            42W0A02STCA8         Dell Ent N=
VMe CM6 MU 6.4TB               0x1          4.10  kB /   6.40  TB    512   =
B +  0 B   2.1.8
/dev/nvme5n1          /dev/ng5n1            PHLN112302C16P4CGN   Dell Expre=
ss Flash NVMe P4610 6.4TB SFF  0x1          6.40  TB /   6.40  TB    512   =
B +  0 B   VDV1DP24

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

