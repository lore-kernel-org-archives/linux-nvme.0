Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7BBC3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 22:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x1m1LvhoUN7+l1ue6qt8OgKxODWRf0vIH+eB6T5wsAY=; b=Op9t51SbpMh0n2HCZ5VxBsKDbV
	hw0ocQvkzrRwDf/SoV3TIyg+fIAGVqAqHP5KLC1BHscXbIsH/cCxORKj+yFZsPjnuwLeL5a/eqoF5
	TvLJQyDwIxeMYpHkSrf5qPWx+lGwvOoMR++Tsi+driECnFW4QqFcZhrJ2GMlXuG0sfiichRB8xBQv
	rsCIG9twrXj19Dh++Gng1t4rojGAlkbUt89or7oBQeskpZC8woswUnuNIKC2y941ZF2cIyEwWmWWW
	otPnBGLdX/Z+cNVHSxSlfYNdqARnVIxrDYd6RpPiOwH17iM346zfgM8z4f7mgMIKAur2LfkNmkLIp
	eLiEG8DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDVrD-0000000520k-0urd;
	Fri, 09 May 2025 22:06:15 +0000
Received: from mail-dm6nam10on2070a.outbound.protection.outlook.com ([2a01:111:f403:2413::70a] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDVrA-00000005206-1KyP
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 22:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=migNGkV2jcXBldyLGDfRXZY529kDx7zGGHkhZcikWxlnxsrxR89bWLB0ugOc7v9stuC0ZfRV4i26T8UVVPhxo+Mfgmg1Vx0GnPBRxbdl0zAkN/HLKlf7Ci/QuctHxyOVW5heZN3tUt6apcBOPJp/EMA5Q8or0Lre9DzReThKywoZVA2qbZT79M6yJj3OU5vMZR8xddby3+7GwGCg57Kx44r454sLJwwCRmyynGWhyVgFEKii063w+gBgHLIp/vM716womr09dLcm/CP4sGC0FqTNaIX6dj3OkQkY+ovv+lspxOhqgCBjATlYwE8tOSvP8hGacCl+fBo4Zn0/gZzu+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1m1LvhoUN7+l1ue6qt8OgKxODWRf0vIH+eB6T5wsAY=;
 b=XYZ5XEVb/Srt4XjQmsxfnMMvj2OTrQVbfOmdappbVuK2G9Qg9p5Z50Sqfw+frZkql9cS6jPgsOPjVDaR+QMHAit7UrH+dGeYdPE1MplreJUH5QHKtvcSBCcZB7Bg85F9PQlgnnpqULhqlrREdCdI9bfk1GKDKR7qjuK/luzq4niISmbCTqdTidwXZfR5igO+FZUIqAUHQ22NuPTjs369UX1iUZzWRs7MZLh3KfIpH6PY+GBl9jLqmAlezTxQqYIsF2xamsmKcAcFpIcmLqzSx4ejIS9J0v1z7PaZAzGi5RCnJoI8Af8k+ErMASS2CKWLe620lVYj2LcL1PbnoUu8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psmnv.com; dmarc=pass action=none header.from=psmnv.com;
 dkim=pass header.d=psmnv.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psmnv.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1m1LvhoUN7+l1ue6qt8OgKxODWRf0vIH+eB6T5wsAY=;
 b=o4yLigekTrq9r5fupZAv8UHyQNp/ddgKsFa9hdS+FmsWQlRHiyENVHcmk8a5/z1yL9IcpVFnUyndaZgXyVqgk7X1LCVlKWhLP7KQaW9oCQ0HOJs9/pkT+CwX9ePLmMT42Nt9/3cl/AYXJwJl2dp6SHWyVTl/8O85G9pZpHZ+sSO5r57Vn4vJc7LjpAdFjMMMNnEbvozSC7+NeTI7r//pJZqI3Q+fj6GLBC6Ij3731DcQqv72ULEUXbyi6JLRC6eR+dppMLxsy19sG0rvqFAnVRBljqSYiRiZxXaM5AaeHrYdk+dPwZx33p3LxRLIzmFAfXGFCeOsQ+dIzqvprrw05w==
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18)
 by SA1PR03MB6418.namprd03.prod.outlook.com (2603:10b6:806:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 22:05:58 +0000
Received: from SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b]) by SJ0PR03MB6501.namprd03.prod.outlook.com
 ([fe80::520:c240:b60c:57b%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 22:05:58 +0000
From: Eric Robinson <eric.robinson@psmnv.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: 'nvme list' shows 100% usage on empty drives
Thread-Topic: 'nvme list' shows 100% usage on empty drives
Thread-Index: AdvA83kFx6m6RPjHS361DwMdkX+71AAHGrmAAAdhi8A=
Date: Fri, 9 May 2025 22:05:58 +0000
Message-ID: <SJ0PR03MB650108CF09FC9A51D35AE3D9FA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
References: <SJ0PR03MB65015EFAAC79F560121311CAFA8AA@SJ0PR03MB6501.namprd03.prod.outlook.com>
 <aB5I2UjeRiudiQnu@kbusch-mbp>
In-Reply-To: <aB5I2UjeRiudiQnu@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psmnv.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR03MB6501:EE_|SA1PR03MB6418:EE_
x-ms-office365-filtering-correlation-id: 428fe9ba-a54e-431b-8239-08dd8f45adce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ltH4cooboBAJGYL5XvR95nVOZ56DKcv41uuB3A3ZwHJnC1wuiLZFUsFJOqAF?=
 =?us-ascii?Q?MG5R1NZAVYulcuaH1EVUKaEbR6BusLeDXuNsJoaKArwnrkuWJjIup1bCGhn4?=
 =?us-ascii?Q?wWt4KZT5JXCU3Wff/JCifiyS8EFJ2nX7+1y/2SF5NHeL7YQ/IhNpB4LPegUM?=
 =?us-ascii?Q?U2pso+cnWR02ijugMri6+rgBOrufjUyj/y+5PoQuxrJElxbP/0mscC3AFB+9?=
 =?us-ascii?Q?6/pEJNJ/MWACpmXHVe1pbZfS/JsKST4eCz1E1lfqCcdzMvKsLXuCRn6pc0kX?=
 =?us-ascii?Q?elRdZpln9GDtblu6Cyx6lfR0jCnFI3bXPXRJtwgAkFKgrPtSilhbax5c6ZHf?=
 =?us-ascii?Q?MYG5MbAMZVsBaeNj61po84hy87YJ94gnrsWHWS88PB2m1aStsMxn+X8/mPnD?=
 =?us-ascii?Q?RTGf01O8814WbqSrg9N7eYP56sOo30UWIWeqvkHUUR1PAjYWwKg6ZC2ppIu8?=
 =?us-ascii?Q?rK7GS5pfI9bRltuW3KZMbyRUQeCNpYY/MnfBS6wC7b7Gwh8I1XVAtAyPkFlb?=
 =?us-ascii?Q?9eqEOiJTN86d6K0OUyi6xIgc7HKyOpbtSQmneEsnwH9NUCySjgAdWSjiqORQ?=
 =?us-ascii?Q?Mfbc33k3XUU9d0thrDN5kUBmCcUB31hJF04Q7KUN4wF7r4Qs8T+caEya4uNF?=
 =?us-ascii?Q?VEWNYq5cNupFF020qoLy7oLSbrQH0OoKRmR6RANac1EAl46/eKNhmgphSgJf?=
 =?us-ascii?Q?n67jqcfMKyXgKHpg1VlPSny8sGLh0iJT6ahFeb3dEJn9YucoamX/UqbVgAKc?=
 =?us-ascii?Q?feB65QGtGdZTa/E7lpsDTuFt5JRLB+Xk5hDhGJDbf6e90XZdPhyYj4E2rRQ+?=
 =?us-ascii?Q?DaH72fNuCB2orhs/xkdrOvceDLY0FTYWYpttYjlp5KqQBMSKCfpcCx9p1/Bb?=
 =?us-ascii?Q?5miduze7vttB7N41pBcvJPRuSxrKFeQn7gSPw1ZMhZZ6TtFxW2VgnoofD/59?=
 =?us-ascii?Q?j3+o5ZP+xAVEtsIWEgXngJDv7PE8Z4sWptD6z+7oyVKWkYOwFfWZs1shrj5I?=
 =?us-ascii?Q?fupvKoEy9Rdqaqub6mVrK9007U2t7vw0QHMLR5PN8/mf6B1MrLiW/sdwVKF9?=
 =?us-ascii?Q?ctx54w6ei9+MzyG76NIwKNiJQ6b4wlwANjBS/IXsOVOpggcm7KgZ3uGLCbAo?=
 =?us-ascii?Q?wN9Ue1sZA0zGVxkRLAlhvFQCxo/ibBIrIvMc3HvJvnPXQDngEZLf2iQ++hxS?=
 =?us-ascii?Q?cT2NnYYkjWCKkc5xBEjGiIeBuznxalifM4kvfCdskpMGmGR9Y2WynYGYvame?=
 =?us-ascii?Q?VVYMqeRoObOBzS/giCyQ5vgvQoM2E81TjN7CC3V0Jr/qDUX/kUFTGtlfjywx?=
 =?us-ascii?Q?jiVkdbYGmVuqEeepEh1mg2GYfzD4WwWyr0S5y6yFeXO8d7hIPzEVD7rbxzBO?=
 =?us-ascii?Q?zHiQyYBacNfXJY15uaG4NdQbKnFnZMvd/3AvtaKGwExOs3qox66NeOu434Wc?=
 =?us-ascii?Q?xdbz4ECWpAy2xrM4TdB7Lnb83JTwfGPu3zwRnRbTkjM6HUan+fUmHA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6501.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/JJxudL7FMP2cd40ktjzFtSGJgGeV/piGvuQek87APfDvNoN9gM6fLzwrvyT?=
 =?us-ascii?Q?InHAs+GXYDHK2TrctlpRbiOadOp4HGNervyaHxUraQcYfDGp4qZ5JdF7LlGA?=
 =?us-ascii?Q?giJNq/cc8S+9diJCPzZcXNkoNk2eY3OCBuh3ojlpe+O+fJWfZhEHd3cYK2VU?=
 =?us-ascii?Q?MAvlcrPkPfSjr9SupKhW0ZehMhHzYlSjX99aSdBR/sdba7coRP0wmED+O5Xg?=
 =?us-ascii?Q?uHhqxjzk6oYy71axW9F5a1/nujyoDnqLP544AA5BGSsqCVFWc00c3GMjE0cK?=
 =?us-ascii?Q?xAWLTa2x8NRQL6ES+ZuztOULcI2gDOLhDtFwJZfH+uHIuPO9eMEJfeueRBws?=
 =?us-ascii?Q?CqnYfekE0zEfbAmif9kQmvpCm5Fn/yYFO/8+PB5h2/ElJRjdDJUIl1v3BMfc?=
 =?us-ascii?Q?BHgWmLeenGa5QHEM9aexlVYnLMIZgaHY9OyujrqH0FovIZu5cWPdUy+8clhM?=
 =?us-ascii?Q?E/xIyXaDwEkNtmT79xbTgdBoO5Q/T5Ov9imxJOJDOzryjcP2USVLmG4nzymg?=
 =?us-ascii?Q?FgGObm8YaC0r9lPALUOiSm97c8qK53XQqIU2IWJ4EGXslLTpooxFXh9TYCoG?=
 =?us-ascii?Q?c10BwDu6rRM2Ym72QgR+BtKuZ+C1/FoGhbigd6fOL/bSOhrc9NUzYCyLnboD?=
 =?us-ascii?Q?VkaQXfyunS6ggxMgdDlBF3dzjWSiOId0VnWWMqIOAGGAOEiFycqLrOQGOJ7U?=
 =?us-ascii?Q?KdDqn8t5nGcDVhBX/U7KBqT0/DnCA0VR50j45tT9XWtj1phxbEF34dawOFm6?=
 =?us-ascii?Q?DZJ5ZfNDhjzXZ25uEsq7To4L2LX0InCSsz/X1RgI/wU7MqgL8aLxwMz98KD6?=
 =?us-ascii?Q?eYj6hdclZjluvmV8gCE8bQ5l3ZIZLuW4rw1NRGK+JKi6CIY+aVHFWw4Cv/WA?=
 =?us-ascii?Q?tAviqJyR7dY4T5IJC3bwjtv7t/wt7FI+IXCizECqmBERcbEADmfe1SX/9a/8?=
 =?us-ascii?Q?ZavpJ19ElgPTotFYGH3x60Eo4yciMuCs6VcE4T8Y2JMkslPQjmrlM3bKez6h?=
 =?us-ascii?Q?cxMngSPPkzVAKAxs7x1SBkjk82HxlIsK6bnZw/bC+MdWRx52+bE4ym5yzUJs?=
 =?us-ascii?Q?Am9hjgoGVGfhG60TBEF2nMNDamxA66NhD5cC4mT8wQNvi8fHb4XMjuuYkRw4?=
 =?us-ascii?Q?b1E08XQAH4+Cia6aScpDbWQwACcHzfPLfGqwHsASEz5k2MMJ1kxSfKDVLOIp?=
 =?us-ascii?Q?iVHXaIem9jFwI09eM+JyesnAcOpAfLKXiiMJ8WB/hC+Fa/CmYww/ln4+2JDZ?=
 =?us-ascii?Q?JF6+ctagDrj9xVrKZCXaHr8U9qwjCprQVRsYMQ6E3hbNi2tNnB637DdLWic9?=
 =?us-ascii?Q?f4Mxc94FvavBUDrqmBX4F7/zEOjo3Np60gkmKYyLQdqT2w8SHIc1wXYX4fpp?=
 =?us-ascii?Q?RdF594edzeGezATBVQ3caIa6l6ar/pM0//34EIaPeinQGsx7rVKJkLL1aWQC?=
 =?us-ascii?Q?vGV4ovdvz1zWZv197Jh9aozfYUNlArbtjiCTd9MPHI4kWnYl3b7U1vgf3xew?=
 =?us-ascii?Q?sK2Sft6hRx9T4ftAmkjTw+B+zTKlPJimIK71fVUrWqsOcFM3EqyLK3Ju+V+T?=
 =?us-ascii?Q?Y0NQAjTLfZaHb61Nn23ArwPcF/08X0g1hH0G/3cq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: psmnv.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6501.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428fe9ba-a54e-431b-8239-08dd8f45adce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 22:05:58.7665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41c01403-a265-4172-8028-7972e133fa87
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnN0OihnZnopxyCxwMhe0HDlEe6Ep4P68E1VR8jiyDmjO0hOb9gW2Xs7lzFSYrxrFsTEcQZHJv027Wk0MRvjNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6418
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_150612_386533_AA2F5074 
X-CRM114-Status: GOOD (  16.34  )
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

Keith,

Yours is the first coherent explanation we've heard. Thank you. The only th=
ing that concerns me is that we had this problem once before, about two yea=
rs ago, and I cannot find my notes about how I fixed it. I remember that I =
ran a command (maybe wipefs, fdisk, sedutil, or something similar) and it c=
orrected the problem. After running the command, I ran 'nvme list' multiple=
 times, and each time the "Used" amount kept going down, until it eventuall=
y stabilized at 4k. If the issue is with the controller, any idea what woul=
d account for that behavior?

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>
Sent: Friday, May 9, 2025 1:27 PM
To: Eric Robinson <eric.robinson@psmnv.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: 'nvme list' shows 100% usage on empty drives

On Fri, May 09, 2025 at 03:46:03PM +0000, Eric Robinson wrote:
> Why does 'nvme list' show drives as fully used when they are not? Note th=
at 4 of the drives show as fully used. These drives have been secure-erased=
.

The value here comes from your controller; "nvme list" is just the messenge=
r. The utilization is the Identify Namespace "NUSE" (Namespace
Utilization) field as reported by your controller.

The spec indicates this field is optional, section 2.1.1 of NVM Command Set=
 specification says: "the controller (...) may report a value in the Namesp=
ace Utilization field that is always equal to the value in the Namespace Ca=
pacity field." Sounds like your controller opted to use that behavior.
Disclaimer : This email and any files transmitted with it are confidential =
and intended solely for intended recipients. If you are not the named addre=
ssee you should not disseminate, distribute, copy or alter this email. Any =
views or opinions presented in this email are solely those of the author an=
d might not represent those of Physician Select Management. Warning: Althou=
gh Physician Select Management has taken reasonable precautions to ensure n=
o viruses are present in this email, the company cannot accept responsibili=
ty for any loss or damage arising from the use of this email or attachments=
.

