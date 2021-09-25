Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2DEC433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:47:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D7060FDC
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 60D7060FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=DNBhIoAWhMrHvOcDH5EKbgEk9s
	nbBUKTDun6EqxL7++Ze10vIyY+Q/chtIOgfe9rHl8poKk98oMzWZlc71vAyEpxn1yjFRey7VSPIyc
	VCZZB0viSkbQC2clpyjDVdZf0PtjKhm3OVCRfTsy9yrempTAQYLoswmQwNkF+m3cnchaQ9f7QE4hQ
	HJIqRqZwfzUg4yI/zS65k2TVExcOKejJThvuUDqBQe5e62MfEOjy7t26uT/fwyoi/8cBPA33cj9Hz
	SleVjkKu64vPmRFRjpT5qCDJISO5oShxAbTgZyVLl/Ngttnmmb4seEm8MedATY2bw9rGIxLpL5LcF
	LWwcoxgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUEZz-00HDy2-95; Sat, 25 Sep 2021 20:47:27 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUEZr-00HDxI-Fo
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 20:47:20 +0000
Received: by mail-ed1-f53.google.com with SMTP id b26so2367723edt.0
 for <linux-nvme@lists.infradead.org>; Sat, 25 Sep 2021 13:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=hFG6gbC6ONlMbZnYMkHsFbjM5SyTPyXCBVrAWGU197WbnoJpMUFQZHHYIDRF9QzMKN
 /40JRRLegTBWOglrLnsyQ9glh+vnoBw5VPUaHRn0h5LWY4PRGxY9SD0UN+jx/45wsDB8
 Zw2h4iDdL1XbUfMDEW/b4V8PtNNuXrvn9KI5i1YlTIQbu6bU3J1dZvTaXZxXqPE9/SZh
 FKvObL5D0SselehvYHjp3YHA+rXsFkMVnC1aNVRs2RrgrBesS56T+3a3ivmENID4r2Yk
 QySc9rTzywKk0PDQFf8qMEvlvowkHy73hb4n5xxixW+5b0Q+wgSTm6X0B9lTV8icJ10d
 32bQ==
X-Gm-Message-State: AOAM5308rwtGU5qaDkPXkeMRqbdChYrRNYrZTSwCD1i2DBHDNJRX6aDB
 j6G+PqVCB0qzdAtcllCLyVo=
X-Google-Smtp-Source: ABdhPJx30VCzLy3DHGhtJOIfdzh29iVBw/y6ytBOzJj+wbWJs2el134+GuP2ID/m16/wNa5Mmel64w==
X-Received: by 2002:aa7:ccd3:: with SMTP id y19mr920879edt.176.1632602837617; 
 Sat, 25 Sep 2021 13:47:17 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id f2sm6589855eje.109.2021.09.25.13.47.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Sep 2021 13:47:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, chaitanyak@nvidia.com
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
 <20210923101744.4204-2-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b2ed1c77-f9ce-b944-1936-f5147278729c@grimberg.me>
Date: Sat, 25 Sep 2021 23:47:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923101744.4204-2-mgurtovoy@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_134719_540146_A633F824 
X-CRM114-Status: UNSURE (   8.64  )
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
