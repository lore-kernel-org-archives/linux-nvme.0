Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033D8C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 23:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OQ/60h0+dLUZ2Q8BX2t23kxSm1cQ36X8t9YuerXzthM=; b=is2JjnGDENFlZs6O9QZBHUxwWi
	QHd4jfLeH5hwx96nDmjKZ7QvFURz628XYU5FMkbIPKRDBJFqn7EARQ41Xc28Ns2TgmT7CIQ1hEQ2c
	e3oFyaR/QY0i8EtVlMExfAzT3VpAyBCV1ymvYanDa5rPjxt9bMk4e7oZI6cBgWjcbxsmFROAC6IfY
	EBtJ0RDjU4FiAf6mSfB1Xg7sviiCvzAxvlWOxz2HtRhG+2ME6GIAv8HMt+delFkh/6boygnkC2wKs
	YS8LrUVA7n53NQC9jucU3Hsgc2xLiXB0sbNe53GAPGhcJLX4ZXu1qNj8cef+N4HMfjqYMkFPWnNjZ
	1Xrt94/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf7Xe-0004OL-0n;
	Wed, 22 Mar 2023 23:06:50 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf7Xa-0004NO-0s
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 23:06:48 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MJIirV010996;
	Wed, 22 Mar 2023 23:06:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OQ/60h0+dLUZ2Q8BX2t23kxSm1cQ36X8t9YuerXzthM=;
 b=FAdpib2vyZweN6wQkAd/ClwxSsSR1NqK8i/Ywrg98IBlEmlfGQaM4zHE4Eqj1kaHNyDw
 MIPagNHb6faDvkp2W2hQtWRf52H/oHpqPe80F0fpb+DmEX3ashYX6fDBZUEiAqRHoQXE
 P9rnsKZ0WfyGhfaaGnV4T1FLgV1KsL6LBAJwFyoC7ut8cTy1DjQdiLx7iqAqiKmSdgvB
 IonAWEWw4nYm3MhFlevEOMIa0GiWFv++/oBJ76HQr4GT7YL8Z6aM10kZG++De2Jzbh77
 KiZo96vE78CMK1srA1wF+9V1EF8APqZiSBIfdzK9iDSFY+ddHxjc1xqj1jeznmdqt6ZM TA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd5bcjce7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Mar 2023 23:06:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32MMJ0fI013125;
	Wed, 22 Mar 2023 23:06:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgac194qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Mar 2023 23:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZrjw9+JPc/nJzZPabJ7GZWnEW4VrLL/WaEbh5lu60JSVAg5fJQqEHHDpeDwz/UNDg7LQ9wpXPAYWruU83eqXhR/oIFazomhfUtF9i/3A3W/bYmzXl118rEggiY041XgcvX/w1rEHVy7JQfxvNgj9f27Yah2Hj2T0rN7WPooL7wKG3pAlr/fIvH1jy0XkIvZWLhiG3ImG/Nh4nBQBDJ39MCx0ADARXLdSPq3870IdB+HXGkM3cl0Py7pWIPrk95/u+5ugUhCIvKuZoysvs5HdoXM7gtX8oE4lx5iiJERvT5S+rc7Tbki9nkM12lp/8JUSseXDaT4hzpj/79farCddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ/60h0+dLUZ2Q8BX2t23kxSm1cQ36X8t9YuerXzthM=;
 b=TKIlxdePhlXxrKSyvy90z6FZViZPc4n1JH/6rVOVwSonSjuJf+M3L8bh+un4v7WXAI7wtnj3lJOcIbDoVjlw0pidy9S8vXTlF9HWxNsfylB7Hpkm3YcGjKD/l01vr+MLMKcb3w4Uax0HzZcyalUypXMq7J/wqtSqWwz3uVpeuo41akmBtt6l/iZgbUYBn1B5TbaMmjupruexlwm2lE0CrFCjChfH3a42unTVrD7Bh6WQwJV3uWxVgeuKP74JXedpx/j5j39KXzXvgFUSSgoYtM9rO0Ql+Mm5clp2pFYRaZ2e9HZAceKLVt/3b3JwiSIcr6wADn5O51lsJnE7k55xRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ/60h0+dLUZ2Q8BX2t23kxSm1cQ36X8t9YuerXzthM=;
 b=o/SiBT/exaEM1HA25MLAqaSNubFDcbh7L+iUfkxU0aO7v85H1Vw1JATgwc2spWgX2zoWmljqjWTVPr9t0kvbyUMn2FWQ6dyiHTTurQcCy6bmyndyIm1YqHSb5v261HePfX7UQ8QlqudHcWbu3iZdeaJsGTNiluga0RahJRMkJpY=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 23:06:29 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 23:06:29 +0000
Message-ID: <e8fe009b-6707-2b99-9c62-01c72746bdca@oracle.com>
Date: Wed, 22 Mar 2023 16:06:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC 2/2] nvme: add error logging opt-in
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
References: <20230316234958.1486700-1-alan.adamson@oracle.com>
 <20230316234958.1486700-3-alan.adamson@oracle.com>
 <CGME20230317090114eucas1p11073fbdbca45d20600789ec121d4470e@eucas1p1.samsung.com>
 <20230317085257.thj7cwhg6cip26gt@blixen>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20230317085257.thj7cwhg6cip26gt@blixen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:806:22::8) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB5698:EE_
X-MS-Office365-Filtering-Correlation-Id: 246dfddc-171d-4937-53ec-08db2b2a11ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	JuOaGm51c7bc3pIFhgimMYw/aE97/TdyILa7uMuBqTbHnq2+/FNPwFwt++M9fJARTxEX0hzJESyfSKPg4JzrdAeNiC7ixMQuYQjUvbGK4dSXxvTWOGqzT6Ae4ezSiUi6EgJMqs1evwdlafmyvORHFxSD4uXcVS6teYtpw2oQlXsIxJhXHgYOTF3XmYbKyLREwGK26ejnG+raOkEVj7MBzofF9I1oCkCKtWCzrFAyzE3foIPEhb2Z3hmGo7hWzLQq8GKLo8+OtIAIjM3yH1U6Q8hrAVlcJP0xgHpdlmC5qbrhybcrZcQnD6QO/Xe1bdwIutcsT8cqqDeWSTt71jrmPuUu1o5HHoMRyZJJ1RMqBLe+vkZHOZ4+9RjUlM8vIoyhk3F93RxItW3U/NCzQKjc7j4mFxYjZNLHlTNooOtY6RXHhnrQShgmsNYyT5ivqogjks6tEYyIU2lukB82m5Rz8F60UuDG7Imo2+nVXdOxeTbPBJDwaiYm/jCzvxmXGVz9n6Uqaeyh3aFmEv5Zan1dVSRe1qMldj8VVmQZCElv9rMDlJIssch9dcbZ5MPTRILBd6Y2AT8XhnO5Q5qUBWSQnn/Lp8CZotn179W1uWVuBRiRgnywzTNkW+Z6qJgm17tfHQ5eI/uMY+Gws59FbLEntBZF6WFhHFdf2PVAnI7H8ntEqllWovs6+ID0L5ZX0PgwNYh6I7ClGI2xPkzHFuPbYw==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199018)(31686004)(2616005)(9686003)(6666004)(6486002)(53546011)(6506007)(26005)(186003)(6512007)(38100700002)(31696002)(478600001)(2906002)(86362001)(316002)(4744005)(66946007)(8676002)(66476007)(41300700001)(8936002)(6916009)(5660300002)(4326008)(36756003)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?eUhaRmJkZkJxdUhEdHFnWEVwbkE0cGdVa2k1NU1TVDExcDhZbE92dFFrUnJs?=
 =?utf-8?B?NHhFS3FBSk9TRnZUZTJKVGdLemkzcE9xMkVCV3hDek1RN241c1NlL1VRQmFV?=
 =?utf-8?B?cmFTeSsvOVB1SmdjNHNuSlhPSEZvRzFKbnBQSXUva1RvTmVLQVczV1o4N1lI?=
 =?utf-8?B?R3hMTTZoS3RDaEFhdXJYeUd4RmtJS2RiWlZkVWV4SFA5SDY3SkVTb2hYV29a?=
 =?utf-8?B?UjRJVlBIcnN2SWROUkFPTVpydkp0cnBpeFhiYWhRWFhHUE5zNEZ2MVRvNDA2?=
 =?utf-8?B?cXY0S0UzR1N1TzkwaHJXNmNBMXFDMStaa2JzRlhMNFpwaFE2ejdZT3FiWEc5?=
 =?utf-8?B?R2xaaUx3QlhRSnlXTGhMbnJlak5ETTVaSjl6OUVyZHZLZ0cybHFpVXNscW54?=
 =?utf-8?B?MmIzSkFJdHNwVC9VL0F0NElKM2RLaStJMTkzT0RWRGo2NGlYUDNjQVgxTDN0?=
 =?utf-8?B?SlllYmxyY3JXVlZaWGJUMUVVcVRBWURNZGhzRGFydGdSd3ZCTTFHWXdMcHpw?=
 =?utf-8?B?VTJ1dHhCUE05WkQzQ0g4WjE4MytLUGZoWlRRNUNvRUtnTEZMdzcydkxPb3g1?=
 =?utf-8?B?d29RV2hTZlB6c0l3UGRCTnpyRDJNL0E5UVdXZmgvVkZMQTJzT1JiS0U4bmQ1?=
 =?utf-8?B?K3cwSVVlNC8vK1QybUY2aEdEQU1PVEl2WXluUVZGV1FKc0pQbzE0Tkhnc2JY?=
 =?utf-8?B?eGRvbHFsSXBBOXRIaVMrSEt4cHBDaTI4Y3NlTFVwbGdkWEZKS3BjS1RXc01O?=
 =?utf-8?B?NXl3ZEcvQTVoU3F1WjBwSExpUGpmandCYUwvSDRqSkNVRVlBdkU1ejRrU1lr?=
 =?utf-8?B?N3dheUwwZ0h4MG9DWHYzbkd3cUxhZjhFV2lnVEhvMCtxdjlJbXBxaHBZOUx2?=
 =?utf-8?B?czFvd1VmZVRHVXhZNU44M3lsRldtSlZIU0krWGFzVWlFTHRTZm5TdmNjOTdj?=
 =?utf-8?B?QjJBMDVHdURwc2N1ZU5nNXBEeGUyaUdxY3JiSThFNnBRL1puby9JMHlRbVZL?=
 =?utf-8?B?L0NYL2p4a2w4V3hkOTNYRElvbVVGVDlWblNnSzZuUEJ3QnBFeVZnSHJuUE40?=
 =?utf-8?B?NVJKcUN2R054aDg4QitrUjYrKzV3OEN6Z3owY2RmS1hyWmN1bXpqeGpVbXNF?=
 =?utf-8?B?M3JpZjZLNGYyd1V3dGQ2eGtiWXpPU0lDQ29QRFVpdUpCUzAvOVFRL0FYQkd1?=
 =?utf-8?B?UWdmQ20yUlhxKzRQTFBvNlcyTjQ5dldDY2hXdnVzWnNkYTJYS0JiMmFJQjVa?=
 =?utf-8?B?cTZzbUJzazByV0V0VW42eUFzc1hLMmZvMnJVNlptd2ttUkIyRmE2ZlFsVS9H?=
 =?utf-8?B?a2NSR1VNeUt4N1B3K1VYaEd3eVpQMHZzRmdYREF5TDdYRVlhdmxISCtVVEVv?=
 =?utf-8?B?U01zNXU1WU4vZFRGWFN6aHVMb01pTmxwYW1sMkFqK0tJdXFHd3FZK1d1cFVt?=
 =?utf-8?B?Z3VIMlVLNGZ4TDQwTkREOERxRUszNFBlcEI3ODZBSVhEa1luYThtMjUyZjV6?=
 =?utf-8?B?VkdwZlBkVVR4a0d6VUNHNnNXdkwzRGpWWVorSFlKdjdtMFVKYWV6WjNYUzJt?=
 =?utf-8?B?Qm80clJtM2w5TjhRelk0WWNnSXRIb1dWRGlPUithZFkzQ2IwT3F3ODlvazhp?=
 =?utf-8?B?aGY0WjdnV2hrYm8wMnVzSlhOSEpMdDBRd0ZhZVFZaTNMTmFRUFowa2xrbnR4?=
 =?utf-8?B?WEhEZll1cXF0a0hROENJMUtWNW5QRWl4NmFMeDdDUGhmNE5jRkZqNnZFYmM0?=
 =?utf-8?B?SDJ2R1hYdjNydTk4L3c2MHpxVUxsZkMvVERlcmVLck8zQmhNNURLVk9tdEpH?=
 =?utf-8?B?b2tCNnlnVExiTU5rN1FlNG9WdU9rMUNYajM1OG92eGdMU1hMeWVXVWg4TjdC?=
 =?utf-8?B?QW1KYTVOM1RMY1ZnWVYrdGVVL2phN1RSdk5LckZVZW51NjN1Y25RQUR4aWda?=
 =?utf-8?B?Qlg4UFFUeTF1WFdSQnM2Q2h5QjIvTHVNelJNQ2tEcG1lRnJKWHVVZUpFTzNk?=
 =?utf-8?B?Ui9mQ09sY0ZsQTJkTktkTWlTczNabWVDVllwNWRESnBCVUUyejJPUW9McGVJ?=
 =?utf-8?B?by9CUnpDc3Y5azE2ZEdUbkl3K1lndVZacGxLbGgvNUF6OWtkcHpNS2NINmZB?=
 =?utf-8?B?OW1GQ3NLOTZXcW94VEU4YW41ZlJPaDVta2RoaGtNQ3k3SVZnK096L3JlNHVk?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	29KkhShkq6+daiZZHfCHRrKwBppasif1T7YQwckdBRFh5gWdEvHg1HlgWR8u4kK9Rlttdc+fT/AipQ5H5AvbhZNGQBYF5smfLdhWkqIwr/r66Slw68PObAfJK0xB2G4ZVR7kDn1I73nedy1chplCLF2Bs956cpBRnOxQPwyY49SqIo8yg5USXMc24LgSBdO2sWiWL4IyvKsRpE6oOxzm8WHmXm85vbhmblDLLeP78+ApU90vXNDmVXcObNotZReHXHYSFkzayBxnW1nzCwSBMRgcmuGmmLEKSBCD2o2Y9C2mdHXIotwFK9/FIjNbplhO3lpjafSKLgKqAlfH1Kkonlmn9RlGCR6Baq6HSjn6R/7FlRaaCQgDRXQ7o5YFuZv8TTptZMr9Tvb4AYJ7T+ASCeEZCYJXA+LxTQdxws8CQZ01nP2Sh20ErBi4tRaXRzjzUSStqA5u/ujQIdhGNy89tQNkc4jvA8VYSKNiNy9xACdKhMeJTxmeDrEm+cVYXcJM/VWY+A8cN3XJQYvT/GndYOc8RwSqZjb5AJGyZqePH7nck/b2NM5no/T6l3FKLhIucPlXCqw7levEHgw3XvpDrhqVtYXfRbiUNMv3GUvdqiEiaoW8HtHA6SXCPJcvxTi0r3Yex3CtBgJBM2jDWSrRADWSzF6mc6UZGgS92dZkX914rp08hzA5t5MWDOnMD9jvYEFaqo8H2NKtAyRMfjWH5ddQqzjKj4j4hHuh+YLaRJ4hjfbTmZgTYFvKBf2GEsgxji6OTmL3/Vce5h7t50TJnL9DiIjrQAOuC2tB6hUyPKbw4Hg/GMZYdAptvybfAucyDd9pLXspYFER8EhcvEwhgfYG5LGQeOrmTaBVHyCkgLzbwXuWS8Y8aaiV1bmT0uU+
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 246dfddc-171d-4937-53ec-08db2b2a11ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 23:06:29.2663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HaP5ZONsUwXo6DaQt/eIMwaRMAxYMUflESyUSLld4txLz6wczfIIUlC7IycJhis05MtE547LD7CptSXigCLcMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5698
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_18,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303220167
X-Proofpoint-ORIG-GUID: Wrx5zuyBD2vI6b76zRZ_2Lxp-FZA9I6a
X-Proofpoint-GUID: Wrx5zuyBD2vI6b76zRZ_2Lxp-FZA9I6a
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_160647_294080_13DF73DA 
X-CRM114-Status: GOOD (  16.52  )
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


On 3/17/23 1:52 AM, Pankaj Raghav wrote:
> On Thu, Mar 16, 2023 at 04:49:58PM -0700, Alan Adamson wrote:
>>   
>> @@ -5183,6 +5188,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>>   
>>   	nvme_debugfs_init(&ctrl->debugfs, dev_name(ctrl->device));
>>   	nvme_fault_inject_init(&ctrl->debugfs);
>> +
>> +	ctrl->debugfs.error_logging = false;
> Can we wrap the above statement into nvme_error_logging_init function?
> static inline void nvme_error_logging_init(struct nvme_debugfs *debugfs)
> {
> 	debugfs->error_logging = false;
> }

Since the error_logging flag is being used outside the debugfs 
environment, it will need to be initialized to false even if Pass 
Through errors is not configured.  I will move the flag to the nvme_ctrl.

Thanks,

Alan


