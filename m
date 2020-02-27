Return-Path: <SRS0=7/L5=4P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B622FC4BA24
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 02:35:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67138208E4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2020 02:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GvfutVBo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XuXOEoXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67138208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aeX8BHgduUz95xEIuej5v8pEhrvQOeMcliSKZ07HJSc=; b=GvfutVBoNeAAOlJ65xOcLhvoBT
	GJNvNZFOGk5VGRHZm3NYo/2VPwS31rOzDCfGtyOWexmkwMO5yrLcr4DXH7Z+/4H4V8xIH4tT+iQUd
	ID6dI+fujCLf6bvLjVECyHBWVu9KYDTtfoagBKFZjHKeURHHZPT+CBP7CgtsjkAIKGh+nfdPeKW3p
	4/hv//cioTY+1NjwnTMU9tAGo5SVDcCIpVP7T3dSdt7CSnJLlcdoFaz4kbB7YtMAOA2QX41ctfWqX
	5j0Swm1CgE06j9Q3hdmHHXwAkEaIuAJ29pEMz91n9aDZTkxGfELHuemVcEdaDP2d9UL8v3pzf2fQP
	jUOFzjbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j790u-0005WM-Ng; Thu, 27 Feb 2020 02:35:00 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j790r-0005Vk-GV
 for linux-nvme@lists.infradead.org; Thu, 27 Feb 2020 02:34:59 +0000
Received: by mail-pl1-x642.google.com with SMTP id b22so482742pls.12
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=n+TZCoZS+Buzwk7jI/syyoCu+K0BYVq5mzGgmATJVzA=;
 b=XuXOEoXKaZc+t+PAnrKuMyBZ5p9HshS/q4j360JHyfiStkY0KMZrCGY2IcPgwwt/W2
 dlnIZ137LZHGIQAbxI7vD0LvSDpOixeJ0fW563OOmfir/0thS+8TavRrxfsOzvBRwwmj
 zYQUfFzGa/X+F0j48MdUOGz7Di11sUM8g1fzU9+0H+K0ZvqPyZv6wGCvoQJ5xUFv8XMn
 +kvsBSau6mbPLQUIPdnNhqe5F7EIFipiV2RYl9obU13/y+jYnCvnnQwrrsu90PyWkxDL
 u1j8ks3g5QieU9k+dvVKE6sxo63T9k4U3d6vfHF6CvE8Vu+w9O1gH7ocOzGzdIhLG569
 izYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=n+TZCoZS+Buzwk7jI/syyoCu+K0BYVq5mzGgmATJVzA=;
 b=IHn95rjwZfQ5Ilofe9W7hKGbiVWdFOtJBaMj6gVMcx+Hqf1UJevnXYcLA33qOBkCoI
 1XhyZ5s8RwJnveTdFoI4A5xwMfdHJ9ZZuh3ITW2t32gTgGm0umdMq9VrCNZBuBPKqtIF
 7PibrYjpuIpo5hyID2VmUgjHhKSaEgPBQc5/bWS8os1YKOXDtfrMTjWIt4g7r7vDFgRq
 uiGO3HaxpajDyMOgYh3xUwwJnhlmN0zPUMKzBMY2pK74/sf+H5HK8G3ItAU/gTGaUl6s
 eB9zavvnnBHYgH+R3LYTXecRIE9ScxjlGZCxG8JPviLBCvupDsH0Xzjmci2OngOonEYD
 SjYA==
X-Gm-Message-State: APjAAAUGoqRBRU5ARdpIhGZBaC+EWso5BFtURkDM0mua2qfHI5gxOzkR
 zBk3ntr1DNj7i1+4xG53KpQWnaxcGgv/2A==
X-Google-Smtp-Source: APXvYqxqXxi5V2NuI34mo0YfrzTO4xTXJTnoNKdQt4CG0+4PWqRG/vkWdSOeNcJS5OFBltGxyYIN/A==
X-Received: by 2002:a17:90a:b10b:: with SMTP id
 z11mr2418746pjq.132.1582770895772; 
 Wed, 26 Feb 2020 18:34:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
 by smtp.gmail.com with ESMTPSA id d23sm4528857pfo.176.2020.02.26.18.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 18:34:55 -0800 (PST)
Subject: Re: [PATCH 1/1] nvme-pci: Hold cq_poll_lock while completing CQEs
To: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <1582753762-47774-1-git-send-email-bijan.mottahedeh@oracle.com>
 <f85ab885-0837-633f-51eb-028dcf451486@grimberg.me>
 <993bca83-459a-7982-3351-18446a14b9c0@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ca82e982-7f51-c515-202c-dbce10eff54a@kernel.dk>
Date: Wed, 26 Feb 2020 19:34:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <993bca83-459a-7982-3351-18446a14b9c0@oracle.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_183457_568655_9ABF9418 
X-CRM114-Status: GOOD (  11.81  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/26/20 7:31 PM, Bijan Mottahedeh wrote:
> On 2/26/2020 3:06 PM, Sagi Grimberg wrote:
>  > This needs a Fixes tag, and should probably also be
>  > picked up for stable. Other than that, looks fine,
>  >
>  > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> 
> Is this the right tag?
> 
> Fixes: dabcefab45d3 (nvme: provide optimized poll function for separate 
> poll queues)

Should be:

Fixes: dabcefab45d3 ("nvme: provide optimized poll function for separate poll queues")

> Should I send a v2?

I think so, always better that way.

Feel free to add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

to it as well.

-- 
Jens Axboe


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
