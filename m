Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DDD7C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	Content-type:In-reply-to:From:References:Cc:To:Subject:MIME-version:Date:
	Message-id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ApYvMZAdcht4TuxINHU06qR0evDmcGeYdQJ2jN5Iu0M=; b=0YxvIPVcpFdhkY3pKuHQ5tM/Cp
	5M6Eh+SlUjdM45YpPCLmEcC5con13OngOMWVpD+KA7WjojhDvXPhqknB1Bug/4kspHCn9g6qHqHHM
	ueRkdbg1gawGl6sn/YyP4ywDWMdsgGQZ0F/J25acO3FEmOu6Fb5fEnzP3hCs2Gmvnd+zTgdP8MAK+
	gQ5B/ABnVELGsftRnCthtF6ztEVEZ2IjcVXEagAAd9dS1oNEHfuCNZ+R9wP3jL7/y+PGg8U+q6E9X
	WxXzNhDtFlEQIoQnWe/1i5L6K88FGh+FxjlfdaoxNxgMSP3lT7jFfUXtSt88VM0ve6qRI6Rx1Lkik
	j0TwhIig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYye-00HAij-1b;
	Mon, 31 Jul 2023 19:54:48 +0000
Received: from abi149hd125.arn1.oracleemaildelivery.com ([129.149.84.125])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYyc-00HAi6-14
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 19:54:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ApYvMZAdcht4TuxINHU06qR0evDmcGeYdQJ2jN5Iu0M=;
 b=uPbrlxINyTbk0xDEKLNPuEnPz00ELPAqDUwA60Mnc5KrPVOefmisSQxRSdnP/8++FfunUihhi3jp
   E6jmO95xJvBfzMzYerhgygg/2hGP5Fb9/byedmopUEhI38ts+ETtPMye2YnqO49UTNJknvR2HIae
   YBwyRZNBxP3BhlVhmJsoZZiGMbH5rEaB4a3yaN75L35mPoG46919Y22GZp4E4i+vV2jgslUN6mT+
   PuQ0+jYT4m8LdsLWXiHRuAqaAEmTJP7sK+WOpNceGIjbweHnNV0ELWssPZ51CWmdczk4BXYQ/Y9V
   +nJLO1wmg+h2hYu94nMt7x50D+kgbFBWv0TLYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=ApYvMZAdcht4TuxINHU06qR0evDmcGeYdQJ2jN5Iu0M=;
 b=ZE9p12PndKQU3/xYesCzM4nZrIddzZyNh5tJgaBGsp8/qf7nyc0GwMi6BfmN55K5DqBT4NV5czKx
   6bokZCKWigwbp33rGHN1U4uS9erP6dVZh4SOjkAIwVKIBz9kuTEiH5MEw0PvVwFufk8Ow0CeRAKM
   WN9NST+ScUgY9gRT1GNYm6sY7SMzndeqslqBxGk0ATsYuuz686yui9orUeHd5IXfX9u6G+eKNWS7
   Z+evzo/3jC+oyiKD3PAhBCazsIsKPvMpqU2kGeZv7LVcttiw683uAv1ut7yo07wixSQCc1JHZFgC
   J3G/y8n9uFWIr0qiJaTXw9Zi5i6b0e2FfqSqfQ==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYO00KTQFB79W80@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Mon, 31 Jul 2023 19:54:43 +0000 (GMT)
Message-id: <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se>
Date: Mon, 31 Jul 2023 21:54:39 +0200
MIME-version: 1.0
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Content-language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, nilskruse97@gmail.com, David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
 <ZMgHE2wu4T4OfrTR@kbusch-mbp>
From: August Wikerfors <git@augustwikerfors.se>
In-reply-to: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAGxKd0J+EDPNkJxyVSwXV8t9u0oYmwvO47EmDb/N7KkuuHQNewGDNL7XqL4XvXk
 NwsfeuoNmYe+xIBGUiA/iGydppa6afCXI4nR6OL6yk2decP0iJyC/hKQBpLtLSGG
 U1dwMmp042ebDj0UXNnD7GKSU+GsWd5wS9RCIUJNt3GY8U/s2djFUEiBVBHt3X//
 swO9KmWWDOp8QrKnsBxDE2XTP1g9l5opWDqR0QB4c3oibBlme3mymhtXs9T3m2uN
 nuCUVhKov5lIuAmrVJoUCsFvdpM3ZzZ1mhRTZnzo4dQX80WFLs6d4C51lm4o8erC
 THCt51CyiSPpIjWior9td1DGhsqcorhJ3LfscTlK9g8Et8aNsSuBSWOyUUKT2zde
 oOhiYGQSeddWf29lksd2iRtIPj9dToiMHaCC68fMty31y5wZDvOABKuNNNkj1UpZ nU0jTb6+/Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_125446_375169_A62B1B6D 
X-CRM114-Status: GOOD (  15.53  )
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

On 2023-07-31 21:10, Keith Busch wrote:
> On Mon, Jul 31, 2023 at 01:51:03PM -0500, Mario Limonciello wrote:
>> Samsung PM9B1 has problems after resume because NSID has changed.
>> This has been reported in the past on OEM varities of PM9B1 parts
>> and fixed by firmware updates on 'some' of those parts.
>>
>> However this same issue also happens on 'retail' PM9B1 parts which
>> Samsung has not released firmware updates for.
>>
>> As the check has been relaxed at startup for multiple disks with
>> duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
>> probe due to duplicate IDs for single-ported PCIe devices") also
>> relax the check that runs on resume for NSIDs and mark them bogus
>> if this occurs on resume.
> 
> How could the driver tell the difference between the device needing a
> quirk compared to a rapid delete-create-attach namespace sequence?
> Proceeding with the namespace now may get dirty writes intended for the
> previous namespace, corrupting the new one.
> 
> The commit you mentioned tries to constrain allowing duplication where
> we can reasonably assume the quirk is needed. If we need to do similiar
> for this condition, one possible constraint might be that the device
> doesn't report OACS bit 3 (Namespace Management).

It looks like that would work for the PM9B1:
> $ sudo nvme id-ctrl -H /dev/nvme0
> [...] > oacs      : 0x17
>   [10:10] : 0   Lockdown Command and Feature Not Supported
>   [9:9] : 0     Get LBA Status Capability Not Supported
>   [8:8] : 0     Doorbell Buffer Config Not Supported
>   [7:7] : 0     Virtualization Management Not Supported
>   [6:6] : 0     NVMe-MI Send and Receive Not Supported
>   [5:5] : 0     Directives Not Supported
>   [4:4] : 0x1   Device Self-test Supported
>   [3:3] : 0     NS Management and Attachment Not Supported
>   [2:2] : 0x1   FW Commit and Download Supported
>   [1:1] : 0x1   Format NVM Supported
>   [0:0] : 0x1   Security Send and Receive Supported

Regards,
August Wikerfors

