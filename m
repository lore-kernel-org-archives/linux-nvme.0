Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B92C38A2A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 07:02:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD5D120735
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 07:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AGb7woYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5D120735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TTEw+LrQoHg8/OclnBVGQRwIclS5bl9sZHpemkqny8Q=; b=AGb7woYkrmgHYPyfx6ltlQCoo
	Il+EHtasc5Y/RQIEq8hQ7kiywyEcAZqEcBAXbKOdDmWGgrvv37xud1heUXqThOb3Ce/xkH0XnzElB
	zEiF7AD/tD3xy8RhM7wIbqNCXFegDl6W9p8zp0mDhrZFdTMgL5l1WYdHjYGih0EXTxrwf4NBbwdBZ
	VZ590DDGTiikAAkcGzak+SeA0zQ6ToiW2wtBTmEUy7LRlcJ/G+FpnYtpZTAlElPIcmy5GHGbL/Xp2
	f8CF5xPUcqpdIAZ70rR0xsYTG4n0+4nLslITZ/OjuFXPP5K2XQxQOV+5i7i3UkI7w6Zo/4cCLA+gy
	P8VswkAxw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWx1J-0000Cs-CB; Fri, 08 May 2020 07:02:05 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWx1D-0000CK-Ij
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 07:02:00 +0000
Received: by mail-wr1-f52.google.com with SMTP id h9so592214wrt.0
 for <linux-nvme@lists.infradead.org>; Fri, 08 May 2020 00:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NQ+Ivb7vKfTuokCBqUC7gYU/Cq47HXsQjkIHUA2RCDA=;
 b=ebNcqU/GaEl98pnfFQdiJxWSqpC7xqkRL1bJp7Lg3X3lBnLm6/S9ZBFnUXwHa+CsrY
 mhY+lmF+b3lIFa0ddtQo5IRvUI+aUZRPUDSLAx3OFjRaRquwiwM4LLMj0Wn7gd2HQ9Yf
 YXSKibsM2ehNTIcrsXhL6Hn+rZwAGyzxMQZf3T8tcy8RctgSxFkmoWGcDgsqXfKQz9xY
 jMJF3SvRYsXcc9YJrijkwNxv59gwcVzkiuI5VmWexXVOl/7RhwNkhNC7Zq4pcE5FunWC
 3iwmQKYJYdoJJ+R/ySEBl+0AGfVvpuS7BwSBNyFmnnAAk8w2RenWcX/gBkzvY29lruK2
 nSHQ==
X-Gm-Message-State: AGi0PuZyfVuO5KFZU36P7tl/ThEn2XeooIEHZ+LYweaggnYuDBVfw9ua
 wSRnxxScQL4tc8NNXoWeERDDtJ/s
X-Google-Smtp-Source: APiQypLnxaMfD3swo++SkH3rRUI1kjVVswALh9bzsu2tL0vHr0S/jmfeG06TTLj8a0fTrKe/qVmwuQ==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr1207830wrs.350.1588921316625; 
 Fri, 08 May 2020 00:01:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6507:baa2:4de7:40e9?
 ([2601:647:4802:9070:6507:baa2:4de7:40e9])
 by smtp.gmail.com with ESMTPSA id t71sm12276189wmt.31.2020.05.08.00.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2020 00:01:56 -0700 (PDT)
Subject: Re: [PATCH 0/3] Add nvme-tcp hpda support
To: Yoray Zack <yorayz@mellanox.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0cffbf28-0e40-e1f1-219d-330c0fe43ffc@grimberg.me>
Date: Fri, 8 May 2020 00:01:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588860124-40089-1-git-send-email-yorayz@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_000159_616778_235809D9 
X-CRM114-Status: GOOD (  12.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Boris Pismenny <borisp@mellanox.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Given the padding defined by user-space, the host driver will
> send the requested hpda to the target which will support that
> on nvme/tcp c2h capsules. The host will parse the capsules
> according to the padding.
> 
> The request hpda is 0's based value in units of dwords in the range 0  to 31
> (e.g., values 0, 1, and 2 correspond to 4 byte, 8 byte, and 12 byte alignment)).

Thanks Yoray for the contribution!

Can you share a bit on the use case you are adding this for? Curious to
learn about it.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
