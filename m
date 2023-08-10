Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732A6C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FhhSAWngiQm8CFUxUdaB95104btIjyFwdIStKZowfd0=; b=Sj1CNZhHkBWi0sAZpAvMt84JYN
	yP0ncSx68PxXozVP/9aeATfsw63dqyAW2DshwPkrmgHQGJa4CEjg8HCAH/hT2UyvqqzI2aCrLpkzo
	kNkK+e+Xf4YFD3oEFz9pRUdgRlUhcXeFgrNg1d3+GRgNqyyVWJqQFld79PHSpaOaPzpyVHDZ2N/MF
	7dfWRt2qqAikrzAFSGsZJk+Y5+mqyEA2bPRXMmQ1GhfOpESniEOcb08guhk/6/7K15xaAw3UtLxsr
	rc+rzth2iv+pTYIkTG2pJhfczep1mTojsNxJ56MUboCFqWhYsUaVc1B0C7T6mqRrlzhKKlcxjswJc
	SNX3SXXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU1e3-006w3L-03;
	Thu, 10 Aug 2023 09:07:51 +0000
Received: from mail-lf1-f41.google.com ([209.85.167.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU1e0-006w2W-1a
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 09:07:49 +0000
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4fe1e7440f1so179549e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 02:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658461; x=1692263261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhhSAWngiQm8CFUxUdaB95104btIjyFwdIStKZowfd0=;
        b=b1RfzRl8T14rAPxo5bPY9WsBwkWdpYt6ORTwafqSnbEhHquNdUdEZ4Vmh7Np0UhyeY
         yeB6hMwAtth0/gLuU/5EtK/e2KbiVjCOix0X50SBLnpdG60HWYMvAZ0pwZ6B+jzIlXK2
         umrJeuczpFlPjazAESSs2ljHNaKIzaYrvmMJNMq+ny4vneYJdIkHkF+EvhfjYMcpnh2k
         lg33KZTR6bebsy4vYgBAkwTMv269zDmaVN2SNyRAHF3ELIL32njwT5EGc8ZLlLaCv2lw
         1gxJ+rg5aZIHzq6YRMij5gVN4gJB48PaNNEuAxtm9pUMYO9J7TtOR5ArOOVYCZYD25M9
         sjBg==
X-Gm-Message-State: AOJu0Yyr5W+fR/w8l0VLrvZucgLKN+D0EHVIhxWiLDvU2ikyfz77VC6f
	Khrx81bweaG562pafrkU+9c7d86LcJA=
X-Google-Smtp-Source: AGHT+IFVEvBiFlf+4LBVYHN5iI1epdJ2MIjErdwOB2dMbBYlJlpMOjtRsXygttXX2M4cGVQrsShBeA==
X-Received: by 2002:a19:f812:0:b0:4fb:7381:952e with SMTP id a18-20020a19f812000000b004fb7381952emr1148968lff.2.1691658460380;
        Thu, 10 Aug 2023 02:07:40 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c2-20020ac24142000000b004fdde1db756sm205383lfi.26.2023.08.10.02.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 02:07:39 -0700 (PDT)
Message-ID: <2a8abad4-8c6c-2353-d056-ea6f04cc0f12@grimberg.me>
Date: Thu, 10 Aug 2023 12:07:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple
 H2CData PDUs
Content-Language: en-US
To: Varun Prakash <varun@chelsio.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Rakshana S <rakshanas@chelsio.com>
References: <20230803105839.6139-1-varun@chelsio.com>
 <eb0ec990-50f2-128b-93ea-5a997e36bdee@grimberg.me>
 <BN9PR12MB5324E8DC829612DD1463116BBC0CA@BN9PR12MB5324.namprd12.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BN9PR12MB5324E8DC829612DD1463116BBC0CA@BN9PR12MB5324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_020748_546949_909AC674 
X-CRM114-Status: GOOD (  13.37  )
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



On 8/7/23 18:13, Varun Prakash wrote:
> 
>>> +{
>>> +	struct scatterlist *sg = &cmd->req.sg[cmd->sg_idx];
>>> +	struct bio_vec *iov = cmd->iov;
>>> +	u32 data_length = cmd->pdu_len;
>>> +
>>> +	crypto_ahash_init(hash);
>>> +
>>> +	if (iov->bv_offset) {
>>> +		struct scatterlist first_sg;
>>> +
>>> +		sg_init_table(&first_sg, 1);
>>> +		sg_set_page(&first_sg, sg_page(sg), iov->bv_len,
>>> +				iov->bv_offset);
>>> +
>>> +		data_length -= iov->bv_len;
>>> +
>>> +		if (data_length) {
>>> +			ahash_request_set_crypt(hash, &first_sg, NULL,
>>> +						iov->bv_len);
>>> +			crypto_ahash_update(hash);
>>> +			sg = sg_next(sg);
>>> +		} else {
>>> +			ahash_request_set_crypt(hash, &first_sg,
>>> +					(void *)&cmd->exp_ddgst, iov->bv_len);
>>> +			crypto_ahash_finup(hash);
>>> +			return;
>>> +		}
>>
>> What is the case for data_length=0 ? I'm not entirely clear how this can
>> happen.
> 
> This can happen if H2CData PDU data length is not a multiple of target page size.
> 
> For example if transfer length is 32K, page size is 4K and H2CData PDU data length is 6K,
> host will send 6 H2CData PDUs, for the last PDU iov->bv_offset = 2K,
> iov->bv_len = 2K and data_length = 2K.

I understand.

Looking into this, I'm almost thinking we should just give up and
iterate. at this point it unnecessarily complicates the code...

