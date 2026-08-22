Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E97C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 21:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Igh0Ottskx2f9sZg+1Isz0Smwl9Yir5l0ffA/k19hA=; b=NW/9JBZAaDLyFCjprtQt6oHBaA
	pJy4SB7aFmnIlv2DnQiHoFtWQd4NDn4InGj38vkNldoXAxSxbT7yzC3hfRpO+sAea4RxBfYSZAjsz
	LMy7az2I+5WvJ5w6NL95mr+pzLp65xsLM0IVYchxkB27pG9rYBQaWoiLTQjH0rHXryBo+DcZEG5Qi
	jAAKWWuRbVZF+UBz/I/yNJLTuY2PYLcgTTTT212eHSEYo/wIW85BL8efpWwGHZ8wW/HgjI/n0Cz8d
	PR+UZt5Sc5Sb1BfXtXc3V4/mZFD/eYC6gpD65BNuXatdZcX+AZNJKvMXg/z/drwXSLbCoCCdf3HOA
	wu1xWZ0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtJi-0000000EoaY-32Z1;
	Sat, 22 Aug 2026 21:31:54 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtJh-0000000EoaD-0Fms
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 21:31:54 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c20fb91ed0fso318802066b.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 14:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434311; x=1788039111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Igh0Ottskx2f9sZg+1Isz0Smwl9Yir5l0ffA/k19hA=;
        b=iMHRApaAOuGxpygOYa6V+RZi+eRnY0SWzjPO1hfqOaKqaw1IPf/BLou7cpabmM2PNK
         9+Woh5UnDS5vWqfDj89JwKO8cTZGAO9L6ao5IGHORPZnfZ9hXbKnRs8adzA/tOkYWm2M
         kcb7w9xyuu7RPVPigSo+kHQf9FioD2ydtG8nr5rSKMWV5lrqktMr7RdDHmRwTrLcFIdr
         2w31NF+0f+zFgSbJqlF2/1TS/rhjKpOGhLeX5YLz7jiNF+P6uPchhskS5VnzIacGmtTR
         WvQLbyM8Q4Z4MZYldKA1CJbhIxeuyxkuZRWtvy1558+VOZEGp3Bmchbk58KadwSiQi22
         y+ww==
X-Gm-Message-State: AFuF++lFIxLyY2uacnSR+X0nQpDHWLxL/RQ39SyiMtvjrdz+yEf3IXLi
	QfZfQzUf6aDoUZVrj38HFenV9KB4cNZuTLuETPn4/BOEY67EQ9eYfNKSYPrHFA==
X-Gm-Gg: AR+sD10tLxN/m1xR/zEEilnE7tL1KkL02apyNQyDkA8duzAnjN+5xYJ++T8ZEjzu9s7
	KDbmZHNwnIRfw9czYlIx73bVZ0ysj+8Xm9QS5DDs2Y5CDyQunFVbjTlDBgjn9WrnIUVzuEXJWWr
	PzANedg8c9yKteVWOEjbTKiFcbjOG7g4G1DSbA8DA8p0T4y5ia56xUcquZeU/RkEV0S3E61+URr
	6ZQXY2GG8W6YAVBavQf031oC4eTx7fj4lGAEaNztkObbAt5TZG8iUdea6UK1KdOctzw4+kZCVEX
	4uAJoxp7ersBP41WV905eFvNH5AcmFoR0nUHmTT9MBgubiSC6rkfqZrF3A7Ge5ce9z5LVY1a2Xa
	DVNX4/s0UtLlBJ1X8S3z7bqHpBQzPxg9r6L8Ga1wQJZHnb2rUbRw0xhQ/3hgeN0p4sR4bs2GLsb
	j3p4qr9YowE+y+nBlyG3LfBGSXU1yZ817fLdcjxaLqqJCyYkn2qW8M14EssC7ZvMDCdZlw+j9Bu
	3TpUduIPBFb4PzvvfYtOiQ=
X-Received: by 2002:a17:907:6094:b0:c1f:9c3b:96a7 with SMTP id a640c23a62f3a-c246a6269d2mr1682356366b.17.1787434310988;
        Sat, 22 Aug 2026 14:31:50 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f809bsm566254566b.41.2026.08.22.14.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 14:31:50 -0700 (PDT)
Message-ID: <5e602a4c-082d-4b7a-a594-acdaf7bca9e0@grimberg.me>
Date: Sun, 23 Aug 2026 00:31:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Subject: [PATCH] nvme: remove stale namespaces by NSID
 range during scan
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260821203854.3897938-1-mkhalfella@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260821203854.3897938-1-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_143153_110470_24499E4F 
X-CRM114-Status: UNSURE (   6.07  )
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

Remove the 'Subject: [PATCH]' from the patch title, other than that 
looks good

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

