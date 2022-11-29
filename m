Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC0C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=15SxSNHfPSkRdUIJs7jjUNKUA+5AqJcIJ0LWkA4RN+g=; b=OlS3nuVzl54GR6DZW10tG/d3eS
	kdwCsynXE8DJMco7uxJGl6VuOT6Op9sk2x5Vnv06M0APr/gcvoQicM9BsYOFAUdTj8/LnWXzmE/AV
	Fukg7JqyHsdbArKxIv9QV0E/TrLp8U+/9iY5Ozvo4yGVAIPhaMRaL8SmoCJ1un/SQimGBGCKi5g/z
	Tc+lzBwAWUhLdJUG4Ez6PDz3U55xYjPil8Oy0nqYTceDgIvSZoRzLZ5VxX5EHNFt2uMceOwm5Oq8j
	p/U0FPp625mUA/UTe9pYI2t8eFOxJ3ULHVVeDZdHLFJ0NlS09qdvrQCdotS8a6GJh/P8oWCE1iljt
	9EXNnVsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01f2-009HOO-9m; Tue, 29 Nov 2022 14:32:36 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01ew-009HKZ-T9
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:32:34 +0000
Received: by mail-pg1-x52f.google.com with SMTP id s196so13179720pgs.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Nov 2022 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15SxSNHfPSkRdUIJs7jjUNKUA+5AqJcIJ0LWkA4RN+g=;
        b=zI4jM57lq4kblIKU5yxIn9FX6V+mwXkU/iIh8lZgHDF6o2hmGCnyHy3B3R5AW3zo03
         hjQvrFsaRvQtI0g5Labl5sM/kuJCeYftFLaKHZ6I410sDOAUCbpDzcUGQvNq2686lF/J
         Ki6eW4IHGBmRq46BEHvMtEc96woczA3ms6IoZI4gLcDgc8zOWq2tZ2H6Ub8ui80N6Z9U
         HkGB2dX37zZKFsY8kuLyvPFtup1HPZXs5/gaS0SeNMS7Lzs/ueuphSju95F4bqF1kNwh
         H09HRQFrmTKdaKWQtY0kPmMB6iHHdoG9GoMEowOdDBD5uXlEhcY/+qcD4OVPJsV2+7hB
         AD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15SxSNHfPSkRdUIJs7jjUNKUA+5AqJcIJ0LWkA4RN+g=;
        b=QDSJmi1kBzScJWSkvCckt/RcbQaPEdS/RtznSS2uMIp+Aon3/8s43/XhdKsgDV1GAd
         MpsaBYjX3L2np8NnE72JM1j9dMmVYl49adPH2MSnfYoZLd1IoL5n/FZMxrm1tLUlqiVd
         EovUvY8/Ife/3+A8nZuhytC9eah6Gb3gF5lSXlthCBiiKA3K2Ssk5XHEBikmmDnUWwSe
         kwh25N7+VUyCxD2blq+lGBbE1VzGEDIjfFtYsfxLdHFcEuL4wRd8x+BJgqSdGXw393aF
         coq3ZYYFL99R7z5z1d3aDSs67m9vNToHKK8lJ/mvo/prva0IJ9MrYhIJX7sFYiPmy/5z
         SpSw==
X-Gm-Message-State: ANoB5pnfMErmgknA5HPN2VpiXoJpJ26YlC34O/D7lB71ko9JQ3odhPAx
	QD653uFpKZPBUtvKIiYqMe9OOg==
X-Google-Smtp-Source: AA0mqf5g6DaXafJJOhWTZSsPpS8P+CKVmgSPtpkqBcyOyey/shhvMPSK01cTYg/DRIth7yaOl0+8XA==
X-Received: by 2002:a62:198d:0:b0:572:5a7f:9f4a with SMTP id 135-20020a62198d000000b005725a7f9f4amr37451404pfz.33.1669732347829;
        Tue, 29 Nov 2022 06:32:27 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090abd0100b0021885b05660sm1447319pjr.24.2022.11.29.06.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:32:27 -0800 (PST)
Message-ID: <d07eee61-eb3f-de75-4cc2-d9c554640a2b@kernel.dk>
Date: Tue, 29 Nov 2022 07:32:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] nvme: introduce nvme_start_request
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-2-sagi@grimberg.me>
 <Y4YXDAZDZQbnLIbF@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4YXDAZDZQbnLIbF@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_063230_957140_F10296DD 
X-CRM114-Status: GOOD (  10.44  )
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

On 11/29/22 7:28 AM, Keith Busch wrote:
> On Mon, Oct 03, 2022 at 12:43:43PM +0300, Sagi Grimberg wrote:
>>  
>> +void nvme_start_request(struct request *rq)
>> +{
>> +	blk_mq_start_request(rq);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_start_request);
> 
> Looks good, other than I feel this should be a static inline function in
> nvme.h instead.

Hah, mid-air collision. But at least we agree :-)

-- 
Jens Axboe



