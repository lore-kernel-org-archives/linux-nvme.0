Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF74C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 15:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SBc3GAZ4YIZ93s8r+/3FQmo1yidZe9JMqHnGjAewgfA=; b=2gecc0YhVZU7WpG/5DkMDDDUZH
	FLw3QG/A2WtGYGUqvmWLccedCqLQ2a8203BHZe1otT/AvoXxq4R2KXa8opXqkow74XLGDrBDg8Elx
	ouB/6pyfbUQa+ypAKS/Q8YgV7r7xaUhoUI3iuMVFbaE30MPJYFHseKCgm3rVm47erTEhDqcPMOq69
	fQvKdTVcMdG031fTs26DTIxhuXXVvvGKTdBT+N7stjT6GG2Vot51i9ua0zu+bPvG08IYv9jQNd/Jw
	F9aVQWAUx++15XllRUMx5pg1qorWgyx77aalDVXaJeFaC6nL/AyIH/AATPj4WUgyheGt4CKUXDZ9g
	vBf2y6KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxsx8-006OhP-Ef; Thu, 16 Dec 2021 15:45:54 +0000
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxsx5-006Oge-RK
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 15:45:53 +0000
Received: by mail-io1-xd32.google.com with SMTP id x10so35720565ioj.9
 for <linux-nvme@lists.infradead.org>; Thu, 16 Dec 2021 07:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SBc3GAZ4YIZ93s8r+/3FQmo1yidZe9JMqHnGjAewgfA=;
 b=TV6wSRzLfaitAAev15bGgk32ATQBKLUauLBN3HJF2ETNkTpl5pszIifpP+yj0RDwIL
 4RYMlw2TagUJa01p3ziZxfwqkdBSh0Qa8Vov14hk3IhmlNLh1uQzjaGt6gt+K0f5+kRF
 4fIa16ymlTeCbf6hldLKQHYWlCxhTxKfgUsb6SodSoKs6HsbZWUMkB2bIlGW/PRLuOfU
 s6uYDzFk3tAiTAa4R5GzFQL+ncUST1uJGZFLJXW4K/afgT9MZBwGrwB25fcrXwpstlyj
 /DSJ9JrGOF8fsyMVscLoU15aR1rKwWZTkDGfGHKc+zDy8XTDgJUA+XXePVQuAbqm4whh
 ASTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SBc3GAZ4YIZ93s8r+/3FQmo1yidZe9JMqHnGjAewgfA=;
 b=YEpgIS8aVe4q/Eb8FVzkEvdyxu1G1TBslcp8+EWGitQml65DFudn0xoUBSXoXkbKFO
 aa6mXWo3Me73XUrfyFKsCzN9cdEQVbFJjI/UxG6NMT7GSQNBj0AsBqSY8h0PxfFtFehe
 4CwvwN+859TXGe8BBr5fQRaoF8m+uOo7qk2s5dXzLXcekS+bXLPp+Zg4K4yDuzS7+4Yf
 fa3k37oKFjuI4H/ueLU03cXlmi1flNBjti5UOygnOcaVtvYUIKffAKxPNkaJyHc6XiQU
 Xo39VgTwB09N1AEJp5KdKdxi11MX/dM7+PGuQD6TGwK8duk+thJhvkPdBDzjwN12bAHN
 3+HA==
X-Gm-Message-State: AOAM5336WyMwZyisvflLET7lDDtnzRr1+A1H5t5r4spdT4r6WB/cJ8Ku
 D6MWMigpXO8l6YcxOfnO4Ynxn59r6COOQA==
X-Google-Smtp-Source: ABdhPJxplkANgDmAeUKaQOmui2rltUUu3y+oFsyxBSdV6c9hGPou7JZdqdr7SPCy+0CdVlD+v46jsQ==
X-Received: by 2002:a05:6638:d89:: with SMTP id
 l9mr10226540jaj.80.1639669549784; 
 Thu, 16 Dec 2021 07:45:49 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id t6sm2680980ioi.51.2021.12.16.07.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Dec 2021 07:45:49 -0800 (PST)
Subject: Re: [PATCH 4/4] nvme: add support for mq_ops->queue_rqs()
To: Christoph Hellwig <hch@infradead.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20211215162421.14896-1-axboe@kernel.dk>
 <20211215162421.14896-5-axboe@kernel.dk> <YbsB/W/1Uwok4i0u@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <83aa4715-7bf8-4ed1-6945-3910cb13f233@kernel.dk>
Date: Thu, 16 Dec 2021 08:45:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YbsB/W/1Uwok4i0u@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_074551_918200_07D39CD0 
X-CRM114-Status: GOOD (  18.60  )
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

On 12/16/21 2:08 AM, Christoph Hellwig wrote:
> On Wed, Dec 15, 2021 at 09:24:21AM -0700, Jens Axboe wrote:
>> +	spin_lock(&nvmeq->sq_lock);
>> +	while (!rq_list_empty(*rqlist)) {
>> +		struct request *req = rq_list_pop(rqlist);
>> +		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>> +
>> +		memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
>> +				absolute_pointer(&iod->cmd), sizeof(iod->cmd));
>> +		if (++nvmeq->sq_tail == nvmeq->q_depth)
>> +			nvmeq->sq_tail = 0;
> 
> So this doesn't even use the new helper added in patch 2?  I think this
> should call nvme_sq_copy_cmd().

But you NAK'ed that one? It definitely should use that helper, so I take it
you are fine with it then if we do it here too? That would make 3 call sites,
and I still do think the helper makes sense...

> The rest looks identical to the incremental patch I posted, so I guess
> the performance degration measured on the first try was a measurement
> error?

It may have been a measurement error, I'm honestly not quite sure. I
reshuffled and modified a few bits here and there, and verified the
end result. Wish I had a better answer, but...

-- 
Jens Axboe


