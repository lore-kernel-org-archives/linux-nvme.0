Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D64CAC582
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Sep 2025 22:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQQq41SVVRbn6631nZmi56Z4Of+AjJI4UHPGihR3J2Q=; b=WzJ7MjOXeIgTAST0sy9DCP0HT4
	7milcQAjraxoVM5GsG6wCw7jk4459z+Of1s3l1vCWRkmkSjA5oKsP5dVRzLzThacMwYYnG7NxReMd
	cEgCgfp788OWHt1PVp0hr/Flw8ADqqYJ977SJJ5GlFFwOEfKA/Lw4Fr5aKhooRo6xbPGXGoarlPAP
	PszAxo0bwojxCAk1h9V92DkN1QPcGVwUohzMgbl0tgikooMHQcCimM7yFXmsGKSrQprfjuvJ4ytgE
	i0bG8skKYOSaFkJIXGRRn0nxhqGRiTu8yrjKWuyf4Knm04jF4tAnVZVIRnZTVy+qPgjpaZyDXbukB
	KV+AsjDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCfw-0000000By3q-309e;
	Fri, 12 Sep 2025 22:55:28 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCft-0000000By3N-2nqO
	for linux-nvme@lists.infradead.org;
	Fri, 12 Sep 2025 22:55:26 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3e76bde55f7so777501f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Sep 2025 15:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757717723; x=1758322523; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQQq41SVVRbn6631nZmi56Z4Of+AjJI4UHPGihR3J2Q=;
        b=F9V+y+iuruJEUOJaF4EQanpOuOUfC2Q9I5fReU/4Zpug4w0T/buEoDsF5/rYq1m5BP
         YZI9Dtk4wDJf4+Tm7up7c7ePGqyKIs8WecRBk/scrktd5Fie58TEyBgZ6UaaCZkWcW/B
         SZe1+tAdmEb2yeeRvtC176XqLAnhr24jWp3POC4Oyda3nFMEd9WEhupjW/bChpH5CwP9
         jEfcprdOS+JvvJVGnVvP96BzxsFrXAbBD/rqPgUvTEUqIbauewoKbRy/HKezz2y+KUdF
         SN3jw4YVD34vkOqfvfVmXhaGIw2JSE0IRCyZ5XWyLTf46BwEPsxXiga4T8/HNTwsWLNx
         3omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757717723; x=1758322523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQQq41SVVRbn6631nZmi56Z4Of+AjJI4UHPGihR3J2Q=;
        b=rcJcXr3R8zW1Z698hIxKkFUkTx98KFgwC83tqqVL+XruP2F0Nd+YNUsfJgqneJAaKY
         R95v0j4kvDFMrGKJ3O7HDUim9aq16FIm2Ufe0Jw6qRIC2wk9g6O6iG0Yhj5Z5nyjv88F
         xFq/WmCG49sy2IVnqslZ1xbMZgbCJuqvSfoZ5GnGugkekCyscKv5Md0ZD6+t44LuBCpY
         yQjkis78Swwx8VERQYj1XJ1ZCzmimQgaDPNNA25303Sh7y2HldwL/ZAVLRAq4M7F9yy6
         f6r6DlmmU1U3ldZmycnuISIMOtmE9b7mTtE3uRUq9iAEzDUhs5+Q+n4m82aSt7JR1BOM
         KAjg==
X-Forwarded-Encrypted: i=1; AJvYcCVRdAh/xqwRepDk0Rs7m+AKXkz9kCjQ0NRo1FRPywRW/ZJJz2gv+We4nt5c89thmrrBYArYn4vmeyjC@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7phdyOWy5q3Qh71rrwhl1nHmWulr6dTzx/NDzjgbsN9GojEv4
	43M7sBYfA+u0DvKGrllSDXiFP99FqWHVHOzU/Iqyq+A2xwoGo4H6hnij
X-Gm-Gg: ASbGncsiAozdH7Atztzg1UfEJmkQHzLB5pVO7npWPgbKymUh2BE8tZhn6lRBu5whTqq
	ApkpU0SAuxoQIo+tXR09wv9fBU7MjLZDoXVZjxRtXJrV99TyOdh08DEcsBc0s0EpnXF4UGk7owQ
	1SQCivJtKLqk0okF1Yw63X8q0h2ko/tSGHmC35IaTjzGpEOYbZJHt3RxKl2QzhO4qJljOLMQC9S
	qxIXVx/yNGtkTixY2PX/6S3KfQjaJTFz9zTkp8xbcUBTwHmwdWK5SIKnpi3I01LCvC+2lWtirIe
	AinFhOYPVxfb/OH7zZ9D6hpT3vdIKbvnzhhXM/Rz6XVmObirNd2/GRAl/5q2xRsq5lbEIJKGvfc
	glOfoUVrmW5dcXlN9CM/FBIQdRDHdbk/WoE1C4Soe3vMqjwfYZm84X8bSkToAeL0m0ilDfSoaZ6
	D1kwB65g==
X-Google-Smtp-Source: AGHT+IHIf0xPTQSq2SGK+xjb3mFSGDk7HN3L2nA4JQ5Js7XJrtXXtnD62hWKhZUN18BtSlP72hjvRw==
X-Received: by 2002:a05:6000:420f:b0:3e5:955d:a81b with SMTP id ffacd0b85a97d-3e7659c4248mr4152680f8f.34.1757717722835;
        Fri, 12 Sep 2025 15:55:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01578272sm84954695e9.9.2025.09.12.15.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 15:55:22 -0700 (PDT)
Date: Fri, 12 Sep 2025 23:54:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
 ebiggers@kernel.org, hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
 jaegeuk@kernel.org, kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <20250912235456.6ba2c789@pumpkin>
In-Reply-To: <20250911073204.574742-1-409411716@gms.tku.edu.tw>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
	<20250911073204.574742-1-409411716@gms.tku.edu.tw>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_155525_733886_367FA90E 
X-CRM114-Status: GOOD (  25.50  )
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

On Thu, 11 Sep 2025 15:32:04 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> From: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> The base64 decoder previously relied on strchr() to locate each
> character in the base64 table. In the worst case, this requires
> scanning all 64 entries, and even with bitwise tricks or word-sized
> comparisons, still needs up to 8 checks.
> 
> Introduce a small helper function that maps input characters directly
> to their position in the base64 table. This reduces the maximum number
> of comparisons to 5, improving decoding efficiency while keeping the
> logic straightforward.
> 
> Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> over 1000 runs, tested with KUnit):
> 
> Decode:
>  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
>  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> ---
>  lib/base64.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/base64.c b/lib/base64.c
> index b736a7a43..9416bded2 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -18,6 +18,21 @@
>  static const char base64_table[65] =
>  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
>  
> +static inline const char *find_chr(const char *base64_table, char ch)
> +{
> +	if ('A' <= ch && ch <= 'Z')
> +		return base64_table + ch - 'A';
> +	if ('a' <= ch && ch <= 'z')
> +		return base64_table + 26 + ch - 'a';
> +	if ('0' <= ch && ch <= '9')
> +		return base64_table + 26 * 2 + ch - '0';
> +	if (ch == base64_table[26 * 2 + 10])
> +		return base64_table + 26 * 2 + 10;
> +	if (ch == base64_table[26 * 2 + 10 + 1])
> +		return base64_table + 26 * 2 + 10 + 1;
> +	return NULL;
> +}

That's still going to be really horrible with random data.
You'll get a lot of mispredicted branch penalties.
I think they are about 20 clocks each on my Zen-5.
A 256 byte lookup table might be better.
However if you assume ascii then 'ch' can be split 3:5 bits and
the top three used to determine the valid values for the low bits
(probably using shifts of constants rather than actual arrays).
So apart from the outlying '+' and '/' (and IIRC there is a variant
that uses different characters) which can be picked up in the error
path; it ought to be possible to code with no conditionals at all.

To late at night to write (and test) an implementation.

	David




> +
>  /**
>   * base64_encode() - base64-encode some binary data
>   * @src: the binary data to encode
> @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
>  	u8 *bp = dst;
>  
>  	for (i = 0; i < srclen; i++) {
> -		const char *p = strchr(base64_table, src[i]);
> +		const char *p = find_chr(base64_table, src[i]);
>  
>  		if (src[i] == '=') {
>  			ac = (ac << 6);


