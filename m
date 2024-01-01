Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EE3C4706F
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auHX0OR9LnspTqWSSud/vqqy0l7DEcnti1L++jeSS7s=; b=nRB9pv/tBWTkVTzV1GcP2jMvAz
	2Ktr1tVoZX47y19CxwlURzAugoFXX9fs481SY4ynI3ml5Wedvsocj/MQGhocJh58/K48z63AJq2XZ
	wRlH7gToIflyUmPdiyydzxLaskOrvfFpOXQg9vXpgNWMBV5/tieTjeOFhaDnFy0UmAtsJlaP4YDcO
	S5Dk0WDQLXHrAWkp9kr+bmC89zhT5c7CyqWJYecIUDr0tv/rI2mCQCEIW+gbCoUytEcMmTuoXiTNU
	xIpvPKmwKU/W/R+fn2LNQfdLsb1MtXeZ6/XjiwhYWhgwrcDvAN5vwhjBiXdomqtuIS1y3vPYjdgqY
	W9A7YjTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKF32-005rwd-0i;
	Mon, 01 Jan 2024 09:57:28 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKF2z-005rwF-1Z
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:57:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6mYoBL8E+CCiUG91LaJoBhTweD6u6jJfAZYKWYOK+vHjuQn7wBCFrx8xUUWnZSfMNI+/i+h6jxcc7DsUBqqMWsMRXAT9tFQQ5JNsFloKXgFCT7nMGaJBFRIYmjBV8l0gvIwq9HxJe/4+i6HoX3bThEbbBqWwmm4PNnsR+8xJRBSzburdjkToxRceoEvSoc+KoApLwZwScEVKr1pgc3FXARcgMcpktKoPomQTl6Xuv+C0ql+1+DJryKbiZwRPSJXvZ5dJGNlhKwye7jmEgLyNNBhszzF2LN86d13at8uPTaDq173/snnE9jpcHUhdwyw590V31+9FFVd1zpqPdcTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auHX0OR9LnspTqWSSud/vqqy0l7DEcnti1L++jeSS7s=;
 b=ZuarOip9bJYDvYc7eGVYUIWz29o9fsa0SsZgNbxokmV3RbOzcbihPcF4OYSj4ZH1jPT7ELAThh6T6JXPIjlWNw4CmmSJnI88/nzLiHW+tc5H3Xgy84+xXIYEIU3G70cTRM4QWtYL/qdYRXYQHgKH20PqLKTvnKf+OwBTPeAgFWp1wTEY6XXNJWxB4GvqfJJ5hW8Vm0SFxn8DZZcIAjxQxQGHc+b0n88cBef5y5PhQw710sWfcoHXXmqdAiHKABPjiT+I7Ja1IF0wvKymNtg4ouSLyMJHXP7z2ifTbDHDaU/F6m2gUb1H4K45cZaHWcb2pvs980REe5Kiy/4zJ9dDqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auHX0OR9LnspTqWSSud/vqqy0l7DEcnti1L++jeSS7s=;
 b=kVea5NtJpRmnUqQ4dyT0hyzIp1e9dLX36LPpewWemhF93SiTmZOOgdLkNfsZV41ZpK1MlmN5Spo4xtNNsNwQrW52jmhvArVwXpijZeb2mAlAQ3S+UBL+3nCZiDU2/ikawD8lIEQMadFdeTMl8+6yfH9m3hbZRjLdSJUDbaelITrAtqhNF/W/T8pyqdQGfZxWML3RtFdd0ItFBTBSzUaoNEo+vA1o33kpm0uTrWxK1KObz+MfG8ShOZPdJM9mlT9Btu8b2ovRa6LQ/W1y6pkJ2V90XFZinSRRZda3zZj68vNghCK7mDLobbC/wBfAiOnZHCRWGIVRB4fx3HHfRkrbEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 09:57:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 09:57:17 +0000
Message-ID: <9e0aed28-2fc5-43cc-be4f-8aa6966919a9@nvidia.com>
Date: Mon, 1 Jan 2024 11:57:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] nvme: remove unused definition
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-2-mgurtovoy@nvidia.com>
 <e638a73c-9808-4e3c-a280-cb6fdc1d9f4e@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <e638a73c-9808-4e3c-a280-cb6fdc1d9f4e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0329.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::29) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 8967d53b-b210-49e4-d872-08dc0ab00967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0wHepasTcyA+foLbiUHG1WWuId3DKmy5WLUEBxJkoefBkWk3lnd1dfTDxFXa3/ykfRmUgdrUgXwWbzPjJyH9mjrJFP45HZABKS2UJeXvXWUX29lAqYnFXE13N/IuCMj4oDqUEYsRk8MzgIG1Khs7TNZ17Pter2wc4AwkIP8vTGCdHyzECseSwLilNoIsUhadCNXu4Q6VVKu8NMsNwptVm4b6tABWab5WRjCLqNQ+Ry/ih93VL/IS0yt5HvPbw0oCkAWkISi/jRRuVuXllU70JCjLy307IR6Mh0yjv8MIksQVwFrU3IyTdz9rkzrjeeJKCM4ysmxCLJJ7s2k7DJI/HGS2HKso4e4KQ1j63bEsR4lDFIXg/Vqqpzh0Vpsr4AMoDQ5SAdLYGy6iaYYpzdJMpOhabCYnWpLWjKKqXaNDVkhNCDyE7gLLYfGUTtNeXJVfkRL/z7oCgwNDwoPKxoKCeYjLve3VNJcUJ2hZ4XM7B1XADrrGlPGF3sXdHHMlNI/SZ03QSuOr9ZxWHtmbHbp8R0wv1J79+tiXC6wTfDkzeFA/z1QL1tLlBXlkeIKhrtWcf36g+sC66+qWjmSOlkIssRD8tI4omMOVqf8EDu/gG/pnxmRZXggOFkvUHHawt979O1k/arEhhmGqaCYFfcCnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66556008)(66946007)(26005)(66476007)(8676002)(8936002)(2616005)(107886003)(316002)(478600001)(31696002)(86362001)(2906002)(41300700001)(5660300002)(36756003)(6666004)(6486002)(558084003)(38100700002)(31686004)(53546011)(4326008)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3lwMjJ2N1lnT2VCelhFd09maTBhQnFvSEdtZWR6YkFIOGVSQ3AwM01iOENM?=
 =?utf-8?B?Q0tmMDlGYnQ3ZW5NeFEyN3VzNUt0WHgyeHZBOEY0ZkZCL2ZGbXN3ZldLUks3?=
 =?utf-8?B?aWdCU0Z6RE9kcHhVaDd2S2VqeXE0eVdxSkUyTjMxMU5PbnBOM0hsczFpWWVq?=
 =?utf-8?B?R2c0Q2tCSGowNHo2MWZZL0tTenN0VzErd24vcFBiSXNhVHJUQ3luQzZtVTds?=
 =?utf-8?B?VjM2WWhBSkNZVUMzdzJBaHlnTENWa2hNMitxbEI5M3dFS3NUZCtER1FhSWdq?=
 =?utf-8?B?WFU4VDkxMTViU2FiR0t1RUVuTWlOa1l5cm05S2FKMjAzSGZlNGVUdTM2Ukd4?=
 =?utf-8?B?K2pYUWhqL3VhYlVRZlh1YVZtM085cWNueVAwOEUvMVp5djBNWGk0MENwZW9B?=
 =?utf-8?B?VjdLUDdUdTB4eXVNa0NLclp3MlJYOFAzNkd6YWFDSnZjQW16UnU0U2NDLzVr?=
 =?utf-8?B?Z2pXZWdOaG1RZzNFL1FnSTVKbnhnLzdtOGh6K0JwelVnUmRMMTd3YlZvaVVy?=
 =?utf-8?B?ZXdIVHFycmcycjVqWURianBEVWcxSlhUYUdacklqVUVKNk0rZVViT2VNc1py?=
 =?utf-8?B?UTlTVlJZc2J0L1psYnJxWVhCRVc3aEVhVk1yQlA3SVpYYVhncmQ0cFkzdW5t?=
 =?utf-8?B?dlJuTTk0RG1JZThEanZFTUhib1Vma1JnWGY1UHVlNVVCcTZ3WkY4YXlLZklH?=
 =?utf-8?B?MzY2K0ltc2lDSi9VOGRQY285WEo4MXdOYk8yRUg3UmVDcnFFbDRjUjExNUM5?=
 =?utf-8?B?S1ltb1N0YkdQbVBUM0VrbFRvUHU5Z3NFMTlDZm5KZFZtazlXdWZQVTloSitr?=
 =?utf-8?B?VGViNEdUM0NKY2VYai9JVmVKSFU1eXZFTVFMSmo1Z0loMVRUelFOQXdSRjZH?=
 =?utf-8?B?SmFEMmNvZmN4OTZGOG9xanFVWEdLSEx0TU9ERWtIZitGSmFUZEpiM0wzOHVJ?=
 =?utf-8?B?K09pdlM4QnhlSEp1aG1iOWxWMkJVYzNtVUdUSUZ4bTFrenRnZHltZVNUOUxI?=
 =?utf-8?B?YWNQemZOMk5qcjJpNjZFYXNLN0IyN29JcmppUCtkblQ4bFluazVMbFRUWWNO?=
 =?utf-8?B?ODRFSTdCSzJyUitqM2J1OW5zTmV0YXpqVzRCMEZiUjJTU2lUd0lYWlM2REcw?=
 =?utf-8?B?V0ZYaWw1SW9tUjF1N05pdVBJK0pyUVdrTjVXeng4ckVyd3Y4NnFwdlArTU9W?=
 =?utf-8?B?WEcwZXRvRDkrNXZrMUljTGdqbnJYZlhLNzJNZHRNUUtiOGxpK1p0bjArbFNC?=
 =?utf-8?B?cEVTNnpiQStRaGhtaWl2anVFOTJjSGQvYlFYUkR5VEpmbWdKTlFhZjVLOEZJ?=
 =?utf-8?B?d3ZMMmZSc2RxVUlRTStzYjZPemdCUlhUVUlCRStBSWFBSTF0MlRZWFhnTlpE?=
 =?utf-8?B?YlM4cmNGaVJEU0hCZCtqbFdPcEt1ZlltcnlUSVZXM0V6aUJ1T1g0dzUwL1Ex?=
 =?utf-8?B?eXlNRFUvSVB4Q2hwa25JSVYyMnRXWE1GMEVyMitvMU05L3lJZVZEZlpLUGR0?=
 =?utf-8?B?MmFSMGZaRE4xSFYrRGpjRkFGYlE1dmc4SXFFVW1lNWhLTENHQnJoRVZkWnZH?=
 =?utf-8?B?dXFUbzhrMHZadm9rSnk3TjBBK00rcUswN1lnSVJPdmMxMVZaNFBGU1VVKy94?=
 =?utf-8?B?b0lxOEl1M0RmL3pMbCtZeVJzSDIvOXdzMloxYWpQZ3dqdVZ6Ym9VNnpsNGdx?=
 =?utf-8?B?a200dkFXRWZueTRFT3NEUVdwOXEyZk5nQ21yeEdoTTBEcFFxODg3UWJ0ZFkv?=
 =?utf-8?B?RkxhMHFPTTVaeFJRcXd4TFZIZ0xPWDNjWUxMVkJlYnlyTEQreVBWdGtGTmJI?=
 =?utf-8?B?ODdNejFvNldOZ1ozVEd0b1gydnZnRXg5ZlowS2ZUbU9pM1hwVDRDSkkvQ1Bs?=
 =?utf-8?B?bHE5cmV5KzdUK0Y4QzRvQ0NjVFUwMkJ4dVRUaHRTVDUwbkVVWjdaQUxCS25p?=
 =?utf-8?B?MGt1UHZlenBEOUlhakVLMUpDUHlHVDJ3dGZjM2tjWVpjcnVaZUgyUnFhWnhV?=
 =?utf-8?B?TmQwR2VnWTdMa1ViTWkxQkhLa0lLRGxYR3JkeGpTby9KQkRMTitIOUViYmxs?=
 =?utf-8?B?Nk5idzQ1NklBQXNBQ0ZZMEtIU0pIUVRyZU9YSFlHdG5lbXdaUTdYcWJnc2pE?=
 =?utf-8?Q?3QM6pp5+SYboQax5eu+hiM6wn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8967d53b-b210-49e4-d872-08dc0ab00967
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 09:57:17.0562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNZQ+v+oJaL19qgeYz70PygvbJLWBTWh+80steVtIKXcKj8TuOOEJsrTLYqNEQrf/EcK21IKwNzKrsSmXfIV6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_015725_588503_7C0008D7 
X-CRM114-Status: UNSURE (   5.12  )
X-CRM114-Notice: Please train this message.
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



On 01/01/2024 11:25, Sagi Grimberg wrote:
> Can you separate this unrelated patch out of the patchset?

sure.


