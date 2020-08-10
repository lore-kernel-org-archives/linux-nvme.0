Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC4C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:10:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2286B20748
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 22:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MODXPrPR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="FkLHi7+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2286B20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SQP1a4dS1bsgYxUodx+furiN4eLM5nRtLrO2KgMB5i0=; b=MODXPrPRDCBY7yzCJQ9waLsvp
	/JTP1QRJn0U0Ur8SAG8oAxYrcyFBIZ+l/W1OYBwcRlnjjAn7ThR980PK/vujX89pR0VlCVLhU/4hM
	+SGRZCoq3MHQiN5VHlp1E6Uz7jaMMZLS4zo/kj38JLYRbsN2HZPgvTyTwS55vtjyJutS+oZrUd3Hp
	Dv4ryIexx9D89q4CKu1iLzF/RLrm+5JIAcAVo6HIOPbrto2uWGc5QUmb6NtH4aNzyj8E58/UTel/Y
	jlbcpT/6HCsn/+jVkjofpmv7dK3jqZQUx+AbfHL9zG/u6jKdfiyx0f02c9ebo9ZhPd9CulRh3MHzJ
	nXNZ5VG1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5G05-0000UV-4H; Mon, 10 Aug 2020 22:10:37 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5G02-0000U0-22
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 22:10:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N9wLwYPHNbAdcv0L9rUPSTqv6uqqPv3pS2nOVxhF+RA=; b=FkLHi7+lSt0ZeYctjLuf4BR+JU
 Zre5KjxYfV1RPnSBaIV7T1vDQm7JQLtYwpaqBRCjN6r2T1E2YdBVKBkLTXfFHAatquCw5NSXJN3M/
 8Zh3UBeAKxcys6d3ZWglzQfAKmwf2/eYtQ89/kVkMQqi4JgPc+GuykWh/hfkUfUCaw1ywMi9gJGC0
 M2rmEVxeXLJJxJrpxJ4HBF/VIcJisxdzP3/1xPS4NhnkajFARkKtDOfXAlVVpXBUmMnvgI/nCHebw
 lmWdeRq2l//ZL7K38CXt2xCF4bXPY2uQmO+Zx7ha/fMHMbZ90Ck8z2pPkvj1EtpheV5WO0qDdsXza
 svihKJ3A==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5Fzy-0000ia-HE; Mon, 10 Aug 2020 16:10:31 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-8-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <367b5571-2981-8389-a5fe-f0bea20d2e33@deltatee.com>
Date: Mon, 10 Aug 2020 16:10:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-8-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 07/14] nvmet: reuse pt-req-done for rq completion
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_181034_154455_453298AD 
X-CRM114-Status: GOOD (  13.35  )
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
Cc: hch@lst.de, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
> In the function nvmet_passthru_execute_cmd_work() after overriding
> id_[ctr|ns] results it completes the request by assigning the target
> request completion queue entry result from nvme request result,
> actually completing request on the transport and calling
> blk_mq_free_request().
> 
> The function nvmet_passhru_req_done does the same thing, use that and
> remove the duplicate code in nvmet_passhru_execute_cmd_work().
> 
> The last parameter for the nvmet_passthru_req_done() which is
> blk_status_t is not used since we derive the result from the nvme_req.

Christoph had specifically requested open coding this in earlier feedback:

https://lore.kernel.org/linux-block/20191010123406.GC28921@lst.de/

It was originally called nvmet_passthru_req_complete() and was open
coded at his request.

I think the way it was merged ended up being cleaner and easier to read
as well.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
