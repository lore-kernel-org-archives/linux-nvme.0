Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F78C55178
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 07:51:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A746A2085B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 07:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J3bJfniX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzTjJsg5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A746A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GWfK1yZa5l+MSaApPifPzFWfE5/lzLMhsGpUghQQK5g=; b=J3bJfniXWJl+aqG/IN5aOYP4H
	7FFNw5uU7jhbMxiTMlbm8n6zKa7IepJlCDc870pKQRNKPV+hhxbYbC0z1iVd33bPYUX8KV2cUqHmR
	zaNxe35MnroUfGBZ84zjTreNFZyC3+KJZXgQCdp0fUHGHH26ZRGH7+YXAu/vtBerTNGvkpMlVLb42
	luLOftit1CtzW5wDhTe45k/dze+4Q19Fdhzf5o8X/abMczH+03ROM5YWdSSYh7JGgByqDrt+OcpGr
	kFBTwrUepMryPxjrQ0Zwd9b+mz9Z+40LzJlPzuwnvu40/VntjpLT+JX6ZX8+mJaY6YHgwI2uUjzFE
	6tiMu16Kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVrql-0005a7-OK; Fri, 23 Oct 2020 07:50:59 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVrqi-0005ZR-KN
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 07:50:57 +0000
Received: by mail-wr1-x444.google.com with SMTP id t9so674496wrq.11
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=KiMeTNvuJWl2SezAC+PmIAPqAyoNbN6ufn4geAn7wIU=;
 b=mzTjJsg59fvwvjsKPdPbU4FwswB2et416YxnnCTAeThWcV0QEQ/x1GEM6EtvztmX6f
 qwXoAA5IallguDLmOACi3bL80UhRdIJQ3rbPSwvCmn3U5H7ZatijxBW/FW21fcLdO4Oy
 ulLjjvCcy+0VwGICRt2YJEjDSRLo+5Adm6HhvYpP9eb3kUIEUavuKff1CwU67dtaBPtH
 dQ2j1vWSIkIV0fSOvlmzphVtZ/u6+1kEBIsDG1P9iOKOHB1eJXAgGCGIQt/LAwJMngV2
 Xo8EN9D7useCWRLAKzLHniikB22CgwBQWqe6T5wfIls3xyAhrVqDD9flj/jQiFAwrJie
 amnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=KiMeTNvuJWl2SezAC+PmIAPqAyoNbN6ufn4geAn7wIU=;
 b=C4gf5PRRuYrUNWU5yBruF6XkPdag3XH8t2eI/QiplVMOQdBjFC1036XdR0DmU2oXav
 bDH/hu6yJVe4sAp9MDPa1oImjulwL7rxNQ7IBXcM9zZY8ZiGuWJn4w5B1aC0yFZ/x7rN
 nhHv6OFDEeshOLnN11aNteTSQ76XWW+Xa5ek3F7C8cKy9YYrXdOtimGv+yBrqGNdncjG
 uCiI5eykxOquyZTPNA7MpM2bodvJcBK/mxL+fX0KBlqOH01q9x4IiTl7O4sIMTQtYUV6
 npW710ZxX8Kz8TnTBM/iLuCjomIaeWJDwdvZ0fo1nxIejeZnHkLPCMFYW6tJU1aU+msN
 q3zw==
X-Gm-Message-State: AOAM532rbpogvvM2HhZCmNwUiuffO/DVFPE+NDkKAlxMcXE0i7hDZX7t
 i8KIxtASMJwcNPa14MmnQfE=
X-Google-Smtp-Source: ABdhPJwbpU56hwwxySnGZy6ga7dCt4XEtWrU/x1AxEtT+lI4i00bETVnkPdMhp/y6mL3PIz2vQOlww==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr1226034wrr.9.1603439455197;
 Fri, 23 Oct 2020 00:50:55 -0700 (PDT)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id 40sm1657185wrc.46.2020.10.23.00.50.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 00:50:54 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 03/10] net: Introduce crc offload for tcp
 ddp ulp
To: Sagi Grimberg <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-4-borisp@mellanox.com>
 <904a5edf-3f50-5f6f-6bc6-3d1a1a664aa5@grimberg.me>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <8d8a5e86-c734-7fa3-248b-b7c3c7a5699e@gmail.com>
Date: Sun, 11 Oct 2020 17:58:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <904a5edf-3f50-5f6f-6bc6-3d1a1a664aa5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_035056_758632_EBB4A128 
X-CRM114-Status: GOOD (  14.80  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 09/10/2020 0:51, Sagi Grimberg wrote:
>> This commit itroduces support for CRC offload to direct data placement
>                introduces
>> ULP on the receive side. Both DDP and CRC share a common API to
>> initialize the offload for a TCP socket. But otherwise, both can
>> be executed independently.
>  From the API it not clear that the offload engine does crc32c, do you
> see this extended to other crc types in the future?

Yes, it is somewhat implicit, and it depends on the tcp ddp configuration. At the moment we only do nvme-tcp, and that has only CRC32C. If in the future, there would be other CRC variants, or data digest algorithms, then the code could be easily extended.

In general, any data digest over TCP can leverage this code and SKB member. Not only other CRC types can benefit from it, but even more complex data digest algorithms like SHA can use this. In essence this bit is similar to the TLS skb->decrypted bit. In TLS, skb->decrypted also indicates that the authentication has no error, exactly like ddp_crc indicates that there is no CRC32C error. The only reason we didn't use the same bit for both is that these two protocol offloads can be combined and that will benefit from two independent bits.

>
> Other than this the patch looks good to me,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
