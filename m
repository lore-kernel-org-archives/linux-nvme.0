Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A088C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:36:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BCE63219
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 14BCE63219
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6TRyWlIO4zHFM6tgCDl7yl5O1itcO3INiM0UIvIWRP4=; b=n9m4Q5W/MOo4WWSNU8rHxZQpSD
	DUArB5e5DRMa3HITe+vMUJ7T13XnQ3jfdWVlFTev/ZrCP9OWVSfUhjA6IbuWCfvLOHQyr2ogcTgvz
	EmBHHxWMTtc5Ty43d2MmEVEDsFELuy1WUijr6EXXKO1mSU9PRARN/MwgzVxiuX23rk3Puui2vfbsk
	BkmcVPa1CZ4est3uQaPxOa6cqEXlgug/gvIIthMuNxpxnuBbQHj7jgqKuwR2SWPBoCkBznka522mV
	/Z6328y5wzadEUu8E270gqPDqAcx6LfeiZgAZz0Hp94gLEhi6Ul3wVkLFjIvMD5fmIe19N1M0Do6h
	Id+LE5UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmvou-001Dye-B6; Tue, 16 Nov 2021 10:36:08 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmvoO-001Do2-UE
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 10:35:38 +0000
Received: by mail-wr1-f49.google.com with SMTP id a9so10384440wrr.8
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 02:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6TRyWlIO4zHFM6tgCDl7yl5O1itcO3INiM0UIvIWRP4=;
 b=MoZwOqPWQpNMmlgbRKkWav9vH/Ruf+/ogqcE1UJEjaour4gNaH3/x6PD8tiskc5sYF
 b5GGwvtTxEjokDdOJJg5vGWcyoN0jV+4O/5wh6P5wJT43muOvuBmeCXGUd4lJlWX8/3C
 9D9FaDEaOD9poZ0ijp6V1+94pBwodPV+BB0K57oOdZ46boPEK5FwGC3Vw3rPPBJEjPW0
 o9Uq3jgH2sDpUDTzs/FqOMzAZvihnOzFhKikeGXzdzyi0uHNKmJqMzkwQRget13If9DF
 e1B1U9ljZl6KS8i4kH9Ht5oN4XxwZQo2h52W/ucGzd0S6KCWxpHtW3SPSklU/3t21f/l
 4kCw==
X-Gm-Message-State: AOAM532zi/tVi1yNAmCzuorECpXGYQMnofWXqUJW8ZPY9xAJhNe0MbyN
 iZZe+3/evBlzGsn17WR8uOtUjOPi+Os=
X-Google-Smtp-Source: ABdhPJw/zgBsmOUoe87mnOZyQwdyZix9mDhDZJGnsPKZkSsT9t3tWZVZuMQLDopMDBCK0zOa7z0tZA==
X-Received: by 2002:a05:6000:1868:: with SMTP id
 d8mr7757927wri.285.1637058935653; 
 Tue, 16 Nov 2021 02:35:35 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id s24sm1928570wmj.26.2021.11.16.02.35.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 02:35:35 -0800 (PST)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <20211112125928.97318-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ce8ad3e5-6f18-0ffa-33b4-11e52b39e1b4@grimberg.me>
Date: Tue, 16 Nov 2021 12:35:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112125928.97318-8-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_023537_034038_2F8C5F2B 
X-CRM114-Status: GOOD (  15.44  )
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


> +static int nvme_auth_dhchap_host_response(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)

Maybe better to call it nvme_auth_dhchap_setup_host_response()?

> +{
> +	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
> +	u8 buf[4], *challenge = chap->c1;
> +	int ret;
> +
> +	dev_dbg(ctrl->device, "%s: qid %d host response seq %d transaction %d\n",
> +		__func__, chap->qid, chap->s1, chap->transaction);
> +
> +	if (!chap->host_response) {
> +		chap->host_response = nvme_auth_transform_key(ctrl->dhchap_key,
> +					ctrl->dhchap_key_len,
> +					ctrl->dhchap_key_hash,
> +					ctrl->opts->host->nqn);
> +		if (IS_ERR(chap->host_response)) {
> +			ret = PTR_ERR(chap->host_response);
> +			chap->host_response = NULL;
> +			return ret;
> +		}
> +	} else {
> +		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
> +			__func__, chap->qid);
> +	}
> +
> +	ret = crypto_shash_setkey(chap->shash_tfm,
> +			chap->host_response, ctrl->dhchap_key_len);
> +	if (ret) {
> +		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
> +			 chap->qid, ret);
> +		goto out;
> +	}
> +
> +	shash->tfm = chap->shash_tfm;
> +	ret = crypto_shash_init(shash);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, challenge, chap->hash_len);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le32(chap->s1, buf);
> +	ret = crypto_shash_update(shash, buf, 4);
> +	if (ret)
> +		goto out;
> +	put_unaligned_le16(chap->transaction, buf);
> +	ret = crypto_shash_update(shash, buf, 2);
> +	if (ret)
> +		goto out;
> +	memset(buf, 0, sizeof(buf));
> +	ret = crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, "HostHost", 8);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
> +				  strlen(ctrl->opts->host->nqn));
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, buf, 1);
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
> +			    strlen(ctrl->opts->subsysnqn));
> +	if (ret)
> +		goto out;
> +	ret = crypto_shash_final(shash, chap->response);
> +out:
> +	if (challenge != chap->c1)
> +		kfree(challenge);
> +	return ret;
> +}
> +
> +static int nvme_auth_dhchap_ctrl_response(struct nvme_ctrl *ctrl,
> +		struct nvme_dhchap_queue_context *chap)

Maybe better to call it nvme_auth_dhchap_validate_ctrl_response()?

