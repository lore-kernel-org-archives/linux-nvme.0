Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E40C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:41:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB25610D1
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 11:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6CB25610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=08GBveB4PwjXslQrDJ1MlILmXO
	kkD/TZCiGyx3UZzdWSS2mOjOuwIQFYbCkHtLwOyUnangyuUW9cxtVrKSSjYAolnD+AyXjIJGBIJuQ
	2iHDjSgmo4WHffv9tMC3w3qJRJEP0PWMf6lLBlYT03a3L6IWIFnMNGiJo/NnNxr2S4IktXJ6QcJHp
	IsrckAHDtOxT1gTQX3ZTx65FzsuOI7bSB2OCaVduG86ZLZfPm7igsPwzZSD1s5fK+0zAnv2qKNoNv
	nJ3Hgg2xXAq/NL8A+EQx6lDj+VyCQ9DTHgIlTjyhFkuV3frZFHEl/eFwPgBinCAhclUALsW4IhMCm
	glmrnC8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1macdG-00GN5h-CT; Wed, 13 Oct 2021 11:41:14 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mabiZ-00G4H2-B9
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 10:42:40 +0000
Received: by mail-wr1-f44.google.com with SMTP id v17so6719837wrv.9
 for <linux-nvme@lists.infradead.org>; Wed, 13 Oct 2021 03:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=5bQfV/xQUTj2Z+9Mac5B3lWm7+bD5SE0iDsNiv9i/lFMNKyyfGVulQm33AmQq1Ewl9
 3AvQVHLXi6XuS/sv4KjtnH7MzjUoicV7R6dUqkTcifvl9ouedOpFsi6QYw7O/i3rIGu7
 EVEttBTMGxFhABFuApRQBcRZwng0gxDj+u1sEsv2RZYx8oL/J4jviiJTlHbrpBbmucdN
 O4mKeJ0aIO42mgzrQFmUCQMVoJkcOUB+TgPuzVkPy3YT/rlA3Q9JBKL5DIbBmFNHDGiw
 HrfeYeqnLSKCWcEX/rNJFGEGZXIoAJNRzHtg81D/2RWvcuT2YdyRB10QyLCsaMhUYLlP
 cfFA==
X-Gm-Message-State: AOAM5311WErdD5nR2cOXZq2ikqQNhxts5WUlRwAJZ3yDGd8YqvKC9mzs
 20+rrhWO7E5uwQ10XTBjFYrtMO27FOw=
X-Google-Smtp-Source: ABdhPJwhddV2ARk+BQaQwerHwByTeVEqS3Jo4y42CH75AflfLtX/RHBKsxIbFnW8daF0bFirDwYJUw==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr38987849wru.51.1634121756664; 
 Wed, 13 Oct 2021 03:42:36 -0700 (PDT)
Received: from [192.168.81.70] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n1sm4998471wmi.30.2021.10.13.03.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 03:42:36 -0700 (PDT)
Subject: Re: [PATCH 01/16] direct-io: remove blk_poll support
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <40d102dd-4d0d-c56b-0872-e996e5a1265b@grimberg.me>
Date: Wed, 13 Oct 2021 13:42:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_034239_453332_0DDD5956 
X-CRM114-Status: UNSURE (   8.70  )
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
