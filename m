Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B989CD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1fx1xVstgsJAW5b2x//Ww/cH/Fvg4rlZ9oQTLw7ipg=; b=w9Mz3dcMuvxlXRTc2HP7is3etC
	RsabpZxMnrdOE6PSmPz5+KEwN/uTsi/PIjmqjuOAe2nOpl1P/ri1zwanhdo6qROOxf5Q9rE6EqcPl
	pN0iPR72/SOvDNz2EXdbFJQbGoVxrFH/Smb861pca7uw884PdrLacfEQb/auHu0UqYnf5DcOvI4Ls
	fvr5v9vpSgcoV4rJ7zGfNFRRT5AB1ddxDLqWCsDgj3ugaPzNIJeV6HZSbEJH1/BYxRwfk0FLM1SU7
	RNSji/VPYvZrkUXcX4fCdLIG1iUIqP7mKP/KAoLBGWq/V97qOSKFP4sCgdM1OQNGPxHCt3Na2SIJC
	MgGIWkSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyRq-0000000FyfI-4ANJ;
	Thu, 28 Mar 2024 22:42:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyRn-0000000FyeI-31Zc
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:42:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF754617A6;
	Thu, 28 Mar 2024 22:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E527AC433F1;
	Thu, 28 Mar 2024 22:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711665729;
	bh=MzwB43EG7KeAx0YkElgFBYLwOHrbrRhvxrCVC4TpalY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Qkhou3GUD0yQYaq5sI+0HzRkxNEJyp94VPii0QzQzPdgLfR4i7I8REIyW2U0gW2Pw
	 FiFwOhTZ5BmhSiDSX+HsYRg7FnPA/bLg05I4IZZnhdnLOc33IElaadzyVDykKunA/N
	 3pjzV/zSWrf1GYawkpeAMbLYwP6jFZq44Echm0ummfcZz9vjlrU0ro6+gNmk3X59zn
	 otAvfZBXu3JfjXrMfnkDznrTzfjHJ1I0AjXvoKtQi1dm5UnSjygvw6Pba2KwGU1ptj
	 oaro5d/8YYhMPsaoSVBv/dlv+cBe+Tq66AfCNdH1OtZVoZKpSDh+icv0fmgKSYC0R4
	 Huv0NR4ajQmeA==
Message-ID: <a4727142-d533-4b75-bacf-ea0c016a3e67@kernel.org>
Date: Fri, 29 Mar 2024 07:42:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/30] block: Remove req_bio_endio()
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-4-dlemoal@kernel.org>
 <b09d7101-4124-4d77-b33a-977e2b555607@acm.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <b09d7101-4124-4d77-b33a-977e2b555607@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_154211_845878_955DDD2A 
X-CRM114-Status: GOOD (  13.25  )
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

On 3/29/24 06:28, Bart Van Assche wrote:
> On 3/27/24 5:43 PM, Damien Le Moal wrote:
>> Moving req_bio_endio() code into its only caller, blk_update_request(),
>> allows reducing accesses to and tests of bio and request fields. Also,
>> given that partial completions of zone append operations is not
>> possible and that zone append operations cannot be merged, the update
>> of the BIO sector using the request sector for these operations can be
>> moved directly before the call to bio_endio().
> 
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> 
>> -	if (unlikely(error && !blk_rq_is_passthrough(req) &&
>> -		     !(req->rq_flags & RQF_QUIET)) &&
>> -		     !test_bit(GD_DEAD, &req->q->disk->state)) {
>> +	if (unlikely(error && !blk_rq_is_passthrough(req) && !quiet) &&
>> +	    !test_bit(GD_DEAD, &req->q->disk->state)) {
> 
> A question that is independent of this patch series: is it a bug or is
> it a feature that the GD_DEAD bit test is not marked as "unlikely"?

likely/unlikely are optimizations... I guess that bit test could be under
unlikely() as well. Though if we are dealing with a removable media device, this
may not be appropriate, which may be why it is not under unlikely(). Not sure.

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research


