Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0B5D339AF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhlpUCqerCgg89TeahubZhhVDdSg0WPb2EHjHy0q2Xw=; b=be1bZU9sp8crb6CP0dIihiiozo
	Riw9fBLoDlX9kiC6bfbck3JN7S+4FXSdX+niF6b67ue+XnB0L9TBjki9nNK9nyQLZZHBs3hscyMmf
	bt2sH9OCFmDzj4zwLe79cTuIuqkcyRz4guO+ilvXhQKFIIEhoKm6e1DIu2AwMQPlkhP2x5bhy4dMk
	RUpuYDRsKmI/XbwjWclV7l8gnxuwfBHpZ0AlnYE2DdooPxLyZdhggE1ERYLMyXqobJwitLzrsIKwI
	Oe4KzmZZMs8fAKNcgXh4G4eH+xTO12cDzVTul2/2JtsVjvqIshU4IJHvHO1Z6lgUsKEHRyjg7O09Q
	q31b8fBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5USq-0000000BohI-0uVl;
	Mon, 28 Oct 2024 18:27:40 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5USn-0000000Bogu-3eXt
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 18:27:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Xchh93fq2zlgVnY;
	Mon, 28 Oct 2024 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730140054; x=1732732055; bh=rhlpUCqerCgg89TeahubZhhV
	DdSg0WPb2EHjHy0q2Xw=; b=DhKPFJpwpvxhzpKYxUjS3ZL89K5UeOtkI/jcnaB6
	cNh3v4ZfnI0ivSzxXOQKTXYMYhzusvFhy79ymlg+2ZDoMhzboqNNAGPDSHDTkDNJ
	L5FWLiu7IuAieAeFA40n3agyo5Rymjr6y/bc96C5MCwsU6FiUUvGXsjfQ9LOCD7N
	51FN8UKAgeq8VD3JFETDbgUyNZN6qo7kk51MRsFdngjRj+wAu6FtzN8trc5d+q7V
	aVVDXTCsll4vYfbcUJaTxzUcyrIr7VgARFcNVQBQ53GveJMWdUBskwwSXAhE9Fj8
	p3WQOPXTNDTnP3PzVtEppXyRAN0KPyczS4udNgXocq5bNQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sMy7fRG_jkxB; Mon, 28 Oct 2024 18:27:34 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Xchh56TsqzlgTWR;
	Mon, 28 Oct 2024 18:27:33 +0000 (UTC)
Message-ID: <626bd35e-7216-4379-967d-5f6ebb4a5272@acm.org>
Date: Mon, 28 Oct 2024 11:27:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 3/7] block: allow ability to limit partition write hints
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
 javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241025213645.3464331-1-kbusch@meta.com>
 <20241025213645.3464331-4-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241025213645.3464331-4-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_112737_960962_954538E9 
X-CRM114-Status: UNSURE (   7.69  )
X-CRM114-Notice: Please train this message.
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

On 10/25/24 2:36 PM, Keith Busch wrote:
> When multiple partitions are used, you may want to enforce different
> subsets of the available write hints for each partition. Provide a
> bitmap attribute of the available write hints, and allow an admin to
> write a different mask to set the partition's allowed write hints.

After /proc/irq/*/smp_affinity was introduced (a bitmask),
/proc/irq/*/smp_affinity_list (set of ranges) was introduced as a more
user-friendly alternative. Is the same expected to happen with the
write_hint_mask? If so, shouldn't we skip the bitmask user space
interface and directly introduce the more user friendly interface (set
of ranges)?

Thanks,

Bart.

