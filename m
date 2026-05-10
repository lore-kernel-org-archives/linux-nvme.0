Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C25CD37B5
	for <linux-nvme@archiver.kernel.org>; Sun, 10 May 2026 22:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88pKdRxOy9OhVztSUg2g9U/yIqo0Der1KlOI70WyrPM=; b=Lrz5QmF0ncdFCr+25+BYt3QP/6
	t1jP9G7JhhWDjRMjVg+M+hzYSIowcjA3ub8zBZtO23wP+WQMVvW81yEZm0kDCje+khLCUzeAhLMaW
	pss74zZGeUaV7S7JXplrIsVz85q+sjiTGCsAKap8fTgtXNFq1o+t6BHnOpZeNdzYHO4BKFbiZODt9
	BgXCEv4b6YAorg3x8p9qF/Ho1pKpQHti/dPuC9Immv2u2B/r5tP7vlUAt8cURXicRKAjTxZz02zig
	H7UVB7hDKn5WuW0IRKpTpmYR4C4xfjt0iS5PRvt7mE1Da0v0eOpu8TaHC+e4MnoLSeFDZ2fRbBO0j
	BPpSNx4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCOX-0000000BjcU-1DmO;
	Sun, 10 May 2026 22:13:05 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMCOU-0000000Bjbw-1XT8
	for linux-nvme@lists.infradead.org;
	Sun, 10 May 2026 22:13:03 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44a044cb827so2879109f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 10 May 2026 15:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778451180; x=1779055980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88pKdRxOy9OhVztSUg2g9U/yIqo0Der1KlOI70WyrPM=;
        b=cfs31uaz5HICUUyu4qywTR6cYbq6zgBApm12TOvg8AgXzLq9JNwzFGMEOtYG8Sa6r9
         CdZ2LQcAJ17WchZJk4oV7C0Ev69V8GpEILfR79U3ZivXsD6nWGIabV5tS7Qyh88D6KFW
         BFvTKI1Cx4rib0LH/VvbANO2R/EA7i1JVoPrtAZ0NCbxlWOJ6hGHEvS07auLgxdF1s5N
         LXv2varm5cCwUNt03n/VrkyhM4dOyBZbHV+S4x8pvhnVZBdJ0BCzHscyPMBTlnkSLzpE
         CB0hYocZjkXsYi3khRGEqGxLv42vZU3KQuXr33i9Sck6Q9VJM542ZU23Mv6blmZ9OKZs
         vQJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8WpO2HLkZWxzdgGqnB6xnh71ysRaqlL+HdacGGIzFObRaFN3IQmYUfABjjGZ3PQ+56247c+k6nRooP@lists.infradead.org
X-Gm-Message-State: AOJu0Yynws9G30b+69Lq71g5bQjq/z1UicVG2tGZrzgmIJ4pVMfZoNn5
	NgF4Clj2T3ww88A2p+yVW+r7DosA3iq+TKv5gDs3B/1hsrSHO5TioUgm
X-Gm-Gg: Acq92OF8JxkiXiys+dqvNiK9P14OR1jNfXZo99L7U/wwAgV01M1zTKDgFJApdoGCCNZ
	nzPYXRotd69FfSgl0rJv7e6Qw7eSTL2mrCQizFnHyWY+0Qvn3DCeAjHJqcl9owjx8C0LQIh8o4J
	xZ09ydUqO0GMI2ColHmkGkhqLcJXvfNbJu+ZZax4eRxORL2iRdQkD1Qis2S4e4m+CmDSI8GUl77
	OoS3bA30m8I4lz/s+Hnmuq5hHhKU0DuvVAomSmJoF+fWJuBdTJJnRIR3tSrna1XAORaHl1JaFWa
	OMaQDIWAZWz9iiXSgyRdQ9ATnCqOGNw8ZFiwY5FX8Eu783nvD7wmmOpoGAYnk/EChhQYdHz2nQW
	mJ5p0tTTCC+OFZiCsSacb5bmfRtS2+PjY5UHkrsO6jx+xThqtx4rhmeK91zfcDzXLq5QOxRhpRh
	pHKn2x5jikM472BniwRRs=
X-Received: by 2002:a05:6000:18a5:b0:43d:1dfe:350a with SMTP id ffacd0b85a97d-4515ce1c991mr35984090f8f.22.1778451180450;
        Sun, 10 May 2026 15:13:00 -0700 (PDT)
Received: from [10.100.102.74] ([89.138.75.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm21427262f8f.30.2026.05.10.15.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 15:12:59 -0700 (PDT)
Message-ID: <86fd8b31-7264-48d1-99e6-a053ae6cae4e@grimberg.me>
Date: Mon, 11 May 2026 01:12:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/9] nvme: add sysfs attribute to change IO timeout per
 controller
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org, dwagner@suse.de, mlombard@arkamax.eu,
 mkhalfella@purestorage.com, chaitanyak@nvidia.com, hare@kernel.org,
 hch@lst.de
References: <20260508133335.98612-1-mlombard@redhat.com>
 <20260508133335.98612-6-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260508133335.98612-6-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_151302_426465_3F267BD7 
X-CRM114-Status: UNSURE (   7.53  )
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



On 08/05/2026 16:33, Maurizio Lombardi wrote:
> Currently, there is no method to adjust the timeout values on a
> per controller basis with nvme I/O queues.
> Add an io_timeout attribute to nvme so that different nvme controllers
> which may have different timeout requirements can have custom
> I/O timeouts set.

Why is this needed? Why not simply change the timeout on
the namespaces themselves?

