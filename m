Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E7EC433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:59:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EAFC601FC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 16:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EAFC601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mAQj5cej8mMfTf1UCR0FPvIQeDneyjI8fJXVuQbM3HM=; b=gg5VJ9FSbREyVoCcgRlA8JIgD
	IgUG43B3utpDCeCGA8VE/VkBmQK6tz7/6ReodZkocA+Tqnf3JAp0IOt2K+Wi6NZFrcsbWGK+NxLLp
	BMuFdao0fs91X4TPNTkup6luW4Q1bHOfmMJczhy6aiYu00lnajxf714fCas8nXV/I94WaD3yJWQ2z
	jnCf4KeXALnyROvFD+7nZY542SEvYL3jjxeHMVyupkicRsQVOfGnM4ZmLI8KO5BuVQpzZHiQMRIkw
	Y2rrLWb79HJozr3p5nk4sgfqc9jLNjWIPV/tOK/iQe7JJJN04rnOe64/So9FKBYkZ7uf/fvw5FN21
	vrfMUepWg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldbv3-00ESzu-0B; Mon, 03 May 2021 16:59:41 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbuy-00ESzn-5j
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 16:59:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=OKe1VeBPnW31tayeYtRJedAB2CHKRq1y2/9F3sFsaoQ=; b=UG1AwWcG3Yr7SUKpU8GMslHQ6L
 jicSzWtJnrIruSFsqVQj3o2/8GsmMcHoV4DAk8mmI4ym7o+LN+c+bfnIJcSDQLCzBFyhUYzv4aUdC
 Tu+7V5UJ7L7wwON5dXui024bW1eYN48+vVmTjCpSzBlhwdB87KQjh1hlm9mjo4lbLQmj7rcyftAi1
 ZWuNSySqrf9zXbZ3+ri+FnVu1qJoQ0ntvJA4GOfYq8nTS74815ZndlCyqqTkbAgdPomYbx4Bm+tYn
 zMJ0oBCWqJflbw1mwn6FpGQ6sxjLbyrQsZj2UqfrTMu+ch+oyXlwiSbQ5A8UEdjmQyjhv6Ynz+Gpy
 QI40vMhg==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldbut-003JOk-JY
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 16:59:34 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 143GwQuu002139; Mon, 3 May 2021 12:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=OKe1VeBPnW31tayeYtRJedAB2CHKRq1y2/9F3sFsaoQ=;
 b=aoYbkCkrik1eDiFtFUkuVjEzgARSxKi7OQnI8Tsu4aIobQ9tGayqTHPTKrMgVYw8NS4K
 kJ5Ei11mJgEi4wdQPqfzLWbulKHAzbSemVwILcKo4eZ3ChRGPGRMAn8lWlOO125RbGKY
 Mw7lEhEFIiKfce7eqAtY+a4h/fD6ESOk0VbLhve/61ClQg+gpCCdnhzH1BzdPeVyNGZb
 kv0g2O+C3NoRlk+mqsXbrJuCzmP8xlQ3+XGajgM1oj3o0GrlHwFFDLlrKThT424A/sEr
 DhzCkkXgw8+BFXbU3ws84tXgFgdlnSEpsKcfBaEm22MTjLkKdsfSRJ7Ms8QG1FuR/x6e ww== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 38924xn4wr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 May 2021 12:59:18 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 143GuKDj054810; Mon, 3 May 2021 12:59:12 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-00154901.pphosted.com with ESMTP id 389kyja752-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 03 May 2021 12:59:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtAZrpqcn/jtePwSDvM0yM+EWTb4AbnhR6zjvuRvFc7Xl3XEAMzi1vnjoaFFUl4G7o+YSPc2DlaozdboJ46ZpuxFwwTYufkOMRzsXCBkyMvYPNypNoPuiI5koZzrkCZmxPbi8RMf842BW2nntudI8/XGUERUFi8awGuSIOSmWk9WE7kqSCbGKsePR2Itz7xTitf04T34vguuIcS6+P+VvvQEGBmSE5Rz97G4r97KrB/w3c4ejUuK+v37QkWrputPMo8NEYHLBIZt1W9IJL9SYuf8EMDJJiI+atMSmwi6wXhTrAsXV1f4ummO4Q9jIqrJEQjZjy6iNpa8K6Cd0EZ1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKe1VeBPnW31tayeYtRJedAB2CHKRq1y2/9F3sFsaoQ=;
 b=Pn6Ue5ON0lUBvQorVUWO2Wyaqmx9zTA9sGaxX8iDX54ivfRvLWXi3ZcTvDq2PLQOsZ72mkuR97TqXfaOWNORyy0nlH7XmoZiwdzpuLSuIZ4dS3a+C3030ecYU9u2twLMHhEaAHAz8bX4GqOhvO/mGffJWkamill4S/4mOuHW68aU87TEx4T3dSeGMXVGUVUwgRexFp0hgMd2DskfOHsC36Rt+xAO7Cagrz+S9Jox0KSLlkwowwGZTv1H419WWv6iNQ5Mi+ENjby8NwRJ3OMXKvq58SIgS61IPLh7lXQp7arMe9PUZmmbNTMzx/LePHCMHKPIEQkv/HHR0muLsmTeIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SJ0PR19MB4525.namprd19.prod.outlook.com (2603:10b6:a03:283::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.26; Mon, 3 May
 2021 16:59:10 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::6d24:c151:2746:4ba6%2]) with mapi id 15.20.4087.043; Mon, 3 May 2021
 16:59:10 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
Thread-Topic: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection.
 The driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
Thread-Index: AQHXMi3Bh57r8OJ1AEy+hCu2vgTdtarOl4SAgAN88A0=
Date: Mon, 3 May 2021 16:59:10 +0000
Message-ID: <SJ0PR19MB454486D08CA07BCE274966E6F25B9@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>,
 <11e71590-de9b-7eca-7d10-bbd3600d650c@suse.de>
In-Reply-To: <11e71590-de9b-7eca-7d10-bbd3600d650c@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Enabled=True;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_SetDate=2021-05-03T16:59:10.113Z;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Name=Public;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_ContentBits=0;
 MSIP_Label_34759c52-a6db-4813-b00f-5ea20e29646d_Method=Privileged; 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c63789f-2d47-48a9-d3c3-08d90e54c5ba
x-ms-traffictypediagnostic: SJ0PR19MB4525:
x-microsoft-antispam-prvs: <SJ0PR19MB4525BA5B8378ED9E96304527F25B9@SJ0PR19MB4525.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zr5UwKFJP7UfUDr/dN+Ud92g9L5T6RClJo963+Go/okr+wBrnIw2wwd8ugd31UhaFspv+i+skaPVActBlPmIurXzDTzlkEV0Ond9NKdd1zKOMHikcpkOlq3WaSfEDVYEdraOePqP0VOPvEYOWx7CdR4rtq0wwjiPJv7i+5Q+TprnuOjo4sWr5Z3p60FfQM6W7Smqy+zTXmUQLMtUs2I07zSjTM21+qSOcNPlICTye+yAY46EM1Wbe8hoMDykbKAbYQXvHALut3PYUBkwIZJ0e1q7/Y5Gs7Qb7vjA0H2MZZoGOFp1jxy19QUzTzs28H00uNR2HPOmm8+OiP3Gx7OnTFQEZJLKKJy78JeKdAVPQVgg9z4Hm2kTLUx3rhpDnvzMnEPAVvUSKX+56gXqt4dAFd26W4VdJ1KQH1MC+LGZsTcXXunie3cf2HAbvV406B6Y2c7lcH2ZMFh0OxM6hhPby59EVh/Q06KevcV3iga/MSZfORM5Yrenrv6QPx5DiJ9McFb6t2x9bvE6DJAmFBkLEEesqBZ79aaPZDTHcqQ/7CpujcmpwOGv1RcaYIvk0ONAIqjBhHkKUcFpwJY15M3z+Y8y3odplIXEnoHW3Y17aHE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(478600001)(186003)(2906002)(71200400001)(26005)(4326008)(33656002)(5660300002)(55016002)(66946007)(9686003)(8676002)(86362001)(52536014)(316002)(8936002)(122000001)(38100700002)(53546011)(66574015)(66476007)(66446008)(786003)(66556008)(64756008)(110136005)(54906003)(76116006)(6506007)(91956017)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9NofpbfRbBye3vD1lds/sIsjHjsNzpnJGPNNJR6y8kN0v3Ny4n3t7pAXal?=
 =?iso-8859-1?Q?0JBtcWTP8v/18XeEiDIdaBysLNIb2o5+BC3KJTbq3C/FzsIyO4dCVx9dt1?=
 =?iso-8859-1?Q?mn5P0XleVnAKWhDs9RIBtxxX3fmkpvzfarCKevpBArE1g0ehqgsu6Vuzvk?=
 =?iso-8859-1?Q?PHn/Cy4B/3XuJlUxM6bzrKDgb48Dd8bcd2qI/dNOd/lUsam9B0MQlEKi3R?=
 =?iso-8859-1?Q?qrHfoB8WmW+wsvGMeVRN1HfINgqu3Ry9b+BC0NvFWGi2gbTf1gmqrGOwAo?=
 =?iso-8859-1?Q?shgtQCeeLjqu2Zq1Xk99GGeDrZn8QbgmGy9s53hPVQIssYxCmqCr075vnz?=
 =?iso-8859-1?Q?JTsXkBKa9ROcZ62mt1mQeoug/Id+XTTi3w0sYHgfs3AWgKZ0rBKoPPYwkQ?=
 =?iso-8859-1?Q?fvYKfxyic9L7W5MHTkdh9ZuUOF7TBfMpikcYTbtCiuzOqe0Jws6GJgy0Qk?=
 =?iso-8859-1?Q?bOaS4H2HgFoTuuPdCAIC3+V51o6KWGW/q/+3RQ/XaOZIOqBmfDhuqxrugK?=
 =?iso-8859-1?Q?2zC1EMezChsHcD6yuz2UFDLEMHmo9TpnYsH2UHHF33U0/kBoHPX9PZJ1hl?=
 =?iso-8859-1?Q?5F3w+xS6Ds7FG5WUc0vP36IfrMky145zKLR8/nbWMQtN0BMsXolEa/46KQ?=
 =?iso-8859-1?Q?4hfJxDDpK1+7ms3wqPNg1oVhPw4+cu4VVX6Xi1ORKvo4N8XpZeQcVKDfo9?=
 =?iso-8859-1?Q?mM8/1w/mwm00RcztFdxh4QkTWQ6XWwceMokOcUVyvEMtx/5B7In94KwKqL?=
 =?iso-8859-1?Q?Vhp8OqfcxR38qhfOmWRfNnAXafpfNBdYBXz4VopluDmp8EOl5mARAxputv?=
 =?iso-8859-1?Q?8ak4/bG1gwzF+Spo55BI8my60Wuymw2wiCpdXru0dHeoJPxMRciVUqMnfi?=
 =?iso-8859-1?Q?EyjdLnNGqrIcidPrrK0iXXGt8njID3kJ0wrAW4CFBKqI+Srpiu9oHf+1qQ?=
 =?iso-8859-1?Q?n7RA5EOXU6ozwIGJlznLmLHCXq5zsX9/U0RSNoeNzkyxs42VhknDhHFl40?=
 =?iso-8859-1?Q?EhvVamJXSER7jP3cgvg4z9s5NDo9lvcSA9trctPRzNB8P5BrjQcab8MVcH?=
 =?iso-8859-1?Q?cXT3KisNDw8AHqqI+3pFhNS7/5tMVAJIKUHXi8ZuqX0nZ9U4KxosXxdOgY?=
 =?iso-8859-1?Q?7RXQdM1X6QJjRZ9qm2gJzVau/FHuN5uDVz3o1iCDYnWI2mIKy7L/7q32kj?=
 =?iso-8859-1?Q?lBlghc9ij3cHC8QgGz4hqRF1mHPqF7QYn1tsXvoK4WpOkHSyYHhRP5MpKk?=
 =?iso-8859-1?Q?Qrbac4JqqsLaJ23N8ZFkI/LFTLGYyncWd7RnFYVLP4gpI0yh3XyWlEmuPz?=
 =?iso-8859-1?Q?QRjCKwo4a+jPA5lkNEbdyoUQnxrcAmWEPoGscNg/uIumLp3hzeIIzYTev2?=
 =?iso-8859-1?Q?huQ3eY6aqM?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c63789f-2d47-48a9-d3c3-08d90e54c5ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 16:59:10.6206 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47ih7IynBg1dA/2MUMYFdgJ7TuZCS3JbehTPz5CXfdXY1Ceh+s0LYjC1i3AU3w8ct92JJs/FvvLu/8Qo6jBUsRF/Xo64F0Vl6NOiDjm7YJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4525
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-03_13:2021-05-03,
 2021-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030110
X-Proofpoint-GUID: yDKgJ9S1k9siHeA83tjGOVKgmO1w45Xj
X-Proofpoint-ORIG-GUID: yDKgJ9S1k9siHeA83tjGOVKgmO1w45Xj
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_095932_536690_02DCA4A7 
X-CRM114-Status: GOOD (  29.70  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Hannes,

I just noticed there were in-line comments. to answer you questions:

Q1) Why not simply 'host_iface' ? 'triface' is a bit awkward.
A1) I used TRIFACE to keep consistency with all other transport options: tr=
addr, trsvcid, host_traddr. I will rename to host_iface at your suggestion.

Q2) Is this valid for all transports? I guess it would only work for 'tcp',=
 and maybe 'rdma' if one would be running ROCE. Shouldn't we error out on o=
ther transports like 'fc' or 'loop'?
A2) This is only for TCP, and we do check that this option is only allowed =
for TCP by specifying it in the "allowed_opts" as follows (see file tcp.c):

static struct nvmf_transport_ops nvme_tcp_transport =3D {
        .name           =3D "tcp",
        .module         =3D THIS_MODULE,
        .required_opts  =3D NVMF_OPT_TRADDR,
        .allowed_opts   =3D NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
                          NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
                          NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
                          NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUE=
S |
                          NVMF_OPT_TOS | NVMF_OPT_HOST_TRIFACE,
        .create_ctrl    =3D nvme_tcp_create_ctrl,
};

Q3) Normally the options are just parts of the 'address' string; why didn't
you use that approach here?
A3) I don't understand what you mean?

Regards,
Martin


________________________________________
From: Hannes Reinecke <hare@suse.de>
Sent: Saturday, May 1, 2021 07:34
To: Martin Belanger; linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; Belanger=
, Martin
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This c=
an be used to specify the IP interface to use for the connection. The drive=
r uses that to set SO_BINDTODEVICE on the socket before connecting.


[EXTERNAL EMAIL]

On 4/15/21 9:28 PM, Martin Belanger wrote:
> From: Martin Belanger <martin.belanger@dell.com>
>
Please fix up the subject and description.

> ---
>   drivers/nvme/host/core.c    |  5 +++++
>   drivers/nvme/host/fabrics.c | 14 +++++++++++++
>   drivers/nvme/host/fabrics.h |  6 +++++-
>   drivers/nvme/host/tcp.c     | 41 ++++++++++++++++++++++++++++++++++---
>   4 files changed, 62 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 288ac47ff5b4..91ae11a1ae26 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3961,6 +3961,11 @@ static int nvme_class_uevent(struct device *dev, s=
truct kobj_uevent_env *env)
>
>               ret =3D add_uevent_var(env, "NVME_HOST_TRADDR=3D%s",
>                               opts->host_traddr ?: "none");
> +             if (ret)
> +                     return ret;
> +
> +             ret =3D add_uevent_var(env, "NVME_HOST_TRIFACE=3D%s",
> +                             opts->host_triface ?: "none");
>       }
>       return ret;
>   }

Why not simply 'host_iface' ? 'triface' is a bit awkward.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 604ab0e5a2ad..f5d0d760b53b 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -112,6 +112,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *bu=
f, int size)
>       if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
>               len +=3D scnprintf(buf + len, size - len, "%shost_traddr=3D=
%s",
>                               (len) ? "," : "", ctrl->opts->host_traddr);
> +     if (ctrl->opts->mask & NVMF_OPT_HOST_TRIFACE)
> +             len +=3D scnprintf(buf + len, size - len, "%shost_triface=
=3D%s",
> +                             (len) ? "," : "", ctrl->opts->host_triface);
>       len +=3D scnprintf(buf + len, size - len, "\n");
>
>       return len;
> @@ -604,6 +607,7 @@ static const match_table_t opt_tokens =3D {
>       { NVMF_OPT_KATO,                "keep_alive_tmo=3D%d"     },
>       { NVMF_OPT_HOSTNQN,             "hostnqn=3D%s"            },
>       { NVMF_OPT_HOST_TRADDR,         "host_traddr=3D%s"        },
> +     { NVMF_OPT_HOST_TRIFACE,        "host_triface=3D%s"       },
>       { NVMF_OPT_HOST_ID,             "hostid=3D%s"             },
>       { NVMF_OPT_DUP_CONNECT,         "duplicate_connect"     },
>       { NVMF_OPT_DISABLE_SQFLOW,      "disable_sqflow"        },
> @@ -813,6 +817,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_optio=
ns *opts,
>                       kfree(opts->host_traddr);
>                       opts->host_traddr =3D p;
>                       break;
> +             case NVMF_OPT_HOST_TRIFACE:
> +                     p =3D match_strdup(args);
> +                     if (!p) {
> +                             ret =3D -ENOMEM;
> +                             goto out;
> +                     }
> +                     kfree(opts->host_triface);
> +                     opts->host_triface =3D p;
> +                     break;
>               case NVMF_OPT_HOST_ID:
>                       p =3D match_strdup(args);
>                       if (!p) {
> @@ -997,6 +1010,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opt=
s)
>       kfree(opts->trsvcid);
>       kfree(opts->subsysnqn);
>       kfree(opts->host_traddr);
> +     kfree(opts->host_triface);
>       kfree(opts);
>   }
>   EXPORT_SYMBOL_GPL(nvmf_free_options);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 733010d2eafd..17c64ff4db8c 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -59,6 +59,7 @@ enum {
>       NVMF_OPT_NR_POLL_QUEUES =3D 1 << 18,
>       NVMF_OPT_TOS            =3D 1 << 19,
>       NVMF_OPT_FAIL_FAST_TMO  =3D 1 << 20,
> +     NVMF_OPT_HOST_TRIFACE   =3D 1 << 21,
>   };
>
>   /**
> @@ -76,7 +77,9 @@ enum {
>    * @trsvcid:        The transport-specific TRSVCID field for a port on =
the
>    *              subsystem which is adding a controller.
>    * @host_traddr: A transport-specific field identifying the NVME host p=
ort
> - *              to use for the connection to the controller.
> + *           to use for the connection to the controller.
> + * @host_triface: A transport-specific field identifying the NVME host
> + *           interface to use for the connection to the controller.
>    * @queue_size: Number of IO queue elements.
>    * @nr_io_queues: Number of controller IO queues that will be establish=
ed.
>    * @reconnect_delay: Time between two consecutive reconnect attempts.
> @@ -101,6 +104,7 @@ struct nvmf_ctrl_options {
>       char                    *traddr;
>       char                    *trsvcid;
>       char                    *host_traddr;
> +     char                    *host_triface;
>       size_t                  queue_size;
>       unsigned int            nr_io_queues;
>       unsigned int            reconnect_delay;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8e55d8bc0c50..28eb7f88b487 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1447,6 +1447,20 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *=
nctrl,
>               }
>       }
>
> +     if (nctrl->opts->mask & NVMF_OPT_HOST_TRIFACE) {
> +             char *iface =3D nctrl->opts->host_triface;
> +             sockptr_t optval =3D KERNEL_SOCKPTR(iface);
> +
> +             ret =3D sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTOD=
EVICE,
> +                                   optval, strlen(iface));
> +             if (ret) {
> +                     dev_err(nctrl->device,
> +                       "failed to bind to interface %s queue %d err %d\n=
",
> +                       iface, qid, ret);
> +                     goto err_sock;
> +             }
> +     }
> +
>       queue->hdr_digest =3D nctrl->opts->hdr_digest;
>       queue->data_digest =3D nctrl->opts->data_digest;
>       if (queue->hdr_digest || queue->data_digest) {

Is this valid for all transports? I guess it would only work for 'tcp',
and maybe 'rdma' if one would be running ROCE.
Shouldn't we error out on other transports like 'fc' or 'loop'?

> @@ -2457,6 +2471,10 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_opti=
ons *opts)
>   static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>               struct nvmf_ctrl_options *opts)
>   {
> +     const char *iface_key =3D "";
> +     const char *iface_val =3D "";
> +     const char *srce_key  =3D "";
> +     const char *srce_val  =3D "";
>       struct nvme_tcp_ctrl *ctrl;
>       int ret;
>
> @@ -2502,6 +2520,22 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(stru=
ct device *dev,
>                              opts->host_traddr);
>                       goto out_free_ctrl;
>               }
> +             srce_key =3D ", src-addr ";
> +             srce_val =3D opts->host_traddr;
> +     }
> +
> +     if (opts->mask & NVMF_OPT_HOST_TRIFACE) {
> +             struct net_device *ndev;
> +
> +             ndev =3D dev_get_by_name(&init_net, opts->host_triface);
> +             if (!ndev) {
> +                     pr_err("invalid interface passed: %s\n",
> +                            opts->host_triface);
> +                     ret =3D -ENODEV;
> +                     goto out_free_ctrl;
> +             }
> +             iface_key =3D ", iface ";
> +             iface_val =3D opts->host_triface;
>       }
>
>       if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts))=
 {

Normally the options are just parts of the 'address' string; why didn't
you use that approach here?

> @@ -2530,8 +2564,9 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struc=
t device *dev,
>       if (ret)
>               goto out_uninit_ctrl;
>
> -     dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
> -             ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
> +     dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp%s%s%s=
%s\n",
> +              ctrl->ctrl.opts->subsysnqn, &ctrl->addr,
> +              srce_key, srce_val, iface_key, iface_val);
>
>       mutex_lock(&nvme_tcp_ctrl_mutex);
>       list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
> @@ -2560,7 +2595,7 @@ static struct nvmf_transport_ops nvme_tcp_transport=
 =3D {
>                         NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>                         NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>                         NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUE=
S |
> -                       NVMF_OPT_TOS,
> +                       NVMF_OPT_TOS | NVMF_OPT_HOST_TRIFACE,
>       .create_ctrl    =3D nvme_tcp_create_ctrl,
>   };
>
>
Cheers,

Hannes
--
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
HRB 36809 (AG N=FCrnberg), Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
