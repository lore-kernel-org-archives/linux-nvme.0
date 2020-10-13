Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3397FC43457
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 15:35:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FE2251C5
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 15:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rO+DCt9p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="RJsEfu8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FE2251C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=npuezeqxA7/t73PHkO6S7LGdLu/9L9/LcdlMrJh79AE=; b=rO+DCt9p1DoO+Du0v0sC6h5Gj
	X1JuerZZq15qFi7FY6hISDc1P31BoOfu8tpDML/2bqtBRKYOZPdkrx0qDylB6SoZb9ZSHgajvgVbc
	TlmHsM8XTqIVlfmLW3jmNAof2FAaBo7Rfhi2+5Ymm+BYZL9hmUpmBwKR1lkRscvQK1mVIO1TZifal
	F9BYcJTINc+tMZ6Ws9b7Oo/hPGNnV7KuVlCzFrRQOWfBhL7azaDUiOgJkyveRA5ZnNdufYY4i6vR8
	iZQ3w6lmQE4C+xTor28eZpFhQCaEAMYhd0vseAttQ/NK1gL15CKmVgLI7hgN+VNnoenEgTMGLQeUz
	6PoDeICSg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSMKg-0004KG-3b; Tue, 13 Oct 2020 15:35:22 +0000
Received: from mail-eopbgr750083.outbound.protection.outlook.com
 ([40.107.75.83] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSMKc-0004Jj-9L
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 15:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLT3vqGJ9j/mabx5GeFj0vDODNKzoeNeXrRLi3HKsnqjH6Gnop/lbr8+6+vr7VFWE8GOhk7kCqhac2PCt1XyLvOjJcL1+RLXbx0cmI4kjBhWIunkKgocFAqESOms+9MLMAsbRT08gxqXyHfK+2Ikk5Hrw0FR2Az+RdkwhMN7R53Q+mBDrMGzSK3kJVvP3L5MDGCxKuq2uz+1opBV3Yj2iyyRD7ibI3MslZiPYc5mwn3Je1wE7BTNWUj5RwIAbDbkv2NoHZVkfafNeIgukDB14aB8OsgmYwge0hx1H+3S6Sb7YImlfxQsmJ/7rTtaGraV1VtF4/TwQjdyh6d8mEVG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45zAVkpiRKVmL6Yozf159YlDqIdaWDKEoHEBn3x5eJo=;
 b=Jm1hpKrtbAt5rpKbE/VPg+eCXK2QhZxt4ML5oaw4kN0I+nPjh0JaDkqf2gg5qLiLmYOmwZurGXIP6eYzVUStj9txUbQBJvDA5KM4ye0CzWYF5QJwkC5JiF5ThR/UHsQSFOxRKBhRdPGOqzdyczpsKQfr5LWXj919J/GTq0S5XykgW7UBZp6xHmrcAj/ExPlMJxfTGVqe1tdzpIGkpUeSxMvn+1B/UX55rJXMwUZK3jjRk3AeMEeaiZs7+cFFDCJWYGh5uMpJAbYHAeLcyogps27YtMUdJxnP7ruQEd/qAR5YRi2DVCqiqamWhGf2tuftFVyAfJwrXkkA4x1B5rOjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45zAVkpiRKVmL6Yozf159YlDqIdaWDKEoHEBn3x5eJo=;
 b=RJsEfu8nZ6Ch27Y4qY54CIu8aZOzm/MNdLk8I5BCAE7BIzKziQSyYZr8qXN4EwhMb8/U6vAoE1sG3XR+WyR52nj3dhSjfysl4dgPOu3ENGw5wN3Dz/zacf+4UBjNEIuS/sVl2uWgmDFiWrQzOSpWgHcu8kXv5e7gzZgilzfRBaA=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 by BYAPR11MB2776.namprd11.prod.outlook.com (2603:10b6:a02:c8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 15:19:20 +0000
Received: from SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40]) by SJ0PR11MB5120.namprd11.prod.outlook.com
 ([fe80::c048:b134:f828:e40%6]) with mapi id 15.20.3477.020; Tue, 13 Oct 2020
 15:19:20 +0000
Subject: Re: NVME, isolcpus, and irq affinity
To: Ming Lei <tom.leiming@gmail.com>
References: <2a4a5174-d1b9-86b7-f3c8-03b041fa093e@windriver.com>
 <CACVXFVM=UPgJ0K4iZOG=DJNmfovHFjg-u5zQkEFgwG7np5V3PQ@mail.gmail.com>
 <c199e17e-2c7d-8010-7648-3d16ed964c2f@windriver.com>
 <CACVXFVOSR7UXDC52A-2sE1xeZNZ1+KUxGPXUJrvu_FpZ0qT4hA@mail.gmail.com>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <635acc40-d76b-3f2d-45aa-38ec1d0865a7@windriver.com>
Date: Tue, 13 Oct 2020 09:19:16 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <CACVXFVOSR7UXDC52A-2sE1xeZNZ1+KUxGPXUJrvu_FpZ0qT4hA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [70.64.84.123]
X-ClientProxiedBy: BYAPR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:40::29) To SJ0PR11MB5120.namprd11.prod.outlook.com
 (2603:10b6:a03:2d1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.25.39.5] (70.64.84.123) by
 BYAPR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:40::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Tue, 13 Oct 2020 15:19:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3207f86e-5dcb-44ad-6446-08d86f8b5b74
X-MS-TrafficTypeDiagnostic: BYAPR11MB2776:
X-Microsoft-Antispam-PRVS: <BYAPR11MB2776B39B54AC94C3ED2BE471F6040@BYAPR11MB2776.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9IBJ51UlcyOlKDJfa0c+lOL0L7dzytlS7uB0XhXEbQeZDmWPADjYrd/Jyvf4R/6MGbzcXrKqFlJWcBnncah0YF6FkPG/lQytdcDAQfX1ouHBsOZ9KjjvSqA+Oue4XDWQJjuDLWhlByGyncHTtat+RyLxLrEBBN9rALwEA551B0S3jflbBVWhXIu7yjDvx3NDzQrEE66msG9mbe2/zHd/1xMkPXKQXrt5D05BsE4qZBmZluYgj8nXqLZssRctfoLkr9cVb3BJYUFheUHxlK5QG5+/vU6DYpfwr6TDpQXIPbBsGPYSQ7vVb0OZvQAMhLAEogghcofP83IPhXMouPtE6LHjl9diX/FNy5cgzkHUyU0HN6dA1x/SDWR+lFf7351t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB5120.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(136003)(366004)(376002)(346002)(5660300002)(2616005)(956004)(8676002)(316002)(4744005)(2906002)(16576012)(66556008)(66476007)(66946007)(53546011)(186003)(16526019)(8936002)(26005)(52116002)(6916009)(478600001)(31686004)(4326008)(44832011)(36756003)(31696002)(86362001)(6486002)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +1H0nLovxZERJVXNZR+WJ9xWnl+jRhwCuU2BlkrsSvW4/iMYJfUWsTJiYF+HuS0HDJCEksM7i3nGWW/KnnirNJ6TImRZWpm67i3fFIVRzD01QUjtb79vc6JNTeldnC6bTZM/skUnMTrnUw+qEKF6k99lBdy+9YIjg7Ak5EXOno2gtSMIzfkbjGgDn4+UkxMemctZPqBkUMUT9wYztNf1vn+I/4Z+MjyGPFQotiWJovt86zhHh+RlL20lZu+aFHGHgaYSSWJ3aAY03WUi505q7R2gwoYGxhgsaCIaUgdOE6ui0tta66pmTD6kY7bXULJr9PxPCfAQagxuUtYXnfg0tirLb6eNZLs+/tG75hIcaN1NPeKqjuiL7cngXEHH9fZQ9SfY4sTFXJM2kcXIzqABYxH+Y5GL8Zmj2i5dC5Axjvsd+BbX8SfDkqzRhQPTNf5WUXYUg43qSiPoNNafecO/PCJtqihMKqYJz9WIMa1g+0D+RwXScw7MJh7bltR+5QxI3YSmlziAQGebI3SIfC++236gU8ByAmyxL4lyjpaEi26wYFX/7wiNNRBlLBeoHEYQ1odCtM9Qpf5S6yxvssb1HsZynw+OtO3aZi2kOj497egA7np5fPtJTxXN8I7WeTwNmS8fVpIHkr4veHChrq4IKQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3207f86e-5dcb-44ad-6446-08d86f8b5b74
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5120.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 15:19:20.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfP9xI/ev97hEeZ7G9crUg/sJnjESw3QvYjBzAne44tRIZYDiu4tmEZ8uEIjwQKcstUrwMTZ8ohQNndYwYAOoiZTHBDhT6bWVWDFkH6J8Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2776
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_113518_356112_E42CF54A 
X-CRM114-Status: GOOD (  13.85  )
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
Cc: linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/13/2020 1:50 AM, Ming Lei wrote:
> On Tue, Oct 13, 2020 at 2:24 PM Chris Friesen
> <chris.friesen@windriver.com> wrote:

>> kernel and jumping to a brand new kernel will mean a lot of additional
>> validation work so it's not something we can do on a whim.
> 
> You can backport that patch to your kernel.

Right, we might end up having to do something like that.

>> I'm definitely looking forward to moving to something newer though.
> 
> What is the something newer you want?

Sorry, I meant something newer than what we have currently. :)

Chris

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
