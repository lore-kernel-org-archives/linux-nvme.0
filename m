Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C935C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:44:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D0D20836
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IGkdKguF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XL5ORLRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D0D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=C2gNIxPD1DgoZ8gMI7PkKhHRRX87VOmJJqs6fSV735c=; b=IGkdKguF3DRy+RfAXSZGo1/Uo
	3zdZALzLiQqguT2K481G/Teeqv3WLCnpjtq5iRkgCD/zhB1nXLMSPVG4xDZoHhKpJzwGnhDkBs2QT
	Dstpq/Ytn5+0URdPCUvAr7Ppq+Gq8JafqLGT026puOpnqFdpSLS2rQLLCt5Cclh/7GtA1vuRkEU/I
	bnlr9G3Gv1nLcoIKyxZHunffAnBMWPcjS5QsyO70uWO5m2IMzGeqxk3yYSDKfnR1592GbZGoEIFmt
	hijY+UBV/c3b1D49PRjJUTar09T66GH80mceUTzsYs0lCM4eaeH+27UExhnWbaPj4ZYdWAvrv5bA/
	zQ7RodQ3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo10x-0003mS-Q0; Wed, 24 Jun 2020 08:44:15 +0000
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo10v-0003lY-4f
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 08:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGc6wNsnud8L99jV7HnlAdZEmh3byTShHbJv0tfBzGrYb/5P1YV35sIGntVHnBdbQWQPtomLho0T7PwbKs5sVsSfAIDrEM987C7F2Py2EE6r+AT8ih6cRenqk0bR5Y3JjTHZcrMd5k/foe5LWTJ0Rhrc6Dvies6vuFhiZkgLoXLMi6e1+PuPAETlvObpzxqWthK/yy+Km3s7i5wi+TQv1MU/uqEeKSU5IkCe9MfNmc/0HuhzjbJjdQRDfDsLIGIcus9T5qmhN0Y6qQ0Da+T5WFjkU7Rwsd1cryflPhFwKQdlp2bKljD7a8SR8hYPNneN53pz6UBEb4l+GK5qFgHuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7HO52PyQfUsFXWxV5hI63PFzCBQoM/AvoKv5eDukX0=;
 b=XluqkN/dEA51ohRK9mWCRUeC5W9rajmRblmXzqQIfoSKzjNDzEGPZMmm5nXXo+v8pZPjPWQgrc8ggu2XGWEyUZht94P28oO4Wpz90WZXVBh7RI0/0mpdY3u8WdcImDeyW9Z4mkoV1FvK9HdU5nPSp301AYKhiHUixQ92tLiEHVTgCVQRjZj1Q5k4WWqjmjErdbmQbJVO//PgBPSeXbZ3L7ixd9BTF8izH6ePqh63uJFWF7q1f9n0CsYplaivnyY07tpR90AuWevBGyr6h08pSUN7edGpMAs2rszhjxkeGCUt9QcGOiV8WmMbYzxiohqmZNtsiSVBGxbliP+vyIhoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7HO52PyQfUsFXWxV5hI63PFzCBQoM/AvoKv5eDukX0=;
 b=XL5ORLRpDEGK+jLAk1nuc9/nbUO38z9nbDXnJYCn6FCowiDt5mOet1ON+kDIjdW9yfJqaH/h5+JeKkoMOzIvz/FN2nCvoC98IKX60q9tFCp8h+Y/wTfKb3pKvdke4C6oNv92FCo324LrQ3D2TiRP/jpLPaMuEqxzaAVIG5H1X6s=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5026.eurprd05.prod.outlook.com (2603:10a6:208:d0::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.26; Wed, 24 Jun
 2020 08:44:10 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 08:44:10 +0000
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
To: Christoph Hellwig <hch@lst.de>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com>
 <20200623152236.GA3072004@mellanox.com>
 <543adcc9-fda0-abb2-c37a-fb961d65c5cd@grimberg.me>
 <ec6b1a89-0cc0-1378-6d29-29b9d255c7f5@mellanox.com>
 <20200624083743.GA23529@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0e102b77-79bb-0dc6-48e7-10cc3aefc9a8@mellanox.com>
Date: Wed, 24 Jun 2020 11:44:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <20200624083743.GA23529@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0701CA0011.eurprd07.prod.outlook.com
 (2603:10a6:200:42::21) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM4PR0701CA0011.eurprd07.prod.outlook.com (2603:10a6:200:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.11 via Frontend
 Transport; Wed, 24 Jun 2020 08:44:08 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4419a26-060c-4561-736b-08d8181ac37c
X-MS-TrafficTypeDiagnostic: AM0PR05MB5026:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5026499A86709EFC932D240AB6950@AM0PR05MB5026.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 23rG0Mf9t6EFBpX5kq6V3dU1S0S/px3q3kPnb1cdfp4EmDFQb4wxweeYPdvuxBoFSSwMCgJqddDgBOn/wtQ6RGV0uNYVpUIOVrqE/pKrd5KpHaRCFA7Jd1saQWOcwsP22QUIo7+aCrYvS6+bpSQiCEt6G6vcSGl77RM0IqFtpLriUMqbMjZCCZYsUEsbb6Y+g2LKjR0Cq8e/Zxkn6FGohpbGUtrbmNH6Voxbs2V1cB5uMQ7i/Mb3ZIMNAc282n7cz/L+iST1gj6oer383SZeWjpOJJe6qAFCxYqigR7MZl9vuLDDxCScxYTMREaBanw1tXdA+TgY7YhOuI8Vwf5e4RAegc1ErEebmPZJZwff9drYDdnKLZWHND8KVK055r50
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(6916009)(66556008)(8936002)(2906002)(26005)(86362001)(52116002)(36756003)(956004)(2616005)(186003)(107886003)(53546011)(66476007)(66946007)(4326008)(8676002)(16526019)(316002)(54906003)(5660300002)(31696002)(16576012)(31686004)(83380400001)(478600001)(6486002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xgQit1AJcFLmrAZ6ykXO/z1I98Zd0v6JisEvTvlCMBpHaDwU3XeA0gNcH+QooYulArV6YniNKVlgDfdoEUpnY2XQm/tgnCk9GXrr6uWwF7hbFbZ/DRkefRTrRpY7xojwQhH7VNtnONL4KulHqJbQ04F0aMKqMk4W0+ESrqhRzJbWTc0dUuDFbhZ666Va10ANnwZAZT0ojBcWJW1yQ54JEtP8M2XL4hY22Rx0003GCPqjAYfkhcGMGG837Z90gYwTeTPavtDuDed6zf07IrnDZJoMkExAN0Z+WT9JU3iMOM9xA5/rKqCm1Fc4EgPtYMqM1iirZ95eLxS07LvB5ne54PyyPaiAPCmDVsKfoXRYxKajxHXhsEcPIUvrgC9JtRmHNiKVVns/1lB2Kh0ttsHAfwLA78HYJFYZq9wvUBCKS4USZQNyUzDvjiHH2GCOMZ5rxsNRxqSiIbvfhtLt6/DIeuXN0daQICw4n6YnxP5i/zyUXkiT19haXX/AJcOsZLO5
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4419a26-060c-4561-736b-08d8181ac37c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 08:44:10.2203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8q3o0nr8oGmfGHpJEyjWSVOzIt/ZpV8o8JGJDANXuE5qkYytTTf5CICmwDOIM/3BK3VXDO47GK4y4vdiCphrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5026
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
Cc: yaminf@mellanox.com, Sagi Grimberg <sagi@grimberg.me>, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 Jason Gunthorpe <jgg@nvidia.com>, kbusch@kernel.org, ogerlitz@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 6/24/2020 11:37 AM, Christoph Hellwig wrote:
> On Wed, Jun 24, 2020 at 11:34:22AM +0300, Max Gurtovoy wrote:
>> On 6/23/2020 8:34 PM, Sagi Grimberg wrote:
>>>>> The completion vector index that is given during CQ creation can't
>>>>> exceed the number of support vectors by the underlying RDMA device. This
>>>>> violation currently can accure, for example, in case one will try to
>>>>> connect with N regular read/write queues and M poll queues and the sum
>>>>> of N + M > num_supported_vectors. This will lead to failure in establish
>>>>> a connection to remote target. Instead, in that case, share a completion
>>>>> vector between queues.
>>>> That sounds like a RC patch? Where is the fixes line? Why is it in
>>>> this series?
>>> Agree, this should be sent as a separate patch.
>> The reason I sent it in 1 series is to avoid conflicts. Since all the
>> patches can go to nvme-5.8, I tried to make life easier.
>>
>> We can do it separately of course.
>>
>> Christoph,
>>
>> would you like to merge patches 1+2 from this series or should I send them
>> again as well ?
> I don't think 1+2 are 5.8 material, so please just resend 3 standalone
> for now, and then resend 1+2 once I've merged it and rebased nvme-5.9
> on top of nvme-5.8.

Ok. Actually 1+2 were aimed to be merged to 5.8 but created a conflict 
between Jason's and Jens's trees.

If we go this way it means we can't push new features to RDMA and use it 
in NVMf in the same cycle.

Jason,

can we push iSER CQ sharing to kernel-5.8 ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
