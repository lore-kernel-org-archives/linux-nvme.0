Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4940C76196
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Apr 2023 22:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UmnydO3+Nv64eVgY6jlK3V4ym2QCqDGm/bN9PqXHIk=; b=boCvwgRBS1EoOGtMLEI5J6h0Mp
	X/8BEIioQYofEju3EanHjVx3tzcU71Hi0IX0JnetfzmVinfQhYoEx3i6mESaulSEXBXvPMp1zWj8N
	6dMkgdQP5pTuyVugymcJQm8SW83265idZJTVMqF0X/FSVhPm4baUMKaCeG6vgXQfXYY8Rf2RSCs3T
	QDmxqhTp73kerwBcqt//+QGDPTovC35c7YSX2OSpwcvsMxBWM6FCdz7VXBg18GuVFG0OGYnH6Widm
	plH976NoS9Jqb+FWkUdCoFRbu39V1I4/IcuJneUDdNAqqsLFsL8jKzPz4eIueUFf0OYZjtsLxEmVa
	JsR0E1/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjT4u-00H86m-0j;
	Mon, 03 Apr 2023 22:55:08 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjT4r-00H85c-0f
	for linux-nvme@lists.infradead.org;
	Mon, 03 Apr 2023 22:55:06 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333JaS4l028432;
	Mon, 3 Apr 2023 22:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4UmnydO3+Nv64eVgY6jlK3V4ym2QCqDGm/bN9PqXHIk=;
 b=yXcMtpeRMgYGnNE3i+MR/KnAoLjcgAvXYYS7sSvACSFGVcnadmyujq1f3ZRtNemp9oEi
 5sRrV/B9HPuTQeFa6LKAb9AthPdfIOXFqP/TOCWHFQd7+4lAeXIN53CI1mZYBXMJsCFY
 eEgALnsPwxsTXBcTomzV2AnxF3aPXaz6FGTXtRXedT/j7G3e2Do0/qRTbcGj8O0C+Z0F
 Ajy/7joVR337kMEMhVQ+7qj+KDIWnvQxYTpVzDPL71Sfsoj+pulQ7jftf5s5lnfVRyr2
 UNHmpOkXx+/T8PehnhJTkPRJYmijn+ljVwJbkYGJfJ+MRXBq78Z4ZHfuA+ptbdwcmOll fQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgamdew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Apr 2023 22:54:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 333MrTjh028862;
	Mon, 3 Apr 2023 22:54:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt25gbr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Apr 2023 22:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMQZntTJlv8C1sm3/6CpjPUpV4ca/50NaeRrGzbtCpdVQrNxFqPADxrDfZe3GuYgn1H4LKARiR9qI5sCDvoTsqlIHfdUQ0eNoci6cXCV+qgT8H1rHjoAaeTowb20nkO2vPkSHs0Z7rr28RWITigkEwcn0pwT1HMOzvMwAPuIhowf2x4glN0joQj7GduqQKGseYWKVpBm14qm+9EnjEFQfesOSWQUzSJy+9VIoGQhuFxKr9Kc4xKlw3Kwhk7jci+/oCFRsr63Lgj09luVK8B5SR5Y8MBXNEtHEWhTtonAy8Hy27blfNDM+xjj/w0n6iqUNDmRb4YCAvvhVwNF1/+YPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UmnydO3+Nv64eVgY6jlK3V4ym2QCqDGm/bN9PqXHIk=;
 b=NWTrE26TwfWWXtq5YqAuR9vX3MFKq+M9dOKkt65QsXatdgIgqIlQgvstnvCATEZhUljwkOy8gyl514+sWI2nzSZgfmCWB6SyxbVN+shcXKtzBvrw9USLBK2enyhNP3lRp/7SeJG7vHPaStktPNw58V9tgJJvD+dHMC+M3rykjjy33jdHOFz0rxwaY16oIU4CRNXxdKI6t1uT8B9884OPCgX8EAoU/sSOBkZ6HOGefvbQyryX/od3EuEJqMETKjy4//UcYGlgFnfAaJdLstCUZigt3+jAKSG8Nu5CXLL3a8cgGdB107m538YNgai6ey4vRKv8nmpJLGBrjOwH6T2IJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UmnydO3+Nv64eVgY6jlK3V4ym2QCqDGm/bN9PqXHIk=;
 b=Igx/lufJgGIPAb7dlouhTr117+vpNXI1JjfbPlSt9Tt8vPpew5eEjUedHRnNdUozyEd+mjCHgDbhnPyk5/AAGsHrQc++/fnPDpFqG9yBYVskJtZiGMKrHWhA96MIZgZGbZCTsR0vDANQNb4fuutlWNtHv+RnvwT4mWuACcWZd8w=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by IA1PR10MB6709.namprd10.prod.outlook.com (2603:10b6:208:41a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 22:54:55 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 22:54:55 +0000
Message-ID: <935faecc-e000-3d7a-71ed-7517b1f4c299@oracle.com>
Date: Mon, 3 Apr 2023 15:54:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [RFC v3 1/1] nvme: add passthrough error logging opt-in
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de
References: <20230331221823.2806192-1-alan.adamson@oracle.com>
 <20230331221823.2806192-2-alan.adamson@oracle.com>
 <40dba1f3-8307-ca1a-ad6f-c80df87e0344@grimberg.me>
 <ca72677d-932d-29f6-5260-0b0d05fd6584@oracle.com>
 <132431e1-6c77-4e4d-1d48-fbb0bd4dc5b6@grimberg.me>
From: alan.adamson@oracle.com
In-Reply-To: <132431e1-6c77-4e4d-1d48-fbb0bd4dc5b6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0020.namprd05.prod.outlook.com
 (2603:10b6:803:40::33) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|IA1PR10MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: c2aa68c2-1459-46b7-6d29-08db3496713d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	7mAW18ps57yxat7jV4J3Sux2B7n5vwiZeSvJrp7qk6I8m4sPdlc34UxaCH5l2Qlig7oCX2w4h+FN8wwf7wGFPfQZL7h8/xp0MOVe7CnQOIvw589gaMCw5uRNaroKTod35CXEpr7FJbM1uf/UxN9BqpEg64hqTKseZctAgbjfssW3dbw024+2/LobT1MXWlnIsM4AmzROf7i9mWImOfASdCXW1VVN4kHAMzwjCBmTkUrS7WvElzMtt/jg/qfpo3dQytNMwW6rSdRQw2MA3sz9/bRRuEAp9oPEVhUVpWVBzQkSS6dMGHSmoKyGCVZwgY5JUGN62fdFcDWXn/8FrCavuvhzrJ21ndllIw2s+xtgz8MjwM7bB0K1mYWpIWYPjuvyl898ZJexDuGom5IYwZFBEM5OC2Mi9knGW9MA/OGZ3Td5AJtJ9Mr5rW66C95mfVpdGqR0MJphj1nW6vSSVV5C+mvGyKR3Gd5l2CUbfNmhwZV1LVZaF1mluenNRbbvyQy1KSJvaXt+RSxEXGElzfkiGGmanrUpJqie0tA4pLQcQ2bVYMZ541eiOk9AHo+5vcAjwmqQBr4hla84uc+kj8DxjBHGkSaeCdlKhHxLISTof7+q2RDmdweYBeAgRcAfFVzk
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(41300700001)(38100700002)(8676002)(66476007)(66556008)(66946007)(5660300002)(8936002)(316002)(31686004)(4326008)(478600001)(2906002)(31696002)(4744005)(83380400001)(86362001)(186003)(6666004)(2616005)(36756003)(53546011)(6486002)(6512007)(6506007)(26005)(9686003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?RkdlWFVIVnJGQnRMNDd6ZVFRNXJ3d3A3MGFtTDJRY0ZoYkZnaDk0R3Fjc1FV?=
 =?utf-8?B?MXVpSmZCWGh0TFJoaGpLNWNzZGVKU0JyYVNvaVgwRTYvVVlxQ3p6VGplMWFv?=
 =?utf-8?B?eU5NUk1Ma2ZTelI2NlRPcHYzMTVleUhXTWRSL0ZEU0pLaVVpdXFNOCtuZzdP?=
 =?utf-8?B?OGZvY1dJRDNTYzgvMW1DWlhnd2dZKzZqeWpueDZ0ei9OTXZOK0VFV3FHN2Vr?=
 =?utf-8?B?ZGlTa0N1c3liZFBlNnV2dEF5T29henJZTlo3ZlhLcXZlck5NSXNnemlhcXVM?=
 =?utf-8?B?d2IwZTJjY2JYSlVBZDhvbVBRRS9GS0VLRDJWc2FsL0Z0Q204WlQ3UHQ2RHVq?=
 =?utf-8?B?Zmp1VkxTTEd3Nm9sWEFTVCtQNnIxSmZmQW5rSGZ4aHNweEpGbFlRcTdRYkkv?=
 =?utf-8?B?RFM3UlFqWjd5RzUrMW42Q3prNE5XRzh2NGd6OWM4Ti9Sa3dvVUZnTksvK2Np?=
 =?utf-8?B?SEQ0R0cwcHBVQVo0UzlkSWthZ003Tjd3UXVjcmp4VHlNaHduY2hPd2hQQlNv?=
 =?utf-8?B?bmFQRk5weFBJRk41MElVUkFQekJTQklPYklzZlAvMC9WclRJSVNiTEhmYmdV?=
 =?utf-8?B?ZFFtMDVyYzRrSG44NG01RmZPaVBVQXhtUGNOcHRLMWdGNm5pRkZVdTNwZEVG?=
 =?utf-8?B?RWczYXVXQnZjVGFabHNKb0JhZG9HZ3Z2RG5Fbm11SFdISEIvWW1OMk51eW9n?=
 =?utf-8?B?UHM4WnlGQms1Vk1EQUNDZ1VFMlBvYitjcGVTWTZoeld0N2hmcTk3azlpd2hJ?=
 =?utf-8?B?MnFpT0YrTVdkdW9RWW1TNm1telJqY0UrakFUWkR1MFlCbU9Ua3EvQkdxeHVH?=
 =?utf-8?B?a0pVS2RObEZNeEprb1c2aTF3Z29BVis0c2g4OEJBVTBEajJnM2Ywa0lvZUlT?=
 =?utf-8?B?TDNrZm44Y2dBdDVJdGpvRk9INjlCREoyN3FvdjdLYlRNZE9yRGRQTEYxekNO?=
 =?utf-8?B?MWpic3VzR0hJQjVBTHdOME14WERReVFiOHl2VnlnRXQramRkcXBtTEF3ZGlo?=
 =?utf-8?B?VnZlMXcyRHQ5a3ZNS0wxS2hTeXE2RXd6OEl6NWUzalBkT2xRMFgzUzA4Y2p2?=
 =?utf-8?B?cEhldFIzMXhkbkM0MS9KYXEvK24wajF2cGN1MFJ1dmR1QW8zR0dlK0ttQys2?=
 =?utf-8?B?ME1GKzJ2RFVXQWpVdTMxZUdva3NzUVIzYTB6WHJydDlxTWpEWUcrWVRIdC80?=
 =?utf-8?B?eGVxekpaUG85YjJDZFV2K2NVajBDZGNMU3NabnAxTXNyOUZoKzhwREQ5aEhj?=
 =?utf-8?B?bU45TzZtTkVqL3czTE0wOWdURi93Q1dKdTVTblFnS0NKWThCOUg4ZGkvWGdq?=
 =?utf-8?B?Y1IwMVkwMXNOUmZhQzBhU01acmpjcW5leHcxZnROTG5acDhoYXdWc1U1SlFz?=
 =?utf-8?B?bUc5L1NlekJId21aZis0aVZQamdqdDJpQURSblAwQ3hoL3ByMG9icG5jenBm?=
 =?utf-8?B?TlFQUFd0OXdNUERTWFdYTmFaM0hCaGs3TUhIV3FkQitQemM2d3Y3UnZBWWVR?=
 =?utf-8?B?ZnlITDdrakh3R2JvYkQ1Zjk1d0pkSlNjVmZENjNXSDhnbjFqQTl5QndZOVpO?=
 =?utf-8?B?UTRzNWttd1JCM1FFdlZ6RlVwNnNRd2ZQaHNQbUVSR3JqNXFFZlhVdjNnQU5X?=
 =?utf-8?B?aWwxNlpqRU85cmhVWFZDcHQwOExlQUpaN0J4TGlVZWw4b05iempoMk1VVXRG?=
 =?utf-8?B?TytCeS9XZEsrTkZ0NnJJbVIxbTRmZmJBczhpR0ZHSFpNOWp5bGFMSndDNkJ0?=
 =?utf-8?B?VHN6QVNnNWo3SEtRMTNiUHVtVFBWdnBObzV5bFZpaU05MHVQNWNHb1hRSk1U?=
 =?utf-8?B?VDRZc0d3elJxR1FWdmlxeGJrTHBDZTQ5dlZQRHlQc2lLK1hxRC8rL3l1K0sw?=
 =?utf-8?B?Zm4wRnoybVpSMkwraTdFZlZIV09xK1RUNWRkTGdYZTVDMlh0OXNmd29kWXFB?=
 =?utf-8?B?WG41TXFNRmJQZkNWand6Ymk1YThLbzc4Ry9OZGVoNHZGS3cwbTQ2SGhERzV2?=
 =?utf-8?B?YnMrZXJ4YTRDdnUycmNKYmdxbFgwOXBlU2N0ZlhhRytOVjZ6NXBBaWM5WnRw?=
 =?utf-8?B?M0Q0bTlDM0VVOFVFeVhhUWVmZDdmZHdiWDI3RWxFUDBTVjQ0UkVVZy9xNElZ?=
 =?utf-8?Q?BVtNraB7qRzkRxAeUgqz9TiOc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	mzTvgRHIVjakgpqkTdNsn2A5QItaLZHIeNVkhvnsuvABU/TJF+4CyK06jGRLeD7miFXPYcTZPPwJtMuLBpRffVOwo1fwdR/k12KddHUlxF5UM00BIN/KKPEYgMiR9vkBwh/+pYnDBlKUhR2YHXBZ4pXeT+0sdYtAcm4xKwdITeRjFJjMRyrrBWBbxURam8cSZs9BblC7eKGiv4tSeIvSN60PqG3Ch+6UFhDuViBHztyjrfJB7P9Hw2kyWSkLtJiZuEXjAUD9k8v21E7GXM9FS51+wAfnKD7fXkEb14gMAGPTahuGwP1kGFNZHgXCXYvbtORP5dIfJ4AUvgF8JN3N5gjbAg6+fPDge06stoGqSagfEuHbHUN/BXIJkiqykulGdLNPUrSR14rU793Jrqaqr8R0SacTzoOt4c3NX0h6B8I5BRMSW3IiKucnoMaxSlv9I6nuRyGexGIeDMc0RqMjFlv8drlZICy0kL8U98dPM78zMXUMNs6CXkrKR01MO3Sbg2fX5cf+I6WNmWCuRfWZT/ZG4ThdLBKJT/dv4udmjQOgBwqIk607pybmGLpT2AxQqzOt3IYzVdTzUUzU2Oeclf0vCJceupzZG+jA++VSvvVncxcAFmQanBrqtjY5MAsUOaj3bgi5phv1bvCi98ANnwhXsvCws3dLFqN2SgWDJEQ4wC4WTsI+C4E05QWDD9CQ3ou88qNESnnxpE6L4j1TLBYMxegxpbx9F30nLBCME47FXntXH1mHzm84+HB91QepyrQxpwZElNFqO+JZ68uFeozMu8RPq06T+cinfQYefXzUGV6P0so74h1kQbsnsqDNlWo285JTaPeWbgXXl6mFJjKtru/+ccSVSRr5lZeb2uk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2aa68c2-1459-46b7-6d29-08db3496713d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 22:54:55.3733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXS9gP9Gzsb20hfwOd7lTVvhBSTrqnpGHdLHIvADQpqNSaC7jOwinNIZFL1MdbUx9DuNSxO8DAi7K/wi5oy9ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_17,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=970 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030181
X-Proofpoint-GUID: rgDBrURvp51Zv57njdGQe-Z71yT3R7Zp
X-Proofpoint-ORIG-GUID: rgDBrURvp51Zv57njdGQe-Z71yT3R7Zp
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230403_155505_510850_23716937 
X-CRM114-Status: GOOD (  14.57  )
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


On 4/3/23 3:38 PM, Sagi Grimberg wrote:
>
>>>> +    if (!nr->ctrl->error_logging)
>>>> +        req->rq_flags |= RQF_QUIET;
>>>> +
>>>> +    memcpy(nr->cmd, cmd, sizeof(*cmd));
>>>
>>> Question, if we already introduce granularity to this setting, why
>>> not per-ns? why only per controller? I'd think it makes more
>>> sense to do this per ns. Will also remove access to ctrl in the hot
>>> path...
>>
>>
>> Meaning we should have both:
>>
>> /sys/class/nvme/nvme0/passthrough_logging
>>
>> /sys/class/nvme/nvme0/nvme0n1/passthrough_logging
>
> No, just the namespace logging, why would we need the
> controller as well?

For Admin Commands?

Alan



