Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774D2C77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OE6SoZHU6WSwHnyOfNavGqDy9DDf9NehLSNYyH2uW5o=; b=ZpIIFLzpTMNL05YGSqBFtb9irE
	oawdL4p1jxX679UGqekI3gzl+eY5KT86i5lGh817dh1rz8TRjFwP03hwgDHcmpRjsBpgHOdotbXAv
	old87S7EzUotuklmB0MQVHTydBXNwHJYEHuCEc91uJj20HKaFrathFJp4kF4XlTKqMPbIj8nw5CKN
	nmW6H/REqxiQUncKhNfcRwqpRAB41TJSVtA3dWFbMkhmInw9DoJCmvqarfnThWmFdRo3w6lvqZuJ3
	m3m3cL4zVAlMAuApahdSg5tcvD1In/0mh4uA22xJngGHL4BRvJRk2H4Gw5YY7FQpHfvSd3S8GPnIc
	zJnGtHvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr0Uz-00GxHP-01;
	Mon, 24 Apr 2023 18:01:13 +0000
Received: from mail-dm6nam11on20631.outbound.protection.outlook.com ([2a01:111:f400:7eaa::631] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr0Uw-00GxH4-1L
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 18:01:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4sy6ic2QgQ64kPDAjqQxdPbp9msP1CJ0oa5LHHdgxJluv6Tlo67RDZMEZja4qsFI836g3/mfdygy/PqLdqdXQB9Kdqu9n9BFvqpX+1MJVIZeqAOjC2QROY2tJ/O2dtKosLzTIzhdwjfkuzvLNLigHivnREXv42kX8VMn3cZw5wkxG7TFZmf+GS2UBv1Gk43pCwECU06i6KWt3gwrvPeS6OGq0BmLoOXPxHwGujtszT4JrY0bRiohySPuNKVXBp+QlfgJoe/gTW2u8LF/ArTwCsQWnhZTiKGalisAtPm7QTZbhHbI9E5QGXzScrxDz7mE/5Z6KEtJVerK0I/KgwmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE6SoZHU6WSwHnyOfNavGqDy9DDf9NehLSNYyH2uW5o=;
 b=JAVcm6gC9Lbj9wkI/ZGXnwCQhGnWSFcQyMmgZyWn7NIHTiaaWsP/BxIk+jDQsv9B5S2Q+DvTRrW9jBdBKdBfxQKsnJHP3iAYe98f2uovFLqm+zBp3mJzMn6WuVsk/bTPd0FiSWqAxX7gT8MCILdoL7yOEG3nB7Q5UQYGRGszm2ly3zR7aHigD05ncwaO0sVRLKQTW5n5DhsEFPXI2PAjBAy6r0np2l714JP1S4CC+ax8uVYDDpNqFxBnIE9U1NnBxy/mb40H8nq+Q0HkHb+s/r6mbPU8V/LoCqbUFDQ+p3AZFA08yX246Bd9aIiX76GJ1JDPyIp0DtVL4arg8IuROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE6SoZHU6WSwHnyOfNavGqDy9DDf9NehLSNYyH2uW5o=;
 b=Hk8PJHOAL0coWc0uDDJ/e9hEvoAyqzj2qTt/cAbOcuiicZpwZFlE3ms2ooJ3yytMKVJWprcWAeWIwC2rPuKjT3NiVtbwivJzAg3rP9cujPO8FiEASBERC5dwjnPtw7Rb2UhpK4FEPGzp+FpyBzAMzqkAGjGlXQxBOphsbp4WtGhITm72VVV1fFJ+iZ8tzxWoKox9ZIQyfsCFvuhyENAUtgOiPYy51YeKYsY+97M5CTMpQ+VYWIwbt8A8b5P9d0BnLl2suM2eTxb3yB5LsC0iC2VQ/oPnT7Bq0YVzhevivmb5kbUcZRlPWfOCy6ayOWbQUWE8meNlL8EEWbBU5XgcDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 18:01:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 18:01:06 +0000
Message-ID: <a853d387-c4b9-7be3-9cda-cfc482ae13ab@nvidia.com>
Date: Mon, 24 Apr 2023 21:00:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424141818.16173-1-mgurtovoy@nvidia.com>
 <162a487f-f651-50c8-3ddd-cbe18fb0bd89@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <162a487f-f651-50c8-3ddd-cbe18fb0bd89@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: b2ea4cc2-d02f-4618-8007-08db44ede029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	NF+NS+sRZv2JqaJDqCuXG36tDYNf/K0WCVGYTNCtY2f8y3Mx42rfxPZ28gS7AqlKM5tHvNGfS0Ss+XQxUJpJIB201D7hDX3Jn2HEq4ufrAfyRRqL6xUJezjY8Nw2hB8Q1bB44DfqcsoShOnYv2Hzl9GeCKuOFKYsB0hwOgh7Prp6cPw/sOrX8OkiLtexs0x1ERnGgpSgaMtgquYsOiXSfd0nSHGDNTzxRAFr6JPZRGnouilCZsShbUFxfifoSKxIh3E5T5hv9ff7k2BEvpsOGlBiBSLoCk+vdAt0kMHOXJV5Y9I3S7WW9egehCW1n14BW5XPBXHqec1TZFKmh25yasSjFK9sNkbLmfHK0ZqmF9I+CCAlxaPVJUvDes9d6pRSGjxqSaDgejuy5xaK7Hi0UAAWVHBlhkQ1PPDKFp4Pa2d1V9Fk4p/zElDX/fEwDQq26PYUhC++QQFVoim/cxUgIoxXlbEVH0nn/uau9QZSrBYWDNBFQ/nlT3jSZC+gjZzoPjPQw2f44v2UL1DOzQByeC8GESyQJ95m2Jk5bzE717GNm2ILdVLyDEs20hWsG3x4iA3I5juyI/OSkb/3k6uLcWCTa0DTyXaIBZ2Dk7RhBnI5v09UqySaE4CfgSFof+ogouv1LKDyj4HrGeKKu0WnmMYqrVAlaefki2Tlq6IfXTLB6uSgOcu4PtoKjpQMJEHi
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(107886003)(53546011)(6506007)(6512007)(2616005)(36756003)(186003)(38100700002)(66946007)(558084003)(478600001)(31696002)(86362001)(66556008)(66476007)(31686004)(8676002)(8936002)(5660300002)(6486002)(2906002)(41300700001)(4326008)(6666004)(316002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?c1pxSHlKUVRBdXNFMnoxWHprY0VkMlo5dFdTREFjK3NKQ2cxc2dicmZYZzJF?=
 =?utf-8?B?VDNoYlZsRExoMGFZOXYxczJPMCtpZzFPV2YrcERIYU9BaXUvYjRveXRxMW0v?=
 =?utf-8?B?em9ySDVUT0ZoYitjR0dJaVhweFhQNzAzbEQ2WDFFYmIyaFB4YndiaW8wRU1D?=
 =?utf-8?B?MUpMSDVTdUtaM1gyNzUzNVU2eDYyWml4WUR1NUloaFQwbWN1N21zVkRUMEg3?=
 =?utf-8?B?SE9CTHJoSm1tWmJrWDBuQU5OWnRQRzdSaVJ6dzNIZk1tdkQ0bTJRMm1pOFY0?=
 =?utf-8?B?R2F6V2x1dUpJVHRqNDlnaW5VdkthYzBsRDdJUDQyZmQ1V1J5bnpVR2d2ME1j?=
 =?utf-8?B?YW1FbmZYaENGOS9kTGc2NFBKcUprOEpZQ2tHYnFmL2I4d3ZwVW9JMW9vZG1k?=
 =?utf-8?B?aUh6WnZheXZBZXdKc0QvWEtRd09SZlFQenNoQUVUWTJwNFRjalVMcUUvd0d4?=
 =?utf-8?B?dG5OR1Z5MzdLUDJYbEdHeWN4bjlvNUd3K1BQeUU5MkxKOVI4VVBUd1JZaGdx?=
 =?utf-8?B?Y1lpRWprTmZOakpyNjdtWlR1WG56ZnAvYmxlMklxMk5MTUxxcjEvSFk1NXBp?=
 =?utf-8?B?a2ZEd21Gb3UyQ0x2emFOYkJpSVVPYXlYcTRjQU1yT2RodDBydWI5bjd0dFpI?=
 =?utf-8?B?eG9LWVpVaTdPYTh4LzYwVTJ3VTBSVjZYMkdldEtyL1gya1dyWDVHYUg4YkJE?=
 =?utf-8?B?a0hqNWJrdENhekhXK3IvUUFtNkwwRFdBREV1a2NqRVVRT29GTkc3NWZ3MnF3?=
 =?utf-8?B?dUc3V1BLNERyZ0FsbGV3UjQxYUh6cCs3NUpqdmsrdndoVVBZUlJreWhWaE9P?=
 =?utf-8?B?TW50Tms0aTBWdzNEaGY3TWQxNk5SV3RiTXQyOHhxN1BkdlhLSkFrWnlMVGh3?=
 =?utf-8?B?cUhWSE05VktUQWZwREZKeitKM1BJRzZVNk1HcTZSeHNGbUsrTXUwZUxOSkFX?=
 =?utf-8?B?Qm0yQ1ZvOWUvbm94WDV5eFBmRzhseEtLS1pXWnVac2FTQ1FlaDV5M3pJTkNJ?=
 =?utf-8?B?bjREaXpRTWh3UHBPRklpWC9kdmJXWDNYdXpzSk4vLzBRQzNDd0Nvd2IrOUNE?=
 =?utf-8?B?eUE5VzVCaW5kTmtMN21ackRTTUcwZVBDTjUrOS81djFVeXE2aktoblI3TEVo?=
 =?utf-8?B?ZkYrWGFkeTd2dEJGNy9GZUw2bDVIdVczZEVSNGZIRGN2dk0vdkFjb1hNMVdJ?=
 =?utf-8?B?ZU16NzBsaUxsdWlLWHFWUkp6TFlNRmlDNzFWVkV2QmlxdnI0WEhYbXhaK2xQ?=
 =?utf-8?B?ank0RnF4bU14aVEzV00zbHhmUzRodW9qaGx1SHg4U3R2MEZLcGlyMGExYTYy?=
 =?utf-8?B?Njl1Rm8xc1VJS29xdEthMFBORE5relVLYzUvNzh3Nmo2THhxcXp3UGNvQ2Rm?=
 =?utf-8?B?cjYzNGkwRWd5NENqSlVJYk02NFNtQ3RFQlJmS0YzVGtoZVNGNStIeWwzaUps?=
 =?utf-8?B?L2x2cXBaNEhRMitZQkhTU1BqbGRmN1FLU1hDaTBRVDJvWlpkMFhMb0kxR0ZY?=
 =?utf-8?B?R1JlVGNlOWtrK3lNYXNib2dpMjVPUlpEMVpQOHJZV3JUNTdkVFNsbEtndEcw?=
 =?utf-8?B?RHZUSkUzWEs1UWR5cDVab01OQm51QUVJa1ZhWSsrWC9WRlliVWxmRU1oeUlZ?=
 =?utf-8?B?blUwbzEvczJaQ3FRdHRXaU0zZW1rS2lHL2ZhQzBLQmQ4UnhHQmVoVGkyT2FO?=
 =?utf-8?B?UDM4b0syMTVyaXRSbGwwN2N4clFGS1pBOHRheksxRTZwd052QXpIQjB2MXFF?=
 =?utf-8?B?YXpNcjVBbEcrUmpXM0xrdkI0dlQrRmY0aHMvemVNT3ova0ZLb1BwYUN3N2hx?=
 =?utf-8?B?cFpCaVpRbThFMHNPSzZXODUrQ2M5emh3NnRxSmhnUkR1TmpITERtSHpwMFJx?=
 =?utf-8?B?TzlQSHJEUHY0V2ZhSmU2ZWN0aWJ5V0J3RGc0TXdJZWFPbWx6L0RqY3E1U3ZH?=
 =?utf-8?B?ODliSlJMNXRkZEJjWTROTExYWjE3cFhIVWFLbm04eWNCVW1MamNlRXR2VDBm?=
 =?utf-8?B?ZGhvTjhkeGNuNnczM2ZTeStFUzNtQzB3ZWFVcmtpQktmait6MjkxUU5mMVNu?=
 =?utf-8?B?RHJPbXZZUWM2YzBRdkV6NGI4ZmRqK1l1VzNtZndRaVFDM29pYVNvQTRmZWpZ?=
 =?utf-8?B?MXNFeWt2d29qVkc5TDcxalpDc3lqODNhQlcxWmN4SVJaWGNrZXhqWGl3Ykc1?=
 =?utf-8?B?dTRYWTcvVUZ2SlVKMXYrekgwTFNLUHdjNmJPUzFSTnBvNjlWMk96dGY1VjRq?=
 =?utf-8?B?d21XT3ZmQ2RpRndpblVKeHF1aVVRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ea4cc2-d02f-4618-8007-08db44ede029
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 18:01:06.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPHCpgQHKH3LbC/cmOkTzlVxH6fVXWQLyh3LjgWIFYkgeukkBuwSZ3VXDeCloK1hide3THJIQtyVPVMR98biLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_110110_455223_AAE0EDFF 
X-CRM114-Status: UNSURE (   6.49  )
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



On 24/04/2023 18:23, Sagi Grimberg wrote:
> I'd rephrase the title:
> "nvme: move sysfs code to a dedicated sysfs.c file"
> 
> Also add a short comment that the patch does not include any
> functional changes.

Sure. Will do.

Will wait for some more comments and reviews before sending v2.

