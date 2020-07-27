Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F27EC433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 15:44:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2931206E7
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 15:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M0N73M6K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="kjRUm44k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2931206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zGvq9m7cejKAWfhAJijGPt7OmEDXb0DV60KcadNLXW4=; b=M0N73M6KdHHA5ZdrZr7wCrQge
	5jrbpmlkk6IZr+J6yALT2m6nodrSnBQrjw69aAocW1fluyzrC8WOfqVHMMyeZm/aZSGYy4vKzTolw
	mGlyXbmoTT0692LH6/vASmJ6wEBtVrk5iLORvAuBbxcC5muAUKxJUyLVOO9KqsVbghEWO0v9zxSbS
	Scb3PdYvXNjMf32ax1qHdtpuyarDzc1Zh2hCVyRxw1pAY6aRwJPPsV0dq1zMtJ2QrK2NKIT6CJ/A2
	xO/IgE71huSZHurmNnIhTMy6GFKpMO1IkT10+RLY8KkGd9fm4xssvrCp6ccJqocc1jIBFcVyqLPYV
	4vIwI0eNA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k05In-0000RU-OO; Mon, 27 Jul 2020 15:44:33 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k05Il-0000Qa-Ms
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 15:44:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v9juTWF0gUqIQym5kftupp/yJY6WM8xbb3ynnrOV7Ec=; b=kjRUm44k6agr6xBlWPUhmI/zSe
 LD3CypdiCMTqy4ao7clkxItuhG/EWKGMWI4Qoz6Cb0IBN+QYxxm8+t0hgu/4POalYqV1HBDofGfGz
 ASolRjnbAWUvl8/OCaG4Wk7s2WPd2C2nKVazCQZH2KOhC4lxhlqWXmDw0Lu6SbswSjxsvfPYZhpdl
 g0oja+r6dw4DXSt1W4zNjvzkZLF1BSeOasDOb/2xQ1r5STH+Bs5ML2Jrufgo9fnZfMHYKfuF3pjgV
 qLIJbgnP/027CA/2YHgCOhWemQCrbnuTA5J3XollrxBA0Kpyuwi4beRxHPFHTyX0o+yIAShS+upRe
 Qf1qFknw==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k05Id-0002iR-9G; Mon, 27 Jul 2020 09:44:24 -0600
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200724172520.16318-1-logang@deltatee.com>
 <20200724172520.16318-7-logang@deltatee.com>
 <20200724193351.GA2857771@dhcp-10-100-145-180.wdl.wdc.com>
 <20200726154104.GA23930@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2963e23f-5f37-7720-f8f2-fb1a73f31ac5@deltatee.com>
Date: Mon, 27 Jul 2020 09:44:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726154104.GA23930@lst.de>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, maxg@mellanox.com,
 Chaitanya.Kulkarni@wdc.com, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kbusch@kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v16 6/9] nvmet-passthru: Add passthru code to process
 commands
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_114431_836170_51E2288F 
X-CRM114-Status: GOOD (  18.62  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 Jens Axboe <axboe@fb.com>, Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-07-26 9:41 a.m., Christoph Hellwig wrote:
> On Fri, Jul 24, 2020 at 12:33:51PM -0700, Keith Busch wrote:
>> On Fri, Jul 24, 2020 at 11:25:17AM -0600, Logan Gunthorpe wrote:
>>> +	/*
>>> +	 * The passthru NVMe driver may have a limit on the number of segments
>>> +	 * which depends on the host's memory fragementation. To solve this,
>>> +	 * ensure mdts is limitted to the pages equal to the number of
>>
>>                           limited
> 
> I've fixed this when applying.
> 
>>> +	/* don't support fuse commands */
>>> +	id->fuses = 0;
>>
>> If a host were to set a fuse, the target should return an Invalid Field
>> error. Just to future-proof, rejecting commands with any flags set
>> (other than SGL, which you handled in patch 1/9) is probably what should
>> happen, like:
>>
>>> +u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
>>> +{
>>
>> 	if (req->cmd->common.flags & ~NVME_CMD_SGL_ALL)
>> 		return NVME_SC_INVALID_FIELD;
>>
>> Or maybe we could obviate the need for 1/9 with something like:
>>
>> 	req->cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>> 	if (req->cmd->common.flags)
>> 		return NVME_SC_INVALID_FIELD;
> 
> We'll also need this for the admin commands, but otherwise this sounds
> like a good idea.  For now I've applied the series as-is, but an
> incremental patch for this would be nice.

Great, I can send one later in the week.

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
