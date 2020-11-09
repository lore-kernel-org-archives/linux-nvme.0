Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A11C388F7
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 15:05:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE9320853
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 15:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q1hezkr5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbgPZG++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE9320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a7EGoBenTl62jlk8h2SO5C5LUrpNTu1v9bvzhcfforo=; b=Q1hezkr5ensKovcgUKi0tvozj
	pg+BrAEuFLsw1Hin9daAA5ETzUpfdbmP8p7hMJCqk2mRqAmHo4gNs79TeGyaTZS1+iSCrC3QftV0o
	kP5viAMkDL2wTCJnhZ0FKuvjHBd9HhGWtw6PZYXO79cWjjvyuLPoaA8I2PO+3E7loRKtOZ31xN1KH
	PYowlAtMd1B0rwel2LC1awDYE1Aj89kKTjsorZgQ8nrawknAlznvf+1kbta7gpkF2foanZ1Xn/SB4
	qyVYlKSvRla2/iT6cS0kSfQBEF7S0ULRIFvew30Uhg0clY+8m8EattvGJqFDWgZ7nKh8fg4VnNvBW
	KnbOPEONQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc8jT-00015E-P1; Mon, 09 Nov 2020 15:05:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc8jR-00014W-Cj
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 15:05:22 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CB12520853;
 Mon,  9 Nov 2020 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604934320;
 bh=5Z5l2kahgouLK3P1lyzr/yn1CMXxlexBvUGlXRedt7o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LbgPZG++83AGaB20514ACzKjkobGB6HNqxVlsHCxz6fr9nU6pgDVrLWRJXywC6O9a
 syNdo+9lgNxUzBaY7cE9ajgKQS969zdeB537TeLSuAq7W99Deyq/5Ju9M7QCwzxQsJ
 aoi6wVj3b84saljvr+IU63pqDE9kTF1BuznA6plU=
Date: Mon, 9 Nov 2020 07:05:17 -0800
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme: Boot as soon as the boot controller has been probed
Message-ID: <20201109150517.GB2221592@dhcp-10-100-145-180.wdc.com>
References: <20201108040903.8185-1-bvanassche@acm.org>
 <20201108082403.GB40741@kroah.com>
 <20201108223152.GA2219646@dhcp-10-100-145-180.wdc.com>
 <8ee7a7b0-5be4-99a3-7314-77d784e2ebb7@acm.org>
 <20201109023544.GB2219646@dhcp-10-100-145-180.wdc.com>
 <90da3071-0d73-f007-5892-d683de71d964@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <90da3071-0d73-f007-5892-d683de71d964@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_100521_523694_475CCE72 
X-CRM114-Status: GOOD (  19.58  )
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
Cc: Greg KH <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Nov 08, 2020 at 08:00:42PM -0800, Bart Van Assche wrote:
> On 11/8/20 6:35 PM, Keith Busch wrote:
> > The only user space visible artifact the driver creates on bind is the
> > controller character device, and access to that during a reset is
> > handled by the driver's state machine.
> 
> Hi Keith,
> 
> Is nvme_dev_fops associated with that character device? If so, in
> nvme_dev_open() I found the following:
> 
> 	switch (ctrl->state) {
> 	case NVME_CTRL_LIVE:
> 		break;
> 	default:
> 		return -EWOULDBLOCK;
> 	}
> 
> Does this mean that nvme-cli will succeed or fail depending on whether
> or not nvme_reset_work() has finished? Isn't that something that can
> cause trouble if nvme-cli is invoked from a udev rule?

Resets can happen at any time, so user space should always have been
prepared for this. Is there actually a real case that is not working for
you?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
