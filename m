Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A497AECAAD4
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 23:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uJXgpR719CML8ai2irROXBhJDQDhDE9lWT7BbrVCf9w=; b=tgbJAs0E+QQYw7FjqGeev35SCp
	3isCzKSPuXqMhWl6KgUUY8RnzFix0Y1AsB1LEViV6WMPMVbzJJ323PKF4fb1ekhZHWltefi4CC5GQ
	hIZoxa8zSWnA/E6jGEoSPwRuhkAGKI3TeAGPaqdcRR3z5p7XWoQNekRz7UdwEuU8SJ582M0pvd+2Z
	Ke7fXX10nuQSIeY4pRN2GxfBAKs/UgfyAIkypgcQwi92JF00RaQzyYl96PhpC8e19UsHS7VeMHcjD
	TEYnbB4P7zcoVO0X5By/Jjt+SmX0Du4LDGmJfTO2m3Nt4HuZWpNwJi6E9j5TkFNv472Wf7DCO4BIp
	M2+ZSCEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSoTu-00DFOx-5X; Mon, 29 Aug 2022 23:47:50 +0000
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSoTp-00DFMJ-IK
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 23:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpZgFfrd+vVnGGxTj95axS4d0AVkCtYybpZdkD1bIJgm0Hg4x8GWX7sV6W38lmpdy1Yi1VmBVpKR1Au/jUZgFrbG7HXFqTFU+aauEAiIKBWhxaCVmloER5xpgKOpMhvhuay0Sq3jiy3uVjJBisEn5B3VvVwY/C+creUBRF1nhumLpF25xT1qGwdWYEoQ1pUS+g44QZvMv0OUtJsO2q+8oFjZkliAvMX/uRbKzYqaMiMfZCSnfKuwHKUihThTxGWE2GV9eSmVT6qHOnVHliHU7gSxgsXV5pDJ4A4+Rbg1cU1fTFzEmSgLGlIpfFew77E8nBBflwowIGfVH7lOGK16ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJXgpR719CML8ai2irROXBhJDQDhDE9lWT7BbrVCf9w=;
 b=MIIlZ9GEHeDbRfh7dVnNlhgHb4cXZ+xXHIyx1Yc13SFXGCokFUJUBEyUI2sxHZjVL2rF4ElAmjLABomL14U4O/LKkCh3HQPHTyBT9eJrxW780xJvUfeCn14DaDiqsp5eeNkQezWfyt1hatG4g2cUDLYG8QcC822Js4uAKIzlto3vP7xySbT+wvnDsmXy+Ns90q2cVnafkhWcPYmLveU0G/Ogz45pH5LZzY1jcV6sOJ37SJxKcYburijgUaRFNBedzmfcOC+/LlEr+hmVN3GZBEIR54fTwpKLY2UqgX30F6OmfHaSQ+BJMQhVcCXJ/dtJzz5kL1hEfReJZCNPuAZXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJXgpR719CML8ai2irROXBhJDQDhDE9lWT7BbrVCf9w=;
 b=AeS/NRbPlaJ5om5gpj7aapWVffWO7e8jsENyAY2XxIkB42uqY6niOk5BfpuMbnCfYZbhvqMpq+xwvdgYYyN6oVGPkCMvRKh72A+psBvpL+v28fFVqvJhEYzRQcFYSzBi7GwQeOt0T/ifK4DN1sEAP8CiuGGEKi50G1t3DglyQGZYBx37gDWCMZ4rcafJdmUACENt4Tj6R/OJZY0NARu7+N/HdUbwT7kyan/eimjsjlA6vq7lOTSLvtKXp+NEI9+vWyQInE2fySqUwTMo9acAJrNy7ksqSXaGwJ9F0Y6KEZ5UtjiKcgKVhX+BrZGIktZgI6eYtMnKultoLwV7mr272A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 23:47:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:47:39 +0000
Message-ID: <f3fae5fb-0c98-4b40-ea7f-3a7cf20ebc61@nvidia.com>
Date: Tue, 30 Aug 2022 02:47:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
 <YwzWyrFahUlqs2fx@kbusch-mbp.dhcp.thefacebook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <YwzWyrFahUlqs2fx@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::31) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec21066b-7180-438a-e6f0-08da8a18db6d
X-MS-TrafficTypeDiagnostic: MW6PR12MB7086:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	kZFWpqYDkjc24eo03eNiLNAzIRoidyFPugepByjwuFhW5K0w0FZZ+fpS4+w3D7SRo0RZ9HNctz1FNynPKuSeeVAmhO14mzZOsekvMzGj01KjRVe7nPxf7uLk0T81wGb4jTIwE6tgYVGAqLqkBIwX3/k1y+g0bNaanCrWXvcO+9b5DSx7ZqfGL11zt6LNBi/XDnhuIsltlJn6NHmSY+W4KOjmabL8myKZiqSNXzv6sLl2SONMie1AN0IIX16u27UnKCPnKDr92yL4PnqsWPzaJzyrHi3Pimzp/fBZS2lWGtpvH1GJ/j9QUTYN+aRLlkcEzPV5iMFXDN2oVPlmnkA+mBRS5skblzQp5BWC9/CqU/AHtXjw+KM30jYnvIP4vZ3XxGeEbsXHFxcIEbDdVGB1z/QQJgiNBa/Af9y/C/CSH5lQYlskljo81qaI22lBKAv5YsSfbMnilQTyXAhYw/u/0Mx9yYMViJ2AkZFdrfSWqhS+F96tJvP3hl5rgaTNJ0h05xirIhpWF0vniYbJHShWvl6neZYiwoto+VR/+3F/tbEkx/pA4BX6lz6OsAmiNQdfW/b4elIQLhm/+IJtFbcuHGcrJnlcM8lQakAs9iehuItHDiZkH2OtcEAtl0ERmiypq2e9xYvGkIqfUlreqSdRw/1grHDN6lG+XqZAR9JH6ezCy5TA195yrpj9iQFxR/FSSTYcLDq3mMu7DJndAetA6/1WOA8uHmD/ro6rbLCLqkcDIVDfwM5SebT7EHh1BdAlnInYtqR19xsQM/1acJU3CqnUa2nBcjg5imXHZ0tue+E=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(478600001)(186003)(38100700002)(83380400001)(53546011)(6512007)(36756003)(2616005)(6506007)(6666004)(41300700001)(26005)(31686004)(66946007)(86362001)(31696002)(66556008)(66476007)(6486002)(8936002)(2906002)(5660300002)(8676002)(316002)(6916009)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?QjVjdkVKSENUdnNKVzRWQTlYVXNOYW9JWS9OTU00SGhjdEZEYkl3UksrK1p2?=
 =?utf-8?B?Z0ZHeHRKMEpTa2picUthYU0zRVQ3ZWRXNEJXRGRLTTQ1bEJPUjROVHRDSUxO?=
 =?utf-8?B?cVZOQkoxOGNBcTVycHQrYmZPdE5MdVBLdEJjNkRqOXRNck9VQVIxcDFGbTN5?=
 =?utf-8?B?OW9jUzB0NmdIN0xialgyK1JhVis5WnlnTEYzVzI1eHhvdExKMTVXSjRDbjZk?=
 =?utf-8?B?VmpKMUtrVHphVDFNZk9WMU93akZvQSt5eE82cytkYkZSWjVEWjl4RmpjeWNY?=
 =?utf-8?B?TFpsckxjN3lYTUNVVkpoYXhKVlNkejJxdkloOTZNMHBBY3VxNnpqT2M2NkZC?=
 =?utf-8?B?WnAwK2o1MnV0VWx3OUZsSnpCTStmQlhKR3d0MHNYM0pHZzJkVzk0dWlUZ1Rw?=
 =?utf-8?B?dzNwMkhsWXdTZTZvOHVob0ZHOVZsV2NnN09pRW9xcHVKck53SHJUcTl2WnQ0?=
 =?utf-8?B?VGltYy9renVGZ3BXNHc5Q1IvQWF5SVREZVRaRG53bmI0eUJ2dmZMYW5hVmxv?=
 =?utf-8?B?b2NiU3l5OVRFZ0hWakhYSW90aTBPVDhsK0hRYmVoVy92eXU1bVJ0YmZwaisr?=
 =?utf-8?B?NDNPVHZnc0pVOUVBVkl4cGhkR1QrUTh1UDNaQ3lDYnhoNGhWNHcvRncwT1Vr?=
 =?utf-8?B?QXRGUXRiNzZaeWRWV0xsK2dQT296aUMvWFd5ejZ2dWEwUHFzVk5iODBaem9v?=
 =?utf-8?B?U2lPZ2JEVzVjYnNnZTV0Q1R2c0M0em9YYmgzVWNmM3V0TkhvRmVneUx3Slk0?=
 =?utf-8?B?MG5pVFVGSVprd043Nk1OSHo1MUVnd2U3K3ZxUlMxM2pxbG9KbnYvdXJZT3ps?=
 =?utf-8?B?c1FSemhZRVhEY3dqellQSUZSVEZiVUU4UTRLUnltQTYyT081Wmk4TzFkVmFS?=
 =?utf-8?B?bTdFN05QUkJtdmk5dUVqZFRiQ1JLVGRXT2RZbkVVWXhHN3BYcnE1VGoyZ05a?=
 =?utf-8?B?NUNQVEhNcVlvdUw4L3FNTzBCUk1vTWJzVnUzb1UzWnFNVDNhK1JLQ0FOQWU0?=
 =?utf-8?B?eG4yMUNMdkRrQTlzZGlSdnhyL2RvN2hJVytuVUNjWVRmNVVURWViNDZJZ2hY?=
 =?utf-8?B?SlRHc29OQjRoVHVId3hIUHlHbExhNFhlNHc4Y1BycmF0WjVycVBvL2cvM2x2?=
 =?utf-8?B?MkkzS0daRFZ6aXBobkx5OThkZnV4UHJybFlEZmlaNERsdXVpeUk3aFgyeitQ?=
 =?utf-8?B?d1I5a0NCTFFsR3VhemRlbm1iNTVCenQvc1ZrWmYxRDdScFdzOG90YzJOTE5E?=
 =?utf-8?B?ZnlKTUpDWmcvMjJyVSs5RVVWbGtEdmg1ejg4ak5nNENjY1dreitCOXM0ZW53?=
 =?utf-8?B?QVUyTVZ0OWQ0WmJzQUkvTzZSY1NuYlhxSmwxaEFFdWVNcHBPNksxcTlQZnBQ?=
 =?utf-8?B?R2VFUFRWOGxPNEFFR0hvSHdrekhUUytXZEVNZDkrQkpRaWRaOXk5NXRhVmJm?=
 =?utf-8?B?WnNVcU9keWJUMEVGbnB5SG1DS21GakNIV3YvU0pFRHhDd1ZaL1BXSGhaTlQr?=
 =?utf-8?B?QnYyOTN6Q3ZaM3gwRWZqcmQ0S25UOEF3UWdLaXorZ1dTZHJ1ZTh1Y2tFRGti?=
 =?utf-8?B?Z0grOEJ5Z3FSWnJIUlg5U2RLdXhNQjlYczNub3RiYXErM0NGbERSZER4ZnRa?=
 =?utf-8?B?Y25rZE1UWXhScXUrR05vU29nSUZ0eVVCTkNjL0xBMDNhOE1yNVByZ0gwTnpo?=
 =?utf-8?B?ZnlBcWJ2TU9uZTYwd01XWTBiYUVMeVJDL0lIVnRkN0diNXdkMjBXUW5McVdU?=
 =?utf-8?B?YXZFWXZLRGxONmNad2x5azg5Y1V1TVZ5RzZ4Wk45WnVjTVE2cWNNRTJUYk1J?=
 =?utf-8?B?b2htcThsTVFjRG85dXpBQW1Wb3NXVjhJQ2NuR1lkdFloMEE3Z2Y3djVLa2tC?=
 =?utf-8?B?MmFNeTU2OEVFek5sbzFQdzZ5a2RreWZOY1BwbURCVGhLb2RvNXorNE43WG8z?=
 =?utf-8?B?NVJ1Z1pEaExIUFFpYVc5MGdRcEpSUTNrVlBkYXdPOGZoYUdaWVcvbHplb1BQ?=
 =?utf-8?B?eXg3Tkp6Q2VGaEhmZUhwM1Y1cHh2RVd4MUJRSW1NekJXZzlnbHVYdm12Wnh0?=
 =?utf-8?B?bERnMDQrYmg2WVZKWWxWYWVsa2wzS203NktpTUMxS2NzczhtYVhORUJzVWhH?=
 =?utf-8?B?QTNER2JRMG5sa0s0MEQ0VE5lTDRIRjlrOGJzV3F2RXpCSUlHVGZmZWluTkpR?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec21066b-7180-438a-e6f0-08da8a18db6d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:47:39.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4oPOfJW1QopEBOL0kzLiZOKElFpnyEFbIrhyKWuU7ml4QKKgLkcmsnsfv5kqC4RDm2WmUBwGR+1UHTDZxFUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_164745_991557_C03A62FC 
X-CRM114-Status: GOOD (  17.83  )
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


On 8/29/2022 6:10 PM, Keith Busch wrote:
> On Mon, Aug 29, 2022 at 05:56:39PM +0300, Max Gurtovoy wrote:
>> On 8/29/2022 4:16 PM, Chao Leng wrote:
>>> On 2022/8/29 18:43, Max Gurtovoy wrote:
>>>> On 8/29/2022 11:12 AM, Chao Leng wrote:
>>>>
>>>> You can mention that also in iser, if supported, the default is to
>>>> use IP_CHECKSUM for DIX and not CRC.
>>> According to DIX define:DIX = IP_CHECKSUM.
>>> To reduce CPU utilization, the end-to-end DIF for SCSI protocols is
>>> DIX-DIF when supported by hardware.
>>  From what I re-call DIX was protection between host_buff -> host_device and
>> DIF was protection between host_device -> target_device.
>>
>> If now its defined as DIX == IP_CHECKSUM and DIF == CRC please mention it
>> somehow in the commit message.
> Where is this coming from? The NVMe command set spec says this is the
> difference between DIF and DIX:
>
>    The primary difference between these two mechanisms is the location of the
>    protection information. In DIF, the protection information is contiguous with
>    the logical block data and creates an extended logical block, while in DIX,
>    the protection information is stored in a separate buffer.
>
> Regarding CRC vs IP Checksum, the spec also says this:
>
>    In addition to a CRC-16, DIX also specifies an optional IP checksum that is
>    not supported by the NVM Express interface.

Not so clear what does that mean.

>
> So DIX support doesn't imply IP checksum. Even if the host device can support
> it, the target device can not report it uses that guard type.

Right.
But we don't send the IP checksum guard on the wire.
The implementation is only used for integrity between host buffer <--> 
local HBA.

And the fabrics support only DIF (extended logical block) so IP checksum 
guard is not allowed.

So, I suggest re-write the commit message according to the NVMe spec 
(that defined DIX and DIF differently than SCSI) + add perf numbers for 
4k, 8k, 16k, 32k, 64k, 128k, 258k IO read + IO write.
Or maybe mention only the IP checksum that become default, if supported, 
for offloaded integrity between host buffer <--> local HBA (As we do in 
iSER).


