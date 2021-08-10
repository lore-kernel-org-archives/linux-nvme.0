Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35591C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 19:14:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3ACB6101E
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 19:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3ACB6101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LOh7iGBu4vj6JIzi7xBx+v++ttMXJIYnH5dAAK/fo+I=; b=wmYmkQSLLqkz38
	Y5AED25JDRAkU4Pag3MugswvpZTieJlvXRHuUnjJ2vN4D897LTiODZYUfpukB+1qATx5lv+Y0LOkV
	5QWjagvfvuKjmKmlAqLyHRqn06DYXA2/8wsY1z3mOtS4/M8tv1stZ3sEj96msL1JVl+ioI5wKXOk9
	pQOZ9BeLbjDNtRX5J8Kpi5gcEF/QErP74cMz51cHFmjgcGREQVoKuoIXf5T4VvgSChJJVM7XiLle2
	InUXcRnOMNJYUfnpO7q/Bzj+c0U1n0csWTKH8//1KTaPsXIbVDakBkt28g3orUlk95dJQLWM1Atw9
	uGmhXcl+xSIVxo/YXAXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDXC6-004mwp-4n; Tue, 10 Aug 2021 19:13:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDXC2-004mw9-Qf
 for linux-nvme@lists.infradead.org; Tue, 10 Aug 2021 19:13:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE7F261019;
 Tue, 10 Aug 2021 19:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628622822;
 bh=3rE5qc+iJNNSvC4ekgPf62m2QsbfzCpL6SJxL+syab8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZQC0NEk0Him79x8hhE3+Sr+z7EPYmUxL8PTeYH/CjZGvf4FrabhG8oPj/dhV15wp9
 bM0E6Zb3ZtrKA/55nDzFReeOSLZs2MDcZ5Jx6FlungZ+C+lrN9hH7gY9VyNACyRvS+
 jU/O6+Wzzt8CtrpVTelrqQvpOLxSLPaKxbPMGZp3q0xK72zRV+qU8YkdRUpkWHoF+G
 uHv8MCo6c3pHEq90IVKsjmQcSvf4Ctu3fECrFTuNySU3qLZSvlgGv3Lx2tqqUtYtH/
 gyHADC9n6cHisQamSGltETg5lyyE9Ap1yi8YmBiGU5swo57pTX4Cc8RJn0N0JNCqPO
 0TB1Iqe4arR8A==
Date: Tue, 10 Aug 2021 12:13:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 04/13] lib/base64: RFC4648-compliant base64 encoding
Message-ID: <YRLP5JuQrF/SJPBt@gmail.com>
References: <20210810124230.12161-1-hare@suse.de>
 <20210810124230.12161-5-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210810124230.12161-5-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_121342_931662_F9ACEEEC 
X-CRM114-Status: GOOD (  24.65  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 10, 2021 at 02:42:21PM +0200, Hannes Reinecke wrote:
> Add RFC4648-compliant base64 encoding and decoding routines.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  include/linux/base64.h |  16 ++++++
>  lib/Makefile           |   2 +-
>  lib/base64.c           | 115 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 132 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/base64.h
>  create mode 100644 lib/base64.c
> 
> diff --git a/include/linux/base64.h b/include/linux/base64.h
> new file mode 100644
> index 000000000000..660d4cb1ef31
> --- /dev/null
> +++ b/include/linux/base64.h
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * base64 encoding, lifted from fs/crypto/fname.c.
> + */

As I mentioned previously, please make it very clear which variant of Base64 it
is (including whether padding is included and required or not), and update all
the comments accordingly.  I've done so in fs/crypto/fname.c with
https://lkml.kernel.org/r/20210718000125.59701-1-ebiggers@kernel.org.  It would
probably be best to start over with a copy of that and modify it accordingly to
implement the desired variant of Base64.

> +/**
> + * base64_decode() - base64-decode some bytes
> + * @src: the base64-encoded string to decode
> + * @len: number of bytes to decode
> + * @dst: (output) the decoded bytes.

"@len: number of bytes to decode" is ambiguous as it could refer to either @src
or @dst.  I've fixed this in the fs/crypto/fname.c version.

> + *
> + * Decodes the base64-encoded bytes @src according to RFC 4648.
> + *
> + * Return: number of decoded bytes
> + */

Shouldn't this return an error if the string is invalid?  Again, see the latest
fs/crypto/fname.c version.

> +int base64_decode(const char *src, int len, u8 *dst)
> +{
> +        int i, bits = 0, pad = 0;
> +        u32 ac = 0;
> +        size_t dst_len = 0;
> +
> +        for (i = 0; i < len; i++) {
> +                int c, p = -1;
> +
> +                if (src[i] == '=') {
> +                        pad++;
> +                        if (i + 1 < len && src[i + 1] == '=')
> +                                pad++;
> +                        break;
> +                }
> +                for (c = 0; c < strlen(lookup_table); c++) {

strlen() shouldn't be used in a loop condition like this.

- Eric

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
