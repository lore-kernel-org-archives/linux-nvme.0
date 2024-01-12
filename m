Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DF3C47077
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jan 2024 03:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RSE7F8N60c0Ae+fmfpGH9XuG5NGRejl7n9fMC80v5x8=; b=2pUzklbxIPOR8PkhztZMkX8ch7
	rj/Z0m9wor9CWZy/bX6LNSKDKkTAMFF/1VqBsuaBGDpYokY8XyXA4EXaJ7loYOdYHIXBtbAyZkMl1
	OeK0QEIeLUXICqXBPwzOWmkkRVZwvY4br+BRXkc4Jn2AUm6Ps4d1IQmkrTHXplTrzSXWw/MgHaLDJ
	0vJFNwj78W97l4Fu+RFFxbXA8H4dEoTeaCSbL2EkL48izWpoZW49IiEGDnFYGQWxFQi3Qg+9KHuAm
	ELvLl2OF5ny2PCLmk/TClQZ8EVaZyIjZw06ZLbWEjieNsSojv7tzxPbNiPccOHPF7HycBLT4kyO5/
	AQy/mFJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rO7rj-001jlM-1u;
	Fri, 12 Jan 2024 03:05:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rO7rh-001jko-05
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jan 2024 03:05:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D2E6061CE2;
	Fri, 12 Jan 2024 03:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7CAC433F1;
	Fri, 12 Jan 2024 03:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705028747;
	bh=7F4lPbM4glnQ1WhTY4k/Nyg28ifeaJTdz7hV/nwWi2E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cB1byrQWODg8L7v/CB7CtewBFAsUE9RIc2+9EhNTfIo6K6s4psEAkXu2w/952PywI
	 Ws3RXMKd0RzU2N9Nua0dFxKf9ZYr7/6I4uoP7X8ftxqy3+fwUzlVD2h/R2OnIHSe4z
	 REQeyMMlHxXjeHhnPe67/14ls7ZACa6L68S7N0LDI1xE0ZOffuitspSlMC6sIgRXaq
	 RG9NzIA9WQ3/vn3PyeswfpPyLQXaKiOVUSK+KcUJnHHAmwuxP549dh50Wk7NAOj44G
	 vvT9vqJW5uXwPnQAlajszYb/K+k8yr1T6CZ+locaHK9oRFfQ1AlIUxh9ocv/W2Pycn
	 L+iTcM5pO6EBQ==
Message-ID: <20503cd0-3a99-45bb-8374-40296a3cb92a@kernel.org>
Date: Fri, 12 Jan 2024 12:05:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>, John Meneghini <jmeneghi@redhat.com>,
 linux-nvme@lists.infradead.org, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <ZaCSOH7L+Nm6PvcN@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZaCSOH7L+Nm6PvcN@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240111_190549_123411_7FFCC3DE 
X-CRM114-Status: GOOD (  15.04  )
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

On 1/12/24 10:13, Ming Lei wrote:
> Hello Damien and Guys,
> 
> Yi reported that the following failure:
> 
> Oct 18 15:24:15 localhost kernel: nvme nvme4: invalid zone size:196608 for namespace:1
> Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, opened
> Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, NETAPPX4022S173A4T0NTZ, S/N:S66NNE0T800169, FW:MVP40B7B, 4.09 TB
> 
> Looks current blk-zoned requires zone->len to be power_of_2() since
> commit:
> 
> 6c6b35491422 ("block: set the zone size in blk_revalidate_disk_zones atomically")
> 
> And the original power_of_2() requirement is from the following commit
> for ZBC and ZAC.
> 
> d9dd73087a8b ("block: Enhance blk_revalidate_disk_zones()")
> 
> Meantime block layer does support non-power_of_2 chunk sectors limit.

That is not true. It does. See blk_stack_limits which ahs:

	/* Set non-power-of-2 compatible chunk_sectors boundary */
        if (b->chunk_sectors)
                t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);

and the absence of any check on the value of chunk_sectors in
blk_queue_chunk_sectors().

> The question is if there is such hard requirement for ZNS, and I can't see
> any such words in NVMe Zoned Namespace Command Set Specification.

No, there are no requirements in ZNS for the zone size to be a power of 2 number
of sectors/LBAs. The same is also true for ZBC and ZAC (SCSI and ATA) SMR HDDs.
The requirement for the zone size to be a power of 2 number of sectors is
entirely in the kernel. The reason being that zoned block device support started
with SMR HDDs which all had a zone size of 256 MB (and still do) and no user
ever wanted anything else than that. So everything was coded with this
requirement, as that allowed many nice things like bit-shift/mask arithmetic for
conversions between zone number and sectors etc (and that of course is very
efficient).

> So is it one NVMe firmware issue? or blk-zoned problem with too strict(power_of_2)
> requirement on zone->len?

It is the latter. There was a session at LSF/MM last year about this. I recall
that the conclusion was that unless there is a strong user demand for non power
of 2 zone size, we are not going to do anything about it. Because allowing
non-power of 2 zone size has some serious consequences all over the place,
including in FSes that natively support zoned devices. So relaxing that
requirement is not trivial.


-- 
Damien Le Moal
Western Digital Research


