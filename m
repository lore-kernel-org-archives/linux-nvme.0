Return-Path: <SRS0=1D85=OM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E62C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:34:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F5F61153
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Sep 2021 13:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57F5F61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3euK5n01Gnfar0sqhVcNnwtz1so7K9bCvRUKd80S26I=; b=zMlRyHVA37UNNq
	wQ9TkBH1TQAq4c6ZpY8MqA7m4uG5Z5Gi/ZrCVUnJPCMnqWDNlrn5RD/FuuSB8P3NXqubMgDczGpyY
	mtQzgx+8e5z0WUzEnodjZ8hPOEuVQiD6niH+jxvYPRc9TCh16HiGNOH90P7Snz8J0s+JphJqyce0V
	2JOOBZvo23OnBno2l0Fg6dW6Wv4QbHv4tmhklB5XlSsHapj5iMY30ouXKZp0RoELGI4MCKdECZp4k
	LTUu6q+dPX3nlU5r55LJ2WoQiaNOSK0RIk9UJjlol/3SFSum+Bkp7nu68fQ3ImnC/Wkr/4frvH8LC
	lg8WPGwHMScO0JzgdexQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mT2OM-008diZ-Ll; Wed, 22 Sep 2021 13:34:30 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2OJ-008dhP-9n
 for linux-nvme@lists.infradead.org; Wed, 22 Sep 2021 13:34:29 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MD7IPx021872; 
 Wed, 22 Sep 2021 13:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pFkT3c05Rm9hY5oZ/4U8HnZlCA15jGRgzMyhsLFqU58=;
 b=oPoALXblE0YR9V6mNlAeacvXgCyPPhwB6+lTbbyf6fm+vgnkKF9g1EBvtOEvwZjnHpNG
 LUsid8853GZoEM1sbT+68u3bQBRRBIXU0FCN0W21mTKw9os5rnr+0ILqFGNniBH+l9Zl
 IHBMPDRgwRRd9XTDmrGw1xfO2klNcD6zy5MnHxO6juUk3GdrXAyWRVYHz1eRSJzqQwLD
 Wkx+y17oFSxmfcJ0Yq60uiesfbVYvYqQWk0MAuRtfK16+5TNBtZAezd3Xb99s8iFZgIr
 6t140jvaGyMlYmgtGKf1GqoO20zrpwLA4eH5Cncv+w+70plcZ9Uj0rfPtZFkXRo67gdU kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4p3uun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:34:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MDVb9v178819;
 Wed, 22 Sep 2021 13:34:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
 by userp3030.oracle.com with ESMTP id 3b7q5my7ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Sep 2021 13:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GU1mCcIaugegdRK9deQW44xe47BrUGDyDFsGKzJoZTOq4f8QT1Y22hHwTPuGzg+tXvOzYyI6qr0uI3W0q2R1lO/T+wbjFBv7HxLwwONf2DsxMHLzhSpG6r6z7j92R8aJnxBhYQlC8Q9LI/5ofHM7ZsyMvKZzWskhFF13Tcd5hSMHaaq9O5l8YcEvh8mQjLmv2UTI7PD8WAe/+45/hVC2790oShePiIj5xtKaSglqJCoWty4wHsT2qRznNuWQSuJUW3m1BR+aMCw+G3bHSn9d455WDYQbdJOxDnC9qGoIPR2vOyPMkZS87u+vdmxrob7wrr8o0mrwy8pxuVP9ZnVXvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=pFkT3c05Rm9hY5oZ/4U8HnZlCA15jGRgzMyhsLFqU58=;
 b=Vog9oFVPGt1K85iz14StTIxRQHnuRJoZif5MIur0g7z99KhTG8qQNp4y79wRL9vqs08lKkV7MxmazKYdqF39FDiqZlL5uaQHU34xQvKicxSe545zJ4CXjVFY8D3fzVrXD+XgXtulJWzJi4j8GPmMMltyrzdD/tImrkjRYPsERb93XnDoZDPI+0GGCJBgCsTaPdCVNDX/4utjWB0xNu85faY1l0VTZKbg7qE7OUS6l24X9JI7u4JuvCOxmRQ1gNdk7hXjPVSbBLgSUe9utW8JRHHZZlvrY1KU7zFe2asejQdq6oQQiZ18SirtfGK/vmeZkmntF8klT6Sn9N4iR3mWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFkT3c05Rm9hY5oZ/4U8HnZlCA15jGRgzMyhsLFqU58=;
 b=rNuMsmmtw9hoSm0i6YxXWwuqZI7faa9xVHtRAe5HdVPsIzGBEXmxAtTsm7BVt8iu/fKGvBDAdqDu8m16MBQREX7uqqxr1W42FWM9/A0nP3UuleOs+7jvFxUHDv1LAG9V5wv9Sic50mezg+ZYJAVIpBeB3TRaf9Y/YEXhessKmC0=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SN6PR10MB2768.namprd10.prod.outlook.com (2603:10b6:805:4a::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 13:34:14 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::74c8:89c0:65b:bf6f%7]) with mapi id 15.20.4544.015; Wed, 22 Sep 2021
 13:34:13 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/6] nvme: expose subsystem type in sysfs attribute
 'subtype'
Thread-Topic: [PATCH 4/6] nvme: expose subsystem type in sysfs attribute
 'subtype'
Thread-Index: AQHXrv0IcV7mhVqsTE+ReSvvGeuRRKuwDxWA
Date: Wed, 22 Sep 2021 13:34:13 +0000
Message-ID: <E3B4D716-8EBD-44D1-8A5F-A1E870FC1E9C@oracle.com>
References: <20210921151529.29419-1-hare@suse.de>
 <20210921151529.29419-5-hare@suse.de>
In-Reply-To: <20210921151529.29419-5-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa3f268-0486-467b-9f63-08d97dcdaaef
x-ms-traffictypediagnostic: SN6PR10MB2768:
x-microsoft-antispam-prvs: <SN6PR10MB276874A2A1F9DEF9823D6B2DE6A29@SN6PR10MB2768.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dbHvCJLWS4Fr9xYQS1Bpvyo4YcO+HiaDtfmLZ5gSmhVgockLiJuDHbiy2fMQF/DkftnnheBo5LrEtN3D0wjCWI01cvT6x5xDUUr+B2Sfy4tOCYPs7XYT2oowAgce+KxEZynvdtkwg8e+fM2BIRiFbg66ON2qfKWvyj93xqlvHSvAxoyiYlQTRDQSU7Q8DHDD3300bKc7xYPhvwUehsSwpLhTvV4ak13fPqQ8VEyJA+mhXvbIyKLqTJZNy4Dgfq5S5qzk/tCy2sbCJaNicLQohbEe9nYEGmCxEGfpqjx0XPQBlEh/JC1wjbXXrijfzmq9dwGvuZZBONcGm0HsOrlAOeBe5giOP1U4ie2+NCbbzVv9V2zOg+wpt8WqOaENB+BR/nT8/JI6uJX7lsMjA04h+fbo9XZR9akh/e3r7mU8qGdbqtKaNdoRZa9v1CcAnCUTRMHTm6d9em0QsZqqf3ep4p9oKmY26ODYGKi5IbiKASEElwc0ENpYVxpW6hIX+LQXtUHwxMBHCkFSKAU6u4IaHF6EocegeOKsYAFLPmFpIBiQqiiSjZSpgLctt3Kxx8ygOTzDRO7QWp+Ex3abor79POcMn0Cd8nYdZypA5lK2PT8f2Ywz5N7pgqiCGRLy+i25h7NssL6XJY5SukJISFkXodnhYpNDjj8VffcdyWTcPHC1bgQgsMzblUY6rEx/Q+k3A4bcrwsrvnhpKTtVoxQNgQGXI5vEwrYz9x541G8gRr+L/5BZFSx3iVqda5+/FPwMJDtSoT8AZmLd6fybfGqKU8VHGzFSoCcwWXcqT9/FqFN0Tm9JrsS154fj99QsgxpQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(66446008)(53546011)(66946007)(6506007)(64756008)(76116006)(2906002)(8936002)(71200400001)(66556008)(66476007)(122000001)(38100700002)(966005)(316002)(508600001)(38070700005)(44832011)(54906003)(36756003)(186003)(5660300002)(8676002)(4326008)(26005)(33656002)(6486002)(86362001)(6512007)(2616005)(6916009)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Hy6WjP+5Y7Gfb0PPQgezOqab8DAzZBIKo7rhMwa0B+ew3QDv/T+k0XYZF1w?=
 =?us-ascii?Q?ucQoaFpJCq7rFroa9e31kxgv3tCSRiDoGDXMoB8qPt2DPWb9uzN6VVJnwclj?=
 =?us-ascii?Q?bWR7ktEQxlL91kwUnt7YUB+6T0k1nR60dx6DomUKwSf28QfU9HHv9pu3brRH?=
 =?us-ascii?Q?oKqLuKA6eUYs+Fad+2g0482oSleA9xnYR3TpRzr1odbJkovJ2s4hrBBJXara?=
 =?us-ascii?Q?7/acsBrg1Z+Yd97ptmd2+bsB04PuUcJuRBEukL2ql9sbqZq6jYEzaaLYxG+Q?=
 =?us-ascii?Q?3/c/++8v9WLyDPAowz1GxSzf0ornIC5/k0xlSyBiYmjXVkdFHQy7WBRCElqP?=
 =?us-ascii?Q?dkfhqu459hBAKU2asb8IrFxUea5oebExPNQxXl3Vvrcbu90qlvDwY8tlB2dg?=
 =?us-ascii?Q?jg6zlvAKm/gU0RSBXV8EdB2gEr6zpYhsdL97dGsAtQRz/JzhxzSgSaSyI8ZE?=
 =?us-ascii?Q?jM3lmYQfdBnsEhZM/5yOEKVOjXYd6DMGFTt2HJ4WTHm3TVUiZwqFRpVDgXSv?=
 =?us-ascii?Q?2E1YHZ9EfycrPgf7vZKjFMSDXYl4h9JbT2j27CsGWNZhMZYxdKC5N/c2dJBn?=
 =?us-ascii?Q?1seaQ88qREACSdT+QYmO0OvGYpT9NlZu0T2pTS7zO7H1mU7XVeZLz1dclalu?=
 =?us-ascii?Q?NnEO/O24U12w/5PGRfp0uSaGx7noR9P94kjb7W0kP37omvyDLou7SxkkxEiZ?=
 =?us-ascii?Q?ovlkci3g/eqTMmMJZgvD8lbVU0PawHkBCC6W6QPp3GAtB/pIYsHsgXiT55w4?=
 =?us-ascii?Q?BKdfbP4cwo07xTZVVTki+ZF4QTeskbKGd1mO2aow/Dhwzykvmx7D4tevG4Xz?=
 =?us-ascii?Q?343HYPfDtQfdOX3wpt5lHeKF3pvskpQMdJ1h4Y8PNsUMr8i0AwuIXTsKZKPF?=
 =?us-ascii?Q?7t92M5DLbrzcm9xwTfTgHvmHRaJVwSwwQtW54a4cyXA1PnnNoPt+bf3x22MX?=
 =?us-ascii?Q?Oq/GE+fJD2hRAmi1ID8ReMHUawZFzTbuParMjCH2lL8XJMaWl5Ka1FcmI9tl?=
 =?us-ascii?Q?vd0V7lEaM7Is63ys+PLi6anaOEY7a5TfEKKgVKZ6uRGrs0OTQlVGrqqqWEbS?=
 =?us-ascii?Q?FrBJyD1qqTG8CRrtDO3X5D8KP1HJqFIgIo1D9oLfk9ig45WXWXXE9j7FQTGl?=
 =?us-ascii?Q?dfgiOhVf+X5g4gDoMPsad6usTBj4Pyjk2gxtL7TWP/hhUYz5EWZmIWNiJbFs?=
 =?us-ascii?Q?1QDJPu1sw2QQMFWzvX7ulFsmoIm++1GHkEkSP6wsrDquq2O8MLyUFc6jW8i+?=
 =?us-ascii?Q?3BgGvvlos3kd2CyT/GZ6trJ32DqDqfIffubreIXAZsF1OwpON+rGlfdIwjJ9?=
 =?us-ascii?Q?agPHCsJ9CHnPgVVayu6xamgGkYvkkFc7F4hMUa70MpqtrQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <11A72FC818303942B4501E92AD6C2EEA@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa3f268-0486-467b-9f63-08d97dcdaaef
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 13:34:13.8594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJZp0Wdb9Zx+N1g7gkoDDefxj8euolS65g3DCap4JJgcXdGP0oFV2oxhAM1nmiUXbENhXEiLvKkZkCP/tPn6Om3dOZ3pWtjQd2XH7XQZ9II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2768
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220096
X-Proofpoint-GUID: mWPR0qY6Q_VRu8DbvzicHc_UmpgdEeuq
X-Proofpoint-ORIG-GUID: mWPR0qY6Q_VRu8DbvzicHc_UmpgdEeuq
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210922_063427_520978_E6F5D7E9 
X-CRM114-Status: GOOD (  31.18  )
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



> On Sep 21, 2021, at 10:15 AM, Hannes Reinecke <hare@suse.de> wrote:
> 
> With unique discovery controller NQNs we cannot distinguish the
> subsystem type by the NQN alone, but need to check the subsystem
> type, too.
> So expose the subsystem type in a new sysfs attribute 'subtype'.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
> drivers/nvme/host/core.c | 27 +++++++++++++++++++++++++++
> drivers/nvme/host/nvme.h |  1 +
> 2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e486845d2c7e..1ed1b7be2812 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2598,6 +2598,24 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
> }
> static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
> 
> +static ssize_t nvme_subsys_show_subtype(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct nvme_subsystem *subsys =
> +		container_of(dev, struct nvme_subsystem, dev);
> +
> +	switch (subsys->subtype) {
> +	case NVME_NQN_DISC:
> +		return sysfs_emit(buf, "discovery\n");
> +	case NVME_NQN_NVME:
> +		return sysfs_emit(buf, "nvm\n");
> +	default:
> +		return sysfs_emit(buf, "reserved\n");
> +	}
> +}
> +static SUBSYS_ATTR_RO(subtype, S_IRUGO, nvme_subsys_show_subtype);
> +
> #define nvme_subsys_show_str_function(field)				\
> static ssize_t subsys_##field##_show(struct device *dev,		\
> 			    struct device_attribute *attr, char *buf)	\
> @@ -2618,6 +2636,7 @@ static struct attribute *nvme_subsys_attrs[] = {
> 	&subsys_attr_serial.attr,
> 	&subsys_attr_firmware_rev.attr,
> 	&subsys_attr_subsysnqn.attr,
> +	&subsys_attr_subtype.attr,
> #ifdef CONFIG_NVME_MULTIPATH
> 	&subsys_attr_iopolicy.attr,
> #endif
> @@ -2688,6 +2707,14 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> 	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
> 	subsys->vendor_id = le16_to_cpu(id->vid);
> 	subsys->cmic = id->cmic;
> +
> +	/* Versions prior to 1.4 don't necessarily report a valid type */
> +	if (id->cntrltype == NVME_CTRL_DISC ||
> +	    !strcmp(subsys->subnqn, NVME_DISC_SUBSYS_NAME))
> +		subsys->subtype = NVME_NQN_DISC;
> +	else
> +		subsys->subtype = NVME_NQN_NVME;
> +
> 	subsys->awupf = le16_to_cpu(id->awupf);
> #ifdef CONFIG_NVME_MULTIPATH
> 	subsys->iopolicy = NVME_IOPOLICY_NUMA;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9871c0c9374c..2c7a77f600f8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -366,6 +366,7 @@ struct nvme_subsystem {
> 	char			model[40];
> 	char			firmware_rev[8];
> 	u8			cmic;
> +	enum nvme_subsys_type	subtype;
> 	u16			vendor_id;
> 	u16			awupf;	/* 0's based awupf value. */
> 	struct ida		ns_ida;
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks Good. 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
