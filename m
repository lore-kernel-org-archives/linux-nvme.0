Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038D0C4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 15:50:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB88C207DD
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 15:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AN4ql3wm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.com header.i=@fb.com header.b="lhs0x1j3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eRtPeAOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB88C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gZAz4ANlm5HgEim2gKSzl+5cVrxihhnvYmAQgNGZvdY=; b=AN4ql3wmmYSMNF
	rBT4G4Pup/E326myNNK9uVV3RZ2fxYGh4oXeRLvbOb3Do8C/K9o+3jHp+QYiE7w4DnWfyJqauWJw6
	Mrad+/LxtjuRqlW5zo7Bj7rapzDsbtu5PNBLRx78hxHhVuJIst1ReEAXbG7AKIkqKxrxz/JMQPu24
	F4FGTDJQp87mCfO4W9pj9x/0hkdNohzs6BPf399FbM72UwR8Q7X/KXggR4+LrkDv8eQTqtLyZGE4W
	qml+308Kw3NhE5J4Ms7wNuRjkzVY2uzyf8WkBYTNHM4BMqOs6uQFkp/ltPKvQuTxAKBUN977H/ZJS
	WaHbUMgusBWFZMsCEXeA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX5Gs-0005rq-Lj; Fri, 08 May 2020 15:50:42 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX5Gp-0003Qu-6x
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 15:50:40 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 048Fd74P001216; Fri, 8 May 2020 08:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+mTs+pKyBuc6enr0smcQLymATt2cZRUhaBkpVgmwJDA=;
 b=lhs0x1j3KQfHp+g4jUPQlpg7ZFHOlGJ4UTykBTsWf6LgEwrWzNAVNsjiU9EVEu0AiDqz
 g/5NvT3+boXVyHY+Az5NMTwL/kMS06lB9bVNd+i+XanqpA6f7X4mKT80GJtFIbxFGGS0
 jZL+P3OCYi3Hep/oFvhVyyyFtVQ1LgASomM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com with ESMTP id 30vtcymaqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 08 May 2020 08:49:46 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 8 May 2020 08:49:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jt3/p68vGyCa9PNAHk1nIwHXXXPPY/CXabdiBoEvBu0E6xB97NRUVcIH4SK4iGHR/pKkxswrq2BE1VKwx+Gwz8jtuUQKaHLPxgp/HN7QgDEJPRJyv4zB9N6fKMdFUtPsuM+AdwVfQwheMmNVD5q4VYtX/rfVNUjnN3kDoJRnfVh3vuEzNdctegaABM7gyVyxvyOH5nxjBZvd1fdOvQSJ0Aw8Wb2W4S1zzpQ+Qo6PsNehYB9Fsxm3Zri60P4m7L+c/i2Mn+hRbn+viVZJVdK13UE0+/A4FTuKCHGtXf/UuDalW1IfxeFrnY6o5aZnCjaiC7/qtO1QxWJw2/tjQg93RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mTs+pKyBuc6enr0smcQLymATt2cZRUhaBkpVgmwJDA=;
 b=CA2LLmhW4buui0PiO0ECOMet5xJAn2xh8pLCWj8iTnjMaDtf3e2GPTLQtheiuu/fFjQJQZXZjwF1TTG8UlQUPp1gfERLA4+0yZuALugnGI46QSNag3oMhyk9dZxRe5JUTogwR1unZvm2XTHkuUJn3y0zoPoZjaErgGVeQt39hMKK8jpmsMnXUftXo+TO/1PWvNlSj+xau8agIGZbIS+i/I1xLO3583dE+jOObZ5/5HiZhPDMK+esSJTIqwFHDb82J+ss2DISkTapouTgCVNcwT3edDI+gLL+C5RKz3WHxG+8iV/oZPm7zaOrSEntF3NUV7Gffngg44W7el8lzv/YSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mTs+pKyBuc6enr0smcQLymATt2cZRUhaBkpVgmwJDA=;
 b=eRtPeAOTRfdMThbet/bYqFsFyPmnbQ+XUGIBnQhmHDgfhTg51wrVbq5FCGP6zWaOteOjnZ6sdJEb4/bauGSf1lwYh5rijkmYPjqc7e+1zyhmUfeFfOicSVhS9rkizOMTPTCJh6rPS7nDjZvanvUJUv43YY4w9f1dFfZmHcx6SEs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB2246.namprd15.prod.outlook.com (2603:10b6:a02:8d::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 15:49:45 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::8da8:642b:d574:16d7]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::8da8:642b:d574:16d7%4]) with mapi id 15.20.2979.033; Fri, 8 May 2020
 15:49:45 +0000
Subject: Re: [GIT PULL] nvme fixes for 5.7
To: Christoph Hellwig <hch@infradead.org>
References: <20200508153951.GA250474@infradead.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <ef6d2cf7-4a21-d4e9-3303-979411d50ea4@fb.com>
Date: Fri, 8 May 2020 09:49:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200508153951.GA250474@infradead.org>
Content-Language: en-US
X-ClientProxiedBy: CH2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:610:20::26) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.159] (65.144.74.34) by
 CH2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:610:20::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Fri, 8 May 2020 15:49:43 +0000
X-Originating-IP: [65.144.74.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51f85756-b5a9-48ef-a2b5-08d7f3676d9f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2246:
X-Microsoft-Antispam-PRVS: <BYAPR15MB22462676BBC480AE94B97781C0A20@BYAPR15MB2246.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:106;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVMgoobXaDfN7uHIgi96p9sSznPH8+gHOQ34ybxj7RF5D0cpeDbTZXcIGOMubzJin8yDJzQnWtt+ngxqZlyEa8Yu/DSm0kgLf47qHJK7gwQOe0jLpCbT9B8R/e0BZMJENi+yjiFhxiAmy/GcilieHswn+9F5GbX0Kg5vemeadIsZ1cOQd2WEoypVR3VS6YtojbMk1LtCB3K1yd4XrQs/hh9VKpiaYc8bpvFxbBil83Bccq/S9I+sr0odW4pbOPevYCpiIvIZDeZQaFz9gaSRBTSHL7/Sd7OCBjjTL56Jrsosv39H/l6U0kvBII08j+CuFAYTvKrikWbaOt06b1urLvY3UD3wcxuAWweO8nyhzJM7HcE+ujf3uhBTX4mPZ0tV8Jvo0IQVfxOyMrBEpq7F4ia3mKMJwA2B86lB9nvB7ipf5Db3HMNaM+VsM4CGSGA5QSAB5F2V0DMd3Wl9+jT1x9ao+v1FxXVCpXuZLe7rsJiZMoaj5Ibu4O5FWrE43TxV5EdQoAgJqdNmvewXEKFxXyOeoc+1rtTLy/7BXlfsRTmRk1aFrRoXObnHfOPo8Gf3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2566.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(39860400002)(346002)(366004)(376002)(396003)(136003)(33430700001)(478600001)(66556008)(8676002)(31686004)(36756003)(53546011)(8936002)(2906002)(66946007)(2616005)(86362001)(4744005)(33440700001)(83310400001)(83320400001)(83300400001)(83290400001)(26005)(956004)(83280400001)(52116002)(16576012)(16526019)(6916009)(186003)(5660300002)(66476007)(4326008)(31696002)(6486002)(54906003)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 3/EFwrM3iBAUeTSwFB/anEJ8rTzZ8EiPG+ERgTl58+UuxDGeSM79o9w+3aT/Nc6Kot2Ytfit1+LPzxWp1f7J8ADGUfKKO45Ib67AIqw5jGiUNMYEwaHvZWd3UU04Jiv1ZZS8nNItl504cIAV3xlSg8w0e+c/GRYzhQHTN615WROodn6h1rnmpGRAURFWzEg+qqRCe43HZe7r6ckaPRgQgxbDmEsKZ+B8ZPwj60dnHFLlsVqICo3NpAhPTB3Uo1dsC2y8Abz2rR9EEXd6Sm97Zj1gRYisQo6f9q8qWT8dmNaEuqd72z6/YXbEJkEI+L7ZTLdmg/72Mi8iCm8D63JaYunbu+Az0A7ckjRxphj7CDHxgt2SYR9EaxCWnn8Ha5Bk4UnfkKM5Eeco7rSwAeik9ZbJ41JAmpQDgawtt7K/yOnsqAbRfdzryPKuA5EhUkmCo+jbDuOmlrY9NuOEplAf8PxyG+0Hr1GsItD1+Zb5/qc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f85756-b5a9-48ef-a2b5-08d7f3676d9f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 15:49:44.8480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb+5C7lJ7P/7DpXUXwmJrZHq9Ade6Iw80II42873DPAfeEzXIhWBZzUaqx6KM0Ix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2246
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-08_14:2020-05-08,
 2020-05-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005080138
X-FB-Internal: deliver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_085039_376678_19A2ED3F 
X-CRM114-Status: GOOD (  16.25  )
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

On 5/8/20 9:39 AM, Christoph Hellwig wrote:
> The following changes since commit 860a93ff87acd001eea827b70f4a7a64c0854b81:
> 
>   bdi: add a ->dev_name field to struct backing_dev_info (2020-05-07 08:45:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.7
> 
> for you to fetch changes up to 8874d040ff34285e8b8458a75f9434e19ed06174:
> 
>   nvme: fix possible hang when ns scanning fails during error recovery (2020-05-08 17:04:15 +0200)
> 
> ----------------------------------------------------------------
> Alexey Dobriyan (1):
>       nvme-pci: fix "slimmer CQ head update"
> 
> Sagi Grimberg (1):
>       nvme: fix possible hang when ns scanning fails during error recovery
> 
>  drivers/nvme/host/core.c | 2 +-
>  drivers/nvme/host/pci.c  | 6 +++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
