Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F35EC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:58:49 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F19C8613FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 21:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19C8613FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=HYSIuU5uBMbpsTIOnyXaQvz1q
	3iRnjcuVRhtcKBewDXDiPiYv0EcjYcT5nbbzIpDk2Ku54P08Nfwk+d/cf7Dv6Vg4DwtVH9H9cVpgS
	3u/SGnuH3DZxH9sxuVAwSWf6qpmls/q9E7Xgjd8+zOkfb+lhjCxyXtM44r5aH3+TRixGv+KUrgQi+
	ylnAjwFINwDGCGc/syM0GAYGPew05QkhjclCRH3/Zc5xmzp0Q+bybvaSUX+TZrNRYmPsPKCBo6n0C
	Xv84oKLrbDQaur7SFDIBIdeiKukfw2SavEAY7lC7Wi3S9garn6I79+KIeihYy6DmvghuRzdhGCDn4
	pFh1Wzayg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgwsM-0047DA-NR; Wed, 12 May 2021 21:58:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwsJ-0047Cu-4E
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 21:58:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ZKUSMfxHgPMUTybpHilOfK/qIn
 nZaSTR9WSWYW72oPaOMZ9zpPWC+yPIqQJYFs3PIPyRg59OSxuB4pCX0qrul1x3qEBVD9zc8MxXSWO
 cQKet8SSsdhiEg+tzIBGGpSquIV/NUp2nKxwlP+ApLQNbz1fdTAJYEkrO1/LYa9lbWgtC8xnj7LzY
 LLkIxitT28eyG5kC+IrSNTL75/V4JAc5uYLyR51mvMxth16I/swLk9YXWbzg9TEgLqQakCtGmhzER
 sF4/tKihubzGCo448vePuWYEFfvNlWKfyb2v15+A1AvU9/17NLREi4w872xy3B2ckg/XPdyU/5yUh
 fVBzgsUQ==;
Received: from mail-qk1-f176.google.com ([209.85.222.176])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgwsG-00Ar6p-LJ
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 21:58:37 +0000
Received: by mail-qk1-f176.google.com with SMTP id x8so23822569qkl.2
 for <linux-nvme@lists.infradead.org>; Wed, 12 May 2021 14:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=A6HhL1u5zOIv7Dun8+4cDCj6vb1ispQmv6+TJhvZwL3NSrU4hM58xToFhPsPmu0PaO
 QOB1pLm9/b97cQNl2lkXq0HbhhkUPjP1eQM81NPw2+xiYcGK2pVZZE126L9xfMA3I3Hm
 1LadW5j+UIHk6n8QKHHP5xqvqubAr9f189NOanuBuqjtklGHqFr0NZF7fJ8a5x8/OOuO
 trrfIFRTVcOIho75+eebU4QuvzHaDzlwvm43rGabG/gCz+gKl6GGFu1LPiyzY18+goCH
 4HDWp8GL4mHzv814UIPoEVTEnV46B0PU0j8fP9VzzFLSlyaXv2oJ5PCdOwaz4KgY5ECE
 Vmnw==
X-Gm-Message-State: AOAM533NTSXzg1HhEBS/MSXFqAv/mUFfZ6XFTKvncXQa6tZwmxJrUuJb
 KVDKzYjSGdc1bpLkv+2RI4exilzqJ9c=
X-Google-Smtp-Source: ABdhPJzwS0cgNLHyE4FZlTFgrvA54SkjFB9zrbp32LsPaNSlXEy/DVB0N754OeJqsYxVMpsnkgOwbg==
X-Received: by 2002:a37:8c1:: with SMTP id 184mr35663745qki.345.1620856715252; 
 Wed, 12 May 2021 14:58:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c65a:d038:3389:f848?
 ([2600:1700:65a0:78e0:c65a:d038:3389:f848])
 by smtp.gmail.com with ESMTPSA id u6sm977905qkj.117.2021.05.12.14.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 May 2021 14:58:34 -0700 (PDT)
Subject: Re: [PATCH 11/15] block: define 'struct bvec_iter' as packed
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20210512131545.495160-1-hch@lst.de>
 <20210512131545.495160-12-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c337780b-4499-003a-e6c3-b29e941234db@grimberg.me>
Date: Wed, 12 May 2021 14:58:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512131545.495160-12-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_145836_706489_38B3982A 
X-CRM114-Status: UNSURE (   9.00  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
