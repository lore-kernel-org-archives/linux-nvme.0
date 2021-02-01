Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C2AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:54:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EA064DD9
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 17:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EA064DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l6n1F4Wo5Lznh4M6XH6pkcMipc3ppgOPxHcddUzdgFQ=; b=F6aToUcqHs7XLSyWgTY44x4+ua
	vx+k6iNmQKhmm0zmadChTXmVMFKEINkRB7fHpFqBhIrT9KEkEd80YHsmAcrWfdmtf31Q/8njlZfxf
	6MurbKU5SR8HwLYxm8gIVdsVvGo9N+VV8Q2ff71bHZHXD43PeVrYRFYUKZNyGXV1mP/z5nJUffoSj
	kHPfeLjiDHn36VRHBp9pk8hUundAsCgcaOm+jTLwnDx+hF//hSNl9nPwJQCHiIPNYX6RtvcLOv29/
	EGnRi27lr5HxGA61ntjoa7SRmbS576J88TXSptrKByuQq+wfyakTCRr3sPCIUkB+HmSoOLinxBEYO
	OkSICn4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6dOf-00011n-8X; Mon, 01 Feb 2021 17:53:57 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6dOb-00010h-Rs
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 17:53:55 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 111HrWld019606
 for <linux-nvme@lists.infradead.org>; Mon, 1 Feb 2021 12:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=BvW4GG+twj/SqyMEB+YBdHW9lPzxprimXXK0tfcfpEo=;
 b=vCNikesryPTPOkczclYfZ4z39bWUWzR/zfAyOxV7/BXFil6gSdaMTHvtYZ+0Grp1IbWy
 Nq1FdWkAja9ZvUUMp7h/xwFKkKrENSbJlHX0sDNprG4Xi16iUDsvV7wasBGnNzGd/TCu
 XjXVSmdBRrvw0UcQBAMu7n8DCLrSrqHEakPNlz27ZtYDUkW2kd8FqHoAVtMIz++SB9OE
 jamEm41tRHg4EWHbMZGdb0W5+72DtHRU9o6USSN8MDSI454ZZvVfxuBB9KxW837Y8kIf
 aRgXZMnKxCpAfxXW6d8nheBgiyxIAfkpDFIAmqb4BOp4vU/XyV0r9bWwdgq9LcvtHyPv uA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 36d3npwfhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 12:53:51 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 111Hos6G124599
 for <linux-nvme@lists.infradead.org>; Mon, 1 Feb 2021 12:53:50 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
 by mx0b-00154901.pphosted.com with ESMTP id 36dnu12td5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 12:53:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4bahveRGT8PxXNPShQGIsixmEWKiPwPUFx3ov8Y8ZkSG5z7BDCBlQyMCVWrLHpJfYbOG0Zx27cmQuBPwQSbcrQsaJkWPaxHe6I5/xvOhyRRs/UGV8swjp0rqUscjE3Wyj+BErXNUUcp+0eYYAneFF2rOFdKM8Gi/hukp74y84/gJVHjwee9EaqRkuGJbscm3pg2XIPdrP3+0K98yb9vslPg/nb4Ej24Y44qJHFcZg7PB7UHmoEL/sgj/nI/NtIKLTd6Ipz4HN4uArZSmvaQalwW1Pmepl1HEC9804fl80cIjinLMvCvqDB6O5aD0pu/owK3llrSR04qHMa1NOJIlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvW4GG+twj/SqyMEB+YBdHW9lPzxprimXXK0tfcfpEo=;
 b=auivCVpZ6PP8mE8j3U9p3fttc/Gt6Vh2iA4RLroQzCvHf85gjEDp9YFFTVEHN3fvuoI/W4LHZ2430Vz4UQKAZ0H7fDdPBOtBUw5DmiGDgJVPh1WB4iLwINhJFaVIYZ+DkEcd+5gG9cQlDkNckZSex/fTUaPDU9y75Pz1axKXnP6fEfzVTTAgnGFVb1ofSJHR5jv8qr53ayND1tVgdBGTS4MYL372/I/dyeTA08AxRXKypPATBotuhSdywdkvmx8D3fizyvpKgFr7mz8ECHwjNrzPNPiK1BeCgBg+9shxOOtCz4A+6qdbK3W6fmXHnZSmVvq1YHx5kHjGhzyCosXeUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by BY5PR19MB3857.namprd19.prod.outlook.com (2603:10b6:a03:228::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.25; Mon, 1 Feb
 2021 17:53:48 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9%3]) with mapi id 15.20.3805.028; Mon, 1 Feb 2021
 17:53:48 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: How to submit bugs for the nvme kernel modules?
Thread-Topic: How to submit bugs for the nvme kernel modules?
Thread-Index: AQHW+MLROvU7p98KMUiYot4MPDqoOw==
Date: Mon, 1 Feb 2021 17:53:48 +0000
Message-ID: <SJ0PR19MB45442FC3EA568AD0D5FFFE9BF2B69@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704cdd50-d4c2-47d0-731d-08d8c6da53cf
x-ms-traffictypediagnostic: BY5PR19MB3857:
x-microsoft-antispam-prvs: <BY5PR19MB3857EDF1612100A714D3A334F2B69@BY5PR19MB3857.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MOU1FMlL/evZJqtfROdTMnDlxU3A0LxL1mjfNR8pmi8GwqWdp5IcdqHNHZCPviXxwSkPfjT9kz4iTUQD9UKrfmnKg8WGadv57OtWzLk/45MBwXiu9kf0/kOkrTzVLVGni1yoegg9rAniIeZm4B7+7JfSYqZ2iVWadCd3ZaZ7H8zUZoCCi5IcVZlriy3QfMRwczPQdrVR7WpyOXoFJ3ztwriyXHxqE+576z3qWtyK+BL9IuSMhF5DJi79kWPBcNhIR7qsRh8SoLhAj80JwXMgnUADhzfK88OqfyjxXUhSdmv4DZZmlG4+6Y3j7iF9++pDCX4YOoX7iX7aShWUv2DydKgTUloKlKEMLeZVDWhOlQlh1KC3h2giCxEHb6MltetIseoDbrcHS56PP5NU/t18AjMicrgng7Vp2oaSK5pyx6gc+R1hTLPHQwz4bJwyVu4gplE+mdwY7EecQd9ef4Q9ovmRbfRpMO6l/BPId0mD15p2PKvWZnUS/NJ4jUp2rA70YBc374UVU2hWNXmdr7Neg0217VN/qFGkHW/1+4ipzEBb+J9UyGdOCU6L2hNKFEVuq6cIAj8EwvJagB6z4pzJ245M/7ZVZBb9pZMXMQ+AmIY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(6506007)(26005)(52536014)(91956017)(86362001)(76116006)(66946007)(186003)(66446008)(66476007)(5660300002)(8936002)(64756008)(66556008)(71200400001)(558084003)(7696005)(9686003)(55016002)(6916009)(33656002)(786003)(2906002)(478600001)(8676002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?7Vz+D+fmfsfFr0lM+7Q0TwLHL32nRtL2Phj/vlcqCcndbmFuvvDQ2gj8WJ?=
 =?iso-8859-1?Q?5HeHwX+fjph53Q/7JTjHFKmAT9Cl0+9/fbR+1gRJ531Bk1VYB2p3TdX8A+?=
 =?iso-8859-1?Q?ve6XUbr35xCirRGt3NBeaI4gkqLJG9vJ2Wpw7D1pOYTP6MUtJzJmMHzORD?=
 =?iso-8859-1?Q?yYIyeAZDAxfax1wDfT40CET9GFtT8KtosASQ6N4l2Cb85su9Z7vgHXgzNL?=
 =?iso-8859-1?Q?mx4e/UgS53X3Qfl7Hg66RXTlKjBVRe43W2ctOgsJnpamz9PG8a7tjK1v4r?=
 =?iso-8859-1?Q?WQowWOHK85i+RgDRutl2hl17OiTymaIgWcPzjtFktMsXWayDMHsgCJ3gUq?=
 =?iso-8859-1?Q?vwBdzHNBnfoLjMzsqtYFC9outuBvLIUSGEDQpWJZjO0NAfso3cR2OMk0zI?=
 =?iso-8859-1?Q?K5L9RQaaVrEyu6Lv7uc1Ij8RqtsBbR4Bbb+3qyynHUREQgWtHFbKWwKvAj?=
 =?iso-8859-1?Q?4jtBQ2PsLtM/zVo8J/c6+aj6ZEquw7p72hdE4qRluoCXhdSmsJhUvbv0aW?=
 =?iso-8859-1?Q?HPtyXkZQJk7uz7V43oRlXtfVj28ZvDM6CoNFiiXXVlNYrcH8HogF9kTbc4?=
 =?iso-8859-1?Q?vm4uJDs3kInhBFq6S/lk1sj7HVvLW3AUDqGQ3gagcfC7TRHj+cwM/zHcqh?=
 =?iso-8859-1?Q?pf48dOCF06X3OBaslLYHNNgzYwJlUqff+6BgcVsrYpBqM8JeWmXcBe8Ha4?=
 =?iso-8859-1?Q?KHNyZvrkzDo2RUJ26ygaLvU4IXw2qPvKtR/LK0D4TIGkeQzgFy8DyCGIrM?=
 =?iso-8859-1?Q?IQTsJoxu7WdbP3ks7uEgpQvc0Cw5F9IYilYYU+Bu5ADt1CT0237sidIUGa?=
 =?iso-8859-1?Q?9z6E4smQYU1d29C0lf50DTpx5lCe56un7sEOy7lyZ0yeQK0ufFmrYsiRG4?=
 =?iso-8859-1?Q?HYkk6bGwCIFPt9a0Ez0JekrW1W5WNbtBiaWjEmk3y2RaN5CNyc9jA8ZNEM?=
 =?iso-8859-1?Q?panQ+ODE2g0sKFrPQaK0rQvT7d7190AGpSdtXrFXyFPZ9gbIp2gpwfAH0X?=
 =?iso-8859-1?Q?BHA4qJERoq9ZweCJlPrNdeQq44OAUvU7l0WCr1RAnho3WvGFxel/1PyAIW?=
 =?iso-8859-1?Q?j9w5jmdeEBwySg/2jn0/C7YEJnVV6EYldVDGRLMqAmM5?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704cdd50-d4c2-47d0-731d-08d8c6da53cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 17:53:48.3572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93Ml3+CUu/qgzK/JB7d0q1KX8tvfUs7ReeBLxEfGLANMLHtDui2qvV2J5nByGREpqADumZIp4KxrMqup0AYdhm/9UPH2I9cBBXA5AUDicH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR19MB3857
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-01_06:2021-01-29,
 2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=391 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102010092
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=517 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_125354_126868_F0DB0C25 
X-CRM114-Status: GOOD (  15.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

Hi,

How does one submit a bug against the nvme kernel modules. I found the GitHub for the user space nvme utilities (https://github.com/linux-nvme/), but I assume that's not the right place to file bugs against the kernel modules (or is it?).

Thanks,
Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
