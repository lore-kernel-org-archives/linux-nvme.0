Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240DFEB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 08:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zXKlgw/qS9o4prODqRIr4gYoDwGoS5nS6e4y6EX7htw=; b=3jdqaxHqhqnCGWkMmaxWNUCQJ9
	GyEeQ6akZ9XF456MPZEjuOfoSlTs4t2U1QgZc5/dd6Hg46BdhuTsPT+tnCT0lFtani7qOkGCvn94s
	NW937UlEBldkvzUlhEqk5xBb+GwRpgvsTp50KbfF/nqVfOIvV7gzVMQCCcHWUMG1RozaQtDvBn1yW
	cY6MaQOkAvfCN24f6aVqFT/2o48dK/mkgbEGX2fNBow4zYkcRyWc6alsv0ffc8oPlIV7LlafviHXQ
	2np0qAPDQZxv4knd3JMKCvbG6zEzbkmGT2ZPnGBD6P6VG9gxRhwa3JpF1e0Ce3IEKG2alUEg6Q+VD
	mNQK0IGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEQFi-00F8DT-1p;
	Wed, 28 Jun 2023 08:10:14 +0000
Received: from mail-bn8nam12on2061c.outbound.protection.outlook.com ([2a01:111:f400:fe5b::61c] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEQFg-00F8D4-0m
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 08:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIBiccq4IhriUZiSBtrfJNcu/2rDTyJkNTLr/kfxIm4WF9YrKAzY5BrE2js/GgRrKXDVH6doOArAt9E7NwHvgAbH/oyxUgc9k2hS3a3Vvl1/GsiwZpIsXuQx4VEbhjMF1C9q2OT1wX8RN+hzn/inRZCSFfCaXrohoFD9BaJYxspP1+eKSnKCxB5MvmfPg7JVZmqKhW17P84jTRCDRFUyg0S9NPYucv1EHj77oLsD3ILo3O6pSqUp6Dg/5scnu/DnXtGDfsss6pf5L+TDhbTWZuRWPV6/dzgsvjpTdsPyti6AIPDrcqgdbgwKIm4VSocvu6B3S+CjUnKsCmSk7i14Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXKlgw/qS9o4prODqRIr4gYoDwGoS5nS6e4y6EX7htw=;
 b=JuzKftO8AFOTcYb/lX5UBI5l6C1IOVaGHm3dNjqbnAzxaEPbYflZkh91WcwbMVZclpeaR+iEH6gKCfyyOEF+FNgowRk9QEonjLptT63sND7DklCYkt/hhDUvRydl2Klf/cXbhxquHA8pYeu48TYFmL4t68JockDvP2yCcKecdVbWwIQwakSCmyYh+DakrsYpQ0fs1dIYxPceYFrgEAHwagFXwLH9+VubhYN2TZjbgpkmdCK2pila+p0dgB2dZh+8Z+yVWJFLIVuj7rCzKKR1FvXmBhwISUAdSSxU4R1dQRL9hLnY3Iv/YB2ezIgcox1KCzw7foCgmE5Gjd9pWm0quQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXKlgw/qS9o4prODqRIr4gYoDwGoS5nS6e4y6EX7htw=;
 b=A7aa6Q25osobT0uWyDmMjy0elHl4GcpGlbjvv7FADp7FCidHtwDJ5MCUb8v/7vubHUp+r1rj2KLrJhcqvd9vwoACo39VXakVe7OmAsrFZIgX0eh3paaRQtNTnvkSJwGa3yCyH8X0SJTJfCsYuqQkyTHlN56ktXP9htubqVluAqFTNLd9zxmg2KCbfQpWP1NGw3mdp//NT/bkFUiYAlcmGeeWV7sISaLUVyp8Xkub7vK6yb5YzJZVuqGg6Zc8HaCl4yph3plYcr94tQJwXuFVZp2XJraNoo26eks77XRgMhwGXqd9wUUHX98GJNRV60atoHpe07i3LUomMiA7cftZQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA0PR12MB7089.namprd12.prod.outlook.com (2603:10b6:806:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 08:10:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%7]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 08:10:06 +0000
Message-ID: <83ef44fb-fcef-4b61-9de1-bc24e3c0f4d2@nvidia.com>
Date: Wed, 28 Jun 2023 11:09:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
 <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA0PR12MB7089:EE_
X-MS-Office365-Filtering-Correlation-Id: 001afc0b-206b-4f36-ebaf-08db77af154a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zW9KbLnmbl/wGDqY29WCoQHZcA1qNUJcAAgeAkritaLRtY68xsVr7b6jRGV3KDMe/AifK2thxEX9CQ7XbHi6sOh9WCQyWBJKuDhRhsOaotdO8dfnDNhoEymLQgxYKoWDUf0x+g3iwdvfeMitWzI1pH5HQZgb35fnS5B+N98WA67szSSlF3JNW07TkXdbtJjL+moRI+BCtJkNC3C3TgPLRN05xgcCs2qeXFQwghHvkFo8c7NA9uKsb665kzzuo0chLSXZ/WzqBQ+FTQR4nhVOhQKdsgqzEctIR/eE5bkNa3D0sP0kTLxKRAgvK/dpqVOLapyn1NUlIe+Zow3iOBfUx6uTUprpl97qkSuJ+uaBLXrDhAN2EFHWz+4Ig1X/plxa4kPmdrt+9VaV1fUowsbpiiEMfIyaAi5acuV+ihMj/KzaKhW/bJCCzZ7HXVlMjytDpiGkjLZ5hUsUYUVprcrNIeF74UmTOWymsA5Dblg0RIudq1wwxr9obteI7C6g+Zdsr+J7S871rMvUKDQkox5wg4oFaDs8L0+epzJUnQHOszS0oK1VPtYBEGYF1zK9PgnbH8lg9AUZ5LPwzaqJ7B708YG0WdEtHJzfa3JNjkowtsYRMm8HAEnMwpWuLrNesOCLzUP0CFt8ZnqVu1AGOifkRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(26005)(66476007)(66556008)(6506007)(36756003)(110136005)(6666004)(54906003)(478600001)(2616005)(186003)(2906002)(53546011)(6486002)(4744005)(83380400001)(5660300002)(66946007)(38100700002)(31696002)(86362001)(316002)(8676002)(8936002)(41300700001)(4326008)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEEvZ3R2cG5IVnlRTVo3OWFoUk1RYWNnNE01SFBRaHJ0UktpRVJlQWNvVHVn?=
 =?utf-8?B?N2JXR09XY2JJWEd3M3U0US9jaTlJTUJWWjV5RzFLblFMSGJERGlUbmNIZ2NO?=
 =?utf-8?B?Y1F5VkYzWHZENDNYa3BsNFFvOVhsSnR5dWE4TlZQNGJnN09wTjgycGVCa1N0?=
 =?utf-8?B?TmF5WllULytIKzA5cjAxWXdXMVlwa2IweVozd2cvbWhpTjVsbEtwRGZ5N3Fs?=
 =?utf-8?B?aDNTWi9veHB4dFV2SVhTM291Y1U5TU9oaCtsNkFQU21RRDhyeXFOS1NUNWZr?=
 =?utf-8?B?MElIcEtUZFdKTU1neENIWEgrbHhESGJLK2pCVm83dFA1Y24vQkFrbWNLclBR?=
 =?utf-8?B?MEdBMHEweWNSeXZxRzRLWEZMNE1oR3NIZzIxTGFwRldvNlAwcmdFbng4N3FW?=
 =?utf-8?B?dVlLYTJYc2lDcXg1TkhrRjVGOTdwbVBVMklKVVNJYUdMYldtNTkyLzRSeWxk?=
 =?utf-8?B?MHdyekVGNm93WEJXS3NqbjJEY3oxcXhtQ2xmYi8yV1BhNWw1V3VhZVhTMXRS?=
 =?utf-8?B?UDVlekY3UXJZQzhVVXk4L2R2dkoweUM3eHcxVDZCTUo4LzNHVEZpb2JHcFMr?=
 =?utf-8?B?bUhVbThCd2JsODdRZFlRQmtsSWk0ODZ0YzJDZ2hWQ0psVTJFNXBkTSt1UEpl?=
 =?utf-8?B?NnhLVGdkRm1veXNyMUhwMVpWMkV1VSsvbmtSOTErNjVMaHp5ZXZDdjZTQjND?=
 =?utf-8?B?YTROYko0SDk1Nk1jTFRENUZSVEtRMmpCOTJ5cDN6dkN0YWF1aFJYS2cxSDRM?=
 =?utf-8?B?YjNsZ251TDY0dHpRNXJneDZiM29SSndtN2lVRXpQL3QvZ3lQU0ozM1dkZmg2?=
 =?utf-8?B?a05GVW5icGRIS2NlKzg0R3luaG91dXRtbDNMOVljelJNdFlaUit2V0RYSlgw?=
 =?utf-8?B?MFpzei9HVktIa1lPR2pLTlpEZlAyYWhwT0N5TmFJcHBRUGZtbk9WeWkyS2ZC?=
 =?utf-8?B?YVJmWnFqeGpCcjZlNTNRaGUrRzg0MDFmamxuejRSREZNaWFDN29vZVhPaFhX?=
 =?utf-8?B?Tk9zWFZCSHM1MnhJV1VFZU13cWtoU0tSSGwvVkZmQ0pLOEcyMTVzT0pFTVBy?=
 =?utf-8?B?T2dFc1RUTGhYLzA0aEVkbEhiMktOY2FNa3B4NlJES0RWWUozdjFKbmNHSWR5?=
 =?utf-8?B?VDBkUVRjUE1xSzhaNlAyUjR2ME1BRlJnbGVwYUE1MHVXZVphV0tDdmR5dTRK?=
 =?utf-8?B?VzlyYXpaU1ZkWEU4ek9uODJ5Y1kxVXB5SE1udi9zcGt1RTdvNU9vYm1uL3l3?=
 =?utf-8?B?bHdERzRZWmdHeFBxZUVZeG9wd0VTMUh6cGMvb0pYOG1lcFB2dTRaaXViZ0x5?=
 =?utf-8?B?QnNvT0pKeVBCdkJPNHFBSFJkMkdKNXYvMVdRSy96WGdXMXNTZEo5dlpBaUF5?=
 =?utf-8?B?Uis3YW4yRHVydEFkTi9nVldJeDNFWEJaV2pKQ0h6UjA5QTBKcWN6Uks2OGZD?=
 =?utf-8?B?bVQ0dCtwOCtsM2FJdkFza2haK250Z0VHczk3MEpQQzBmaGFlT0RtTjNPRHFN?=
 =?utf-8?B?Y01XRjl6OUpsK3I4Q1A4NVFjOUM5R0F4SCtnT3lXWkVVTzBUVFEzaWVKTTdB?=
 =?utf-8?B?bCtJTDdRdTErN2RsQnJPTVdCcE4vZVc1V1hJWFQ4TTRleW9NWk4rVHRSV3hB?=
 =?utf-8?B?cHVUQ3NmWHBJSDUwWjBWclJnb1pINDRMemQwVkV0eVF2SFduNEMzZXJUWEdl?=
 =?utf-8?B?NEljbmpoNXpoWjJSb1pwYU1ESTFLcHFSM1hPaHJCOHpKNy9lZHErTHIvV2FP?=
 =?utf-8?B?eWpDWVpTL2Q2OVFzWE5oMW1uWVFqQzdtQnM3RVFuRjVoUGxJM1hEOS9XNW1x?=
 =?utf-8?B?Z0phZDczQWpONm5zZ3pweTMxYkpqb3l4UnU0bEttWUF3Y1lqMVduaTc0QVpO?=
 =?utf-8?B?UDhLMWY4dGVCSXF0am04NmJLNlphSGhsblBJUmRrOTB2WE8wWTllTlNXTnlS?=
 =?utf-8?B?dkVUNzBYTmFzOWlOK0lMUnBRY21TUG8rNVY5Q1dnaWdjTnEyM3VJTHhvcnZN?=
 =?utf-8?B?L1lXa1d5emh0RncrVmFrVklrOEt4UkFxcUQ2SGw1OVBQcU03MmQ0RHNJNzhk?=
 =?utf-8?B?cTRMY3FhMWNsSFBVMHovbS92STNJeXg1QmNVTXRQRGdRdVJGejVEZFZQQUxx?=
 =?utf-8?B?YldqcHplbjhHL1BoSDVyMUpodXNSOEIvY3NyV3ZJNXpLTEdHU0ZWZHlnOUlM?=
 =?utf-8?B?dEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001afc0b-206b-4f36-ebaf-08db77af154a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 08:10:06.5649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+ysh77Yo2BChVwaXAYkz47Az09FxshjchSqRrLdh3ToNUyRfJLqkK7FBw2NKZJqrfLXHIo1Wqf5wFqIh6+/ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_011012_289376_F15C92F9 
X-CRM114-Status: UNSURE (   8.64  )
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



On 28/06/2023 10:24, Sagi Grimberg wrote:
> 
>>> Yi,
>>>
>>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>>
>>
>> No, only one discovery.conf there.
>>
>> # ls /etc/nvme/
>> discovery.conf
> 
> So the hostid is generated every time if it is not passed.
> We should probably revert the patch and add it back when
> blktests are passing.

Seems like the patch is doing exactly what it should do - fix wrong 
behavior of users that override hostid.
Can we fix the tests instead ?

