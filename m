Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88FBC433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA43D206B5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QCdzgkEE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="R58JFuPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA43D206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5jHfu/90XEP+oD4Pjfa1l2Zl8jXd/oyRhmgCgsN+t90=; b=QCdzgkEEmsSzu+6yBBGQSGUP/
	lUISnNuViAiJcp3eG+Nz++Urkl7P25YUreFb42lHnvRWjBCZyDBVFOU3X23RTLdxZGWXj5mapbXLJ
	hc3GQbhw2ipA6Mi8eHI2hZBkGst9uPxP1VKcP7NqKejvCDAA6ZDhx24xwnZ6FRF2C8rHNuzksUXea
	u4nFn3ROCTkiLuILkeHMjU/YoaUJoDUCAfurpVFSbquJKIAptYRnFz9oLPeqtmNSPp1OyaPdhxlhV
	R5CUTBv9AwO1/HpS6vKKjpsqeJQ0hPsPVjszuxACLC+FrW82niJ3Z34VEbgCuryLxS/G1xXVD3bYC
	k5kCBX6Ig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5FkC-0006RQ-U1; Mon, 10 Aug 2020 21:54:12 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5FkA-0006R6-Fp
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 21:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qwgm4D3xxLDCJmz8MXFEac5NC/tr8yXMYONlUGMBBcw=; b=R58JFuPrdKYyPjeJHHsA1M4Gk3
 7icykCLWfyma6/Rs8JaWqe799RpkK3Hrz3yQ4eGat+1tCr8aAuulNX6r9DD43zSiLUS8RFL68Te65
 txgUQU2pw71AHcJAEe2Iv+ULZfN/UnnbACYMwhf3BoXgY7iHr9BedijdpiO7yZFDKoEtbl86eJP5K
 9T6mq3e16IdXxiFBicfBrf5uON7/Md8EUik0sG0uNMw5MuyRDVJRGacln+wCY2hHcIszyxFlE7/Zp
 8kIUwRRnQ/upjMkNybV6aMjO5Eqd0275jXHT2ornRPFYBgKPB0WvuYxZJniLVxvUEC5k1oXXCxDqn
 ePqrE1+A==;
Received: from [172.16.1.162] by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1k5Fk5-0000AN-Vi; Mon, 10 Aug 2020 15:54:07 -0600
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-2-chaitanya.kulkarni@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <53dd1aa6-31a7-a9bd-6def-5cc18468845e@deltatee.com>
Date: Mon, 10 Aug 2020 15:54:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810185456.7713-2-chaitanya.kulkarni@wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
 chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 01/14] nvmet: for pt I/O cmds annotate req->sg_cnt likely
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_175410_584421_9E16EFEE 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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

Hey,

You forgot to CC me again....

On 2020-08-10 12:54 p.m., Chaitanya Kulkarni wrote:
> I/O Commands (nvme_cmd_read, nvme_cmd_write) are most command commands
> when accessing passthru controller. For I/O commands data is represented
> in SG list, so sg_cnt != 0 in most cases.
> 
> Annotate req->sg_cnt check with likely.

Does adding these likely annotations actually produce any benefit? Why
can't we rely on the branch predictor in these instances?

I vaguely remember somebody complaining about all the extra likelys and
unlikelys which is why I removed them.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
