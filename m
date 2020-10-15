Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E80C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 17:24:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB93922210
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 17:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="13pGPOqV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB93922210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=interlog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:Reply-To:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=maqeP8UOw3c6NZjZdWKRBiCXZEDsPBP2vkZALXpdNtc=; b=13pGPOqV77U3dg
	tTv19mArJWEoLT5WwaJYElkbUseAY7ClwI7/jBikGgDKv0D8SQSBRNxEiAidBH6+6wKDo/m1WWmkJ
	Cjnf4ljAAu9g6PBJAH57KSmPNfydcZ34oRVUOcyHAXjXgObVynqcx8cNeEjIgoE6wPt6vENcgcVSc
	2UX9aFh6Y6DEcFSCK88DCsOnDvRvpf5KlDT6jmV3QgAAMV65V34C0QIPgDwwxIloi4O2OOfO+7vL5
	7dnSdtVQjtO0qZP+5emPPWALdkmQgk+eeuI2Q3kveICQytPNIcJQdT3g83hvfwDUzJQgj9ZsRgTjU
	aEwF9M+4VxwEYAcCwzEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kT6zb-00061C-RL; Thu, 15 Oct 2020 17:24:43 +0000
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kT6zY-00060n-Ex
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 17:24:41 +0000
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
 by mail-1.ca.inter.net (Postfix) with ESMTP id 9D6342EAC9D;
 Thu, 15 Oct 2020 13:24:36 -0400 (EDT)
Received: from mail-1.ca.inter.net ([208.85.220.69])
 by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
 with ESMTP id HSRawYvTTr4b; Thu, 15 Oct 2020 13:17:24 -0400 (EDT)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca
 [104.157.204.209])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: dgilbert@interlog.com)
 by mail-1.ca.inter.net (Postfix) with ESMTPSA id 846132EA092;
 Thu, 15 Oct 2020 13:24:34 -0400 (EDT)
Subject: Re: [PATCH] nvmet-passthru: Cleanup nvmet_passthru_map_sg()
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
References: <20201009231816.1524-1-logang@deltatee.com>
 <20201015075640.GJ14082@lst.de>
 <bc51aadc-eee3-cf52-0623-b3f82e1958f4@deltatee.com>
From: Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <7913172f-0125-e327-562a-aa6b842ab193@interlog.com>
Date: Thu, 15 Oct 2020 13:24:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc51aadc-eee3-cf52-0623-b3f82e1958f4@deltatee.com>
Content-Language: en-CA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_132440_520200_FFCD55E0 
X-CRM114-Status: GOOD (  16.11  )
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
Reply-To: dgilbert@interlog.com
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020-10-15 12:01 p.m., Logan Gunthorpe wrote:
> 
> 
> On 2020-10-15 1:56 a.m., Christoph Hellwig wrote:
>> On Fri, Oct 09, 2020 at 05:18:16PM -0600, Logan Gunthorpe wrote:
>>>   static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
>>>   {
>>> -	int sg_cnt = req->sg_cnt;
>>>   	struct scatterlist *sg;
>>>   	int op_flags = 0;
>>>   	struct bio *bio;
>>>   	int i, ret;
>>>   
>>> +	if (req->sg_cnt > BIO_MAX_PAGES)
>>> +		return -EINVAL;
>>
>> Don't you need to handle larger requests as well?  Or at least
>> limit MDTS?
> 
> No and Yes: there is already code in nvmet_passthru_override_id_ctrl()
> to limit MDTS based on max_segments and max_hw_sectors. So any request
> that doesn't pass this check should be from a misbehaving client and an
> error should be appropriate.

Running the numbers: with PAGE_SIZE of 4096 bytes and BIO_MAX_PAGES at
256 gives 1 MiB. From memory the block layer won't accept single requests
bigger than 4 MiB (or 8 MiB). Then it is possible that the sgl was
built with sgl_alloc_order(order > 0, chainable=false) in which case
the maximum (unchained) bio carrying size goes up to:
    PAGE_SIZE * (2^order) * 256

I'm using order=3 by default in my driver. So one (unchained) bio will
hold as much (or more) than the block layer will take.

Doug Gilbert



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
