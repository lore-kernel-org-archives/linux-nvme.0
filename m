Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF969C25B50
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4yTdcDBJTrs5Cb/iupgl8JwyhPAoj/hrBf//3NRcvVg=; b=m2pra42sp9ORzgH8gCUAjksZ9D
	IaQBdplR4K+xlqGtVBBF0QQ+m2Kp8zPToIs6h1K2G9t9yEo4NzkYBME2iY+kdOVxYfCTtRITlbRv4
	k53ANhXpY6i5jrl9EEtgA28IpDOhbhGhUdUvh8AzEt8jtaDhLME5LjTEVW28a1d+rkeDOzVCR/9qG
	gdyoBlifHHKdbSwTpXZGDzlFNS5iTMS+DoZHEJn8IT72QjBjdqkR0heVS9CI8Fo92GJ1akO1Afesn
	GosAvG9x1sDihln6ip1HlniQDrHeZX2vK7I8Is+qVyh5eU1AlkhKUM6Asa1WSjSIWRqfQimrKvvxI
	iWhRmjLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJuys-00GxtF-Uz; Mon, 23 Jan 2023 11:27:18 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJuyq-00GxsJ-6V
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 11:27:17 +0000
Received: by mail-wm1-f43.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso8292006wms.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 03:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yTdcDBJTrs5Cb/iupgl8JwyhPAoj/hrBf//3NRcvVg=;
        b=6gY8OPAmruYFjf0Hqm26QpkiiHEA8NgnMK2c4K2pFmKMicm4lMOwJB4uRQFLs2lDem
         Zdarsm9Co4WfZw+5J19MdTFDzdy/4ZQzeRwA7gPPIbWVypq3KOR1QkIS8FKnFWa3Iveq
         pKay0yujtG194txd5JbMg/neUsjqlQnGTsdM57wjAGOS33gaglfEA7ARzz2fyMWxlAHM
         Z7dwi8YhbQi1LaOiUWngksv04RHBIEuQ45BFCz8Fif2Ly8FzFtvxw4P9xpZQUBXH1AQ+
         MrOlWuvCXG7Z/FEgl+cVMxZHT1N4ufQD2SekSzrbO/WPM7LEUfRKLoo6QHAs9gUjmhtu
         n/0g==
X-Gm-Message-State: AFqh2kraIjRbwfNQ4A27+DmhsYm9K37nkxHdWI3QfkbX2gSPyfST6DNs
	IFTbsEe4MFmgXRc5gVv+qLtGuxHw5Ec=
X-Google-Smtp-Source: AMrXdXvdjw20Lv7I4+W+Hg4dvw9yXtwgL3LEooExW5vSfd6qFA+Kr64gkQWRX15yiaon5VnaaEWpJA==
X-Received: by 2002:a05:600c:3551:b0:3d2:813:138a with SMTP id i17-20020a05600c355100b003d20813138amr31584379wmq.35.1674473233474;
        Mon, 23 Jan 2023 03:27:13 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003c6bbe910fdsm13400157wmo.9.2023.01.23.03.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:27:12 -0800 (PST)
Message-ID: <6f9da88c-f01e-156b-eb19-0b275c46c6b5@grimberg.me>
Date: Mon, 23 Jan 2023 13:27:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH rdma-next 00/13] Add RDMA inline crypto support
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Bryan Tan <bryantan@vmware.com>, Christoph Hellwig <hch@lst.de>,
 Eric Dumazet <edumazet@google.com>, Israel Rukshin <israelr@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Steven Rostedt <rostedt@goodmis.org>, Vishnu Dasa <vdasa@vmware.com>,
 Yishai Hadas <yishaih@nvidia.com>
References: <cover.1673873422.git.leon@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <cover.1673873422.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_032716_274614_3CE8DD4B 
X-CRM114-Status: GOOD (  18.44  )
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


>  From Israel,
> 
> The purpose of this patchset is to add support for inline
> encryption/decryption of the data at storage protocols like nvmf over
> RDMA (at a similar way like integrity is used via unique mkey).
> 
> This patchset adds support for plaintext keys. The patches were tested
> on BF-3 HW with fscrypt tool to test this feature, which showed reduce
> in CPU utilization when comparing at 64k or more IO size. The CPU utilization
> was improved by more than 50% comparing to the SW only solution at this case.
> 
> How to configure fscrypt to enable plaintext keys:
>   # mkfs.ext4 -O encrypt /dev/nvme0n1
>   # mount /dev/nvme0n1 /mnt/crypto -o inlinecrypt
>   # head -c 64 /dev/urandom > /tmp/master_key
>   # fscryptctl add_key /mnt/crypto/ < /tmp/master_key
>   # mkdir /mnt/crypto/test1
>   # fscryptctl set_policy 152c41b2ea39fa3d90ea06448456e7fb /mnt/crypto/test1
>     ** “152c41b2ea39fa3d90ea06448456e7fb” is the output of the
>        “fscryptctl add_key” command.
>   # echo foo > /mnt/crypto/test1/foo
> 
> Notes:
>   - At plaintext mode only, the user set a master key and the fscrypt
>     driver derived from it the DEK and the key identifier.
>   - 152c41b2ea39fa3d90ea06448456e7fb is the derived key identifier
>   - Only on the first IO, nvme-rdma gets a callback to load the derived DEK.
> 
> There is no special configuration to support crypto at nvme modules.

Hey, this looks sane to me in a very first glance.

Few high level questions:
- what happens with multipathing? when if not all devices are
capable. SW fallback?
- Does the crypt stuff stay intact when bio is requeued?

I'm assuming you tested this with multipathing? This is not very
useful if it is incompatible with it.

