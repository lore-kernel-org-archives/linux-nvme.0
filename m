Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E20C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 18:15:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3257261059
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 18:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3257261059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EePflpxRfFV0IZDEQC3lJP6PTVxMDp9XaSFgTgsW5QE=; b=zB6ei1DUUh3VCb
	JGYjtD1Dy4lxEjpZtOkTczL5ewqgulOdPKSmrJwSnzg463UGMlMoyA6QoUjNbv6bKWGAa6z7ecLdi
	wP9BR82beLEt+LrKIkw1S30yqNKQ9V6QXK/xQZXKQqhghh58Ka6QvFwOXpE0NB/mxYgz0TkBe8LVm
	EAbl3csR3TuYtrSFQNop3DVSJFpivBK2whIH2QUliGizkXKE/wxXGeqG4FpETNEjckMd4YzCobiJR
	UoG/uOWilPMcA59qZ7sWBbTKN+qcVudb3qcA0RbAIxdqRWDYB1r/CqnBWu3ZU1oOP2QEXTL2d1SxS
	tR75y1rrE025aVfSe7TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsr7B-00Ff0l-0D; Mon, 14 Jun 2021 18:15:13 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsr73-00Feyc-Hn
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 18:15:07 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15EIAmg2020639; Mon, 14 Jun 2021 11:14:59 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
 by mx0b-0016f401.pphosted.com with ESMTP id 3963v1j4n7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jun 2021 11:14:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5FY9WsoqtBoEQBID+0g/cehEnU5MYeJsR1tE9KRbC9WCMY1S2GBnZMX9TzAtDPoBrAm0wH3jORRuoHeWhzTMQ45sveFHeJndmkOHAeRHrxuz1D0rc+VDbIHT7Rast4IB2egEDQ3Qvb3ld4w6gcIA4RYaZ/KY5N1xTow3fwLuw7hS/IHhYh7UbPdgG5gIXb/R3c1noqFDTeIrke418ikqevfUMAFmgy8KqpOCrXBuAmhAfcSBSr/gUwwuiTtd1Rt1Es/vTSy8PHnqOJji9P5c1PRlsowVJO9JouHRr/Yz42oUnzI8EuF+doStALU9GRvJw1G7JtYcU2HLrH2wpUGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otOL3bb8MKG8Ogm74hXbwm3i4s7NEVsp0XZmZt74Vg0=;
 b=FutKA45CY+YOGBVv3N+fZfV2nczyELu8TnSOKBqfd0jsYyrtW8sGIwm9lYsrRBSC8+hXpjKtlqy989kl8sq3ir8DJox7bBlsCzxSjJplCNKx9hPrz2abAcqcXV1M1wqKUH9xwPIaiCtB1YRUMYy1FbKsE8XsM1Jk79gtYZbF4OZqqRqb4AtGVzTWNPcqEyIpt5rYwDo/U4Zw1Rrfm9d6ExhCbqQad/9RoiSLfeDP+GBJzkApAF4lm5RabnGB8qR5KO7QB8y541vQ54CsoenAzZBcI+mFeWKqzmpvu+jVpQP2+CzYhKIMrqy4ezJlUd27ae4WWaw9z7DoSCvebamLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otOL3bb8MKG8Ogm74hXbwm3i4s7NEVsp0XZmZt74Vg0=;
 b=Bnz5dIQsaIw7bEtuMOv/koAqAuUYADFi8gbJOuY9pZEZC7ySGQ1PG2ixtLNHenmgiJGAsn1xgJaHbqY00lQIAxaUHdHwQsD4y6d9Cue1ycxSUu3tIq+0ak81uunu6m73C48KuVY7flmsXbowLUz4QF1XhsC5AHfy0zcTJ95UPkU=
Received: from CH0PR18MB4129.namprd18.prod.outlook.com (2603:10b6:610:e0::12)
 by CH2PR18MB3207.namprd18.prod.outlook.com (2603:10b6:610:22::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Mon, 14 Jun
 2021 18:14:55 +0000
Received: from CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::a0cd:d9bd:2cb4:9bfe]) by CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::a0cd:d9bd:2cb4:9bfe%4]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 18:14:55 +0000
From: Michal Kalderon <mkalderon@marvell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Shai Malin <smalin@marvell.com>, Ariel
 Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: BUG: scheduling while atomic when
 nvmet_rdma_queue_response fails in posting a request
Thread-Topic: [EXT] Re: BUG: scheduling while atomic when
 nvmet_rdma_queue_response fails in posting a request
Thread-Index: AddVJduDAzSsasp/Srq8m1sJiLA/SwHZ/iiAAAIE7AAAC0D9AAEaK/MQAAQ90AAAAv1ZkA==
Date: Mon, 14 Jun 2021 18:14:55 +0000
Message-ID: <CH0PR18MB4129DEE104D73DEB0BD9B01EA1319@CH0PR18MB4129.namprd18.prod.outlook.com>
References: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
 <e059fc90-81e7-dbe8-86f4-87b4bdbd5bb0@grimberg.me>
 <20210608184134.GA339600@dhcp-10-100-145-180.wdc.com>
 <4a031bc0-fba3-12d6-428f-a378aba1897e@grimberg.me>
 <CH0PR18MB412996A6716DE9AA114C09B0A1319@CH0PR18MB4129.namprd18.prod.outlook.com>
 <4b77d39b-00ba-317a-658b-b00be6cb3e20@grimberg.me>
In-Reply-To: <4b77d39b-00ba-317a-658b-b00be6cb3e20@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.32.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89920ea8-63c8-43b9-d6de-08d92f60501e
x-ms-traffictypediagnostic: CH2PR18MB3207:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB32073577D5F93B3E7584A176A1319@CH2PR18MB3207.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VDm27QcOZHdV1gXruIrhflSmADJhd4fbW/WXJ9Sa7jZnU+XEfc3W8nhHNZNKxcpolPgTLdWzmNAx5fFqFOkFANelIol2IzsHPd5lJ0QsBX5mXIubV+EIezNvoO5sE0tRGMhAA0jgVlxigrYvDhn/Be+WHDy/Iv+nVeFhp7DgWcGKxxeoCd4kU4til8P4iPPhdHHSw+/SeK9cfIGDZDNowv82hB1F3CmweE84HCI+Cwm17aWNMDEVMIQ5sWW85EjZztk+JdLODut+2xTYayzPAo7oxmXPsXi+bocmtsaxdrT2nyoUmRtHlkO4F1tUF0DSpxldBjMAryCLNwidZwHouq7rEFpEkm10aEdhlT2PiQxl0hCdJyaftlhu8AflNbWRb5s3UP0gWW/aclp9mITYNIANGSMlki4yHJsXEruw+fmqKtj7Tmey4hd2QhQEpBc27s6LsF+UXQRNGmc7FLmv2XAddA76G9nth0HZYXCjjX0L8vvH2f9aRd3YvL91ikEB1+nQrAjDA3LPJqhpJRJvzJa3M7ZIg8Q5d3alxYtlDdAiqj+HJOcjN+EEmcDjJPxs22+bLZ/sb8dTj7wUpuOIean57VQNfN8NYmltiIZYfmw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR18MB4129.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(38100700002)(6506007)(7696005)(55016002)(107886003)(83380400001)(9686003)(71200400001)(186003)(26005)(122000001)(110136005)(52536014)(66446008)(66476007)(66946007)(66556008)(54906003)(8676002)(76116006)(8936002)(86362001)(498600001)(33656002)(4326008)(2906002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWRtb0Z5Q1JIVnJjWHZ6Y29RV1V5cVRBeDdUTzFUTmowV1VQdGNtaHBFSm94?=
 =?utf-8?B?SXltMFlVWjc1akhpbHpYckpZMUZScktNVm5iQWVmTExPRmg2MkQzYlA3eFlS?=
 =?utf-8?B?SWJmN0thUmFvbEF0NUtnNVJnaTlnM1NJam5pSTh3K05JSUt5bUlmNGNMNkl2?=
 =?utf-8?B?T3ZwYTRjOUxNMy9KMGNiTFg4VDRXY2pITUQ1Uk1qM2ZZUGxyWnF0WDNQYS9r?=
 =?utf-8?B?cTBGbDJoQlF2aGVlRjdqNWdRVHF4OXJTcm40UktNaFZ5VW9QQzZmY0k2M2Vi?=
 =?utf-8?B?Uzc1WGg1ZUZvclNnU2ZndU0rM0xMWDVyMEFMaWxHNUE2cTlYU1BPeStsV3Nv?=
 =?utf-8?B?WVZsVXhVQi9YUkN0bG1xOFdXYkVZUHBwKzh4UmYrSHNLOEJILzFjZUZJV0dW?=
 =?utf-8?B?aTFUZ0llVDBiSFVWRE4yRG5vaTZ0Y3RuYkxDVys1RGc3UUpOQzgrVGZ3WWha?=
 =?utf-8?B?SHhia04rbjNtR1RQclkyWnJUMGdiM0xoUTVHNHhualp2NkJTd2J0RW9xcHll?=
 =?utf-8?B?cHR6c25uT1dWOFVEQlJlK3BveUI3bHdMeDNoZ3U4V1hJWjgxTWFoQnV5ZEZ1?=
 =?utf-8?B?bi9oRVdQMUtTQmVlVnJaVDRpTFJLMmJJWkhGaEdFSGtCQWhqYUQzbFhXdXNo?=
 =?utf-8?B?M0g0OVZKSDBRdGpqNi9QZEVSUWxGS3NTdGJDREswblBEYkxzK21vVjF5M08w?=
 =?utf-8?B?YWxGMGFsa1FpMmIvd0lla2Q0eHNjaFVHc1V3VUhIYmFOK2F1RTJjZis4VW1p?=
 =?utf-8?B?VEVSUDU4V0FXWTZjaWtySkNtVUpwekIvZTFMU1YxVDlNM1ZGK25ZWmpIUnRP?=
 =?utf-8?B?cHlyVW1tZm5hckVHMzFWVVZ4RFJKeWhiK3pWb1VVU2JhSmY4a2VJNjF3T0hn?=
 =?utf-8?B?OXBHamVDZVBFRUtBWU5xTyt1cUZpbUxFcjNzcUg4Ti8rR1BxWHExVE9hemRw?=
 =?utf-8?B?N1lwVHpOSW5uMVhsM1k4T1hKNVBFcWZwWnVJVFkrSGRaUEJTa2tqMUNpUkZr?=
 =?utf-8?B?RmY3S2ZnQkl6dHpLVjZLSDlEeXhtN1JsMmZqQ094M0puK1FCZUJvY3Q1Rzlx?=
 =?utf-8?B?K1dpamhWZlpvamFmSys4Ti80UldLd0tBNXg0MEpvNWRCZG9OV01lSlRMK2dz?=
 =?utf-8?B?MjdUc1BiQzVhSVNIOFdXaENvZ0kxRXFSeXBOUElqTGRQaVdtUWIxbGJVVGNJ?=
 =?utf-8?B?VWdQZlpuSDNJVXBEdWtlOWNWbWhwanZVZXZPN1F6d2VzSEJ5N1ZNUm9lRy9I?=
 =?utf-8?B?V0dwdGdiOUtoZERDWFBCYWcyMlFHd0F0Q2x6YzhwQmlndzhueDhGWVhnbmF2?=
 =?utf-8?B?VmR0dXdpenhpMXhqVzJrWFBYZDg5dlNBelp4Rld6bTBsVy92YVA5WDBRN2hW?=
 =?utf-8?B?dDZPZGdkVklwSStoVmdjaSs3SXRWUmhpdW03YitaSGlDUnc3T0NQclYxRXFi?=
 =?utf-8?B?ck41UkZob0E2SVRwMkN3c2ZZNUtzWUtHN3RaM0RnVVM1YzNFRUVGSWVQd1NX?=
 =?utf-8?B?V1NqaStyakJSVnYyWlBwMlYxdDNvYkJoSjZaM2pNUCtUNThaTnUyZFpUWGNR?=
 =?utf-8?B?MzBZb0N1Um5wOTBtd2xBbFFmdnp4Q1BNbkdpaDE5VUNpZmZYcEZjWkVJTDVp?=
 =?utf-8?B?MWtycDcvNWRCdTdoSEZqT3FMWDZXUFdKRFhvQy9hMEh0K1V5b01rclVSNy9V?=
 =?utf-8?B?RFNFM2FkREp1M252QXFBYS9jb0ZHSGNuc1Mvc3V2VmdCeWRZa2JyVVdRUW1K?=
 =?utf-8?Q?zaKKEy8d7Bwqm2IJ9iqamKSDbUE6jqGo6XCasJE?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4129.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89920ea8-63c8-43b9-d6de-08d92f60501e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 18:14:55.5935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+qEEkVKeKN9dCqGGMsFY1177xP0Bwt2eLwOOuww/bC1oXKYaRLl+Pcbw9FDo3o/Byl/AGk+v5cw8RbmgqMM9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3207
X-Proofpoint-GUID: Lf5gw-ZF40Fjtde4LwlQbN1hH6SvNKaP
X-Proofpoint-ORIG-GUID: Lf5gw-ZF40Fjtde4LwlQbN1hH6SvNKaP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-14_12:2021-06-14,
 2021-06-14 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_111505_840393_F9767D4C 
X-CRM114-Status: GOOD (  13.64  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Sagi Grimberg <sagi@grimberg.me>
> Sent: Monday, June 14, 2021 7:45 PM
> 
> 
> >> OK, it seems that the issue is that we are submitting I/O in atomic
> >> context. This should be more appropriate...
> >
> > Thanks Sagi, this seems to work. I'm still hitting some other issues where in
> some cases reconnect fails, but I'm
> > Collecting more info.
> 
> Same type of failures?
No, something else. 
After recovery completes, I'm getting the following errors on initiator side without any messages on target: 
[14678.618025] nvme nvme2: Connect rejected: status -104 (reset by remote host).
[14678.619350] nvme nvme2: rdma connection establishment failed (-104)
[14678.622274] nvme nvme2: Failed reconnect attempt 6
[14678.623623] nvme nvme2: Reconnecting in 10 seconds...
[14751.304247] nvme nvme2: I/O 0 QID 0 timeout
[14751.305749] nvme nvme2: Connect command failed, error wo/DNR bit: 881
[14751.307240] nvme nvme2: failed to connect queue: 0 ret=881
[14751.310497] nvme nvme2: Failed reconnect attempt 7
[14751.312174] nvme nvme2: Reconnecting in 10 seconds...
[14825.032645] nvme nvme2: I/O 1 QID 0 timeout


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
