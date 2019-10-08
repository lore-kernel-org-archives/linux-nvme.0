Return-Path: <SRS0=/gup=YB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A0C4360C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 15:59:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533AA206C2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2019 15:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XYneRJcl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0BwknLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533AA206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8mfth+mGT9WINJh7HysXYGWJlMrpZ0PYInnfig+Dghs=; b=XYneRJcloq+XFS
	1XgPHyPLmPoMZOZhJWuNb74zrcXbXtEYBTMsXkSl+dPjdZizixw7brY//H/5ySvC9JdnmDUxlQNR7
	jpfAOvsBBDCa2VMkr9O2wn/19acbt+WDI2avv8xTlL4UfDw8Vn3gN9nM+BEb7U2Y7T9upUXkAWlbq
	R15aM3yeOwSAlW+zTDbc2VAFUGgryvSBwk0eOYlNm28ZPd7VZdWEBhHS7Kpy3lSRVs7QHsMurvHlp
	LVQUlkcljxvK+08Smr/Y9ZmYZoIcyWHLnTRXuL4dN7jkOiJIXRQHEwTT+Q+mDk2ypy5bNv2U0bNrO
	aXC5EZhCL/ycJ9cMoM9A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHrte-0000NB-J3; Tue, 08 Oct 2019 15:59:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHrtb-0000Mr-Qd
 for linux-nvme@lists.infradead.org; Tue, 08 Oct 2019 15:59:33 +0000
Received: from C02WT3WMHTD6.wdl.wdc.com (unknown [199.255.45.63])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 41DF9206C0;
 Tue,  8 Oct 2019 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570550370;
 bh=p7M5THPrHJa0ZASERd+tyqVnV3NhY+ElDrqGTjZtVPA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A0BwknLlMbqJXtSETV5mHjMiq2yozGFDD1eZmmtF3NLSLe2wx4iSshWNAjVJXBlc8
 kHL1UtrsVHPRmILo5c7ZH1OQfXP7Y1kvApWuVGcwwsxKvDW8VCgOMmnjC+1vDfhXtU
 YTxXufs/E3AcW7waJ/5/S03vlvI1Cbytp1P6iR0g=
Date: Tue, 8 Oct 2019 09:59:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Vaibhav Nagarnaik <vnagarnaik@google.com>
Subject: Re: NVMe PCI driver ignores SQHD from completion entries
Message-ID: <20191008155928.GB23704@C02WT3WMHTD6.wdl.wdc.com>
References: <CAL26m8+WdjrKvnXDZdP4d2ekznfORDUV2Td6U6-DY9gcOqoOUA@mail.gmail.com>
 <20191005142722.GA30437@keith-busch>
 <CAL26m8+gM6KdrqpDTTQ_Tj7FGSd-qbcU78O0Ok3EaQ_B9rgHkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL26m8+gM6KdrqpDTTQ_Tj7FGSd-qbcU78O0Ok3EaQ_B9rgHkw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191008_085931_885063_C4021656 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: Abbas Companywala <acompany@google.com>,
 Bart Van Assche <bvanassche@google.com>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Eric Gouriou <egouriou@google.com>,
 Christoph Hellwig <hch@lst.de>, "Mihai R." <dizzy@google.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 07, 2019 at 05:32:55PM -0700, Vaibhav Nagarnaik wrote:
> On Sat, Oct 5, 2019 at 7:27 AM Keith Busch <kbusch@kernel.org> wrote:
> > Checking SQ head is required only if the host might submit more commands
> > than there are entries. The Linux nvme driver allocates enough tags
> > for the depth of the queue, leaving one entry empty, so having a tag
> > available means the next sq entry must be available.
> 
> But the driver does overwrite submission queue entries under process
> (which are already fetched by the controller). Are there guarantees
> from controllers out there that once fetched, the SQ entries will not
> be fetched again for any reason? The spec doesn't prohibit that.

Every controller I've encountered fetches commands exactly once. I have to
admit I don't find this spelled out in great detail in the spec, though
out-of-order fetching doesn't sound like it would satisfy the properties of a
queue.

Closest thing I can find is in section 4.1:

  The consumer of entries on a queue uses the current Head entry pointer to
  identify the slot containing the next entry to be consumed.

And later says:

  Once a Submission Queue or Completion Queue entry has been consumed, the slot
  in which it was placed is free and available for reuse.

If you have to re-fetch an entry, then the controller didn't "consume" it on
the original fetch. If the controller completes a later entry, it has consumed
an entry that wasn't the "next" entry in violation of the consumer requirement.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
