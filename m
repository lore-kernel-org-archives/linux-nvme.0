Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D10C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:39:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7633C22247
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Eas5mNzB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NGoK7NXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7633C22247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+FXJuZpMceJFZI+L1gWgzeOlo1giFFGUTlOjeOJ5VZk=; b=Eas5mNzBWOl0uuMVYpPND9yup
	PRtQZoLS/hMBfKqjXUrkI6T3V2HM31PUvAiR7u7d6ssSZd+FZpJWSRHx0FZru4FKjNcRW+89QiuNb
	G9wJ1AtRUPunVc4H0/WnrnsEpxepVvDclE/16k7XaMtBFX6bC/QOiWeBANAWaYHwiim6AWrxrlJCJ
	4y9nZ/Ew4/tq7/+Rf5U41+2Ws8NVo+lCZMnyuDAnnQtTjgjuz7PgqLwCgcsQyiVzjtyk5Mh+55NHa
	/LW65/eCaYQiOqNoc0iYJK2gS81SCL7c+wea6ZclXG3G0pTev2eVDwz8nA9P6Yjue7KZx6zFvCCd5
	xi+lUBf9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUtja-0008GI-Sk; Tue, 20 Oct 2020 15:39:34 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUtjY-0008FY-9u
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 15:39:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wqPPzd8Uk8+HqVQf3NeXuFYMYYrVUyLFch0RVYE/VVA=; b=NGoK7NXla/CTiFL6aysc10UXrm
 UoaUYnUfCnwfP/Qdiw0fI3SrbdNivTwXSWaezpFmbJXEWNKIscS5oFDm+4X4R6zbr4oujjSLhut6X
 JqqQk023bMWAAeYi7isR+SkebQwFOlP/LdC6Zay8f0uTQzWf7+NdS2U53lXQKKqQJ37rbO0nzjjKt
 1h9deUbdVsBSO7W48MiEVAvoLecwHOZIAEUR0PoiOT2c4+Sstti+pA6t3ekLqSoegjPLW/ViXYyBU
 w7VHEROB0hWfJvS2OWvMv09FOpW0mZQSC0n3cJkN9ei6CFTMU4py3DzVLCfdzYGu4/JSw6sL+zy2u
 K1wO8I1w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kUtjW-0001qn-8p; Tue, 20 Oct 2020 09:39:31 -0600
To: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20201020014417.3604-1-chaitanya.kulkarni@wdc.com>
 <74e2bc85-3752-08fe-4f2c-07130ab4411d@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a37ee655-c215-2354-4d55-267b11d92ae0@deltatee.com>
Date: Tue, 20 Oct 2020 09:39:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <74e2bc85-3752-08fe-4f2c-07130ab4411d@grimberg.me>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/1] nvmet: allow user to set req alloc flag
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_113932_500216_CEF90A80 
X-CRM114-Status: GOOD (  15.34  )
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
Cc: hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-10-20 2:22 a.m., Sagi Grimberg wrote:
> 
>> Hi,
>>
>> When using NVMeOF target in the passthru mode we allocate the request
>> with BLK_MQ_REQ_NOWAIT flag. This allocates the request in the following
>> manner :-
>>
>> nvme_alloc_request()
>>   blk_mq_alloc_rquest()
>>    blk_mq_queue_enter()
>>     if (flag & BLK_MQ_REQ_NOWAIT)
>>    	return -EBUSY; <-- return if busy.
>>
>> On the NVMe controller which I've the fio random write workload running
>> parallel on 32 namespaces with higher queue depth results in I/O error,
>> where blk_mq_queue_enter() returning -EBUSY as shown above. This problem
>> is not easy to reproduce but occurs once in a while with following error
>> (See 1 for detailed log) :-
>>
>> test1: (groupid=0, jobs=32): err= 5
>> (file:io_u.c:1744, func=io_u error, error=Input/output error):
>>
>> When the flag BLK_MQ_REQ_NOWAIT is removed from the allocation the
>> workload doen't result in the error.
>>
>> This patch fixes the problem with the request allocation by adding
>> a new configfs attribute so that user can optionally decide whether
>> to use BLK_MQ_REQ_NOWAIT or not. We retain the default behavior by
>> using BLK_MQ_REQ_NOWAIT when creating the nvmet passthru subsystem.
> 
> Why should we ever set REQ_NOWAIT at all? Nothing prevents the
> host(s) queue depth from exceeding the controller queue depth...

I agree... I certainly found adding a configfs attribute for this rather
off-putting. Why would the user want an option that turns on random errors?

Logan


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
