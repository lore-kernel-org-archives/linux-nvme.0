Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BFFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 17:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eINKgwnplOc7DbhoI3lI5lGaLkG22uE7L7f1ckayxSU=; b=pzNPJ6rcMuvgZPUokdPuR/bCM0
	rCJjYPNzFVi6vfDvGMmO+RZUodvPNfUL7Z6Z5qlmiwmavbPIlWj/H0XijZ36ClQwUI0M8O8JNOY56
	RI8+2TXqUsV07CCE2zb5f3Yi6n/Da5Zuf5ekUnG1/kHAGscqBqwW/K0iJOOsPHgYj3yCOFYN1XyJL
	k4QkyisqkrBYpGUVKFn/duGOWGj9AkO2ziITuubS/MMJG81R90kM0TCe+YQncBN7xrV8SCoG1VCbn
	b4nWQgKLLr7KSErs6noTYloudtiIoa9dwHAyqHjyrw5WLlM6d/mZB24B28F43dasaTSblUyGMPQtQ
	WLyRYJ9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXQvM-00HIkt-IX; Thu, 24 Mar 2022 17:07:00 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXQvJ-00HIjM-18
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 17:06:58 +0000
Received: by mail-wr1-f51.google.com with SMTP id r13so7521377wrr.9
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 10:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=eINKgwnplOc7DbhoI3lI5lGaLkG22uE7L7f1ckayxSU=;
 b=ha8XvQEQjC7vFPAAM3YdApHOynsa/XvKDfLQe/qblMu2Krn1xyMnrbx8xLhGHR4x36
 0abKEN9s8EWCJHIIXtTzIGfCIm0CKSUOMDpwKcGvXzV9W30EEJbjk/jdPJyzpJYgycZ2
 5OTwQ5We3XW3qtTpEj9LNNPb4AiQgP7MZjIiWijO++6uCFt+Ds8R/lM6W2nTPSNrVZsa
 jX3z382VIVOoVSPddomEB0qtR/EpIF/Xc6ELcXZ95EHOl5WDzzwVwwyvdSkWt7e6rkfD
 /9YQqJI3EAYQJVTPAtiViUrHDFlMndnwU0mP3HJjyFYad9cukMJPaSXWD4EivhQV3mbl
 EkWQ==
X-Gm-Message-State: AOAM5327b1kYRrVCYsZCKaJWAG8a9vVSIXXxzXV45AG2wwG4K7HeY7PY
 g+cTTW5cTkz2IaRTuTguFFEZt3yJd2Y=
X-Google-Smtp-Source: ABdhPJxC9A7+FIiHTEirRNG61dGWkh9y8xZA6ODYs+CAfqcVr0B8EU0lDllROMTL0UN4uGejOR6qPw==
X-Received: by 2002:a05:6000:1848:b0:204:e92:5af6 with SMTP id
 c8-20020a056000184800b002040e925af6mr5383918wri.180.1648141615160; 
 Thu, 24 Mar 2022 10:06:55 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net.
 [85.65.206.129]) by smtp.gmail.com with ESMTPSA id
 u11-20020a5d6acb000000b002058148822bsm4338555wrw.63.2022.03.24.10.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Mar 2022 10:06:53 -0700 (PDT)
Message-ID: <7a664019-1ef8-9867-ecec-45e27052f9d5@grimberg.me>
Date: Thu, 24 Mar 2022 19:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv9 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220323071303.14671-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220323071303.14671-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_100657_109025_B438B559 
X-CRM114-Status: GOOD (  18.30  )
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

> Hi all,
> 
> recent updates to the NVMe spec have added definitions for in-band
> authentication, and seeing that it provides some real benefit
> especially for NVMe-TCP here's an attempt to implement it.
> 
> Thanks to Nicolai Stange the crypto DH framework has been upgraded
> to provide us with a FFDHE implementation; I've updated the patchset
> to use the ephemeral key generation provided there.
> 
> Note that this is just for in-band authentication. Secure
> concatenation (ie starting TLS with the negotiated parameters)
> requires a TLS handshake, which the in-kernel TLS implementation
> does not provide. This is being worked on with a different patchset,
> and subject to discussion at LSF..
> 
> The nvme-cli support has already been merged; please use the latest
> nvme-cli git repository to build the most recent version.
> 
> A copy of this patchset can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
> branch auth.v9
> 
> As usual, comments and reviews are welcome.

Hannes, can you resend blktests patch set as well?

IIRC one test there acted funky...

