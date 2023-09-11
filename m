Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDE1EE57DF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Sep 2023 19:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOzBaZVEt5gQY++7RqjQswx+b33XCIagh1muoGrlAno=; b=vmmSFCreCqjJHIIoLJULGdtZyI
	NrF7eJpB8P/7SBLMFFuTcbm6gW5Li7TaUSJvh4+8gWxS4qLba6LtHRqOkVl9t9zrEWQSMbj7TfgpR
	2BZ9KKihSzcJ7E5BUAJsuXrvwnyIsBMwxSIKek/pVjSX5xIxff5UpO3LqLEoxpzzOqK9BmPKhJaDa
	0Aou/MgXttAfPUrk0Ll1sYYgR7ny97DaihNdjtu3coaGodBNy22W6NPLRwOhCul53VSr3aM+jbceK
	/bgyRLewGaR6E/dZhFsYYD5Ycnp/kAOBqUuTYFelM6hx1zSjpFoP6BKKy5spt5wAdRlNJimg8ZEQW
	pr0w/GKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfmc2-001CSI-2C;
	Mon, 11 Sep 2023 19:30:22 +0000
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfmby-001CR6-2r
	for linux-nvme@lists.infradead.org;
	Mon, 11 Sep 2023 19:30:20 +0000
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5922380064bso47969867b3.2
        for <linux-nvme@lists.infradead.org>; Mon, 11 Sep 2023 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ixsystems.com; s=google; t=1694460617; x=1695065417; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOzBaZVEt5gQY++7RqjQswx+b33XCIagh1muoGrlAno=;
        b=NB+ba4XUHNtBLapV5PGe5aTaAER+4SA2mwCzB/Gef2aOahbW2rWD2t4r3CE8L4YKE1
         V47VFmLog8WQ2ADayVoSVoCyveIjADigMZnmB3kG7egxtRB3janstOZdYEs7FTlWnnz9
         myhs7JJcYEBikgeXg8epsq/taTF58osB2/DUu3IN+3zNuLxuT3Q2nWTyo1KAnpcUAWlp
         LjN7ejYYDmpGGhuAjBUjtaw+D5W2BwYQKeTt6C8H5oA68XZOogLdIJ1Pi8y7QJi2i0UT
         bA91RAFPlPVgg0MHYPlpSed/9w82Cr0h7J0nrbOaOCjnY9vGjHcKB8wKIA2snj3O24Vu
         d4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694460617; x=1695065417;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dOzBaZVEt5gQY++7RqjQswx+b33XCIagh1muoGrlAno=;
        b=Kog5/gzcLkRWwoxMYPTqtKHCCzaDgWFIKoKivabDPx47cI6/Co9abxNFX+t6jhNjWD
         SM3zs07uNxceDoK3+aJfZS2uJOqAMHjdeZQRyKr3IXTRUKUMZVjS3k7WKUtAH99Njsn9
         JFVO5veoR/8q/slDtoNA8YwA5Rcbn7iAaN/7Ffqpq9eTthWeVc5GwJ178nDyytWieH/+
         kT0u4klGDPD16YjG/RoM6sy92q/1j34Pir6c87C4bLPfpibduVwY1ejgzbQcO5xA+aAH
         v8kSo7UgJsy7jP2N1oeX8EH71T0re0IkFQl7lco/eefNrqzS+2a8mT4j3WH1GN7VZkL9
         R25g==
X-Gm-Message-State: AOJu0Yw8iiRsVhi/N0wsZQYWIoLw1x23NPdI4CpVnXJebQ5kDCIzHD1D
	AnuEcwc7jC0Vldu9hv3wXeJRUhecIuhF31GcMwo=
X-Google-Smtp-Source: AGHT+IESxrLOaWegF5gTHmBHYw+/IUhEQGmX3/l2Ji8Z3+aAqLldkGtB6pMnrMVyRK3tlfdNewm/Zg==
X-Received: by 2002:a0d:e20e:0:b0:58c:57c1:138a with SMTP id l14-20020a0de20e000000b0058c57c1138amr10944186ywe.19.1694460616784;
        Mon, 11 Sep 2023 12:30:16 -0700 (PDT)
Received: from [10.230.45.5] ([38.32.73.2])
        by smtp.gmail.com with ESMTPSA id m83-20020a0dca56000000b00589e84acafasm2133892ywd.48.2023.09.11.12.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 12:30:16 -0700 (PDT)
Message-ID: <2f1414ab-9152-17ab-d2c6-96f4f5de7d45@ixsystems.com>
Date: Mon, 11 Sep 2023 15:29:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme: prevent id ctrl csi for specs below 2.0
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Ameer Hamza <ahamza@ixsystems.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-kernel@vger.kernel.org, edmund.nadolski@ixsystems.com
References: <20230910212641.338438-1-ahamza@ixsystems.com>
 <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
From: Alexander Motin <mav@ixsystems.com>
In-Reply-To: <ZP9fOBSl59u8u0hq@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_123018_928526_677ACB0B 
X-CRM114-Status: GOOD (  13.19  )
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

On 11.09.2023 14:40, Keith Busch wrote:
> On Mon, Sep 11, 2023 at 02:26:41AM +0500, Ameer Hamza wrote:
>> The 'id ctrl csi' command was introduced in version 2.0, as specified
>> in Section 5.17.2.6 of the NVME Base Specification 2.0. Executing this
>> command on previous NVMe versions returns an "Invalid Field" error,
>> and the error entry is saved in the log page. Although, Commit
>> c917dd96fe41 ("nvme: skip optional id ctrl csi if it failed") reduced
>> the error occurrences, but the error persisted during the initial
>> module load. This patch ensures the command isn't executed on versions
>> older than 2.0, and it also eliminates the skip implementation because
>> NVME_ID_CNS_CS_CTRL is expected to succeed with version 2.0.
> 
> NVMe TP's are allowed to be implemented by versions lower than the
> release that first included it. I recall the first nvme controller I'd
> seen that implemented this identification reported itself as 1.4.

Then there must be a way to detect it.  How otherwise it is not a 
standard violation to send arbitrary effectively vendor-specific 
commands to a drive?

-- 
Alexander Motin

