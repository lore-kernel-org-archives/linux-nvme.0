Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342E0C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  4 May 2022 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WN26lsagJL4pdNyPEQ7HfFpD1NYMfhKOpFKAu+2HvXc=; b=v3piW2wbKt0VRVUXzW3RPW0Fm4
	lNZErcYDOqQjsUFmSUlgQTf1d28/9mEcz10OBJBoFYfWmuQO5T0bf4yNU2yS8F8j2F3jCi+ek239v
	j+XjEd1o29LGP+O/zmXWT6tWhpqgaG5ukpXAtnRutnny41+TMDCN65DAtwzBTXiRg1LCdtADZpQ2i
	p0EsYJ90dKUyV0xCHy7+l+5+A3HQ/vKjb1Mlir05yWyN0/jeK74CJGIBxyy+FI/5WEP+LytxV3kKp
	JARyO6eFiqTaCUQZuWRlmy9mkk1FrX/B8CLXpdo8ly6meCpz60qENS1EfAMr8OXz5JwAaU/iUfstR
	jn4BPS2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmDpD-00Af2L-S2; Wed, 04 May 2022 12:09:47 +0000
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmDpA-00Af0P-Lr
 for linux-nvme@lists.infradead.org; Wed, 04 May 2022 12:09:46 +0000
Received: by mail-pj1-x1033.google.com with SMTP id
 t11-20020a17090ad50b00b001d95bf21996so5020307pju.2
 for <linux-nvme@lists.infradead.org>; Wed, 04 May 2022 05:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=WN26lsagJL4pdNyPEQ7HfFpD1NYMfhKOpFKAu+2HvXc=;
 b=eB+RA9Xn/HO7qvVXckDmKIxv3Rdk20fFxZXIJsbgSnU5xH11QlIbEk+41sSRfiGIYb
 2nvMYN3XJZB6LOyjUWjkt7VOrYe2d7LS7aJFstRKrw3vqC/Oqclo21b2nvOg5itOwE7A
 ZDNy7cs9VaTmKQUCQM4TdYrN21zXtxmWPKdHQQCZTqQnQ+U0QHrw3XuoED2zq6aNxSNd
 8wZajNjmxNv+5uEK9tmaV+jxKTHQAP26KDyjLr+7YJcBag7DYjVE8aiQV6ltpWAOjDjv
 upIuyuyU4KNewWXWIrN7VsA7foTz4EruCxYif6Tb7cNy1nAzX0pIH2NpQI3DYzM1k8S3
 trQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=WN26lsagJL4pdNyPEQ7HfFpD1NYMfhKOpFKAu+2HvXc=;
 b=Jdc44O2AGC4slhgjXd6F0YVcA4gl77pPTHj6i5vveotV88fh7l9EVs6+md+0C1Nrqa
 MMir7wuUeZMT+5GXsMfbIA3Wg5PM4+2HGSyNSQUYQzalB3toiF6Wr68yKvFDSO5uZDCP
 OlKXdDJjybvE9S18OwKJSivjBvpZqzx2sNL5IPlfkTbcd4TcV5gXu3xEiQUWYWHlR4Lr
 TiFirUYC9l7iJ6XVZ2uLEQgwSd8Xm6CsRHgQN4tIfFxqpmTPfz4Znb8bgZG54koV9yHn
 4XVt3opP5VvZXMdlX3upleRIzmDNCFRzbn9xFfVCliAWKUN2PmIpv+cMFUYXPScjYkao
 X9Hg==
X-Gm-Message-State: AOAM533qBmQgHnez2MUIHBs9D1F/LMSI4byt0VonjNintj1OTn9NzMLq
 ixM0+T/He3RVjvwVEsXHDxrTjw==
X-Google-Smtp-Source: ABdhPJyI9yHw5N7Z274pvOUBNLkDQslDEoywKffSOV3ZxsSOQ1SpbdjrK0LJm3PQ5VuOZ6r4UCKqPQ==
X-Received: by 2002:a17:90b:4f92:b0:1cd:3a73:3a46 with SMTP id
 qe18-20020a17090b4f9200b001cd3a733a46mr10136443pjb.66.1651666182660; 
 Wed, 04 May 2022 05:09:42 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a1709028a8400b0015e8d4eb257sm8186529plo.161.2022.05.04.05.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 May 2022 05:09:42 -0700 (PDT)
Message-ID: <812fe134-3e69-294b-fd05-9a8366e17467@kernel.dk>
Date: Wed, 4 May 2022 06:09:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] fs,io_uring: add infrastructure for uring-cmd
Content-Language: en-US
To: Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <p.raghav@samsung.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pavel Begunkov <asml.silence@gmail.com>,
 Ming Lei <ming.lei@redhat.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Stefan Roesch <shr@fb.com>, gost.dev@samsung.com,
 Kanchan Joshi <joshi.k@samsung.com>
References: <20220503184831.78705-1-p.raghav@samsung.com>
 <CGME20220503184912eucas1p1bb0e3d36c06cfde8436df3a45e67bd32@eucas1p1.samsung.com>
 <20220503184831.78705-2-p.raghav@samsung.com> <20220503205202.GA9567@lst.de>
 <CA+1E3rKe6G8UC9Pzkm4Wbu50X=TT5tise8g6umduhj1eTbN0+w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CA+1E3rKe6G8UC9Pzkm4Wbu50X=TT5tise8g6umduhj1eTbN0+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_050944_759313_B363113D 
X-CRM114-Status: GOOD (  12.82  )
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

On 5/4/22 9:12 AM, Kanchan Joshi wrote:
>> @@ -64,16 +63,19 @@ struct io_uring_sqe {
>>                 __u32   file_index;
>>         };
>>         union {
>> -               __u64   addr3;
>> -               __u64   cmd;
>> +               struct {
>> +                       __u64   addr3;
>> +                       __u64   __pad2[1];
>> +               } small;
> 
> Thinking if this can cause any issue for existing users of addr3, i.e.
> in the userspace side? Since it needs to access this field with
> small.addr3.
> Jens - is xattr infra already frozen?

It's not, as it's not upstream yet. But I don't think we need to change
it, just make the two structs unnamed instead. That also avoids awkward
small/big prefixes.

-- 
Jens Axboe


