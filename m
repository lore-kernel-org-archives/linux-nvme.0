Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8E6C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 27 Feb 2022 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAxWN/Fn2Mczw45wFLz8L+Vyy3ASNUMHSwWD9KKoHkQ=; b=a2rxvF6q/5S44YDJuwCnG0lOiO
	Otv2xoRXAjQTaY/d7ot5vnNBvjWQiUnzLx4DYfWsbeGSHRTec6XHUcQ9k7+axGquWsV+6JEEXf3Be
	DQbvajoj6t1VK5kP7tekC7HgjOnSrdc76gFfNTyvWSLfQ2ZVqpZgg4wpn/BUBdTTlHWwF+Oy1krV4
	AvYKwOD2uBAaeTh0avw4usDvBGWBImNcFkIelw+cXtPOPaCslWS/cGda0xk7816E+ysRM+LRbJQWT
	gjNfnTnbGj9X1cV/PXOCUMhx0skQDzuHKXO6ntRqNJFQr8PysooQeS8zF9ISEloLFjRi6A76B8Jvs
	olBKbOMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOSrP-00AKm4-4M; Sun, 27 Feb 2022 23:21:51 +0000
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOSrM-00AKlm-2B
 for linux-nvme@lists.infradead.org; Sun, 27 Feb 2022 23:21:49 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 ev16-20020a17090aead000b001bc3835fea8so9816356pjb.0
 for <linux-nvme@lists.infradead.org>; Sun, 27 Feb 2022 15:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PAxWN/Fn2Mczw45wFLz8L+Vyy3ASNUMHSwWD9KKoHkQ=;
 b=hb0MT0VzXqCNtjpE9iJKpWmaQaleL6jFvHBWbfSdHnkD945vP+VS4aQorKQ3TSJUqS
 6FkAAk9GGBT+17JGDY3jPq+qIVSWmFj9aSJoLCFKoUh5fOECj9INO2DSy64D8RmBa4ML
 8AWpHeD91QAlXhNMonIQNXof+c639RxKTh5jQ5632GQvdp634EhhrJSyV15zLA5YasjA
 uDEk+voWOSmeQ70iV8mYN/56y+zd7Y0VaiSluZt1eNqeZ+5Sd5h/sXk0Z0W1ZeNmn169
 xFRmxaS/xbUznFXp3Id9GmIO+3KgrzjdC3GsCA/RB/SXodc9qrYp1vOPQiIYOyhIzKk9
 +qxQ==
X-Gm-Message-State: AOAM533+Ed1w04ZZE4vf5IligJJszsc5weGF1Y3NAJzVyHARzP0CRokG
 6JLlVWAL4eSXNzqLJjWra3Y=
X-Google-Smtp-Source: ABdhPJx3hEjd67rMbJmf0135OrWhFWBYzB+s9qHiBPBu3CDQnOPnI0KAABf9pqTHWfY3++H0rAZCyw==
X-Received: by 2002:a17:90a:f8c:b0:1bc:cf23:2319 with SMTP id
 12-20020a17090a0f8c00b001bccf232319mr13931101pjz.67.1646004106456; 
 Sun, 27 Feb 2022 15:21:46 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 b17-20020a637151000000b00372e85c81casm8489669pgn.77.2022.02.27.15.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Feb 2022 15:21:45 -0800 (PST)
Message-ID: <bc4ae9f0-3028-3f27-157a-44a00632c214@acm.org>
Date: Sun, 27 Feb 2022 15:21:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220227_152148_161520_67A7509B 
X-CRM114-Status: UNSURE (   8.10  )
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

On 12/3/21 19:04, Yi Zhang wrote:
> Below WARNING triggered by blktests nvmeof-mp/002, it can be
> reproduced with the latest 5.16.0-rc3 and also exists on 5.12, pls
> check it.
> 
> # use_siw=1 ./check nvmeof-mp/002

I can reproduce this issue with kernel v5.17.0-rc2.

Bart.

