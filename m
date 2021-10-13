Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CAEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:51:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D765F6008E
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D765F6008E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=VPGxBNH6Fo+IWkw+eNAMDfCgGV
	nsifjbD76XAbTZeHts33lfUcenzYS76UA4Cqp0hpS70LTk/stuXwl5adSFj2Mpg/uVoxtEGE+QGTs
	V44FgpyIwxNz+T06YS4Z9sF4t1CtI38/m6Z/BYfVk8BQQ+4rzY5r/qNYSORJ4qasWx0ND5qVlr61m
	EnDW9lIsds48c7y4p+AOn+AixVuhDqCbkLT23HMrMp6ruUk8tl9A+wgi1xJfmEGNx4kiNc8YINfVa
	eaJS97EUVgQYRQiXN4FwVqfHeHlES5sd8zLE8BhWL2UuoI1XTBJGgCgzSNWUFz6sdNurCCgOzgV+5
	t+QgJrnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macnI-00GPNM-V9; Wed, 13 Oct 2021 11:51:37 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mabll-00G5ES-GI
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:45:58 +0000
Received: by mail-wr1-f46.google.com with SMTP id y3so6880077wrl.1
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 03:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=gq7AnvnMD/2s4NyNdAdWYXkh+yIm3wKy4uA3WvNIIZxkBJfq/FvuEG1gqiaqXQPOHo
 uh83takj/VLKRcd7i8+zEC20m97lCEQisiRVO1cTBkAF7v+mS74W/RkF5Qa1rTJ8BbIg
 fdnjpIqt/n6l8/QQIDM408t+cHxVz7QypnzMVgR+4JBg5z4xKlV+aLXSBFQ38l1sSEJM
 X1C7FvG9nxf/zrcfWmWVecW6E4G5VhzYNZNuzgkZmaB5t3W8juLuIC4OTZiViNY0x1mD
 y35xZatsSK+mS39scumyYRZEk8k7qVQcAXOEVRWRBpOGGiLQKAjUWL7XiFh9bOaVQ6pQ
 zpNA==
X-Gm-Message-State: AOAM533qosVPhqe9rynuGuleTzxWBWFNZUstyphClVe1NE0Gw2KSTavJ
 MrP/CMz3wfNNTRGK2LMohJEwEO7vNIg=
X-Google-Smtp-Source: ABdhPJxuCWpusAcRSBUL/YOkPjghlssAoi3ijytswLvfEFC2/EM+Jqn4gCl/ELUOVhnjYe/paL8r6g==
X-Received: by 2002:adf:bb0a:: with SMTP id r10mr37769054wrg.23.1634121955635; 
 Wed, 13 Oct 2021 03:45:55 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id w5sm12858163wrq.86.2021.10.13.03.45.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 03:45:55 -0700 (PDT)
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dde98ff3-0770-69ad-fce7-8efb0a335416@grimberg.me>
Date: Wed, 13 Oct 2021 13:45:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-15-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_034557_568811_E70ECB3B 
X-CRM114-Status: UNSURE (   8.71  )
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
