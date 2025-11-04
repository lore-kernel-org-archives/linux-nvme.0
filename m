Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58A8CCFA00
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 09:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zo+v+I4+4hNzyEdpTLX3lyu2mUDwsgwys0xGnDbMc1Y=; b=3hdD+qhb0akw6Xl2cVSY2zAx9T
	fw4IaWC1tA+F7bHJKAZn0kWX+OsgmNUfP0xJCa5ps6cZvmBOg0xFqokB1FwZLraMHFEHnEvkhsWBv
	G2tIZWuIDRyg1b9PfffJBQHwoCnWosve0qTu+qzDy1gmaha4MHocmUZWUB3nYOul/WV6ZHzoehTjM
	XseGxdKZem0Vy5zJSslNsgvXf0FFyuG/mfcUWXDyE4UosK7HnXdAcupoQeaHcQfPP6DGXmr0pHF71
	Z8TpTMcp457rQYjCj0ULsv/H7cQHhk7IjmhOtXyx7L5svSPqoV7cXQFouXu8jZNjLOo9YQqgDC2mU
	d1yMEdrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCwx-0000000BV84-0Suy;
	Tue, 04 Nov 2025 09:03:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGCwv-0000000BV7a-1qS4
	for linux-nvme@bombadil.infradead.org;
	Tue, 04 Nov 2025 09:03:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Zo+v+I4+4hNzyEdpTLX3lyu2mUDwsgwys0xGnDbMc1Y=; b=Ww1ZR9rOwTSY/lOkzAHgyFyhj9
	+1Gk2b3U2+dLmj1wwbwzJtzNDzgMZUZaKd1rv5j5R4Mh94NAeqm/AVTzf6+FjK65kCig6n8Xns9G0
	AAcKYbk4LuPu9cee0twLaZOMJnBazalvojfkvtSQxqTa2cU6MQj5k90/CDccqVnTpDMlVg7NxFfVo
	AHTsTKDM8PAcqSQfkXtVt5+9+FOLvJyCN49Jiv9HivwK5dYeAW8qn3ZC6NgO+GZCYh+ov0hcxYBrx
	suZhxi9qIZ+UiHybOO1zS8ezkoEqLjVQ4HBO3M/1ly2VmVv9sy/gMnsS6D9OTab+fWL5MHpdaTQtG
	k48AaQDg==;
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGC5B-0000000HE3x-0XBw
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 08:08:02 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3348811f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 01:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762247009; x=1762851809; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo+v+I4+4hNzyEdpTLX3lyu2mUDwsgwys0xGnDbMc1Y=;
        b=Jra0tNlS5HMEmwlnr4kbTrdfXect1ZJRTWruiL+pBmxN1OTCA/ySdr1lFiRAxwyrlM
         aD2JR+nH+Ik6PTsuAu++FgnnxMrZVijBMOkM7RihqgwGlZF5QN4RBWLfxLz1rP7xB14S
         XpmvFnQFH0jlaB0SPySQ1hPOPKLCPz0k6X6OvxSqhuyLeWx6RDZ5xxqwHKxl/b5CBg9D
         x7FwijsKQLCBsaC8uDeBLFPbeYI4mgF4Ug0Wn/NvbHw/ulhHdPLJViQOR6op0CBMxXdl
         Ev3yYofj3hR8xqj6+KZY1L1quBYBeoC72gyof2B9Dm8APwEbNl1I2JUNesLBabxsfw++
         0SJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762247009; x=1762851809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo+v+I4+4hNzyEdpTLX3lyu2mUDwsgwys0xGnDbMc1Y=;
        b=Dzd/0sj4SaDdZ6WQzzvJl8hGk6NEeAELgIH+/f2DLPakUhNo4ZMNzMpa+YBD5Ehzy2
         lG+zdvhqIGN9/8adhN5gJXBlvM8tpZHXLFDjoVUiyqRBI0nfKDXTlIiPDYp4YSmcCIDB
         v1oKjSHNaPd27qltnkzcFjASQDGCntysJGiqIdJV3oOrvGMJH3IwS7FNzXFcrJ8YZkOn
         TUyPnZArp4IK5CmKAiaqcTWvWvx8+1wCJWBHB8aQEFM6jgkRiIvO0QHGF1CUih17qVuO
         4kz+osi97AxQ0cRW1kxt3+bzCeWMUlu5IVK84upImYDYKMOrm5h421cMMS3wVN8C5GTF
         isyA==
X-Forwarded-Encrypted: i=1; AJvYcCW2th/YU/oaDRshuD0WoifdBMir5p+/TZKHRV38z1uqhJe2Y39UOCtKJ44QOzGhvsLdyBUckhxoikeV@lists.infradead.org
X-Gm-Message-State: AOJu0Yw+novBIerHK1AL76FUbwQRrfp/UjeB4vDN53FYTq7hQYlhxA96
	9gYk1gv5PLOhHA3Ah9r5BTtiF8WMbgMBeVfEkYFUvIWAItnCezvWIQuI
X-Gm-Gg: ASbGncuj+CFxQqwIcscVSKSS2TCDSkAld3/yBiqLF822EHRvcE6yr4UgcfQ+hK1LU6j
	ob9FI/Lqq1+gwKSWStF6q6t1+236TZiP+UhjJ2xpD1mx9c98xDoSHKR8+CldFEFBuMJ0GNufTqv
	gJ6SN8QDfI2GCaSFEsO5jVj7O/WMOqDnV6Lk2X7y0+EnwsuTXZVxGDlIsgvU6j75HMaWtI+s4Hr
	6g104Sz6IIOOlBgc3uJOkgTb6Z2I6ybXd9wAG1Y2y6IFqwq/KK5O9SZLKz8pqV0RiFCmcRyAPAn
	NablJtaPuEX+HJNE0trX+OvJso2eWXzBJrDatH/PggLlNJBbE9nvdUVO3Jdr87jrFxz0eJGJLg/
	JNQlCAX4por79QvFcdSjxNXUjav8t8qpALM+LD6laBTsfAZLMGqSN+LNaH9MOF6UL7JqtynACld
	438Nen1YV24cQ9LvUbfb8RfO8K9yFypYqtiayk7C13wg==
X-Google-Smtp-Source: AGHT+IFSl8Yus2hXHqquAbsHWOjt30uW3Pr+rVQvYNkob8XHiLc9RfhluHaTs0Iiu4iVjKlOwvYm9A==
X-Received: by 2002:a05:6000:2387:b0:427:6c6:4e31 with SMTP id ffacd0b85a97d-429bd681254mr13032111f8f.22.1762247008372;
        Tue, 04 Nov 2025 01:03:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc18efb3sm3529487f8f.3.2025.11.04.01.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 01:03:27 -0800 (PST)
Date: Tue, 4 Nov 2025 09:03:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, Andrew Morton <akpm@linux-foundation.org>,
 ebiggers@kernel.org, tytso@mit.edu, jaegeuk@kernel.org, xiubli@redhat.com,
 idryomov@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, home7438072@gmail.com, linux-nvme@lists.infradead.org,
 linux-fscrypt@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] lib/base64: add generic encoder/decoder, migrate
 users
Message-ID: <20251104090326.2040fa75@pumpkin>
In-Reply-To: <aQiM7OWWM0dXTT0J@google.com>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
	<20251031210947.1d2b028da88ef526aebd890d@linux-foundation.org>
	<aQiC4zrtXobieAUm@black.igk.intel.com>
	<aQiM7OWWM0dXTT0J@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_080801_231422_CB3A7E72 
X-CRM114-Status: GOOD (  18.05  )
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

On Mon, 3 Nov 2025 19:07:24 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> +Cc David
> 
> Hi Guan-Chun,
> 
> If we need to respin this series, please Cc David when sending the next
> version.
> 
> On Mon, Nov 03, 2025 at 11:24:35AM +0100, Andy Shevchenko wrote:
...
> Hi David,
> 
> Since I believe many people test and care about W=1 builds, I think we
> need to find another way to avoid this warning? Perhaps we could
> consider what you suggested:
> 
> #define BASE64_REV_INIT(val_plus, val_comma, val_minus, val_slash, val_under) { \
> 	[ 0 ... '+'-1 ] = -1, \
> 	[ '+' ] = val_plus, val_comma, val_minus, -1, val_slash, \
> 	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
> 	[ '9'+1 ... 'A'-1 ] = -1, \
> 	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
> 		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
> 	[ 'Z'+1 ... '_'-1 ] = -1, \
> 	[ '_' ] = val_under, \
> 	[ '_'+1 ... 'a'-1 ] = -1, \
> 	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
> 		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
> 	[ 'z'+1 ... 255 ] = -1 \
> }

I've a slightly better version:

#define INIT_62_63(ch, ch_62, ch_63) \
	[ ch ] = ch == ch_62 ? 62 : ch == ch_63 ? 63 : -1

#define BASE64_REV_INIT(ch_62, ch_63) { \
	[ 0 ... '0' - 6 ] = -1, \
	INIT_62_63('+', ch_62, ch_63), \
	INIT_62_63(',', ch_62, ch_63), \
	INIT_62_63('-', ch_62, ch_63), \
	INIT_62_63('.', ch_62, ch_63), \
	INIT_62_63('/', ch_62, ch_63), \
	[ '0' ] = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, \
	[ '9' + 1 ... 'A' - 1 ] = -1, \
	[ 'A' ] = 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, \
		  23, 24, 25, 26, 27, 28, 28, 30, 31, 32, 33, 34, 35, \
	[ 'Z' + 1 ... '_' - 1 ] = -1, \
	INIT_62_63('_', ch_62, ch_63), \
	[ '_' + 1 ... 'a' - 1 ] = -1, \
	[ 'a' ] = 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
		  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, \
	[ 'z' + 1 ... 255 ] = -1 \
}

that only requires that INIT_62_63() be used for all the characters
that are used for 62 and 63 - it can be used for extra ones (eg '.').
If some code wants to use different characters; the -1 need replacing
with INIT_62_63() but nothing else has to be changed.

I used '0' - 6 (rather than '+' - 1 - or any other expression for 0x2a)
to (possibly) make the table obviously correct without referring to the
ascii code table.

	David




