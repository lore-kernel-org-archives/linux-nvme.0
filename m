Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A7C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:36:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588F2224B1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 04:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588F2224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HslPMTrDWmCorQdGFZsLyC62viRu3zFj7hip9LpVoEQ=; b=Yd2aP1jkJe2ogrh0UyWBd1KFJ
	N/z1F0DoyYr00JHAt29hE74GoczkZTUtgGH2fiSo+RLZN2A63It+f/tiUe+5BoFGkInRYgM8eQdSy
	gXoQ4nW+EVFXXKaMYf/mX4AnkFdRaMV0cyuSqyFiYBcp+nF8qDjUkv+0JVPR9C4ybLcvSAF7YmX+q
	lEsFXFCTXsZIiu8kBUgemZKZMrLKOa7PHgkz3MQjTywuPCerabb/X58SQlUdXaZ9Z+zImF8lSyaMv
	1zsdy1koyLxzujw7vdIQD8jgVGzDLHEuBAvPkPS30nV4/tEQ9pAq0ZW0D0cGHe/BzHiBaEPFNA6+T
	ct64XcvBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l3tc2-0002dk-Rx; Mon, 25 Jan 2021 04:36:26 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l3tc0-0002cq-36
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 04:36:25 +0000
Received: by mail-pg1-x534.google.com with SMTP id p18so8060983pgm.11
 for <linux-nvme@lists.infradead.org>; Sun, 24 Jan 2021 20:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FijkUVA4wtqEzKdrwPNqr5BszwjDE0ObYH72kW/p/Qc=;
 b=ba/PQSHzp1XMXEYfaF8IHUMMLul1kjomGVtf+iR7PS5f0N91qzg13X0RZJ97PPA0Vh
 2RdglhLdiBxokgZLrklGFKw5elkOv9IMkxXL0wir8HcRac0waGN3dSgDWP5u3/F7/Cgi
 zYenYmfFAphreQtQ6crnNkJJn2bJDNx+iWqrZ9M/3gKEPnNx6sQ/UjR6GyJB8zRxqnDY
 8AoCDP3zaCxdj45M0aZ0vmEL3zsal3fLpbCh9fg8FUjTPIm99GyHz5AH1S6u4wgID8kS
 qSTr2uI9gX38rFZ2+qHIncgSSpsuO7n+wVQHBnvHeHyyCbF6tB6X6fJpGBFJ/5ws39Hs
 f7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FijkUVA4wtqEzKdrwPNqr5BszwjDE0ObYH72kW/p/Qc=;
 b=FwCTYb9rN8W6qk4wHHke5rGfoAjgaV8HVTjbPOz761xPHWfpqP5JuD6RhjQ699rSTj
 1yPOQHfc1XU3TWDGEaCC0amlMiv0vXQ7EWAcW4i0Ti0GQCCkob8NzyxNr0Bwj49PVLGD
 CQb59DByo6M13JRTjhZH//xGagssXATh/oQEwqpF2w2KN1+czQfhLMhnuwl3bpLaZOPH
 CxArRLjmf/g8qhae5GQXYOA8R0psk6Bh0WEgkaHCU5VJ4dtGybZaHzer7I+TsMKdHrQT
 f3I5ju3TnmHUcY6K6fOMQ9zcIEfKmubjnxn6tGKadf4qYEsHx5kt6qvkiAArHJMyZsm0
 OUkQ==
X-Gm-Message-State: AOAM533pYIQt+AaHbU38R3zD6WdmoOMklrFMzmsnvZYcbJhytpepmdJ7
 IhG8MfwVPvge5UyM1QoaHNqzLQ==
X-Google-Smtp-Source: ABdhPJwqMLqKBZAD9FxC+3lNxtWNGWUkaLysCeumNlPXimZYcundbTEt00KrsFB9Hb+bWilXVtUrpA==
X-Received: by 2002:a63:d917:: with SMTP id r23mr1043183pgg.126.1611549378270; 
 Sun, 24 Jan 2021 20:36:18 -0800 (PST)
Received: from [10.8.2.15] ([185.125.207.232])
 by smtp.gmail.com with ESMTPSA id k64sm14947157pfd.75.2021.01.24.20.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Jan 2021 20:36:17 -0800 (PST)
Subject: Re: [PATCH V2 2/2] block: remove unnecessary argument from
 blk_execute_rq
To: Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
References: <20210122092824.20971-1-guoqing.jiang@cloud.ionos.com>
 <20210122092824.20971-3-guoqing.jiang@cloud.ionos.com>
 <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <439d415f-6aed-7092-a593-0d2d490652d2@cloud.ionos.com>
Date: Mon, 25 Jan 2021 05:35:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoPL4drfh3efKXyhXLp6Ce+j=oHwNd9VnVP4aaKQ0zmDQ@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210124_233624_165583_F8A3C111 
X-CRM114-Status: GOOD (  15.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block <linux-block@vger.kernel.org>, linux-nfs@vger.kernel.org,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, linux-ide@vger.kernel.org,
 target-devel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 1/22/21 10:50, Ulf Hansson wrote:
> On Fri, 22 Jan 2021 at 10:28, Guoqing Jiang
> <guoqing.jiang@cloud.ionos.com> wrote:
>>
>> We can remove 'q' from blk_execute_rq as well after the previous change
>> in blk_execute_rq_nowait.
>>
>> And more importantly it never really was needed to start with given
>> that we can trivial derive it from struct request.
>>
>> Cc: linux-scsi@vger.kernel.org
>> Cc: virtualization@lists.linux-foundation.org
>> Cc: linux-ide@vger.kernel.org
>> Cc: linux-mmc@vger.kernel.org
>> Cc: linux-nvme@lists.infradead.org
>> Cc: linux-nfs@vger.kernel.org
>> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> 
> [...]
> 
>>   drivers/mmc/core/block.c          | 10 +++++-----
> 
> [...]
> 
>  From mmc point of view, please add:
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> At the moment I don't think this will conflict with any changes to
> mmc, but if that happens let's sort it then...
> 

Thank you! Will resend and add your acked-by.

Guoqing

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
