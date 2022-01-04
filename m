Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB31C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jan 2022 18:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0kjW5pVkfh84bY4Oh4jTDHMHG+GXIkNDfWA8Z3gscv0=; b=s5oB0eNBT11MtLQfX3f5N+LKZ9
	pEpPoeb7v8pRSAVnhlHQF3gNT4icoXzTYPBQ3NhDNWHIG+t8uhs0wRhEJx29YKbN9/l2HyKuLCKw+
	BVE7p9xrewwjltfNW+CjGR1fWdRrOZphwVZW7+FJlsaNg7fPDXcXwtJT9+MkakzEaYVeMzdrvGUPR
	G8vnZYHDPP1hFdKAf4g81WrDMru4zbpiA18zgGBXw8heR5kmSmAQmbTwmdy+XoWMek1jfFXSyomvI
	/ncAXX7IuvoIiwm0sVtD/8FcyTsyVlH0sW/MQp6Bh84RseJ61CShuIrVg9IJYqYzaMkKEQZtgDFLA
	+YEcUSoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n4oOa-00CSgg-Do; Tue, 04 Jan 2022 18:18:52 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4oOS-00CSgF-O1
 for linux-nvme@lists.infradead.org; Tue, 04 Jan 2022 18:18:46 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204GJAdx032284; 
 Tue, 4 Jan 2022 18:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0kjW5pVkfh84bY4Oh4jTDHMHG+GXIkNDfWA8Z3gscv0=;
 b=xvEtVThisXH9NiTas2AAH+c0WDQTxTGZ+DR73Kgnc0h3wYfWyLBIhk6W7r4QknBP+B12
 cjYUqmnOdskd/ykdEfhw9WG0u69PNGpIv3QE4s64SmWRvybkaHCXQtkyb7Cp8Z/OPQDg
 KXHRHvgbwvJWBU94gqgULUpiiBO7B24P851LdESeQtGMcuGTqaldVbiFpAoLrwMTgFJO
 4NNG6PiP5E5wuZa/a9cE0Th0EV7F2ftO2EkayXKW0DC27s9TEdJC1F5aJxoucBnuzijV
 qNJDh17YKuHtGhfUJyWvjb6hcHGuCTer42Lihe6qLvsaR/2ktmSsFbRsLXHmOJOMvFau oA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dc8q7t6p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jan 2022 18:18:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 204IFFpd068588;
 Tue, 4 Jan 2022 18:18:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by userp3020.oracle.com with ESMTP id 3dagdnxvaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Jan 2022 18:18:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD+yPVXh2qw7hMRxg0QG83jxXenC0lGKxHl+xC1j4yXqQQwPeMl/4d+dGWQsSSVGccS9+qjYK6lEW6aLP8JoOZhkun/4fBGObDoD6qVjCS5Suvuw7+QC5mfgVFVry1Vh9bu3m5hFhapt+eRYgeRR/KqBSoZP9HCtutggUBLqa0K3+E2v3UYwZ+SMRhBgiiYIZOk1FJj87RoXHLzRUfZ/vWAobOysO2iWWlQzO8V6sE5kVfa9yhPBw+BEf1XXZfxgQWl1sQOZGlK+DGNa0yuPji7BDLPs02QKVaCfzz1G4wlTsXjzfRjuz1WrzF51TR+Io41OLKitX5275vWJhF19XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kjW5pVkfh84bY4Oh4jTDHMHG+GXIkNDfWA8Z3gscv0=;
 b=XhV+mrtYwd6gMgRAXoQwIASL6wmvJeHVF5IR3oNQeALD46bnOVjDtAmgZMX+eFHyBj+aY3NNkBlucrHK9R7HB6XoQ6IMQfEnYvURz8qf6UMuxXAUHpeblM8tH0UH+flhs4IC5pt1bR8KxgR4U4LjVrV5b4iAegjGUoQS1Z/yX9oKPVAHHvfkfizVbgGO8zU25eLOcn6vtOwewoI//DnPhA5TEJEKCAtdETgrlFOofFQfdCDBU8EwdtD9lxOMXqoIh8IkOspx2kYK10OL3qV6BFx2GMgPrBsu57hSrxeXsZZOcRtXWaC7PZng8ac6jKCoLgkYFkWvLveca+8jGuHqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kjW5pVkfh84bY4Oh4jTDHMHG+GXIkNDfWA8Z3gscv0=;
 b=D5aKvtvk2jJy/sGup0CX937MbyjRi8KbuPOVLHL8QdBNHCm01mibfzCYLm+GQxQjKBtH84b3DiViQmHJrco24nb3o9LecRtTz5qvBgtY8yhlNffZWT0KE3A4QS3tzlCQyOoXa/39MM5xq3D9aapmKblpD040hxUGo/vW+s+W41k=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by BYAPR10MB3656.namprd10.prod.outlook.com (2603:10b6:a03:11e::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Tue, 4 Jan
 2022 18:18:27 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::d89d:7380:8d67:aee0]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::d89d:7380:8d67:aee0%5]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 18:18:27 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 1/1] nvme: Add verbose error logging
Thread-Topic: [PATCH V2 1/1] nvme: Add verbose error logging
Thread-Index: AQHX+Egn8yeQpLGizE+cuDdhywaQP6xGhyQAgAy3OgA=
Date: Tue, 4 Jan 2022 18:18:27 +0000
Message-ID: <18CFFBBB-81A4-4F0D-9F94-B543F2D83BD8@oracle.com>
References: <20211223215726.71096-1-alan.adamson@oracle.com>
 <20211223215726.71096-2-alan.adamson@oracle.com>
 <20211227160732.GB2207198@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20211227160732.GB2207198@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 643ae8ca-0828-4b25-5ecb-08d9cfae9a6b
x-ms-traffictypediagnostic: BYAPR10MB3656:EE_
x-microsoft-antispam-prvs: <BYAPR10MB3656DBEEE3D8737953ED8B23F44A9@BYAPR10MB3656.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qPraccHist8V6fZH0Y9UFF+Ysm6ilwm0trp4i+E90RN641HCj+KvQ4wntXkFePflBI7cLEa3WnQerc06hzyAWcL8ERHx21gpcdbqivD89luSjtBQLi3/8uFR4HRIrW+t8hTABNvD1tHldDUOVLJP9Ks6A5woncK38P6pniVmXcfCRrb6uhP8sFqF2ullmzhtZAjuxlA0nQnGQ/+OFQyilnYeuU8MNkesOClxHzT4qXJS/p7yEpoFknTMSwE+CPr4rfuSyNEdNG3N/+P62niSRsyplqU95mmNeH19ytz86lxE/i8TSD5U6s5AtoEx9QCZ6JVIX22ff23rRRC3TxEUBU5u12uSw0hMcAqU1N86hEmog89C6t6Kb7/hsv828KdW5dNuz9b7EqtwWLGNPJOBNugws3rojxW9vDsX9oZQ0zw5o23P4Q844nOsvpbEA/PzUmGCOpJbODIP8pu/FmKkhUl2kXjEvV836xVBu9a1QvvK4tIZEnsD20297Wrr8taQUJKrnQmY45adcfMJk7wR3hPKg+PJFvwsQdPZ+uZ+QQa5fyfKTIze7rZO4/6ogyd2hnipO83Fx/1RBxQ8W1Y1nZgzQSc4crspwP1xgG/VfrQMQYfv4tUBVDJYmnMk+76NHKL9HXpkuH6nyRKEY7+5nebvbEi0Uext0aQXW77hufFkmhAH0ICkaY/ULFPB58VlRdJz0eZnxtOqQFzIjSAazsl0wgCw78B+ZYfMfkXkWM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(64756008)(6512007)(66556008)(508600001)(76116006)(122000001)(66476007)(54906003)(71200400001)(186003)(8676002)(6916009)(66446008)(33656002)(6486002)(2616005)(91956017)(316002)(66946007)(83380400001)(8936002)(2906002)(6506007)(53546011)(44832011)(38070700005)(38100700002)(5660300002)(4326008)(86362001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDBVWmdDR2VmOE9hQlBEN1ZvNWFCRlVrZGxTam50QkpaaXlHdDcyMkFjYk5F?=
 =?utf-8?B?ZnRkb0xJRVVORzhMYnMvc255ajJUbkpCdXdxTU1IdGlTQlJycjNZbVZrQ1Rk?=
 =?utf-8?B?eER1Ni9DUjBHVmw0RndKWmdacFBZQTdFMU9YWlpTbnArMy9sbWhGamFPY3Zm?=
 =?utf-8?B?TldxTm9CODZERVk5dFZuZDk5SWliSVJQOENhMUwvY3kvZnBXampKREZSaDRn?=
 =?utf-8?B?M3RSOFBoYTdBaFVnYi9FSU9xMm8yVE1BVWh3a1p0TzU4ZWhmQUI5OFc1VkpY?=
 =?utf-8?B?OUhCSGxpZXIxNkE0U1RiNGtOWEdMbDROa1dvcFQ2cnNKTFk3M0JkRFNQY1c0?=
 =?utf-8?B?QWZIUWltRll2dytEZnZhMkk0NGZ5NEQ5MXNpckNuekFpT2hic0Q3S3QzNW1u?=
 =?utf-8?B?NGZLT2J4WUZCQ3dZUlRYQUtFMU5BVWFWcFM0Zlk0cEZxV2lDcXV3WWlqOW5Y?=
 =?utf-8?B?YkVLZzd3VmtaMFh1MG9YRHFrYmlsTjFTTmEyTnl0Z0dhbDBmVmgwMlVCUzBS?=
 =?utf-8?B?em0zcHFiK3VYRFd1b2JMbUdnZHdheGtDS2VrMTBrekovMVJra3ExaFBITGZE?=
 =?utf-8?B?Nlc5Q0dJUTZVcDNzUFpjZFJyZUVSWS9kYUNEM3J6Sk9TT1Z4S2U1Qm9Da01N?=
 =?utf-8?B?cElXYllZZnNZNCtsRmZFVE54MU4xcEZGYjdVdWFLd2t1dHBkR1R1SGFHc0Zm?=
 =?utf-8?B?SkRNY1Z5b3NDck9kZVBmZnVETW1sekpqN0ZiWjVNQm9Dd0FjcWE1NlZ0cldJ?=
 =?utf-8?B?MncrNW1nVnY1N21QR3AvRGtXaXcyelZGNk9lOGxLTXJVV1FGSHRMQlhWZzVm?=
 =?utf-8?B?QXRrWFhJMWZnZzJUWWhXYzhYd1BYMHVoZDNTeEdIcU5jb0IwcHovK0I4UWRs?=
 =?utf-8?B?K2RmMm5CbHloTVBFWSsvL25tczBNZ253T1Y4S1RVVGJHaXBVWnNHZExGVjBV?=
 =?utf-8?B?MmpodU0yUlRzeXU5d2dqdVB0TVlCVHdhNTh6d0lndWhiYk1PVi8waEcwYkov?=
 =?utf-8?B?ZlluY1FZL2xGVDNMNDI0Z2hMUThqdEVWR2VZNDFGZXVPUlJ6MmVRNlR5RWtx?=
 =?utf-8?B?N081Qzh5ZmlYMkd1OFVhYnBLN0xHajdmUnJlQXVxdENiMmh0RVJyckxyOUcy?=
 =?utf-8?B?TXdIVkIwckZSYUhXNkhlS2JlZkJrWG4raDlKUEpyQThzT0VvZVdNK0lKL3Iv?=
 =?utf-8?B?cVczQ3BuNzVCMGdCZlNrUHphanNjaDRQYzFFUFNHamRnQlVCdDFEUGFYNith?=
 =?utf-8?B?eFdiaVVKK0E0L1Qrc2NrQU84QkkxMGhEelExNTJYU1Q3ZGFuTHlhU0VRL1hp?=
 =?utf-8?B?N0VKVEQ4SjcvMkhkRC9GcUgrbE5LV0Vrd1c4akhiMVc2UmlIQnJNdXlXS2xJ?=
 =?utf-8?B?WG9XNm44VFNsT2k4ZWR0dWdlck1HK3ZBUS93NWdzMk50Mk9KVERvb09IZmhj?=
 =?utf-8?B?bWs0ZEpqSmprSS9idTgwUVhxR2JLYjN0Y2FRQVVmaFFKbzh5a2tIRlJLanZC?=
 =?utf-8?B?bTBvWkgxd0JWTlJ0ZWM4NTJnTWJ0UkRlTnp3cWdJdWJOc0NhdFNIN3psY2xM?=
 =?utf-8?B?N0NFbElYTzliLzd6ZVpteVNPZFZmQXc3blhiMWU1WS9qYTJ2c09kc3VwWUs5?=
 =?utf-8?B?STlZV3puSGhyTFh6RmUrYk5uTm10ZEk0U2hKTVBPNzM0b3RqZE5tOFlnMXpY?=
 =?utf-8?B?SDVBTDRFR3lJWW1mM3pWbENxb1YwOHh6ZVVxOTgvTlMrdFVNWHR1TEN0ekEx?=
 =?utf-8?B?OVI0MHdjUW50VE5MVExWUitmbUtmRjNQQVlib0t1dS8xRUtKOS9SUzFPUW9r?=
 =?utf-8?B?Q0ptc2pIQkJZb1A3Z0V6d0dxcmNUQmxTdkQ2dDVKYzJxMkNLT3BkVzFpcXRz?=
 =?utf-8?B?bmc2ZG1iaGJmeXI1ZUpZN0V4blpFbko0V3hRQmw3Qkw4VE1JVzgxWkRIb2Qv?=
 =?utf-8?B?eTh3T3FNVkpDTElncDVtbHJnK0pHanhFTFpZZUhuanpUWUNXMFVTUkI5VHVQ?=
 =?utf-8?B?aVEzY2NvM1VVbGtkNnViOW1wRVlsblRGbmltQlhkQUtub01LRVdTelplTVJD?=
 =?utf-8?B?ZWtURGdBbllpei95SitrYVhrY3IvTnRMa3NWV1RJbmR0RjZxSzR0OTExQk9l?=
 =?utf-8?B?aVQweTZoZ1FJS09IUmxQS1VXV2l5RUUyR295a0tETU5BSER6SEh5cEc2REVF?=
 =?utf-8?B?OXFyM2VoclVjNGljWk5kbUlhazVVcHNLYTBTTThrNFVMNjZPeDhYWklMN1VO?=
 =?utf-8?B?c2UvRC9RYy9wWHI0YXFrN1c0anRBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9187DF02BB7AB46853D5EA9A26CCC41@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643ae8ca-0828-4b25-5ecb-08d9cfae9a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 18:18:27.0373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kTog2tjZvnpr432teOebZLjis2BDqqzOeqiQcNxNHXprgkUR3snVGqSAKdZiYuCq4kMbGHKFkv9EvyHWhfqC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3656
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040121
X-Proofpoint-GUID: ASDxlWuR8-lMcYbv8RtKdITTwSWTpOpS
X-Proofpoint-ORIG-GUID: ASDxlWuR8-lMcYbv8RtKdITTwSWTpOpS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220104_101844_815090_05EA3108 
X-CRM114-Status: GOOD (  23.63  )
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

DQoNCj4gT24gRGVjIDI3LCAyMDIxLCBhdCA4OjA3IEFNLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCBEZWMgMjMsIDIwMjEgYXQgMDE6NTc6MjZQ
TSAtMDgwMCwgQWxhbiBBZGFtc29uIHdyb3RlOg0KPj4gKw0KPj4gK3N0YXRpYyBjb25zdCBjaGFy
ICogY29uc3QgbnZtZV9lcnJvcnNbXSA9IHsNCj4+ICsJIlN1Y2Nlc3MiLA0KPj4gKwkiSW52YWxp
ZCBDb21tYW5kIE9wY29kZSIsDQo+PiArCSJJbnZhbGlkIEZpZWxkIGluIENvbW1hbmQiLA0KPj4g
KwkiQ29tbWFuZCBJRCBDb25mbGljdCIsDQo+PiArCSJEYXRhIFRyYW5zZmVyIEVycm9yIiwNCj4+
ICsJIkNvbW1hbmRzIEFib3J0ZWQgZHVlIHRvIFBvd2VyIExvc3MgTm90aWZpY2F0aW9uIiwNCj4+
ICsJIkludGVybmFsIEVycm9yIiwNCj4+ICsJIkNvbW1hbmQgQWJvcnQgUmVxdWVzdGVkIiwNCj4+
ICsJIkNvbW1hbmQgQWJvcnRlZCBkdWUgdG8gU1EgRGVsZXRpb24iLA0KPj4gKwkiQ29tbWFuZCBB
Ym9ydGVkIGR1ZSB0byBGYWlsZWQgRnVzZWQgQ29tbWFuZCIsDQo+PiArCSJDb21tYW5kIEFib3J0
ZWQgZHVlIHRvIE1pc3NpbmcgRnVzZWQgQ29tbWFuZCIsDQo+PiArCSJJbnZhbGlkIE5hbWVzcGFj
ZSBvciBGb3JtYXQiLA0KPj4gKwkiQ29tbWFuZCBTZXF1ZW5jZSBFcnJvciIsDQo+PiArCSJJbnZh
bGlkIFNHTCBTZWdtZW50IERlc2NyaXB0b3IiLA0KPj4gKwkiSW52YWxpZCBOdW1iZXIgb2YgU0dM
IERlc2NyaXB0b3JzIiwNCj4+ICsJIkRhdGEgU0dMIExlbmd0aCBJbnZhbGlkIiwNCj4+ICsJIk1l
dGFkYXRhIFNHTCBMZW5ndGggSW52YWxpZCIsDQo+PiArCSJTR0wgRGVzY3JpcHRvciBUeXBlIElu
dmFsaWQiLA0KPj4gKwkiSW52YWxpZCBVc2Ugb2YgQ29udHJvbGxlciBNZW1vcnkgQnVmZmVyIiwN
Cj4+ICsJIlBSUCBPZmZzZXQgSW52YWxpZCIsDQo+PiArCSJBdG9taWMgV3JpdGUgVW5pdCBFeGNl
ZWRlZCIsDQo+PiArCSJPcGVyYXRpb24gRGVuaWVkIiwNCj4+ICsJIlNHTCBPZmZzZXQgSW52YWxp
ZCIsDQo+PiArCSJSZXNlcnZlZCIsDQo+PiArCSJIb3N0IElkZW50aWZpZXIgSW5jb25zaXN0ZW50
IEZvcm1hdCIsDQo+PiArCSJLZWVwIEFsaXZlIFRpbWVvdXQgRXhwaXJlZCIsDQo+PiArCSJLZWVw
IEFsaXZlIFRpbWVvdXQgSW52YWxpZCIsDQo+PiArCSJDb21tYW5kIEFib3J0ZWQgZHVlIHRvIFBy
ZWVtcHQgYW5kIEFib3J0IiwNCj4+ICsJIlNhbml0aXplIEZhaWxlZCIsDQo+PiArCSJTYW5pdGl6
ZSBJbiBQcm9ncmVzcyIsDQo+PiArCSJTR0wgRGF0YSBCbG9jayBHcmFudWxhcml0eSBJbnZhbGlk
IiwNCj4+ICsJIkNvbW1hbmQgTm90IFN1cHBvcnRlZCBmb3IgUXVldWUgaW4gQ01CIiwNCj4+ICsJ
Ik5hbWVzcGFjZSBpcyBXcml0ZSBQcm90ZWN0ZWQiLA0KPj4gKwkiQ29tbWFuZCBJbnRlcnJ1cHRl
ZCIsDQo+PiArCSJUcmFuc2llbnQgVHJhbnNwb3J0IEVycm9yIiwNCj4+ICsJTlVMTCwgTlVMTCwg
TlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwgTlVMTCwNCj4gDQo+IFRyYWNraW5n
IHRoZXNlIE5VTEwncyBpcyBnb2luZyB0byBiZSBwcm9ibGVtYXRpYyBhbmQgZXJyb3IgcHJvbmUu
DQoNCkkgZG9u4oCZdCBkaXNhZ3JlZSwgZGVmaW5pdGVseSB3YXNu4oCZdCBmdW4gcHV0dGluZyB0
aGVtIGluIHRoZXJlOikNCg0KSWYgd2UgZG9u4oCZdCBkZWZpbmUgdGhlIE5VTExzLCB3aGF0IGhh
cHBlbnMgaWYgdGhlIGhhcmR3YXJlIHJlc3BvbmRzIHdpdGggYSB1bmRlZmluZWQgZXJyb3Igc3Rh
dHVzPyANCldlIHdpbGwgYXR0ZW1wdCB0byBsb2cgYSB1bmRlZmluZWQvbm9uLXN0cmluZy4NCg0K
QWxhbg0KDQo+IA0KPiBJIHJlY29tbWVuZCBpbmRleGluZyB0aGUgc3RyaW5ncyBhcyB5b3UgZGVm
aW5lIHRoZW0uIEZvciBleGFtcGxlOg0KPiANCj4gc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBu
dm1lX2Vycm9yc1tdID0gew0KPiAJW05WTUVfU0NfU1VDQ0VTU10gPSAiU3VjY2VzcyIsDQo+IAlb
TlZNRV9TQ19JTlZBTElEX09QQ09ERV0gPSAiSW52YWxpZCBDb21tYW5kIE9wY29kZSIsDQo+IA0K
PiBldGMuLi4NCj4gDQo+IFRoZW4geW91IGRvbid0IG5lZWQgdG8gYm90aGVyIHRyYWNraW5nIHRo
ZSB1bmRlZmluZWQgaW5kZXhlcyBvciBtYWtpbmcNCj4gc3VyZSBldmVyeXRoaW5nIGlzIGluIG9y
ZGVyLg0KDQo=

