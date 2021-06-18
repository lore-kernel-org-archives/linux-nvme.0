Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40743C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 19:19:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F3161057
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 19:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F3161057
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S6IadJck9FQy9W53kN15E8ZSq26BSlw60brvLpz2u4c=; b=OOAVlstHhhkAAB
	/+/mvZWa7691Tc6vjghG57rvZTvETnwf4wz5q69yH1TnB2qRhdgE2PUqLnOwzEKI1kwbVRUyxooMI
	oa5Q9WQsTlIuj33FgVaOuo2OziZ9fRc9ekAWFGE2Ot7n8pRwQ/5SlSbJ3B4MBQ3G9I6YEikyexutR
	ZpajlJM3y6f1w8sI2zy2iDXVU7IoeYah+gnP2IAlVqCS2irI52jul344eRGXh1WBoenAjDf3zEiv9
	t+4Yx08FoQFydwROnPapAkgeXbXDgTrFoJ2fpppLT9X2en+dns0/1j3YEpOKtYYff3p3CPiplhuwf
	Wqetm5tFsQzFImFD/uSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luK1P-00FGtj-Vx; Fri, 18 Jun 2021 19:19:20 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luK1N-00FGt9-Hy
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 19:19:18 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1624043953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSLxGC3VTRMA2Whz78he85SSFCN5pOWp9Ja2rRincrE=;
 b=Nh4soZq81bzyJPDPuk6OzK7HF4t54zEr2or1xJZHbE/JpRDaIB2XoDCYU9n1UiBMxI+SpZ
 gYAStHegI/oNOuab4hNo8UKqfktYNa6DHie9NnNhpHnOi3ZTmOnHBRS9t6Mwni1Sw0CrRv
 2++Ypt6yi9HJswKEy/4ehOO1ygPmj9JcbMcNedlZGwJwRriy8Sdg1U6HWjRRrw9tto4BTC
 /TfF50Bzzxe/CTixRdGbI9ln6URYNxw0lM/9SNRLk1Q9BPybWFiwTOEWlCLd3VT237g679
 Kl5ANInl8B/rrHu6xEerRqfVGkFhf2eavm+zWxVhvBbP6DegejfN/f65ELFQeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1624043953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sSLxGC3VTRMA2Whz78he85SSFCN5pOWp9Ja2rRincrE=;
 b=RSZzBGebnC17LsPojYK3bBoRQRgGmd+zjyPW5m11as59RHQl5NDNcQRPMID7YkOywbpvre
 Lg6856XaSEqMB/AA==
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 Keith Busch <keith.busch@intel.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 3/7] genirq/affinity: Add new callback for
 (re)calculating interrupt sets
In-Reply-To: <20210615195707.GA2909907@bjorn-Precision-5520>
References: <20210615195707.GA2909907@bjorn-Precision-5520>
Date: Fri, 18 Jun 2021 21:19:12 +0200
Message-ID: <878s37f0b3.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_121917_780253_7085D88B 
X-CRM114-Status: GOOD (  14.92  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 15 2021 at 14:57, Bjorn Helgaas wrote:
>
>> @@ -1196,6 +1196,13 @@ int pci_alloc_irq_vectors_affinity(struc
>>  	/* use legacy irq if allowed */
>>  	if (flags & PCI_IRQ_LEGACY) {
>>  		if (min_vecs == 1 && dev->irq) {
>> +			/*
>> +			 * Invoke the affinity spreading logic to ensure that
>> +			 * the device driver can adjust queue configuration
>> +			 * for the single interrupt case.
>> +			 */
>> +			if (affd)
>> +				irq_create_affinity_masks(1, affd);
>
> This looks like a leak because irq_create_affinity_masks() returns a
> pointer to kcalloc()ed space, but we throw away the pointer.
>
> Or is there something very subtle going on here, like this special
> case doesn't allocate anything?  I do see the "Nothing to assign?"
> case that returns NULL with no alloc, but it's not completely trivial
> to verify that we take that case here.

Yes, it's subtle and it's subtle crap. Sorry that I did not catch that.

Thanks,

        tglx

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
