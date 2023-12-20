Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A060EC41535
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 00:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wKgtDuo4K64g8KjGqRWE9yfxiLByjiQiN0r54wPsLqU=; b=v93bBeEgT1NLyUEThI5bWd7UoD
	UtfpxDky/bS6HUSvl/r1TkML6+NNMfQyQGCZ0+sbaHQLND9xCPHJNwusaq1gOm98EZMHRXYDl4zNn
	5oVhHtxvlNWcsZrNUH826/lSbNEgmo0/f+E868OyJbBFooDMrashSZeUkTK+NtgUU3ho90y0KXjeE
	dYpOMt439DVJLdL4K7WoOiK5WB6cv+JWW8EJmJP6GxtdYouZlngC4BwqfLdoPrMFcyek1LtdU+lgK
	d6AxX2xltBmPg4fckuHV8I6JvJmPPIV0/tFg0c9v291tcxHzLYQn6x4assk4P09mWBJNcAyFPMIFo
	1UA7EG1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFknT-00FqFW-2e;
	Wed, 20 Dec 2023 00:50:51 +0000
Received: from mail-co1nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2416::601] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFknR-00FqFC-1C
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 00:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShrY5s2efz9TnKgOUh1KTLb/SxTUqDLSCRw8Cw0uhcltT0FvNFOdldS453MamocDj3BgFOmMctkAxfCjChcWb/cK+edB3cRk3g5IkJHUCb30fIkVjgDy8cERy9EQZFYVd9t4550qj9u8OtQM1QUT/1p5ucFDK7rWrwcUpZif9lsvpwzrlvVdHZ3WSNA7UOj41AJ1InlkSR6zi7yde/NUEvCl8U/StJ8l1dATfzTJqQo5b2Ea/Q/wdZgXP2MVxCq/qaOuK1WJ+n1m6FV8GmrXCdoxeNcUyEG2cGEbeYqjIfyiFQ2rZW1MQoayd8j+F4vQiabIh0HEolJvHhjzdY0XVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKgtDuo4K64g8KjGqRWE9yfxiLByjiQiN0r54wPsLqU=;
 b=B6aC/yqasMRIbY8Aj1YgKey1PTwZqxf0KfPFrbeDcrkQeR0QCffjwNMr3xPNPICCX0/b10elW3izijQKgIITr5UGpp1bOjxs5chPix+K0Tyx3PyLs/JQGHX1m8Br7s8cTXjxGPN3hpORps6HTMqTL6MX3VdZPya/ex63F/gzstu66TMxG8d05TSCfZ1/kmsUcm7i7VRsUQodHSGcbMqALMm0qjC2gfJG91/9g5vhS4JhIOEaJ2vEUJsCKi7EnQ5Sr4TsoAk7JmCFrfw6uIANzMhjM18+z23BwOXbDWtiScJr+txveYslLbZAMVn0eBqJDDellkNW+NsILLNcb4I8IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKgtDuo4K64g8KjGqRWE9yfxiLByjiQiN0r54wPsLqU=;
 b=iNjN6uOnMfE+6OVZyaNiPcBMSzC3CHOBe6g8gDo6/+Gp+g5B27+oaDMMGPWN9GYn6XfYmyv7xI5XhPuRXTTja5N+U/CDASjKBABz/soTVAwSqMtdk/s4PAHA/FP6UAivtV21RkwFZumIAeORYFnqLNVDqMCIx3S/WckbuKRR/gYJHHXbAqwAyDazSl4hVzEfKEaJMVg+SpBOp61CREz/4fZGuIKeA89JGShSjKHj0xwBDEHjFIX41fkh4ZHLpK/qXdNhZvfEPZCJtYuQItw/9oJNVeEBwEMtr8lv7adH+AoLcwNdaFJnuw6S65Jo4QvR2oz6I3vWNw9yna9pH8rz3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 00:50:41 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 00:50:41 +0000
Message-ID: <6a308db3-d487-413a-9ee9-9206463d6308@nvidia.com>
Date: Wed, 20 Dec 2023 02:50:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
 <20231218153105.12717-2-dwagner@suse.de> <20231219042717.GB30580@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231219042717.GB30580@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: d3eeb3f2-73b0-41d1-4605-08dc00f5b090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WpUgH6thdFD2VamTfPKftFlj+IUn8cbV/055MjEohR4B6kJcd2Rd/GiZqtAAvxZfQMJjTuvvt87NeORWtH0tfn3HYxtWTnmCcCbcARCV03kzB43NoxIz15KAY5h+py1+/s4Wk3bNZp922rEoOW9NXxeNV610M1cg21y4EybAaY+KaJIH/hkaHIDBiIAoj+1OTU6WU4r8Zt64KL73mTn6/TpuxakahRyZXiEY+gWHw7BiNMSXK18avwev/dBbd3eAA4a3rM/z1Dqh76fUyaLiyVu5X9GJUS7scUzu66lfWLRuuMpq2W2USXEuR0RngxBgV9eJq5LFOG0uZuU/qcNJGgPV+cizp3IYOsJtZCOecWQgXEI9wiPJTgXYidAfNAeN36dXIeXFXpcEWa+6M6bXdHCFaY4VYZTbmQ4uuiE9foI3GVao/9pqSKLJ+Dx04ikEPfiSaMiX/t9CkkI8BKu7tNeyMzkz+cuyj9dnbMwSas+M07+mdUPBkjGleLRcCpmkyZnJvZFl9d1jIUwgdFgz8d7Ennmydqq+WZuHDBbkYHww1N74+1d6jsQZX0OHwkZopHnmS28dC/wV6r0Y52goJswZs85vMFyI/pnayAnaSPOGHToQgBDusjBnIZHMGN89LlnNtEnLQgsEogZnUfva1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(110136005)(31686004)(4744005)(2906002)(5660300002)(4326008)(8936002)(8676002)(66476007)(66946007)(66556008)(6512007)(6506007)(6666004)(316002)(54906003)(86362001)(478600001)(31696002)(6486002)(83380400001)(53546011)(26005)(2616005)(41300700001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vk5PMUxwd0hDa3ZwcWx1OFh0WlBZQnR3VlpYMHY0R2YydFBHR3F4dWp3RzFm?=
 =?utf-8?B?UU8raXcyQUFyWHpVY1lLTWl5ekVlbGcvMzNtbk1UOGRWM29ncFY4UThLdEc1?=
 =?utf-8?B?Zk5MRXhqVHZtK1FuL3E0MTFRdlFxdU5nNTNwamV5UjMyNkUwZXRkeGNXNDBt?=
 =?utf-8?B?MEc3SjlKRWxpZlFyWVZkNHBRTmJKU3RjMzVjSEdJUndkeVhoSHdFZDd3NXpF?=
 =?utf-8?B?WlVVMVhOb3pvZng3UG50dFR5b0hxT0NnbDdrRUtBY1dwbVo1YTlJYlRNbmlS?=
 =?utf-8?B?VFA2Q3FzYXkyc1ppSHlVbExORDhjV0Q5TFFCMmp1cmtjUFZwanVNRTVKYUho?=
 =?utf-8?B?SEZnek9nMXRnK2tpbUpaQTYzSU41aGUzelc1Smc4WDQvQjh6V1dRemczVnQz?=
 =?utf-8?B?Q3EyYVJ4NTJUNTZIWW5hb205VDc0Wmx2QUE1elNuSC9ZNUpJYXlYbFhMV3dG?=
 =?utf-8?B?ejR0cjV0dVZCZVFNb3RydDZjVTRPcGlhSFoyWTYxdWxjYmVDRC9qY1pBQU9u?=
 =?utf-8?B?SGowSzJKZ2grUk5hY3MwNzN5aGdTV3ZIdWt4NVJ5RnVHdUFmRDFRTnVNU0hz?=
 =?utf-8?B?MHNOMG56bHRWTTk2OE93YUhDUUV4R1JiLzlyWnlqbnJhVUxhS08wRkNsbWNj?=
 =?utf-8?B?QkNlK29aNEQ1dnByOVk1UERuMmJhM2c2a1NqZ3gwTlFLbDhadFVESkpDbWs0?=
 =?utf-8?B?bTltSGU4bUpLbGN0eGtQZXBnbFJvbmEwc25rN2Ruc2Jrek5Ccmd1Q1JnTTBI?=
 =?utf-8?B?dW9NbHBWMWY5L1Q3MFVWVFkxejJXOGZBZkhISEN1aW90NWlVZjZYVGkzd1Qz?=
 =?utf-8?B?MEVNU2E0RlZSWUJqUGdONkdMSld3UW1JMSszMU5xQmh4aGFXY2VoQjRwaUpW?=
 =?utf-8?B?dFQ2NEc3czhiVjgzclVGRmM2ckU2TW9xVE9pRlZTamo1djlGdTB6cGZFdUpm?=
 =?utf-8?B?Wnd2WlRDN05JQ1NwRm9EbDQ1ZU5pYWsxYmtEVTRKekt2Mkx2cHF5QkVDOUl4?=
 =?utf-8?B?MFpYanNmSWRTZ2JUNGVvcnR0TjZQQjZ2S295Zk0rTzVueGVwK0l1YlBRcWcy?=
 =?utf-8?B?MXFJMlNGdVJPakZ6cHU1bzZ6NFMra1B1cm9ycTJoZEhwTURaTEhjYWxoeE5O?=
 =?utf-8?B?Z0FxNDdQZ3RIaUdnUUxCazFZTko5bnJQdHZZUEFSdSt4OWpXamdYUzJ2bVJB?=
 =?utf-8?B?S3pxcHYxL3h0cE1GQkRMc3NnbDB3SHFPVG9pZXBteTFsQmFwVVhPU3ZwcU9C?=
 =?utf-8?B?eFJjUEZQelRjajBoZnhJbG5oQnhYNGJoYVZlZkhvb1hHcng5UGx2VDRQZFgr?=
 =?utf-8?B?eFI3YkdPVmlKMERNRTh1WnpUSUxuQmZoTVlyR1R3TkFoL1RwOWhwRzNpVEJN?=
 =?utf-8?B?Tnc0NHVBdUxjSVFlbUU5UDZESjJkNXVaeDJGNE5JaEVvYlI5TDlRa2Q0STc0?=
 =?utf-8?B?andqdjZqMmhEYjFlTHdSMGxJOW5HRzVISzM3T0FJZFhlSXVHSVV3TGIzTEcr?=
 =?utf-8?B?NVhIOHBHWjhpTFowNmdsR1dteDNtanp1SmhkNHpYMm4vNWtXNkozZk4vV3di?=
 =?utf-8?B?b21ndVBGNkNQaDJRUnJBZzlFNE9KckF6R1lqMkVxWUFyb3ZZRHhUTnUxT1JZ?=
 =?utf-8?B?NHF4M3ZjdTV3Ri92MnJQL3NPb1dMdUFaOUZJTW9aZk5vellUSkdiYnBNeVhI?=
 =?utf-8?B?V3NpZEpYd3RMVUxMWDdlc0I5dEplZHVPRUNna2kyY3VWZkNmVUh0WTlvcTJT?=
 =?utf-8?B?MDVzUVZWUHNoRkgzdXhJVXB1NU1iaXh5N2JSNmU0UkN0TVFCbVJ1bjUzOFF5?=
 =?utf-8?B?a2IvYWlDYzZyNG54bS9rUFNyNnpxQ2ZPSDRQK2ZPRjIrS3F0YzFiS0hlV0Vx?=
 =?utf-8?B?Z1YyUWhCQnRlc1BnNndreWhDLzdSdklsUk0vd1JuVFQwVThVNHpwRTdmNUpu?=
 =?utf-8?B?elpLd3lHTVFlWE1HRnVaM21LYlI4OEkzVDRUL3Z4RjA2R2NTeXRWTU5iTndu?=
 =?utf-8?B?WjFKZVJja21GS0UwRWFsWHZhMWEvUmFTcTZlL3BYNU45MWJyVkpwaSt1MzlQ?=
 =?utf-8?B?K3dUMXl1Mi92bk9JZDJwaEI3eTJyZU5pejdZNWtsalcySDFXWW5ackRTS3B3?=
 =?utf-8?B?RTNOSFJUeDkxbXAybU1GajBoOStFRTZ6Q05Fc3VvNkdwT2lvZkxyYUcwVlBn?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eeb3f2-73b0-41d1-4605-08dc00f5b090
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 00:50:41.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9cikHssyZu7Mj8jQ9iugsnXRnlf6uNWKx/VXkSqr+mKtkGPDlUCHe1IYeaK0VX3PeHm4V+nuHHcl1i6OphOLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_165049_435270_2A2FEF89 
X-CRM114-Status: GOOD (  13.10  )
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



On 19/12/2023 6:27, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 04:30:49PM +0100, Daniel Wagner wrote:
>> +	/*
>> +	 * Max command capsule size is sqe + in-capsule data size.
>> +	 * Disable in-capsule data for Metadata capable controllers.
> 
> A why on the disable would be useful here - the fact that it is disabled
> is pretty obvious from the code.
> 

We have another thread on this patch that I think is wrong since the 
discovery controller shouldn't set these values according to the spec. 
It is explicitly say that ioccsz and iorcsz are reserved for discovery 
controllers.

I've sent a proposal to fix the initiator/host code.

