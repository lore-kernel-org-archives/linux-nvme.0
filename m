Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C8FC3DA4A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Aug 2024 23:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=a1YAJLGvj93XPT+aOf9TKjiiUPhtA4SWQxPz3o631Jc=; b=vgBk00AvptE9OP
	AyCIsNeYR5ByQJdaQlJRLH0cIWw9EPq3h5Jw/2RYFVdeJHw923E1kIkoRMWLp5zqvC5xAkneAU/Ux
	EQgLMZl6vtKXVsKcHAHzzcSgCoGDURRlVcjOO/RKHSkdoACln+FPes2bTfp267MvvqC4W1r8NiBe8
	HzfXfarwGPB3lvKa84ZGaUXFSiDz9bDj3TGpcZ6xSS2tjEje49MmWpyDTGqEJfSQJPzJpnQFtOY+M
	ctuFjEqipZ5NRwLvdDGL2NLPjDj1gPcpaTO6lcpCT3Mp7YaSP8vao1Bg+kap9H5U1eH29TeMLi2kv
	kqugFwCsub++46fhipZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sb79X-0000000HZ4p-2LUy;
	Mon, 05 Aug 2024 23:30:11 +0000
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sb79U-0000000HZ3k-3Ayz
	for linux-nvme@lists.infradead.org;
	Mon, 05 Aug 2024 23:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QAC9ZnY1fuVFKuRn1cch3qRGMnO72G5Cxu9V8svorcInpPHJGb5pFfWAkO1hRbmUBx33pN8qepbiSU3ajlReXe2l+PLlHXGM8Czw8MXvZkRQyEHHkwX2jWXbHy2Ysuf9q19tn34+xTZkNIHzxN/JKwTbHtxJxb3M/DreORJ9StQCWlkhVd8/GjUMgZ+uZAtOj5M+ybxmTJBEpXI2DTVsdx5UY5grc8v2RnDGqjp5PKSTANr6yYb70HKRLcHtxdEowT85TXxG1Es4+Gr7DA/IuXYctktIsEMD4wKVbnVQZXpG87C82mkROYRy4/SEUztFHUGaut6zffwMFIPHys4Ehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1YAJLGvj93XPT+aOf9TKjiiUPhtA4SWQxPz3o631Jc=;
 b=KeS9eIiKvlowEjXIZsXVhpMYhxSpmndYLk0IMNUiZn/yaYBQUJ39j//472Fizwd4nvhxaw/+9k40LS2tzsjZHUW+jGE5vri1FhjOzeJ63wilXdRQOHEvqoH31/sytxDZ01nzB46pG9NprSGfHtQahVjqaI3Sxd55lq3+TF8lhB5uZj0X0IOMNt5tB+BmD7FeuBLArifxkl6QOIcEgYQx8tsOmTkHTJ7DVdUse61lxHQUx/g1Ac2S/Scn+0V6bs8niADcLFWvLuUYYJxXeJizxd/pfCg7GBjtLrWayewAJ21XHJv3z8lX0srOWkMMfFvG/O8K3/K1SnOxIsTKMyB2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1YAJLGvj93XPT+aOf9TKjiiUPhtA4SWQxPz3o631Jc=;
 b=InxXGml1wxXmNEc3538BCyLLMmaE2sH3J6a11O5FXDWucg2tpZFC4rcNwMYbDRGapRhefSp0peCAFtIz1nud6GDTTgv94deQW0xLssmFdYuM5eOAWi3kSt9BwIg8xv8IENVnMEFpSjftcNOEaVgZ/bLuvC1v8o4NnR94Y+W5u08=
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by SA1PR03MB6323.namprd03.prod.outlook.com (2603:10b6:806:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 23:30:03 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%5]) with mapi id 15.20.7807.026; Mon, 5 Aug 2024
 23:30:03 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Disk Says It is Full But There's Nothing on It
Thread-Topic: Disk Says It is Full But There's Nothing on It
Thread-Index: Adrnh75MzNJkXFWcSMupUSjuDERcWg==
Date: Mon, 5 Aug 2024 23:30:02 +0000
Message-ID: <SJ0PR03MB65014AE3AD77A352D0C88855FABE2@SJ0PR03MB6501.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|SA1PR03MB6323:EE_
x-ms-office365-filtering-correlation-id: a4e6656e-7547-484b-3eb3-08dcb5a687fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?v3BkLdbyBdG85rtXk9scKfnMzOSDJziDW2mY7qjF2Ty6FC1Rnx3zVadSjl?=
 =?iso-8859-1?Q?WyB9k5oU7mRSt487ZJCv3K/YsnQ/2MCNmze3BUhzSSVJUhEV+Rm5jK4wDt?=
 =?iso-8859-1?Q?adf8iyHrVDIJpnjS5zcXa4lONx0a5qMNPDaYwkEqyCmAVmu35CF+T8pnvR?=
 =?iso-8859-1?Q?EHRXOMmzituBqQraSESDY+8B43bD8cIZjdN+AuNwlBmTU2VAGsHVw4efzQ?=
 =?iso-8859-1?Q?+TEDC0GTAQXbzvluEX2XKhHIEvL8uzN6M/CdGG37iKJi4tx/PofCnE6Iyx?=
 =?iso-8859-1?Q?HHIjuFvYLwNHhOIK+0aeJNSIz31cM9SPK3w/NypsxDOJGiwgN9a4+6BwAn?=
 =?iso-8859-1?Q?mya6dhLyJVj9MQ4eN8hTJopELjbjOs0/GwyE5A0+jI2UcIBi3C6TDaO8Dd?=
 =?iso-8859-1?Q?4ETO3mpDbFWZ657rpyU6dn5iXdhijmpygP2FUQF2iOlgRDd10tGvoWiIJR?=
 =?iso-8859-1?Q?XtXrb4PCsnFbu95FMozdT2FamlB8/+rsyuHnvrfLbZwUEnpf/qYpi6fKOI?=
 =?iso-8859-1?Q?imjme5CV+Tr0x+Vo4MALeaGq0ZEYq7bbvHPIl2V1RyQxLa7Tt0LAIhz8no?=
 =?iso-8859-1?Q?WQiZ6Od/WGgfvPguA6UHGzCzi3aF3ftaiIPITXZwrI0c66zFCmNjl0FyJT?=
 =?iso-8859-1?Q?+tfiWpWua9YQoR3UJhW29IEJcsXGgjwv1tur6rnzYv5fSlWdLByRyCn8N7?=
 =?iso-8859-1?Q?olrE/34k0mmk09lsrpa6qxtYZ3eh7+sBxrlp54sGZa8cCf47BLf8DZm21/?=
 =?iso-8859-1?Q?VI8i6M2rNbtbQlz1rk5cQthnbpaiNJm9mKUeXg77MxHqHsHEZmYqO6kGXm?=
 =?iso-8859-1?Q?I0aL1+dBE4pHq/WvZCPOjcKA5atkrekySPXb6WjzPZZVTQ4l8kSLn1Tls3?=
 =?iso-8859-1?Q?rcUWMtgaMIIVx/35lbLAOneES2u9mLpcplSHIwIOpSVxfMEL9ooIWzq+yy?=
 =?iso-8859-1?Q?KxfiZVy2jokXEGMhnKbpueQPYSgp79x5vFst3VYt0XE1AmAEUZbfskPUqK?=
 =?iso-8859-1?Q?zicTHAkUY6eH6XHdg8uPnpqVx9/Em5lJGf5SlZHhS7UMVunV2ck3W5rSRM?=
 =?iso-8859-1?Q?/Nb73zcwvsBp0WImhJNrRIa5xUYgn6BHsMyHFmWcMmhalk7g6v9rn4RRI8?=
 =?iso-8859-1?Q?D8GelwG5O5Jcbad996n0y5PJ4aShseoby3jV2XLuOIQ91CPVx6ViAbaHoW?=
 =?iso-8859-1?Q?8vMdfp426GwXdkXx9uGqD3xk1eZoXQMrFi78KM3Vp3PHDIgVDB7aybrRg1?=
 =?iso-8859-1?Q?hiUQYW8y42MjkmMdbxTdrBbR/5fvphRi6tYdQdTi7+14i06iVgtrsJjmTX?=
 =?iso-8859-1?Q?6Ws74l32UuKVvblWAOGcJzDPbLBrUHaERvZjRKUX1MuFMmStYAadHG0y5s?=
 =?iso-8859-1?Q?ckB5g4GskxV82EXRzfBuEYqfoO0rfsMZ6J11BcTNVndNHTwVek+DYqR/OI?=
 =?iso-8859-1?Q?oCQN9diQXGA0zROhjzwB8bA67jgod2PFqlYbig=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AiXMwCXoKZp1tVGHAGuUmXziq8rD0foC5pydGDn2xqV8on9fra5LnlxZ8y?=
 =?iso-8859-1?Q?DMI1EF7AwOj1WZ31IxHx0XOFGOmSn6eQRUbJw+Ipq2DdrJ86XRTPXt05Rx?=
 =?iso-8859-1?Q?dw30PP77ezpTjweskqflRLvYBtQ0mbuySMljdNFCgqcxXU0qeiGqjqxjBb?=
 =?iso-8859-1?Q?almON1XAuc0xk7mwWhrHUzqVYt2/tvFzQOFCxNvOa8MKTJi+9ayNLw7/oe?=
 =?iso-8859-1?Q?nsifdujP66dMihRoTN4XXXDzat5MKzm09bBBh8pDy2Rd1VdqQ6pu0MDleW?=
 =?iso-8859-1?Q?feCaJ+zlfqCheg5rtOgWV5XTa6tqGTMDkOXkGD4zmALLM8LFt5/WVETkMv?=
 =?iso-8859-1?Q?fXBj27DY0jMmMPsLJgQvAZVS8sw4TPmToUl5fiGWbu80eddHJ6W6695SQR?=
 =?iso-8859-1?Q?hyLW4GYMmEdslXgQkElip9kX9sMaMAm5boHxArkAW7P2eanjlCZlCI/mqn?=
 =?iso-8859-1?Q?w4XA5Vnh8ST+rWgUrus8UhRwNlFn927uLaawRrJ3S89NJSI1NA/7y0peh7?=
 =?iso-8859-1?Q?569WkIwIfFVxMKSeg+Dwf8/waH2wlRWZd4KrJv5QVDLJysxHFmjI4D2Ram?=
 =?iso-8859-1?Q?wAefMivgNxisePq0vpP1+MfZyGMrcrz7AiIohAgTC0QzmRDuTKEDDW8iuX?=
 =?iso-8859-1?Q?CrS1Mus2aW5p+zE1ubHH/EBit7yxb/u4HN/YfNZKfkyC1XzVOmGzqI9wSc?=
 =?iso-8859-1?Q?NTRxR7wLaqM8bsm295THJ4HU8ljP9mlQ6/Z+Tl1K+mRI7EMiH6Wj5k9ejI?=
 =?iso-8859-1?Q?4Emy8NDYPiucmZ6LE2IiY5NggccRR78tpNau4R94Og2AiYQJBH5j1n6Nok?=
 =?iso-8859-1?Q?DJq7qNgE7rRoM3JUIZTKG9rsZD7xCEf5jVYxjs51Ty61iRNdNhRuYirhCT?=
 =?iso-8859-1?Q?hkhhdNLJ3NkCZKgqnJ3ahe/trJ9lCUEcw8EK5r48KOaA/OoyD2Wja8Y9ui?=
 =?iso-8859-1?Q?Rn4gKxKK5xFKrZhYC7wzrcY96YtdcqCdS9ZdYdpG0VUKizNNxMJB+eNJDQ?=
 =?iso-8859-1?Q?dps9B8v6DIdTGBUMM7CgqYZBUsxfvWQKrPEK1sOoU0cSW/Ch20F/WaHxsp?=
 =?iso-8859-1?Q?LiyQ6cQ+q16ez49iMG/xjHrhdfJ3fZeFEtW1JX8AE9nT5QotwtJTjCo868?=
 =?iso-8859-1?Q?VJKvbWKAqp/EyhWVO/AupLNytcYifj79G/jNBvdWxBrq2XNzrUvl0YWkwt?=
 =?iso-8859-1?Q?xjiIGAfoEjVfSAYKdjhSro9aCh4tDQ7MFvyWdbOa4ALLh0hKTuPB7G5MQh?=
 =?iso-8859-1?Q?pPL5aF458ZK/CebffYaw1+EXKTk5wanAFwTYe9/lwOJR9xITbaEcfA7M+w?=
 =?iso-8859-1?Q?5aSFWnEzuZMrYbpqazs1Dj/jV2btPi1XLFylC3PEqO9Y0RGBA1N3gsfpa2?=
 =?iso-8859-1?Q?nJ6XSoJOLqZID27FrA7F7wjvJaRqiGv8onh7iJ1TscA4FuYsGIK83mMtl4?=
 =?iso-8859-1?Q?F/azhsixuWNulu6f/XyottbIjFRsv1iX8ZM85IsI4eeHRoNtiGVCef6wEW?=
 =?iso-8859-1?Q?xXNPxnqXD8Z4KcJvgQWtBAPoeKxja+voYvaVi79xhZD3aY3ZUCRbPDtBzn?=
 =?iso-8859-1?Q?lUESL46vKynrzuwZu9wzTdsErUaapy9xcNSixFUIJKSMVMjzpdyxFO4C1u?=
 =?iso-8859-1?Q?MMkDGT9S5Vtk1ndeCVfqYgo/uvgXh6lJ1s?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e6656e-7547-484b-3eb3-08dcb5a687fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 23:30:03.0088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PXEefxXkbxsJZyHpq14ev6Z8BY2cBlyiPgeL8m0Ab9MSfetGx12uFOr3cg37zudx5TL7YUGYzQCIYVAj4grf0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240805_163008_847398_E58AA5FC 
X-CRM114-Status: UNSURE (   9.15  )
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

Two new Dell R640 servers, same OS and firmware.  One of the servers shows =
the drive usage correctly, as they don't have anything on them yet...

[root@store11a ~]# nvme list
Node                  Generic               SN                   Model     =
                               Namespace  Usage                      Format=
           FW Rev
--------------------- --------------------- -------------------- ----------=
------------------------------ ---------- -------------------------- ------=
---------- --------
/dev/nvme0n1          /dev/ng0n1            7170A00CTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.50  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme1n1          /dev/ng1n1            6240A0XMTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.49  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme2n1          /dev/ng2n1            6240A0T8TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.48  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme3n1          /dev/ng3n1            6240A1LRTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.48  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme4n1          /dev/ng4n1            6240A0XWTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.47  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme5n1          /dev/ng5n1            6240A0XZTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.47  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme6n1          /dev/ng6n1            6240A1H0TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.47  MB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme7n1          /dev/ng7n1            6240A0T4TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1          1.47  MB /  15.36  TB    512   =
B +  0 B   2.2.1

The other servers shows that the drives are completely full.

[root@store11c ~]# nvme list
Node                  Generic               SN                   Model     =
                               Namespace  Usage                      Format=
           FW Rev
--------------------- --------------------- -------------------- ----------=
------------------------------ ---------- -------------------------- ------=
---------- --------
/dev/nvme0n1          /dev/ng0n1            6240A0Y0TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme1n1          /dev/ng1n1            6240A0T2TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme2n1          /dev/ng2n1            6230A0N9TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme3n1          /dev/ng3n1            62D0A0FFTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme4n1          /dev/ng4n1            62D0A0FPTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme5n1          /dev/ng5n1            6240A0XNTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme6n1          /dev/ng6n1            6240A1BJTCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1
/dev/nvme7n1          /dev/ng7n1            6240A0Q4TCG8         Dell Ent N=
VMe CM6 RI 15.36TB             0x1         15.36  TB /  15.36  TB    512   =
B +  0 B   2.2.1

I have not been able to find any hidden partitions or data on the drives.

What's up with this?


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

