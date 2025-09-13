Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D3ECAC587
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Sep 2025 21:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04qpIN+fZKNNBN7I+FlAUBoFYreC9O4k+On5eLa+qz8=; b=lUiR3kPV4v3XNkKxbBJWoz1CAm
	KolqGuqSkXehh0asCACtEvQ2hsRe0WanbiBk9OkLoch651NV/B2jYnc9h5z3A1Xso4pPADUFPHRpZ
	LETjPc6AO8Kf6paGgh/1FkBvKOB1aO3jtPRSj/g7UJpLsiVic4Hg0h0xqFQQuC6b9QgHx0Jj3RAep
	9DRaWsm9lT8mpUF/7IZm5edWqmdSpI105v32zEUPvUKWfs6gdWTralawTwgmnY5d/GAtPIjzTC2IV
	Jl7JoXA/eNFee/vYzLnvar9aIG4KSZg6/EDrmfhgIeA73G4fWsKZNzU0czn0zSe8gvI86T/6zpDra
	/w6uUc6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxXmH-0000000GLNJ-2BN2;
	Sat, 13 Sep 2025 21:27:25 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxXmA-0000000GLMD-30XF
	for linux-nvme@lists.infradead.org;
	Sat, 13 Sep 2025 21:27:19 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3e8ea11a325so654390f8f.1
        for <linux-nvme@lists.infradead.org>; Sat, 13 Sep 2025 14:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798837; x=1758403637; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04qpIN+fZKNNBN7I+FlAUBoFYreC9O4k+On5eLa+qz8=;
        b=iFUV27Lpm7VwZXx3EYwn5d4h1nPCDsNmFAWsp0XOm1Wv8ZD23SuXrb79OclCRUEmRF
         6A93Fnvi86dCnxXQYXNxxrSSm/k5NmztgjImn7nBskJ6u/GpUtLWraH1a0TH6YIVUVOY
         rfU/K/L/1boiqZaSCWh5pQ32kKYwK+ycHci6SyiwDocytW7Pp7SskVZhZUElDzd8TRpR
         QuyH8Voilftwg3ev5E9DOaA7ApL4IR/Ho1HrCaa+1INkGmGXgD7kTfHplmOVzelZj2ho
         +Arpkg2GlnLA+5MCW7jxZhrEf8RoPYU9QYWw/gx5txe+O3OnDGzIj1QmWnKfMHUXQDpq
         00YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798837; x=1758403637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04qpIN+fZKNNBN7I+FlAUBoFYreC9O4k+On5eLa+qz8=;
        b=ULZknfZP6mDtY8bTkCCwHOJPt77zNiVrtKsVkuLGinFw1r7ICXBdH5NcXSHibfXfgO
         zYv5/uDJuDzIjTvEsFEhldJ9IkO1lB1X2G7/gGmcLk2AR0nJwwEbUah65bptX05ffI4A
         RKdjxzOyzqUxMH8uuRFpDPGVTwU+i4cxsvCXh5iVCcCaNfXRtMavN/4DGdjoGIJ3JM3C
         ZTJyG0kJ9wqMX6KfpyYCuCwL456XEoH/chX9yMbneLvmn+/4GvoZM5FYBm5Q1au2Da26
         kwuvhGdwjMiSQbSc5rfrvL4uEgbZUFGoyVZCmCdZdj0zN5VTm9akhhBsakgf8P5tVtij
         Z1bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBBvS1snKbNzwCePk5pgNl91tr3pZyoKwvAM5K688jt63l1of2UuiRiv3IeLzRmZ+OnhBkX2xu0NAw@lists.infradead.org
X-Gm-Message-State: AOJu0YxOsawALhxqL9jDeWr4Iy09cl2xOaxeKro44szAzwXyPO+hf5Ut
	wyalyHoHV3CVp4x6z3ViZjB5KoeS+hvoQQY55BcVrUdDtewnjijbbgMP
X-Gm-Gg: ASbGncuS6NeZmhJ4X6LN156/1K35Z0cswKzkdPA1UjcuiltPd5EJ0HqkRtwNkY3urqf
	13djegEbliFq5egb5BP/QW1qvetsBSHu7x4oouyShLxyfw0neZpXMhvyPS/Y394RPXynJdMQVgj
	8oMHz5XedBYPTmabqBrEQ8KE35kRtHMdG+7vU+5uNZqXtzwSmUxTS6JcF+Xe7QUTzd2b+Q7MWQQ
	RxigultvMWjQA5b33S3gHZs9V27cKYL0Kb05qN0vBo9v7AVWeg1Wl17rMnTAqkv6RSEiK9tc4CE
	eDuPTbFh2V4lmMjmyEsMicmapJZr6CTpvMlvq5Tqq/MAk+DV8fKGWG9Lk4MniBnxub8jestjT7L
	+AlZHSGxnTsehVzEvRVlm0DvDB2mrSLckUv78i1me49F29RQqx5IABRZ3Q0Xi4xWqkMockF1bKE
	lD8IiWMQ==
X-Google-Smtp-Source: AGHT+IGN6z9+pVmuqZyHNovffXCVFTiBlSaxwVU9Is7CF2e2b52XUbcCYIX0d3TqqhVYSkV6hsC0Cg==
X-Received: by 2002:a05:6000:2307:b0:3e3:e7a0:1fec with SMTP id ffacd0b85a97d-3e7657924f5mr5797120f8f.16.1757798836589;
        Sat, 13 Sep 2025 14:27:16 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a066366fsm753048f8f.44.2025.09.13.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:27:16 -0700 (PDT)
Date: Sat, 13 Sep 2025 22:27:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Guan-Chun Wu
 <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org, axboe@kernel.dk,
 ceph-devel@vger.kernel.org, hch@lst.de, home7438072@gmail.com,
 idryomov@gmail.com, jaegeuk@kernel.org, kbusch@kernel.org,
 linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
 xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <20250913222714.47b9e65b@pumpkin>
In-Reply-To: <aMMYmfVfmkm7Ei+6@visitorckw-System-Product-Name>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
	<20250911073204.574742-1-409411716@gms.tku.edu.tw>
	<20250911181418.GB1376@sol>
	<aMMYmfVfmkm7Ei+6@visitorckw-System-Product-Name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250913_142718_795292_CF06B527 
X-CRM114-Status: GOOD (  38.34  )
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

On Fri, 12 Sep 2025 02:44:41 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Hi Eric,
> 
> On Thu, Sep 11, 2025 at 11:14:18AM -0700, Eric Biggers wrote:
> > On Thu, Sep 11, 2025 at 03:32:04PM +0800, Guan-Chun Wu wrote:  
> > > From: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > 
> > > The base64 decoder previously relied on strchr() to locate each
> > > character in the base64 table. In the worst case, this requires
> > > scanning all 64 entries, and even with bitwise tricks or word-sized
> > > comparisons, still needs up to 8 checks.
> > > 
> > > Introduce a small helper function that maps input characters directly
> > > to their position in the base64 table. This reduces the maximum number
> > > of comparisons to 5, improving decoding efficiency while keeping the
> > > logic straightforward.
> > > 
> > > Benchmarks on x86_64 (Intel Core i7-10700 @ 2.90GHz, averaged
> > > over 1000 runs, tested with KUnit):
> > > 
> > > Decode:
> > >  - 64B input: avg ~1530ns -> ~126ns (~12x faster)
> > >  - 1KB input: avg ~27726ns -> ~2003ns (~14x faster)
> > > 
> > > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> > > Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
> > > ---
> > >  lib/base64.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/base64.c b/lib/base64.c
> > > index b736a7a43..9416bded2 100644
> > > --- a/lib/base64.c
> > > +++ b/lib/base64.c
> > > @@ -18,6 +18,21 @@
> > >  static const char base64_table[65] =
> > >  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
> > >  
> > > +static inline const char *find_chr(const char *base64_table, char ch)
> > > +{
> > > +	if ('A' <= ch && ch <= 'Z')
> > > +		return base64_table + ch - 'A';
> > > +	if ('a' <= ch && ch <= 'z')
> > > +		return base64_table + 26 + ch - 'a';
> > > +	if ('0' <= ch && ch <= '9')
> > > +		return base64_table + 26 * 2 + ch - '0';
> > > +	if (ch == base64_table[26 * 2 + 10])
> > > +		return base64_table + 26 * 2 + 10;
> > > +	if (ch == base64_table[26 * 2 + 10 + 1])
> > > +		return base64_table + 26 * 2 + 10 + 1;
> > > +	return NULL;
> > > +}
> > > +
> > >  /**
> > >   * base64_encode() - base64-encode some binary data
> > >   * @src: the binary data to encode
> > > @@ -78,7 +93,7 @@ int base64_decode(const char *src, int srclen, u8 *dst)
> > >  	u8 *bp = dst;
> > >  
> > >  	for (i = 0; i < srclen; i++) {
> > > -		const char *p = strchr(base64_table, src[i]);
> > > +		const char *p = find_chr(base64_table, src[i]);
> > >  
> > >  		if (src[i] == '=') {
> > >  			ac = (ac << 6);  
> > 
> > But this makes the contents of base64_table no longer be used, except
> > for entries 62 and 63.  So this patch doesn't make sense.  Either we
> > should actually use base64_table, or we should remove base64_table and
> > do the mapping entirely in code.
> >   
> For base64_decode(), you're right. After this patch it only uses the last
> two entries of base64_table. However, base64_encode() still makes use of
> the entire table.
> 
> I'm a bit unsure why it would be unacceptable if only one of the two
> functions relies on the full base64 table.

I think the point is that that first 62 entries are fixed, only the last two
change.
Passing the full table might make someone think they can an arbitrary table.
Clearly this isn't true.

Having the full table is convenient for the encoder (although the memory
lookups may be slower than other algorithms).
This might be ok if you could guarantee the compiler would use conditional moves:
	if (val > 26)
		val += 'a' - 'Z' - 1;
	if (val > 52)
		val += '0' - 'z' - 1;
	if (val > 62)
		val = val == 62 ? ch_62 : ch_63;
	else
		val += 'A';

This test code seems to do the decode.
The only conditional is in the path for 62 and 53 (and errors).

int main(int argc, char **argv)
{
        char *cp = argv[1];
        unsigned char ch;
        unsigned int bank, val;
        unsigned int ch_62 = '+', ch_63 = '/';

        if (!cp)
                return 1;
        while ((ch = *cp++)) {
                bank = (ch >> 5) * 4;
                val = ch & 0x1f;
		// Need to subtract 1 or 16, variants using 'conditional move'
		// are probably better - but not all cpu have sane ones.
                val -= ((0xf << 4) >> bank) + 1;
                if (val >= (((10u << 4 | 26u << 8 | 26u << 12) >> bank) & 0x1e)) {
                        if (ch == ch_62)
                                val = 62;
                        else if (ch == ch_63)
                                val = 63;
                        else
                                val = 255;
                } else {
                        val += ((52u << 8 | 0u << 16 | 26u << 24) >> (bank * 2)) & 63;
                }
                printf("%c => %u\n", ch, val);
        }
        return 0;
}

	David

> 
> Regards,
> Kuan-Wei
> 
> 


