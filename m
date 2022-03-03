Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E4CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 13:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0UBkJ2Pb7W1PxYzO7A3LI3ZwpErtCl3yriSz9WeOiFY=; b=dGK20VZdi8i5nIYOnzVw//IhgY
	fymF70apDbVYPipYhZQW0PaQhfuQNaQXMSxcGm4bR6px+r3D0X4/CY0hf6L79DQBtvZPc62JddP+R
	Ok6apST9shBxELLJN1e1XgxzcOOfgyasDJSSg5n+4UWsb/Pyl4U8czXeEQgbKYqbkJmHjqgOKFjdu
	AA1rfiVZr7HhRzyAulpwcvTcB7zG4Wytzb8NJ+bdd3JqDyBuEW/sm6I6YL8jlS+FezSb0UGTzIoTQ
	CajcdX7nt7DhdjGFMZfTtX1ihFyuXx/qBVoJ//7N5MhLpMVaAVlRqa/KIijQTT1P10NFisvfZaphB
	BYAM1z0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPlaC-006VSH-Hf; Thu, 03 Mar 2022 13:33:28 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPlZz-006VPf-Qz
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 13:33:17 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2235c1u1003374;
 Thu, 3 Mar 2022 05:30:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0UBkJ2Pb7W1PxYzO7A3LI3ZwpErtCl3yriSz9WeOiFY=;
 b=Xj6o38WMUdYYg0qOwTevlcujiYdBx4F7rfG09pQaT8XoxiJFWUbx81NaP68i8IFyHEtV
 /HkQ5BAsrO1rSP+RII0StgHWG7TUnJ0W73zt51CJTs/Qp8J2ZnN5Mfv94g9JaH6PYVwC
 yb6pWlnx7Bfk8G2f6H64Vt6uzmHGBvrYVO4= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
 by m0001303.ppops.net (PPS) with ESMTPS id 3ejqpua492-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Mar 2022 05:30:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnwYkk/eGWCBgghRJ1Tv7UraVOiARNQjBt4Srh0MzlEJxG7kfKMStz79PDXSZi3seYaVpQKK3NdXyeNvp1EkVCB1YFzWVL9IqdhqpdAkQiIr9LUtm8HURzxJtIeffejN8LA2jW0c7AFvzzSuMkrP9+v0QM5z0cFxroI+pwuhqE9rHC5JpUOOmae/NmD/RuRLooXNeB8TTi0t2D/Mn/whPRUhwOro2Pcrii0iije+XNXaETP8mfT6FGJALg1XJZl+4UJ566OVlWCcJN4fCuYii+RrKml8d0lGjA7yDvWpmkv/aAzuD0bot07fMJEPoHOtQlwTeZ7QuaNvhNCr9Bi1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UBkJ2Pb7W1PxYzO7A3LI3ZwpErtCl3yriSz9WeOiFY=;
 b=ZqWWmfa57extA2YQhTzjOnFJv+4h8W8iLzI9rZAvkqgaqngw1ZUePPLKiRyxVDnFzbuS8mksdbmqL4vgvZyyyLqE+HmAjRcMzgssJPqerqk5Z4lZYmWKFel0reEvpMOf6/jcz63Gy/gbNZOzEkg8ghm7CraBRedHP+qo2c8inpWw38i/uV24/+RKuDL5x9OQ0GwwlcpNrdnGwdbYAqPqxLrNAbh6bqhXvmz/iOwBrK0nF2A6b26RPGmLMT5ea2wFm3Ea1IkNNNA0o8PSOmysqbHMmVpaZhvlQtW9kLDCy1uFmZta0P9Np10yY0FmgveSan5h0Ya799BPhLl3IJfaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by DM6PR15MB2219.namprd15.prod.outlook.com (2603:10b6:5:86::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 13:30:23 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::4c03:ad71:a2cf:cd92]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::4c03:ad71:a2cf:cd92%5]) with mapi id 15.20.5038.016; Thu, 3 Mar 2022
 13:30:23 +0000
Message-ID: <03da08be-249b-38c5-598d-c00645888794@fb.com>
Date: Thu, 3 Mar 2022 06:30:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvme: remove support or stream based temperature hint
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
References: <20220303105049.315987-1-hch@lst.de>
From: Jens Axboe <axboe@fb.com>
In-Reply-To: <20220303105049.315987-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR14CA0053.namprd14.prod.outlook.com
 (2603:10b6:300:81::15) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24ff31c-1bd4-45fb-18fc-08d9fd19f871
X-MS-TrafficTypeDiagnostic: DM6PR15MB2219:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB2219F20ACAE4242AEB96D457C0049@DM6PR15MB2219.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJ8BzWfkgsw+bSwzCVtdmICYDZBbXN1RU2GnatOjR6mfmthOe1WiNcsDQ+JfPheB44AlNsdrsr7F0CI6DBbIH7pz6T7//nhxb6XY2yTbbnxgXuFlGG96LZgLqP3q9b9hYN/J6/2NOYf4pnyD7aFotrEGx6B3BexZn/hl8K2qABcGRh1YqwqtWvzb4PleR/SGUdQwnP2SmeXxxwnQbSivE8C+9SwVlR5boneoNgXfZr7E/6+RqgCZi7vb+JMuzQ/uzhvQkFfinEYqNK8MKfK/yv8gAhJXy4ASW6O0kcFajLC3/Xkm8qPx9vdO3/w9VgrgHqaJNSFLcLfBjxH1V/mQ93ldfGVm0IoCTSLsz7trK+bm+RCDEnEZ5/znwzydFuCv7RKY5szaeEJYJDZKooKxfiZg9dICXe6eMZdrrel8wxaQw2/FP8HZoT2AoPE4oIIzLBdZgAatvIxKzxzUYGvWPgVzaOIFpFNO48Q1mK7eJFiE2EKeynaeB0P1E9V6diCdRKFMlwfEz/ScGSlOTK0qckqhwjUhdoFrU8H3SIfjtRQu7FKkfXxyU3HdSTYVcOi3oHDOpY4xAewSTyPpStwQMJXRCges0aWYCol5vtuiEtar2WF6zL6lIByIX1bXRpBnPuToqqm7JTCulgjwd+f7Z7g2q6BO0Za9+yLgckel9YXEGC3C8XrOi5cOL67nfQbMhIoJhzMEO4xoDDirvUiPxliOo99i6gWaDAOpr823j7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2566.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(508600001)(6486002)(38100700002)(316002)(66946007)(66556008)(66476007)(31696002)(8676002)(86362001)(4326008)(36756003)(6506007)(31686004)(2616005)(4744005)(5660300002)(2906002)(6512007)(186003)(8936002)(26005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWNJMWxLelVhZGZhMlR6OWdoZjIrV1RCNERSanhlZHJYVmtzZUo1ZjV6d2Rr?=
 =?utf-8?B?Y3hJa2hERHJ2NjV6bmFyN2Q2SlFTMnZRMWVXWjEzQy9qeitNUGd1VTZPOERG?=
 =?utf-8?B?aHVLUVJtbTNaU2twbE53Q2JUZlFkNG1mRm9OcHRFNE1iMXFCYmxzQUxDZm45?=
 =?utf-8?B?S0pBV1FTZXJRMzgySlNZa0p0UWsvM2pzVWkxZFRZMU1nOFhoZzc5bXpYN0VQ?=
 =?utf-8?B?Z0dnT1BISEpGT3Y3SUR0VkF0cW80bEpLSDl0QmFzUkh4OHk4REpaVzNrRkpo?=
 =?utf-8?B?a3RmMndydm01L0VPTkdDTk1lNENISUo0RTZiemdKSUF5SGNNMVRZT0tiYm5h?=
 =?utf-8?B?a2t1NHpsTE1QV1diSW85UCtScHpzYU5wLzZNbTZBRTcrMkZ6dFJlK2dtTnpI?=
 =?utf-8?B?ZGJFdXNZMTQ1QlhmVkt6Rm1LZDVnaWluOHNSa0wzcUF0WHFTZzc4dU9IOVlQ?=
 =?utf-8?B?dDBVK2h2dnFWZE1vQ3BFc2RuMEZRUHZmVHg2ZERrdDNZbG85YXNvcjgwS3cv?=
 =?utf-8?B?MXFnWHNkVmdheXVENlVTelJQdEdJU2NxWmwrWUVUcFNMWW15S2tnOGM4MXhW?=
 =?utf-8?B?cml4RlRiamZFd08wWnY5aTRiZEQ2OHpSeTlCSDZVVTNWdi96RkJhRmpwWW90?=
 =?utf-8?B?N0ZWTWRwUWRpaHM4aGQ1SjBRa1E0QmNjL1RMVGpKYi9TeDlodDZzL0UyYlFJ?=
 =?utf-8?B?M0pRY20xUG1KS3BRb3VZcDV0dEY3RTVTcDkwVTU4SzdUMUowTUNNa01hWnd1?=
 =?utf-8?B?MWs1b0RUQk9POHpxekdhQ3FLc1JWdGNNZjRUZ2ovOUpjcVNxTVV2VDdiNGU1?=
 =?utf-8?B?MThNck8vT3doWE9FQzJ6YlIvUnFyVlM0V0dST0tZeSt0SmZwOExuWW9VQy9S?=
 =?utf-8?B?bno1ZjhLWFZIdkxyWFd5T2ZHYTZyeGd2b0RiZ3BKV2M2cVFFZmpyMjJpUnpJ?=
 =?utf-8?B?akxqUHJnSCtoOENLNXRxdHNaMkgvdks3ZFNOckxqSmZ5bm1Pc0pLNHR3bzdz?=
 =?utf-8?B?aVBlN28xSFEvdzVERnhUTXZ1VUpQQUVsSU93UFh4SWtoaXJOeEhtNi8zN0pR?=
 =?utf-8?B?WVhOOERmUjUrMU45SGlWd01MTHQwTGpXQ0w4cFhraUdnVGhzeWdiWkZ3bk9o?=
 =?utf-8?B?UGlFNGJmTlVOT3haSytZc2Fod2Rodi92N01MY1NhQlZhRC9Fcm9QdHlPR2pW?=
 =?utf-8?B?MlNDT3NKYWtTcUlBZndCNllHekJGNkVuaTB5UDNHbUFQNjNaL1E4dnZldnNV?=
 =?utf-8?B?M3lITFltUEx4eVlJT0Zlc3ZvQWJsZ2RZZjJJeVJEVkU1TTFJbERKTGFld1ZL?=
 =?utf-8?B?Y1JqUncxLzdNVzBaWk0zd3MwaGJCdUZnQnU2ZWd0VEpLWkcvaURPdW1kR0Nu?=
 =?utf-8?B?NVBHWGRhSmhpdyt6N0E3eGhqRUhRaHVlMTc1dXVXUlZBS29OK09FOXljTm1w?=
 =?utf-8?B?VG5rZ1lWRmNzdE5qY2UvVlZsZEdCb2FNa2JtNDFrUU5LUFdGMVJXbk5YZTJm?=
 =?utf-8?B?NzF6Mk5OWWtSc3dBSUFvaGtRbjVKTVR6ZHBXcFJNV2R1bHZ6R21oT1lNTkVu?=
 =?utf-8?B?RjE1R0NwWG1aR2pwL05tYkswQU8wWFNKQ0pxK3JyNTZibzBqRWdkK25tNGZT?=
 =?utf-8?B?OW9tVnBFeDV1ZlVrQWhuZ3NNVjVxMERkVk1GYno2WExpbGt6Nys4SHFRTS9j?=
 =?utf-8?B?UDdmUTFzbVdxQ1V6MWx0RVRmajV1QkMxSEF3ZnNpNGVnQXlXdVJPQlNzWDN6?=
 =?utf-8?B?d3VYSUJMTlF0VE9Xc2dwK3lraGh3bzArT2FCc041Qk5aOGNPckRYbDhPNnZ3?=
 =?utf-8?B?c3laTUc5QUlMa21lRGF2ZGQrV1Fyc09rVlpRYWxnNXNrTnRwMnNEeXhBTU1R?=
 =?utf-8?B?MWtyVllBZTBRby9TTG5HazZxeW1IeXJvNDVRU1VDbVd2UTRWZ2EwTGhTbWJN?=
 =?utf-8?B?bTlwc011cmNMUi8xWmJCSTJraEtETW9BWUJ5WVFWWFBjQU5mSDBtdW1YVnRZ?=
 =?utf-8?B?Y2ErM0lkZ280dWxPeGkyZUZmaXJ1cFN2bDdrang4a0tVbzlxVkp2WldxK0JK?=
 =?utf-8?B?NEhBSFJyaFRjTERQU2xjVTNma1Z2ZlAxYjNyTkdZdHVMck50dXVWRitBRklx?=
 =?utf-8?Q?3mpQ=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c24ff31c-1bd4-45fb-18fc-08d9fd19f871
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:30:23.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY6h/nTtY3HCA4M3ZhjzKvQwGJiaoBIQtAwskU4EOrF2bBp+q4EY84FompqAUaTa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2219
X-Proofpoint-ORIG-GUID: kUtVdFd9jLJnVKq7i_BOG510zpkCN_hm
X-Proofpoint-GUID: kUtVdFd9jLJnVKq7i_BOG510zpkCN_hm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0
 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030063
X-FB-Internal: deliver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_053316_043012_713D8038 
X-CRM114-Status: GOOD (  12.33  )
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

On 3/3/22 3:50 AM, Christoph Hellwig wrote:
> This support was added for RocksDB, but RocksDB ended up not using it.
> At the same time drives on the open marked (vs those build for OEMs
> for non-Linux support) that actually support streams are extremly
> rare.  Don't bloat the nvme driver for it.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


