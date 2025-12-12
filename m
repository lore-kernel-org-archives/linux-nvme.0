Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F27D4335B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 01:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PiqT1y0DQKTCKplE+X4RtztJVQKRqPD52kbRIZIB4Kc=; b=RAJOmR9c4lCekPykt8rFZ04J8i
	9TE+vc2KHe//JUMRfPbY/1b43A7DHpOrE9KGz2LNAwjj8w/dzAUsuB/kRJdTEAYQF82mWKZHDMOas
	caNkBLJGXW35L/+McOAJntfcR0SvJXPVIlxFXMexEIAHtz65XIg5sWHWXScSpUuvpHz1xJ3hTRU6w
	Njdg0/8oklMkxazCiOp+uLF/+MSjDr2gl7Bb+HDyPHrq0mkFK9k5nIsjFmkiaRJV7FrD/GHeHxRzt
	gmfrk60V8gFP3qh0MSpaVh8WOB6jLTLGwTpW+uUJeZqhrvRukN7dKgZ2IaMVrvgb+CW2yrVtASELH
	XGs3hcKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTrXt-0000000HSzZ-0POH;
	Fri, 12 Dec 2025 01:02:09 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTrXm-0000000HSyy-0a3x
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 01:02:03 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so714066b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 11 Dec 2025 17:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765501320; x=1766106120; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiqT1y0DQKTCKplE+X4RtztJVQKRqPD52kbRIZIB4Kc=;
        b=DhIv55BJtuHeqdelSOFkY4bObcp3TPn9Ji5jk15f9VTcnyZ17fh8OWdXbWvakXSqaK
         O85oaYAyEKrcojoQeXZwVH61RXAydDcyIe2iiORLPLECccjMq9QFTQWLHJcabA9CAscr
         PaV076ClfV4tZxWGzHOkaBM4AtNOx7oE2at7CPNVYPzgZRpyPFqoyY5BjUoDWmu2OyP4
         ElGekYDsitr6/0BT4Y1VtF6sPrKvJAHUg9SUr46P1oMJdqmoZYK3fiazxvVQDU2PpCGU
         F8ONv9HXd5wetUZFkueVXmKHyZHvKGtZuXW8t+Ke79nIyyxUMJi/ejb8dVgth/9Ue1e5
         JZrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765501321; x=1766106121;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiqT1y0DQKTCKplE+X4RtztJVQKRqPD52kbRIZIB4Kc=;
        b=wI/Afk8xpawXo0aNs/ahsJdS736JHl+VVquzhbxy5H1yis2gAUP/98TbW5fLLUUgCf
         +tHYgNkPQvZTsywlAkGHZ3gHltX2d9YBAhFRZsyAxkDYCyF7dO8ZzuuHBcwG11l7s+7z
         M6wiD++UqsceIPYPzVPEQ63zCBILD5La2r5beAAhYFx7Kt8ILYn+m5xzxZu0lqfgwbzi
         s0c7BRmuiS5n+Lukcr8rNXi0qeEiF5LsFa3UK7l/e1+eXcwJzHdzfYeX9uzhxwoNmfmc
         7qHGQ4AR9kTmhMGDVIosmcABkJbdd4qPNRO3QijZcDTEBE6o0673JXV6FcN8rSlyKPvd
         ifXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqKpYE3/DXg3frySK8kuLiXAMIf3TmiTDbFEfzyFD0UYEDvcTDv1iDLM7wKPc7eHut6arXvctZwF+e@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9gPMYhpYKMypn++vglC2+48xNsB19081WYkOs/3Vkr/3xOVPD
	IC1A3rxgdVi7VrudJdVdEXcAMkySG0CxKfNYV4lmCoPS5Ao3QrxjmxLp
X-Gm-Gg: AY/fxX43+Enz+C8/1o+2PBeC8O6W5jvGAESR9+rYBntLxruLByAoQmjVW+m9l8yrCZX
	yV7J/Xxqh1xmjQD5jBTDoBujgTOXGj6N5MnsMUXAPgiPtJsaN3KUT04L2xs3QYRAnjgzSpDiGyt
	5SS5ZxjQkF9SrDdy/Ipiw4Sk6KsYeR2HnIvqwvCfOyc3HkR30zB7FExaxn7JC2/T4/ymXtmi01J
	e4tYYErgGS2/O2n1ialfW/MnhBXAHSROLDDszrCFo4NRhw0yv29x/2eUKXMp3QOwU1JyK7X4kvV
	imb+PKHF2vHfVCcRVUC9g5qkx49FTXF/GiXyig7MN74Qh0rPmYTAHExWTY9ANPC7ZqjdQmTInFX
	j5YqKaXBSO0YavxVQkuFgo4SShKO6ZkvkTpE+vvRp30yvyjl1IdpmTQ3D9McSFKC0hWUQkLF7aS
	0+lVBB9EnVZSmuLtQ7Tq0gxh1C1eS8duTWjwTMIvy8JAy4npI8li30jihSZYuYDHI4juIHLGsIP
	Mbjz04/bq3DbLxwDkb7OyHy+HIbpWI+EOz7fMJHnPvK+1iJmQaAQvzbV0OQWQ==
X-Google-Smtp-Source: AGHT+IG0+NAokoVmG4o76ltchxh72cgR5S6czK8w8NPqiA4lCkRSaBrc+e6H5PWtVLyiGmX8KUNYIA==
X-Received: by 2002:a05:6a20:1584:b0:35d:7f7:4aac with SMTP id adf61e73a8af0-369afa01e9emr370191637.47.1765501320420;
        Thu, 11 Dec 2025 17:02:00 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2b9d8a2bsm3358325a12.27.2025.12.11.17.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:01:59 -0800 (PST)
Message-ID: <fb1abb05-ac8a-4130-a6a9-1a1089df441d@gmail.com>
Date: Fri, 12 Dec 2025 01:02:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com>
 <aTFllxgsNCzGdzKB@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aTFllxgsNCzGdzKB@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_170202_191594_DA5F9E97 
X-CRM114-Status: GOOD (  17.65  )
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

On 12/4/25 10:42, Christoph Hellwig wrote:
> On Sun, Nov 23, 2025 at 10:51:21PM +0000, Pavel Begunkov wrote:
>> +static inline struct dma_token *
>> +dma_token_create(struct file *file, struct dma_token_params *params)
>> +{
>> +	struct dma_token *res;
>> +
>> +	if (!file->f_op->dma_map)
>> +		return ERR_PTR(-EOPNOTSUPP);
>> +	res = file->f_op->dma_map(file, params);
> 
> Calling the file operation ->dmap_map feels really misleading.

agreed

> create_token as in the function name is already much better, but
> it really is not just dma, but dmabuf related, and that should really
> be encoded in the name.
> 
> Also why not pass the dmabuf and direction directly instead of wrapping
> it in the odd params struct making the whole thing hard to follow?

I added it after I forgot about the direction and had to plumb
it through all the layers. In a draft of v3 I had I already
removed it as dmabuf is passed with the token to drivers.

-- 
Pavel Begunkov


