Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC27C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 00:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z14ZE783l+7iieV+ubclQFtP82vwXIvYg+tNbKxoAjU=; b=OcwgPH29F2TIOd183elsQ0h/Ec
	E+Kb6qs1ebmHZFFW+oHMqfGYezA49K4XVKJcJHZn+F/6diqgQTaSuU2POBMcZ5LHvPiWCdVhJXLGb
	lQuMxjOoLZ2D8SxoKN4H0UL7rseBwqfAbDMSykEwnH9yVxDuaoV89OVn4f9EXu948izaHt35PgKsD
	IWecKbKWOw+C9wSNvgRwFtPvaQyB+fFuhm6jjCXXXVzkOGoGVl8uoaekZDL1Q51AZ54bYqD43g7ev
	A7+r+w1gKLcTUvZs/At/hPCXvJNhSfeeurnJXafvSY3mfxpuMscC/xgNwst8WptAPLZ7visTxbawU
	hnTHj5ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nimvY-007haG-P0; Mon, 25 Apr 2022 00:50:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nimvN-007hEU-Iq
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 00:49:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EF4C961382;
 Mon, 25 Apr 2022 00:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3504CC385A7;
 Mon, 25 Apr 2022 00:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650847795;
 bh=F1o86+c3i27P7lXaQREiQ3xGCoQJ5F/6dbeDXC2Hv+8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NNNl2oY39OmGQht4oPedgUc5AAbsNs5dCdeNish0v9zUwAm4Y9lbMjwf8EcfuAWup
 qcFw9YUWOwk6wbfJWvEo9T8S3AARfyUw0ONzssRewEuitHeBNB4tqp7lBcOoq+mcdW
 2A+BIncUk9HPmEyRctmQmw/afV/4FDqj47jTsuc3RmbpmHBbP+VpeTsaBV0zrMYXGa
 WRswl1PJY/bA5HC1DFZa+pnRsYqCp1NuSgeh0IHN0BGhXN7dhxCHwQMR24HPCckAmS
 i5f8Cjb/uHMB2kdNPcB/mQAUYAK8tadxIH//xkb5mqksoYP2avFOrAHMUfAuN/hCsF
 oKXRoocw/A6gQ==
Date: Sun, 24 Apr 2022 20:49:53 -0400
From: Sasha Levin <sashal@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Klaus Jensen <its@irrelevant.dk>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 axboe@fb.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.10 18/18] nvme-pci: disable namespace
 identifiers for Qemu controllers
Message-ID: <YmXwMUdka3m01hUV@sashalap>
References: <20220419181353.485719-1-sashal@kernel.org>
 <20220419181353.485719-18-sashal@kernel.org>
 <YmBWdMfQ/WIACcTg@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YmBWdMfQ/WIACcTg@bombadil.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220424_174957_702191_C4ECE1C9 
X-CRM114-Status: GOOD (  17.02  )
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

On Wed, Apr 20, 2022 at 11:52:36AM -0700, Luis Chamberlain wrote:
>On Tue, Apr 19, 2022 at 02:13:52PM -0400, Sasha Levin wrote:
>> From: Christoph Hellwig <hch@lst.de>
>>
>> [ Upstream commit 66dd346b84d79fde20832ed691a54f4881eac20d ]
>>
>> Qemu unconditionally reports a UUID, which depending on the qemu version
>> is either all-null (which is incorrect but harmless) or contains a single
>> bit set for all controllers.  In addition it can also optionally report
>> a eui64 which needs to be manually set.  Disable namespace identifiers
>> for Qemu controlles entirely even if in some cases they could be set
>> correctly through manual intervention.
>>
>> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Keith Busch <kbusch@kernel.org>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Huh? The NVME_QUIRK_BOGUS_NID is a new define and the code which uses
>this quirk is also new, and so I'm curious *how and why* the auto-sel
>stuff for stable can decide to merge this and this should not even
>compile? I see this was backported to v5.15  and v5.17 as well.

Because we take quirks for -stable?

It does compile apparently... At least with the configs we test.

>I didn't get Cc'd on perhaps some other patches, but this immediately
>caught my attention as not applicable, unless of course the patch
>"nvme: add a quirk to disable namespace identifiers" was also sent
>as part of this series to stable kernels. And if that was done, well
>holy crap, really?

Yes, it was.

I'm not sure why we shouldn't be picking it up?

-- 
Thanks,
Sasha

