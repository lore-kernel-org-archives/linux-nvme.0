Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF2AD5B156
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yd1rJb4mWMaQjl27aMZhVEr4utlmzGlMM4YloIg83ak=; b=OhC19gWJdeoPhqz28t9Is/QU2v
	M2MnFcnQRwMNrpuiScmSzJiRe8q83ak3crZLessh7aIMt+DldYvgAGuNyP8qmyIhweNORi885IoXK
	sExktVWV2pJeR0KW8xlpgOAFPByNPDT8dZI5J+4kMU3Qkpkc3GA0bawl26Vvtt0itS+0Coiw1hcFu
	dzmkxYRLkIOUHjcE4s/4jz2wXRQ2nU32R74u3I6rrLEd/r3rEwteNEDpmD5YheWnNtrkQXPw9D3+D
	HG1p1GyiZPyrVWk0L43qNnD9NxFp2E/ZVYP+ngqGqVKLTsDBUs8ZCaliVWrw7gnn1bbEfi95uwur8
	PvYH2PRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5X66-0000000CJJq-2si1;
	Mon, 28 Oct 2024 21:16:22 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Wkf-0000000CGIa-0t9O
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 20:54:15 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3a4e5e574b6so10447765ab.0
        for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730148852; x=1730753652; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yd1rJb4mWMaQjl27aMZhVEr4utlmzGlMM4YloIg83ak=;
        b=Ny25++aBU3kmyQshE8GoiUdUd2xTya0T/iqZcaWTTVf4mnNmDOZzs/EQ2zGjzAOegb
         kSMqNl3UcNFyyEibPyBkRGjvEyi1H3smTbZolGzIljWRYGQum1o7Tc0Ake39LXTGswQV
         Ypd55gVjOiyEcP7EV0F84RnbJsVj+5JOQD4E8nW0AiY/JCPBbszcGocMSbbv9D/Hs5UI
         vWPkhJNIeibKRcvhWuXPEBgieW+k7tvbGE/wrq9jqWi6/kk2EqtS1l5Xu+jLiFRAZD/X
         pqP3Sgi24PbzFqIsmd4xquaQ7q6e5m5d8+R5B6qUWU02mtj5G2XTihKaZxeceIKI3PxP
         gN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730148852; x=1730753652;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yd1rJb4mWMaQjl27aMZhVEr4utlmzGlMM4YloIg83ak=;
        b=Qca5xv8K4ng1h0leZM+BuzZmjzY7I4v04hej4w/9WcFfwstazYy5kzd7K40FegmDcM
         Ggf4zPSsfQ++OhQsymDbIZxj9MINmPWEcWk9WIrSQSbRs6paJiD6y2gOyCgpO1gM+9A6
         M4dyHBAF46z6qA/zzGCnAGYRdygga1eDB4HQLSGIooGJpWZyrUzbZ55B2HXyMUbNUFK+
         ttFfmtlzpHgpxBtkfAdpAswgMP25PGMeXc9duEkZTcQaws63SZVMcKj8+zuhY3IZ1EgN
         Nr4vaC9tp2P2rgrFW4rZq4qY9+HQuuz5LwKO78bTzGki/wnG3hvVn3ynHg5esOiaWi/X
         bBOw==
X-Forwarded-Encrypted: i=1; AJvYcCUuw/rH1/r4dRBkf+/YuiRxYJ+TcaH7jx7xj2jgIvJLxSTVHjUTdxn6OMMPezjJ1AVuB93U+eTCMj6u@lists.infradead.org
X-Gm-Message-State: AOJu0Ywv4dhgzJW28qZ7BMqjT7uo9L2qqyctsPNV420KkmuBj4dTp0SC
	qdmqgUifyG9NOFjtSwECVFTaJXhBAbVpfSFg919oKLo69ynTsNv3i1Zw+nUA2Ow=
X-Google-Smtp-Source: AGHT+IE5aoGs+VCZUBYTQ4LrimhjTlEwvsULyhVziwNVeHJpOsf1BDZy/Bzj1rx0XhsDJhyKdLu6Hw==
X-Received: by 2002:a05:6e02:1c23:b0:39f:507a:6170 with SMTP id e9e14a558f8ab-3a508e01c68mr9289495ab.8.1730148851721;
        Mon, 28 Oct 2024 13:54:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6dfc9c2sm17957415ab.48.2024.10.28.13.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 13:54:11 -0700 (PDT)
Message-ID: <e5685301-ff1d-44f4-a10c-8f9a2f84488b@kernel.dk>
Date: Mon, 28 Oct 2024 14:54:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: re-fix error-handling for io_uring nvme-passthrough
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: anuj20.g@samsung.com, Keith Busch <kbusch@kernel.org>
References: <20241028205253.2054407-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241028205253.2054407-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_135413_547796_9E950037 
X-CRM114-Status: UNSURE (   8.53  )
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

On 10/28/24 2:52 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This was previously fixed with commit 1147dd0503564fa0e0348
> ("nvme: fix error-handling for io_uring nvme-passthrough"), but the
> change was mistakenly undone in a later commit.
> 
> Fixes: d6aacee9255e7f ("nvme: use bio_integrity_map_user"
> Reported-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me, but needs a:

Cc: stable@vger.kernel.org

to ensure it hits stable as well.

-- 
Jens Axboe


