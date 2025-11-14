Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD24CE7A96
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RmGL71As4NC9Ari9wD9SqERFZR+6bEtc3Jb/BauBhYM=; b=XzAzEWB8I8nO6sJ0m3GwrDxZXS
	DpCLvWOiYhW6DTzHVtDrCVr+wkgxwT3UjmrPf0NWTMnNocKVFXiG+qIqQ3Lv6WTbkWxy9KATnM4/P
	XHCmqxv3/16zpy/ymNwkEAIcgMN7BmfddCuZUppuBM31vonjeNXaeAOxiDOypws0K8fUcbdWCllqI
	VbCKdCFibWQVOerBQ14sua+H0mDuOVVvWaTk0qpq1Pa/KlgsG/6vNWpR1mmX7CgzhB+AeuW2HoJ6s
	kTOAvgxk/u0fSIC8jezi5gVkx1DXN2OeraT+sMe510DSK2yOGQLxVNJIpoLd4lnVhn3BKccXvtGyE
	pwsU2SGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJptU-0000000BsOi-1JyU;
	Fri, 14 Nov 2025 09:15:00 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJptS-0000000BsNn-1oub
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 09:14:59 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so855332f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 01:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763111696; x=1763716496; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmGL71As4NC9Ari9wD9SqERFZR+6bEtc3Jb/BauBhYM=;
        b=bS0evvdaNJWSwReO1wNn99Vnp3+O0a+gqcu9YuMKh00wIFHYMXqzp+N8BwqfAsVsE0
         exfXYBc8rnv/WftqXekF4VVYhXt/zXPmVQ0tKYvpT8iXjdt7y18hMrIqJuFx138yFFnA
         knZRKZH+peLRjGKfLV70JiQSsZV8t9Levqkn5Q6A7Gkwy4eIh0DTrfRoDE63mpD/TIZ7
         T3cZH9AaAu8EXsuNI1DdvrKj0tDTO/TDpYsodjPEsVlznT0H/AArjCxdi0owIH9bItCJ
         LAPai7cYt6TsTpXqGL7tfg6bQxGGbNgu2X8gQ+qkHc/nFgt2k6gge4a/Mm1xDfVoDF8e
         xG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763111696; x=1763716496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RmGL71As4NC9Ari9wD9SqERFZR+6bEtc3Jb/BauBhYM=;
        b=JE4MMHEI4jmw21CBqZJTRaJV9F6CKLOZnxuzXTnjBuBb7tIOxtxlindiH17mTMEK2B
         qUl8LGh3202zfzrRhWW7VHD/bKrBkz2Ic9Z2TdGf+qISSuHkwltonugd6l9EpltS08ec
         UB9YlCbEyJr2uT1SsQCn1SH9/ad+208O4dAXdTRYNcyXMfKal7X+9a1pVhnJdlCqtdw5
         YUj2UQ5Pzl7vnFIAavMt91ZxplCcWiTIBCRU0vvkga9fRSLa5C5yMOqJPqvVxE+l8SO0
         BO+EtPDmi7Pm3T/o8X8ve4BBnzmdsMOYGubhruIlFE9ocqQ6EYebYEw8S7QG+N717C4W
         wXgg==
X-Forwarded-Encrypted: i=1; AJvYcCVFlQJbFh7T60XpIfKfIHUSdRU268Iuvgqhoi8FIngikVs+cAd9xCOno6SiTm9naMHlxPA/e8aD0OuB@lists.infradead.org
X-Gm-Message-State: AOJu0YwMSJVrTzzVJ3InbWBA9ToDu+FFYV4GzeOz+bBrjwgc9ldZgQwn
	1yJKeqTG1sg2VfFcsDnQ4hDS3Unn8SZWLLMXo2GhGZL6Se8G0wsa/A5Q
X-Gm-Gg: ASbGncvucqql8B/TRu1srwa0cqxh0oGJXGOMjZK4/QqCrSRQtZKBLugFseVdHs8y9ve
	BpN5DTVl7I2RBj1s0SISrqWdwdqDSlBHohGlvRm5CyTSnmq1Y+yqNlFbk/KI+hD3P6g+C50/F0B
	GO6q1u+idQPHk2iSkiy0RM7jMv8l7fB8HFKJkCz9wmjvpBg3y46P7axKlDN1LT3xDqXq3h7VPMt
	J7IBB6CwciIdjcEYvl72DcfFrjSSlsSq6h6lCrmxBniyHax5ihpn2FeDbLTB+cliYgcARVFkPJC
	AZqe8ZmwBgEInPAr7DW38uKQFy8ujiykFsj7xuX5epkWUF26eH6vh8OGV/JTrrsxB8AeeEZlqI3
	TytB7j3qSobCrhpjRvv+7GAFFVT4Yoc490LULXNBoj1nZhvINJHC7pDZuU34TMM233ejEqZphdH
	KGnJztutALPuFumyyGig9NbTmKcupWQW/lpwVEkMNFYxDEAJtwsrox
X-Google-Smtp-Source: AGHT+IG6vU2bsOEFY2Pt3/YgVdDI6hItqo1MmD515aomBXXZ72CDnKNh3ehpPfNQLQSjE0uqgfo72w==
X-Received: by 2002:a05:6000:1a8d:b0:42b:3746:3b86 with SMTP id ffacd0b85a97d-42b5938aab5mr2239624f8f.54.1763111696455;
        Fri, 14 Nov 2025 01:14:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b8d6sm9102852f8f.28.2025.11.14.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:14:56 -0800 (PST)
Date: Fri, 14 Nov 2025 09:14:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, andriy.shevchenko@intel.com, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, ebiggers@kernel.org, hch@lst.de,
 home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
 kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, tytso@mit.edu, visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v5 2/6] lib/base64: Optimize base64_decode() with
 reverse lookup tables
Message-ID: <20251114091454.5a5dbfc7@pumpkin>
In-Reply-To: <20251114060107.89026-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
	<20251114060107.89026-1-409411716@gms.tku.edu.tw>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_011458_504216_56D2617B 
X-CRM114-Status: GOOD (  22.59  )
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

On Fri, 14 Nov 2025 14:01:07 +0800
Guan-Chun Wu <409411716@gms.tku.edu.tw> wrote:

> From: Kuan-Wei Chiu <visitorckw@gmail.com>
> 
> Replace the use of strchr() in base64_decode() with precomputed reverse
> lookup tables for each variant. This avoids repeated string scans and
> improves performance. Use -1 in the tables to mark invalid characters.
> 
> Decode:
>   64B   ~1530ns  ->  ~80ns    (~19.1x)
>   1KB  ~27726ns  -> ~1239ns   (~22.4x)
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>

Reviewed-by: David Laight <david.laight.linux@gmail.com>

> ---
>  lib/base64.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/base64.c b/lib/base64.c
> index a7c20a8e8e98..9d1074bb821c 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -21,6 +21,49 @@ static const char base64_tables[][65] = {
>  	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
>  };
>  
> +/**
> + * Initialize the base64 reverse mapping for a single character
> + * This macro maps a character to its corresponding base64 value,
> + * returning -1 if the character is invalid.
> + * char 'A'-'Z' maps to 0-25, 'a'-'z' maps to 26-51, '0'-'9' maps to 52-61,
> + * ch_62 maps to 62, ch_63 maps to 63, and other characters return -1
> + */
> +#define INIT_1(v, ch_62, ch_63) \
> +	[v] = (v) >= 'A' && (v) <= 'Z' ? (v) - 'A' \
> +		: (v) >= 'a' && (v) <= 'z' ? (v) - 'a' + 26 \
> +		: (v) >= '0' && (v) <= '9' ? (v) - '0' + 52 \
> +		: (v) == (ch_62) ? 62 : (v) == (ch_63) ? 63 : -1
> +/**
> + * Recursive macros to generate multiple Base64 reverse mapping table entries.
> + * Each macro generates a sequence of entries in the lookup table:
> + * INIT_2 generates 2 entries, INIT_4 generates 4, INIT_8 generates 8, and so on up to INIT_32.
> + */
> +#define INIT_2(v, ...) INIT_1(v, __VA_ARGS__), INIT_1((v) + 1, __VA_ARGS__)
> +#define INIT_4(v, ...) INIT_2(v, __VA_ARGS__), INIT_2((v) + 2, __VA_ARGS__)
> +#define INIT_8(v, ...) INIT_4(v, __VA_ARGS__), INIT_4((v) + 4, __VA_ARGS__)
> +#define INIT_16(v, ...) INIT_8(v, __VA_ARGS__), INIT_8((v) + 8, __VA_ARGS__)
> +#define INIT_32(v, ...) INIT_16(v, __VA_ARGS__), INIT_16((v) + 16, __VA_ARGS__)
> +
> +#define BASE64_REV_INIT(ch_62, ch_63) { \
> +	[0 ... 0x1f] = -1, \
> +	INIT_32(0x20, ch_62, ch_63), \
> +	INIT_32(0x40, ch_62, ch_63), \
> +	INIT_32(0x60, ch_62, ch_63), \
> +	[0x80 ... 0xff] = -1 }
> +
> +static const s8 base64_rev_maps[][256] = {
> +	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
> +	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
> +	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
> +};
> +
> +#undef BASE64_REV_INIT
> +#undef INIT_32
> +#undef INIT_16
> +#undef INIT_8
> +#undef INIT_4
> +#undef INIT_2
> +#undef INIT_1
>  /**
>   * base64_encode() - Base64-encode some binary data
>   * @src: the binary data to encode
> @@ -84,10 +127,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
>  	int bits = 0;
>  	int i;
>  	u8 *bp = dst;
> -	const char *base64_table = base64_tables[variant];
> +	s8 ch;
>  
>  	for (i = 0; i < srclen; i++) {
> -		const char *p = strchr(base64_table, src[i]);
>  		if (padding) {
>  			if (src[i] == '=') {
>  				ac = (ac << 6);
> @@ -97,9 +139,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
>  				continue;
>  			}
>  		}
> -		if (p == NULL || src[i] == 0)
> +		ch = base64_rev_maps[variant][(u8)src[i]];
> +		if (ch == -1)
>  			return -1;
> -		ac = (ac << 6) | (p - base64_table);
> +		ac = (ac << 6) | ch;
>  		bits += 6;
>  		if (bits >= 8) {
>  			bits -= 8;


