Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA5C54EE9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1DwDVcE9Q7fJnvzqJ95nLyaymD/H1xmCXUcLA5QnNqs=; b=KqnK1XTgCGviJyfbg4YI7FgDeW
	eGGChhAy7SVIgqoWhNVu5zbNRV/vy4gtDx4cO52egU+WG1OvRhGWJND1jA3FskOlcLePxdZrcjn5r
	JSTw8YJ/RUUrLxUz+r/XHhXOH0Z6SZEI6OJyM5lc8hcDnLGTdFfDyP5xfeWSXsA8AOvui2E8KYgJ4
	PET04b4N2a7Z0NhTGYxgRSEDcP7ggB4dQDyBZWfBkpfSb+iyLnkr/ndcCTXzv/tPSOlohMWnMezYF
	VOPPi2cILH/e/OKUNza592txHq+ZMs5TUYTO1D3BGCJBq5UDd57lBH6GZq8Ds6+VQjBQM7qNvmPt+
	iqqkDUPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaHTu-00C1VH-0a; Mon, 19 Sep 2022 14:10:42 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaHTq-00C1Tn-43
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 14:10:40 +0000
Received: by mail-io1-xd31.google.com with SMTP id d8so19892959iof.11
        for <linux-nvme@lists.infradead.org>; Mon, 19 Sep 2022 07:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1DwDVcE9Q7fJnvzqJ95nLyaymD/H1xmCXUcLA5QnNqs=;
        b=I+5dK2Lropv+/49qWmABlU7JVzFW8/PAdOTt47JCfdzdFjvoS9e622gDzpNbCoVVGc
         O7WjybSmFafhUCZSKk4rdvmzPXrUO6+zh//MP8KR2uMuoFNIOrwtFz7Kyb2GhjW/3Zlz
         KhkVo6HG7R8qCC6Ak4INMXwT/6EItuJEudDTa2PdosbuZCrINM0JhQiC8/g3GJ47XVvq
         N5RGiuodznlnngCxgFBv28RTgAxIpNkqBHS4J0FwH4I+fvtFfsVD8EgRgWCLFZPLSJ5T
         CWq9YrX1M9LQOU63nuNvuSaNGfBj0foZbggX2x9UmG2iWIP+bS8zkJen4psYfYdYwfZx
         p+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1DwDVcE9Q7fJnvzqJ95nLyaymD/H1xmCXUcLA5QnNqs=;
        b=pwcxi7GLT4piJR0TlRYdkFTIBf/CU5hDMe8bw+IViydbJ02IwEm0rDWG8XF9oHrS9D
         4+8qlsRSrsXcKrdbhG9rjwUcGrkq/T4P/z0KhPG9TaUCnJ/CSt6cKApM5eavFHc5RF2o
         WbIq4nC2VUe+wb17WVsN7yEIQU2rK3JAj5d0ra9VG58F1f0M7ZoTni5hAob67WnvQ9/I
         kNEh9WsJyH0Gt/7RCgweJOiBOMu6Ix4LJUPvvleRVPlRR+VtN2VC1raK7jnliIp/B0Cd
         DtkduWxLthpUH72mnROoBNdymtI27VErtENFAAXdcNJ0S9Lh6LZgI5DPi8gddWBLxkbb
         BoFg==
X-Gm-Message-State: ACrzQf2g/dPDkMe5foDy3bWkodI/RGHvSCZX3zRfFVX9kaA9XRgVNLjy
	nkYugkGxqFgzdF01AjiZqtkkGg==
X-Google-Smtp-Source: AMsMyM6Bs1+NdJwv1qGYlqvXnmtuML1sRA+RH/tv6xUV+aEZ7TB09Uow7JAEBvBny0KXIyZQ9ldYcg==
X-Received: by 2002:a6b:5c10:0:b0:6a0:fbbd:3241 with SMTP id z16-20020a6b5c10000000b006a0fbbd3241mr7092750ioh.166.1663596635564;
        Mon, 19 Sep 2022 07:10:35 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z8-20020a027a48000000b00358437173c3sm5470510jad.53.2022.09.19.07.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 07:10:34 -0700 (PDT)
Message-ID: <894e18a4-4504-df48-6429-a04c222ca064@kernel.dk>
Date: Mon, 19 Sep 2022 08:10:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] nvme: request remote is usually not involved for nvme
 devices
To: Liu Song <liusong@linux.alibaba.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1663432858-99743-1-git-send-email-liusong@linux.alibaba.com>
 <d8e43495-0959-2b47-b0af-be46d7ad57ea@kernel.dk>
 <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7b28925a-cbee-620f-fde7-d16f256836cc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_071038_429499_F4D31B62 
X-CRM114-Status: GOOD (  23.70  )
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

On 9/18/22 10:10 AM, Liu Song wrote:
> 
> On 2022/9/18 00:50, Jens Axboe wrote:
>> On 9/17/22 10:40 AM, Liu Song wrote:
>>> From: Liu Song <liusong@linux.alibaba.com>
>>>
>>> NVMe devices usually have a 1:1 mapping between "ctx" and "hctx",
>>> so when "nr_ctx" is equal to 1, there is no possibility of remote
>>> request, so the corresponding process can be simplified.
>> If the worry is the call overhead of blk_mq_complete_request_remote(),
>> why don't we just make that available as an inline instead? That seems
>> vastly superior to providing a random shortcut in a driver to avoid
>> calling it.
> 
> Hi
> 
> This is what I think about it. If it is an SSD with only one hw queue,
> remote requests will appear occasionally. As a real multi-queue
> device, nvme usually does not have remote requests, so we don't need
> to care about it. So even if "blk_mq_complete_request_remote" is
> called, there is a high probability that it will return false, and the
> cost of changing the call to "blk_mq_complete_request_remote" to
> determine whether "req->mq_hctx->nr_ctx" is 1 is not only a function
> call, but more judgments in "blk_mq_complete_request_remote". If
> "blk_mq_complete_request_remote" is decorated as inline, it also
> depends on the compiler, there is uncertainty.

I'm not disagreeing with any of that, my point is just that you're
hacking around this in the nvme driver. This is problematic whenever
core changes happen, because now we have to touch individual drivers.
While the expectation is that there are no remote IPI completions for
NVMe, queue starved devices do exist and those do see remote
completions.

This optimization belongs in the blk-mq core, not in nvme. I do think it
makes sense, you just need to solve it in blk-mq rather than in the nvme
driver.

-- 
Jens Axboe

