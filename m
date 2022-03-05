Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71220C433EF
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Mar 2022 23:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTFM0BLrFEzuVT+NEbfUfqIis6Wa5g9+pZvF27yAoQo=; b=uhNUFhxYn5YCVKPC58MI/GqGjX
	PM9UHgNwn0lBTsRm3kT0Z8GcbzRirs5Cm4uCJ9kdF35ix2tkZUir5HQyM2YCdIfTCZDQ3OBNTTtDI
	wtXVgFzXd0XVnqq6NaBLsg9Glt8Gga/Afuna+nVfyUcEDHTzSBacNExmxQ3QpOIfBzmo08cIP0RK6
	W0NgZvMoVsnm5pypi6ElQcpDNItKkVaMdFmaYfWaAieMc2f2GZc18vxtssWezArbNgCIhZiuBBvTu
	OxJj3DbWimXZHCrEdCNbOcaAIRhrSmjOoQ6acPS9wbErSL5knV27Ha1zXeYMMRfoRPFJJ6Ggont+g
	QdtrZxCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nQeFY-00Dz0g-NA; Sat, 05 Mar 2022 23:55:48 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nQeFV-00Dyzk-Df
 for linux-nvme@lists.infradead.org; Sat, 05 Mar 2022 23:55:46 +0000
Received: by mail-pg1-f171.google.com with SMTP id c1so10501786pgk.11
 for <linux-nvme@lists.infradead.org>; Sat, 05 Mar 2022 15:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=fTFM0BLrFEzuVT+NEbfUfqIis6Wa5g9+pZvF27yAoQo=;
 b=6/s4Bci6ssbjiSyolH4VWOSVlyDCbs5lrbiOqj7B87TxhhmCn+3COQTL0KddZlFwmU
 gpUKbCMNzU4XSrT4bwrr8hSAOeSAoO6mY4HUKpvdH/6IgCoiZmGN391GxJQHDCmprEVz
 OYiCmmo1fuCvGXsCXjKy51as97+ubVe4C962S3QAeJaffuHWBsfeGRDGCk7hhxIN9Sml
 codkCiia9LR/X4fIODCS2sp05Lt8ZbJ9PRfTcr1UtSCowxi7t1qEBWuQAoCWx6MV/U2I
 6RAC/iaADELKFa5o9ZkfBizeyL2cIQETxe2sgQj2elI4GhY9bLaSuZULqWqG+hW15DoH
 UZSg==
X-Gm-Message-State: AOAM530z8APPmWdwV8I94WRG/D68/tmeKhC2lJqiDHpumcFrvrlVVauq
 iSo2o396s9GINVLlyoGQc6E=
X-Google-Smtp-Source: ABdhPJz5VvA3U2fLc1z+mBiMQ4u+RZgL1KkG+Po1/Fl96HJUah2jzC5KKpI11NFwskc9qjJ1fhfUsQ==
X-Received: by 2002:a62:cdc3:0:b0:4e0:e439:ed2d with SMTP id
 o186-20020a62cdc3000000b004e0e439ed2dmr5770274pfg.39.1646524543626; 
 Sat, 05 Mar 2022 15:55:43 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a056a00218200b004f6519ce666sm10984217pfi.170.2022.03.05.15.55.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Mar 2022 15:55:43 -0800 (PST)
Message-ID: <535ff59f-cde0-caf4-6e47-a0f2db03261e@acm.org>
Date: Sat, 5 Mar 2022 15:55:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
 linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220304175556.407719-1-hch@lst.de>
 <20220304175556.407719-2-hch@lst.de>
 <20220304221255.GL3927073@dread.disaster.area>
 <20220305051929.GA24696@lst.de>
 <20220305214056.GO3927073@dread.disaster.area>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220305214056.GO3927073@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220305_155545_501129_DF1E8617 
X-CRM114-Status: GOOD (  15.69  )
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

On 3/5/22 13:40, Dave Chinner wrote:
> On Sat, Mar 05, 2022 at 06:19:29AM +0100, Christoph Hellwig wrote:
>> On Sat, Mar 05, 2022 at 09:12:55AM +1100, Dave Chinner wrote:
>>> AFAICT, this patch leaves just the f2fs allocator usage of
>>> inode->i_rw_hint to select a segment to allocate from as the
>>> remaining consumer of this entire plumbing and user API. Is that
>>> used by applications anywhere, or can that be removed and so the
>>> rest of the infrastructure get removed and the fcntl()s no-op'd or
>>> -EOPNOTSUPP?
>>
>> I was told it is used quite heavily in android.
> 
> So it's primarily used by out of tree code? And that after this
> patch, there's really no way to test that this API does anything
> useful at all?

Hi Dave,

Android kernel developers follow the "upstream first" policy for core kernel 
code (this means all kernel code other than kernel drivers that implement 
support for the phone SoC). As a result, the Android 13 F2FS implementation is 
very close to the upstream F2FS code. So the statement above about "out of tree 
code" is not correct.

Bart.

