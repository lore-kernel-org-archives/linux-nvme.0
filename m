Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A657DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:02:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F3664EC3
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 10:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F3664EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=V91Sc0sTCPSb4YWvIN7VYy6Ej/EjfQXM2UbXx1Skrgw=; b=yXebMPZQ2o6lED6WC+b6oUDPA
	Hj0ihkKFeJKe0D6cMbsPuY+es/mFb2TGGhI+BwZA25o9jEPISsiWmrPxSxrUP1dDazzjeUx9Nrzqa
	mk4oPDqpcmOUdytdVYOQaFEgCK0RKjBbaA6j8gD/B7p+NkXcHrZB59y/zgdTxGTtoTs5t37JLIctq
	oeJBbBAZfbAjVfLpxVm2y/IbTgYHpaimLEIamUMckafUhhpw6U7SwHmC/b+rafq1GYZxsr06JX3sk
	agAYS4jJxMy7vstL0/u7EZfxOBJycGa8TA0o0jvL/sp4NjMvccuwb6N/hTrSjXxMMt7uJA+s6IHzX
	ITKHwiQ3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEr0K-0005r6-F0; Wed, 24 Feb 2021 10:02:48 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEr0H-0005qh-T7
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 10:02:47 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B603624410004>; Wed, 24 Feb 2021 02:02:41 -0800
Received: from [172.27.0.5] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 10:02:39 +0000
Subject: Re: [PATCH 1/1] nvmet: allow setting model_number once
To: Christoph Hellwig <hch@lst.de>
References: <20210217181153.15343-1-mgurtovoy@nvidia.com>
 <20210224094347.GA5965@lst.de>
 <119dbae3-9dc8-a5d8-0f35-20d619931db6@nvidia.com>
 <20210224100047.GA9017@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <d770fb90-5000-87bb-e46d-2f18de6b354d@nvidia.com>
Date: Wed, 24 Feb 2021 12:02:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210224100047.GA9017@lst.de>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1614160962; bh=XQ013IeZonhZ8CHNh3euwTfYrI0kmv+Pu+Id4CAL/Ls=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=V8ekOEHDaUtdZGvw8ENkiPUFmvyefRnwUcXwB7gKJLmK/0oXi+bsRZIrbg7/jDK/j
 JGHivTotV7s8SwxxbapOmeVqZoHHa/+ElPvw9YvIKKFNxphQJjupp6nsvzmpd3QyVg
 YuN2MJD3KVFVr/UDYN55e2RzI6smScJ63xKbvvyxL9xS6a9nHcXGghxWsFCQz0QmdD
 V+jIDVeLifkSueocg+xrh77IfDC/KE/DDhunN9g2ZJLlFTTAFumUpH3fb9zYDJERt4
 bKnNJIhOGlZ0Q7394M1udcYm0UMycySlrQ3R3FCifr7peOgHQVjFBWhzovX8aAIXJ4
 0452rsvqhYXQA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_050246_086694_DE350216 
X-CRM114-Status: GOOD (  10.39  )
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
Cc: kbusch@kernel.org, chaitanya.kulkarni@wdc.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, oren@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2/24/2021 12:00 PM, Christoph Hellwig wrote:
> On Wed, Feb 24, 2021 at 11:59:22AM +0200, Max Gurtovoy wrote:
>> you don't need the id argument here.
>>
>> Otherwise looks good and it can be squashed to my patch.
> Can you resend it with the updates?

Yes.

What is the target branch ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
