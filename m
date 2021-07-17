Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976ABC636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 14:21:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D61C611BE
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 14:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D61C611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XU0zgE8fo0MuxO95T+Gr6gVl234q9cdSG3pAMxk/mS0=; b=ObAzcr77mBNLiT
	gV4zGNufYDl0USATQWdvq8mZyxvLXpPgMAlTEMw/yGaa9OM+NdHezVTFPCW5NPY35APy8YJN4RwU8
	jeWcewMpPH7b8W68shyPHz30ucqRvs1T8AmNVrtPs9xJEZRB96EAPR8bo23FCzvlF1B935tPgSHMD
	cEd8tM2HoO+ovRo2erOF1dCsyso1ZzDMKo9K/BHYOaJzrFCcgbAn1chOHXZs7mj5Xunn7mtXJzT8p
	vaEd/DYBEf2xfQEv4e0M96XjQAAW7rtLaQhP01scuYyYZXv2SFHfeuxefGQy/Ab35zt9uq79zeQpG
	NDxs19OsciTi45JtrdHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4lBZ-006iUY-5O; Sat, 17 Jul 2021 14:20:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4lBW-006iUF-1Z
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 14:20:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27913613C4;
 Sat, 17 Jul 2021 14:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626531653;
 bh=wSCwVuuSnJ3NHowIjdatyUb2d30WxXzTltY3f8AipVM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rxuhin9VHzrkiynQVLE/oSC9N/P4q1XmBS+mIzFysTyr1Ytfcq2t1wqtjw7rtwWK1
 1LrEhEqRiWHgroZSStVvKHAc766HKyzUFjtvOSoje9CngpjYOx+olsKeVpS5DoOnYs
 gDOdwt2qgGOFcROCRdRi2tOlvy4yTJyRq44RcgYLJ8Gaee3BBUXJDqB4FkxoX+0ggy
 FyPL4oAeRMZvp7A3ReSNLLFRz5zW2i1rd2oxaHFsLpD7H2BELAQXUaF9yI6PHIjfgM
 F0rr9zfs5T4uqV1g/zuQ5YKEAJ1jqZPHhMUQFfxDW/zuA04cPOJKFdC9tVs58nWjay
 p9lIAmrMfJyYw==
Date: Sat, 17 Jul 2021 09:20:51 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 04/11] lib/base64: RFC4648-compliant base64 encoding
Message-ID: <YPLnQ1iyCQaEcnCq@quark.localdomain>
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-5-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210716110428.9727-5-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_072054_145466_22203FBF 
X-CRM114-Status: GOOD (  14.95  )
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

On Fri, Jul 16, 2021 at 01:04:21PM +0200, Hannes Reinecke wrote:
> +/**
> + * base64_decode() - base64-decode some bytes
> + * @src: the base64-encoded string to decode
> + * @len: number of bytes to decode
> + * @dst: (output) the decoded bytes.
> + *
> + * Decodes the base64-encoded bytes @src according to RFC 4648.
> + *
> + * Return: number of decoded bytes
> + */
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
> +                        if (src[i] == lookup_table[c]) {
> +                                p = c;
> +                                break;
> +                        }
> +                }
> +                if (p < 0)
> +                        break;
> +                ac = (ac << 6) | p;
> +                bits += 6;
> +                if (bits < 24)
> +                        continue;
> +                while (bits) {
> +                        bits -= 8;
> +                        dst[dst_len++] = (ac >> bits) & 0xff;
> +                }
> +                ac = 0;
> +        }
> +        dst_len -= pad;
> +        return dst_len;
> +}
> +EXPORT_SYMBOL_GPL(base64_decode);

This should return an error if the input isn't valid base64.

- Eric

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
