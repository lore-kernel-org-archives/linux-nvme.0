Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D8EFCA9ED5
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 06:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/KXn2Mae47AvoKafUjW5cAwSLHA0Ei67hf+ZpEdJmV8=; b=v1CWIalXg2plmOlDWXVMzErtMJ
	lu88z56tfM1U5fsQsEuQvuMY5jkHOirqxM5NXkxuui3J3ESy59asnV/6DIqZmetgQaOjvmIs2U2Ec
	f9BP8u8A/jV4nE49eQocEFBq58LCAUsh0Cu3RdRWdusX2+zXekj/EPk9W2WUbTblI0/eTZVaIHg7z
	pkm13Km4oVrU6aTiWFXDXcvvZSbVX7XpIduQnUAtRpy7EUGn0pg2jB5X0XJa8Y5DBaeDexqLcJ09m
	DGpK/KJDSDcclmqM4vGWxVMlvI5K3r80Ace7bqMf8pQBLcm02INHjveJnsV05ws0UNdw/reqOzAyk
	j9TiCXpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xG9p6-00000009luZ-0plu;
	Mon, 12 Oct 2026 06:47:48 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xG9p3-00000009luE-12pL
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 06:47:46 +0000
Received: from [10.95.64.165] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3472120B7166;
	Sun, 11 Oct 2026 23:47:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3472120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791787660;
	bh=/KXn2Mae47AvoKafUjW5cAwSLHA0Ei67hf+ZpEdJmV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dw3/VxE9wlO75SFlUpXhbWSw4ayQLfs23MInfKvBPVc4K03c1/hqDU4MY3v65IM09
	 GuTD8dwrZ+lZX20TqgfHb5q1Ihw+59rdHKDIRRD+5vfTvqrjp0UsNeGU/rJUHL4Xkq
	 hDhMvWJejrCbgxTruQhVgn9l5iygO2IzeDDhT6Z8=
Message-ID: <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>
Date: Mon, 12 Oct 2026 12:17:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] nvme-pci: defer completions when rescheduling is
 needed
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <20261009050556.2817978-4-namjain@linux.microsoft.com>
 <askIoNon8UVyNJiJ@kbusch-mbp>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <askIoNon8UVyNJiJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261011_234745_324739_827ACD41 
X-CRM114-Status: GOOD (  17.16  )
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



On 10/9/2026 9:00 PM, Keith Busch wrote:
> On Fri, Oct 09, 2026 at 05:05:56AM +0000, Naman Jain wrote:
>>   static irqreturn_t nvme_irq(int irq, void *data)
>>   {
>>   	struct nvme_queue *nvmeq = data;
>>   	DEFINE_IO_COMP_BATCH(iob);
>>   
>> +	if (unlikely(test_and_clear_bit(NVMEQ_IRQ_POLL_HANDOFF,
>> +					&nvmeq->flags))) {
>> +		if (!nvme_cqe_pending(nvmeq))
>> +			return IRQ_HANDLED;
>> +	}
>> +	if (unlikely(test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
>> +		     (!test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) ||
>> +		      test_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags) ||
>> +		      READ_ONCE(to_pci_dev(nvmeq->dev->dev)->error_state) !=
>> +				pci_channel_io_normal)))
>> +		return IRQ_HANDLED;
>> +
>> +	if (unlikely(in_hardirq() &&
>> +		     test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) &&
>> +		     !test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
>> +		     need_resched() && nvme_cqe_pending(nvmeq) &&
>> +		     !test_and_set_bit_lock(NVMEQ_IRQ_POLL, &nvmeq->flags))) {
>> +		set_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
>> +		disable_irq_nosync(irq);
>> +		irq_poll_sched(&nvmeq->iopoll);
>> +		return IRQ_HANDLED;
>> +	}
> 
> The disable_irq_nosync still does non-posted transactions for msi and
> msi-x. NVMe has a shortcut for msi, but there's currently nothing for
> msi-x. For that case, I have a prep patch I consulted with Thomas, and
> the result is below. I'm delayed sending it out while catching up from
> travel, but I think this will be even more efficient.
> 

Thanks for sharing. I'll give it a try. IIUC, after your patch goes in, 
I should be using disable_irq_nowait() in above and see better 
performance. Please correct me if I am wrong. I'll monitor your patch in 
LKML for future versions.

Regards,
Naman

