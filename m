Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5763CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A+Cn9VJ5JxWU8S2Ey/PBGjNyD4O20dAGfWiK6YEmbYE=; b=keDcSV+6TPhtN2kFOK+dG+7QCZ
	gOrsZSx31mZAj0WHwxMAey/Hiy/z5GipHT0iiH6Oj+uPnAUkunm9OcE9/newO0z7uZqno1X0fL0Vh
	9bHIVxIKSmcF+XJT/aMbj40zt7JYBNZFc1WeLONCEO6vyTKBcVDewjk8+nxVuZWS4IXDvOAdIpkc5
	S3860n3ZEOBne6Txq6ZJun3vXGUXRo8P0HtrQXJCyE5lVr000fQtCo2g4PBIvKikvunL6fbQ5gBUL
	QruZY4fAz+MMfbiWHRmWj/MJm5oH2/Z9EqmYiBo4Dq4I0DVz1tbOyjOvwklGAblelEQFWSbG3uU0/
	WQZ8F6Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4xo-00FvQK-6Q; Thu, 27 Jan 2022 13:37:24 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4xj-00FvP9-VV
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:37:21 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20R8qlIM008481;
 Thu, 27 Jan 2022 08:37:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=A+Cn9VJ5JxWU8S2Ey/PBGjNyD4O20dAGfWiK6YEmbYE=;
 b=Xfd6RS3poKXAUSEbfQs7WTsWg6HQu2lSrkI83NrvkVpNpyn/QJIDT65jc1o7HYNe/W0e
 nhFogy3zWBaW5NVfdUtIr/oZBBYBAIS9o93zzG1jlvWlBMZhU3MN2DK/JgNNZ1M8Tf7G
 7RVq/p29Loi6R3HA8g9aQ3+TK239Do6LYJxXq4FNDFflG6mujsq1YSlkiUFSvSGvkVUt
 IP77quMQiQXE+MmkwOkI2+VH/34vf5zo6v+5Qf+kfPf3sd+wuyxipGSJoKQHY4oVrj+U
 Kq0kyFr+fNV9nYiBAaExfRfY4yUU5y0BwEbAcP3+xbS/HZBWthUqHi3ivZxvNma4VLHl 6Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3du1x1x6yv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jan 2022 08:37:11 -0500
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 20RDTf0m044795; Thu, 27 Jan 2022 08:37:11 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by mx0a-00154901.pphosted.com with ESMTP id 3du43acb5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jan 2022 08:37:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWSdwmsAtqZz9+SIhzT3/c8Bsob8ES7fiFPVUsF9fDx+MGl7mTmyLGVWBdKtqWM+ETBFnfQq7vTTHu/VswljBirOXgqJ8+pBN0tmG6RQCdVDqz4nRtQIY8YMMs+xUSgfwYA0s2tIfou/dc5E16rytbWbpBYY0WNYdpcZd666lytBAqg3t3OaqbdSwSPVEsXEhm/xNjL/kq9CSy++sT0rG2zqlh1lluJcBYdsnpiW1UPX3J8CWvrd8bcEi0I/W9z8tex32ledSnpoxh5HZDnPqf5qOsWfddOYFzqlMH/Lgh8gwM/YG1X42POvil3UX8Wgfv8Ugc7WubmQoibzEyVaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+Cn9VJ5JxWU8S2Ey/PBGjNyD4O20dAGfWiK6YEmbYE=;
 b=PdOHDsEXM3yVkRpiiJDl9lFpB1cmw/aQy/s3Jj5LFI+rs/3ZbrR02cdpjHfZQ6czbFMjVzEcBfErdhtqFxz0vfLXAPRoZjjAco80fS1ni14CFuWMHod8ZFbdRCs236f3cvRuMTmPths62+gi3B30EClwqW83QmXxg8MMNV2EwK+2EJj/D94d3vH8EH87KDEtEDO5/rUuAKt6628sjkUyfZHVhRLc4vgFHGidOO+fzBtlFsBGzgnHyRqiAIUDFIYFzm8Vtj2G0qUWdmEe89eUcbDeQ6g8/YMMIeT/+ByYV3ClavmLpkzY3XqCr7w2IMg2hgGx4qTxocpMwDgss4mqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by CH2PR19MB3909.namprd19.prod.outlook.com (2603:10b6:610:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 13:37:09 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::f01b:bbd8:4187:36b3]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::f01b:bbd8:4187:36b3%6]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 13:37:09 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/4] nvme-fabrics: add discovery controller type
Thread-Topic: [PATCH 1/4] nvme-fabrics: add discovery controller type
Thread-Index: AQHYEfxKWjqcE/xXGkGEXB8m7U87Nax2mUOAgABHIRA=
Date: Thu, 27 Jan 2022 13:37:09 +0000
Message-ID: <SJ0PR19MB4544921F2D62F52AEDD77DACF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291022C56E35D6F93500AF79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b680e4d4-4375-4b49-b3b5-dde8d0e7f097@suse.de>
In-Reply-To: <b680e4d4-4375-4b49-b3b5-dde8d0e7f097@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-01-27T13:37:06Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=92295207-3611-47fe-9afa-b4ea363a2c4a;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5acf607-de14-4e15-205c-08d9e19a1df6
x-ms-traffictypediagnostic: CH2PR19MB3909:EE_
x-microsoft-antispam-prvs: <CH2PR19MB3909088DF56F441798E18CC4F2219@CH2PR19MB3909.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5Mfy0P+WH31Dd3apWR7FHHNf+Pl7ErlJnNANcZyEUYZxDFjKstuZFuOvgmV0qrObfLetq8mukFEh8JL4jz4jnwr1YSMskOW+0SGMWBqrHrO0t/eCZZRBfg5gUi6cg/RV7NnwtGP/xq4VonJWI9G4OKwAaCraFx1b5g496zO6kBTJeVe/RVeWG+mx3EvTKyj5MorfRoo0XK5jw+OPaxiT7X9wGePMIV/h2aX3g2sl6PkQwFW9rQkJzB6pUbhdI7Ofny1oS0fb+XzJRy1jIC4sOtNWt9DkpVOusjh0bYZwWTLb+CMDZISu28XOzjzbbPwcaNbQOiy4K6wJ9bVMO4uqNOWABKmco8sfR66sPFSf5p34krYDZyuWcXnzeKntRM2+IFcmMBI/TYHBGuyulw69sRmhmMhmDUII6C7sfc9d9dj8XNG83Eq46iyESehB0mBiLQqjDyIhABXvzPEfNpV6XjXlJ5CYmocfEtr/IZLGUGjuaW2P+VC1vFH7Afn9jyY0OyYQ97S3E0N43RZRcMK5og7EUuyI1Nmn0VBU+SeGLuMPia/MbVRImfvMBoMLtIcOmsthXmrOFPNpwuqZ6CHma1k/1BzfVn4/aixC+batd7IZF2kNUamxWfgNKgLMYxA7G60Ma/A4VBi5SS9Jr6WJkKr2Nsn6UuqTFEq/vQv/JmSST7lKbTXx5Zocdl79hENFNa2WtmCmwmYsW8DyYgE7g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(5660300002)(52536014)(66946007)(66556008)(66446008)(64756008)(66476007)(38070700005)(76116006)(8936002)(8676002)(2906002)(55016003)(38100700002)(86362001)(66574015)(186003)(82960400001)(508600001)(122000001)(6506007)(110136005)(53546011)(9686003)(786003)(33656002)(7696005)(54906003)(316002)(71200400001)(83380400001)(26005)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDExanRlbElaSHQ1aTB6TkVNcUY1OElTeFhUekRJams1anlML1hzWWhqWm9I?=
 =?utf-8?B?VTJFaEhENHRhemxOYzlTT0E1T2NXUkRRSmlWSDZ6U0tiWnVPZ2Q3NWFFL2dI?=
 =?utf-8?B?UitLZ0JsL3ZWVWJ1QVd6Nlc3TWU5Y0VMTzNiaGJVREFCYldheDRha3UvOGVw?=
 =?utf-8?B?RWpkREt0MDlSMDFwdS8vWlNnZHlhNFBiYmlJMFVacERVS2c1UzByVHlyT1Ar?=
 =?utf-8?B?SHF3QkN2SHI1TGhXWEhIcDlqZTA4blMzNmgxZFlsYXdINS9UT1E1WFFHanR3?=
 =?utf-8?B?clEzVzRVK3l6bDNDTUwxTDhjKzQyVHkzODAzcXFDOU1KdDAvSmZRcVFkZ3Rv?=
 =?utf-8?B?OWFpSUd5b2VpS1hOYVpXR0ZSaDRnbTZlRU8yWWFuQUpMczQ1M281bDJENWVn?=
 =?utf-8?B?bTY3NkpsSDN6YmxNVFlZY0RPQ2dUVmtST0VRN0NWdytSTXM1U0pXV0l5ZCtV?=
 =?utf-8?B?Z21wZjVEOXFBKytpcWc0RThpcFlSRVIrSkJKUE5Md3V1bWZSZzFjTlArb09m?=
 =?utf-8?B?OUtPYlQ4MWJaUFVhaEFjN0NmTGhTOGlxOGFQdXZwV0xMdmRTN0RkQ0NMa1Y5?=
 =?utf-8?B?VWR3akprWmVlcmlHcFNtbkI5d09JMGhwYlFwdmZibXd4cjRJMjd3WG94b3Fa?=
 =?utf-8?B?WkRJVENzaFJ5SDg2Vkc1b1JnREUxVnFPT2YzUy9RWGxUdXNXWmRBY0hNUzBx?=
 =?utf-8?B?U2p5OUZNK1BUWWNpODdVMFZnRjd2V29jUnJFN3pQM3V1Ri9RNXhrSXZvOEdN?=
 =?utf-8?B?Ulc3a3dpY3FvaWYwdXdJeHJQbmh4ZllWRXliY3Q2RGlQMlEyWXFaVjc4VzVs?=
 =?utf-8?B?Wmw1THRuQXRMeXN0cElMOU9xZFJjZzJvVkk1dXVQNkY1WDM4NXdxK3Q3ZURl?=
 =?utf-8?B?R25pV1hvUjRvRWJaYWVHcW8vSG5FMVZXUWowcTBqYlN4Qnd6VGR0NElOaERs?=
 =?utf-8?B?Qk9tU2V6cGF1cHJXZmZ5dG5yQWlEZ203WFVVNWFUa0I2U1ZwTXk3ZjkvYkZP?=
 =?utf-8?B?TENPTHFzMG4xRENHdTZVNy9qMlgyZU82M3MrQWh4cG5qTFAvWXVOa0ZOWi80?=
 =?utf-8?B?dExXUGRrbDZrc2pKNFpVaUY5bHIwa0ZuY0dkTUxjcFgzZXJmMVlsTGRITDBu?=
 =?utf-8?B?OUgzcjhnWDZaRjhBY3dCa0J1ZXgxcy95cm5xYjBFeVlMdmc2b05Rbys3WE85?=
 =?utf-8?B?WWthK1NsSGFzT3U5RVkvaXNyVm1MZnR0WkZRQ1lsSUJlOEU2VlZYdmpDVDFF?=
 =?utf-8?B?c2ZwV3g3WFY0aXVOMjVSZkhZVmR4ZnA2MWVJcS9WZ3E2TDFVTlRJRmp0TlZF?=
 =?utf-8?B?ODQ2Z01lcU9uTm1mVGVlSUNJVkFhOU5Gdm16WkV1V2VHOHVLNXpiaU8xcHJ6?=
 =?utf-8?B?TlRFZTJUcWcybmx1TjE5dGs5S3Z1emZVNUNRbWVObUJFSWZsUFRYeStaTGlJ?=
 =?utf-8?B?ZHlMK2w0dWlXQ01xazNKeDByUXJ0MFZSNktsUDBzQnZ1WWg1bXlBczdwTGVF?=
 =?utf-8?B?THg1bGhKYzdVZndhMnNLeGtDZzRDVHJIVEx3bmVkbW1DKzMwbDYxTlMyNTNy?=
 =?utf-8?B?UE5wdmxvTkZIS2RvdXVlbWVGSnNvNUViZE1laWx1R0NTUDZYR0t6bTZZQnBB?=
 =?utf-8?B?U1FCdFIwLytnbGE0bGVpTGE0RWdUbnc4RGF2NkR6Tk00MUEySm5vZW90bHhZ?=
 =?utf-8?B?RVk3V0ZPRWZwdXBrcitwaXplRXVYY3VkR1hrd2M4SFJkLy9qQjRQUHorY2ZS?=
 =?utf-8?B?ejdTUUcrK0tkQmNKemg5N1lDa3JEdENJMmx5SG9oRDlmeGRXMHdtZGlqNXNJ?=
 =?utf-8?B?Mnk1T21aRUtRR1hIVWd3S1lGUy9FMDVRRWtzcW5MNnJoaHNjWjRXclFNbzQ0?=
 =?utf-8?B?OFJhd3pFSWZhYWQxTlZ4NmEyWDBaMWU4R2VZUTJoRzBiUnMyRHpaanF2YklM?=
 =?utf-8?B?Y1NjdFB1RE1heWh0c1ZlSDcyMTRDRmQxS2VSbVpIMjQ5bytUWHlpMXJCWHVv?=
 =?utf-8?B?aWhnTHoyYytCQVRiVDM5bzNkKzZyQ2VIKzNpTHFTMDhOWmNnd0N2Nk5Xa2RF?=
 =?utf-8?B?aExOa3RWL3NhaE5NMVkvS0J5WFkzMUxycktTbUs2ZCtxVWYyQXhVRFRaZzVu?=
 =?utf-8?B?d1lFOStlK1pKR016UXJYajNHS3RUcjNreTNrcW5nd1paSkRVbFpJdXB1cEVY?=
 =?utf-8?B?b0ZPbFd5aFE4cFBrWGRmZDk2VCsyZitUNHRhZEw1WERxNHVWNGlsTWhwb2Nz?=
 =?utf-8?B?Sk44R1kzd2dTbk4xUXNOVTdCdGNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5acf607-de14-4e15-205c-08d9e19a1df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 13:37:09.2893 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8dxsAXI9+eH6UUxhztiIOGUU6amWZIz2ah19QIWP55ookfnsZ2XaOG2RllQOLvdqFBBTMJAaJvhk9HzzZ1cTMX4HOgQ1NYQHcyp1zKauaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR19MB3909
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-01-27_03:2022-01-27,
 2022-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201270081
X-Proofpoint-GUID: iJ9s_QpWut_SW9-7QuiMU96WHHF8NuPj
X-Proofpoint-ORIG-GUID: iJ9s_QpWut_SW9-7QuiMU96WHHF8NuPj
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_053720_065120_B9A6CD51 
X-CRM114-Status: GOOD (  28.82  )
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

PiBPbiAxLzI1LzIyIDE1OjU5LCBNYXJ0aW4gQmVsYW5nZXIgd3JvdGU6DQo+ID4gRnJvbTogTWFy
dGluIEJlbGFuZ2VyIDxtYXJ0aW4uYmVsYW5nZXJAZGVsbC5jb20+DQo+ID4NCj4gPiBUUDgwMTAg
aW50cm9kdWNlcyB0aGUgQ2VudHJhbCBEaXNjb3ZlcnkgQ29udHJvbGxlciAoQ0RDKS4gVG8NCj4g
PiBkaWZmZXJlbnRpYXRlIGJldHdlZW4gYSBDREMgYW5kIGEgRERDIChEaXJlY3QgREMpLCB0aGUg
aWRlbnRpZnkNCj4gPiByZXNwb25zZSBub3cgY2FycmllcyBhIERDVFlQRSAoRGlzY292ZXJ5IENv
bnRyb2xsZXIgVHlwZSkgZmllbGQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmVs
YW5nZXIgPG1hcnRpbi5iZWxhbmdlckBkZWxsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyB8ICAzICsrKw0KPiA+ICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5o
IHwgIDIgKysNCj4gPiAgIGluY2x1ZGUvbGludXgvbnZtZS5oICAgICB8IDEwICsrKysrKysrKy0N
Cj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2NvcmUuYyBpbmRleA0KPiA+IDRmYzc5NGQ5YzJmNC4uY2QzNGI5MmU4ZTlkIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYw0KPiA+IEBAIC0yOTc4LDYgKzI5NzgsNyBAQCBzdGF0aWMgaW50
IG52bWVfaW5pdF9pZGVudGlmeShzdHJ1Y3QgbnZtZV9jdHJsDQo+ICpjdHJsKQ0KPiA+ICAgCWN0
cmwtPmthcyA9IGxlMTZfdG9fY3B1KGlkLT5rYXMpOw0KPiA+ICAgCWN0cmwtPm1heF9uYW1lc3Bh
Y2VzID0gbGUzMl90b19jcHUoaWQtPm1uYW4pOw0KPiA+ICAgCWN0cmwtPmN0cmF0dCA9IGxlMzJf
dG9fY3B1KGlkLT5jdHJhdHQpOw0KPiA+ICsJY3RybC0+ZGN0eXBlID0gaWQtPmRjdHlwZTsNCj4g
Pg0KPiA+ICAgCWlmIChpZC0+cnRkM2UpIHsNCj4gPiAgIAkJLyogdXMgLT4gcyAqLw0KPiA+IEBA
IC0zMzM1LDYgKzMzMzYsNyBAQCBudm1lX3Nob3dfaW50X2Z1bmN0aW9uKG51bWFfbm9kZSk7DQo+
ID4gICBudm1lX3Nob3dfaW50X2Z1bmN0aW9uKHF1ZXVlX2NvdW50KTsNCj4gPiAgIG52bWVfc2hv
d19pbnRfZnVuY3Rpb24oc3FzaXplKTsNCj4gPiAgIG52bWVfc2hvd19pbnRfZnVuY3Rpb24oa2F0
byk7DQo+ID4gK252bWVfc2hvd19pbnRfZnVuY3Rpb24oZGN0eXBlKTsNCj4gPg0KPiA+ICAgc3Rh
dGljIHNzaXplX3QgbnZtZV9zeXNmc19kZWxldGUoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICAg
CQkJCXN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjb25zdCBjaGFyICpidWYsDQo+IEBA
IC0zNTMzLDYNCj4gPiArMzUzNSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpudm1lX2Rl
dl9hdHRyc1tdID0gew0KPiA+ICAgCSZkZXZfYXR0cl9yZWNvbm5lY3RfZGVsYXkuYXR0ciwNCj4g
PiAgIAkmZGV2X2F0dHJfZmFzdF9pb19mYWlsX3Rtby5hdHRyLA0KPiA+ICAgCSZkZXZfYXR0cl9r
YXRvLmF0dHIsDQo+ID4gKwkmZGV2X2F0dHJfZGN0eXBlLmF0dHIsDQo+ID4gICAJTlVMTA0KPiA+
ICAgfTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmggYi9k
cml2ZXJzL252bWUvaG9zdC9udm1lLmggaW5kZXgNCj4gPiBmZTIyNDAxNjQxOGUuLmY4YjYwZjcz
NDZmZCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gPiArKysg
Yi9kcml2ZXJzL252bWUvaG9zdC9udm1lLmgNCj4gPiBAQCAtMzQ5LDYgKzM0OSw4IEBAIHN0cnVj
dCBudm1lX2N0cmwgew0KPiA+ICAgCXVuc2lnbmVkIGxvbmcgZGlzY2FyZF9wYWdlX2J1c3k7DQo+
ID4NCj4gPiAgIAlzdHJ1Y3QgbnZtZV9mYXVsdF9pbmplY3QgZmF1bHRfaW5qZWN0Ow0KPiA+ICsN
Cj4gPiArCWVudW0gbnZtZV9kY3R5cGUgZGN0eXBlOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgZW51
bSBudm1lX2lvcG9saWN5IHsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9udm1lLmgg
Yi9pbmNsdWRlL2xpbnV4L252bWUuaCBpbmRleA0KPiA+IDg1NWRkOWIzZTg0Yi4uODI1NjdkNDkz
YzUxIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbnZtZS5oDQo+ID4gKysrIGIvaW5j
bHVkZS9saW51eC9udm1lLmgNCj4gPiBAQCAtMjQwLDYgKzI0MCwxMiBAQCBlbnVtIG52bWVfY3Ry
bF9hdHRyIHsNCj4gPiAgIAlOVk1FX0NUUkxfQVRUUl9UQktBUwkJPSAoMSA8PCA2KSwNCj4gPiAg
IH07DQo+ID4NCj4gPiArZW51bSBudm1lX2RjdHlwZSB7DQo+ID4gKwlOVk1FX0RDVFlQRV9OT1Rf
UkVQT1JURUQgPSAwLA0KPiA+ICsJTlZNRV9EQ1RZUEVfRERDID0gMSwNCj4gPiArCU5WTUVfRENU
WVBFX0NEQyA9IDIsDQo+ID4gK307DQo+ID4gKw0KPiA+ICAgc3RydWN0IG52bWVfaWRfY3RybCB7
DQo+ID4gICAJX19sZTE2CQkJdmlkOw0KPiA+ICAgCV9fbGUxNgkJCXNzdmlkOw0KPiA+IEBAIC0z
MjAsNyArMzI2LDkgQEAgc3RydWN0IG52bWVfaWRfY3RybCB7DQo+ID4gICAJX19sZTE2CQkJaWNk
b2ZmOw0KPiA+ICAgCV9fdTgJCQljdHJhdHRyOw0KPiA+ICAgCV9fdTgJCQltc2RiZDsNCj4gPiAt
CV9fdTgJCQlyc3ZkMTgwNFsyNDRdOw0KPiA+ICsJX19sZTE2CQkJb2ZjczsNCj4gPiArCV9fdTgJ
CQlkY3R5cGU7DQo+ID4gKwlfX3U4CQkJcnN2ZDE4MDdbMjQxXTsNCj4gPiAgIAlzdHJ1Y3QgbnZt
ZV9pZF9wb3dlcl9zdGF0ZQlwc2RbMzJdOw0KPiA+ICAgCV9fdTgJCQl2c1sxMDI0XTsNCj4gPiAg
IH07DQo+IA0KPiBQbGVhc2UgZGVjb2RlIHRoZSBmaWVsZHMgZm9yIHRoZSBzeXNmcyBhdHRyaWJ1
dGU7ICdjZGMnIGlzIGZhciBlYXNpZXIgdG8NCj4gdW5kZXJzdGFuZCB0aGFuICcyJy4NCg0KT2ss
IEkgd2lsbCBhZGQgYSBkZWNvZGVyLCBidXQganVzdCB0byBleHBsYWluIHdoeSBJIGRpZCBpdCB0
aGlzIHdheS4uLi4NCg0KSSBhZ3JlZSB0aGF0ICdjZGMnIGlzIG1vcmUgaHVtYW4tcmVhZGFibGUg
dGhhbiAyLiBPbiB0aGUgb3RoZXIgaGFuZCwNCmRlY29kaW5nIHRvIGEgc3RyaW5nIGhhcyB0aGUg
ZHJhd2JhY2sgdGhhdCB3aGVuIChpZikgdGhlIGVudW1lcmF0aW9uIA0KY2hhbmdlcywgdGhlbiB3
ZSBuZWVkIHRvIGFkZCBtb3JlIGRlY29kZSBjb2RlIGluIHRoZSBrZXJuZWwuDQoNCkFzIHlvdSBr
bm93IGl0IHRha2VzIGEgd2hpbGUgZm9yIGtlcm5lbCBjaGFuZ2VzIHRvIG1ha2UgaXQgaW50byBh
IGRpc3Ryby4NCkJ5IHNpbXBseSBwcmludGluZyB0aGUgZGVjaW1hbCB2YWx1ZSB3ZSBuZXZlciBo
YXZlIHRvIG1ha2UgY2hhbmdlcyANCnRvIHRoZSBrZXJuZWwgYWdhaW4gYW5kIGFueSB2YWx1ZSBh
ZGRlZCB0byB0aGUgZW51bSBpbiB0aGUgZnV0dXJlIHdpbGwNCmp1c3Qgc2hvdyB1cC4NCg0KPiAN
Cj4gQ2hlZXJzLA0KPiANCj4gSGFubmVzDQo+IC0tDQo+IERyLiBIYW5uZXMgUmVpbmVja2UJCSAg
ICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0DQo+IGhhcmVAc3VzZS5kZQkJCSAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4DQo+IFNVU0UgU29mdHdhcmUgU29sdXRpb25z
IEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnDQo+IEhSQiAzNjgw
OSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcg0KDQpJbnRlcm5hbCBVc2Ug
LSBDb25maWRlbnRpYWwNCg==

