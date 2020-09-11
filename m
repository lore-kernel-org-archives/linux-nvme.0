Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F9AC433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 11:27:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E8C221EB
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 11:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lb86tBWO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JUUawHsi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E8C221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wHzH/GXXCcaleDMHmOFKX12egcucL70AdfVBgqgzn10=; b=lb86tBWOOXgQn7gnUKXWNIrc0
	viGMbP6AKaWQoPoMkvN3LjJf+9C2F5k0QY4LNJROJ1YMBJK7K5EiRVO0rMuSzWFXAW31DApb5MFD6
	9UQHoHkoSVy4JF7VxZGMy7DvbvpeAgYdm20p96Mh+fQArWltCyQO3K7qUo4ll79JQuxscD/yBvsU7
	z3rnW57KZsK27FbYGoT+B2FlOZeiHkECgiNUVKjtTq3Xg3mVdtbMEtdBPTV3pPdPWy4vvOlENoTWV
	UHL74EmbKAM3qhaETx97PAYcA0N9UtB1y9Pv5YdMsbMMzD/uJoOSWpT6tlNi/0s/rMDQMerh7mkdq
	ZarmzBKlg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGhDN-0003fD-3R; Fri, 11 Sep 2020 11:27:37 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGhDK-0003c3-Co
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 11:27:35 +0000
Received: by mail-pf1-x42c.google.com with SMTP id w7so7112335pfi.4
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nopPWRCL9i3gw7xBkMwWS/BG6rL2ZcEddtOrNa8g5oc=;
 b=JUUawHsiuQ1bhCa6s3UcN+Zk4MyQWzoHtJmkL8ETjz9kRCwWpcDwZdKyW53o6at0Ci
 Ctc4+Qy5j6RFmGJa33LOfjcWCvCb2UD9GY62CdXbcTDWI72T8g5SxI1yNyDOYt97j7Cj
 IgAikl7VtoCXotfb4tt79OarlHLSCCpCSVxhuGbDXpdCRtl4i657qqLeE4HZGCg0ud/m
 /dxV8VoVk/qic9zjAWeDDsIHo3wLbh8sbbxHeO6yhLa87Y/QDGL0NZEoc3740SfmeZ4W
 t+luW87Unjl96hY+FEU9hWtX3M35PGR/wHs3xQezxHAgIdL0Bhh7z4fK7RpwUE+iF1Uw
 YKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nopPWRCL9i3gw7xBkMwWS/BG6rL2ZcEddtOrNa8g5oc=;
 b=sRNcbQp3RV9VC2WP3uoULjhJb8ZUua4Ayg+hcazlX+5yy68E8kgX+K/YfPxyG91LPL
 cnSIxI4Rg4kKaLvKhtG+L9BuJQ4ES6mCxtX19WcNAfLJO4WB62DQB/3leiNsFgtCOYRu
 KdQ86YR2XILaZHLkJDecWzKxGBXd+ugbCT8o46NY6YSjofFJKYwVrwDYDTOaHafErwvO
 MiaoYafnH7laHsw/Tdp3KUkSwuNZsT56iw7jWa+uG30P4xGSSua7wlfN0iwOytt/WOct
 uZIVm9CMde6fqXCEUQXL5wmxKqG+1ZzAaGrDk32ITKzYvBByZiUxxDZI4p4JrzjCqpXQ
 ERGw==
X-Gm-Message-State: AOAM533LqwD2SyS6I1vKowiL4dUTCKMofeAz/AAEaPYXaWxk6HK+QDSV
 7LAgq8UnRnMsY9/u0sFjJbp27g==
X-Google-Smtp-Source: ABdhPJxDzAK04tI9vIIoxKk+Mde2cJFNzvPXiNHGN6t6uAtKklOutcnCavByjnWJtzKNRRJouO/Y0w==
X-Received: by 2002:aa7:948d:0:b029:13e:cb8d:60e0 with SMTP id
 z13-20020aa7948d0000b029013ecb8d60e0mr1830375pfk.9.1599823650349; 
 Fri, 11 Sep 2020 04:27:30 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
 by smtp.gmail.com with ESMTPSA id i9sm2127839pfq.53.2020.09.11.04.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 04:27:29 -0700 (PDT)
Subject: Re: [PATCH V2] blk-mq: always allow reserved allocation in
 hctx_may_queue
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
References: <20200911104114.163691-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <49ca5561-2c61-cd7d-d07e-868d0b31f359@kernel.dk>
Date: Fri, 11 Sep 2020 05:27:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911104114.163691-1-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_072734_592543_09419600 
X-CRM114-Status: GOOD (  16.20  )
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
Cc: David Milburn <dmilburn@redhat.com>, Hannes Reinecke <hare@suse.de>,
 "Ewan D . Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/11/20 4:41 AM, Ming Lei wrote:
> NVMe shares tagset between fabric queue and admin queue or between
> connect_q and NS queue, so hctx_may_queue() can be called to allocate
> request for these queues.
> 
> Tags can be reserved in these tagset. Before error recovery, there is
> often lots of in-flight requests which can't be completed, and new
> reserved request may be needed in error recovery path. However,
> hctx_may_queue() can always return false because there is too many
> in-flight requests which can't be completed during error handling.
> Finally, everything can't move on.
> 
> Fix this issue by always allowing reserved tag allocation in
> hctx_may_queue(). This ways is reasonable because reserved tag
> suppose to be ready any time.

Applied, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
