Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFC4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Feb 2022 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F+qp5DTST113uFa2qEVLJWk99qBqQPXyZ2z+KHeY2Zk=; b=MSA+UIHWCN2ZUM6pwSRWDidnug
	QuiplxtaKUYJaEBJ5kESIkntMoeQ8kOemtCLWroffabGTfgmnY6D2aeUu3+ijtWi6HYOQ/7rovW6n
	ihj6OXGGa0yEzH9NWNYzm6mb4BWdbKKFCjsGpw/3GmGkjVi1Sw1ptQx7C5qgmKYQkaNjyUXrO2Pzi
	ocZ7kwMMuBAzlzLbTA+EjbZ5drMTWtEiFpJ8Ql77c+L58ieZ1NfzY0wn4k9OBWaQ6RgX8xbNLcWoI
	Zy06kNQIEfyy/t3FwOdtInMpiDrSxAo4mZ3cFH+sQ3qC4jhf/XhLJgAlJ/saHPRUoJ8wzWTUI22v9
	vL+MPDGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJzb0-003Da1-Ls; Tue, 15 Feb 2022 15:18:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJzay-003DZh-AE
 for linux-nvme@lists.infradead.org; Tue, 15 Feb 2022 15:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644938303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+qp5DTST113uFa2qEVLJWk99qBqQPXyZ2z+KHeY2Zk=;
 b=asQXZMCuAqq1GkwZtR8n/Be6lt27U5ZGT+tMqf3Ul1Ro3Qoz5Lsu+dFCjmftJSK40rlouP
 aVG3DB0hzDFOVAAay7V3XlRBPVLSPTdN1yNhZsqdv6EKtpQf8kIJUUGXr2oo+gvm2W/CqO
 UAx7hIfmbJMit6cMHSrw580uzX1Zir4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-622-P46SpbDbPQaOz8c3bfM03w-1; Tue, 15 Feb 2022 10:18:20 -0500
X-MC-Unique: P46SpbDbPQaOz8c3bfM03w-1
Received: by mail-oo1-f71.google.com with SMTP id
 h13-20020a4aa74d000000b002e99030d358so12793329oom.6
 for <linux-nvme@lists.infradead.org>; Tue, 15 Feb 2022 07:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:references:in-reply-to
 :content-transfer-encoding;
 bh=F+qp5DTST113uFa2qEVLJWk99qBqQPXyZ2z+KHeY2Zk=;
 b=0/ylFLLt2I4BxSbfB+6W155sBZlzu2f45Me19vDp34ugzq93eTxPoy3YD44629dHqb
 qhpp+GcPfrV2wxF51GCDPmIRkajkPXrnsAzZNeqmpwM+6ywMuHrda4WjT0siunUbwlbl
 zZAPenqaAWohTOahVzGgKye/GYdg4KGc12A6yBo0j5Phjbi0WL6yZgThTWMgGnumd6lX
 dy8B8Rtj7RwZU+g6HoUuaVFvqKL5cCk9d9ghXbqzQJLRKfyIwCv27Ridg9iVjFBHltsV
 gIW4+DnfGHJYo4Ts/i1hh4qW3o/zakIndbkDS+5RSg4HqzgVanGdgij+NaEQCNJEQGee
 trsQ==
X-Gm-Message-State: AOAM5338D7sp8xYR5EbJ5i6MMLLbznfqAVwRVur/Fez+65P7QoXOag9q
 nj1ex1PJMltaoQ9oaar8l293IhRHDXIP1t1VyEqMXtBBgh3+Hl5+7n3aRFz+4ugsP+FDTsu5Ihu
 DMfvLVXcb+24u40QCAi4P1eKdb20=
X-Received: by 2002:a05:6870:c189:b0:ce:c0c9:651 with SMTP id
 h9-20020a056870c18900b000cec0c90651mr1542858oad.163.1644938299816; 
 Tue, 15 Feb 2022 07:18:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvcaH7jcnbwPkLjg2ejyUvLy+ZVX93Xbc/KU+U9/El5yPyHeCLfLRZclLcTwWS7JBRqYBD0w==
X-Received: by 2002:a05:6870:c189:b0:ce:c0c9:651 with SMTP id
 h9-20020a056870c18900b000cec0c90651mr1542849oad.163.1644938299653; 
 Tue, 15 Feb 2022 07:18:19 -0800 (PST)
Received: from [192.168.0.14] (97-120-62-247.ptld.qwest.net. [97.120.62.247])
 by smtp.gmail.com with ESMTPSA id
 s3sm14813219ois.19.2022.02.15.07.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Feb 2022 07:18:19 -0800 (PST)
Message-ID: <03b33f30-aff7-84e4-8415-782d204177fe@redhat.com>
Date: Tue, 15 Feb 2022 07:18:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bug report] WARNING: possible circular locking dependency
 detected with blktests nvme-tcp nvme/013
From: Chris Leech <cleech@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org
References: <CAHj4cs9MDYLJ+q+2_GXUK9HxFizv2pxUryUR0toX974M040z7g@mail.gmail.com>
 <71d184e9-503a-1dea-2881-c38f59849209@grimberg.me>
 <e6062357-beb7-7150-1e88-1109babcb86a@redhat.com>
In-Reply-To: <e6062357-beb7-7150-1e88-1109babcb86a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cleech@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220215_071824_463929_204CF0B7 
X-CRM114-Status: GOOD (  10.83  )
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

On 2/14/22 8:21 PM, Chris Leech wrote:
> Also, I might have a sleeping function called in atomic context report
> with a similar enough call trace to take a closer look at the direct send.

That looks to be a backport run with device mapper multipath, and a
repeat of the dm-rq BLK_MQ_F_BLOCKING discussion on linux-block.

I currently don't see a reason why the lockdep annotation wouldn't be
enough for this.  I'll send a real patch if that's the way we want to go.

- Chris


