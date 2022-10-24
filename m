Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B880C67871
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 21:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:To:From:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6apzl3DZgy8wdgM4i1/EG3TnzpJ6yY+YFiphiUbRZbk=; b=yIawfLeYLY2A24
	fCyRi8uIkW7/ravW4xcyl5f5OwCrWMAKHMTlA9rIBl5NK275sQl2qysMLohM/jR7w55su+PkSM4qx
	YLOTRyKsAX5BP8vA5LVtYo/Krg5GefmlxZL2gxLHdlRl8tgPqHhuR3Pk6ivbcrkjhxecCO74OtaT2
	Qpu91dI1xqOqrLRZIdRTMcRTaD+8ScNbyGQqYIR8xa6DEVUpirxCjZhmvz38AONe0XGBRbu0vCaTC
	p0KKs+FyXT8cWwsqGDnDVmmTxnY6/HdHoHbalscDEiRlS92SPDglT/r94aof9JtT8+cLXzP75Ru2E
	FhYonlP1hpAA+/nPqyHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on5Fm-0035fD-Ah; Mon, 24 Oct 2022 21:45:02 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on5Ff-0035eN-NC
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 21:45:00 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OKTuxi021680
	for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 21:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : to : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=6apzl3DZgy8wdgM4i1/EG3TnzpJ6yY+YFiphiUbRZbk=;
 b=ZOC38NsB3hhD0/FqdUOc/I52FWFumHCrp2pxI6anouPOfoo7UcfKB1dhXTK7WH4QUq6j
 JPHcm7zGjCkZR8RRYEj9aLW9RBbuvITrSbxwhf4VvI8kgUkaAOdBfL2MZzDJzxelNdRx
 uFS/9OtPpKzQk95PbmQLTdEONzkBLaW2vF6cN9xcVG9NGymC8TWKOSMaqwh+fZsEOAS8
 PqrsVvW2ivmuLthy/xEFsk9PGqZKC9YYCmwD0EwQLmr7OL6MSLaeuKflWnHxgm0kvM3W
 508bMmir45dI86lACKhwS34wFWlraH414sdpL6UVj0ZkPIb9MU7iw1RUEERtNMD8F1Kr Pg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kc93965xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 21:44:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29OJ2XdJ034042
	for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 21:44:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kc6y9t2ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 21:44:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6e10aHR5V5/tU/m3lMfRhj7LG9GwoqZ18hjdmNAHdJLvTXG69TIRQVrFVktJwgtP9Io+abDqONiiDY3MgyXFxrBr4VtrNk2pYRbR7psRq26nqnbJ0UiftLydMbkAaYCs6fHkS3YBu8UT+8I+piGv51efky/SpekV4j91TuZBoTPO9Vh1Vkit96TM6vX/nvIwHV5bTFhrJfhEnpRQ2IL/zxfSHCwaTwSVX2OWlra868bG8Gv03+vBiY/tVTfSyajhtsa6JyBPuQnSQIARD1CYJSMUel1QmLfSbak4aX9jfL+tx1M+nhVEB7a5O4CmreJ2esqdtqySVzalRAWdzN1ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6apzl3DZgy8wdgM4i1/EG3TnzpJ6yY+YFiphiUbRZbk=;
 b=oFu19fPV8KA2Rj9EYSfrB7G+9rx4PzLOQ62idiseY10Z1aLoRhItK3wxS8E6MsojcpUspU9uTeW/xoFf1K+HlSlribHXXvVca/dsBqGjwFMnZm9VFyQyKdOtOMWxxS11apJtjfmNjTLW89nEeTQpuCDz3Il7xX7UxuGrGEHxHjmRbX0Qac8NaE5lNmXf9bDAqd6vju2AgP/PRzR0qqdd3dfnQS4T8g0FDBe3sy4lvoCpdpmJX7OiEr8uPo0mrw+mZ3HxCCrpX8bBsnNHBvGpqFY19BYHQJTfCk5Q1jrlh0j5Vs0qJi/o0TqPBcLt5mhV6YuIcRSFun3f/F6gdiaXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6apzl3DZgy8wdgM4i1/EG3TnzpJ6yY+YFiphiUbRZbk=;
 b=naRVOCDD8Uz7OGCdzxDXKkVOJwOB+clrt548lPc8nIG10vjzPTPv4XVpBzq8qid+Fm9ikhRR2U+/KAchshjkSH+tg17AcDraTXnhj5ddKjGQeCU1Nx7w6L410zrv14MmM1jIzK3mc3f8vUzMApBJ7DQVAWvIKBRdRx0ivAPi35M=
Received: from BN8PR10MB4083.namprd10.prod.outlook.com (2603:10b6:408:b6::13)
 by DS7PR10MB4910.namprd10.prod.outlook.com (2603:10b6:5:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Mon, 24 Oct
 2022 21:44:47 +0000
Received: from BN8PR10MB4083.namprd10.prod.outlook.com
 ([fe80::25b0:fd83:3a20:665d]) by BN8PR10MB4083.namprd10.prod.outlook.com
 ([fe80::25b0:fd83:3a20:665d%5]) with mapi id 15.20.5746.023; Mon, 24 Oct 2022
 21:44:47 +0000
Message-ID: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
Date: Mon, 24 Oct 2022 17:40:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
To: linux-nvme@lists.infradead.org
Subject: way to unbind a bad nvme device/controller without powering off
 system
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0153.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::8) To BN8PR10MB4083.namprd10.prod.outlook.com
 (2603:10b6:408:b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB4083:EE_|DS7PR10MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c5f67d-ec7f-4ff5-f6eb-08dab608f873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	9z0VDRcEEipyEP+82J5JkU/7g689obV3EyHusa0vVcXmKur19+zAoItDhG6AFOnjsHRlgNOCcdrDwNW9diBnbaC5V6Q5e9R9+Bt0nhAQTTrQ7sTbUySNjuADx/DpeKohNYbFxurY2VAXQvEYfVxy560XpHmNYKK85NArXONfWezKjkoDQcvLhwKWp33qF3EvdoQOrNmorfqAySMJ6HjQi9NiE4LO24HX8zm4X6z4xm1j9Fb9738OPDoNuWfS0DmwDANtpe5Tnl0fJJ6X85nmb5db2O8ReYmLmhB3tT+cyTln335l0fFp2Mr9NRNT1k1TZ0YeVDtk/waW0ceo5rakny22+spRI6PlkGq6CU+rd8676zsjstNOMTytwW8RIFE8dk/+dUXjA0VmG5gAHcTqK4qnl1F5AMiU0kEGapR5iP9i9NilLSGBFViNUbrkjzOaoyVB0OAYVGXeq/3PU+0boPz+SYwJsJoXH3dmRqpbaBB+FaHtMHWKiQGZwk+sLzg1aJwDU0+intEUgEJuldyy84Epey96EwRAbdEackp2NR+QUHymW1MvGrhSSMnhed+JgfjV5t8PW9I9trq4UiYQvZnUQOdXGyzXtQv61nCqMYzzztUUYthWNqjguTsdJQ/HM4l72/filaFUwAJVY/ImPKRkhCvSDMs8XC8y8Z6W3LgkcQSz9m/EVxDAavum8VORGswpi674W6xkqu7hkzWMjQKQonTfCGl41+y0PkZ5tZ9HasGnixPlzKzmetdlDVzmypiUnuFhMI604140MmhHqp3zydCQiMHqhc+AgdMj3r1OgTVjUU8j+yHPj7asQP2P
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB4083.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199015)(86362001)(66476007)(66556008)(66946007)(31696002)(6916009)(8676002)(316002)(5660300002)(8936002)(6512007)(30864003)(36756003)(44832011)(41300700001)(6486002)(26005)(6666004)(38100700002)(6506007)(478600001)(83380400001)(186003)(2616005)(2906002)(31686004)(43043002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?RDZRdTMxKy9UZFFaY1djT09rQzV6SEJMbm9idkYwWnE5a2FhUTVNSEJYaXR2?=
 =?utf-8?B?cktjemc0a0xSZkpUN0QwK0dnbGFObldnWFhiSTk3ZDNLYTd6c0VZZVdEQ3FJ?=
 =?utf-8?B?TEI2cDY2dlovdWhmc0NPbkxXam54WVBGNm12N0pNOUxsblU5SEhVTzg0b0gv?=
 =?utf-8?B?TExGRjJvbzhxdUlzdERWWnQvYXdqaWZNTFNlRkZmYnlwY0VXVHZRK1lSM0FH?=
 =?utf-8?B?SklMcXhPRjJyc1Q0RC8xQWNJTVVLVUZpZXRMYzEyTFZTdUZpeUlYaXU2dzNj?=
 =?utf-8?B?cU5QTk9pZHV4dmQrRkdaRWhldkRNTFpwY29EZGt3YWdFVEhLOW9DWnhqb0JO?=
 =?utf-8?B?ZEwrNWZMME5jc0RHTXdBdXJzTmxDaEh5d0lKV1hvYXo4VEwzTVlZWitxYkNi?=
 =?utf-8?B?OENPR1VZSSs3dWtORkJ3YXc2N2ozM3N6a3h1R2hCRXFPRFhmTnVWVlM2L3JV?=
 =?utf-8?B?VUMwTE5nUDdZUml1Tjl5YlRMYmp5S3lMdUgzREMvTGU3a0pxS2FETGhDZ2h1?=
 =?utf-8?B?YlVwYVVSV3pOV0NhZUNvT2RlWmt2NWtmcE1LbEQyQXJCZHVqZ2VwWGs4VEc4?=
 =?utf-8?B?RGdndUJ2NVkybUlLYm5iRlFaeDZVcmxhcytmRVhZellPT1hXMnc5RTNWZUxu?=
 =?utf-8?B?cXRRQm8xTlMyQ2hYYktRQ24rbnc0bVc0dDRyZ2lrczNPSWpzaVBaYkNpcWNI?=
 =?utf-8?B?L1M2eCtaeUd6U2RiMW4rOURzc0NlMG4wNGlEQ3JaSm5mcy9TQkkzUkFHdEV0?=
 =?utf-8?B?K0xZNXFMczJRc0JkREZ6ZGxJM2loNXBwc0xXbnQrbloxVUx1S3ZyZXd0aFhz?=
 =?utf-8?B?MEhrU01pK0REVXZES0Y3eXVBbnJBL2wySkJBUXZybUpzMUZFWVdrcGJuL0tu?=
 =?utf-8?B?WVBjTWo3aUdGS3IyNkVOc2YzTmVwOWtxRzN5WEhTbzhFV3RsV2RqZjJvemdC?=
 =?utf-8?B?enF5bUdHRGtsSHRBVkx1Wk9TN3NIUGtMSDlnelNjeGRVamVHLzhtNDZVQjJv?=
 =?utf-8?B?d1UrczlRU1dGelYvanJ1SjRhamowNXFjdmVVczIrUUp1L3NjUkVSQ0E0UVU2?=
 =?utf-8?B?UGdxaWJ4M3YxRDYxdk85eUsrT2tyZmw4YkprNVlIQ2hFNFNSMHlZcGRtZ2FU?=
 =?utf-8?B?UmJ3a3lldldiYW1PKy9uYzYwRWREeUhrOHo0SGU3RENHRXljRVRQOGNQTVBQ?=
 =?utf-8?B?a0N2QzRuc051VUliczlBMVovY1Y0eElpOUVmWUxhekhMYmMrQy9vTXV5ME56?=
 =?utf-8?B?dVNtQUppazJsVi9oY0xOTXhaMGIrdXpaYlhhK1hmUzRJaXhTd0ZHR3ZjKy9i?=
 =?utf-8?B?cm4raUQ4Nk5sUjd2UGxHNWcrdEdsS09Ka3NqTkJRZ040ckpmSXNNVE5OUDhU?=
 =?utf-8?B?cC9oRXR1UFh0UXZWOFdBK0x2QXVScmtCU1RJRVFqdFdHaENvYnozL3J2Z201?=
 =?utf-8?B?eVNRcGRTWGx0VXNwbGhLekpHeEphZTNRZHdVQUViYTg0cHJTazlkZXZyZk1i?=
 =?utf-8?B?c0d3MXUxYzU2d2NjdlVzZ0g5T1hTQk5DSnB4SlpWWHpNMnhFUjFydTZ6VnY3?=
 =?utf-8?B?QWxjeGZvMUVRNlBZWGZiVVVuV01LMVlRNDBjN0R6NmV2NHMzaFgxM1BqZTFw?=
 =?utf-8?B?dWNmbUh3a21qc3dlZm9raVdVQ0tLM3ROc0FhcHV2R3dDZGp4c24yOWxLRzd1?=
 =?utf-8?B?MTdxSXA2c3V5ZkIvRVFjVE1tL3d3YjVmVDUzMUNvVVVSMVBXRVhVUEVqTDRm?=
 =?utf-8?B?LzBjSVVUVDh6TjJEd3RXZHdHUWYyZHdXZ1J1MUc5RlJGd21ibjg0NDZ5Vzg3?=
 =?utf-8?B?S1ZoWUlYaCtGdmtINndzZ0xZdXAxKzljUmJ0Y3gvdnVlbkh2VXNYRFVtYytI?=
 =?utf-8?B?aUxyZEVsWGFNWEl3Qjg2bnkveHVLQXVMUnY0ZFJ5RnhZalEwRDFhdTNxR0hI?=
 =?utf-8?B?cU0rOHpBWkFTek82R2dacTJxRmZPejNTbHdFci9wQTVwTmNyODlCamVLREV0?=
 =?utf-8?B?YnNHMjhPVDB2UFpKcGVSdi9PbFpqR0o2N3hscSt5V1Z5L25jL2Ezbm1XbWNV?=
 =?utf-8?B?N1hIbk1GSHQvUHpySkF6TFMyRmZHR25YMktRTk5kdmV0Uy9vSXVNY1dqNnBR?=
 =?utf-8?B?NWxrbm9qaElyMjU2MzA2dlBzU2lRelJ5bkY3c3lNbmh1bzlHclNvUnZtK2tk?=
 =?utf-8?Q?hDNUwqC185tRW3NDvA15V3o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c5f67d-ec7f-4ff5-f6eb-08dab608f873
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB4083.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 21:44:47.2720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flvIM677yktS0H4OmXr3EZag90q2GSnDv/09l5RNtDUBiSzd+NhkYdpblr8KtEvaZEcZkb/aZZYZcJIvWvlyFjcpRBWMz99o/kzP620oD7ROhS37dWUnRRjNiV8hEhM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_07,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210240130
X-Proofpoint-GUID: KVwUSkHnkBDiC0aaWLqeGFxVXauABS3A
X-Proofpoint-ORIG-GUID: KVwUSkHnkBDiC0aaWLqeGFxVXauABS3A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_144455_800641_B66A1CEA 
X-CRM114-Status: GOOD (  16.92  )
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

Hi -

I'm seeing a scenario where what seems to be a non-functioning nvme controller/drive where the IO transactions are timing out and the controller is not responding to any controller commands. The controller seems to be disabled (nvme_dev_disable called via the nvme_timeout) but we're still seeing the nvme_reset_work thread  blocked and not making progress. I tried to remove the controller via the HP sysfs interface and that also hangs behind the reset thread waiting for it to complete. 

I thought the the disable controller path does not talk to the controller and simply unblocks the queues and cleans them out before unbinding the controller from the device. Not sure why the reset thread is still stuck then? Does the reset thread have to finish its course even though the controller has been disabled? trying to understand the flow here.

I guess what I'm really looking for is a way to simply unbind the device from the driver, kill any threads and allow the device to be powered of via the hotplug interface (trying to avoid rebooting the system to remove the device).

thanks,
James


systemd[1]:info: Removed slice User Slice of root.
kernel:warning: [10416583.556274] nvme nvme3: I/O 527 QID 1 timeout, aborting
kernel:warning: [10416583.556287] nvme nvme3: I/O 603 QID 1 timeout, aborting
kernel:warning: [10416583.556291] nvme nvme3: I/O 607 QID 1 timeout, aborting
kernel:warning: [10416583.556301] nvme nvme3: I/O 765 QID 1 timeout, aborting
kernel:warning: [10416583.556274] nvme nvme3: I/O 527 QID 1 timeout, aborting
kernel:warning: [10416583.556287] nvme nvme3: I/O 603 QID 1 timeout, aborting
kernel:warning: [10416583.556291] nvme nvme3: I/O 607 QID 1 timeout, aborting
kernel:warning: [10416583.556301] nvme nvme3: I/O 765 QID 1 timeout, aborting
kernel:warning: [10416583.557700] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557705] nvme nvme3: I/O 894 QID 22 timeout, aborting
kernel:warning: [10416583.557711] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557700] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557705] nvme nvme3: I/O 894 QID 22 timeout, aborting
kernel:warning: [10416583.557711] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557713] nvme nvme3: I/O 897 QID 22 timeout, aborting
kernel:warning: [10416583.557714] nvme nvme3: Abort status: 0x0
....
....
kernel:warning: [10416594.580023] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588219] nvme nvme3: I/O 191 QID 1 timeout, aborting
kernel:warning: [10416595.588228] nvme nvme3: I/O 192 QID 1 timeout, aborting
kernel:warning: [10416595.588233] nvme nvme3: I/O 195 QID 1 timeout, aborting
kernel:warning: [10416595.588237] nvme nvme3: I/O 196 QID 1 timeout, aborting
kernel:warning: [10416595.588244] nvme nvme3: I/O 209 QID 1 timeout, reset controller
kernel:warning: [10416595.588402] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588219] nvme nvme3: I/O 191 QID 1 timeout, aborting
kernel:warning: [10416595.588228] nvme nvme3: I/O 192 QID 1 timeout, aborting
kernel:warning: [10416595.588233] nvme nvme3: I/O 195 QID 1 timeout, aborting
kernel:warning: [10416595.588237] nvme nvme3: I/O 196 QID 1 timeout, aborting
kernel:warning: [10416595.588244] nvme nvme3: I/O 209 QID 1 timeout, reset controller
kernel:warning: [10416595.588402] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588449] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588449] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588513] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588561] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588513] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588561] nvme nvme3: Abort status: 0x0
kernel:info: [10416598.164310] nvme nvme3: Shutdown timeout set to 10 seconds
kernel:info: [10416598.164310] nvme nvme3: Shutdown timeout set to 10 seconds
systemd[1]:info: Removed slice User Slice of root.
kernel:warning: [10416583.556274] nvme nvme3: I/O 527 QID 1 timeout, aborting
kernel:warning: [10416583.556287] nvme nvme3: I/O 603 QID 1 timeout, aborting
kernel:warning: [10416583.556291] nvme nvme3: I/O 607 QID 1 timeout, aborting
kernel:warning: [10416583.556301] nvme nvme3: I/O 765 QID 1 timeout, aborting
kernel:warning: [10416583.556274] nvme nvme3: I/O 527 QID 1 timeout, aborting
kernel:warning: [10416583.556287] nvme nvme3: I/O 603 QID 1 timeout, aborting
kernel:warning: [10416583.556291] nvme nvme3: I/O 607 QID 1 timeout, aborting
kernel:warning: [10416583.556301] nvme nvme3: I/O 765 QID 1 timeout, aborting
kernel:warning: [10416583.557700] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557705] nvme nvme3: I/O 894 QID 22 timeout, aborting
kernel:warning: [10416583.557711] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557700] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557705] nvme nvme3: I/O 894 QID 22 timeout, aborting
kernel:warning: [10416583.557711] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557713] nvme nvme3: I/O 897 QID 22 timeout, aborting
kernel:warning: [10416583.557714] nvme nvme3: Abort status: 0x0
....
....
kernel:warning: [10416594.580023] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588219] nvme nvme3: I/O 191 QID 1 timeout, aborting
kernel:warning: [10416595.588228] nvme nvme3: I/O 192 QID 1 timeout, aborting
kernel:warning: [10416595.588233] nvme nvme3: I/O 195 QID 1 timeout, aborting
kernel:warning: [10416595.588237] nvme nvme3: I/O 196 QID 1 timeout, aborting
kernel:warning: [10416595.588244] nvme nvme3: I/O 209 QID 1 timeout, reset controller
kernel:warning: [10416595.588402] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588219] nvme nvme3: I/O 191 QID 1 timeout, aborting
kernel:warning: [10416595.588228] nvme nvme3: I/O 192 QID 1 timeout, aborting
kernel:warning: [10416595.588233] nvme nvme3: I/O 195 QID 1 timeout, aborting
kernel:warning: [10416595.588237] nvme nvme3: I/O 196 QID 1 timeout, aborting
kernel:warning: [10416595.588244] nvme nvme3: I/O 209 QID 1 timeout, reset controller
kernel:warning: [10416595.588402] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588449] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588449] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588513] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588561] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588513] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588561] nvme nvme3: Abort status: 0x0
kernel:info: [10416598.164310] nvme nvme3: Shutdown timeout set to 10 seconds
kernel:info: [10416598.164310] nvme nvme3: Shutdown timeout set to 10 seconds
systemd[1]:info: Removed slice User Slice of root.
kernel:warning: [10416583.556274] nvme nvme3: I/O 527 QID 1 timeout, aborting
kernel:warning: [10416583.556287] nvme nvme3: I/O 603 QID 1 timeout, aborting
kernel:warning: [10416583.556291] nvme nvme3: I/O 607 QID 1 timeout, aborting
kernel:warning: [10416583.556301] nvme nvme3: I/O 765 QID 1 timeout, aborting
kernel:warning: [10416583.556274] nvme nvme3: I/O 527 QID 1 timeout, aborting
kernel:warning: [10416583.556287] nvme nvme3: I/O 603 QID 1 timeout, aborting
kernel:warning: [10416583.556291] nvme nvme3: I/O 607 QID 1 timeout, aborting
kernel:warning: [10416583.556301] nvme nvme3: I/O 765 QID 1 timeout, aborting
kernel:warning: [10416583.557700] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557705] nvme nvme3: I/O 894 QID 22 timeout, aborting
kernel:warning: [10416583.557711] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557700] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557705] nvme nvme3: I/O 894 QID 22 timeout, aborting
kernel:warning: [10416583.557711] nvme nvme3: Abort status: 0x0
kernel:warning: [10416583.557713] nvme nvme3: I/O 897 QID 22 timeout, aborting
kernel:warning: [10416583.557714] nvme nvme3: Abort status: 0x0
....
....
kernel:warning: [10416594.580023] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588219] nvme nvme3: I/O 191 QID 1 timeout, aborting
kernel:warning: [10416595.588228] nvme nvme3: I/O 192 QID 1 timeout, aborting
kernel:warning: [10416595.588233] nvme nvme3: I/O 195 QID 1 timeout, aborting
kernel:warning: [10416595.588237] nvme nvme3: I/O 196 QID 1 timeout, aborting
kernel:warning: [10416595.588244] nvme nvme3: I/O 209 QID 1 timeout, reset controller
kernel:warning: [10416595.588402] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588219] nvme nvme3: I/O 191 QID 1 timeout, aborting
kernel:warning: [10416595.588228] nvme nvme3: I/O 192 QID 1 timeout, aborting
kernel:warning: [10416595.588233] nvme nvme3: I/O 195 QID 1 timeout, aborting
kernel:warning: [10416595.588237] nvme nvme3: I/O 196 QID 1 timeout, aborting
kernel:warning: [10416595.588244] nvme nvme3: I/O 209 QID 1 timeout, reset controller
kernel:warning: [10416595.588402] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588449] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588449] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588513] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588561] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588513] nvme nvme3: Abort status: 0x0
kernel:warning: [10416595.588561] nvme nvme3: Abort status: 0x0
kernel:info: [10416598.164310] nvme nvme3: Shutdown timeout set to 10 seconds
kernel:info: [10416598.164310] nvme nvme3: Shutdown timeout set to 10 seconds
kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller
kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller
...
...
kernel:info: [10419813.132341] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
kernel:warning: [10419813.132342] Call Trace:
kernel:warning: [10419813.132345]  __schedule+0x2bc/0x89b
kernel:warning: [10419813.132348]  schedule+0x36/0x7c
kernel:warning: [10419813.132351]  blk_mq_freeze_queue_wait+0x4b/0xaa
kernel:warning: [10419813.132353]  ? remove_wait_queue+0x60/0x60
kernel:warning: [10419813.132359]  nvme_wait_freeze+0x33/0x50 [nvme_core]
kernel:warning: [10419813.132362]  nvme_reset_work+0x802/0xd84 [nvme]
kernel:warning: [10419813.132364]  ? __switch_to_asm+0x40/0x62
kernel:warning: [10419813.132365]  ? __switch_to_asm+0x34/0x62
kernel:warning: [10419813.132367]  ? __switch_to+0x9b/0x505
kernel:warning: [10419813.132368]  ? __switch_to_asm+0x40/0x62
kernel:warning: [10419813.132370]  ? __switch_to_asm+0x40/0x62
kernel:warning: [10419813.132372]  process_one_work+0x169/0x399
kernel:warning: [10419813.132374]  worker_thread+0x4d/0x3e5
kernel:warning: [10419813.132377]  kthread+0x105/0x138
kernel:warning: [10419813.132379]  ? rescuer_thread+0x380/0x375
kernel:warning: [10419813.132380]  ? kthread_bind+0x20/0x15
kernel:warning: [10419813.132382]  ret_from_fork+0x24/0x49
...
...
kernel:warning: [10419813.158116]  __schedule+0x2bc/0x89b
kernel:warning: [10419813.158119]  schedule+0x36/0x7c
kernel:warning: [10419813.158122]  schedule_timeout+0x1f6/0x31f
kernel:warning: [10419813.158124]  ? sched_clock_cpu+0x11/0xa5
kernel:warning: [10419813.158126]  ? try_to_wake_up+0x59/0x505
kernel:warning: [10419813.158130]  wait_for_completion+0x12b/0x18a
kernel:warning: [10419813.158132]  ? wake_up_q+0x80/0x73
kernel:warning: [10419813.158134]  flush_work+0x122/0x1a7
kernel:warning: [10419813.158137]  ? wake_up_worker+0x30/0x2b
kernel:warning: [10419813.158141]  nvme_remove+0x71/0x100 [nvme]
kernel:warning: [10419813.158146]  pci_device_remove+0x3e/0xb6
kernel:warning: [10419813.158149]  device_release_driver_internal+0x134/0x1eb
kernel:warning: [10419813.158151]  device_release_driver+0x12/0x14
kernel:warning: [10419813.158155]  pci_stop_bus_device+0x7c/0x96
kernel:warning: [10419813.158158]  pci_stop_bus_device+0x39/0x96
kernel:warning: [10419813.158164]  pci_stop_and_remove_bus_device+0x12/0x1d
kernel:warning: [10419813.158167]  pciehp_unconfigure_device+0x7a/0x1d7
kernel:warning: [10419813.158169]  pciehp_disable_slot+0x52/0xca
kernel:warning: [10419813.158171]  pciehp_sysfs_disable_slot+0x67/0x112
kernel:warning: [10419813.158174]  disable_slot+0x12/0x14
kernel:warning: [10419813.158175]  power_write_file+0x6e/0xf8
kernel:warning: [10419813.158179]  pci_slot_attr_store+0x24/0x2e
kernel:warning: [10419813.158180]  sysfs_kf_write+0x3f/0x46
kernel:warning: [10419813.158182]  kernfs_fop_write+0x124/0x1a3
kernel:warning: [10419813.158184]  __vfs_write+0x3a/0x16d
kernel:warning: [10419813.158187]  ? audit_filter_syscall+0x33/0xce
kernel:warning: [10419813.158189]  vfs_write+0xb2/0x1a1
...
...
kernel:warning: [10419813.158507] Call Trace:
kernel:warning: [10419813.158513]  __schedule+0x2bc/0x89b
kernel:warning: [10419813.158521]  schedule+0x36/0x7c
kernel:warning: [10419813.158527]  schedule_timeout+0x189/0x31f
kernel:warning: [10419813.158533]  ? __next_timer_interrupt+0xe0/0xd4
kernel:warning: [10419813.158539]  ? blk_rq_append_bio+0x96/0xa3
kernel:warning: [10419813.158544]  ? __blk_mq_insert_request+0x76/0x104
kernel:warning: [10419813.158549]  io_schedule_timeout+0x1e/0x43
kernel:warning: [10419813.158554]  wait_for_completion_io_timeout+0x13b/0x19d
kernel:warning: [10419813.158562]  ? wake_up_q+0x80/0x73
kernel:warning: [10419813.158568]  blk_execute_rq+0x6e/0x9a
kernel:warning: [10419813.158577]  nvme_submit_user_cmd+0xc4/0x320 [nvme_core]
kernel:warning: [10419813.158583]  nvme_user_cmd+0x21d/0x3c0 [nvme_core]
kernel:warning: [10419813.158591]  nvme_ioctl+0x175/0x220 [nvme_core]
kernel:warning: [10419813.158598]  blkdev_ioctl+0x878/0x912
kernel:warning: [10419813.158605]  block_ioctl+0x41/0x45
kernel:warning: [10419813.158611]  do_vfs_ioctl+0xaa/0x602
kernel:warning: [10419813.158616]  ? __audit_syscall_entry+0xac/0xef
kernel:warning: [10419813.158621]  ? syscall_trace_enter+0x1ce/0x2b8
kernel:warning: [10419813.158627]  SyS_ioctl+0x79/0x84

