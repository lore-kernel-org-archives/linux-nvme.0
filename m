Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B36C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:46:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61C161108
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D61C161108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=mC3PMe5h2B9g5xywNSeYg/y0WM
	aFYbgaTV8vgdas+q2mxm1ddR1oFvdnKRQ30gWlwzCgwa6LK1wuo7YYUxLvQZ0h5BiQPUhkq/DX64i
	BNDXHFHwdsGVvGH+Z+G4LsTUByle8hH+6utLcWClve14Iq5EZ7w/tGqZjfjZdGemyzPiGK0vlrRFu
	p819t77XlBglMvVZ7Y7T8CvDVsYtQoUrk4nBolQldZ/4GZXfcufjcvqFvL7X0VppVcJIQvvcMDJ8U
	uuewYw8jvzSIVYutuZgRxfmgFh0s9zrQ29tQL8lhM/s6VzglMvp9MM0dRAdWXyTbtxx9D3mFmjPUM
	jItNIlwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maciP-00GOKc-F2; Wed, 13 Oct 2021 11:46:33 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mabkf-00G4vA-Tv
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:44:51 +0000
Received: by mail-wr1-f48.google.com with SMTP id v17so6739431wrv.9
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 03:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=4xdmK8uwUoonY5K4w9pUIwCCYtpxBynh3ZE4jHOqXjqeZMNqHsBFXbX7aFB6LOCxgM
 7rDJhcD8aXmnEfal+YEQw16SXR4PhMsbG7Pgcgzc9Dl5qmGgpHY2Snb5YWmpIVYE43eD
 jbRx6Mu130t6xhAt4HgAQpWfnexQ4mQ8ldGr9mTge0xLNSEha8K1lw7cRij/4mhfeusc
 R6khl39xz6U2nXWiD+R4HYrh8GyZiM4OChv0W7OTsgkKj7qkiZ0gKFR0na4dMlhLMQUK
 pctMdtnKEQRXPI9o4dLje9Yfyvo1zuBmOGb1Xurct4jMHe8jnopwF5sHmvuUcpKf9QZI
 mRkg==
X-Gm-Message-State: AOAM533Sf8GbXA3nPkDWmkDO2dSceS540cpqAxrIAS6wPICurbY727Eg
 YmOUKrCJbC40Rb1nxWaqaNI5OapEJDc=
X-Google-Smtp-Source: ABdhPJwkE7s/yUrnb2NTOS+U/h/aTochobgn/xQEC0SX1NDliyp6ZGkM4DGCgN3hmJFIcue9rPM5mA==
X-Received: by 2002:a05:600c:4fcd:: with SMTP id
 o13mr12313935wmq.158.1634121887275; 
 Wed, 13 Oct 2021 03:44:47 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id f3sm4896127wmb.12.2021.10.13.03.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 03:44:46 -0700 (PDT)
Subject: Re: [PATCH 09/16] block: replace the spin argument to blk_iopoll with
 a flags argument
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-10-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a019990a-ef88-0593-d362-f4c9c639cb21@grimberg.me>
Date: Wed, 13 Oct 2021 13:44:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-10-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_034449_986334_8B58413A 
X-CRM114-Status: UNSURE (   9.07  )
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
