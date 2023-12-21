Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C88C35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 20:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/7KbnN33cEMU1ra8cl0k5N0j8jcZeZqi4GJ0MVOhJUc=; b=jfmXzaLpQoG0dJUE3UluMaOd+A
	+M41tJN7mTf2Ak3QKzFjof6zaR8MgBKW0k94caVrBEQLQ0TdKc1xAenmZPrskbTWv4bmObz1CK8US
	JlFl9U9eGSCrh0QZnoFMGKFN6jt74odJGe5+pIDaJM/hU18eyvDgOrlalxQVx5cBuYeY74+qXwwWt
	psR0DCqBehfwOzqYKTEc8bbcSQ5OOU+MbRo5gw6Yp7owFlEHUO2Nm2SA2BLN9HBqs4Wshus2/IHsA
	pQRCI0+rZ2zGfMbm8VcPPJnA1kYh4EYMuvmUEJ6vHUdniMr2VlN/5ARaxtHG7BWecu/tJAtDVxVB1
	5m9y3QlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGPjH-00422l-2f;
	Thu, 21 Dec 2023 20:33:15 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGPjD-004218-3B
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 20:33:13 +0000
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3e84fded7so8755755ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 12:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703190790; x=1703795590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7KbnN33cEMU1ra8cl0k5N0j8jcZeZqi4GJ0MVOhJUc=;
        b=KMQC7Ja9GX6BfT2ecZGbuHbcrwTdyuWv4kHMR7o/+UlEm6x1n2oKHNhtIZKoOjuDK9
         plx2juC8sAU2XYi9FKj17LWES168dmKdGJ8+TDiZlRxac/hxXzG3rt5LDM9X5EmOxJbk
         SYNAS6hL54TX33n4iEV6oPD55p/d2AheE2ENkYQMPPSBEQ/u/b9t42BcixwGEKrRFr10
         /MF+hTLIAlu/VZXPU6r9DaQy5ldy8TyAIORtjx5wzk5VxrTLogKPhcLa0hq1NgmZJLlo
         9ouSK+aA2nytXD+lccWYLyYKobeOqNqmaPuw+sipYic5wWp9eWhuMRUluYHDbpWPkimj
         O7eA==
X-Gm-Message-State: AOJu0YyLSCVGpLBwisxq2msmtX8Xe7DSWZogOoDtEQWXdY5OCE9TDbDO
	yUoydtUwg6eeGulVsBnr/xA=
X-Google-Smtp-Source: AGHT+IEuLC9+wqhPPyf5+htFMuDuga2BsWAd+xWyMzex6dtSWq5jWA+ph6hyRpScpzzQ0l6JSfYajw==
X-Received: by 2002:a17:902:ecce:b0:1d2:e521:dd72 with SMTP id a14-20020a170902ecce00b001d2e521dd72mr230098plh.109.1703190790351;
        Thu, 21 Dec 2023 12:33:10 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:d9ff:baa2:bd58:437a? ([2620:0:1000:8411:d9ff:baa2:bd58:437a])
        by smtp.gmail.com with ESMTPSA id z3-20020a170903018300b001cfa718039bsm2045190plg.216.2023.12.21.12.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 12:33:09 -0800 (PST)
Message-ID: <5c356222-fe9e-41b0-b7fe-218fbcde4573@acm.org>
Date: Thu, 21 Dec 2023 12:33:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Large block for I/O
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linuxfoundation.org
Cc: linux-mm@kvack.org, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <7970ad75-ca6a-34b9-43ea-c6f67fe6eae6@iogearbox.net>
 <4343d07b-b1b2-d43b-c201-a48e89145e5c@iogearbox.net>
 <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <03ebbc5f-2ff5-4f3c-8c5b-544413c55257@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_123312_020919_0ED9CBF2 
X-CRM114-Status: GOOD (  13.08  )
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

On 12/20/23 07:03, Hannes Reinecke wrote:
> I would like to discuss
> 
> Large blocks for I/O
> 
> Since the presentation last year there has been quite some developments
> and improvements in some areas, but at the same time a lack of progress
> in other areas.
> In this presentation/discussion I would like to highlight the current
> state of affairs, existing pain points, and future directions of development.
> It might be an idea to co-locate it with the MM folks as we do have
> quite some overlap with page-cache improvements and hugepage handling.

Hi Hannes,

I'm interested in this topic. But I'm wondering whether the disadvantages of
large blocks will be covered? Some NAND storage vendors are less than
enthusiast about increasing the logical block size beyond 4 KiB because it
increases the size of many writes to the device and hence increases write
amplification.

Thanks,

Bart.


