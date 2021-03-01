Return-Path: <SRS0=Uoxm=H7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF2CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:10:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2280C601FD
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Mar 2021 19:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2280C601FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JCiipDNKY+3LyRvYo5KP48HP4Amb4L1c6wh1HgDLbSM=; b=kcdO+lzTHMmTGg50uVojo9cXn
	4cu7t2T+Ky5BE6ZxD9lK4WyFZX7FpeFFvfWxzgbInFO/kepVDIafh+9Q0TSiZs/u0U4EeM3X2hNVb
	WwnyX1PDnCv0nw4z0YxX5xJ5siIz6ynA6rMWOE09dHeGtND67XIElJ7NfjrCIq9EEO0OzGM3jJV7N
	LPjYpztk7uoicMSRBM4TSH3sF1fS8V6tguHHO8EMDbqrbpYiRtV2+PgKEBBn40jbvLLF9m2t39R34
	D38LMdxMWqJ7iq6Lisml/u6RDLHP9Xr9H/4+B20O0V6VxJPRdmXo/TR8w9lh2yGhgQl8H8EO0Qex1
	UgEpN/S8Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lGnvw-0002Va-0V; Mon, 01 Mar 2021 19:10:20 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lGnvt-0002Uh-NB
 for linux-nvme@lists.infradead.org; Mon, 01 Mar 2021 19:10:18 +0000
Received: by mail-pf1-x432.google.com with SMTP id d12so9609334pfo.7
 for <linux-nvme@lists.infradead.org>; Mon, 01 Mar 2021 11:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LvFk5w+Pvm+a/m0FSPOpcWGpexTyNd+hJwDhEiPt0iY=;
 b=Ek9qBwwecffW2qAUoiHRG02bizfS7oeB5TqOfLkGJqayFvRmxu84pD+IWKWW7VchJO
 Qk5rn9uHCN46d86k1QEz5Ex9WtDdQk9QmuEFvjCQ2PdZ4sXXgfQoL47jgQXPGf7fF6QV
 uru/wU1uUHwla11hHkMT5tpjbESxj+w2IP6NecnVWfDfVWbdZFzzbLo9kkY110SUOeX5
 5P9bF80fvwLAutANH72klSxdgiYTgbCNoaamdgOxoBLrSoV9ZvOANM+O6kVMNQIFVrb2
 wKNnfTZl0FoUWom7EIB9yVfZkKBbaNG7Kn0Nye1l3UK+qJAxOBJH4vkFGj2v1cgxZoSd
 /kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LvFk5w+Pvm+a/m0FSPOpcWGpexTyNd+hJwDhEiPt0iY=;
 b=ppX+83VT8nMl2G1vlWG0twteEB7k/SlB9Snpq8LaIE/raXWMDaHgaL5jz3sNm3FoAq
 4RxZFFQjUVHZlrFZzpzeWcAAix1bzzrMq8B2TDCaUw/B5aHyxkyBwYcpqyA9nNZz3rLx
 4JGPMAZqLcXKORTA3VXr6L0vowcPQL4jc2Uq0eLy91molLcezrCtA2xNXY+93xn5gq5n
 xvMXSWsl++tuwxbTEeqHbqIyE9NITNL3ilunJDXdUmLndk17h43OW7otHoY6bGeVtuEt
 G9jVlzCMB1+shlJbipbyvu92qAR+auiKvhoNee38r39CxlVcI1+WuYMCD27rp60UWGle
 fwzA==
X-Gm-Message-State: AOAM530/3qvv1Vci99z0TleY5Fnu/q72j4JJP4NR5uw9epasmiQYwEUG
 GTYz6sakmwfxN5lIFReZFCs=
X-Google-Smtp-Source: ABdhPJxhu/9S+1fKSsVk/wpx2jLueFJomzpgiQvAxUxaimUh9JuXizAjcup4/RzTQFUmMSIwpMWxZw==
X-Received: by 2002:a63:a401:: with SMTP id c1mr15265379pgf.60.1614625815527; 
 Mon, 01 Mar 2021 11:10:15 -0800 (PST)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id y1sm547118pjr.3.2021.03.01.11.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Mar 2021 11:10:15 -0800 (PST)
Subject: Re: [PATCH V2 7/8] nvmet-fc: update function documentation
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20210301020611.18669-1-chaitanya.kulkarni@wdc.com>
 <20210301020611.18669-8-chaitanya.kulkarni@wdc.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <d67aa3c4-d426-e596-d10d-7818230ff65a@gmail.com>
Date: Mon, 1 Mar 2021 11:10:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210301020611.18669-8-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210301_141017_797878_054C01AD 
X-CRM114-Status: GOOD (  11.38  )
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
Cc: kbusch@kernel.org, james.smart@broadcom.com, sagi@grimberg.me, hch@lst.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/28/2021 6:06 PM, Chaitanya Kulkarni wrote:
> Add minimum description of the hosthandle parameter for
> nvmet_fc_rcv_ls_req() so that we can get rid of the following warning.
> 
> drivers/nvme//target/fc.c:2009: warning: Function parameter or member 'hosthandle' not described in 'nvmet_fc_rcv_ls_req
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Thanks

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
