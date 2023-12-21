Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715A4C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 21:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=83E5t9dvCQdMsdpEN4iZfGFzunUB9ar9iR0gwlKCl6s=; b=KybsxgivGnrbrvGIf7d11YbhQf
	fjySP0qA4j4CMZjCkokpVAo4bW9OvnAglAaZ7TukKmCyYntFGlDEFj5PpYf9ApngEbYjYjioyANkV
	VHUyXf2rAs/6v8rcM6g++nxZOfX5tmetLlDJEFWd+P73McX5OyfpQZZ+K92okYmZeQCZaZhzoR6j4
	h11Rjs36R33x1lsYRBNtTbILWHNBhlzB0xyTmPnmKTlEVNB/wvedAJyGIs6BEXpIyLNIdKZ6p6Gz3
	nnjKsmOsHvbtLQ1a8O4p8T+wc8NP/0/4RoR6daa96DheoCSebo4tpTq9C+KK9hcv0otSf4TE+nLKK
	iW/Qo45g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQA5-0045cj-0o;
	Thu, 21 Dec 2023 21:00:57 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQA0-0045br-0i
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 21:00:53 +0000
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso899857a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 13:00:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703192450; x=1703797250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83E5t9dvCQdMsdpEN4iZfGFzunUB9ar9iR0gwlKCl6s=;
        b=MbtT/LXZLp4S8IedXIP2ObXdWwQ3qzHF240gm6EYj2IJ7FfSc/yXVUOG6D7C3HXxVW
         XHq86O3mWdFLcBdY1CPvTiDyIbOSJ0PivqXSuun6e5KBdhXm2D4kIP3carHEH9mt9KKX
         Ls5vErY8WfIyQcXkxDt+we9AZNSdUd4eUVC4wnYWfsDiSkT7kBNrOevHMnw7Kur84wYo
         92Ya3ztaf1D60nAQ7DQNeneDMKdv5h/YjJbXRGsunN37O2rlze2un+eGokfhrcSKCpmM
         /EtFOtAqxNeVw9+/P9hTEXl2dF7rw4jREHDXtC7sE8QVTaSK5XeXIQuY1bDC01wLCRFO
         Tlmw==
X-Gm-Message-State: AOJu0Yyqulkgr+AMQbIt1NtFMb688MOP6kx1h0O01k6CxG6kauWb+4+T
	Lk7J/t7486cDIaATjFvp8Ow=
X-Google-Smtp-Source: AGHT+IF6Vyr0+ziV5cTfXGCs1VR1owc+gfKItvvVoK6ZO695dJGMuR7qbeQcDNpP33NW80EtO6hkjw==
X-Received: by 2002:a17:90a:de05:b0:286:6cc0:cabd with SMTP id m5-20020a17090ade0500b002866cc0cabdmr351341pjv.52.1703192449904;
        Thu, 21 Dec 2023 13:00:49 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:d9ff:baa2:bd58:437a? ([2620:0:1000:8411:d9ff:baa2:bd58:437a])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a840f00b0028bad9b220fsm2196949pjn.37.2023.12.21.13.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 13:00:48 -0800 (PST)
Message-ID: <8db6e3f4-c830-49e2-98c6-530c515eaad3@acm.org>
Date: Thu, 21 Dec 2023 13:00:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
 <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
 <ZYSjJdF1wyqeCFhU@casper.infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZYSjJdF1wyqeCFhU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_130052_253965_2B126304 
X-CRM114-Status: UNSURE (   6.03  )
X-CRM114-Notice: Please train this message.
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

On 12/21/23 12:42, Matthew Wilcox wrote:
> So if you want to talk about the downsides, show up and talk about them.

If I receive an invitation for the LSF/MM/BPF summit I will show up :-)

Bart.

