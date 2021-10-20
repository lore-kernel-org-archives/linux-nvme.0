Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E74C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:35:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733F2611C7
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 13:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 733F2611C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=701qDPn7GmT1nCQLv1o3Y3K4NpRrrIARs+S5cP5iklc=; b=3VpeQEF4oYspLqwxyASYGJM5pR
	zLJzz9VLjMBg87VcH3uBFIdNSI29nsStVArNqrd6dMckX/98V6vEUT7vIq5Nz8Pck/jsTjlFyJC4w
	a7PTBvaRT4miIljZX/9a4XglZZIiTtM285kqfArXixu0wui93vVU4RLgajy9CGM8qaglL3RRHvFHx
	DSEj7zlLuAep3diLDwf8DCvSYi4XZT4QionpBp8/fClZ148vDT1T9z49+GIJL/SKYwoBitqL48Z0w
	jb4Sjicsf5upX43Yhiu9kBbfe30zhnsTpqKW0akYVIh/5oQZ1Jn5PKZeMeWIAAdPG8ZLiLtGutzF6
	b3lb/gZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdBkC-004cod-6b; Wed, 20 Oct 2021 13:35:00 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdBk4-004clP-2Y
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 13:34:53 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KDKAFJ018385; 
 Wed, 20 Oct 2021 13:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=701qDPn7GmT1nCQLv1o3Y3K4NpRrrIARs+S5cP5iklc=;
 b=LW/bcZcLSBdgLzP1PARfQwCojJN2d3N5WcTb7z3/APEJBTaL9uaJY9hxa6LWiIN0/9RD
 mMvLTzdlfnDRw10n9OTWGF0VP7jQkEz3vk5x50GchW8/2wrTkcWWUQnn/dyoyGuyleKo
 NWcE7LyW7iWuh24c3FIsdJAt5+qLj3xlzKzDon0oOT9eFJ8x3/Kf2vWWYGKs1WuTWpwQ
 w+Xm43su+0WE8sul2is3myBGJZsdsYK9a68o1W5wYwlcKu2xb47Hn1GVjqclUE4XQqhD
 mS/kgp3AjanJS5+LQR5/4lcT2SC2ypVSGxiUUFMOUhyj7Cxt149iXDilWrRpfew5DuAc qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3btkwj02pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:34:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KDLaIP143969;
 Wed, 20 Oct 2021 13:34:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by userp3030.oracle.com with ESMTP id 3bqkv023vv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 13:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0NIvqSf3ueMZ1U/rSpIn8j0cFftUSrDBM8E10F9XDHVaMRMyn80mUNCckB7P+bBsjOTANfXz0zDNq8HoTAAck9wDK+CxICwR8/lGojYKkIkcvXzyglDOzvKWU8J5LM5G3PJlR1Kc25iwOoJgty7cIfJ+hC0VD3ZUmV41nJgiD8CCCLDBNlUeHFIRitOUhHrWKW9eFm/ONAhp6Ly8p9BZKQrUDJK699rE2wmo6SbooufRKNbTckDtTg/equ64NWiq1Q4hhN+2HkCXOIL8tnUzi4Bzp1NV5rgsBoSXmqjqErdGLbI2dnXQ+fce19giXS1DO+FnuNJZviMnE3oR4BvrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=701qDPn7GmT1nCQLv1o3Y3K4NpRrrIARs+S5cP5iklc=;
 b=XoGjlfTlcIAqYmX8LX3VWtaZPDemH8DwD1669P5NLbmKmIutpBEJssXzCWjk6sax6BkkUbGPrMjwa/EI0pcBJ/SDIWTRQmnzUVoT2wJogu6B58UVlhzMADLgouMLzNkNIRHfOa804V5sdLklUuU8q5D+bDFaOBtgSDWnmutmRkqVOzJUda5n+q56Uj1ZZZ5JAGZajTG04gAlY7Fiua14wVWfPpa2ICOeeVliQ7Oi+gryGwHb6+MGxs6Lls1rJQfa2UOGBUfv76i/dj1luKlFPceKlQ3U7nzvMjTVTcJWDc9NJiCEMpBI3fZLK/KJyxG0aH7vvInpGEic76kotKx3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=701qDPn7GmT1nCQLv1o3Y3K4NpRrrIARs+S5cP5iklc=;
 b=l/W3AkqAY0Qxh9t57qqkun5yMRPLa04aVxORqBAcsOPeSOmtkVuVWjrOxm5kcb4/QWJxSvq8Y9zEY0jFvBfhjy6XVTOm2hcqCAlVI5zIpE/fT/61E6b6zFe2koHRirgBHgOLx+dFvhXUH3sEafvnEKo3vVHbvgJ99lI6lm+0vWs=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by BYAPR10MB2533.namprd10.prod.outlook.com (2603:10b6:a02:b4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 13:34:28 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::1f5:12bf:3985:e2b6%6]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 13:34:27 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "chaitanyak@nvidia.com"
 <chaitanyak@nvidia.com>, "israelr@nvidia.com" <israelr@nvidia.com>,
 "oren@nvidia.com" <oren@nvidia.com>, "jsmart2021@gmail.com"
 <jsmart2021@gmail.com>
Subject: Re: [PATCH 4/7] nvme-fabrics: introduce nvmf_error_recovery API
Thread-Topic: [PATCH 4/7] nvme-fabrics: introduce nvmf_error_recovery API
Thread-Index: AQHXxCiKCSQZMd0RBkS/C6SxWNwzE6vb5haA
Date: Wed, 20 Oct 2021 13:34:27 +0000
Message-ID: <9EB9163C-F08D-4343-A818-784493C26FE0@oracle.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-5-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-5-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34eb80f6-382d-4908-914f-08d993ce56e2
x-ms-traffictypediagnostic: BYAPR10MB2533:
x-microsoft-antispam-prvs: <BYAPR10MB2533710C4434DA8BC6FB3C42E6BE9@BYAPR10MB2533.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhzFdZ2BRqQFhFSajhiSh5+EQbjrMD7/ttGwBEOumue1qmZVzCTVhvdvnSRlDfy2oGPCwjlH5TfmMYixw8YxM76mGG0dKAsRjf8z4onhzAf0i2vPS+IrmUlbLsS6TMZ3YSvCCVoWPPJiY0BlecoVvwJ2GkGsUkhp+NP3WriB2SU9wIa1AJoIJsOd9AcY9HJNyEFCGhWZoQK39dwsoEoxipRoeTbOOsGj6377xFlVXKlchlvcDKZI+U2eVhehVbfBuuk3WLxwz/gwQtuTMeqUe0OgwJHs8oLt2s07q/0ZpxkFV/vM0zJv6PvO/5bvCoxd+Xbtj1O8d6ZOjJp44bcBLuLMypPXJtEHPAtlzxna1MPUM/NkfP5EdHpWvg94j6riLUa1uLuu2e9Khp0JGXshG0qj1i3DmjEO4DszoAUg7p8hzLuKBi8A4F0vDnGg/Yf4Ct/y2LlwJqrKYJH4VNxBf7cy2mFcW1mx0cDpAxEUo4cYun/l8RXUtEqXknbGekKKGAodKTZLHed9O1F7WYyhqda+cCuXm75Z53hwL7cGpM4TyjJnPaUrXdwc/HIM6XhbY8c/JFagAPC7jzprESwX96CMNgXicQgvE1arOjTWS4dva1mX+pxRQnC1ISYPZPMMC04CsOOwZHs0kXlqMSJ1ndnfEy+WI2HTZ9QLH8bncLHptekYvhfI3B2sdtDeuI+Tat/OTrOmI0AaKMxarGEV00Eig1d3oeY7yXSBHlhMnys=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2934.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33656002)(26005)(66446008)(186003)(6506007)(53546011)(6512007)(64756008)(2906002)(38070700005)(66946007)(508600001)(76116006)(4326008)(6486002)(86362001)(66476007)(66556008)(2616005)(36756003)(91956017)(38100700002)(71200400001)(5660300002)(316002)(54906003)(122000001)(8936002)(8676002)(6916009)(44832011)(83380400001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PTpS6Eo4jP/olGePj700ytJ06M+rimo5fkwWW9OMwnyyC8Uz6YijGlCVTm4r?=
 =?us-ascii?Q?lBa5ZKEW0dusSWo5/EPJ2Hm8LTi8w0+If0KUUIkYRv/2d1oaDxcFd6SrT6DT?=
 =?us-ascii?Q?6btIDsznbZjlUq/4LAljg5konp3TQgA9vdIIlazuHophiEI3GCyzWrQm3FD5?=
 =?us-ascii?Q?u/I9Z1xoieb52YAmWs+Tq2l+kTf2G3Lb/89DUe8yJ1FUToFLbWn3u+Cw2s3V?=
 =?us-ascii?Q?LYYkJrlvmFViOTH4OsttAJQ96KN5XjonmFdRwCAr1WtN57mBq3L2INBOeTzZ?=
 =?us-ascii?Q?keVwcN8ceEI+zmVKVv1rZzDwZc26PC3eK9UpqEwTDwjTZH2GUcP+gpkgQFa0?=
 =?us-ascii?Q?GiulWnciSsMkoK6XJLuvNlFy5IrCzll96DN8dKJFCtn0Yyb7ELdL6paWW/W2?=
 =?us-ascii?Q?DpMwiGEXH9vvRMNtzfWQL3Ms7hp0prw8qDzBblGvVwC6inA68OrdFy2XnQHJ?=
 =?us-ascii?Q?XxgCXX1B3+LQfvPPnvsK3DTWr20kTLSjFG1Ca1fEd0xScROzEe0Nq9u/jz/v?=
 =?us-ascii?Q?qQM3aEnSy3i+q8b2j5RT5q8kTprCtpdArH5T3OIeYPa9Z9nk6v/JVwjpDGXq?=
 =?us-ascii?Q?uwV+hgzbtDb5RPmETh1k+x4KSYz7k7o0fjPPgHeUN9kV5EPSVmzzWfOUM2xT?=
 =?us-ascii?Q?8loj3WH+YkBKmLOx7bR43odD0R75oJtb7JMshgioiRKi0GqnixveEs/qmKXd?=
 =?us-ascii?Q?PpE8ykILy0jX1SopQ/ssD7HrEDXDFi8qaTOwcMk03n+2xPBKzuVdk/X8KdPw?=
 =?us-ascii?Q?7J5fC+03T7UDIyKIpDE+g0fnp1c6WlmTRr9iZx3OB2mH15aI91IlYOFZ+Rij?=
 =?us-ascii?Q?7Zw1AW/7MAClW9V/BLISOzI4MNElJhFSXMT/yu7YeTav5bsduoSuyq++USbT?=
 =?us-ascii?Q?4erFCvUvOeZYtb4IJGrC/gxkRfpePEYWpLZlhoRBSy7ppwpXEpqxBrESQdtM?=
 =?us-ascii?Q?6pfknBRefKbLC6AW3Kv7CXDhXpfsfvWczJGbYKguKTnDM4b6UWs7LEL3OfHB?=
 =?us-ascii?Q?TKVRAtuMkiPO3Ukh4c0Nm9rbC2TWGeMsdxIRtMDcA4Zj3HqfN7YCSGayr1U/?=
 =?us-ascii?Q?aQE2AEnM2J/5r8s9OlbgIhcm94JdYn9so9fWLy4+AuApVUIIDKadzIoqIxgk?=
 =?us-ascii?Q?ziOGL52C0/0OjQ2QFlbk6ulKoG3/0/Y66vabfQCxTQzYKyR8ZvbVL+zvYaEQ?=
 =?us-ascii?Q?zbBEUMdZHtI/np2d0YCo2ZyQOwefjFXd+h5qFIRWYz/6SENc2sN7yuWXSEBo?=
 =?us-ascii?Q?zgH/uoK8qXzwExCYA6RcWLA7O7BqGid8PWf+Ym/A7+QBcy0RNVMNTrn4Vwyc?=
 =?us-ascii?Q?XmFQ1SXklmWJ5e9pKWIyfPBzlMrcy7n1seV+9gP1Ds8IXrhx1nEq5M//vPtX?=
 =?us-ascii?Q?l5NqedwpBn2gFauR2/9j0Oa3AqLgdyZopLeshSKeF7bMN/IDUNb7jZH8S7U7?=
 =?us-ascii?Q?p9ViwYa4ylqJbh/qy/ZweZF3P+0EijVZIm3RmHzvxpO+45azqDbykrJimcZD?=
 =?us-ascii?Q?pOk3DmlmEngeb2Tx65avq3hWV4ZHbEJG3xF+nfJUruofUC8SDQ86ftliw90A?=
 =?us-ascii?Q?0xNOIKN/5fUj/et+uy1QI4YMoPBWQGzqyfzqoNmHO/Tgn+z3+5lFfoRf2utg?=
 =?us-ascii?Q?Nb4t/lXj47Z7bfq/zj/VkmcVWQ4Llp4V0nF85NP8W9n4ubN2nZIZwnLMnela?=
 =?us-ascii?Q?ApvC/y2kH1j8F34vY+CSZmIpRI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <935C41D49517E94B95C13D66E7B65EAE@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34eb80f6-382d-4908-914f-08d993ce56e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 13:34:27.8171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37ufrP45aLh1Dxac6E9HUr7nV+9kSSshIX7oF3Za7M2Nqk4XZhpdbWm9nVp7WgjeHzC3IjoTmWvos5ZHPivOMjvYX+RPX3QhegLLZ3Hb/PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2533
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200078
X-Proofpoint-ORIG-GUID: 0qboIT9wQYTFbHWpBYhW7haYaKDp3OTW
X-Proofpoint-GUID: 0qboIT9wQYTFbHWpBYhW7haYaKDp3OTW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_063452_173065_865F751C 
X-CRM114-Status: GOOD (  27.75  )
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



> On Oct 18, 2021, at 8:40 AM, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>=20
> Error recovery mechanism is duplicated in RDMA and TCP transports. Move
> this logic to common code.
>=20
> Also update the RDMA/TCP transport drivers to use this API and remove
> the duplicated code.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> drivers/nvme/host/fabrics.c | 10 ++++++++++
> drivers/nvme/host/fabrics.h |  1 +
> drivers/nvme/host/rdma.c    | 25 ++++++++-----------------
> drivers/nvme/host/tcp.c     | 19 +++++--------------
> 4 files changed, 24 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 4a1ef67c6fb3..2edd086fa922 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -493,6 +493,16 @@ void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl=
)
> }
> EXPORT_SYMBOL_GPL(nvmf_reconnect_or_remove);
>=20
> +void nvmf_error_recovery(struct nvme_ctrl *ctrl)
> +{
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +		return;
> +
> +	dev_warn(ctrl->device, "starting error recovery\n");
> +	queue_work(nvme_reset_wq, &ctrl->err_work);
> +}
> +EXPORT_SYMBOL_GPL(nvmf_error_recovery);
> +
> /**
>  * nvmf_register_transport() - NVMe Fabrics Library registration function=
.
>  * @ops:	Transport ops instance to be registered to the
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index de213ab26977..3d8ec7133fc8 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -189,6 +189,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts=
);
> int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
> bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
> void nvmf_reconnect_or_remove(struct nvme_ctrl *ctrl);
> +void nvmf_error_recovery(struct nvme_ctrl *ctrl);
> bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
> 		struct nvmf_ctrl_options *opts);
>=20
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index da7f61a5fac4..1c57e371af61 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1185,15 +1185,6 @@ static void nvme_rdma_error_recovery_work(struct w=
ork_struct *work)
> 	nvmf_reconnect_or_remove(&ctrl->ctrl);
> }
>=20
> -static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
> -{
> -	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> -		return;
> -
> -	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
> -	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
> -}
> -
> static void nvme_rdma_end_request(struct nvme_rdma_request *req)
> {
> 	struct request *rq =3D blk_mq_rq_from_pdu(req);
> @@ -1215,7 +1206,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, st=
ruct ib_wc *wc,
> 			     "%s for CQE 0x%p failed with status %s (%d)\n",
> 			     op, wc->wr_cqe,
> 			     ib_wc_status_msg(wc->status), wc->status);
> -	nvme_rdma_error_recovery(ctrl);
> +	nvmf_error_recovery(&ctrl->ctrl);
> }
>=20
> static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
> @@ -1715,7 +1706,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_=
rdma_queue *queue,
> 		dev_err(queue->ctrl->ctrl.device,
> 			"got bad command_id %#x on QP %#x\n",
> 			cqe->command_id, queue->qp->qp_num);
> -		nvme_rdma_error_recovery(queue->ctrl);
> +		nvmf_error_recovery(&queue->ctrl->ctrl);
> 		return;
> 	}
> 	req =3D blk_mq_rq_to_pdu(rq);
> @@ -1729,7 +1720,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_=
rdma_queue *queue,
> 			dev_err(queue->ctrl->ctrl.device,
> 				"Bogus remote invalidation for rkey %#x\n",
> 				req->mr ? req->mr->rkey : 0);
> -			nvme_rdma_error_recovery(queue->ctrl);
> +			nvmf_error_recovery(&queue->ctrl->ctrl);
> 		}
> 	} else if (req->mr) {
> 		int ret;
> @@ -1739,7 +1730,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_=
rdma_queue *queue,
> 			dev_err(queue->ctrl->ctrl.device,
> 				"Queueing INV WR for rkey %#x failed (%d)\n",
> 				req->mr->rkey, ret);
> -			nvme_rdma_error_recovery(queue->ctrl);
> +			nvmf_error_recovery(&queue->ctrl->ctrl);
> 		}
> 		/* the local invalidation completion will end the request */
> 		return;
> @@ -1766,7 +1757,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, s=
truct ib_wc *wc)
> 	if (unlikely(wc->byte_len < len)) {
> 		dev_err(queue->ctrl->ctrl.device,
> 			"Unexpected nvme completion length(%d)\n", wc->byte_len);
> -		nvme_rdma_error_recovery(queue->ctrl);
> +		nvmf_error_recovery(&queue->ctrl->ctrl);
> 		return;
> 	}
>=20
> @@ -1936,7 +1927,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
> 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
> 		dev_dbg(queue->ctrl->ctrl.device,
> 			"disconnect received - connection closed\n");
> -		nvme_rdma_error_recovery(queue->ctrl);
> +		nvmf_error_recovery(&queue->ctrl->ctrl);
> 		break;
> 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
> 		/* device removal is handled via the ib_client API */
> @@ -1944,7 +1935,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
> 	default:
> 		dev_err(queue->ctrl->ctrl.device,
> 			"Unexpected RDMA CM event (%d)\n", ev->event);
> -		nvme_rdma_error_recovery(queue->ctrl);
> +		nvmf_error_recovery(&queue->ctrl->ctrl);
> 		break;
> 	}
>=20
> @@ -2000,7 +1991,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved=
)
> 	 * LIVE state should trigger the normal error recovery which will
> 	 * handle completing this request.
> 	 */
> -	nvme_rdma_error_recovery(ctrl);
> +	nvmf_error_recovery(&ctrl->ctrl);
> 	return BLK_EH_RESET_TIMER;
> }
>=20
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 07a9cc4f2274..fe1f2fec457b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -479,15 +479,6 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_q=
ueue *queue)
> 	queue->ddgst_remaining =3D 0;
> }
>=20
> -static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> -{
> -	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> -		return;
> -
> -	dev_warn(ctrl->device, "starting error recovery\n");
> -	queue_work(nvme_reset_wq, &ctrl->err_work);
> -}
> -
> static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> 		struct nvme_completion *cqe)
> {
> @@ -499,7 +490,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_=
queue *queue,
> 		dev_err(queue->ctrl->ctrl.device,
> 			"got bad cqe.command_id %#x on queue %d\n",
> 			cqe->command_id, nvme_tcp_queue_id(queue));
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		nvmf_error_recovery(&queue->ctrl->ctrl);
> 		return -EINVAL;
> 	}
>=20
> @@ -541,7 +532,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_q=
ueue *queue,
> 		dev_err(queue->ctrl->ctrl.device,
> 			"queue %d tag %#x SUCCESS set but not last PDU\n",
> 			nvme_tcp_queue_id(queue), rq->tag);
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		nvmf_error_recovery(&queue->ctrl->ctrl);
> 		return -EPROTO;
> 	}
>=20
> @@ -850,7 +841,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc,=
 struct sk_buff *skb,
> 			dev_err(queue->ctrl->ctrl.device,
> 				"receive failed:  %d\n", result);
> 			queue->rd_enabled =3D false;
> -			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +			nvmf_error_recovery(&queue->ctrl->ctrl);
> 			return result;
> 		}
> 	}
> @@ -898,7 +889,7 @@ static void nvme_tcp_state_change(struct sock *sk)
> 	case TCP_LAST_ACK:
> 	case TCP_FIN_WAIT1:
> 	case TCP_FIN_WAIT2:
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		nvmf_error_recovery(&queue->ctrl->ctrl);
> 		break;
> 	default:
> 		dev_info(queue->ctrl->ctrl.device,
> @@ -2252,7 +2243,7 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
> 	 * LIVE state should trigger the normal error recovery which will
> 	 * handle completing this request.
> 	 */
> -	nvme_tcp_error_recovery(ctrl);
> +	nvmf_error_recovery(ctrl);
> 	return BLK_EH_RESET_TIMER;
> }
>=20
> --=20
> 2.18.1
>=20
>=20

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


