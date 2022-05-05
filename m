Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B5AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJDsBNaU0WtP3zGJAVGJc1XV1UGinZSSPR/pmXCT3fg=; b=M1KBvGaEZnsZi6tCEu5iGWWvLV
	6oYT4T51ndcWZPWzefCESwyEhTqzU53agzZq9XdEo8zs6i9pXCPLr8hCY8XuCcNQ4zQISm0ZFtVAL
	yNUVDClCjP/x0I4fWJUFFeYt+dRAG4r9ikh0vy1Ea4Bql/O0OTl+ckcqk0Clkk5fbscyzSWiJz7cV
	+gMNRhEGCwJ6UMdJAOx1PiQPwgxIgjvGCcMciOv8vDQxKDNGBbNGXd5nrG8bfXihvNlu8tcjJrYku
	oNO715VQo7UR9Z13f79dxAlbGGX3w11aGu4bXUMk1x2WatEilal7itGHbhNE9j389yYPgwN/otk4N
	28Ee9Qsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmgEK-00HLRT-6Y; Thu, 05 May 2022 18:29:36 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmgEH-00HLP9-EA
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 18:29:34 +0000
Received: by mail-pl1-x62d.google.com with SMTP id p6so4648471plr.12
 for <linux-nvme@lists.infradead.org>; Thu, 05 May 2022 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language
 :from:to:cc:references:in-reply-to:content-transfer-encoding;
 bh=qJDsBNaU0WtP3zGJAVGJc1XV1UGinZSSPR/pmXCT3fg=;
 b=MsfJI7wgJazaq5lFNIqyg/2hjMk8meBjzjrd37sw7/Yk7hKbq6mcHgHKyfNrzPrwpo
 0E1Rhuc4JhEujqO3Ymm23DCQb1xvZhdoYQeeH+XZVHL1soFc+SIj43noHv6Iy8jJGrZF
 sh/+BF52lPIHxSSD0OLbL2P8hDReNZAUe/tmmvkUFfLQmKVNzbZP38QmNZXhrU+cy72m
 52jkMVElSfjXcglvj6sKvuLxDlZCb5KBH9dMTxZPfZSUn45mMeDk/RphA3UbmnpfW/3n
 KegiPP91o1WbPuGBlYgwClPlgjyMZJecmcGFZhwF7/JWNOflDDtINsW2zLF48xa8I5+y
 HXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=qJDsBNaU0WtP3zGJAVGJc1XV1UGinZSSPR/pmXCT3fg=;
 b=hfUWDWAyi5VN/Cz8XtdHhb4JcE+DBcEwhLVb7vWY1/9KiRquvNHMD/Rplu4GfqIFKR
 z8pOsF+XpYJAURsqaGEzyYqaCvJl9piCgoQUIGwaPLtH3mqpuSLpmE9sn9hgem5ZWfTk
 DRpFvOeUPS70POROero8OMA2Pt4negQWjOl4hxwXmjb67qQFJJtqDVXMJrziRmjmypxo
 Ka3Dj31YoBg2IBk62MI+EFOM4ZqqPfqVto9cxp+cuSnPkLvcpv36NmQ10scE1hur4V4F
 N2euU1V5s/zVxRkzVXzUeSRKBugHKKjGKgp39+PPqZdcSrkuQUdeU9uIpsCjEsJEEJdK
 5yRg==
X-Gm-Message-State: AOAM532qUi/owu8VVcIK3wmKzLgkxXpvms4tcH1jOFjtRbZmmQsnLadv
 13K06E3BjxO3CXl4ZbtkJ6u/2g==
X-Google-Smtp-Source: ABdhPJzkMXHdKGEICRUdE4gyAEM++LbBaogm7oaZDoNke0R5SMMnkNorn/rvTJeSWr6sGKgr+fDWxw==
X-Received: by 2002:a17:902:dad2:b0:15e:9faa:e924 with SMTP id
 q18-20020a170902dad200b0015e9faae924mr23518649plx.94.1651775369465; 
 Thu, 05 May 2022 11:29:29 -0700 (PDT)
Received: from [192.168.4.166] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a17090301ce00b0015e8d4eb1d3sm1934883plh.29.2022.05.05.11.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 11:29:29 -0700 (PDT)
Message-ID: <a715cc61-97e7-2292-ec7d-59389b00e779@kernel.dk>
Date: Thu, 5 May 2022 12:29:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] io_uring passthrough for nvme
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
References: <CGME20220505061142epcas5p2c943572766bfd5088138fe0f7873c96c@epcas5p2.samsung.com>
 <20220505060616.803816-1-joshi.k@samsung.com>
 <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
In-Reply-To: <d99a828b-94ed-97a0-8430-cfb49dd56b74@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220505_112933_510690_192DB1B0 
X-CRM114-Status: GOOD (  12.67  )
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

On 5/5/22 12:20 PM, Jens Axboe wrote:
> On 5/5/22 12:06 AM, Kanchan Joshi wrote:
>> This iteration is against io_uring-big-sqe brach (linux-block).
>> On top of a739b2354 ("io_uring: enable CQE32").
>>
>> fio testing branch:
>> https://github.com/joshkan/fio/tree/big-cqe-pt.v4
> 
> I folded in the suggested changes, the branch is here:
> 
> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.19/io_uring-passthrough
> 
> I'll try and run the fio test branch, but please take a look and see what
> you think.

Tested that fio branch and it works for me with what I had pushed out.
Also tested explicit deferral of requests.

-- 
Jens Axboe


