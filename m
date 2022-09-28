Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1AEC04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IcCOVXLXxHvpPopGpnPv2T7v0pTrQ2ZxamJTkqROX/w=; b=RCNt0tMrh65XqcAGCQlO11L25I
	/EDgiSz/wQnJoeuiDIzePBucDTdiCJSh07uNmYmBDR+ZuGI0aFo5iIKCHe28aIDmpIZh4uvkYp88K
	Nqlkl9B3dxcTHyd4um5L0IEIlHL+2rkrBUDdX0Eq2OdpHYVmmHEl19amIbvIrS5UMjEfYyJMOJE0N
	o/BmpdCBOWeSLy8dQoZR2vsuRHQMGORUoVJG5rxFf4froSKV69xEYvYK/hbdPOp989MO8Ihhuyr0s
	YUl+AEtQ82USJesN52BZbxlnsGORTngguILlTqItL6YOETqZP5dz0VZEHt3H8QfGe6Kd9Hpmko3AE
	wiM08sIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXxD-00Geu6-IO; Wed, 28 Sep 2022 14:22:27 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXxA-00Gerf-CP
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:22:26 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 78so12323388pgb.13
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 07:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=IcCOVXLXxHvpPopGpnPv2T7v0pTrQ2ZxamJTkqROX/w=;
        b=OVthF5MHuPVJkukGFSTKTOGeIm/VAPIlqbGb4ZI3VhVbiXd7CCeipL3Z2NIOuzENzf
         3Ef8ix6aDPiparDKFbNeUNTcpieYLTvPQpeE3QH3omb33G4XaYOemLITYqSzwt2FDay1
         VtMQE+nBTFJO39jXgTr9dK4HiuT311Ln+8nPYNGeGv2qGLVokMKtfBThJTAwAdHvGLIp
         XO8ug3d320Dte0I7VJiQiyZLR0OVfS0bA6mfWe6aP7iuPR7U5ZnQITGO6zCkYgah59u4
         GZ2BVY7GZ5v022yqAbE+kvMqUC0THUSWJtRqY0vXjiY+Xjm6gYbxa8NbOt06guIMNVYZ
         Puxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IcCOVXLXxHvpPopGpnPv2T7v0pTrQ2ZxamJTkqROX/w=;
        b=Td0q85A+3Ct40w2PvsmukP1gHa+XM4LHcJwDFI8ux+bGW2DwlUer6Mlf7uhws6T7a1
         emT8YPkeXaNeMoxe9Kxz8nM0WaDmU9g65i+I4SsQdfJKCwtdaaJ0jncl2oMEy5HXYVOH
         HHunrPSJ1DVmlEBvRLTy/N0ongTxZfDkcS5mafM2F85YzggEMMLBORny/ul5QaBGnn5v
         TNuEbyfdIIhwXJ4Bu36z5kJetNWVYV0fNMrQzztY4/zLLP2rwNxgOnsXKy2YV+MWdyh1
         unfaWKf0DLjgxXYGn/f2tJDIm9ijhoatX/xqJszNfkopS0AjVIBR9XdmmIk4+Y1M1/HP
         8V3A==
X-Gm-Message-State: ACrzQf2fxPpg6MIcUjkzxlXJ9di2d+Avvd9P6J4kYGSB5MGPP5imj6RV
	AathmCTBxYqzc+H+1R4+dyaTCQ==
X-Google-Smtp-Source: AMsMyM7WUWGY9QTF0hxnqJ85z036FKxylq0a0QVbQjy5vAHIr/PaRgrZPyG6ppoteztUtzf1jxTEsw==
X-Received: by 2002:a65:42cc:0:b0:431:af8c:77e1 with SMTP id l12-20020a6542cc000000b00431af8c77e1mr29052177pgp.308.1664374941478;
        Wed, 28 Sep 2022 07:22:21 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9-20020a621d09000000b005484d133127sm4028417pfd.129.2022.09.28.07.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 07:22:21 -0700 (PDT)
Message-ID: <45fef5c6-8945-a140-a3ce-34bb4b287dc4@kernel.dk>
Date: Wed, 28 Sep 2022 08:22:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCHSET v2 0/5] Enable alloc caching and batched freeing for
 passthrough
Content-Language: en-US
To: Anuj gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20220927014420.71141-1-axboe@kernel.dk>
 <CACzX3AumYMDVPwvRYpMi6vvcPTzR0W0bUT1-545HvArpH+7Uwg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CACzX3AumYMDVPwvRYpMi6vvcPTzR0W0bUT1-545HvArpH+7Uwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_072224_457840_6C9E15E6 
X-CRM114-Status: GOOD (  14.89  )
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

On 9/28/22 7:23 AM, Anuj gupta wrote:
> On Tue, Sep 27, 2022 at 7:14 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Hi,
>>
>> The passthrough IO path currently doesn't do any request allocation
>> batching like we do for normal IO. Wire this up through the usual
>> blk_mq_alloc_request() allocation helper.
>>
>> Similarly, we don't currently supported batched completions for
>> passthrough IO. Allow the request->end_io() handler to return back
>> whether or not it retains ownership of the request. By default all
>> handlers are converted to returning RQ_END_IO_NONE, which retains
>> the existing behavior. But with that in place, we can tweak the
>> nvme uring_cmd end_io handler to pass back ownership, and hence enable
>> completion batching for passthrough requests as well.
>>
>> This is good for a 10% improvement for passthrough performance. For
>> a non-drive limited test case, passthrough IO is now more efficient
>> than the regular bdev O_DIRECT path.
>>
>> Changes since v1:
>> - Remove spurious semicolon
>> - Cleanup struct nvme_uring_cmd_pdu handling
>>
>> --
>> Jens Axboe
>>
>>
> I see an improvement of ~12% (2.34 to 2.63 MIOPS) with polling enabled and
> an improvement of ~4% (1.84 to 1.92 MIOPS) with polling disabled using the
> t/io_uring utility (in fio) in my setup with this patch series!

Thanks for your testing! I'll add your reviewed-by to the series.

-- 
Jens Axboe



