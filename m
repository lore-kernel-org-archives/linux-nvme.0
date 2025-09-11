Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B266CAC587
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+uQopAOmmaw/HQp8TjeR/zXDHZa9QvODN9R1HJQqSjY=; b=BLNq5WOpVp5qIRX6i8TnK1jzKd
	8r2NmjA/W2VMvYops1ngUj+9tuxKR9GNxLEdGYdzBMF4Fn8mPSvjjHhSw+R/2hF9zGaKdkf4S1Vjd
	ZRnMbfFMRAPBbwZzVepH9zpQWI63BvGIHmFwaTwpPYFvt8X7FLDpxpVCLpUiJ4SjA0XMKxuiERCxm
	+tFJY96HCptAuUcCRlyE5ZEpseg0ug9BFVhRIMqmLuTn8BasWuU8a4HPWrfslrCv2NzGTYm5BZ9wY
	Hwa64eq5WCMa6HdNOGHosefDGQOO+Lc7kXjjDYFicigpedWEjsmMHW/BwnZa57fA5obsl/G2rND2P
	uRgebunw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmNn-00000004q9T-33iR;
	Thu, 11 Sep 2025 18:50:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwmNl-00000004q8Q-2g1x
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 18:50:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2979C4076C;
	Thu, 11 Sep 2025 18:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6D3C4CEF0;
	Thu, 11 Sep 2025 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757616657;
	bh=xc1JrzNtcpZ5N5cyAo3Ece+acfMfTB+qXBHnynrrQKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iiYH8x+dKSCKyEYrPVn2ChA+yS+4noJxQHsH/BvYVuVhLOE0A/eKZyrdMQw/oCqwL
	 2tJyd4kbpeLaYpEkIM3dsi/VDXtrG4np/qMto+tqQdyzIRGumDHxB6rllbGuTspHOn
	 YirkTGgVQpRQ5PDJBS1KaRsg1pGG1TnayshhzREynV7T2KU0aUfSNkLv+3JzueIl0D
	 uSXUUGNdLDiX5BD4bqXym6/e+NBZVWwc3LxMfFShDLZGGvhlZlAWYQa+AC9huQz2Tq
	 zMXXPk/XOUyihgdFayforOU6xdmyJBVl+pwyx7zdyvV11ay9iHMIznLI5oswe/mpS5
	 96HY4TcwzOqyg==
Date: Thu, 11 Sep 2025 11:49:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Guan-Chun Wu <409411716@gms.tku.edu.tw>, akpm@linux-foundation.org,
	axboe@kernel.dk, ceph-devel@vger.kernel.org, hch@lst.de,
	home7438072@gmail.com, idryomov@gmail.com, jaegeuk@kernel.org,
	kbusch@kernel.org, linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, tytso@mit.edu, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <20250911184935.GE1376@sol>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
 <20250911181418.GB1376@sol>
 <aMMYmfVfmkm7Ei+6@visitorckw-System-Product-Name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMMYmfVfmkm7Ei+6@visitorckw-System-Product-Name>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_115057_718372_A7ACCC0C 
X-CRM114-Status: GOOD (  33.06  )
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

On Fri, Sep 12, 2025 at 02:44:41AM +0800, Kuan-Wei Chiu wrote:
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

Well, don't remove the table then.  But please don't calculate pointers
into it, only to take the offset from the beginning and never actually
dereference them.  You should just generate the offset directly.

- Eric

