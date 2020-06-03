Return-Path: <SRS0=Mmm6=7Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEFDC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 13:32:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C9820679
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jun 2020 13:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z7fHFhRq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="LgSG4g83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C9820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qq6BtkolmWdyQPzsak/W8AHEY/aLZUdYa/caQzvP5pE=; b=Z7fHFhRqBgACj6EI1SmK7QrQG
	L0cKzMRiugnxXyqMEFTAjbiZbCDdy9Y5HHCdLzFH3hW1TuKRhJiPVbz2faFgsiRqT/J07FePpL4Js
	D1YKoXJFeIsyKeRVIAMTumUn8H2GyW4OQwJaKIi4n1QdofiSdJJU63PR7xaGmu7fLKpvZB4eB+Pei
	9x0NXRs1zpopmiaT8kD9RCfLuuEeVYk5L3xuhIfsISPp7WaSbM0ECSxxqvxkcZHvEK7M/XnHnSfFm
	3hLHkfIz30/zfb7Bwv+BS6OsUjMBV9ddPeK8fE1dRqO/NzJKsWxXE7sqcSkSBFVxIFPn4a1YwdeWC
	E3BwcRPdg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jgTVb-0008E7-3W; Wed, 03 Jun 2020 13:32:43 +0000
Received: from mail-am6eur05on2081.outbound.protection.outlook.com
 ([40.107.22.81] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jgTVW-00083g-Jw
 for linux-nvme@lists.infradead.org; Wed, 03 Jun 2020 13:32:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRVZw3oL5hBQRkinBSVBiMKjWPSaXJLL9MXdCOXGvQ9aYBGBLEzcfhC+HjovVFa8RvSXCmJmyNkZJcuEOWoE4a6BLo4tCvn07AiZ0044gfHI0G5TRipd2ycZrWlCQ2XY93J2ZNVGPrnebkkevU/fEbbQI8f5UQ+Ad57Z8Yek8hnSfPJnbjM4Go+H83dbQ9DJ1g0FzhsVrW8e0eNvQmoRtwdI3PQkeYNOoJ2xhbikkB0/TwbRJKpA2Rd0swMV+RmJQKhuW8QlUaHh6j5dZBxyIK6DF9QDJtS9b9s/kTeF3+Ino5zuOh6LbMAvXItQrT3gvWKE3S6J1bG8Y0dai304pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZWW4TR5NLDej/8HkOj2Wb7EQmIexZdp7Z/lYd+VWrI=;
 b=JOk5rugUngzx0/c/V6kDkPX6bN8NfgnGBj+aaMNyqDAT6IAPiFi0uYMHk71oK/jx77Jldpb6pQg8096kOYMPt1y+Wtz+/fRKsRwj1U8fyuWPxqS8yvzvmgcYtEa1NMxqbsA5GV+9v+qFzHhYgTcc2UpFqrJ0HCscHTt1qph3TkUgGqFvy3PYCzB6w0SFB73720jel2pKPEZUUcx9QXOw2ICP2zfp0swjmXok+WpseTTjbrEEw+yviw9vs061Ebfs3q1ti2bpxmgiVKWpnXwCOJUfKUH9wdTqtnSOjBsASPBJqoNcwALgE6WDzGthHVGOgxCd1SBR38ME5PBJanFsRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZWW4TR5NLDej/8HkOj2Wb7EQmIexZdp7Z/lYd+VWrI=;
 b=LgSG4g83mDDBiDPAEyAYDqpPgB/X1Zailug8ny2SnDYWU2glVLJmphWYZb4qw1j49KnPguI1Yeayc4hV4nKNTw/wQx5BrhMiUzLbyMATeoOO44TvFkm7GE34SlqciNWUYTlXhFsz6KydspPQPvNTvwghR1KGTOiGvH4eBO6myMU=
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB5730.eurprd05.prod.outlook.com (2603:10a6:208:11d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 13:32:32 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::d05d:35af:3f2f:9110%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 13:32:32 +0000
Subject: Re: [PATCH 0/5] NVMe cleanups for 5.8
To: Christoph Hellwig <hch@lst.de>
References: <20200602131546.51903-1-maxg@mellanox.com>
 <20200603130826.GB13511@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <480ca984-9977-e47c-e4ba-03fbef82b0e0@mellanox.com>
Date: Wed, 3 Jun 2020 16:32:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200603130826.GB13511@lst.de>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0169.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::38) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (89.139.203.251) by
 AM0PR01CA0169.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 13:32:27 +0000
X-Originating-IP: [89.139.203.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7cf4ab3d-0f46-45bd-44dd-08d807c29140
X-MS-TrafficTypeDiagnostic: AM0PR05MB5730:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB573037BEA83A05490C3F5819B6880@AM0PR05MB5730.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ke1Z5cuAZlRDyWWYBWGxRcSrPNDRgreDEnLS69Opvfyr0J/fOOvhIGQ3KZfMJC3VsQKvjTcEnujkTm/LzPUQGthOPbUMdHMtvzteTSFjE3nmN9apwRiwE/r7mNr1Y/HNRixy7bRKXqKsTZjb2ZqVRpzyVLWa5SRAR8RNHZpaMu6N6cRTe4hR+hwaWdHXcKS7IlIO7FqO+jwUOd0IRBGDNRav+XLWT2eKIJh8rMTyYgYNFZgNnvJSQExr2d5+x5UGfURcqQ4ieOyiOy2QpnYBTsTOPAaMyPcrXk2uIFzmDS8J01hMpmfj5WXJu2iu7ToOdfn6x7xkHH9O3VF5OMO7ihpd49LLN1PsrGjYs9+1dWNvNfgot0i0ZvaV/1qVHJ10s130O0F2k2RSu7+xKhIrjfs14A9tX6d29fRmFVbb4Ny622RCpoJ5dHxWHkPiSp3zo2y9hWh/NB/GeDRP9jm8og==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(966005)(6486002)(66946007)(478600001)(16526019)(66476007)(66556008)(6916009)(45080400002)(2906002)(186003)(26005)(956004)(8676002)(86362001)(2616005)(5660300002)(8936002)(6666004)(31686004)(107886003)(31696002)(316002)(36756003)(52116002)(16576012)(53546011)(4326008)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: WZkVRnM8QOZb4LLYRPWjjSq4PGZdePfKjDSfJEaYvvIouFsxlg51wSbUgezyVn8KqHRoHzU5Gpvgstdb1nBf68gwhYMJRXq3uN1yotaY0cpSWpdWeIjNcvkTq2YtHbE4mT5JSqdFZGLHta1b7x+AMpSQvITfa0DihdpQNOfT4H0aPWKPX5A8hifZ1IqYq/DHokufRFhMEFqyrPhf6qXaIZRqzP16rtIEiByYIhiCgphwRpLtXTisX470IUU3XQGRZNamamxdwyT85zKPsthwb2UkVmWxg5LwYFrHDG/7QLIfptYqAdBTeGkzThWYYtJjTltpA2JjoQ2skCBsCWQV7ScfpklIsWVtrlV2tLTRhFmwGpjMKERTWHbJxEwuoIpJuEMVZV8RSqJYryhezkRq+sBSUXRn6OHzuPAkhpZaDjNG1o31Qe12ES5GP+VOkZk0SMf5r6W6Zb8uf/uEIR5a9yFPwEi2ZyBdJaA7z9mzhlUkTk5AdtqBw1uwDJGg6qFx
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf4ab3d-0f46-45bd-44dd-08d807c29140
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 13:32:31.8301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXBoLZVA2/NV/VgbyJGLc9lZAHar4A+Wsv+v/488SUWjM047NbRVEr5a+nkDYxgXuLb9DoX5rG3/vcRfEsTDbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5730
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200603_063238_717219_8529C07C 
X-CRM114-Status: GOOD (  11.10  )
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
Cc: sagi@grimberg.me, chaitanya.kulkarni@wdc.com, israelr@mellanox.com,
 james.smart@broadcom.com, linux-nvme@lists.infradead.org, oren@mellanox.com,
 kbusch@kernel.org, nitzanc@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 6/3/2020 4:08 PM, Christoph Hellwig wrote:
> On Tue, Jun 02, 2020 at 04:15:41PM +0300, Max Gurtovoy wrote:
>> This series introduce some cleanups and code/logic duplication for host
>> and target side. It introduces a new header file nvme-types.h that will
>> be used by both host and target drivers. For now it will include mainly
>> mapping structures from types to names, but in the future it can include
>> more common logic between host/target drivers (as done for specific TCP
>> and RDMA transports). The series continues with adding a flags member to
>> nvmet_fabrics_ops structure and removes the need for adding dedicated
>> member for each feature in this struct.
>  From a quick look this looks ok, but w're done with the 5.8 merge
> window except for bug fixes.

Ok so it can go to nvme-5.9..


> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7Ca5d736a6fdf14b4e6e8108d807bf3ab4%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C637267865201210781&amp;sdata=BHo4gR2xiT6WIgiE8BEReIiwVhfUfKcJl7zw651W0l4%3D&amp;reserved=0

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
