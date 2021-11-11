Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D49EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 09:29:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30D2610F8
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 09:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C30D2610F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EdeVF8iY9eFUCpsiODa7damro/8C/n9lgBizqBErhP8=; b=wPAY7ymlA96Mbh55TJfeZJO15q
	oZbMknkMt8La3hB2ci5JPsJO/CBhQ79haiXBl+SM9aICHAjoCwwRnDa6makAVCESfPm18tAUWt5IG
	uih8JrgelI/0XhGGUaav7bDM/0jW39gUzNVouDA/up799G8Zln56zNLtVF2/TKW1GqIYgwrv3dhEZ
	FpThPDfNqMyYdzhwj2X+Ln2gLben9J+Zdp5KXfaMt6wlPo5vGXbJ42iGptXLbU1NzHRpoNwsxkEw/
	t3w91JIgxk8G7VxO643yAD1nw61l7hf4EEsFTrXPdpEFdC/8UnoSHfiauNeyi0D2sUpUDVO6UOE/D
	mz9l2Kaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ml6Op-007ac6-4B; Thu, 11 Nov 2021 09:29:39 +0000
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com
 ([40.107.223.79] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml6Ol-007abn-Bt
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 09:29:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhofhiIVZ86zci0B1LZQ4sf8O/6z5RuIxPmlIOMWNSmlyI/3xh3wHuTjggnwWK72HZCaujjLH8QtqPzktA/E2pYjuf/TWF2Z1tdEkRuyhORtcMxbrmrmkM+h5dJKwCdZah28li1mrGwBk1+iTHI7oOkMCOKzNNgwnfGvSJIHYHlVeLoH0cnxlEj/3zYSD+YCEwaOXmh6ibXKv6zHmxObMJDDlWD3KrR4WOircoQ7S1P6XZFP9kPHvhJkInfgw8S92sE/rjrsa9QJjSknTVDzMiMlE6f05kLeUm8HLw9ZIjhlq/qD01AVDyoS8ErDkI2ih8GdNs28F/df1wEYQA4QDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdeVF8iY9eFUCpsiODa7damro/8C/n9lgBizqBErhP8=;
 b=hlZMbnDLeIDuKW+sXSW0WyalQdbt6fOqCH+Pcorb1NaFNJdFfUFheMVch/8GJ6ANEtn+aCAyM1fJdiJ7+nZClEioEaQkBe0+uNgTUgHuqcyWz2dmnggIVtxBc62/hVwQ+sM1taMujdgCKlSzp7NL2GGCeon+hUC8+y91ygehy2h5viuvriRqhjz9qyc3Cm9NbewvbX2qMqAxsh95oRzDvNqtW5kktp3nrvCgF7kXuG/K5YrX3iy0fK3kgdGTZ83MHBR8/meQ3RwMeBsJ15gR3LtQY68REZiX2vyJ3j+QL4xnC/ptnXwJtayBoeIquBhVpjSfEDapQEG4uV7G69fiAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdeVF8iY9eFUCpsiODa7damro/8C/n9lgBizqBErhP8=;
 b=E25zKGC+Zm9IF2T1tFrxxvrOnF1+AStCNQoubV4f/TcAZIVF/roZar0pACyk+Wch6VcEEvgTJj2xIbe2VUS70W35G1gLBAFJe17ywGGYYoyGyV7E+JS0JN/CYxTvcfs7mPXRVCdof1eleU++u83m0uJ4DcEAyYNj4mxLejfpwgFgs5iiAOoyrI0YAOeuKxWEUrH/pEPAwlGpWGWCsa9IpVDfCWIENQ1tcfoG4b8V/TmX28G5SBASznJ3PVUa/g32PRZinBtVHOZQy4yuFzU7TKleuk436ayHxl5iI60aJnTG40bNiqI4FdTPaZ1ELmdm5wVS5XLANIRMbNeWpjz94Q==
Received: from MW4PR03CA0172.namprd03.prod.outlook.com (2603:10b6:303:8d::27)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 11 Nov
 2021 09:29:22 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::f6) by MW4PR03CA0172.outlook.office365.com
 (2603:10b6:303:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend
 Transport; Thu, 11 Nov 2021 09:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 09:29:20 +0000
Received: from [172.27.15.11] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 11 Nov
 2021 09:29:16 +0000
Message-ID: <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
Date: Thu, 11 Nov 2021 11:29:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, <linux-nvme@lists.infradead.org>,
 <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
 <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
 <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
 <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 696b6411-caeb-4100-7c52-08d9a4f5bdb0
X-MS-TrafficTypeDiagnostic: BN9PR12MB5338:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5338011CFF3B55D5BFE1AC34DE949@BN9PR12MB5338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMempuxPqHaKsfgHrGMYqUTvcoFpIinGRw0i2BBJmW7IXTn72eDAJczTgnWFhU3vlrz0es7T7MAs7DNewyif+ztz0JrEaUn6rNyyPgsk6O9skYkw7Cnrs7HOWT1U2hGDnSXv7EBPH3kDFzij4aNBaglL4Fy2AEPiS/gaDKf0Bb5GnwPeGAe3I03iP03Q/I+qUXZYkMckEBKVVQ0RAI8vSxvVuZclYnN4p6IR11l5HZmONzgLxKBnK+JqWdLJVECnjsKz51maySEHwV0r/wy+RD0KgzZrue8aNrSXxm9WhkaclXSh+1qPNfEpm78oG9q3nSGcmf9XkIiSaTzrYSMtV4C+nJQwshp/kKb0CRf5p8clO8U2xbQt0J9JCBB9GYtTNYq1f4MJd7diMjzHoDerYIRQg/nKCgEF1wviFbHMF0uJWBomO5n2FvniLJIPDQzyKM+/lLHa9FWhLMDz+BmnfWVgYNmBSXu0cZwfL8lDRftVpLsSeUiMbCGTbsfZhCKdIKZ3NVASbAje4kqYaytwZmHq7cpLkjs7H+2vx+WHxY7inKMjDfMp8NWhqqZPy3iIQQlejl4RwREA0a6Ab6ODwrUHfWWReAA7lWICoTRMlFZXCEBsdVytW2klMuKW60ixCxod7WVsAGUGmwK5JQhowUKfBVrsRvjbs4TzVY/Tf1CAng+pR+ReD4UBJ5JYFvxRk9/ugcDGoEEE656/IfEU0WwHDc7yatOdALmqB6jz1ww=
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(86362001)(26005)(4326008)(53546011)(8936002)(54906003)(110136005)(16526019)(8676002)(70586007)(2906002)(70206006)(186003)(16576012)(508600001)(5660300002)(31696002)(316002)(7636003)(47076005)(2616005)(356005)(31686004)(36860700001)(336012)(36756003)(83380400001)(6666004)(426003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 09:29:20.4959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 696b6411-caeb-4100-7c52-08d9a4f5bdb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211111_012935_621934_E6449683 
X-CRM114-Status: GOOD (  30.81  )
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


On 11/10/2021 9:45 PM, Sagi Grimberg wrote:
> Hey, sorry for the late chime here, ramping up on some emails.
>
>>>>>>> Max, if you can't point us to a broken target (and yes, it is 
>>>>>>> broken)
>>>>>>> this will not go anywhere.
>>>>>> Any target that uses Apple device as backend can be harmed.
>>>>>>
>>>>>> Most simple example is Linux PT target that copy the sqe as-is 
>>>>>> and passes
>>>>>> it to the NVMe Apple drive.
>>>>> Take another close look at how command_id are assigned my Linux 
>>>>> driver.
>>>>> We obviously do not pass it through as that would be completely 
>>>>> broken.
>>>> Also worth noting this driver has always defined the command id as a
>>>> __u16, not __le16, yet we don't have any bug reports from big-endian
>>>> hosts.
>>>
>>> Right, my bad. I thought that the pass-through target uses the same id.
>>>
>>> Linux PT target works fine.
>>>
>>> Bad example.
>>>
>>> Linux kernel world is covered but I still think we need to add this 
>>> ability
>>> for fabrics controllers as we did for pci controllers.
>>>
>>> There are a lot of vendors out there with their optimizations and 
>>> solutions
>>> and by adding some code to cover a broken TCP target (that no one 
>>> said what
>>> is this target and why nobody fixed it) by default that hurts others 
>>> (even
>>> if it's spec compliant) is not a good practice.
>
> Completely disagree here. The TCP original report was just an example of
> lack of protection we have against spurious completions. Nothing
> specific about nvme-tcp here, this was discussed and agreed on in
> the original report.
>
You are ignoring the facts:

1. The device that broke the spec in the first place was that device for 
which caused you to add the gen bits to CID.

2. These gen bits are causing the limit of 4K Q_depth.

3. It's not mention anywhere in the spec, and if it was intended to be 
implemented like it's now - it would have mentioned in the spec.

4. Since gen bits were introduced, other devices got broken (such as 
Apple), hence the quirk for PCI.

5. The gen bits adds "if" conditions and logic to the fast path for 
"innosent" transports.

6. This series just extends this quirk for fabrics.

7. Even if not broken, some devices may suffer from reduced performance 
having CID space spanning all 16 possible bit - fact that we ignore

8. This series provides a flag to disable default behavior per connection.

9. This series doesn't add any logic to fast path.

10. My patch from last year for resiliency for nvme_pci was rejected 
because it added one if condition to the fast path - no consistency.


>> Could you qualify the harm this caused? The command id is just an opaque
>> cookie; the target should not do any interpretation on it, so this
>> encoding should be inconsequential from the target's perspective.
>
> Exactly, the command id is an opaque that is solely up to the host
> discretion in terms of how to use it. It's pure coincidence that Linux
> uses it for command indexes.
>
> Any implementation that interprets command ids to _anything_ needs
> a quirk, not the other way around.
>
>> There are more hosts than just Linux that may encode id's with flags for
>> driver use, so non-compliance here is just asking for trouble.
>
> I know of at least one significant host implementation where command
> ids are not indexes.
>
>> If a vendor wants to constrain the command id for some vendor specific
>> optimization, they should bring forth a TPar and fight it out in the
>> workgroup.
>>
>> We did get bug reports that not validating command id's will crash the
>> kernel or corrupt data if an unexpected response is observed. Even
>> though the incorrect id is not the kernel's fault, we generally strive
>> for resilience against those types of observations in spite of
>> potentially flaky hardware.
>
> Agreed.

