Return-Path: <SRS0=KSy6=7J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402CC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 11:19:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DB5207CB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2020 11:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dtC+NGTB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="QVd4dqXm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="X8P3Y1Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DB5207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RjF1pbttO1cp+lYfob/ozlDVuWi64AqnNUIsHL2ENH0=; b=dtC+NGTBldxwLp
	6pnTq9jly6AH/SPSQDwdLjNiHXGhPGaUY12rKnjFPWcdw1RgnyJBXluHxL4SBJHIlx8mq9kGqtQa/
	vwDW484feHpo2zjv5uFLxKeYAM52UQFFgVAVwzEqMQ7R5XIZ39RUnAV64qSt9xSIA02X1R3qi8ObE
	ftU6qtldln9H6a5sJHeu9wlrd0TudManbmlIshK+7mHPYqU7CZhltsrt4bevan4QkHPmdwQkaFggR
	qS8Vo+n8eWDO0MNYJcmeloOTQYOQsuzXHN/LPcdGJ7ZQ1A4sMXy0SJTgru7WiNu0X47IgGCjAO7Jk
	191hKB+ujU/zL7riu5Ww==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jdu5V-00067T-UE; Wed, 27 May 2020 11:19:09 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdu5T-00066h-5a
 for linux-nvme@lists.infradead.org; Wed, 27 May 2020 11:19:08 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04RBFV5u014934; Wed, 27 May 2020 04:18:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UsWGqX0Qu7Z/cxHLBX2RXm2y65aSJu1zx8SGBcUbM/U=;
 b=QVd4dqXmmYEN/vc4yxOG4gh0MP3MDGy/sePgkT45tw3qlGqm6Ws/YPFCEizvCZa6lXTQ
 7Yf9c99ryeYwSZekvC7/Wk+Yg+FWicXpp4/v+Tvp63Siq0kOe3qQ2OnB3HfIa3AliqWo
 UA25YOSfNXX3sa/J/kHVMYAa8ow4H7RQjZ0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 317kp3v296-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 27 May 2020 04:18:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 04:18:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm5ylbb1BqYZzIMyLOPdlV5Z/e7Rq6vR5lsPjpUsMW0zPTS3Us5J4AuirMDp3BhKE44RwOF6yOccWoxDGBCCCVEKK+f6I20iUxju/ZSrliIcacHTKXTVzYjOwOws+8wnfhuN31s/sW58lfU9zYMiSv/WdVWsWv4rp+lk3zFYp0TKOgT6gLyUNE8oPhZ9q9OyJ6nsBB1VB1EujMOCVCiV8909+i+M+4LKt23+LqHotroW1zBX6s/WCfPpy3iZkeCMTFvBQ2j36PtYBWm3+yMq2bndPBp7PZZyYUygqk/TaJPE39Wc8UkAAYpYcC00hrvWGHNTM/Xgq36KRduHQ8AknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsWGqX0Qu7Z/cxHLBX2RXm2y65aSJu1zx8SGBcUbM/U=;
 b=hck4DijkLCR07n1aOSJMlQa0z9q4GovF6fNCUznd2Rv+mH4bk1FBqVq7qO1+C302s9gzVMkbnU/z5P5cdAyBM+c8UxNIlVAwNJvP1xbx6ydvQvQ2EEJRG2jETGzAtq81BduEE24RKAIUeCGtWXVhMSXFTDc5lD3wLyMlaKt/IYcwQmQkMQNfM7oGperdrLRhFjaQVmRC6jEP9Ug9nClL+gKBdFNR/rvdRlHh0qn2iVgu1CUbuGh0nwuCoU6fi4VBP/jjURpdML/gH7WelyuWWt7ikDGzx7eZCrW+s4KOtHDJH+o7hHTpV3AGzAc6oqdZHt/L20LuDdCHG+QiR2xWgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsWGqX0Qu7Z/cxHLBX2RXm2y65aSJu1zx8SGBcUbM/U=;
 b=X8P3Y1GeEFlJkeayUt0sbFSVkwbmYdN6UhopYUC/Quhs6b0kC+90hnk2aSTd7mCRU7Xb9SBduLW2D7nKAng42ablC8UOrHD/OCmSFsIm3KJXJMwgHwHKitRIEVio1jnNHRB81ZG1tdXAX1qQu8HYTqDdxtA+QQwqE5Ydbcnu5KQ=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none; lists.infradead.org; dmarc=none action=none header.from=fb.com; 
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB3464.namprd15.prod.outlook.com (2603:10b6:a03:10a::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 11:18:30 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::c0bd:87f5:aedc:b739]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::c0bd:87f5:aedc:b739%3]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 11:18:30 +0000
Subject: Re: [GIT PULL] nvme updates for 5.8
To: Christoph Hellwig <hch@infradead.org>
References: <20200527052038.GA403423@infradead.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <259362da-07eb-ca6c-62df-61e0ef6dd9e4@fb.com>
Date: Wed, 27 May 2020 05:18:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200527052038.GA403423@infradead.org>
Content-Language: en-US
X-ClientProxiedBy: BY5PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::35) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2605:e000:100e:8c61:2cc3:8599:f649:862c]
 (2605:e000:100e:8c61:2cc3:8599:f649:862c) by
 BY5PR20CA0022.namprd20.prod.outlook.com (2603:10b6:a03:1f4::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend
 Transport; Wed, 27 May 2020 11:18:29 +0000
X-Originating-IP: [2605:e000:100e:8c61:2cc3:8599:f649:862c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3a1f5c-df4c-4f14-cb57-08d8022faf20
X-MS-TrafficTypeDiagnostic: BYAPR15MB3464:
X-Microsoft-Antispam-PRVS: <BYAPR15MB346476FCEEA765138F3D0852C0B10@BYAPR15MB3464.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vqcyh1+swcqoCW9fTVNkmrm3h/BWEoGQNcgHgICAK5cT0LWF/li71hhvt35j2RINAzGWTAq69DxsluF6ToV2l2n0QlMtAnpFfDyARpg0MU5iXQOTZS+56YzZSDh1k9sb3HHu85hI/PnqyInwGn9QB5lANH9KrVN7QNFobr2MKT2w5EZa67aznrzsGsvdVXkm+yvyg5QX1lbN2gtm6SXwFGS+mEbMmwileLcf1FGwbmqZEbSCth9yTWyZCzq/eElhtpjX3/a6/2Q1e2WFN2uKQqdmGZcoOZLrtz8faBK7q0JY5Trknt7czKiVdca0XKIIKtYt74dfvVOQmjIvGcpIWFjzWqZngIxq1JcVfK0AoEirHHZB8msz7AsRvnYyohu9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2566.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(36756003)(5660300002)(4744005)(316002)(54906003)(53546011)(16526019)(52116002)(186003)(66476007)(66946007)(31686004)(66556008)(8676002)(8936002)(2616005)(31696002)(86362001)(4326008)(2906002)(15650500001)(6916009)(6486002)(478600001)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: fmGbo7NemwQptv8x99hfbmiUFntsQ2sS1k9o68UTaZZdXrc2FdLV8MbKp4+d93+RblH7S3H9YhVCgtY1lbcw3ftDRJcoxKK4//t5u/0IG0XCrxO5ct2OsHb4nhge/zBSGhDIliNAd0sg+zahU7FvmnenRkL7ObAa/SaTikaVXZTXf2XYR33bZCmBk4ewcrn/8WYb3FQVzqO+GKMS7Z2d1FlUmy7gSX+/hLIEyU0q9sw/z0GvdRw5ptoiDlJodMwdP+MwwdREcvfnpE/D11XtbI+bHVIRuBdLOU5iKovvOEbv1y+FX4y2mPgoWvx+btB9N/NkaVSLuH+LNwk5yGcoNpr+1TKm9LwRaiOt2LxlHw8Ux8dmHbmr8iL4E/Iie+t2jetv5Go785cW76GlZM5E9hqLe/+NZi1ehQ2mM2mE5QP5zv+76siUuNQkT5nyLiVWFz9HBh4VH5jQnwj2mjWt+gkdPIE3bAyPd1/drBCCselO6NmoxXWLDfVnbCz7cUEnsW2yWfV4dFBS/bMjBXlgI/amUqkMsid6YBYjlAgIkr3nOnOeBBQ18HmXRPHOwOkL
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3a1f5c-df4c-4f14-cb57-08d8022faf20
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 11:18:29.8855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hDIeMyAs8BjUpt5dZeZRMPopWbl1xNpY+HLW26vaiF/02uTwou0wf9Y8ykdyhDEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3464
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-05-27_03:2020-05-27,
 2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 cotscore=-2147483648
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270084
X-FB-Internal: deliver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200527_041907_214195_099AFC28 
X-CRM114-Status: GOOD (  14.68  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/26/20 11:20 PM, Christoph Hellwig wrote:
> The second large batch of nvme updates:
> 
>  - t10 protection information support for nvme-rdma and nvmet-rdma
>    (Israel Rukshin and Max Gurtovoy)
>  - target side AEN improvements (Chaitanya Kulkarni)
>  - various fixes and minor improvements all over, icluding the nvme part
>    of the lpfc driver
> 
> The following changes since commit 263c61581a38d0a5ad1f5f4a9143b27d68caeffd:
> 
>   block/floppy: fix contended case in floppy_queue_rq() (2020-05-26 15:23:54 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
