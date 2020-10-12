Return-Path: <SRS0=YdFy=DT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A729EC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 18:51:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2905520870
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2020 18:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jXT8jkin";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="F9cAgo7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2905520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kbHX6yA1E4gWKDKkiKDDWQQpg4vf9Lr+sH6QrcvyJdA=; b=jXT8jkinCfVZaPvODSYWbrHp1
	3+XWl+IZQa8cx6womu+NIso+Qi9Fl+rBEsbee/25ciEP41akmpkEgZF7PXxNGNddEQoBlV91TbK3e
	nwL7pho8Wg6vtXMEn+LQ9yYTeCGMcxWvXejyoeJyXc/VM+fHS4zf2T7l4nOKYDs/RRF2HwJ5KMwVy
	Jd05HJ1bQ6t6nhrGIuMD2GPGe5YBB6zC3Xh2iztpPSl7POdzPR9Wfphpv+4CKwjGCMPuVr0uw4A52
	I7ZCHCz1kxLmGcstg3QTI8apPVpt/vzupeuRgJ525GTZVY13S62j4rPPq3YjwFOiRjBaUL5H7tlDt
	8BE9ym9/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kS2uS-0006zx-1G; Mon, 12 Oct 2020 18:51:00 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kS2uO-0006yn-2n
 for linux-nvme@lists.infradead.org; Mon, 12 Oct 2020 18:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIko8ymH29ftbAkPRgthpkp0GK20G2z5LZMakcUDO1d+WyuSjaMKjbvxF8yIIj/RU5B5PVCnHhuNNd0NP5UA1GF1lv0G1S+Jy5gPkY850Wa+IbeBq28cnaivY5bkdoMNoFNaOzQIxU1ZSpyq0XMaG36SCMlp5Is9UQ2hr7Qu+w2QicjhXbfpaogcTuQcoAas3bdAh88kwkpspMw+VcUBP7DJY0GhXJzJ2ZcFa1AoQg058//CLJFNzsdlmVQBUTdjSCd62wMGKcQcfB83odzAv4+Tl7Oja+wP9K1TbWgWYTlddHXoYIJEophenVmv44pzZ6CjmFd24e80fhS5PteulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCBIIZGVyXRJmSkdX5Bx4R1Wod6Z9qG1fGza2CfZ9Q8=;
 b=RgE2rTL8UECHYUYf/xBD4RXi8KvR80iTaUglxNwBMXlR67nKPz+iHIE8IoQAykl7L13zyTMWYJrT1UIQ1oQDEEJb7v2aAkIQQEVDhCBVzKTQwphHYWBoAYhdhntfcGhwr2zWAHT+Ff1cNiZCUwaDJE+Zy0WO8bu15YH8rSGWBgVOitKuwXBQXMGGF0zMLe8mtfaeaGg4LvM+rfUCWPevVdOFPM07CoskLMWOxq5yAuXRfwU9J/NMjaNkKe5jdJHjuDMSsUwK5UkIdACzqvTrcp4YTCJMrAqA/JEIM0RS6TNYsIzhmoRLfUXY60L93t9JowHI5AgrUGSgsj+OE0uzvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCBIIZGVyXRJmSkdX5Bx4R1Wod6Z9qG1fGza2CfZ9Q8=;
 b=F9cAgo7TFVb1epz4oJxfdckzsDyzUS+wjybC8eEW12s6WHaDScwyd4R7qX8psx045ytxUmt4bHBJ1+0vN1saKCj7WskWnlNnGubtKjFkd08uYRf4pAxzJcw4jTtq5YrholbUmzizbTx5oNycVpeoRPbLRaI5B7vok13AiIuKL8Y=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BY5PR11MB3880.namprd11.prod.outlook.com (2603:10b6:a03:184::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 18:50:53 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 18:50:53 +0000
Subject: Re: NVME, isolcpus, and irq affinity
To: Keith Busch <kbusch@kernel.org>
References: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
 <20201012171333.GA1032168@dhcp-10-100-145-180.wdl.wdc.com>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <00547cf5-0df0-d027-bffa-adfbe247f09d@windriver.com>
Date: Mon, 12 Oct 2020 12:50:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201012171333.GA1032168@dhcp-10-100-145-180.wdl.wdc.com>
Content-Language: en-US
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by
 BYAPR04CA0007.namprd04.prod.outlook.com (2603:10b6:a03:40::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 18:50:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adda6db4-2ab6-4d35-a700-08d86edfbf0c
X-MS-TrafficTypeDiagnostic: BY5PR11MB3880:
X-Microsoft-Antispam-PRVS: <BY5PR11MB38800E6AD1DC8D60BD879D51F6070@BY5PR11MB3880.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZhUSOmkQ5UV5y/LihXvRgf+cM1kc1mauGzcf2JHG1xaMhf5HiAfltKNmcrr4tSQDpMBI+636oRvjOzXFQsVCmKpSXed32O2BHMUNsCmXnWB5KKty941yxO2AzHr/eGa4DG1Dc5sRwt91ToJT+/iWMPHZPHX4fVKa0cyZZLxOg9M+DaKkZZXHKFhhUlr/uqUiRrxzZY1Kj2kQkLyjiCoWSkSL/YeUZRTk/0TMrMtbobzZHlyNzAO6XY8e2cpQtniUjXF5L64HPZdcV7JUcWzaOKi7UrgoP3pnsscGx5HN0M/oFIOCDQUj2QgF1ZOaJWzXwYjjh2NIS/34nfZLxhZ803M9fhXaRC6spgmpp/oceg+rE8YCcjFO5C8W5gf/IFv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5120.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39850400004)(346002)(6486002)(86362001)(52116002)(5660300002)(4744005)(66476007)(6666004)(316002)(4326008)(26005)(16526019)(53546011)(478600001)(31686004)(16576012)(44832011)(2616005)(6916009)(186003)(66556008)(31696002)(66946007)(956004)(8676002)(8936002)(2906002)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 8SE/pTrmBX3hm6l8KdKxWF8u6XTzG4DRu22TPQ9/5WdFvTP0LWbFZnLW6eDaGBt5mxqD3BqIn3NF233U1JkU98FjPmFhxIHV/KMowxpSvUX/TII6YVHgL4AUGC08D/6KKrkLVFXSrN0lWG0CC+HhUwDYxyrZIS9ZWFRJj2TQgVXwk786Rvon7BOc/ge0hqYWymUJtd9TAMpA5MAL1WCUKHEgtiiAWsL9617u+mDG5qAN6Or6Fpv3XAH2rRkJqXtf2PmO29gJCPIvqLKXu3nP3xSA67v/2uMmmFnOEmahk0xo7Coo0kE11YCeMLqtEZG6yb7odwPa3XocSwTy5B6I2NZMaq8tzc1CfiM9wdrlzKTjtKdUDNbFzAKzeQ/Gw9H61tayLPY6Z7S1ky2FiNlUoTlxcKyCF62dSLK+MBRikUk+jHbpn0RUdJGZ988N2AyRe5aapryC1scdZcNVITh0XRFjBAQm5Aph/PnFRF2T+nGKVo46DcK1aALFlEJJ69+iRNuFeTK31rNCNv34Z2kVZb7TGUoQAH1PTvF6ro5A40o8RRLl97omZqTas3VqeQqza+XypZegS27DufPPKJOl4eJqB7+OzA96z/w6bSO0WArs8iC4FgeC4QPKpS45wpHFmXDqCqlaK8Jho3mKccs0fA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adda6db4-2ab6-4d35-a700-08d86edfbf0c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 18:50:53.6418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7Fy9ayBqDfW/DYphOLVBYpwV6Z2XmZ3ZPTWrzv7SNidNuauuiQ3m+1HvpRpOTGo24xNPuo2LGiReBHlF8WSGb33P8yWzOprfTtbaTpKyXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3880
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201012_145056_136118_A5A008F0 
X-CRM114-Status: GOOD (  12.57  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/12/2020 11:13 AM, Keith Busch wrote:
> On Mon, Oct 12, 2020 at 09:49:38AM -0600, Chris Friesen wrote:

>> Assuming I'm reading the code correctly, how does it make sense for the NVME
>> driver to affine interrupts to CPUs which have explicitly been designated as
>> "isolated"?
> 
> The driver allocates interrupts, but doesn't affine them. The driver
> lets the kernel handle that instead.

Okay, thanks for the quick reply.

The interrupts in question have names of the form "nvmeXqY", where X and 
Y are integers.  Some of them are affined to individual CPUs while 
others are affined to two or more CPUs.

If no tasks on the CPUs in question do any disk I/O is it possible these 
interrupts could still get triggered by activity instigated by tasks on 
other CPUs?  Or would they basically be idle and inert in that case?

Thanks,

Chris

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
