Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836B9C4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:34:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C32360F51
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 19:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C32360F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lOOnyMbZeXVqFwdrwZe3saowZmT3U3PTfCjXTeqrCDw=; b=Cf2xOP+Cjpc0LnVgF+JtIdJQTF
	RyL6Db69ojF7l0F/9u6cz2ik4Wp5UKQOPtO2I+EPHapF49wwLEUaWhtotXglSDJG00y8MgKcnv01B
	h12So97J7Hpv6xnWlyp2QYs02ytmLMrOXyWK++jPqdOOVRc+1+cITLpRZk6CviZ/nVzYqxgcISjgC
	iBrLbZIjMK1e3Q3mm6uHXEDYFWAyfm5zkR6Hc11tqEeI+q0lb6GD9d2khN/Ra0c/tNSK1d+7no1cJ
	FqemRyUWKjzx1DNj2WYKAUoQ1Ek4w8TkglDvljaTCz+VTHG/5lf2ms7X/uN54404YrtzkSCyNR6K8
	J/uH4b0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAdho-0003KX-D0; Mon, 02 Aug 2021 19:34:32 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAdhk-0003IX-5N
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 19:34:29 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 172JVnkh005010; Mon, 2 Aug 2021 19:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mDYFy+gFWK9sEMQhmpjsER0xI/yO4InbkMCwLi3lyRc=;
 b=bFZQaNGltfVA5+VZmW0v69VVMCR5MqvwBg2/3VzzFiTY50WsuFNhf4dTnOrcDVuOLov6
 yEVbPnVu/sLUHO2kGPPtxzmgeseYmaeX2yzZZ4rO6mVcSVJ+Zxgzh2n/kIp5RYomTDA/
 +MDiWSQM4T0ymjBZQ8FRQwptfl5Z0RIS+FWCTpYqm02wGZJyqnWtJGc4lMZfM5sOs7rL
 tdAzqGmYYR4tk95QTF4hfHDJXoROa3+LKsyZldGxOlvWclMBDPrkkS6Nj9gr6i5zpIBU
 OyFnc3+7B6glDYPUEspCkPP9pjCHzgBJVloOyst7oYNrgpJ81dBzL4mmqfKNYDU2Gr4f NA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mDYFy+gFWK9sEMQhmpjsER0xI/yO4InbkMCwLi3lyRc=;
 b=eQGAvDujyeqVLatutzIY3cxOxvE2zOdZKi5If4k+YXN+fl84AZfRybzmiPxvmDvp3b59
 l52UJITddMCyixxduY3CiugL9OMMxytNj+ef7f0o/zIVlGtdPUiL4U12fHT6L8or9UPz
 r2mt73lo4mL+cv6gK/llGdwQl2VDpS9sY/ZkTLcGIyM2S0slAhR8ZoUiO2jM3QhYVLSC
 USvyn9W2B5TZzyesmE9e+LdSW31+/k7FQ6FEgCX/iG7q9DXnrSN5ZuzOkWF8NzSsaWjA
 znu8UYGvzJ246Yskr/Nuev7iOYbUMGFf/5KvgNGDgDadncsmLHp+85ZlnAkjWLIbVHrg jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3a5wy1je1e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:34:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 172JU2ms157131;
 Mon, 2 Aug 2021 19:34:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
 by aserp3030.oracle.com with ESMTP id 3a4vjcjb35-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Aug 2021 19:34:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2eiVTcMj3wjJIgMvGotBSBdhGnJdmkIwaJ4cz3Qgfd58OENhIKEaYRwJxnb3UtnHgAUlfhN+AO3nlH6QXUVvS7tWDPq4XCYiik4+R9+EqJ1tjUwBqKnSmkBbEZthxENOdJ7AeaJLiEjocX9yYA7NDxXuoB+X3hdGkJTaPXkBLiF0AyJBrjyG42uAEV4wupNwA4sLfBeej9/IhDw0SPDRGnKi2cVmG2qdL6igNKIJudTFlOn4M3xXk1oNPDEKXAkEhlf0cXSrT/Ch94PBYGdfQWoFXD5tbhUCJJ0I0TFRF+L/C0teuxHxE1ayy/3g0CdeerRR8TnuCDc+o1fmQ12Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDYFy+gFWK9sEMQhmpjsER0xI/yO4InbkMCwLi3lyRc=;
 b=N6rszee3zBcq7p6AUjVZ+YWZLsVh0tDGnae0GsXTtXsSN8p8Fpayf1KbLWEUwMdux8FZs0ZNb6aGua9EvSg4EuSGwKakUhCSo9uV6pdE05vq7YJs52Ue5VkXVmzhAM5KTBDtu4e0CESsOo8siIDSaxJsqJYbfIwBdvlsQWGYyCnY5HhZMwlPuiLwl5FwR4vPg6tI0BiZhNMRuEnIMMekXMUZWyLJt3yDezydgr3uosAr/qkS3fdh/U/gem32/DE4zpCHao/r2j3kBMrOK2frWPYnk4PanSRsYTgd56RLbnc6l9bd30G0zmL6S0N315L4bPcmbLGZkXdjAuiBeSlU1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDYFy+gFWK9sEMQhmpjsER0xI/yO4InbkMCwLi3lyRc=;
 b=foifXm1bND4d3FXle33wqGeLyWvGvLMxUa7VCmZ+yttjXii8cawAhuTs/q1uDxp7nyrCjeiT2t5mAGQITDAzroayjniuVuPTnIiJFB+kNQ2B1C8+LptL3y3qoGZF6zWTBpRko+n1lrZ8PvhnNkK3JHnhh9v+f/hOjHx2fCABZxY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 19:34:13 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::7c0c:7f1d:bbb2:b43%5]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 19:34:13 +0000
Subject: Re: [PATCH v4 1/8] nvme-fc: Update hardware queues before using them
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, James Smart <jsmart2021@gmail.com>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-2-dwagner@suse.de>
From: Himanshu Madhani <himanshu.madhani@oracle.com>
Organization: Oracle
Message-ID: <1c295011-12bc-4748-58b9-2e1ec1483f5e@oracle.com>
Date: Mon, 2 Aug 2021 14:34:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210802112658.75875-2-dwagner@suse.de>
Content-Language: en-US
X-ClientProxiedBy: SN4PR0701CA0031.namprd07.prod.outlook.com
 (2603:10b6:803:2d::34) To SN6PR10MB2943.namprd10.prod.outlook.com
 (2603:10b6:805:d4::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2606:b400:2001:93:8000::b52] (2606:b400:8004:44::1e) by
 SN4PR0701CA0031.namprd07.prod.outlook.com (2603:10b6:803:2d::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17 via Frontend
 Transport; Mon, 2 Aug 2021 19:34:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3edb1af-aa55-4171-21b3-08d955ec8223
X-MS-TrafficTypeDiagnostic: SA2PR10MB4538:
X-Microsoft-Antispam-PRVS: <SA2PR10MB45381CC6A55FA88134E30333E6EF9@SA2PR10MB4538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbiErUBC71tjRsDop2SsAgSPg+efPs9q1L0DuBe3IOv2Tarp/UUwem2wGoMpBvFoK/YLc4iZIeT2W8kWpMqCGroeF6MrpTqCP0QtnAOLsFnE+94s8mKk7zmnECgLDXnx0pS1s8Vj8ObHfTBt2VbZqImT788R8wUjqvvJrtgSQfDHYOgAP6vrZ9Mwtxdmy5B9HVUFn9uODkFNtK5CX487kJpY63d9c7/Vf+hoL+SPwVrF4GI+JdC/nvN0RQFXltHkl2mg4HkZnqh1D3qsiHCmit61VKZFBr3bQ/slRqifJjj3CLQI86xULrkPk0TgdD4GSn0fj2bUQFnPexw0cCQn+u9sqp4vPQKrSTUT5K3iv6MzIMOGNcGmyj3JQF7nRtMTGgTMhkilW5PHzXsu1bLyHiLRSJX28V4WRsWMQifzWnVArtd4Jb3HV1+tu7mN7D0y7FDghkOCc6SVPZ8EAaP/0jvZ0lVmCyUNwd4pgynJIlTTrqPAc9PF5h1cs7amocvAzPItPbBoE4tHuWNizlu2R7v0XjsXbjdzh87uEm3kAuqQGnYZ8aF8V9wRVDHOdvffkvA8+ZmZe//eaNvv1d+VSyRyP0xNMciVmOS5Oj/LXMgT55Opv8/QpyBN3+VlxqRhlXYm5uuqCNwh/+UIxYgpvExNG5CtF7xVL9y+2qZlZ7kPu69btjxOziKlMlHtoVzTLt/bfRjif01PyDW7LAPwyhZ+lbQM3AgEdpaBAxRa8Js=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(136003)(396003)(366004)(39860400002)(86362001)(8936002)(66556008)(66476007)(8676002)(186003)(66946007)(31696002)(36756003)(83380400001)(15650500001)(2906002)(36916002)(316002)(44832011)(38100700002)(7416002)(2616005)(53546011)(4326008)(31686004)(5660300002)(54906003)(6486002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFdmMitiVUl0VDVheWxhNGNEN3hZazFnNk5nTyt2UlNnamxJaHR0UHpEOFAx?=
 =?utf-8?B?RUd0MzRmeHhnM0RxalpnZ3YzcC90QkdLQllFYnJ5SjNhbkdrUUxEeWhxZUZJ?=
 =?utf-8?B?ZWhRNG1SUENrQTRyNS8rVXk0ZzZUS2s1NlJEZUNmaDdMeGFRU01qbDV5RlZ3?=
 =?utf-8?B?YjBWQjA0NS85aG81VEY1akpRSENGQitiakhGNk1vSk9KTm9nR29DYVIrSEpS?=
 =?utf-8?B?WHREYXJIYmg2RjFFQXowQVJyNFk3U2hWTUJtL1hRaUxwUm5HV1ZqcUNJZ0tW?=
 =?utf-8?B?QnRxeTZCREhUSFl1Q3QwTWROd2lGaGlLbEpaQTRUMVRSdnBkWGljNXhET0RQ?=
 =?utf-8?B?STZIa0JJTkFSK3NLbEpZN2hNS0VzYWlPVWhwdUs4dXRxRmRUb3FnRFRsby9u?=
 =?utf-8?B?S1BCbGQzZlRuZWI1cjJCeE5HU3hmWEtYZUdsUmN2NXpoVzJQMU1DVWdIWTM1?=
 =?utf-8?B?WXV0MXcxdkdMWjJXZVZXSjdPYk51NFBQK3pyZ04yYUkrcWF5Y29yRzVMMjlr?=
 =?utf-8?B?TXRtQU5xa0lqU0NuZzg3WWhLZTQyeUNxOVFwaHk5TloveHE1S2NiUk81VDI1?=
 =?utf-8?B?Nm5MUzlhY1NSbk42ekdFaGsxOExEeW5WNUhsa3VrN1hCdlZRVGpPN3RUQWta?=
 =?utf-8?B?OXdZc2ovaHNWY2JCaFZqZ0w1Y2dqQzFJV0FCOEhpZnd6WExRZXd2T0NOMUpF?=
 =?utf-8?B?UVZxWW1qUGVVTXBLRlFiZDY0aVNSN1V5aWlzcHNqaGNWRmlHQVExK2p0b0hC?=
 =?utf-8?B?VkhmVFNSS1c0d29ZZzV0djlJZHpwb3lYSHl1MjFCUGUvNHdZNFgyUEdtcnhN?=
 =?utf-8?B?bFNHeG1qbDcvbzB6eEwwV253dVg2UTRNL3M3VzE0UkowcVNhc0JqN0QreVZp?=
 =?utf-8?B?MXNUNXMrL1RaUUd3UUZ5VjVvRjk2d3Nha2pkN1VNeithRU5mT1g4M1MwQUtQ?=
 =?utf-8?B?am9YL21zelBENDhsNzlUTmJqWDVhVzdDS0FQNFBqL1NpZDY1bFBWUTZ3dWIv?=
 =?utf-8?B?bG1EL2hYRjVWcG91MnJXaStoZUNieDRvcjd1R3djam9Gd2hkNXEyNm1JTHZh?=
 =?utf-8?B?aTlSbGgzK0xXR0tBR1ExanJzKzZtWVBBRy9Va240aG1KcitWMDBCOS9sK2E3?=
 =?utf-8?B?dTBsUVVLNDNnUEpPamhqb1VLaDltdnh4WTZ1U3oxNGFvMUIrWDhGSThhR2VL?=
 =?utf-8?B?RjBud0dRVlMwRlcwQmJ3UG4vR3pVOU9wMGVvR1RuK3l5cmlOWGVNWTRsYmxE?=
 =?utf-8?B?dkxhQ29pdU1Zc3FCUi80c0pEdExXeUg5T1RXZHBobEM2U3A5cmo4bExPcGJl?=
 =?utf-8?B?dDZaSjJPaGd1SGh3bEc4OXh0RVRZSWVQV2locVF3eEQyQ1hjZW5BVmI4WVJW?=
 =?utf-8?B?eWFxanI4Z21MVHo5MlU5SzZpWkQ2NjV3RXZQWWEvTVV1cURXRW1YTloraEg4?=
 =?utf-8?B?YUc1K3hLUGlkbXRtdUVQSEJjTDdrKyt0OGpQb0NSNXF0cXlnOFFQOFBjRkpY?=
 =?utf-8?B?WFV1cFA2UDhPSXlzUXl6dEs5Qk8vangxU1Y1TlFpUVVXaHR6MEs0bGtqU2Ri?=
 =?utf-8?B?RTg3b3pHZEtMWTdZaVJwMzlWR1dibXhJRXRrMDVkeVV2TWQreW9vVGlkM0Zu?=
 =?utf-8?B?aG84b2FMSlpiekE2aWl2cXhPL2lxOVRFQkNaU2d6dEpqWVN4WnZMYmJDVnZw?=
 =?utf-8?B?T0dGSVc5YitHdjZldkYvTERFdHdwR0tEczJ0K1VGZmE4WnBXcXhnQ1g4MTkx?=
 =?utf-8?B?RHllMFFrTk1VZDJJaWJHQ2oyenFhQmFiU1cxekNqb1hGSEFGY3lhdklscHNF?=
 =?utf-8?B?dTIvVmZNQ080MHNnQzIrdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3edb1af-aa55-4171-21b3-08d955ec8223
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 19:34:13.4548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IB+7URzDPkYvQDXSMFKmnwvXKofpcmNalbnBfAt0xQQ6FQ+My9K0efv2PdCCgDH0N45vy2qBxRRF0p/YD/Xkxsucnq65XUE2INmJ0MZpo78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108020125
X-Proofpoint-GUID: nE5NGqwvNeZkJOsvRp2mPvf33kViiCbn
X-Proofpoint-ORIG-GUID: nE5NGqwvNeZkJOsvRp2mPvf33kViiCbn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_123428_438532_2C0B5A6A 
X-CRM114-Status: GOOD (  24.15  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/2/21 6:26 AM, Daniel Wagner wrote:
> In case the number of hardware queues changes, do the update the
> tagset and ctx to hctx first before using the mapping to recreate and
> connnect the IO queues.
> 
> Reviewed-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/fc.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 7f462af1b02a..8a903769364f 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2951,14 +2951,6 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   	if (ctrl->ctrl.queue_count == 1)
>   		return 0;
>   
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_free_io_queues;
> -
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_delete_hw_queues;
> -
>   	if (prior_ioq_cnt != nr_io_queues) {
>   		dev_info(ctrl->ctrl.device,
>   			"reconnect: revising io queue count from %d to %d\n",
> @@ -2968,6 +2960,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
>   		nvme_unfreeze(&ctrl->ctrl);
>   	}
>   
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_free_io_queues;
> +
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_delete_hw_queues;
> +
>   	return 0;
>   
>   out_delete_hw_queues:
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

-- 
Himanshu Madhani                                Oracle Linux Engineering

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
