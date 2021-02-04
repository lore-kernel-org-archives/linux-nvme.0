Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D83C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:33:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD9F64E27
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 15:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD9F64E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KTLh/UmpATmAF0MZwcwp6MfUWXlkGrHIzlv7+Jun/gE=; b=B0nQ0pTch4YQxQsWUy7VKD+9t
	C4nEHHO8OULb5Ph00w9UOp0BzXCmBuOaGKn0dEwAx58ivhumtj+JLr5SaaTulffUp2WMB4cBMCPNJ
	tgyFPOz6lzIx7Dlofowr/o2MWY15ryZfQRDLaAR8G5nyKkHzrqK6WT7Uk+K3sMrQ6pHp5jJXNkdSO
	dPkFmzNMdOeml7JJ/mEYLOpPeiqP7RF/4pG5IjpjOWR+nU/5rWFX+3xB76okL5vO9laPi+4hONxqK
	HTwAlW5dm/aQ5Y/drmjylyReln7eoyYDQO8udX6AEFY0IRZsVuWacP4r6r0cyFzy66Yoh45Cvw1I3
	DHS58tzPA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7gdZ-0003oM-8C; Thu, 04 Feb 2021 15:33:41 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7gdX-0003nY-3Y
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 15:33:40 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 114FRQwA022830;
 Thu, 4 Feb 2021 07:32:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=41XEMB1+v6Ykf4NS0yOU81phkfXRmBSvavSB3IMQFcs=;
 b=OdgWDppMhId8GkGeGCq7tSjVj/TpYxEOXawKrWaOdravPjJ+O7j/2QYABaiuokOmGsEv
 hWEti96q6tFtFG+vQnTzoQLztEpbGHf7CLvPpwHXyGMSOUEkDbxJziee2XSu+qB5l+Gl
 Vl5U0XLlRN/fU0DfNB1GHe9agdKOAYtB06w= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by m0001303.ppops.net with ESMTP id 36f3ej6qfk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 04 Feb 2021 07:32:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 4 Feb 2021 07:32:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvOdmFpe4ofDeo2l+W7fuwWAyKaHrfMQyYo2ByPRl9hQhPvd2IM4vilVB94dcGyMwcMgHql8cZoQx8VrDWcnZqyf5FKZoxkMthrK4sSxMNcjeP3zj8CQeuYKJVe5XXK+wi9x9KAo4BxLkSnO3B2Avh73aub0WBI29EISQUnSzRp1ZT6gmItbzSZn6RPumJJ6U+DLhvvSHKGfpSs9vVRkP6KWB93RVi1BmMNmuI+JvBJOHbleRuuGwnsX40lqJUwis6UNVzrVMhTSYXMO53tRL+7MrdezRJLIXmIQhLTdylKIXisV0aKrfiUu8O3iYsmlQICm1jrsLpAgGTco3E4HPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41XEMB1+v6Ykf4NS0yOU81phkfXRmBSvavSB3IMQFcs=;
 b=RzL1zUfZsJXe7DsnFJ7iXJJ+lR58AvI/yFDEykT/42/R4740u3DSjcblYZ0N/HbYarDOTTNmT01paGeNmm8M/a2FFzmor3DPrb37iNIO8rbCLILNZVkpLNAmuwbptXHMwt3wx2g0V5dA/gtSyg/z/tVm7n8DvZj/fcElARojIxbfHjuAAw/ngYkypmMvVrlsNaL6we+3oFL7ROPwiLG7qtQsg1PIDtWcLbg/uFOLkArGI+Qp2CQ9DSH08JsBegHGJz+viNMyCOojje1THsS8yWAt939PKmQ1lKm4cwubmRTWragqbrOflOQiKVGBNK3R86Dumc/+inTh7jij8DSM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41XEMB1+v6Ykf4NS0yOU81phkfXRmBSvavSB3IMQFcs=;
 b=QbKDZ3W/8geHDNH7S5+mrxBxyKT4GRG4FKgxqMhExlP5yrJXcdYb+wyQGH6q6EoWQ6xUGPdpVWcPVzMJZYN1KI66aIp7TtkoRNPC3L2CwlYj3vBeb01IeNuC1gPaxB9DV+m6qjfbFk7JqBN1f7SjZpQOvhL5yHpIiu42ORipWKw=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB2566.namprd15.prod.outlook.com (2603:10b6:a03:150::24)
 by BYAPR15MB3253.namprd15.prod.outlook.com (2603:10b6:a03:104::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 4 Feb
 2021 15:32:21 +0000
Received: from BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb]) by BYAPR15MB2566.namprd15.prod.outlook.com
 ([fe80::684b:6f93:49d2:73eb%6]) with mapi id 15.20.3784.023; Thu, 4 Feb 2021
 15:32:21 +0000
Subject: Re: [PATCH v5 1/3] blk-mq: introduce blk_mq_set_request_complete
To: Christoph Hellwig <hch@lst.de>
References: <20210201034940.18891-1-lengchao@huawei.com>
 <20210201034940.18891-2-lengchao@huawei.com>
 <3b75b43c-638b-b5ac-eb5e-e37314d25ce1@fb.com> <20210204153014.GA29736@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <70bdb0b1-c7aa-af25-4b28-f8f6675c73ae@fb.com>
Date: Thu, 4 Feb 2021 08:32:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210204153014.GA29736@lst.de>
Content-Language: en-US
X-Originating-IP: [65.144.74.34]
X-ClientProxiedBy: CH0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:610:b3::8) To BYAPR15MB2566.namprd15.prod.outlook.com
 (2603:10b6:a03:150::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.30] (65.144.74.34) by
 CH0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:610:b3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.21 via Frontend Transport; Thu, 4 Feb 2021 15:32:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 170824cc-7fe9-4367-c46a-08d8c9221009
X-MS-TrafficTypeDiagnostic: BYAPR15MB3253:
X-Microsoft-Antispam-PRVS: <BYAPR15MB32538446B585A8F0BCF61B50C0B39@BYAPR15MB3253.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YVGTn7ID5QV6qgO12r1OMlORF+1wEzXTcj/1ewnpFHZcawlfwRISTFKoNlKFw/+ZqmFqwE4jLawmVlPwqW2rXBMqr5d36KOvYqvGjIEFZAONSC5gai+U+x1EqD6XbFOpB+5y6ag92AVSeH4GIBMkbjLlsrraWkFj0OnIbGEZdWqbjvMfmtIS7pa4HL3RC1IAS7H+4Ff+FC2eGwCs+Dwqb57Pq0yiwMXDb+J0WhIlZpOh1US0fn+0grSTEwatuuDtZOuRJDsp70rE8Gsj5UzW/rt/xL0DPhV5+eQ6nJDOdfeobGCWYhrogR5wgRa7RiH4Sl+dcS2h8/B9sOD092B8kC64tRdKVoc2kmmBd2rn9PG2hardqOAmBG3nMzpZGOu8V2PFGpG/2b955Kv1yJ+0xaPj+nVSqp/vc5kZUO4uS2YrP2sNyWsm+WQuC0VF5jysQGhSpJ2FxtbM2sGLCqVlgx7o47YKpS76fszQK7q8ioU/8iCho5yLqCTPnQkDzWho+RGblGaaFLkjA0dgpjRH5U5JoV8XINqTlV2opWt/zyfNe9yj2iTEPnjxEkKPDq2i6ROHflXnzNd+e9iAIFpZt9is+J/0/KqxQUaY6WXMr7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR15MB2566.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(346002)(136003)(376002)(366004)(396003)(53546011)(2616005)(956004)(316002)(31696002)(2906002)(186003)(478600001)(6486002)(8676002)(16526019)(86362001)(8936002)(5660300002)(16576012)(6916009)(4326008)(36756003)(4744005)(52116002)(83380400001)(66946007)(66556008)(26005)(31686004)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U2NjTTQzM0J5R3VxYmY2WkJFdCtZamhWOWpJZ1NJekVIQ2dqdFRrK0JsN0VD?=
 =?utf-8?B?M09tS1A5TEUwem1LeWpHMmwybW5ySTZuVzJUU0c2YnY4R2dSVGFBb0JTRU9x?=
 =?utf-8?B?SDVacU91RzVwY3RvLytQT00wcncxdjIxWEpmSzBXZ0RVeWpSQjFnSWFiZzNG?=
 =?utf-8?B?c1NscnZzYkhvMXgzNUljVkhkcWljdXdvM1FJa2VjeDVXRTRHMDJ1Y3pYSjVD?=
 =?utf-8?B?RlMwN1g1ODAwYlBaRG9PeGUrL3FuQ3kwaEFPVmtIZzhtS29GNVpWbHZKTjVo?=
 =?utf-8?B?MUM2VUlNbVdDNmFwUCtGL1EyNVdGY3drWUNFbllFRVQvZWhZUFZCQUQ4ejNV?=
 =?utf-8?B?blUwQThaQWVreVhQMUR6bGVwQWxxcTlSSG9jbnhHQ1oyRzltaXhSVERtcmFr?=
 =?utf-8?B?WURZU2NLZzhiVWs4eXh4ZzVueEFSOXdncmJRaGZXb1VvZks5MWpUamRrY0Vk?=
 =?utf-8?B?R2NmRGZLekViMGpwRUhMSjU3VmdDNllKZEt5V2FzQ0JoZ1dwZ1FiSlZySFhV?=
 =?utf-8?B?aFJyTk5mN2pKNWhPWnVnc3hXdmN6dC9zcW1CZG8xazJxYUVqZ0pQTFlJUkpW?=
 =?utf-8?B?dDVUSkJQYU5CbzVEMjVabjRjcCtYbGFEWU1iOENMWnpEY3ZRTXF0dFVobFAw?=
 =?utf-8?B?c24wMUVnamNvckpFaHh2RXBtN1RsYjZrOHc2eStGc1AxYXIzR29qZUgyWnl1?=
 =?utf-8?B?N2ZxVUJPZHFCM0J5RDFMZ09XNlgrdUlicEJWMnkvNmNNcWNsRXgwbUtZMXBU?=
 =?utf-8?B?NHZmZmpoT2JVT2U1ZG1ac2ZUUEt1SDhCTFFjanZaOENCbGYwSmlodXRZc3Nu?=
 =?utf-8?B?dGZtbFFoeStRZWllWnhXYW5oYUZHZnYxVFVTQ0pWQzVFYlY3N2JsNHZ6Ly9o?=
 =?utf-8?B?M00vSloxUTcycHJ6bVVFWUN6YWRUSU1GWUYwMnRTcWhDUTJQUTdDeHF2d0pw?=
 =?utf-8?B?a3JNYXA3UlB1Z1Z5VUpzOHpMeDZ2STEzbzNEZHhDNzdTTWFtUGFNQTR0a2Zl?=
 =?utf-8?B?NWlaSnNBYzFybllrWXVTYUczcHlkaGNIQmFZSi9jTDZ0U3laamFmc0NsUUdm?=
 =?utf-8?B?R21yY0J4bkhxdExLQm1maG54NnZSSUlSaEdjWFg5QXhZOXRBT1p6bm1HSFpC?=
 =?utf-8?B?WUFTSEtFZnMzSWFjSkQrbG1JM1pVc1puR2FiaXFmYTg3UHJMSU8ydDdtTFNi?=
 =?utf-8?B?V08xcDhiTkZVNUVEcUJzQXc3cFFzQSt0MXZzZnFUUWQyM2g1YitWK0VCb3NG?=
 =?utf-8?B?RWdkS1lLbzZKYVVYb3lVZGt2NVdiVUZ1ZUVGTW5JdnduWnh3OFBhenRuQU53?=
 =?utf-8?B?WEY2NGM1emZ4R1FlUTNpbytsTGhsdXEzR3NKUnAwbGljRnZzanc0bSt6bmZp?=
 =?utf-8?B?dnpqcHZjZzhJU0Qya1RJTGFubVNOSzN1UjFBQ3hNNzArVE5VbDFzOG96TjAz?=
 =?utf-8?Q?nVDGCyfP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 170824cc-7fe9-4367-c46a-08d8c9221009
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2566.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2021 15:32:21.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAC/O3LhOwbnuRAbh3J8syPHb/WlWB2brD3dgvVM6lNs9JwjhVy7pTU30zdgtsDe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3253
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-04_08:2021-02-04,
 2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102040100
X-FB-Internal: deliver
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_103339_275773_D5BB1D09 
X-CRM114-Status: GOOD (  19.93  )
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>,
 kbusch@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/4/21 8:30 AM, Christoph Hellwig wrote:
> On Thu, Feb 04, 2021 at 08:27:46AM -0700, Jens Axboe wrote:
>> On 1/31/21 8:49 PM, Chao Leng wrote:
>>> nvme drivers need to set the state of request to MQ_RQ_COMPLETE when
>>> directly complete request in queue_rq.
>>> So add blk_mq_set_request_complete.
>>
>> This is a bit iffy, but looks ok for the intended use case. We just have
>> to be careful NOT to add frivolous users of it...
> 
> Yes, that is my main issue with it.  The current use case looks fine,
> but I suspect every time someone else uses it it's probly going to be
> as misuse.  I've applied this to nvme-5.12 with the rest of the patches,
> it should be on its way to you soon.

Might benefit from a big fat comment on why you probably shouldn't
be using it...

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
