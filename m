Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77248CAC58E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=06QEBt7vQMuCRYFVKDqYDii0jEZZNEOypNRSRw/R+dM=; b=Un9fHnVMcabJJD04VC6DM/1dxk
	zN80V60UynpFpN9IAJgG4mYAJkg7j8NzbLBlvDX6eoWn0TlideVWa/h3dlEQfvWZnH6mg8b0jqgcQ
	2QHIy7/7oyNvVD91m/yqV4QahmUrk6kvvlg6XOZ/VBSt2M3t/BqJNhYqLd/eU3GTDZ1eGA+6KLcxN
	0jTMHGrRNwM8HDcWqRWrwxZSfB2ptaxC0sREQjlEsf9i7fZOwk/ML/HK7FmiNgbhf2Ql/8XUJdRsK
	dSncFvvaO5W63Sd3x1C0focCG8q1zYerLD2UoAgcIjHqlLJvHoU1I2VKpLmRKTHwDebsNlNgQ2bed
	5VJDmGRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwlpg-00000004g2j-27yt;
	Thu, 11 Sep 2025 18:15:44 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwlpc-00000004fzb-43KY
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 18:15:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2EF6D404B8;
	Thu, 11 Sep 2025 18:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC65C4CEF0;
	Thu, 11 Sep 2025 18:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757614540;
	bh=a2Lob0n3/+GCVE61Fr7ySrkcY2m5OqzFFOAuvId4MiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YHF/RmRFumOOHkEnaB3xMYiqo0WcAPOUsR5NQ2XhQl2SJLAVBfc3/wjdHBHX8Wmbe
	 KQVdxrNGKmWY3qjbhOJzzbYoQ2Q5sjebQoSSnx7vv4VBXx0lAc1fDEKsY760hrlSnB
	 cw0Cc6hS1Ykvt7RXoXZHMCn8MkIP3zzIZQxrLMkYrj7Yqnd5FYs9DRrBQBYLsM9/i5
	 Ttq9vEAAXQhJPUxn4tJq3w2kSNphEY2nNwbwJlSRhVN8rrpjajtaojIRtId1AT7kxM
	 nrIuRYtF5Z6Y8vUInleEY8memGNegfHCnpeDFpjJm5uAL8eDpW7AqF7lVG6duhuZ0j
	 ioWusQwGr+YtA==
Date: Thu, 11 Sep 2025 11:14:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, ceph-devel@vger.kernel.org,
	hch@lst.de, home7438072@gmail.com, idryomov@gmail.com,
	jaegeuk@kernel.org, kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, tytso@mit.edu,
	visitorckw@gmail.com, xiubli@redhat.com
Subject: Re: [PATCH v2 1/5] lib/base64: Replace strchr() for better
 performance
Message-ID: <20250911181418.GB1376@sol>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
 <20250911073204.574742-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911073204.574742-1-409411716@gms.tku.edu.tw>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_111541_060011_C617AF9D 
X-CRM114-Status: GOOD (  21.84  )
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

On Thu, Sep 11, 2025 at 03:32:04PM +0800, Guan-Chun Wu wrote:
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

But this makes the contents of base64_table no longer be used, except
for entries 62 and 63.  So this patch doesn't make sense.  Either we
should actually use base64_table, or we should remove base64_table and
do the mapping entirely in code.

- Eric

