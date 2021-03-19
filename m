Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C05C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:34:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9336197A
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 17:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9336197A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pQtK9Vi6Ujt1MKXlRSBHLJRt0y8BE8oLP80uXbjBOCY=; b=G4oKvEZyOK3u7O7b/5OODZ1mv
	u6ZjgPwRhAj7GlBPuMH1Ve9kEc7r8eLzjmPXSRTZ8GiKtcowR7W4AYj/CBbfLWC7rGKk8PnlCuPB5
	N/v+qKcposxKnqWJ1eEfwKKaMqFTUuhcs28qqrKrwW8Yk6nazJHhjMoSjIkV0lRFG/T+eLNtlLqGZ
	zMxYdKxByRGSjeVC2rPp6meWW1f5xsr5bmyZW8hNr4Z+LYtfqEZVp9UHE82dct9qefmo0IeKCCd9q
	wkH3jwEP59aAQZQW/kL18RCUzx5ZSnyKPlTrPIGwxl/0OxbiUtNtscH+6AKSRIAF8X9COtjgeqjv1
	lMdrF3IRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNJ0x-007qzg-32; Fri, 19 Mar 2021 17:34:23 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNJ0r-007qyi-SL
 for linux-nvme@lists.infradead.org; Fri, 19 Mar 2021 17:34:20 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JHOm48181725;
 Fri, 19 Mar 2021 17:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=opFcRgCrP+GSzkAfGDid151B6HE323EFZbG+ZZXvrBs=;
 b=AiEt+VfZb8dkvHDScuJxYzB8RryL7xcBHQxx+fm6vC9ViAJGMQsNBb+UngifukgZ6gwE
 3PqrfgdbjFEC9k97pY/13jOy1XlGFfgCnvRbXPdTrXxquPUrLSTUKRWGtTBT8SkP3kNf
 is2TFYgu1ARKm9XTgV0wBOQEPPV1RoXhHvomfvzwTQs1IEo7IoV03rIXmFYS4O1iTyK7
 LbTAaVj9hU1B/U2zHzTLiPugb3569iYA03FChExAQNVXYUV6AFNOwagC/dlkOC8EtHHl
 63jMvzUn+DO4un7Qy7745FYGUh+AACMYcwFoQM1NlxMR/cWX/pT7t0FbLTczp4lINXNu Eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 37a4em0pjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Mar 2021 17:34:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12JHQrcX176062;
 Fri, 19 Mar 2021 17:34:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
 by aserp3030.oracle.com with ESMTP id 3796yxqg1t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 19 Mar 2021 17:34:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+AhNG3etbJLA9GNpdvpJmzhfDhDHmhYhI7GXZYXAXAtBeo/flNDxPz2B/zjp9u27TIv/ChPANtf7pkhwYKY4+H1ekdKi3qlXNYO5lN3dh9dyMtRq+qjWn4k3pL1toZtBiNCs/uWkbzS164HctRtjHAcDfg2TdmG8rzklaCaVfESeRBgmPN4CAXz2wHAc7qiCyDRywFDq1Sa+T6Seb5nxWnQnLO580DjPgj/xzS0BoOIl42+WgOIu5ZttCaXVZGpyUI0HPzLEx7+trW/S24DfBdK5KOs0narOAD3d6SKoXwXUvXskfeoeCs60+6ZOGpTRFYi3R1vx8AtGIgMQc2GaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opFcRgCrP+GSzkAfGDid151B6HE323EFZbG+ZZXvrBs=;
 b=VGFrSj+s5jU8IcBSUOHAQLssJ3LiH9JP5KEHxsnq47q6uzs2Ot/39PDGYoEaR07T/aS+XwUL6ONxY2Ec7H3oX5wGWd1N4qLGdyyCL48C1a+UKjo+7QBS1hoYUnotrSFxYmI5iZn5stkq2e1yWwPEI5cfqU2E7tzRhKtrx6m3sqIIy+UDFH4qFGogVZQrUN+XmEjsAlCVz3cbp1rq4G5882t3KN+wQCWh10SvNowna11lgEHggE1/oD4ppkW6+LJUNZqK5jN43SPAWMOnXWxxgKHeTru8dAJUJ0gJMastuFBTfwCTwqIV7AaeoiIW2sBZXEDx/zn2X6J5TbUPcnMpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opFcRgCrP+GSzkAfGDid151B6HE323EFZbG+ZZXvrBs=;
 b=o+qruKnDecYBtCstbKRCDPCSpE0V0crruqeuGpqSBT2PVgMLWPUXnFq1qEwvkD/zYCr+6AL+mqjxenbNujk6xHlw3kP1S2Bw2HmNN1VnkRO12F5E4GgJeiwyv6gyktOC2UUWzLhhbnQFdShXjcJrfXBz71fhPhlwjKI//4Ufr/M=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by BYAPR10MB2584.namprd10.prod.outlook.com (2603:10b6:a02:b1::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 19 Mar
 2021 17:33:59 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408%5]) with mapi id 15.20.3955.024; Fri, 19 Mar 2021
 17:33:59 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG26dbipyKKgQXUmKwfMgG9mkE6qJKjcAgADGWgCAAAaogIAAHgKAgAASy4CAALnSAIAAjooAgAACPQCAAB8UAIAAAnSAgAABEQA=
Date: Fri, 19 Mar 2021 17:33:59 +0000
Message-ID: <0FC5438B-E1C9-46AD-A0B3-171C5613E3FD@oracle.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
 <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
 <20210319153008.GA14280@lst.de>
 <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
 <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [76.176.17.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9392fbc4-8bb9-4122-f8fa-08d8eafd2e1a
x-ms-traffictypediagnostic: BYAPR10MB2584:
x-microsoft-antispam-prvs: <BYAPR10MB2584220C99C3214F0E92E3CCF4689@BYAPR10MB2584.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTytc1afq59JU/W9VZCVZzFSfahAMsj0W7xp7n6w3oJLCKsKbaqyeWgNa8uAJP8v7OmRNkWh5gupKVzD+VRZtTcfEbeJVzo+P3Ou+flQYYe5nzErO+oeHRfM3oYByyIJN4Bsw/jZxp3PT/5ICuhYPcybpNkdJp8PPIuVL+gVVnQQocBGsULpVYgSY+s7Ytjwcd660U31Y+WJ/lFz5wK4ucIm4+mX3f0Z+QLps7+ByXGVniHNHYBzozWtqg7JZjdQewj/Lf6Yhuq7Pv/oUpszmbM0uc0wG/SCsmNBA74lsLqPn/Sx6SuumKcIuKMQTcWdAXUo2BApj/E/GvmSyTPRDg9uz7BvbNBdOjrNqJjJ3XfLtzsQh4NdJG4nlMYJmrC0b/iGIGJWUUtto5xD0S+DmX/lWffHveNlYZ6RkA7nkWjZd6PO54rYNNTXkW18xFUp7THWWqQahzlrW6h3BwTMpEzYv2A7dglaeMJx3FNiHwGgc1f5S54FyBBW5DTxhz/iPlrT4m+twWHVzQmzetXW+benA13Pz8H/lZD6W01e6sw4eZBgknpVHvEco/gTUR+ErA2ZC0uZCRvfZdswYnzpHF+au7o3lqEr/Chgh/vmLfEQFjE3re+By4+uG/nUHbbCvuw2yAxUr6rcx5JVUEtF1Zt8JwYkRfxJXXw0jIdyrYs9Zzxun+RsfH3NK4Sa9/QN
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(366004)(136003)(396003)(376002)(53546011)(86362001)(6486002)(64756008)(2616005)(316002)(6512007)(66556008)(91956017)(44832011)(2906002)(66476007)(6506007)(8936002)(76116006)(4326008)(66446008)(6916009)(71200400001)(8676002)(26005)(36756003)(33656002)(54906003)(5660300002)(186003)(83380400001)(478600001)(38100700001)(66946007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?L0hBRDkybDNkejMrMzJDeWZxR3dVVzE3aXR4TUxPbWh5TXBoOGV0N3lxR2Vl?=
 =?utf-8?B?Zll4WnYzbFJocVpJUU5pL1hMRGJlVzVxTWYyTEdKL1VEaXU5VUZFTE5YekJx?=
 =?utf-8?B?YzZlTG90UWxtMXNQZFV2M2xEcEFxNjBQMHZOVU9Wck9WN1U4WmdJeXE3L2Rl?=
 =?utf-8?B?QjhyV05tT0lXakh4OEZtUjFKWVJtWnpiN3pBOTRyUGpnMVhBcC9mQ0dlYkhZ?=
 =?utf-8?B?Ti9yVkRrYjY4bGMvbUZ1WmU1eE4wZFpEbGdCanpCREkyVmp4Z21HemVpRzhv?=
 =?utf-8?B?cmtGNVFqWE8xQkFkZFlwM3h2YXF4bGxJUVBKMVFJazJ2dnZiOWJTWkcrcmc2?=
 =?utf-8?B?L2dQdGtmbVhkV1k5YVIrQTZ5MDE0SHJrcTRmVE9FSlIxYWtoSzBSbXVKY1Y4?=
 =?utf-8?B?bmIzWDBaNVJxaWNtVnpkTkNOR0pWczBwWUlRV2ozYytmS0tzQWxGcWZTbk5m?=
 =?utf-8?B?WGJlby9hd2lLeEQ5OUhTYVFzeDQxaXdEdml4bXVTTjE2anhtRE1hV29VYkxn?=
 =?utf-8?B?Y3lkTmNxSE5VMHpqR0FXRUFRbGt3KzdCSStqMC9YVjZ4bmE3RXMzd3ZqK05m?=
 =?utf-8?B?Q29ka0d0RXd6QWpXMEJXRXBBOWppaFZyc2lUalJmYXExdmRBOTFtL3lpSGlP?=
 =?utf-8?B?bnpEZUtRSHIzdFI1ZC9jR2dQZVRXYzJiYlNPbyswbWpoVVZJVFlDYXZsb1Np?=
 =?utf-8?B?VHZKa0hLL2F5blBRL1lmUTZDYVlCQXNGUnZrTDRvdFg0YzdOSjB1L0pkWnNF?=
 =?utf-8?B?Ni8wemhlNnJPS3NGd0duUStYdnY0Z2NsZi8rWTFxZUFNOENXWGRtSzc3cE10?=
 =?utf-8?B?Y2tKcmNLempXcjR3bHdEZC9KeDZSMStLNit2Z0N2dHV3cUJ1RTZHeUwrYkJX?=
 =?utf-8?B?dnU3K0kra2tRSTdlcnlJYkpiK2dVSzlXVzRSbTRUYm81cUtZeDZHMVZoTDFj?=
 =?utf-8?B?bWVUdVFwd2NsY1FXQzNmTXhkakw2M1NneHlzNHZ2bDJlcVpKdUVVNnhhOSts?=
 =?utf-8?B?cVJHaWRjRllEUVV1cGVsc2FUVGV4bjVpOXJsZmorUVJYYmlpdUI5ZG1xeFMv?=
 =?utf-8?B?bXpNeUllcHA2TlFNbDA0TitUZytmRW9BV0pHenBNa1RiRkFhVC9TQWxJcFNO?=
 =?utf-8?B?ZlVycVZ2Mnc2QmFPOXdZWXBKcEdkOUlnNTJVQlBpcFE5VnZOdlA4MzNxUXd5?=
 =?utf-8?B?UFJ1S2padWVOdERzc2pGRUNFMkxkYVNCY0F0UDBLamZjMnVOTjhLV3dtWE5j?=
 =?utf-8?B?bitNMW1wQ0pubjY3Wlo1eFlsUjF1SHNoR0FmRFNmTkVHKy9tZ3VYY2swaFNy?=
 =?utf-8?B?S1ZveTFhWXpxTCtLdHZBU0RyMmJSS3RuMEdINVIwODBFNU5MKzU2M1p0cGFN?=
 =?utf-8?B?R2tDejBYS3JTSXQ2dGp3YW4yamNSemRZYzFqWDdZV1JoN3VVSmNOdU1MZFVt?=
 =?utf-8?B?alNCbWw1MjFvaHlDdGk3MllZTGRJa2ZUcFEwZEZ3ZW1SWGNMeEYvcDNEcWpV?=
 =?utf-8?B?YjV3c3NBUVZoVmRrRklMOFFIN1VESGs5MVNSWnhWZkY1eE5GSmNFUkpFNVVp?=
 =?utf-8?B?cTJYODlDS2N2bTFTa2JTL3R4N0xtbUFiMVczekp3T0NIUkMvN3paaGpET3h0?=
 =?utf-8?B?WmRvQnJJdzBjT2h6SUlCeVRQdzc5eHpWTjZDUTZHc0pjNVhIMTVYNkIwNnBQ?=
 =?utf-8?B?TkxTeUhaZ2M5dmt1VWlPcVJESUFwMUFLQ2JQeTcwTFdUVWl5aVIxZjh0VWJN?=
 =?utf-8?Q?Nd2T2PxDixlUnTS+tKI1f1zCdz9RyLm65LwNipr?=
x-ms-exchange-transport-forked: True
Content-ID: <A7ADEE2218D5D84CA103686C8F023D25@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9392fbc4-8bb9-4122-f8fa-08d8eafd2e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 17:33:59.2576 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AaKcXedpDhte5jJzQIwNwd3TKPZK8zjA4vEY3wU1cu23jZWAdOwvtokKUzRvWSUaM1hgJTGnqNq6+ltN7iG6aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2584
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190121
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9928
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103190121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_173418_280560_CFE991C8 
X-CRM114-Status: GOOD (  27.07  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

DQoNCj4gT24gTWFyIDE5LCAyMDIxLCBhdCAxMDozMCBBTSwgS2VpdGggQnVzY2ggPGtidXNjaEBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgTWFyIDE5LCAyMDIxIGF0IDA1OjIxOjIy
UE0gKzAwMDAsIEFsYW4gQWRhbXNvbiB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gTWFyIDE5LCAy
MDIxLCBhdCA4OjMwIEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gd3JvdGU6DQo+
Pj4gDQo+Pj4gT24gU2F0LCBNYXIgMjAsIDIwMjEgYXQgMTI6MjI6MDhBTSArMDkwMCwgS2VpdGgg
QnVzY2ggd3JvdGU6DQo+Pj4+PiBJIHRoaW5rIHRoaXMgaXMgYSBob3JyaWJsZSBpZGVhLiAgVXNl
cnNwYWNlIGhhcyBubyBidXNpbmVzcyB0b3VjaGluZw0KPj4+Pj4gcmVnaXN0ZXJzIGV2ZW4gcmVh
ZC1vbmx5LiAgTU1JTyByZWFkcyBjYW4gaGF2ZSBzaWRlIGVmZmVjdHMgYXMgd2VsbCwNCj4+Pj4+
IGludGVudGlvbmFsIG9yIHVuaW50ZW50aW9uYWwsIGFuZCB3ZSBhbHNvIG9wZW4gdXAgYSB3aG9s
ZSBjYW4gb2Ygd29ybXMNCj4+Pj4+IG9mIG1pc21hdGNoZWQgbWVtb3J5IGF0dHJpYnV0ZXMuDQo+
Pj4+IA0KPj4+PiBJIHdhcyB0aGlua2luZyB0aGUgZHJpdmVyIHdvdWxkbid0IG9wdC1pbiBpZiB0
aGVyZSB3ZXJlIHJlYWQgc2lkZQ0KPj4+PiBlZmZlY3RzLCBidXQgeWVhaCwgaXQncyB0b28gZnJh
Z2lsZS4gSSB3aXRoZHJhdyB0aGUgc3VnZ2VzdGlvbi4NCj4+PiANCj4+PiBJJ2Qgc3RpbGwgbGlr
ZSB0byB1bmRlcnN0YW5kIHdoYXQgdmFsdWVzIGluIENTVFMgQWxhbiBjYXJlcyBhYm91dC4gIEkN
Cj4+PiBkb24ndCB0aGluayBqdXN0IGR1bXBpbmcgYSByZWdpc3RlciB3aXRoIHNvbWV3aGF0IGF3
a3dhcmQgZW5jb2RpbmdzDQo+Pj4gaXMgYSBnb29kIGlkZWEuDQo+PiANCj4+IFByaW1hcmlseSBS
ZWFkeSBhbmQgRmFpbGVkLiBJ4oCZbSByZWFjaGluZyBvdXQgdG8gdGhlIHJlcXVlc3RpbmcgdGVh
bSB0byBzZWUgaWYgdGhlIOKAmXN0YXRl4oCZIGF0dHJpYnV0ZSBpcyBzdWZmaWNpZW50Lg0KPj4g
DQo+PiBCYWNrIHRvIG52bWUtY2xpIHNob3ctcmVncywgZG8gd2UganVzdCBleHBlY3QgdGhpcyB0
byBhbHdheXMgZmFpbCBub3cgb3VyIHNob3VsZCB3ZSBiZSByZXR1cm5pbmcgZ29vZA0KPj4gdmFs
dWVzPw0KPiANCj4gRm9yIFBDSWUsIHRoYXQgc2hlbGwgY29tbWFuZCByZXR1cm5zIGdvb2QgdmFs
dWVzIG9ubHkgaWYgdGhlIGtlcm5lbA0KPiB3YXNuJ3QgY29tcGlsZWQgd2l0aCBDT05GSUdfSU9f
U1RSSUNUX0RFVk1FTS4gSWYgdGhlIGtlcm5lbCB3YXMgY29tcGlsZWQNCj4gd2l0aCB0aGF0IG9w
dGlvbiAobW9zdCBhcmUpLCB1c2VyIHNwYWNlIHdpbGwgbm90IGJlIGFibGUgdG8gYWNjZXNzIHRo
ZQ0KPiB2YWx1ZXMuDQoNCkkgZ3Vlc3MgdGhlIHF1ZXN0aW9uIGlzOiBzaG91bGQgd2UgZ2V0ICBz
aG93LXJlZ3MgdG8gd29yayB3aXRob3V0IGhhdmluZyB0byBtYXAgaW4NCnRoZSByZWdpc3RlcnM/
DQoNCkFsYW4NCg0KDQo+IA0KPiBGYWJyaWNzIHNob3VsZCBhbHdheXMgd29yaywgdGhvdWdoLCBi
ZWNhdXNlIHdlIHJldHJpZXZlIENTVFMgdGhyb3VnaCBhbg0KPiBhZG1pbiBjb21tYW5kIHJhdGhl
ciB0aGFuIG1lbW9yeSBtYXBwZWQgSU8uDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK
