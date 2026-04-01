Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BAD107639C
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 18:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6HBixlyChOtfxmYywNeMVEHXeZu1tipbVAxcoEMGRI=; b=1rS20O6yUqPg+9a9DXDvK1QPWF
	ZlKZ/TnWrSJm6Ysn8wqJuYSvm3G5tTQuPFJu8jf5Tzrf3nYodgxNNF1hv0xe8vX19+F9oyCCoMDET
	fU/XLu2OD3NCfSrYxMH1TzYOqXyBx/SORB60VIZqmNpkUwwLwWA3OR7ltzzgLPHFDUcUT6ypoGGwA
	ZlrAO9r8HGbw4MRO3n6yP8A9yM36qodgXEDlVmaAxt510KfKTK1R4/F/5v3Uw0pBSvXQABuiJge/c
	JyGhgkBpKNVLN53qs2fSMhWxPBj9Yxmr9cJupolncEqELA2TGtHus7ObAP4NNmUFWEaBHW402v1Xn
	6XK/ymiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8049-0000000FwU5-10Qf;
	Wed, 01 Apr 2026 18:13:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8045-0000000FwTW-3rKU
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 18:13:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775067193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d6HBixlyChOtfxmYywNeMVEHXeZu1tipbVAxcoEMGRI=;
	b=f7pJVHKgyTw01O/ryJY6SEZrD/9siNXutTEefI0rUTUo9hft7+cHlPiwsxWSJxsDqxLEDC
	2r7ty6erPnqHCnvUXl3hyV8akIPa7FoNEmRSdzpncgJ0q9/DeOvQkrWpb0192dbFViDvUD
	pLS4uTK6IgEoiHt32f+74LIi2yK5AZY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-C5ClZaiDN5aY9M-bjBLU6Q-1; Wed,
 01 Apr 2026 14:13:10 -0400
X-MC-Unique: C5ClZaiDN5aY9M-bjBLU6Q-1
X-Mimecast-MFC-AGG-ID: C5ClZaiDN5aY9M-bjBLU6Q_1775067189
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1C101944F01;
	Wed,  1 Apr 2026 18:13:08 +0000 (UTC)
Received: from cleech-thinkpadt14sgen2i.rmtusor.csb (unknown [10.2.17.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id F1FFA30001A2;
	Wed,  1 Apr 2026 18:13:06 +0000 (UTC)
Date: Wed, 1 Apr 2026 11:13:05 -0700
From: Chris Leech <cleech@redhat.com>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/8] nvme-keyring: add 'dhchap' key type
Message-ID: <20260401-a15bafde727aaad4bed7f497@redhat.com>
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-3-hare@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260317130103.107360-3-hare@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2zeJ-zDoKWllHApAZT4JvN8VhQOGNL9PoSf8yt-9MQY_1775067189
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_111318_052502_404ED4E8 
X-CRM114-Status: GOOD (  33.87  )
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

On Tue, Mar 17, 2026 at 02:00:57PM +0100, Hannes Reinecke wrote:
> Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
> Keys are stored with a 'user-type' compatible payload, such
> that one can use 'user_read()' to access the raw contents
> and the 'read()' callback to get the base64-encoded key
> data in the DH-HMAC-CHAP secret representation.
> 
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/common/keyring.c | 216 ++++++++++++++++++++++++++++++++++
>  1 file changed, 216 insertions(+)
> 
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 32d16c53133b..f7e18df438e6 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -4,6 +4,9 @@
>   */
...  
> +/**
> + * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
> + * @prep: preparsed payload of the key data
> + *
> + * Decode the DH-HMAC-CHAP key data passed in in @prep and
> + * store the resulting binary data. The binary data includes
> + * space for the CRC, the version, and the hmac identifier,
> + * but the data length is just the key data without the CRC.
> + * This allows the user to read the key data via the
> + * 'user_read()' function. The additional 'version' ahd 'hmac'
> + * data is used in the ->read() callback to generate the
> + * base64 encoded key.
> + */
> +static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
> +{
> +	struct user_key_payload *upayload;
> +	size_t datalen = prep->datalen, keylen;
> +	int ret;
> +	u32 crc;
> +	u8 version, hmac;
> +
> +	if (!prep->data) {
> +		pr_debug("%s: Empty data", __func__);
> +		prep->payload.data[0] = NULL;
> +		prep->quotalen = 0;
> +		return -EINVAL;
> +	}
> +
> +	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
> +		   &version, &hmac) != 2) {
> +		pr_debug("%s: invalid key data '%s'\n", __func__,
> +			 (char *)prep->data);
> +		prep->payload.data[0] = NULL;
> +		prep->quotalen = 0;
> +		return -EINVAL;
> +	}

version should be verified to be the expected value of 1 here
(or hardcoded to only accept 1 in the sscanf call like the repalced
code removed in the next patch)
 
> +	/* skip header and final ':' character */
> +	datalen -= 11;
> +
> +	/*
> +	 * payload is < key | version | hmac >
> +	 * base64 decode will always return less data
> +	 * than the encoded data, so allocating the size
> +	 * of the encoded data will be large enough.
> +	 */
> +	upayload = kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
> +	if (!upayload) {
> +		prep->payload.data[0] = NULL;
> +		prep->quotalen = 0;
> +		return -ENOMEM;
> +	}
> +
> +	/* decode the data */
> +	prep->quotalen = keylen;

Uninitialized keylen is being used here to set quotelen.

> +	prep->payload.data[0] = upayload;
> +	ret = base64_decode(prep->data + 10, datalen, upayload->data,
> +			    true, BASE64_STD);
> +	if (ret < 0) {
> +		pr_debug("%s: Failed to decode key %s\n",
> +			 __func__, (char *)prep->data + 10);
> +		return ret;
> +	}
> +	ret -= 4;
> +	crc = ~crc32(~0, upayload->data, ret);
> +	if (get_unaligned_le32(upayload->data + ret) != crc) {
> +		pr_debug("%s: CRC mismatch for key\n", __func__);
> +		/* CRC mismatch */
> +		return -EKEYREJECTED;
> +	}
> +	/* append version and hmac to the payload */
> +	upayload->data[ret + 4] = version;
> +	upayload->data[ret + 5] = hmac;
> +	upayload->datalen = ret;
> +	return 0;
> +}
> +
> +/**
> + * nvme_dhchap_decoded_key_size - Size of the base64-decoded key
> + * @size: size of the encoded key
> + *
> + * Returns the expected size of the key after base64 decoding.
> + */

Isn't this the expected size after encoding, and not decoding?
It's used before a call to base64_encode.

> +static inline int nvme_dhchap_decoded_key_size(int size)
> +{
> +	int keylen = -EINVAL;
> +
> +	switch (size) {
> +	case 32:
> +		keylen = 48;
> +		break;
> +	case 48:
> +		keylen = 72;
> +		break;
> +	case 64:
> +		keylen = 92;
> +		break;
> +	default:
> +		break;
> +	}
> +	return keylen;
> +}

Why don't these keylen numbers match BASE64_CHARS()?

> +/**
> + * nvme_dhchap_psk_read - read callback for dhchap key types
> + * @key: key to read from
> + * @buffer: buffer for the key contents
> + * @buflen: length of @buffer
> + *
> + * Formets the DH-HMAC-CHAP key in base64-encoded form as

spelling typo /Formets/Formats/

- Chris


