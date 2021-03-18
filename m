Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED2DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:40:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A2364F1F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 18:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A2364F1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3M+gehCDjnIunpgB3FoCK+/DWWBF19OcJMVsX5kAbt8=; b=bC1y0J8N+VEbHFGWvGtRdFzDm
	D7te8hANTNwI+ZGjzQuzKGxrk2G0byqsHJbtc4iWmxbIkYJM9nIOztQtnY28JA6J/Y2wmbVbvptMU
	fZKIdoRc0kwZixG5GLcwzjPQ0gynhA5DOuK/NjPcMn0OikK1Zvv2oE+3vVepRNbw3Xy2m6G98GM5x
	DdRD5DnWjMHtWb+4tUIOZVfZBfvjQuGYw666SginuSEFUZtHYFrgHPgcyQyE9QMT4hn2CNgopNBxP
	ZA4eu217CW0E+xDtRFe1b/j6zxJyYP7iIC+gXTn2pzwWM+aLc3SfTHEyavULvSYRgW3hmOG0B8Fya
	SVWvPngQQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMxYu-005rTP-BM; Thu, 18 Mar 2021 18:40:00 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMxYn-005rSd-TS
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 18:39:57 +0000
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IITgXH083247;
 Thu, 18 Mar 2021 18:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mjInPzJIxy/77nWivtCwm5cPTYW6LSIeDRmCQ8bTSE4=;
 b=IIoFPh+uZoxqZakkqwQS7f2Iw1M4vblJ7mPfDy5uRP828uW0a5n3WxK3PZuUogG7YU19
 B7tqPvySZ/ez/53DiU8wTiN7TvRSby/I0RAEhhQ6X+gD2uLJNLZKftmDcyv56hEw51J/
 sIIdU+2waV0HxmeDk2+Vzt7/T1wQbZS7HxdXL36+cD4DtCJPsZ3vdJeYVlWZu+6FxiS+
 PTo31v6biYgow8XWMBrjh4+eIJO1T7kaD3EUyWp0CgxWE4CSi54fR43r4L9LXRfiVW8C
 4OQz3HyG/fbOyI7owFX2Cz8h3uovUZsyIkLIU29jtCt0yydbketsR7oyb5U8JkfRJJyS 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 378p1p0h53-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Mar 2021 18:39:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12IIQ0On044007;
 Thu, 18 Mar 2021 18:39:39 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam07lp2040.outbound.protection.outlook.com [104.47.56.40])
 by aserp3020.oracle.com with ESMTP id 3797a4afgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Mar 2021 18:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXOvHNyY0f5YLKxdFBGz2Dk4ozCutF4cJHo34EWg//iE59ZXz/U9fVGrKbRGgwZlcBl3knEgVEny+wsRF3T6Rv9K6VK0syKCb7rCxxWeFEnxoPpT4sZzNtO2PEhCrUg6t6hHAjgltvZreOUSEISNOjyC3WQhK0FtboZhAgSi/rMKo1PuL8g8IRzUPsbIX7pAegqtGDxHOM+2BYiThfYYhR8C8+1van0vt88Uj9MT/Zqrfs15YtoVFX4ggn6Csj3CixN54tDdDxx4kuNQ8jd1yy5QYk2pxBrfrad1CRj75U2ewL/TXSChbo+P2GS1Q/fjR7YBWViecOYCT21pUH3J7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjInPzJIxy/77nWivtCwm5cPTYW6LSIeDRmCQ8bTSE4=;
 b=atqJP69F7T0WBHHRSoKlCyG2iXgbOtPBOSVKZo/X10TBbowDD8rYGpLXo9mZhhyIIJ+perWMeHOjIUGCGhYFhXrniR0O9UAluUxcPhlQrA4YlN/BKQ+yQihczzAGJp52kzstnNg0thClg+nKvDiCi6i7FR9tjNDEZKi0R6SUvZ5q7bliR4HUhX9MQOXyXqK6G8lqRUIholx5Iw4FgsTP17dnCTfdeS4yWCsZtFZo9hRm1AC+qj2Ee3oLXQm9GRDwYpF3ymjYwzV7lEjAU9Zfkw8asXs/uhstuGzvVkUTaKPTd6z3SEo8JKPRuSVyE92bM92g+jEzluhr9Q3Lah8hJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjInPzJIxy/77nWivtCwm5cPTYW6LSIeDRmCQ8bTSE4=;
 b=FOuQm2bkL8ZAhsMextjTICjMtIWBT/SpvkhHl/t4Fnqg8fgQoycqtYkIIYsMxOvyB+mKgcwJtvj6a5OlYNVk/h0d9Z14qCC/GtO5qLIXQI2xYbZgApEzy3pf+M29yKpQSfsLgauS7C7+nNKFkqCxOBUpksfhxAMsqZa+eeTAS08=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by BYAPR10MB2933.namprd10.prod.outlook.com (2603:10b6:a03:88::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Thu, 18 Mar
 2021 18:39:37 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4570:7f3a:a913:4408%5]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 18:39:37 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG26dbipyKKgQXUmKwfMgG9mkE6qJKjcAgADGWgCAAAaogIAAHgKA
Date: Thu, 18 Mar 2021 18:39:37 +0000
Message-ID: <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
 <20210318043828.GB26988@lst.de>
 <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [76.176.17.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fd8749f-6ff7-4e49-7737-08d8ea3d2f17
x-ms-traffictypediagnostic: BYAPR10MB2933:
x-microsoft-antispam-prvs: <BYAPR10MB29339D35642C4D3A4C271E66F4699@BYAPR10MB2933.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qiDb9+fWD7OHlOoSwHW2q/oD/ZqLMfQQY24iO0KG7lHjLdtaPrp7rcx5kBEtezrIlClo+taGK5OlYG+Eb5qpbam/9vz5Tq9sKk7d7Xw02r/9IjrZfaKBnuekUGLAK22PyuMVeu+vfQ95mIzGbmvTbd9DYMMS537zDdCTX8WgNYxk0vgdWZWtjFTD+fecpDIfmy9cLvGh08BGa6FCaCtzNsjn2lwYyrhxyrTXEehiCoGmycOLyqYlWJetyN9OT0TLa6842hPiCPj0Fa1Tzj0X5oqfjxmBL/RR1I5K2jLPpVKoTWuyJUdvxlWQ7p9GnOOVqT8tD74qRb2V0Nm67dujsjT12grq97fG82iE7iNyR6zVtLP3aJZR51YrkEuK4V/qs/EA9Bjvy+rXKuAyO9yL4yMLNGVloFAZqKU70mzpHfM0VzfVfhnoRu+iAsA486lu89BRDUQK43MfDNVWMZeF+Xorx+b1Bj6h+isBogwwVf/j7mGtoCjvvO12SIadkmlIaLf3TkDiIR6PdAR4icB+HKd0JN4axyIrjBJFf/8WgcBNv2qlIqJTnNiZOWs9/ujxC78MusrjdpM6wGnGiwHwImZN64TJ/ooVDTnwZ7Ij1Vat/FKFjKKplBnxwQ+F7ny3qh9QPrdDBRkjbnu+ameZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(366004)(346002)(136003)(396003)(376002)(64756008)(2616005)(478600001)(66556008)(66446008)(6506007)(5660300002)(36756003)(4326008)(316002)(44832011)(66476007)(91956017)(66946007)(54906003)(186003)(38100700001)(71200400001)(76116006)(53546011)(6486002)(8676002)(6512007)(2906002)(33656002)(83380400001)(8936002)(86362001)(26005)(6916009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VUJxU1dqSHRMeThPYlhnVXZRRFY5VCtoc3dHMndJVWFlVXdhV2ZhU2tFTlBk?=
 =?utf-8?B?ZVFaQXVrWDRBSnBYQllQbURCaGczSXdpdUZTb2lucVd3c1pDdnZNc1dDOUV0?=
 =?utf-8?B?T3M3YUdIc2l3SXZrdjg5ZnlJSEJNa0NIdExYRlVKTk42cTBqTzdDL01HRWta?=
 =?utf-8?B?dWNpMk81ak1NRVRsS1FOeHk1dEYzbWlxYUF3dVZBbGJndURlNnBPQUttWUpQ?=
 =?utf-8?B?ZEU3K0E5Z3BtbCswa1JuV0kzSVV4OFBSblRJYkJTRWl4YkpiOUdUZzdLRi9H?=
 =?utf-8?B?b1ZQajNKaXpxT2tWNmlZbVB0M3cxZ2JERmZ0TSt6Z1FYeFc2RlF1b1lha1d5?=
 =?utf-8?B?ZUd1Qzh5VHk2RlBVa0ozZE9oaXBMUVd3VExyY1BFMm1WczFtckhaNTltNHph?=
 =?utf-8?B?VFRaNWtMVUtreFJXdHNQR0R0bEkrYmphWmJtSmVUdWU3YWMyY3RqekhXdHEy?=
 =?utf-8?B?NVFoMmJWMTdTZ3BwSW5ZWVN5WW05TU1OZFVSUHhYbkorT0k1R21LbU16bmpG?=
 =?utf-8?B?djFNNERDUlhCbnE3N25iNEp1UU1COWdCR3JoWEY3QlJCQkZ0bWlTdUVwYkpy?=
 =?utf-8?B?VmNKQi9aUGtUNDJsWWtCMFp6eFlOZUJjemRHc2xOOWhHb3FVL2ExOHdaN21B?=
 =?utf-8?B?TDFNWHFFWEpYazgzcnJyMEx2cVN2cDUyUldYV0dTREdCT0RnWHlXRHYyanNT?=
 =?utf-8?B?WmlNekdqNnVmanNTK2p4TnhCak1xbkMwcTIxUUhMRFg1d1Q5MnFYWGNhU000?=
 =?utf-8?B?L201SERHTEl4bnI5MnZDZVEzWStxc2VMNksvcmdFdCtzdTF1MEhyZG15ZVdv?=
 =?utf-8?B?N3FKd3pUNGlPL0JmNjRYK2F5TnJOalpnZGlJZVVCbWtMM0tRYzFlRmpRTXlO?=
 =?utf-8?B?NkpqbkU3WE9ZelN0cEg2NDMwVm5zRGd3WG9OQmdBZGxxdUNIalNBN3lHL24w?=
 =?utf-8?B?aTRVVHk3VkVnYkdIZkp3ZGZPdGN2RkJKcmpXU1FsR0EzeFNpUFNHVEhqcWs2?=
 =?utf-8?B?S0V3dnE5cDJnYnNHRjZjcGZYMzNHd05pWWM4bE5pWncvc0Yzc3VOVDBUeU9i?=
 =?utf-8?B?TytEU3l5a3M3NmZhMFVRVCtoNGFzb3U2SCtxclFTeWk3aXBJQm9ZWnIzY1hS?=
 =?utf-8?B?KzlSVEVlT1ZFVFQ0REVhUEJZdjZnV2R1T3ZRd2JBVzBUSUZmNVEreXZkTkJR?=
 =?utf-8?B?K3AxNmJFRzZFQ0tYL1o2cW9RUmp3eEMwb1J0TkJsK2hHaHBhZ2ZxclgyTWdF?=
 =?utf-8?B?Ynl1RStkVHg2L1RTaHJxUDdoRUZVSVZ1WnJodmZLK1I4cUR3TnVJa3Z1VFZa?=
 =?utf-8?B?OXRxekNKK1NvNVZIbjk3R0RDWjlIb0tQT0czT0lmbnV2Yzd6eXJlR24xc25Y?=
 =?utf-8?B?aDFkb2lRYmVxM2xHUzZoVTJJOTRleEExQndMajJER0poMGNUaVpsWk1wUXJ0?=
 =?utf-8?B?Q3pzRWRNc29NdlppT1VqSmsrT3p5ZFh3SUxEdkROZGN6YXhtV20xQ3Z6L205?=
 =?utf-8?B?L2NpcUR5K1pBWlYrdUF4U1lSM2U1UlFURDExeWh1RzNJNXN1bFhSdUJsYnln?=
 =?utf-8?B?T01qODBGZFJMRmczNjZCMHZ1UlFBSjR3UFQyWDZMZDZ3YllxZlI2c1BwaWFO?=
 =?utf-8?B?OWRydTVnVGh4dEdyeEpqTlR4aUpzWk9sbmgvZk5Pd0JNZE9iYzAxZW1mUXZj?=
 =?utf-8?B?VThETko3TWFGMXdtY2NrckJGVVlFY1NLMk9tK2ZkWFpCaHZUTEJFLzZMdVVS?=
 =?utf-8?Q?RfXcqWICklpuIGJiRR9LsBPSElhpDP7/V8S2rtE?=
x-ms-exchange-transport-forked: True
Content-ID: <661649AD21F5C245BD061FAC6DCE4E1D@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd8749f-6ff7-4e49-7737-08d8ea3d2f17
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 18:39:37.6020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ukYEY8F9+gaMGbUIaimzFGHDEl+qU0UG2B7UUr9slm+tuCElCd6N56AUReyTIhV5ATyupqA6NR3ncOO9EcyKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2933
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9927
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 adultscore=0
 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180131
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_183956_165809_0B1F67E5 
X-CRM114-Status: GOOD (  26.24  )
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

DQoNCj4gT24gTWFyIDE4LCAyMDIxLCBhdCA5OjUyIEFNLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBNYXIgMTgsIDIwMjEgYXQgMDQ6Mjg6MjRQ
TSArMDAwMCwgQWxhbiBBZGFtc29uIHdyb3RlOg0KPj4gDQo+PiANCj4+PiBPbiBNYXIgMTcsIDIw
MjEsIGF0IDk6MzggUE0sIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cm90ZToNCj4+
PiANCj4+PiBPbiBXZWQsIE1hciAxNywgMjAyMSBhdCAwNDo0NjoxNFBNIC0wNDAwLCBBbGFuIEFk
YW1zb24gd3JvdGU6DQo+Pj4+IFRoaXMgcGF0Y2ggZXhwb3J0cyB0aGUgTlZNZSBDb250cm9sbGVy
IENTVFMgcmVnaXN0ZXIgdmlhIHN5c2ZzLiAgVGhpcw0KPj4+PiBmZWF0dXJlIGNhbiBiZSB1c2Vk
IGJ5IHVzZXJsYW5kIGV4ZWN1dGFibGVzIHRoYXQgYWNjZXNzZWQgQ1NUUyBhbmQNCj4+Pj4gcG9z
c2libHkgb3RoZXIgcmVnaXN0ZXJzIGJ5IG1hcHBpbmcgdGhlbSBpbnRvIHVzZXIgc3BhY2UuICBT
aW5jZSB0aGlzIGFiaWxpdHkNCj4+Pj4gbWF5IG5vdCBhbHdheXMgYXZhaWxhYmxlLCBleHBvcnRp
bmcgY2VydGFpbiByZWdpc3RlcnMgdmlhIHN5c2ZzIHByb3ZpZGVzDQo+Pj4+IGEgc2FmZS9yZWFk
LW9ubHkgd2F5IHRvIGFjY2VzcyByZWdpc3RlcnMgZnJvbSBvdXRzaWRlIHRoZSBrZXJuZWwuDQo+
Pj4gDQo+Pj4gU28gd2hhdCBpcyB0aGlzIGFwcGxpY2F0aW9uIGRvaW5ncyB3aXRoIGl0PyAgU2hv
dWxkIHdlIGp1c3QgaGF2ZSBhDQo+Pj4gcmVhZHkgYXR0cmlidXRlIGluc3RlYWQgb2YgZXhwb3J0
aW5nIGEgcmF3IHJlZ2lzdGVyIGVuY29kaW5nPw0KPj4gDQo+PiANCj4+IFdhcyB1c2luZyBudm1l
LWNsaSBzaG93LXJlZ3MgdG8gbWFuYWdlIG52bWUgZGV2aWNlcy4gVGhpcyBpcyBubyBsb25nZXIg
YW4gb3B0aW9uLg0KPiANCj4gTW9zdCBkaXN0cmlidXRpb25zIHNoaXAgd2l0aCBrZXJuZWwgQ09O
RklHX0lPX1NUUklDVF9ERVZNRU0gdGhlc2UgZGF5cywNCj4gc28gdGhhdCB1c2VyIGNvbW1hbmQg
d2lsbCB2ZXJ5IHJhcmVseSB3b3JrIG9uIFBDSWUgdGFyZ2V0cyBhbnltb3JlLg0KPiANCj4gUGVy
aGFwcyB3ZSBjb3VsZCBpbnRyb2R1Y2UgYSBkcml2ZXIgb3B0aW9uIGFsbG93aW5nIHJlYWQtb25s
eSBtbWFwIG9uDQo+IHRoaXMgbWVtb3J5PyAgV2hpbGUgeW91J3JlIGN1cnJlbnRseSBhc2tpbmcg
Zm9yIGp1c3Qgb25lIHJlZ2lzdGVyDQo+IGF0dHJpYnV0ZSwgaXQgd291bGQgYmUgbmljZSBpZiB3
ZSBjYW4gbWFrZSBhbGwgZnV0dXJlIHJlcXVlc3RzIGF2YWlsYWJsZQ0KPiB3aXRob3V0IHBpbGlu
ZyBvbiBtb3JlIHN5c2ZzIHByb3BlcnRpZXMuDQoNClRoaXMgY291bGQgYmUgYSBnb29kIHNvbHV0
aW9uIChhbG9uZyB3aXRoIGEgbnZtZS1jbGkgY2hhbmdlKS4gIEnigJlsbCBjb2RlIHRoaXMgdXAu
DQoNClRoYW5rcywNCg0KQWxhbg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1udm1lCg==
