Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAE0C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 06:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N4UDQQ3+4E3oAFJUcZRc6Nsg471/aDlmoFnrAZcnV+Y=; b=B2PHcBAkdxzOi5BYC3jVHddYCh
	vaDS+vHkblIRxkXQIs+wBPsgxCi1+rBF8a1hMWnXJaGXjKGeVof4DoK8hmSbmBALcAiV6k+4s9ZKO
	ql5b8Gb+0MVvhctGzN79H3Ydz+4L1s50Laj1Nes0phTa8rlZzfjDDp1isx2a6vN5ryu+epM9/K8J2
	oQUIRRcf/SrSsAX2QJbe7bIHvfHSCyq2jyN13M6WWmdAxNVZ884XRMEM4ii/V4HJWFx9WOwoC4d8d
	I+VNcB+oB8KmnlvcehfBIcASC+jj7S/IPr0sqtQ83jHCn6frQVz0F+uml1SyjH/i0iDzN5G3v5oYe
	xZzS07OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjTk-0000000CkZ3-0NtY;
	Thu, 28 Mar 2024 06:43:12 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpjTe-0000000CkYc-0YV2
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 06:43:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9F0FD616CE;
	Thu, 28 Mar 2024 06:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF78C433C7;
	Thu, 28 Mar 2024 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711608185;
	bh=yPA8SyoA2brBq0mJQaKnU2hLNt90w9F+QYsLCClR88I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SifEzXyPGr5YdYZ3yVsUb//eWSbH+aFjM2uMorHd8+Lrl2aeWObv/9DKQMvi75cBZ
	 IE1TnNlBR/j1UkiN1fO7Uird09tSFH2hJQnvtIuOuTuauxWvW0rFNVJ8TvYfI9zlsy
	 AOsxtoMdR676g5muFbVzaoRzwqAWsj8/9r24AO8iTXXABzfpdyOc6JMz2D8N5VDgeq
	 8OITcYYUq8Zh5LhDTdXWik7i8rdTdMzFWHoYAGc6NSJ8RRigefQEkK6jVQbFPAk4ab
	 akxD1n5tVGfy7hgFm90eBjENusNtn7sIRZ2zI2ZuYbN1drKug39o/C36cl5aDtJHdo
	 qKfDNmjJJn6fw==
Message-ID: <6035bad8-b157-4705-8ec1-80cc003fa646@kernel.org>
Date: Thu, 28 Mar 2024 15:43:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/30] block: Do not special-case plugging of zone
 write operations
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-31-dlemoal@kernel.org> <20240328045430.GN14113@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240328045430.GN14113@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_234306_253520_6AF12097 
X-CRM114-Status: GOOD (  15.55  )
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

On 3/28/24 13:54, Christoph Hellwig wrote:
> On Thu, Mar 28, 2024 at 09:44:09AM +0900, Damien Le Moal wrote:
>> With the block layer zone write plugging being automatically done for
>> any write operation to a zone of a zoned block device, a regular request
>> plugging handled through current->plug can only ever see at most a
>> single write request per zone. In such case, any potential reordering
>> of the plugged requests will be harmless. We can thus remove the special
>> casing for write operations to zones and have these requests plugged as
>> well. This allows removing the function blk_mq_plug and instead directly
>> using current->plug where needed.
> 
> This looks good in general:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But IIRC we recently had a report that plus reorder I/Os, which would
> be grave for the extent layout if we haven't fixed that yet, so we
> should probably look into it first.

That is indeed not great, but irrelevant for zone writes as the regular BIO plug
is after the zone write plugging. So the regular BIO plug can only see at most
one write request per zone. Even if that order changes, that will not result in
unaligned write errors like before. But the reordering may still be bad for
performance though, especially on HDD, so yes, we should definitely look into this.

-- 
Damien Le Moal
Western Digital Research


