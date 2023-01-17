Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AE0C677F1
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 15:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=emAPgzDug1uDA4ncU27z5McMRQhJS0iuXplYCy2AXx0=; b=BBClPPWT+qnQSJOCQtkZFV88jx
	5HME0RcEzTDaqiGlHdEFKxAYObUwlHpof0WNxtaeMQ9Aa9jmrp4UVPPes1JWWLEcGcn/ycJWV0pDG
	oCT0WMuLSnLDcA29GwkWaWBMLxSQ2vgH6SZftitYF/GMuhsdCmLK1LLwIVDqm7bwZB1wW6i/3eslh
	auU5RZgfEhq/x7nx/wU+SgsM2G8NV3G7UIkEoDvOqFuRlH4lH6gFqze+iqKTMPUhv5b+2kbCIk//u
	jzz+0AvN2V3znv+za74MRG0FzmJ+ezTu565w++TVQD01kHNnQdqS3CQzuTJ8WNpIcGitJS17/ZMa2
	UpJo3seA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHntY-00EqCn-SA; Tue, 17 Jan 2023 15:29:04 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHntV-00EqAf-Hi; Tue, 17 Jan 2023 15:29:03 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HB5heU008865;
	Tue, 17 Jan 2023 10:28:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=emAPgzDug1uDA4ncU27z5McMRQhJS0iuXplYCy2AXx0=;
 b=EVYoheBPI3+PoTPyAuqZmVts9Zb2PxjL0M1Y27RDlaj5tT4p+FqtPKi6lg6rfWie/S2+
 77axhAbdaj/tgbVIX53u5lttEn8hJWrukLqrUVjUFUkQGJ/1dztzRB8ODzMe0HbWW7rb
 1Ft7GzrIAG/SR9TfWm+IgoKv/REQ9ZYY8zLO6XhQnYjoiwcnGW0k/oyQ2CJVP3pYtkj9
 XnGnkIBK/bXWHAmNcagh4dEMsrWAnPFY15rVKJ1rRAcDj/aFXNCKMWwtctJNDocHXsf/
 oeC5kOC6GKc7MZYZ/BjyxZfmaIC7lIs6O21vkQrsdvcJ39Um8Dke2lgntzRZGHX9tKnp Zg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3n3rb9vvcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Jan 2023 10:28:57 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HFPvH9023366;
	Tue, 17 Jan 2023 10:28:56 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3n5pxg74pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jan 2023 10:28:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bc1OSRIuKDByriYcLAU+3xMIrtOuNUYOgJ+vBX0R7A5jcMPy8FffM8XL4iOrSPpdwsfGbi22eGS9qNUjyC4AVNoq3krScyBxZu2qPkehA4w8yDkMcUn0+Xbl7CnhhHwgF/Lk21/nLjPnvjyYmGTNZcB/EqAAFnGh4Z/Z1bCgPULyukQj+2WNep4qpCcJKYHFP+isoqJx1MdSRuS63phyrNU5cYGQM8LdXbawh3xxss/gnCFgbzozUdAi+Zh3dXKqskVMGJO6oJhYPGmM+gdVTmVThOoslYrF6SwY6hY5cRhIo+AcOWL5525xTPfyDBs4WCLmjrggRsu7XXngTPxgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emAPgzDug1uDA4ncU27z5McMRQhJS0iuXplYCy2AXx0=;
 b=W4o9MOd0HFeeVXQMkT2bDgr3DzSyuVVTUbxHQFWuCeroZCeXTTUTEhVG1uioejZuP7cAQ9VLjKlWURWuQEl7C7drSUsqo5wYQ2U6CLwQNPqYCat49dDhwkUdRcHNLIrdM81fjjEj1ZE+MSD7V7lqTuiUuLN01z4+fltKiInNfNslfSpD9psucF1KbO5uP1UukgJ+76162kKmkRrwVcNqFE3/lqObL97ChaYH28Y+LdHwDBXh8+4YIfNvt88u9KnNZkQXkt/YrdDl5wGHeQAPOE94UWEa7LwPoo16JmuQV0bAlCrM0Ljv0d4jfsJKlmwtGdRuYGGTvl5Q6/IUA156JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BL1PR19MB5700.namprd19.prod.outlook.com (2603:10b6:208:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 15:28:51 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 15:28:51 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Hannes
 Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
        "smith, erik"
	<Erik.Smith@dell.com>,
        "Ghalam, Joe" <Joe.Ghalam@dell.com>,
        "Hayes, Stuart"
	<Stuart.Hayes@dell.com>,
        "White, Joseph L" <Joseph.L.White@dell.com>,
        "Glimcher, Boris" <Boris.Glimcher@dell.com>
Subject: RE: nvme-fabrics: devices are uninterruptable
Thread-Topic: nvme-fabrics: devices are uninterruptable
Thread-Index: Adklxcy5R0PWO5jhRLix9YacrkAbkgEm+loAAAjuQwA=
Date: Tue, 17 Jan 2023 15:28:51 +0000
Message-ID:  <SJ0PR19MB4544392AE4A95145CA2F98A0F2C69@SJ0PR19MB4544.namprd19.prod.outlook.com>
References:  <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
 <Y8Z9ypvhwFYUnqkp@infradead.org>
In-Reply-To: <Y8Z9ypvhwFYUnqkp@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-01-17T15:07:42Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=d6734fa1-8966-4d97-b5d8-a202c1ece581;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|BL1PR19MB5700:EE_
x-ms-office365-filtering-correlation-id: 12e36d6d-dcf9-4d3a-776c-08daf89f894d
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  tbJ2X4uDsA9q77kAU4qe9zYXaJgKs7cyJ9OS6WUD9IgdumZ3ec7L9chNID6MuapTVmkMD5gJPWh0k2y+/2JR7XenOlYEwP304jGQ28JlYL5Bjqmpx/3zmNnPr9QaZxZZHZjK8NtEVO1791GL4o4htuQxIPdPSw/Q+ncUESYHmguuVLS5Tpm1WZ+MbdlM7xEhodQqH4ijnQetbvg3X+0DdR7WZBDcGtVBrVEdkgJ0DHUXEpLF39AU6H6FAUa3/GIr9SQ7pd50C9olT71HhbkPTVQeAxsGD+b9aUVJcTeJ0mSFyjfJAIde6zO7KVQy9Uq38Vi2+YKGOC4nT9c295Z7Cfux1xq8++OKO2v87qZrM7RTILUDMUqXMM8oGe2S5o4iWYoxpYLF5tlg+ZQu3C4VncyC9kmmx5JkekziOaBZcTyBH5TK+PunRFYhdVEhF/3V4f+iIIbzYkeEO77SSA7gPUqS101wa0EQNC39i6WAE2KWk9Mw7+/8SG/T8oyegeMQneKhbQVRRtl0EQSv0FldARdGRzKQ5srBPACEH/whTqjL4l+vaQ+8r5M2cQxkeCCj6G0Rx0P86RQjbfGES7GcTgmTegAhoYti2+VYJzd3XDXT1D5xFGAgNCxPpfIU4omCs37XYPe3SlsAtrdmP232b5ta8o6+t//wzfkVUx5+K52cNr55UvDagTx40PgFgmmYqPwjw9eBaB5Gsg4z08uWGA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(38070700005)(86362001)(8936002)(8676002)(6916009)(4326008)(66446008)(52536014)(66556008)(66476007)(76116006)(64756008)(66946007)(2906002)(55016003)(5660300002)(38100700002)(82960400001)(83380400001)(122000001)(33656002)(478600001)(107886003)(71200400001)(7696005)(316002)(786003)(54906003)(41300700001)(26005)(9686003)(186003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?yMaPdoOsv2Dt5+8DwobGccGYxLxi4+B0DPuz4CVYtEdz1bw+1TBbDvA/DAS9?=
 =?us-ascii?Q?B9/hF0FF3aNW0FwNaaHefPh4EUllFe3eSkCFXkI8vn5wjd6GjQn3Iu2h4gli?=
 =?us-ascii?Q?FPQGr18+Tgz/lJyUS/1lJi6hQomleYcx1Y5+LDDK+5+s6WFXH84r9Jx712LJ?=
 =?us-ascii?Q?EzfwNBG/kYEcUBZ/nZBqY5wOp/9a8ZK5xmr7kse2T7NOLwKq0FJ2+r3Z32Tg?=
 =?us-ascii?Q?LiqZ8SjTTrmPHHmS+exAfvOieZLsdmcDvOA1y5PVcFEL1tHEDqoEtLkb8p+F?=
 =?us-ascii?Q?P1RhnaS865lQhPCJpvt7SxgWxWagwsgm2oAZ+BgKF9zsNOJ8S6FH/wb97Lik?=
 =?us-ascii?Q?Lxyzeiou1ZpVFyX1YOXwJMhr8KLviCwuM8uP+ElhAG2C4TmCD6IMhshTWcvp?=
 =?us-ascii?Q?L5bVVkcCG9WV9JrN9IGd1Tmw7UoPOaCy6ieTEcH1lFQ12GiWkKzsAANbuXZy?=
 =?us-ascii?Q?Cvbp1CeH7K9Jl3nnBdQZcrChX00OMkykYd7jJr5pLqoC8rmMPquqla9qYEqW?=
 =?us-ascii?Q?Tz0OIp3e3b1LSfTtbDO2iFLxN8+fZxKfu/ItIgb+0xyV2l82sR1Ycna/rH0Q?=
 =?us-ascii?Q?nzXAFbdVD9IGWBuBJOc6qP++HMCJwhKuEbO8h9OhlvOJd6T5dhJyM2R2eZVb?=
 =?us-ascii?Q?xUgccYL03ZZl9jy32cztYgYDOv/sRRD9ltQiHnSLvBhNGEEGVJ2YxtQ1vuMT?=
 =?us-ascii?Q?c4oUxJZt8XiDVeJSTpYkGU3iZLTaoLdnpDXl+0aBdheNFewvsOFcXQOA9t4J?=
 =?us-ascii?Q?zud9WtimGQ1+W7gukUSzQ0gBU07tdoc1oCpIIVJVwEvJnOSidEezXTKA2jD5?=
 =?us-ascii?Q?itsAkACpJhcsV4wEhMjfLR7iuU4aYuh5/zyYV5t4uobvQ7nVie5Nly+S8VBc?=
 =?us-ascii?Q?0Apj/ta3b+DewWFnTSB+YddzaztiGZ3/XXOoqdb7jIQg/qUHztwlxOoV4cY3?=
 =?us-ascii?Q?f/KnsFWnVUOXGMpVQ3496M/WAtmGA+KMhDzjU7uZRNfjsZ0YPvA8rQG/Asfk?=
 =?us-ascii?Q?OlnWVgG3H+kIimFI7K5mlAgNvACGQUHTAEx246ZvX8Tvj2c/vDElPdtqMBAw?=
 =?us-ascii?Q?PtsscGFKmPvV8SrK6UdJEw8aGOGOteQu6Nq/SFWCOLAe7LG5SKHKAXwV/lVI?=
 =?us-ascii?Q?KVVoZCQoEA+//Bu4e31SZLP+O/sspfCkkjjXg+NTkmVsJgbZHXpMG83rMMCZ?=
 =?us-ascii?Q?8gnCMHP9ZxjvuFtt6sZRzakCKhnTPFQ6NdIWUOP35DOJoDCOGAZ+hyaW9QKs?=
 =?us-ascii?Q?W6GeJqNlaTaXckfn1cVu3udKmoHIa5XKXoL/D1ATS5a0GZGNC4L8y6ohvmSx?=
 =?us-ascii?Q?8aCabbG1Hzc336ro5Xq90Kzkk9Etw4hARAPk874T4FvyiPI1tpDBe4fnXj04?=
 =?us-ascii?Q?1EKUaQZ6tyYuegC1wVUW96ftwt2W0Bpj81Q0n3JdiGTKEyoT9RjBnDyv5aKE?=
 =?us-ascii?Q?vzfl4SXmZf16g4O+v40W4ks98Git4U0eS6AVzlNuP7CohyHf/WjZppeR3Y/9?=
 =?us-ascii?Q?8U7tyymSdiimxAOctzjCYDyzqpvtL9jM9TkjdauZ+exYX08jnvPgi2P1UM2W?=
 =?us-ascii?Q?pXs3HPCAgt6UEfCXlwo1yCAIIigdNy2TiiA2PqhI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e36d6d-dcf9-4d3a-776c-08daf89f894d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 15:28:51.3078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O8Jm71TsL/IcmwyNinBhCTcXRhwZqWpjoNTIMBcBnbzUi9rOeltLzUBF2EhJPtu5CFz7RZ+KwB6AzOvRvrtYyJTzn9PoDLNR2t7t3RUHNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_06,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=382 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301170124
X-Proofpoint-GUID: T1oXVcs5AYOi4WxZjdJPWDQnv7aaD0Tp
X-Proofpoint-ORIG-GUID: T1oXVcs5AYOi4WxZjdJPWDQnv7aaD0Tp
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=467 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_072901_678887_BA20AA1A 
X-CRM114-Status: GOOD (  24.50  )
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

> On Wed, Jan 11, 2023 at 02:37:58PM +0000, Belanger, Martin wrote:
> > POSIX.1 specifies that certain functions such as read() or write() can =
act as
> cancellation points.
>=20
> device special files are mostly out of scope for the normal Posix rules..
>=20
> > I wanted to ask the community if there is a reason for the nvme driver =
to not
> support POSIX cancellation points? I also wanted to know whether it would=
 be
> possible to add support for it? Is there a downside to doing so?
>=20
> How do you propose to allow for safe interruption?

Hi Christoph,

Connection requests that are pending because the kernel is currently busy w=
orking on another connection request should be cancellable. I agree that on=
ce the kernel starts processing a connection request, then that connection =
request can no longer be cancelled. It would be too complex to cleanly inte=
rrupt a connection request midflight.

On the other hand, if the kernel allowed all the connection requests to be =
processed concurrently such that no connection request gets delayed by anot=
her one, then there would be no need for cancellation support.=20

This is only a problem when large numbers of connection requests are made a=
t the same time while there is connectivity issues. That's because a failin=
g connection blocks the /dev/nvme-fabrics interface for about 3 seconds. Fo=
r large numbers of failing connections the interface can block for long per=
iods of time (it only takes 20 failing connections to make the interface bu=
sy for a whole minute). Allowing multiple connection requests in parallel w=
ould reduce the amount of blocking since all the failing connection request=
s would not get in the way of the successful ones. It also means that all t=
he failing connection requests would be reported as failed more or less at =
the same after 3 seconds instead of being reported one at a time once every=
 3 seconds.

Regards,
Martin

