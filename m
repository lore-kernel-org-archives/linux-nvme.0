Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156A9C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=R5+ujYWycFR2Qn1E7l/M3x5nh3
	ye3c1c5uhx7PikrBBSqfa90vMq73CZB2aojOMBv7CfkM1pvlzK2piLPeAGWM4RfM6mxZDgaeropBT
	U/apQxVOdlsYNjH4N2AIECvrSpEmFzkDmgNJE2OYZwAiCTdR7uEZ0k0UfpbWweJ5kM/BakE2rq14e
	DquuF6oxjQMhyG6jQLBCpY2+hp9f3wDjwtP0vM2ENWTTCoIPHJJVIx9ASrTf6CYPJc9WP+FJiNKaH
	73GRFWCV2I9i7jdQEK92vtGSjoe1WjVI8YE5Mv1AgFmHR20S8kr6GEybSjV/z/c+hEw0uQJ/c2N7n
	xQznk2WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54g4-00CBak-0P;
	Mon, 20 Nov 2023 13:51:04 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54fw-00CBYB-17
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 13:50:59 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3316db2c5c0so654883f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 05:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488252; x=1701093052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VpDBiUSuwiB0FN+WHGXNAk7LI+a7wJhXEphRXUAA7+JDTwxXwE4KsR1AKMYW6+Ad8n
         Td6WIrCqEIwgoW4m9avZlU5hltSv9pp3C2X8FBZhhhW771QyD1ajGkmkquAtvJnK3xr7
         OsgFIHklBSXhg/+3J7wPYaJgD8augBVuqvrS5B1d5/MTHe/gpDNLZgvNjvTr232QWQs6
         yUPRqpS7+Y69QSwj/oTokoutiNGIPn6fNYPhvtbqDIlQkLF3gM+KWMQwK9hXVS43TRdw
         VdRZh6i850yivOdAlV9OFxidOJhG9zY4NUzA6w5NT53rSXicV1zcSXI13s+qHhtAO7ZS
         YdlQ==
X-Gm-Message-State: AOJu0YxPw6Df1gLUPNjdgb7w9dIxulUP3IuRAi14d51PENc2F+mB6iaI
	s8lMEnjSYk20PK5U9NvJOxk=
X-Google-Smtp-Source: AGHT+IHLPSueabiNz08RB5dCfgXFcSkq8b0MpGhtZO3fnKbRcNl/36SqwGMo819CZXRVkfeyAEMycQ==
X-Received: by 2002:a5d:5587:0:b0:32d:e445:a663 with SMTP id i7-20020a5d5587000000b0032de445a663mr5072463wrv.2.1700488252359;
        Mon, 20 Nov 2023 05:50:52 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4c92000000b00331424a1266sm11249805wrs.84.2023.11.20.05.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 05:50:52 -0800 (PST)
Message-ID: <54cecdb8-22e1-4c90-929c-da9405ec3826@grimberg.me>
Date: Mon, 20 Nov 2023 15:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: Fix a memory leak
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <f9420cde9afdc5af40bf8a8d5aa9184a9b5da729.1698614556.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_055056_605576_659AB60B 
X-CRM114-Status: UNSURE (   6.76  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

