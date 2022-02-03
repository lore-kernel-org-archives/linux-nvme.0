Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CDAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JIHCG5SuoIkVztWS9P26MSKsRkKl26nerM3LDwI0J+g=; b=QyUwpUOvJql/gEVuUzFm8vNUFO
	XEFimTTmsMPMNzH6CkWOppCKvQv1MZRkNYDdNCPlY28ZPSMirafafJH1LmX5/XEZgjazOqizxc7X1
	Z3aUfGc5truQBiA+0b0i7FZkv/ROYTfHTsuUReSOCPzA34UK+L8QJ59SJlUnvDuAM9CIq8ipzgatH
	VttmFK/UQ50ze39MvJg3SPlH97YNPe3CZJg+y7LPqh4d6AQFw9ocgRR/+Pljmxvix3vQnTGL/2nnm
	QrKNRaPyHVYHImb7648cVrEN1F1eaf6G3brFACeoxw0n8FgVeGHulHODx7CTaZfwIgrPusYO2Gt0u
	3LhRSFmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFebM-001wHb-Dd; Thu, 03 Feb 2022 16:04:52 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFebI-001wGm-OM
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 16:04:50 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2138vGpL031842;
 Thu, 3 Feb 2022 11:04:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=JIHCG5SuoIkVztWS9P26MSKsRkKl26nerM3LDwI0J+g=;
 b=TuZ2dfGiYWiOqdfqcaK/Cri/2CCjfCTpxH5MX3X7KVNSzT0O8dK3Np9V/8P/6ZU5/Uqe
 yfemWwuFmOEZxD1LwJ4JwynbDhKYAt/jb12C2IT4Yt2bM8VcbKJu0//dsDEH919CikwO
 u8uHdIMnE+urVUnF2nPSPxXEHL99qjFXIkyNHXZtXnc788RoOXuO99Ot/fTHMTRjASkp
 C3WSDpujyPAKXRV1nDxhORKwDEPAXeo97+Lz5NW/ijWWIW9+vx3A2MZCR+ucnz+06X69
 tKg4ZY20V0aSn41Nm+ZYnWy8l7FY6oFhCo+0BepUVkYCvrMh5nIqPo3kwah0YeagANsS rA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3e020uuaq5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Feb 2022 11:04:29 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 213G0PqF002733; Thu, 3 Feb 2022 11:04:28 -0500
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0b-00154901.pphosted.com with ESMTP id 3dysksvtny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 03 Feb 2022 11:04:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8mTbx4jHl9HLjQk0pqeauMPhEKEN4SCoJDBllZapZJuvZJhHLiEsd08qKydqBxAsg8kS0SUfOmsp+lwgqmkJFS3hHMkgXywZRoA1YjIagM1aGjSe5CnoCL274CcfT2z4GnjMlJN0Amv3ZB9zc3zjlUN75TCV2G6mDF+c7f42XFJIZNG2nqqZZkdJDN1n2lKcrjraHHcUkWeqd1ne6TCj1N8a+HFctCfyD+RqbE8J8zSFsL/gbBwUlPYPw6SIlFGqS7voTvcNbNkfebrzikQ+/uLTEmAf7YOgmMq/a0nZys/955Om7uWCf4W91AqiverflGmNzNHlFGZfXKrbKYf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIHCG5SuoIkVztWS9P26MSKsRkKl26nerM3LDwI0J+g=;
 b=hTJ78yKtyHIpw3beJJOCfpEykEK7bxBfdHvCjz0rrCuw2pnDE4z+ql42MkrhGvNTImkGVkp5C0ZDzY01GPhFcELUuuLq5eMIRYjkin0+SlwSjVcI33U8hWanfTWoD/JjDPSIsENtgzzXoOpwoaWtdF9MugSKATbJzfsUITlK0uGLUq9p1zVEw8l4HV7BPkzR3VnZuylQCPYHQNYVgC89V4SbHkXj0ugfvAUC2qPRwW/G6BKhbPdnXNHeqchSExDL+mo5fN9UphchG0n+01/jhvW3c4rkga/iuvAy0JvVDhKzAvSxSmOnaBi6SFSkIkFItpCr+UIgpe0qTEAfsjK2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BYAPR19MB2295.namprd19.prod.outlook.com (2603:10b6:a02:ce::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 16:04:27 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 16:04:27 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Martin Belanger
 <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "Hayes, Stuart" <Stuart.Hayes@dell.com>, "Rose, Charles"
 <Charles.Rose@dell.com>
Subject: RE: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Topic: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Thread-Index: AQHYGHzVH84DVIVYUE+St1ikwYiM3ayB0PWAgAAsxdA=
Date: Thu, 3 Feb 2022 16:04:26 +0000
Message-ID: <SJ0PR19MB454483771771EBD3C158F898F2289@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
 <efe3f3fb-b415-f75a-3ec9-671276cef1e3@nvidia.com>
In-Reply-To: <efe3f3fb-b415-f75a-3ec9-671276cef1e3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-02-03T16:04:25Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=ee1a421e-24ad-4614-8548-c08a403111d9;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 634d3525-4499-4f4a-0938-08d9e72eda84
x-ms-traffictypediagnostic: BYAPR19MB2295:EE_
x-microsoft-antispam-prvs: <BYAPR19MB2295FC031A830F67468174EFF2289@BYAPR19MB2295.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ttE8y64HP71gQNOmZoGpwifJy6Z1OzEJi5+T+xCwnXUnmq1hadMfnxkmyf/OHTWhrOFh9FuFTpcVDiz4oU9Sy1EfkFO2XedvwyNHHKkkymMXLKCOJ6Y6geLAuhSo1yL8YnW+FoeRbL1jDNPZ/qLk/hYosrHRr39SUEh/DsIUTQbFIMv7NikxRpfT1NShoJDW2ZntMq9l3qY0aooWps5r6taD49G8NkWz1jLSRWp+Ei+w1erpXqKZ5Xtlii5YIlYwSBI+4F33o+JAcNelyo4vT08qYGVsUkALmHSDF0a/7FtUryvQcCND7DJtxGY1g6Na/Dba4fKcwF89VftnGdkZNbNh4uMq9Rn2SP3W3coy5fiktmCXNxS5EM9/EBj7bhp3XIL9tv5b7PS2pT5ghleanb3eOkCe2mmQP6ZVThG2bFKH4kKNMIdsoJSzMYxWat60YVRGnxacj0yYOSR/JzxH1+0qQJF6WDJ4WLYRz8seSSyH2Vvz+mP/h48TVRYT1UfAtHarkMjyce478o5t7pTOlV9g+GPSedPL9Ffkmt3uM1s7PLazEHM6NfekXgQrdhkKmPs6PCrE2z89OhCkmYHGSBb5CtMXrvGdNdHJfLIY9KnIFj4iB6k1HIyWH18CImvqRj92UxiI49pGfb793Ff4XRKMGR4gQj6MX1K+CPNAZZyPQ1NB2tFwvBmGXOg0QJu7uzRk2u2aCfomcX6Bw8pp7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(71200400001)(54906003)(122000001)(786003)(110136005)(316002)(38100700002)(508600001)(38070700005)(2906002)(33656002)(55016003)(66556008)(83380400001)(66446008)(66476007)(107886003)(86362001)(82960400001)(5660300002)(76116006)(52536014)(66946007)(4326008)(26005)(186003)(8676002)(64756008)(8936002)(9686003)(6506007)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXlWREZnZ2lwcHdkQ3JxZHdJa1ZsL0FxWFZyT2twbTlSc25wSzVjeEtlUHFM?=
 =?utf-8?B?ZnFSYjc0ZURVc24yWDdGbDdRSDVGNmxQanhDQ2Z2cFM1RHVpeTF0N2NCUzQ0?=
 =?utf-8?B?QTlON0VlT0VTeURNK2RPSWFWdjcyMjVGdFc5RHU2R0Z2TXZJcnI1cTRFM0oy?=
 =?utf-8?B?MjhZRWJYV00yZC85WHI3alpEUm9kcjFsM3Vzd0dhRGQycld1c2lSbkpFTHZ3?=
 =?utf-8?B?SUxnYlRUNk1LckJyamZPcXliRkRqTmIrSHE1RFQ2S0RUbWxxNmY0YkhqRTZ3?=
 =?utf-8?B?eDlqTEFvOEh5MDI0bExIV0hDczZKK2RlaVZHMGhmd21xSldWMlcxQ0RJV25u?=
 =?utf-8?B?NjJjQWtxNDFsTFdGa3lybDNBd0lod3hiYisra0QxRXo3ZmRVbzZrTWZURUhU?=
 =?utf-8?B?V3hSanhqVWtvWTU4QkxUUVdTbzUwZU9BcWlRRTc3Yi8vOGZkMi9ZdVdMVkJS?=
 =?utf-8?B?Z3RJTXR5YnZGb0IyeVQrQmJVcjNqaTIxbUdNR0dJQ1IvRnJzd00vYU0rYUFE?=
 =?utf-8?B?SkkvaDZXWDBTN0o2L1dPYnBwUEdSeUJxK3dXRFY1SlQ3R3VSbUN6MU91L1Yw?=
 =?utf-8?B?U05KaEdkenc4MFhLQlNPOVhPZkNMSjMvWGtEWjJjaFM5bHBnRktRZjRuUEZV?=
 =?utf-8?B?UnVlZ0hSRStkVGZYWWlQdmJuR015bW5QTGk0QTQvemNHL0Y3MmkwK0tmTm9N?=
 =?utf-8?B?bWFCdEhIbktLZ3llNVZpSDRKUUJSWDlzaHpCTE1yU05ZUCswalRweU1rZU0r?=
 =?utf-8?B?YjBXQnBuU0gyeWxySGM3cm9OYWRSV0VnT0dzQkhhbmVsWFNtdy9ubUJHY0N4?=
 =?utf-8?B?M01qenYyaHJ6Qzl5UjlDNll6RDZtTHYzUWMxb0VkSXpERXEwRDhlamhEY2ZS?=
 =?utf-8?B?Mkl3VUJKSDI1UGJ4T2FZQ2pibzVvVTRCUEY0NzhKYjVlNTducWUxTStWVkd6?=
 =?utf-8?B?V2JrbGkwR0VBRExHMjJyMnRlZGZzRWtGYTZrY0dJQ1Vpb0o0YStUemd6bGhh?=
 =?utf-8?B?MEc3c2ZXN3NiY1JsVHhJdkJ6ZXFoaWJKakdZQnl4a3hqUGJSTWdHSW4xRW1q?=
 =?utf-8?B?b1h6ZmdRclVLdHZCL1U0OGlTcCs2NjN2SWxxbUlBVTdXOVd3cG9XampvQjhh?=
 =?utf-8?B?cUhmZ25ycEhkaHRMNTh6bWNZcWtDS1VCdzU0aU1CWWMxSG1oUnhmaThja21L?=
 =?utf-8?B?SzFhdHlmNXRQNjBBRjljUVFta3hsaW1FY2xkNFQ0WGQ5UldmaUhac3lnRGh3?=
 =?utf-8?B?a3hmODlYaTZ5ZjI2Y0s4MHFUMEVYSlBPNFlPSkxURGFiWTIyM1hPN2E2SWtF?=
 =?utf-8?B?UWdyWlZEdTExaTZpTk1XdkVvcHZ1ekl5M2lRNHVXRncvTER4VTd2dXF2bGQx?=
 =?utf-8?B?UVZMbElYaXpLU0VWK2VEakRVVGpNOVpWMmoxd0w3RUNxdCtHcjFIeThoMWN5?=
 =?utf-8?B?TmRwRFExV0FIMEtCbkZnVnZnOFRYUC9XcGNxaGtwbXlockpDbURsWFlYNnZV?=
 =?utf-8?B?K0wvMzFXWU9wVnZmNnFsQUtNczVoMjkvTXNFN2oxLzI2aXhwaVlHOXV6YVJN?=
 =?utf-8?B?Zk1DN2lvaFpjNUpkR3hoNi9NQmtsZG84MjhhN0k5dDVNcmtHaElBMlVhS1dC?=
 =?utf-8?B?bjQxc1BhdmxkLzFFMDUybWgzejRoZ0Z0SFE0VWxia3B3UWhzVHB5b2FzOVBR?=
 =?utf-8?B?Q29IUEJyZnFJZk9NOE5EL3d0emdZNU5HdWdLbGFlWkYvQ0pHMjNNczFWSHhP?=
 =?utf-8?B?cGo3L0tjWUdZY3hvQzVQQkIvUm12eDFXUWpzN1duS3E1TmVUMVk2Y09vb2RE?=
 =?utf-8?B?eE0yVkxmYnZodlJobndPcUNpSHZmODZ1OFFDd0tZNHh5WlBnbFNtV2pkcjRs?=
 =?utf-8?B?MG14MU9OYnUvU3h6RzQ4WUJRZnpvMEZNK2Y1MHJoZVFKMGJSOHVOVEk2NGFl?=
 =?utf-8?B?SUdJYmx6R0c5WW9tMlJOQVFKdHkrQ1NpOFRURlFQcjM4eXBCVk9maHN4ajlI?=
 =?utf-8?B?QmFGQ01OclFLaWtGQmNiUFptNnk1VWVkaGtHd0hWbkpFekdqY2o3Ym40dEVk?=
 =?utf-8?B?d3ZEWThKNHJ6eTdZMnNUb2pBSm9BQStEYVhjRTZ6cDJTNHBYYjBTR2ltUzhl?=
 =?utf-8?B?dThSb2ZPVVdtUXFIcldhbklYa3Awd2d6QjVCZU9jd056Rk1uREl4ZnhSeXpP?=
 =?utf-8?B?QlFwS3I2dGF0QTdiaE1XQzFyZGNJbEdDZjd0L1JPSmt6cW43SEh4QThYNFg5?=
 =?utf-8?B?UFEwczFXcFlDM3Rkc05ZaENrNFNRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634d3525-4499-4f4a-0938-08d9e72eda84
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 16:04:26.9440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aS6FYsL98Tc6SL88xfy+eNnH0+ORJIVW+n2xOAi3df2LrB6wqg/sd3owlLRby6dLDws1rowRaenGlT2zRE0u3jG7O9rWpZ+D6eWqSHJyC84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR19MB2295
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-02-03_05:2022-02-03,
 2022-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 phishscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2202030097
X-Proofpoint-GUID: X5vKb4cYEnnwsc6KMos_Y-Vn9T7EekYr
X-Proofpoint-ORIG-GUID: X5vKb4cYEnnwsc6KMos_Y-Vn9T7EekYr
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202030097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_080448_990520_B4041F64 
X-CRM114-Status: GOOD (  34.27  )
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

PiBPbiAyLzIvMjIgMTM6MzQsIE1hcnRpbiBCZWxhbmdlciB3cm90ZToNCj4gPiBGcm9tOiBNYXJ0
aW4gQmVsYW5nZXIgPG1hcnRpbi5iZWxhbmdlckBkZWxsLmNvbT4NCj4gPg0KPiA+IFRQODAxMCBp
bnRyb2R1Y2VzIHRoZSBEaXNjb3ZlcnkgQ29udHJvbGxlciBUeXBlIChkY3R5cGUpIGF0dHJpYnV0
ZS4NCj4gPiBUaGUgZGN0eXBlIGlzIHJldHVybmVkIGluIHRoZSByZXNwb25zZSB0byB0aGUgSWRl
bnRpZnkgY29tbWFuZC4gVGhpcw0KPiA+IHBhdGNoIGV4cG9zZXMgdGhlIGRjdHlwZSB0aHJvdWdo
IHRoZSBzeXNmcy4gU2luY2UgdGhlIGRjdHlwZSBkZXBlbmRzDQo+ID4gb24gdGhlIENvbnRyb2xs
ZXIgVHlwZSAoY250cmx0eXBlKSwgYW5vdGhlciBhdHRyaWJ1dGUgb2YgdGhlIElkZW50aWZ5DQo+
ID4gcmVzcG9uc2UsIHRoZSBwYXRjaCBhbHNvIGV4cG9zZXMgdGhlIGNudHJsdHlwZSBhcyB3ZWxs
Lg0KPiA+DQo+IA0KPiBhYm92ZSBjYW4gYmUgcmUgYWxpZ25lZCB0byA3MiBjaGFyIHBlciBsaW5l
IDotDQo+IA0KPiBUUDgwMTAgaW50cm9kdWNlcyB0aGUgRGlzY292ZXJ5IENvbnRyb2xsZXIgVHlw
ZSAoZGN0eXBlKSBhdHRyaWJ1dGUuIFRoZQ0KPiBkY3R5cGUgaXMgcmV0dXJuZWQgaW4gdGhlIHJl
c3BvbnNlIHRvIHRoZSBJZGVudGlmeSBjb21tYW5kLiBUaGlzIHBhdGNoDQo+IGV4cG9zZXMgdGhl
IGRjdHlwZSB0aHJvdWdoIHRoZSBzeXNmcy4gU2luY2UgdGhlIGRjdHlwZSBkZXBlbmRzIG9uIHRo
ZQ0KPiBDb250cm9sbGVyIFR5cGUgKGNudHJsdHlwZSksIGFub3RoZXIgYXR0cmlidXRlIG9mIHRo
ZSBJZGVudGlmeSByZXNwb25zZSwgdGhlDQo+IHBhdGNoIGFsc28gZXhwb3NlcyB0aGUgY250cmx0
eXBlIGFzIHdlbGwuDQo+IA0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmVsYW5nZXIg
PG1hcnRpbi5iZWxhbmdlckBkZWxsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYyB8IDM1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmggfCAgMyArKysNCj4gPiAgIGluY2x1ZGUvbGlu
dXgvbnZtZS5oICAgICB8IDEwICsrKysrKysrKy0NCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBpbmRleA0KPiA+
IDg3MmMzODlkYzZkMy4uYzY1ZDQ0ZmI2NWM0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiA+IEBA
IC0yOTkyLDYgKzI5OTIsOSBAQCBzdGF0aWMgaW50IG52bWVfaW5pdF9pZGVudGlmeShzdHJ1Y3Qg
bnZtZV9jdHJsDQo+ICpjdHJsKQ0KPiA+ICAgCWN0cmwtPm1heF9uYW1lc3BhY2VzID0gbGUzMl90
b19jcHUoaWQtPm1uYW4pOw0KPiA+ICAgCWN0cmwtPmN0cmF0dCA9IGxlMzJfdG9fY3B1KGlkLT5j
dHJhdHQpOw0KPiA+DQo+ID4gKwljdHJsLT5jbnRybHR5cGUgPSBpZC0+Y250cmx0eXBlOw0KPiA+
ICsJY3RybC0+ZGN0eXBlID0gaWQtPmRjdHlwZTsNCj4gPiArDQo+ID4gICAJaWYgKGlkLT5ydGQz
ZSkgew0KPiA+ICAgCQkvKiB1cyAtPiBzICovDQo+ID4gICAJCXUzMiB0cmFuc2l0aW9uX3RpbWUg
PSBsZTMyX3RvX2NwdShpZC0+cnRkM2UpIC8NCj4gVVNFQ19QRVJfU0VDOyBAQA0KPiA+IC0zNTI1
LDYgKzM1MjgsMzQgQEAgc3RhdGljIHNzaXplX3QNCj4gbnZtZV9jdHJsX2Zhc3RfaW9fZmFpbF90
bW9fc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAgc3RhdGljIERFVklDRV9BVFRSKGZh
c3RfaW9fZmFpbF90bW8sIFNfSVJVR08gfCBTX0lXVVNSLA0KPiA+ICAgCW52bWVfY3RybF9mYXN0
X2lvX2ZhaWxfdG1vX3Nob3csDQo+IG52bWVfY3RybF9mYXN0X2lvX2ZhaWxfdG1vX3N0b3JlKTsN
Cj4gPg0KPiA+ICtzdGF0aWMgc3NpemVfdCBudm1lX2N0cmxfY250cmx0eXBlX3Nob3coc3RydWN0
IGRldmljZSAqZGV2LA0KPiA+ICsJCQkJICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0
ciwgY2hhciAqYnVmKSB7DQo+ID4gKwlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gZGV2X2dldF9k
cnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICsJc3dpdGNoIChjdHJsLT5jbnRybHR5cGUpIHsNCj4g
PiArCWNhc2UgTlZNRV9DVFJMX0lPOglyZXR1cm4gc3lzZnNfZW1pdChidWYsICJpb1xuIik7DQo+
ID4gKwljYXNlIE5WTUVfQ1RSTF9ESVNDOglyZXR1cm4gc3lzZnNfZW1pdChidWYsICJkaXNjXG4i
KTsNCj4gPiArCWNhc2UgTlZNRV9DVFJMX0FETUlOOglyZXR1cm4gc3lzZnNfZW1pdChidWYsICJh
ZG1pblxuIik7DQo+ID4gKwlkZWZhdWx0OgkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAicmVzZXJ2
ZWRcbiIpOw0KPiANCj4gcGxlYXNlIGtlZXAgdGhlIHJldHVybiBvbiBuZXcgbGluZSAuLi4NCg0K
SGkgQ2hhaXRhbnlhLA0KT2ssIEkgd2lsbCBrZWVwIHRoZSByZXR1cm4gb24gYSBzZXBhcmF0ZSBs
aW5lLiBCVFcsIGlzIHRoYXQgc3BlY2lmaWMgdG8gdGhlIA0KTlZNZSBkcml2ZXIuIEkgc2VlIHRo
YXQgaW4gbWFueSBwbGFjZXMgaW4gdGhlIGtlcm5lbCB0aGV5IHB1dCB0aGUgDQpyZXR1cm4gb24g
dGhlIHNhbWUgbGluZSBhcyB0aGUgY2FzZSBzdGF0ZW1lbnQsIGFzIHNob3duIGhlcmU6DQoNCiQg
Z2l0IGdyZXAgLUUgImNhc2UgLio6ICpyZXR1cm4iIHwgd2MgLWwNCjE2NzYNCg0KPiANCj4gPiAr
CX0NCj4gPiArfQ0KPiANCj4gd2l0aCBuZXdsaW5lIGFkZGVkIHRvIHRoZSBzd2l0Y2ggZm9yIGVh
Y2ggbmV3IGNhc2Ugd2Ugd2lsbCBiZSBhZGRpbmcgbmV3DQo+IGNhc2Ugc3RhdGVtZW50IGFuZCBh
IHN5c2ZzX2VtaXQoKSBjYWxsLCBmb2xsb3dpbmcgc3R5bGUgYXZvaWRzIGN1cnJlbnQgYW5kDQo+
IGZ1dHVyZSByZXBldGF0aW9ucyBvZiBjYXNlIC4uLiBzeXNmc19lbWl0KCkgY2FsbHMgYW5kIGJy
aW5ncyBkb3duIHRvIG9ubHkgdHdvDQo+IGNhbGxzIGluY2x1ZGluZyBhbnkgZnV0dXJlIGN0cmwg
dHlwZSB2YWx1ZSAoMiBsaW5lcyBmb3IgZWFjaCBuZXcgdmFsdWUgcGYgY3RybHR5cGUNCj4gdnMg
MSBsaW5lIGluIHRoZSBhcnJheSBvZiBzdHJpbmcgOi0NCj4gDQo+IHN0YXRpYyBzc2l6ZV90IG52
bWVfY3RybF9jbnRybHR5cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIs
IGNoYXIgKmJ1Zikgew0KPiAgICAgICAgICBjb25zdCBjaGFyICp0eXBlW10gPSB7DQo+ICAgICAg
ICAgICAgICBbTlZNRV9DVFJMX0lPXSwgImlvXG4iLA0KPiAgICAgICAgICAgICAgW05WTUVfQ1RS
TF9ESVNDXSwgImRpc2NcbiIsDQo+ICAgICAgICAgICAgICBbTlZNRV9DVFJMX0FETUlOXSwgImFk
bWluXG4iLA0KPiAgICAgICAgICB9Ow0KPiANCj4gICAgICAgICAgaWYgKGN0cmwtPmNudHJsdHlw
ZSA+IE5WTUVfQ1RSTF9BRE1JTiB8fCAhdHlwZVtjdHJsLT5jdHJsdHlwZV0pDQo+ICAgICAgICAg
ICAgICByZXR1cm4gc3lzZnNfZW1pdChidWYsICJyZXNlcnZlZFxuIik7DQo+IA0KPiAgICAgICAg
ICByZXR1cm4gc3lzZnNfZW1pdChidWYsIHR5cGVbY3RybC0+Y3RybHR5cGVdKTsgfQ0KPiANCj4g
DQo+IA0KPiANCj4gPiArc3RhdGljIERFVklDRV9BVFRSKGNudHJsdHlwZSwgU19JUlVHTywgbnZt
ZV9jdHJsX2NudHJsdHlwZV9zaG93LA0KPiA+ICtOVUxMKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBz
c2l6ZV90IG52bWVfY3RybF9kY3R5cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gKwkJ
CQkgICAgIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpIHsNCj4gPiAr
CXN0cnVjdCBudm1lX2N0cmwgKmN0cmwgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiArDQo+
ID4gKwlzd2l0Y2ggKGN0cmwtPmRjdHlwZSkgew0KPiA+ICsJY2FzZSBOVk1FX0RDVFlQRV9OT1Rf
UkVQT1JURUQ6CXJldHVybiBzeXNmc19lbWl0KGJ1ZiwNCj4gIm5yXG4iKTsNCj4gPiArCWNhc2Ug
TlZNRV9EQ1RZUEVfRERDOgkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLA0KPiAiZGRjXG4iKTsNCj4g
PiArCWNhc2UgTlZNRV9EQ1RZUEVfQ0RDOgkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLA0KPiAiY2Rj
XG4iKTsNCj4gPiArCWRlZmF1bHQ6CQkJcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAicmVzZXJ2ZWRc
biIpOw0KPiA+ICsJfQ0KPiA+ICt9DQo+IA0KPiBzYW1lIGNvbW1lbnQgYXMgYWJvdmUgdG8gdXNl
IGFycmF5IG9mIHN0cmluZyB1bmxlc3MgdGhlcmUgaXMgYW55IHJlYXNvbiB3ZQ0KPiBzaG91bGQg
cmVwZWF0IHRoZSBzeXNmc19lbWl0KCkgY2FsbHMuDQo+IA0KPiA+ICtzdGF0aWMgREVWSUNFX0FU
VFIoZGN0eXBlLCBTX0lSVUdPLCBudm1lX2N0cmxfZGN0eXBlX3Nob3csIE5VTEwpOw0KPiA+ICsN
Cj4gPiAgIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpudm1lX2Rldl9hdHRyc1tdID0gew0KPiA+
ICAgCSZkZXZfYXR0cl9yZXNldF9jb250cm9sbGVyLmF0dHIsDQo+ID4gICAJJmRldl9hdHRyX3Jl
c2Nhbl9jb250cm9sbGVyLmF0dHIsDQo+ID4gQEAgLTM1NDYsNiArMzU3Nyw4IEBAIHN0YXRpYyBz
dHJ1Y3QgYXR0cmlidXRlICpudm1lX2Rldl9hdHRyc1tdID0gew0KPiA+ICAgCSZkZXZfYXR0cl9y
ZWNvbm5lY3RfZGVsYXkuYXR0ciwNCj4gPiAgIAkmZGV2X2F0dHJfZmFzdF9pb19mYWlsX3Rtby5h
dHRyLA0KPiA+ICAgCSZkZXZfYXR0cl9rYXRvLmF0dHIsDQo+ID4gKwkmZGV2X2F0dHJfY250cmx0
eXBlLmF0dHIsDQo+ID4gKwkmZGV2X2F0dHJfZGN0eXBlLmF0dHIsDQo+ID4gICAJTlVMTA0KPiA+
ICAgfTsNCj4gPg0KPiA+IEBAIC0zNTY5LDYgKzM2MDIsOCBAQCBzdGF0aWMgdW1vZGVfdA0KPiBu
dm1lX2Rldl9hdHRyc19hcmVfdmlzaWJsZShzdHJ1Y3Qga29iamVjdCAqa29iaiwNCj4gPiAgIAkJ
cmV0dXJuIDA7DQo+ID4gICAJaWYgKGEgPT0gJmRldl9hdHRyX2Zhc3RfaW9fZmFpbF90bW8uYXR0
ciAmJiAhY3RybC0+b3B0cykNCj4gPiAgIAkJcmV0dXJuIDA7DQo+ID4gKwlpZiAoYSA9PSAmZGV2
X2F0dHJfZGN0eXBlLmF0dHIgJiYgY3RybC0+Y250cmx0eXBlID09DQo+IE5WTUVfQ1RSTF9ESVND
KQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+DQo+ID4gICAJcmV0dXJuIGEtPm1vZGU7DQo+ID4gICB9
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZt
ZS9ob3N0L252bWUuaCBpbmRleA0KPiA+IGExNjJmNmM2ZGE2ZS4uZTMwNjI2YzAwNzkxIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L252bWUuaA0KPiA+IEBAIC0zNDksNiArMzQ5LDkgQEAgc3RydWN0IG52bWVfY3Ry
bCB7DQo+ID4gICAJdW5zaWduZWQgbG9uZyBkaXNjYXJkX3BhZ2VfYnVzeTsNCj4gPg0KPiA+ICAg
CXN0cnVjdCBudm1lX2ZhdWx0X2luamVjdCBmYXVsdF9pbmplY3Q7DQo+ID4gKw0KPiA+ICsJZW51
bSBudm1lX2N0cmxfdHlwZSBjbnRybHR5cGU7DQo+ID4gKwllbnVtIG52bWVfZGN0eXBlIGRjdHlw
ZTsNCj4gPiAgIH07DQo+ID4NCj4gPiAgIGVudW0gbnZtZV9pb3BvbGljeSB7DQo+ID4gZGlmZiAt
LWdpdCBhL2luY2x1ZGUvbGludXgvbnZtZS5oIGIvaW5jbHVkZS9saW51eC9udm1lLmggaW5kZXgN
Cj4gPiA4NTVkZDliM2U4NGIuLmFmMTQ5NGQ4M2E1MiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2xpbnV4L252bWUuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbnZtZS5oDQo+ID4gQEAgLTQz
LDYgKzQzLDEyIEBAIGVudW0gbmFtZV9jdHJsX3R5cGUgew0KPiA+ICAgCU5WTUVfQ1RSTF9BRE1J
Tgk9IDMsCQkvKiBBZG1pbmlzdHJhdGl2ZSBjb250cm9sbGVyDQo+ICovDQo+ID4gICB9Ow0KPiA+
DQo+ID4gK2VudW0gbnZtZV9kY3R5cGUgew0KPiA+ICsJTlZNRV9EQ1RZUEVfTk9UX1JFUE9SVEVE
ID0gMCwNCj4gPiArCU5WTUVfRENUWVBFX0REQyA9IDEsCQkvKiBEaXJlY3QgRGlzY292ZXJ5IENv
bnRyb2xsZXINCj4gKi8NCj4gPiArCU5WTUVfRENUWVBFX0NEQyA9IDIsCQkvKiBDZW50cmFsIERp
c2NvdmVyeQ0KPiBDb250cm9sbGVyICovDQo+ID4gK307DQo+ID4gKw0KPiANCj4gY29uc2lkZXIg
Zm9sbHdpbmcgd2l0aCBhbGlnbmVkIGluaXRpYWwgdmFsdWVzIHRoYXQgYWxzbyBtYXRjaGVzIHdo
YXQgd2UgaGF2ZSBpbg0KPiB0aGUgaW5jbHVkZS9saW51eC9udm1lLmggZm9yIGVudW1zIGluaXRp
YWxpemF0aW9uIDotIGVudW0gbnZtZV9kY3R5cGUgew0KPiAgICAgICAgICBOVk1FX0RDVFlQRV9O
T1RfUkVQT1JURUQgICAgICAgID0gMCwNCj4gICAgICAgICAgTlZNRV9EQ1RZUEVfRERDICAgICAg
ICAgICAgICAgICA9IDEsIC8qIERpcmVjdCBEaXNjb3ZlcnkNCj4gQ29udHJvbGxlciAqLw0KPiAg
ICAgICAgICBOVk1FX0RDVFlQRV9DREMgICAgICAgICAgICAgICAgID0gMiwgLyogQ2VudHJhbCBE
aXNjb3ZlcnkNCj4gQ29udHJvbGxlciAqLw0KPiB9Ow0KPiANCj4gPiAgIC8qIEFkZHJlc3MgRmFt
aWx5IGNvZGVzIGZvciBEaXNjb3ZlcnkgTG9nIFBhZ2UgZW50cnkgQURSRkFNIGZpZWxkICovDQo+
ID4gICBlbnVtIHsNCj4gPiAgIAlOVk1GX0FERFJfRkFNSUxZX1BDSQk9IDAsCS8qIFBDSWUgKi8N
Cj4gPiBAQCAtMzIwLDcgKzMyNiw5IEBAIHN0cnVjdCBudm1lX2lkX2N0cmwgew0KPiA+ICAgCV9f
bGUxNgkJCWljZG9mZjsNCj4gPiAgIAlfX3U4CQkJY3RyYXR0cjsNCj4gPiAgIAlfX3U4CQkJbXNk
YmQ7DQo+ID4gLQlfX3U4CQkJcnN2ZDE4MDRbMjQ0XTsNCj4gPiArCV9fdTgJCQlyc3ZkMTgwNFsy
XTsNCj4gPiArCV9fdTgJCQlkY3R5cGU7DQo+ID4gKwlfX3U4CQkJcnN2ZDE4MDdbMjQxXTsNCj4g
PiAgIAlzdHJ1Y3QgbnZtZV9pZF9wb3dlcl9zdGF0ZQlwc2RbMzJdOw0KPiA+ICAgCV9fdTgJCQl2
c1sxMDI0XTsNCj4gPiAgIH07DQo+ID4NCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo=

