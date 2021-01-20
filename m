Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D79C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:03:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745572332B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 10:03:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745572332B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sEqfftBhJIVl7YUFEv7isc0UqzMds5nuk36wPNhFfhs=; b=zPtFL5wDtf+R+vs9HGEjGIhOH
	eWSmJOzvcHscxrFPxKg+6EoxXxQIzjxgf3lV/D3s/WgnWJvfUDsNHjhsr67iT+C7SsQXDBAfM+4Ix
	6a1gTm8HzogV5zgG6zuiAsfapU4C/iTnsR01ooI4lgsEKy4HEgduATE2OuFinJ4hBs6ngQm92sBHk
	Y1HCkW40G7aDEoV3XaOMsrnj57ywgwGzxt6QVl0oEqSONxCd9Ejcj7G2X8tTUbYPHM/l7vDTPngrO
	gKss+R7fgySdgPWCG1N9zY/MxkM1rzVhgckBDB3gFPhYGuxahG/+zgwYBAXGgMJDT9Y0p70nzESks
	s74E0uvTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2AKV-00063V-2F; Wed, 20 Jan 2021 10:03:11 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2AKQ-000634-Hc
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 10:03:07 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B6007ffd80004>; Wed, 20 Jan 2021 02:03:04 -0800
Received: from [172.27.0.39] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Jan
 2021 10:03:01 +0000
Subject: Re: [PATCH 1/1] nvme: update enumerations for status codes
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "oren@nvidia.com"
 <oren@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
References: <20210104125947.160984-1-mgurtovoy@nvidia.com>
 <BYAPR04MB4965E1DC0180C2E5789E505186A20@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <55ebc8c7-5631-1f99-1384-80ca85c26b0d@nvidia.com>
Date: Wed, 20 Jan 2021 12:02:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965E1DC0180C2E5789E505186A20@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611136984; bh=1wKmsNQIARYhLwMxHc7J9fQ6tULlfRjqH1omIIKeO4Y=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=QS6IqfZ9QVb6SgtvGj882VWsoJqhCxDs9WznvIKmpp5gjcLu4v/XpkMnhON/pFpoL
 ZdLs8I64g9je0fOGi/cyowRAqxjGIzzDNbnZFF0J1fId9aV1feVHKwubPyaiKUbRC9
 1Z/ujqy20nKL2r/SNgp9c+1jquPNe96VnjA66UCom0L56XVIgi76FDbEGL2+22wyfV
 53xBk08tE3Q94r1pBwGuozD3f7y8+mLzgzXtqymd7x8VmO55hu78zdlLYUPKrUg547
 qFAFZhaavn/L0gVrhh5sdPXPnjm9t9EOZ04xDCiGg+flZrJNG3/+P/3bY+O9WAT1pF
 aScvzMXfonjmA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_050306_661516_F6D6C04D 
X-CRM114-Status: GOOD (  16.94  )
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
Cc: "israelr@nvidia.com" <israelr@nvidia.com>,
 "nitzanc@nvidia.com" <nitzanc@nvidia.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 1/20/2021 7:09 AM, Chaitanya Kulkarni wrote:
> Max,
> On 1/4/21 04:59, Max Gurtovoy wrote:
>> All the updates are mentioned in the ratified NVMe 1.4 spec.
>>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
> I'm not against keeping the header file up to date with the spec,
> but should we add the error status into the kernel code even if
> we are not using it in the host/target driver ?

I we go with this approach we should remove half of the code inside nvme.h


>
> Here we add 24 lines which we have not used at all.
>>   include/linux/nvme.h | 24 ++++++++++++++++++++----
>>   1 file changed, 20 insertions(+), 4 deletions(-)
>>
> Regarding the nvme-cli this is much needed a sync since it does
> decode all the errors if I'm not wrong.

I can sync it in V2.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
