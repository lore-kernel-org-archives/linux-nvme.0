Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86E4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oh1EtyDxwW8bU0lRsF/7ucwYMpRMF3YMnFvVQLa5I9g=; b=phH79Bhp+duoZiFti6GZvALRmR
	YR0x/DrauwivzrI8V9i4QJYNM6tWOkq5ihQHud8jgGnNyZeIpn4KvimWSi5WzguUtBdXhmGHEndFO
	vweOdvO/Voi4/LcWzKPIsPTmddBs8qVnbXzXRJyz1e5nSVeE9Hl8r1WcqQLeDvcB/XLgAvdJIFvHX
	UZXsskC8lTTgX+mnmiouGGfqKjvaVuUd4TRylU2DOCY25+ibm6dB1rdpymOiRSFnDDlYx5DafzoER
	UnO9qEAZUZYttk9SeYRT6aK2gfkj/b87TbkdRjX852fPbuz2gV557Bk+L2u0WCar4Ol7GrLFE/i0m
	hF4XhFPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS5TX-00AlgK-Su; Wed, 09 Mar 2022 23:12:11 +0000
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS5TU-00Alfn-Io
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 23:12:10 +0000
Received: by mail-pj1-f49.google.com with SMTP id bx5so3644682pjb.3
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 15:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Oh1EtyDxwW8bU0lRsF/7ucwYMpRMF3YMnFvVQLa5I9g=;
 b=D6eiI06cmXUtqX34k4BQb2vEmXVgBdmcXpYHPR7OZb4kjXwHGWOIoP8TMvHqm0V5Zj
 2pFdh3VFMjRr2oZ9eWs6l+UCr7rTDKAASPzhywMkZLqK3aOc3ZVf0DGaGcGBGXHLIqqe
 CzTU9rBq5/4lhE+kx5xeZpTj868J+d5h+Wk9oR2Q53dPsQwHIu/HoCS58Q2fjT0ZjQDN
 /AoZyeItobbxcCX16eomMn1ZjWLW4CSUHAQRfK5CguNpoBVcowjP3H4TqhBvkLIuaPv9
 K097Tle2ayCKkSB/1H4XCFfjYAl9Ep524UdZ4Z+GeLvxKe/tHvTvD5XcWQardedpdtGD
 s7pw==
X-Gm-Message-State: AOAM532FJviEoSo5vV1ZoOcdnyOgHsHQwhRgMOVvfDrA9CkEDfDNr+mp
 gxI5jRUtLgPGWpdNLR4pOCKvxgBgSbo=
X-Google-Smtp-Source: ABdhPJwGSRWUnfF30t6UlYMekAgR49jEmbANE7x7NzUafqf/dUjch5uwuB0xSeTuyzL1eJsYtx0ewg==
X-Received: by 2002:a17:902:ea12:b0:151:dbbd:aeb8 with SMTP id
 s18-20020a170902ea1200b00151dbbdaeb8mr1834622plg.157.1646867525643; 
 Wed, 09 Mar 2022 15:12:05 -0800 (PST)
Received: from ?IPV6:2620:0:1000:2514:1f39:9c42:2577:aafd?
 ([2620:0:1000:2514:1f39:9c42:2577:aafd])
 by smtp.gmail.com with ESMTPSA id
 u15-20020a63470f000000b00372d063da1fsm3364154pga.29.2022.03.09.15.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 15:12:05 -0800 (PST)
Message-ID: <283f07fe-cfc8-cecc-311f-ca7603e5118e@acm.org>
Date: Wed, 9 Mar 2022 15:12:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Niels Dossche <dossche.niels@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
 <dd679ebd-dba9-219b-20c4-21f0270138da@acm.org>
 <09c807d0-1aaa-b5c0-65cb-05700059e5d0@gmail.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <09c807d0-1aaa-b5c0-65cb-05700059e5d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_151208_656647_47B37D5F 
X-CRM114-Status: GOOD (  15.85  )
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

On 3/9/22 14:30, Niels Dossche wrote:
> On 09/03/2022 23:27, Bart Van Assche wrote:
>> On 3/9/22 12:34, Niels Dossche wrote:
>>> nvmet_ns_changed states via lockdep that the ns->subsys->lock
>>> must be held. The only caller of nvmet_ns_changed which does not
>>> acquire that lock is nvmet_ns_revalidate. The only 2 callers of
>>> nvmet_ns_revalidate which do not acquire that lock are
>>> nvmet_execute_identify_cns_cs_ns and nvmet_execute_identify_ns.
>>> Add a lock for around the call to nvmet_ns_revalidate in those 2
>>> functions.
>>> 
>>> Both of those identify functions are called from a common
>>> function nvmet_execute_identify, which itself is called
>>> indirectly via the req->execute function pointer.
>> 
>> Please mention in the patch description whether this has been
>> discovered by studying the source code or by software (static
>> source code analyzer? runtime data race detector?).
> 
> This was discovered by first using a static analyzer and then
> verifying it by manual inspection of the source code.

Hi Niels,

Are there any plans to make that static analyzer available to other 
kernel developers?

Is the static analyzer more powerful than clang thread safety 
annotations? If it is more powerful, is it possible to integrate the 
static analyzer in clang?

See also:
* "C/C++ Thread Safety Analysis" 
(https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/42958.pdf).
* "Thread Safety Annotations for Clang" 
(https://llvm.org/devmtg/2011-11/Hutchins_ThreadSafety.pdf).

Thanks,

Bart.

