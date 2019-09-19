Return-Path: <SRS0=DlcY=XO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB337C3A5A6
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 14:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEC6E205F4
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 14:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OaeiyamI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jN4dbbHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC6E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8EAeLVLf59Nk4OuXIH9mVW4LR8jfzh5hK9uoe5InJoo=; b=OaeiyamI60okou
	szkEov+RwWD8NICRkoW0p5amGH+Fc0ePPq9QPaf8dWKOZnLjwMKZrvc+hCLrNrGSoYQZk7Llg+dgl
	RKYk9aNq79a2q95hp6yXNVUnrC31Y6pp0ND+7y/ZQYcAiaGYkG4jApftmilvp/d5ZCTOrdgrnmA0Y
	WJQMSOl4OfUK2v3bDq0ZXxwbM9ddEWupt4GNcVb+qNg41zWGXq9SYSBQIBY1XIn6MgHBBrAL8AzBE
	PAQtSti6hM8e42icPrhjdWhW9kxh4ZPspou68JxT4LpD744RjseyuG617oQp7gTPfnHxpihiu+AbW
	GhONXBETwbfLgJN2Rs6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAxBD-0000fq-3q; Thu, 19 Sep 2019 14:13:07 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAxBA-0000fQ-5j
 for linux-nvme@lists.infradead.org; Thu, 19 Sep 2019 14:13:05 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 329CD2067B;
 Thu, 19 Sep 2019 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568902383;
 bh=Fduf10OMcAOvnRZMP54/18uKfFU1Trz0JGIfeGeiB4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jN4dbbHT21aYx902Chc1XXK8Kdi9Df4rkc3LIUIfNdMNrCDpcMm/HGWxuJVKpj41j
 UqzqSFg+JVY61WyyiE6LgTiPPxrk3kXuwgSfcumAmWgylc/3arkAL47IZGS0bxVKeY
 +VVd/nu3WZlz/ol+YKw71u/gNP84D1k5TAXs8uDk=
Date: Thu, 19 Sep 2019 08:13:01 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bharat Kumar Gogada <bharatku@xilinx.com>
Subject: Re: NVMe Poll CQ on timeout
Message-ID: <20190919141301.GA61660@C02WT3WMHTD6>
References: <MN2PR02MB633689DBBA6DE9DD7A34043FA5890@MN2PR02MB6336.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR02MB633689DBBA6DE9DD7A34043FA5890@MN2PR02MB6336.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190919_071304_242270_070AA545 
X-CRM114-Status: GOOD (  13.28  )
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
Cc: "keith.busch@intel.com" <keith.busch@intel.com>,
 Keith Busch <keith.busch@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 19, 2019 at 01:47:50PM +0000, Bharat Kumar Gogada wrote:
> Hi All,
> 
> We are testing NVMe cards on ARM64 platform, the card uses MSI-X interrupts.
> We are hitting following case in drivers/nvme/host/pci.c
> /*
>          * Did we miss an interrupt?
>          */
>         if (__nvme_poll(nvmeq, req->tag)) {
>                 dev_warn(dev->ctrl.device,
>                          "I/O %d QID %d timeout, completion polled\n",
>                          req->tag, nvmeq->qid);
>                 return BLK_EH_DONE;
>         }
> 
> Can anyone tell when does nvme_timeout gets invoked ?

Timeout is invoked when the driver didn't see a completion to a
submitted command.

> In what cases we see this interrupt miss ?

That usually happens for one of two reasons:

 1. The device didn't send any MSIx message for a CQE

 2. The device sent the MSIx message before posting the CQE

I've also seen h/w errata where the MSIx and CQE are re-ordered, which
can also lead to this.

A hardware trace would provide the most detailed view of what's
happening. You might be able to infer if you carefully account for
commands sent, interrupts received, and spurious interrupts detected.

> We are seeing this issue only for reads with following fio command 
> fio --name=randwrite --ioengine=libaio --iodepth=1 --rw=randread --bs=128k --direct=0 \
> --size=128M --numjobs=3 --group_reporting --filename=/dev/nvme0n1
> 
> We are not seeing issue with --rw=randwrite for same size.
> 
> Please let us know what can cause this issue. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
