Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E737C2D0CD
	for <linux-nvme@archiver.kernel.org>; Sat, 17 May 2025 20:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZ6Cdn9EsHHItXTMwN7zCQevwD72gZm5vOAf0aeJXRQ=; b=pMO+OAJ4gnlFwD3BIK7VuJnHZn
	oOPl3uHUNv0BCHFU7H9zqVLFnwRN0HZbKsQ6uRXR/aM8+I3ApsoAqqNuiNTporSKm7oD2P4AHumpO
	EJfFQWBHd355i1tr2FZhCaOkUzbYP3E877NwH7HDagj6OkK+c9jDGAahSa3qhklxgcTDMoYPLx6XG
	3zTtWD5Np43vlqB0mXBVJ//dazsdXzviR87QmWB8b78lgnz8qLp0bPtIhMvK3IK0PLV3C8JndMd98
	RUAdw5IUXyM7JEE5ah2XEEmSJwEHrEUKISpOkdtH2k2qMyS1mkhCZeFX28Oj/czj2WUmJMWxG/5Ix
	7ngIerxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGOAc-00000006FxJ-41lo;
	Sat, 17 May 2025 20:30:10 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGOAa-00000006Fwr-3RHe
	for linux-nvme@lists.infradead.org;
	Sat, 17 May 2025 20:30:09 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a3681aedf8so581783f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 17 May 2025 13:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747513807; x=1748118607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ6Cdn9EsHHItXTMwN7zCQevwD72gZm5vOAf0aeJXRQ=;
        b=ZP7dHk3yzIDyA7Vya6Ijer+cFnJJHVNL/fOd78/9RtCn1pVhMQAREfQPUQe/nEQPaN
         6NbHAI9iAm4staIczhMxz96Y9o+m2hwkElOYjWQXK74wuXEHtZnO3hW4UOnGoKUzTyjr
         wvD0nmWAZtuRM4FMVhLJm4+1Iw47TGPqqrydFIVomf3t3EgqR1fOd65c0AEBg03T69FV
         7RUuBOeMAyTXGJAGyyfSumnYVQxqTBNpqeN3eXnfiDR/n8C6QntATAnayctGwb/1PNkA
         EeMLQqk9KlTXGBehYqLK/0DJyCT8tBlcPSxnFt+83TOdRhmbmtirOd6gcL/Xe2VR99zx
         +bpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiwzFOaocGqiirUJ1aiNMQjlXFWMGkUKtwaVEId2aAt9QUNLxttS7CHixxVT+rxsUirXMjbxJ/unJ9@lists.infradead.org
X-Gm-Message-State: AOJu0YxF/Fkbc5NCKiaii23hebHpL4H+nDa1iI1kResokDMZzdc2wXt5
	tFHyosviZxG0qEO628l3pTJnkg0cu7WMlo3ZzWrCQa8R0LDaBo7sa18S02rakQ==
X-Gm-Gg: ASbGncvJkNgUCNXcp27zl2+fLVgvmahy5aM6ERliO0mjuuREc1rIWctyLcZrWLcNGU1
	1sXweT9BLCwzim5hognkEww8meB/6Vkr2ygvozAuXZFTn+vzjvpcvStHAmysK6CJ8Bb19JOUqS6
	sLYSz7NP8Pq7B1QOoMDdLRQn8m9rsdzv8b+B0ygO8Wlg3Q8/9URWOdiRCXUq6lw48ksh1TbUXi0
	O6+/y7xfUJF0cVQO1CSon4gzqvSgW6sSEyCROaJETrlYJjaDXQ0OFzFqXdooq89CQfOuFKtSCRN
	hHb6Wfg0pi4WCEhOqqoAy5OZ/VU23UaZhId2XTAAuXcRhbj6rmnq0QwNviqTRB0bVdJlZ4SfL4J
	VTcj0iZzO
X-Google-Smtp-Source: AGHT+IFJqmkPD/xMbGwBXZGrXyFwki275AFmJligoT0yK4fE+E9Upt7H8FQdLTM+3nYtdYFvxxk6Bw==
X-Received: by 2002:a05:6000:40ce:b0:3a3:68c7:e486 with SMTP id ffacd0b85a97d-3a368c7e67bmr2248890f8f.51.1747513806737;
        Sat, 17 May 2025 13:30:06 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8cb2dsm7162321f8f.84.2025.05.17.13.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 May 2025 13:30:06 -0700 (PDT)
Message-ID: <b208773f-aefc-4708-a2df-17c9f64be270@grimberg.me>
Date: Sat, 17 May 2025 23:30:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-10-ebiggers@kernel.org>
 <8b4db290-00c0-4627-a03e-d39a22c56fcf@grimberg.me>
 <20250517172954.GA1239@sol>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250517172954.GA1239@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250517_133008_863232_8F374AC2 
X-CRM114-Status: UNSURE (   5.85  )
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


>> Let's call it rcv_dgst (recv digest) and snd_dgst (send digest).
>> Other than that, looks good to me.
>>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> rcv_dgst would be awfully close to recv_ddgst which holds the on-wire digest
> that is received.  I think I slightly prefer *_crc, since that helps
> differentiate the in-progress values from the finalized values.

yea, sounds good.

