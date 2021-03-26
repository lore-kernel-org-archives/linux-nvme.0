Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CE5C433C1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 20:59:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C547F61A26
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 20:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C547F61A26
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=eJB9J0N5yQ83ZXBQ+425Ur151
	62Ni3B9bXGoXAifHlFSk3A9wg5VaUsPXdOpf/8NMRyr5oT/WVDNyJdBwV/I/rLy9bK2/Gkomx8Cii
	P7aKlZ+UcTJKerXyEcXdBTRfjDchJOHTXHC1zLfk75gUoVKmTXDykVbCQINvYXjmJbIeNiHvtHDri
	ZqamB35D02j54pCRJpqVoc+1tG9991IiOz0SdDT7J6fI4Bjl9VKPvX4LX7iVroE8q9zrB8jWA4+N1
	IxDCvOjnf9d3vdva2Nj+FOqIyd+mlZjXo3urUOD1UFI6Lv6H8zn5X21iHLfqXgs0fwxzY/Rby0RpO
	2YYGy1hSw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPtY1-004LDw-1X; Fri, 26 Mar 2021 20:59:13 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPtXu-004LDO-Hk
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 20:59:08 +0000
Received: by mail-pf1-f176.google.com with SMTP id c204so5691399pfc.4
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 13:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=DmjnpQUkVgKJ0zdzOHo5MgV9XuOhVoyUqlW1QsbOUUJNMqIvkqNhHC17DFsfKIAANN
 zZuDOFpxMqv1j4JkVOMAUo/MkN73aDgCMVWrggL0QwZ5jtrw9qQcrkX/5pT3OAwVCzrH
 A+K8rv/yGX7IM+TcYqMQ72Bn+VHl5XlwPreO2Z9wnqULbApBIo8q6wHY/vuEmFylqs+b
 eOga77YcGkp3/qgm+/osGmgHdBnzNG4MJGbYRwd581/yNcjs8Wxmib86wtDYWVsfkt06
 kml3zdnMBgGGxSL5+D8/YaFhQKLGb3ZRs/lKmlJau2IB0BhaBh/F/vL7Okn7rRkyAx8/
 qBmg==
X-Gm-Message-State: AOAM531D9h7DiKOL/goJX+gs6rVLoBq3zZPFrDBrx4nYNvgcl/BYntcY
 KBAv2hlcFNnBDh3Ev1aaC4M=
X-Google-Smtp-Source: ABdhPJy0Azf7WLtn75JPuvIQUr2HbMIzpSlpcVK5hi4LsE+ZuTFkzvXgcUVs524pg+wXlcmL2M5GxA==
X-Received: by 2002:a65:6107:: with SMTP id z7mr14243684pgu.435.1616792345172; 
 Fri, 26 Mar 2021 13:59:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5512:a799:a5d1:66a3?
 ([2601:647:4802:9070:5512:a799:a5d1:66a3])
 by smtp.gmail.com with ESMTPSA id d20sm9108893pjv.47.2021.03.26.13.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Mar 2021 13:59:04 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: disallow passthru cmd from targeting a nsid !=
 nsid of the block dev
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Cc: "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
 "javier@javigon.com" <javier@javigon.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0c67bd30-9718-0830-db46-cd36e8d5dca5@grimberg.me>
Date: Fri, 26 Mar 2021 13:59:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210326194749.396599-1-Niklas.Cassel@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_205906_697861_758BD196 
X-CRM114-Status: UNSURE (   9.10  )
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
