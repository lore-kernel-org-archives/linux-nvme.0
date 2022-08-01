Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7721C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n7GMfSDK9x3r6XtfiTLrSj1+B5v6nbjoVVVm9/qtILQ=; b=Uod+7vEykOZzpsrd3W4m1qKY+G
	K90cVdN8VK8hL9qirVMmkz8jr0hStXtco0izC62U0SDlH/MNGxVUnBc4RKzpgy4edRtecXXbC45Oq
	s4N8c8A6NKqQeZWWBHaQezdx6v5Vtv7VmnEmAjd6GStgVnG6YlurCt0GmLlRv38rorbV+yt+/WzBV
	bmi8RtPvV+fxMZHBbVXZMw12ZD3KWMXyMjMVHWgbETm0Q51vfnozt8ahBXZifAYBBIhKK4XRBsRza
	q/PhqijtF08jp2//dUMFQw+oXhWFh/rrI1lQIn7FAzA+JzWoYtrxS744kKLSDtGuBPqUKUsZBcce1
	eZeJfo6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaRF-009KRn-Ap; Mon, 01 Aug 2022 18:46:50 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaRA-009KMn-Vg; Mon, 01 Aug 2022 18:46:46 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271Dr2OQ022523;
	Mon, 1 Aug 2022 14:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=n7GMfSDK9x3r6XtfiTLrSj1+B5v6nbjoVVVm9/qtILQ=;
 b=eLg/vYOCVXqJ81nALcZAFRYqEPDbty6JP/pguCgZNRHJUcCB8tQMzl32Ai1Ud2wkmjP2
 qmNjGMnCnKMf47iugwS9YtCnH4CZPZwhXdlFtJzKldN0OymPN6gbxUHfm6X+0Hg5ZZLb
 PGNDlljMdNvhdLLOa/NVhMdlD+9FezQEYwL/sLcXsTpYhr43f4KSTufnY/y1XHcqHfhT
 iriau4t8kmxsokCJPQS9iW7zwJ4A5/7d64kxgEqQHhl6p9NhpNLc8YkcSH2JPg+mi9Ql
 2xvDfo/4IodcDisscAthYW99TGE9jWubux3ueOjO3HEwFOBKEm0WpWU0Pz1VHZuEBgtT 5Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3hn0g0esmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Aug 2022 14:46:37 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271IV3lj034764;
	Mon, 1 Aug 2022 14:46:37 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3hpcsx7uya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Aug 2022 14:46:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6S15Y+KE8AEcvE8yTfiY/DvIvoDHyqoxyDrhjyg70qXYN+56kqqv7g56QJY9A38fPW5uYRss1P8CilKlsDtUB1/nBYsm5UU+/0eN/CWSFJ2WPefjdWNHo+Rj/VroN+z2sdr8PglrZ+pw6k1MpvfbnuroI5Rn4LSOchzssFvGSRlNUc+Ot7mAkXFqzuGwH2iiyCFWHL+OBBZeJ9Lrs4uqJ+monl5IL7CGetFsrOJ/uHZrSHThotbTw5dxE4Z6qRMGf3Ks1LJJT9PNJHmx9P7n8WKaebLi2E2pzpDdYsrfQSnr61e6/RvZ16xdq63CMMT+7smr0t2GO+4GLYBQEqMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n7GMfSDK9x3r6XtfiTLrSj1+B5v6nbjoVVVm9/qtILQ=;
 b=Z1EYdQia/VmqqFmBCUReIyrhF4CYYtFU1/D4EI9u5Fk5HASv2pARpUsGX2MmCwmAohx2cCf4SsJAco9Mbhcf1MgDTOkFq3O1hSoJ8uJ8j2oApWR1/pPuA+59ZBaCg8DEKuQdQE4IHA0QjGkDJVUE+ECim4CNVBLAUFggST8akLgtagw/2cUOylZEf0oIX3sTWN8oW3gsFW22Gu3W6QtFmbrE471eH5NxFc3hgVgmtveuSnIlBjGFGtMWGHB7SXQQoRSkkS6Pi6+5cgO/xd+dCy9m/4cSkZu+Y8Wy9upzAGJdS9eiwIl7HSwPYJWOxNmc0zw0iwnYPSKS8n87K4+Atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MN2PR19MB3855.namprd19.prod.outlook.com (2603:10b6:208:1e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 18:46:34 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a98f:3e77:243b:d1b9]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::a98f:3e77:243b:d1b9%6]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 18:46:33 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH] fabrics: parse nvme connect Linux error codes
Thread-Topic: [PATCH] fabrics: parse nvme connect Linux error codes
Thread-Index: AQHYpdY2JNxC5WeOCk6tYxps1zdeOa2aYUSAgAAAetA=
Date: Mon, 1 Aug 2022 18:46:33 +0000
Message-ID:  <CO1PR19MB488583421E310A494F86C5AAEE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <20220801184039.17593-1-amit.engel@dell.com>
 <YugeneJZJ/ZWPTV3@infradead.org>
In-Reply-To: <YugeneJZJ/ZWPTV3@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-08-01T18:46:28Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=ac2d6714-e0bf-4df6-9a2f-12e80dad64ab;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1979b6f4-297d-463e-1d71-08da73ee27be
x-ms-traffictypediagnostic: MN2PR19MB3855:EE_
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  myjgjaVax7a0aNvLnyOVJuJsmTQslVYD9rp9DY9deIaeByyIVqTATs+cHgYUB86q73Cr1ygSdw47H9cDr33hUIn8EZaNdaIZ4hd4mfJzFzzntEwycsJuJGMq6wh/rHVSmiUNQLqHBdjgn30Rs4FY/WRcYcsfi6/ploMA22BqudzYeCROupNcvlPvZmF9DdbuWjxJSd0VLfl/EEYJm3dpSDPErnxKjFAzFYdk40W8Wm77IFJvQeJ5P5KjQu4XZQ1Oia49+dHy9QOtRcIZCUiVBzM5XNTBJurj67//zAiOcl/wo7BQUerOqtjCi4VDzNfacDJfx9YRudZBGv2g8icuTYIUp9dW4z2xrSfzC2EPLyrsMtm90jvOjujvWdTq3bZKy9+9hWMe46P0i07bpaEf+7fE2k5BuZ3ZGNi7qhwypfM0Nv+PsxRfp7UR46unGa5t1ZKjrx+xTMm3x/bBFyWv5rs7/s7fW+gY8/DdKk57Jp2nL5lfrvZz4BqLnSHQOOk44tbCDFlraKKWX0wacIk/pK/Lx8GmKRcJO0cEZwSZdhpfy+nTU6fM+voIZV7V/iOKWuivv7/m2YIPRnvsWq7aeEArWIZ//eNsHFUpeARlyhWfC/2YtdxmNCAhCRVEnEhezX75ovYGljNK9qz0sxvuVLbRuTSLs2xqU5JlIm75oFQ/ww49rNGr+pQiRZ1H/Yz8etBwG42YblIpx89aiVxJQJq7+uXBOgzMv9i/QSzyyJjAh6VfgAS2lOQ2giHkr37iG1IzS89uzsxKa17CJLyHfOZ9MKqvpvSL5Wodr43I8YW95cNG1pNFlTTi3H+wQNC3
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(8676002)(64756008)(4326008)(66446008)(66476007)(786003)(316002)(54906003)(8936002)(478600001)(6916009)(122000001)(66556008)(76116006)(66946007)(71200400001)(52536014)(4744005)(38100700002)(5660300002)(186003)(41300700001)(9686003)(53546011)(26005)(33656002)(2906002)(7696005)(6506007)(38070700005)(83380400001)(55016003)(82960400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?+F5va8HxtISrGJLhOj4AArAm5FTzWnQpEGiAqS7wLnf6a0b+JWaGICUNthvl?=
 =?us-ascii?Q?lGeVOPu1OqJPDGewjcO+g3uAM3v0ul+TDbCIqe+6e63mH8zYUiiByTX+ii1G?=
 =?us-ascii?Q?YS8gcFO5qSv1Iuuq2cTsKT3YD1+H4XNR8osZuGxU2gfb0i3aL6dVxPR0Q5M4?=
 =?us-ascii?Q?7e+kvdV4f2qsoRRjgj4y3w3y94qpMGRWqvMMjv2x9bTHTLONzjMpAS9bo2KB?=
 =?us-ascii?Q?bVG8jv3QbhVzb3g7XqHj06+0lyDc+1E4mwm51ycc0CeyDqdOGmkyo3f3paNI?=
 =?us-ascii?Q?iQmMmQ9B9Vs1dUwGuvENpozsrlli0P01AKQuiF1ClBfWtGrHyeoqBQcTe1oo?=
 =?us-ascii?Q?Cf0xlK+zfC2RkYx4qRuOz3l0OmlP322omUJ+nt+2V3qcktd0hWx7tuad0Fvf?=
 =?us-ascii?Q?2DFRc5Nu6OVI9QdYaD+3b4moLXVKbnHiRKnyL86NT1AAm9OSXi7q8jkUchXD?=
 =?us-ascii?Q?cLJ664RQxMgqhWpOBDwZv0ll1UsgFnhXoaCa2Q9ezywp0Vw2vl17uc/+5ZXq?=
 =?us-ascii?Q?ZFqGRPJQt3cmNgu24Sy+e/w42cAbHp01UUuzPX4lkx/Wiyy7nairewQDBJej?=
 =?us-ascii?Q?XBXSiKf4WILlkuxJ44qwiV6JxqrOyresr97wZUOhN5EfF7JssjVlk8Ufkhyx?=
 =?us-ascii?Q?9TGvRgrfsZ1JWAVln48bA7kLoZwYVY036RAF6qXF578y+S4w/NldK75spvLf?=
 =?us-ascii?Q?hF1tBLUbGLFq+Dfs1Sd+7JzxWrFxRP3YS3q0J7FfSiMthmRQDPlCiJ755NQw?=
 =?us-ascii?Q?6OsBp6jbsxkspdG0G+JPIYStJghr4R66es1kzXWSXueSQUvIU9S3fuM/AlVU?=
 =?us-ascii?Q?vYQJMU53HZzqBgEMJKujDsvGXYeTuCJ+d6JVg4pl8d2Zqgf/rPmzrsMh1pwy?=
 =?us-ascii?Q?J6XFjuKmXTL2U/xV2re2kFMPlyg0qzaKpYyTHT0pnXZF3ArcmQeTbgu+HJDh?=
 =?us-ascii?Q?Vgwkt+9Mr3HGOTxB6jEiSmK4bxUvnLe6NCbqXFWVjlZr4MWjYG4Zun9HHdRs?=
 =?us-ascii?Q?BlnS54WAJGpbOQH3rJ3WNIMLdKAzv4tdXIP9m4R1Xnz6MgfGkay1WxNc+mBQ?=
 =?us-ascii?Q?jhUPO/QnP2BLNztSAwONg8jSg8ajGzrdo+uGR0d2L+bfk2FJ8hcsY0i7e8Nu?=
 =?us-ascii?Q?MN8WPitH3nxicLhvYFgptC1XQqJQgxJpV74CWtA+153zyZ2+MuDWG10VOjER?=
 =?us-ascii?Q?sqhQ8ig2fsn4oLN8jtTaPLZpdflnSYOV44uQOQNEyz8Z4Slfoay/pDDz9VAT?=
 =?us-ascii?Q?0ZMsQ/E8U+Eo/2LYoh622vMvExhy8SiurPJ7eaf2U7kHWRi7TW117rRD7VTS?=
 =?us-ascii?Q?KQISipYKkDkP5PCHfOsVFThnCHBa+qzKpbPA79biS6tjmr11DO93JmpKs87H?=
 =?us-ascii?Q?BJKoJ3OiMB0W9f7/Pod7uTnjn8UGxfnzeFjEcWvpl5RJsgNbvebclvT+VpSj?=
 =?us-ascii?Q?FiVN5jMpa190wEC7JZeoEHkdl5SaiI+3euGupe/EdpQ4bB27iuVBb45ALb3B?=
 =?us-ascii?Q?b/R/RrGeNpZJZ/10M8nXo1l0O9FLZ2qx4ZHqbWyptKlSgY0A3CaifMS7PgBL?=
 =?us-ascii?Q?osWoHirdhfozNj/FJ5E5ETzw2xLHlgebw9HPAT4P?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1979b6f4-297d-463e-1d71-08da73ee27be
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 18:46:33.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nzgVj+bWD60BXlrSE2f2AxtEvBMZSiJuQSR//PsfVafw6OtV6bQ3fXqcd6cHBBb4XQtZ5A7jV/IskCx0I3J3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3855
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_08,2022-08-01_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2206140000 definitions=main-2208010093
X-Proofpoint-GUID: DAZdP6W-YtTv1_FFTUkrHxsbDDVv16SJ
X-Proofpoint-ORIG-GUID: DAZdP6W-YtTv1_FFTUkrHxsbDDVv16SJ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208010094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_114645_168423_572F2AFE 
X-CRM114-Status: GOOD (  16.30  )
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

Just wanted to stress the point that its not an nvme error but a Linux erro=
r.
But I'm fine with just say "error: %d"

Thanks
Amit


Internal Use - Confidential

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>=20
Sent: Monday, August 1, 2022 9:43 PM
To: Engel, Amit
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me; hch@infradead.org
Subject: Re: [PATCH] fabrics: parse nvme connect Linux error codes


[EXTERNAL EMAIL]=20

I'd drop the Linux error code and just say "error: %d", but otherwise this =
looks good to me.  If everyone agrees to one form or another of the message=
 I can fix it up when applying.

