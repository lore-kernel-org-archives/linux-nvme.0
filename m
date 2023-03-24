Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54F6C76195
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 22:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kNi5IVWqw21q4x81VTiY4xmgBmb3t+6B8I49nhbxJKc=; b=ACvojrEwSMHYNMDB0HG4IMo+pK
	7HwXVs+y8aYtDGqY7HzR3k0CpkXp1OuKhTumSxusBqQZZPZQwfcfa6DQDLZCTFkre3zcDoL7hkJKi
	WB9jqbe+txkUMOP13w1DYcRAOEZY7EVtBmXYSVviMUK2/MtzmEFMS+EID0fLj+OhPyyQEOvsvyKTH
	coHXsJZu3hkNU6TCR4g5N3OGRawl6l0iT2tII3nEYnNMYkByQwxrGRRR44AvAHAoFDjR4ao6zSw4a
	NMhYcdRDXoq2TazfUZBe1BTJhClKsSp3ooxfvZIMdp0Xnt7tGHdtQhZj464eYn/Ls5eJzgd6hXKmW
	S9+esv8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfqIl-005m3z-2T;
	Fri, 24 Mar 2023 22:54:27 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfqIj-005m3I-0F
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 22:54:26 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OMoNUf023073;
	Fri, 24 Mar 2023 22:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kNi5IVWqw21q4x81VTiY4xmgBmb3t+6B8I49nhbxJKc=;
 b=fBWBTnNCw9CYUrSHwJMWCpXYzk3k6QSaepduffkN2uhf+v6tqYXToKOlFV4nnjhRoqfw
 3cTUM3PVRlrNEGejEAEC+r3iZhOoqClWPkQpXzIHfC8jHqaX0I7m9216TXP7lsKVFRCw
 8mJr3J3WM0r+d7+v3iYFclLrcQRKpYEfw0Qm3KrcyAnxlpJAUoKy+Y715kjCs5M0spLF
 tUoUeXPCdXaY4hATv34N/63NrnZiIzNxx5gtgiy7pIxFaNxshvXK6GCKToHv6S83Q7S/
 GqxG+N0F+qKlOVt+bT2wBzyMs7LqM2oRsKnb/Uu12pxLK0d7+V9p6ymmvhkBkWj7100N 6Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phn0d804q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Mar 2023 22:54:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OKUhNo003800;
	Fri, 24 Mar 2023 22:34:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk5uj4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Mar 2023 22:34:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXzPEHTa+fmL+BmoCpkwh2voE8mJMjelFLWJC9Rk52GOye/qj/x/oPD6L6TfhLga20+RAF1GH3VxobsS4Q0chLHipaD3pZ7tRAC1TN4W/4NouY4vg1dJuKz1plAThnjB+NJ6sFwpsPUPZ3b7VMXOxBFr0BwsdhjnlV8xZ+rvquLbl7ivfGMaaU1XmpiwIBBza9INhCocMSm6/ZrRWGvXGkKZqv452HXuP1sFbx0uc++Q1YAUJ9wRDLIe8Kg/W52EGJWXfuRDQJlak63LKTjz6hCvgEc+FPmoSLQ7edkHhE8C9GntDWqcED1nZ4/zhffd8XzH/mOWExL618/xlTQgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNi5IVWqw21q4x81VTiY4xmgBmb3t+6B8I49nhbxJKc=;
 b=G845NzbsoyKtUp0ve4SEIePuLNk8s3Hc5BNRvT/D1c3+QLkf1Wih/WIeGXY0nyR+CHd9n/oh7TbSi7hY992/JQhj+/r2JnnaN5qtoKujM+jpTD8UE63gySXv1UVjj3NKX4a3YBSgNqLanQ74TZP5ufA5BeofAWHAGArJLrxVat437RGLElYceGlTRcTdiHbq9t+5NYMGMgLSfeI/Yq1GOdVBn4sP4mdv99dohUAX5jZotVMNtjrDhCZlOX00HrpYWlBo7j+XXeUnxCqR/bWoSs+sXRTjGT6dbn6lDEewRcKKp++zJyeaZRoj4Ak6VdvAe7GxhDSCanos7Th90vTuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNi5IVWqw21q4x81VTiY4xmgBmb3t+6B8I49nhbxJKc=;
 b=Uf+OVympreYKVaVfvIMcMnwcgxN2frtO/DQ2S8Xjni0rkiPIGKaTSaiRuNYETU+j1pVgxAbVlU9LNQ1aRK+CGM0AD1Yr+l6BxuAxLuv2NHPGC0hvzDYdnHREsySuplZAo1Pj2ODqeWJ3yvFAxqAK/m9Kzcivn40/Rysd29Mpu8I=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 22:34:30 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::1d60:b6d8:763b:d31f%3]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 22:34:30 +0000
Message-ID: <8ee89033-d454-072a-6fe2-e2bf24ece2fc@oracle.com>
Date: Fri, 24 Mar 2023 15:34:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: debugfs message during creation of the NVMeOf controller
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <40baa75e-fdf5-cb73-5fa8-b12d65bce4e7@nvidia.com>
From: alan.adamson@oracle.com
In-Reply-To: <40baa75e-fdf5-cb73-5fa8-b12d65bce4e7@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:a03:331::33) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: e56e4497-b46f-4bf6-cb0c-08db2cb7eecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	J14XS7vF1jjwinVw4LNtBmgnRhUjaNotgYmeV+8abFzeV7Yx/ByKXLJ/LOx6KVv4A83ZGQIfoA0iyvO1FFxvfJEwxtBfOuqbQe7jzY7JaA2IabcKew4w4VheGCqGg0vlIMGqPGxDd8tMc6huXvShRwcLKfEfcPOeNfwY1hn96+l401LhXW2dRLdRop1q48MCpCw39tIDf36FPA3pCqQzci2nYQ7Tqdj0u/XGqJwZplaAojWfwEJY88V/TmlFXbmTHp+snPKsc1GY3jg8M0bZD7fAoEN4dHS1lVINBTXA118HJEMXDuD6LrihePlhPMzArUb5KcdZErYSsVMrBZ/uIQ+a5s80EoWh/S21h4vg23ED17e4Bb1CJIydqgTAv3/HOix0/ka+Wjs/RLO0a+Wo3bJBfSD94IUvcBNPUGMJvQMZwJm4HlIh3h84UyfmWR+TAwwun4K1ZWIFgzKCtQ61ShnuDcOm0mcFL2eAl3LZePyq/Nf7XjUwp5/9lzRF7EOB8P9KP8FzZfahE3WAfkNDpzSL3VpIekZiLLG3K6Ofvpf1C2zeEJyrQ+1sZkJYTp9IO9MExWQD6ucltgetl6aSB+xbmG0GplbmAILe7yD+z/zlw/euQPBtjqWu8wwiL/DV
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(6029001)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199021)(36756003)(15650500001)(6506007)(83380400001)(66946007)(4744005)(31696002)(86362001)(26005)(6666004)(38100700002)(478600001)(6486002)(8676002)(66476007)(8936002)(66556008)(41300700001)(2906002)(31686004)(6512007)(186003)(9686003)(53546011)(5660300002)(110136005)(2616005)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?dEdwZFpPNHV6bDd0bTM2djdQRmViVDVWVGphVDhZa1RxMEF0bFV5d3R1M0J0?=
 =?utf-8?B?eE9KNUNtNk8xTU9VcTdTK3JJNzhmUno0TGIvZDRQREcrOU94UVBQbEZqRERz?=
 =?utf-8?B?djhRK2JCYWtEbmt3bE05b2czVlBhMmgvYUZhVlJyWUo0WUJzT2pTdzgzNkNW?=
 =?utf-8?B?eDZsUzBvUW5YYnVrbE5VeS8zYXFvcFRlc1BDTDlRTUhQY3dzdVcxWmF3Z2Jz?=
 =?utf-8?B?MlBiM1BWSXlRYmxENEZaeUduZTdPY3JSZTZMUnF5cGMzcStmZ1Y2OVNwUURG?=
 =?utf-8?B?a1Q4N21WT0VZckg5REJMaUJERy9WWEtXM01URTJlMi9pLzcyV1VzeGd1ZXNY?=
 =?utf-8?B?MW1EOStuOW56V01SVExHNnNJTkMxNkVwdmIxdWhycm1HTWxDUkhGbGJRWDIr?=
 =?utf-8?B?ZzdhL1VqbTQ2OTF3SkpUaG5WSzhPMGdCQmFwcjJITTE0QzBVYVlYNFlxVTVW?=
 =?utf-8?B?NW4wT29BUWJoZllXeVBSSS9RaUhEWnlEZ0lEZTQ0eWdVSXNOWC9QS0szdFVD?=
 =?utf-8?B?VkI3ZDNSQTUzY05seC8wcUE0am5oUEVLZDFGMm51cktTWjJRcjdhTk5WYitm?=
 =?utf-8?B?OGEyejhpY1dVbEpHOFRKelk3OXRxcndUcjB6QkE1NEp3bSsxVnN6OVdBSHF5?=
 =?utf-8?B?WmRHUklXSEN6Q3BIUkRlMVZpNTVGdG4xMkQwZWE4WnZIaXlsZEx3V0FEOENQ?=
 =?utf-8?B?bGNoemNGa3lnS2cvcjcxT2swZmZiY1pBN0xYMnVZNkduSElBMkNyTnYzYmdS?=
 =?utf-8?B?bkhYUGFMS3RRVlVlODN4clB1dFNObXl1cG9QejJqanlxL2gzcmxOM3ZibTAw?=
 =?utf-8?B?OXZIU0k0WW92N2ZQUTVUZGFtYnp1NmptY1Uwbm9paTEzMlY0RVM4dFpSK2NY?=
 =?utf-8?B?dzJqWGxPKzlsbzdXcm5KQkR0L0diYUF0cXRaZnlUOTBLM05zd3JNUUErWTl4?=
 =?utf-8?B?cTNVRzFNdWZtWmRDZlJRbjZWMjRrbG9LVE5oRmc2c2lxTEw2bmRqN3ovMEF6?=
 =?utf-8?B?TlBNd3p0TGY3Wm45b2l1aElvWGcxNE80RExVVkpmTkI1RnI5YTJ4aGpOWk9T?=
 =?utf-8?B?elNXSHA1LzRnK3BiY3J4aUp5STBpSFBPMVpoUWU2aUVQNnVMeGJCODlUcE40?=
 =?utf-8?B?bzltK2FwNDRBcnBjM2RHQ2UxazJ0NVBaQms1UzllTUVBTStiSXIxOEZzUjIz?=
 =?utf-8?B?VFRXRjZxajJ0QWtrYzdHY2pJUkUvaWE2dmhEZzM2bXZjR1pkaUJraEpXUngw?=
 =?utf-8?B?bEo4RmpSVXpQZzRoT01lb2tjWG9YNHZ4bUxpTTVuSDQyTVdiN0pBbUZkdTVD?=
 =?utf-8?B?VUlzWnBvcXdnUXRpdTY5YTMvdGhUUk0xODFrSnZ4STRzam5hdDdkdlM0R0Zz?=
 =?utf-8?B?dFdDNWRtRVN3YVgwWFJMUktjc2RZUXF5QkN3QkI0VDJLOFNkVjZjNVhuYjVI?=
 =?utf-8?B?V3FGaU9YSUt0aTJCemp2YUlZZU9NOC9qQk9UUjB2bmZybjRVcXlocmZUN1ZF?=
 =?utf-8?B?WXNIYitvZEhqT1JxaWFPVzJsQU1RdnhHaVdaZkUxL2IxTFJiV0xuN0JWU3Qv?=
 =?utf-8?B?ajdqak5VMlZJT2Y5emQvYm1vajNaWmNtMEo2M3VxT0xBUUVWS0d2bU13dloz?=
 =?utf-8?B?bzdUeTVhL2lSMXFzbW9pTHJycW9NQXl6VVNKUDgyRG9jZFE0bzRmNHdGVVZX?=
 =?utf-8?B?dkk2bzJqYW5NSmFtMEI0ejZYUURzb1VyYnJQYjlSelY2ZWpubVovRWVyMGx4?=
 =?utf-8?B?ZGVPUGFWVDl4Z2pUcXcvZWhLRTg5WkdJaSttNE8vVjRNYVJnNlFyS2xadlE4?=
 =?utf-8?B?TWxJYmRKWnRQMjRUdlM2V3FTZ0hlQmcrMXhrUjRNbFRhNVZYQ01EN1o3OHRB?=
 =?utf-8?B?bm95TkxsTTBiNHU3QUhUeU1FVDVlRFVtWHZYZjErQ2tZbUpJWVR5UWh0dVh6?=
 =?utf-8?B?V0pvd1FaSFlWK1VCUDRNb0FaVWlrclUvWXJFVSsyNENTQnpJeldsR0tYN2FS?=
 =?utf-8?B?UlBZWmNnd2EzSGZpdjBxZ0JZRVp6UzNIUnBERHhDOTZONXRhdUg2MTkwRlF0?=
 =?utf-8?B?citGRXEwYnFUSjkwUWltUkU5dUk1MytBVnN5b1E1MEk0Q2t2Z096MlFZTzJp?=
 =?utf-8?Q?xZkgv1wBLvy3d6dg8HaFr2p4z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	yRkfsgHitQZO00Jf1kt0isLHrUEObCv+sWF1o5AkXrYjl9b5jIRE0pnrCFo6EWSgKxuWHrq0eOjtesmEQhsZu84D/3nY6l10z0KydL+tJkrWCv+SThMSNARxpyWcQJCLXOYpK5rBQ3udFmj3UqeCLsvAfF7m6IpvXxis19vz9Pg7I0d9e1Q0htKB2OKSa5CWlqBNHtKQpwjb7KixEFA1GgcEogirw53WzJ3n7M5LlxT//x1IjSqoXcER1ZfYAqRgUXwc0y4Ne+R5r5LuTj1nO4Uns4GVfYuSRusXzT6mV+lZSOscN/ZKUivtOWihGnhhncvzRoETx0Oql0BAvbdiPaO7TssggKF3cd6iM4VihTka4r5GXnlqMBbLb7mqq1b5dhvShx7FO59vaLTn10fXdKAR8TdEm0ikHOZSuw8yoFoZwZo2a+VsUBEtgC7P2df1yt2NANyrhm86zVLjOXgXJUMh3ItYYEbNNs20lbtl5mWYTXuyXpJFEF059w/ee/YZnMBharMVwv4/WZwS04V1imSe6I94VmSMzYG7INe2iSKnhhDKNpkuxVqiIC0ZEnbOHPk07zGgiSdx1klLo9tqyf84NxsXhqpPv5G/pJyEuPfNzpuW5aKj3Lb2Q8MBNXVI0K47hw0B9K7/A0q2XRw0Jfvs/cHvjkscpgOhNpFsYTNO75NwdX8snh8kA3QE+fEBw9JyaW35U4zuaApn8AeXrG6hb6kF2xQIeWbRU76zO+UFNU1iVN1yRkNSL2pfi2UXHdl4eABAbzfE1tBGykSk6wItdGt3RCzdF+2FDSYeEvT4UE6w8o5jbNzbYh8eGYXL
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56e4497-b46f-4bf6-cb0c-08db2cb7eecc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 22:34:30.2436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVmA7rnm/jYa5OqHVnpQT5Nwi1n/mdom0rO6oqCj7XIBVRBo+WKs7HDXe9FrwlneTvM4OqohOrlhhJy300s+KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303240172
X-Proofpoint-GUID: VuAnYnw92ZW1AuJRb6aMD-Pm1Nf66lEy
X-Proofpoint-ORIG-GUID: VuAnYnw92ZW1AuJRb6aMD-Pm1Nf66lEy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_155425_123254_57929846 
X-CRM114-Status: GOOD (  16.27  )
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


On 3/23/23 1:18 AM, Chaitanya Kulkarni wrote:
> Hi everyone,
>
> Whenever I create NVMeOF target controller using nvme-loop
> transport I'm getting following message:-
>
> [18318.052193] debugfs: Directory 'nvme1' with parent '/' already present!
> [18318.053164] nvme1: failed to create debugfs attr
> [18318.053239] nvmet: creating nvm controller 1 for subsystem testnqn
> for NQN
> nqn.2014-08.org.nvmexpress:uuid:bb0a23ee-0be3-4285-8d8a-b47fcad11fe1.
> [18318.053369] nvme nvme1: creating 48 I/O queues.
> [18318.058812] nvme nvme1: new ctrl: "testnqn"
>
> It is certainly coming from
> host/fault_inject.c:nvme_fault_inject_init().
>
> any idea about this ?
>
I may have seen this before, but I can't seem to reproduce it. Can you

provide the script the creates the targets?

Alan


