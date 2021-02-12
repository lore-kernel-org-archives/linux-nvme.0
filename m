Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262FAC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 05:22:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849DD64E6C
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 05:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849DD64E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wN/RcT/G+/X0E+qAolra3OHOmvO+h83BwXrmGQ2hGG4=; b=Cuy68SL4R+6GONhxBX/MbFq8C
	e47HWa0Ferxz/9xxgCJUf7KkOb2Lti0uZnvudWzuZbn8sfoUrtMb5rX1TPDldh2uQmUQD8LZA+ro7
	UXRElCHOl0wrO76DKZo5TEMWGSrnjYexpVogWiQyGuNYEqbP785V8uRWhI8/dePYdja1Hj5Q3lAEo
	esm66zZTM3w5HLVTkmU+4dukULGNBfVV2mX4gugqGBA5eisQPBQ1z822oBqeLkXOsvpW2yw0N3pgm
	B+z5spBsPcdzTD1byuPgj8KNPHr2+1LnLewN+uhbYkIqsgccwlfAbKhndTtOkyss/iw+aQNiTCfay
	Tp2mu2Fnw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAQuk-0005A9-LY; Fri, 12 Feb 2021 05:22:46 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAQui-00059O-8H
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 05:22:45 +0000
Received: by mail-wm1-x32c.google.com with SMTP id u16so3866147wmq.1
 for <linux-nvme@lists.infradead.org>; Thu, 11 Feb 2021 21:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xD21291Ju4hiciJMXvou0U5l3OJazFXXjCPwhLAGanA=;
 b=nN1MgX70ED80GmQb7NLRk6ldnpgRdnPRWEShF8rEk++JBJhCQu3Ddt6h+JSaBklUrL
 jGMA4X4rtcbmjp+X5nAZ5WZtmVFOyfDnk51mxNUylWr2j+RDC6eRyCPrGW240zKzAOMs
 20C9Sj1tf3JnxhD1QW1DfLameVThqUnxP1yEHJ+kPvbxdPQulZyZFxUUzwcHrpXcWFcO
 SsEB2tzOoneU3SluaRcrgPnxeuEEwklcrNWkwMwaO3XA+IhHGfYj90gHBfvH4Mr4PLNQ
 Mwi/dwsBs3ZmUlbtHFbrpsEAyd/qBYZE153rFPKAh3hTgdI1vADdwciqmm9MRuJ1A5Ge
 9yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xD21291Ju4hiciJMXvou0U5l3OJazFXXjCPwhLAGanA=;
 b=R3rNPVALwxm6V8Yk9GLE2sCZkl32Dq+EQf3Af5YxF4Zlx0nYGuMBEH9WK8QhBzRvUl
 E/5g+aN7NRmmSe8ri5rS1J+vMnLTrI69hkyBdMqbVVZFjEqmXPq/N2uWcH9ttqFQKLZk
 k+XsiOtZ7jdT3+7a+QLXsnMHlMgbS5RtGN3U4hsFI85hO/KhGIXooze2SXw61/tbBmiO
 +eM1WNzsDh0keo9gbwoI67JkZ4iHfM0ox0FEJ9gpvotiqls4gOu2GDDDTR1clnlMGFrM
 TQRttDAft+pWwmpfiLgtoXnRFUUcT4aOipBS7Xi8ZIvhcyFSoWHNIxLNjcoytO2seMkn
 09Pg==
X-Gm-Message-State: AOAM531tSDBDbekSyqksgGMSR/uovFH6GzzvNrc3iF9brF+Udcx7x9oo
 z3oAEBmPbyVqsP0kgfNRy5E=
X-Google-Smtp-Source: ABdhPJzmS3WmsSn0SDPqFElzNO0a5be6z7mPm2tSA+NkLN5vqVWyPONfvqjFktwXAcx+M1u80grVjQ==
X-Received: by 2002:a05:600c:210f:: with SMTP id
 u15mr1007836wml.126.1613107362000; 
 Thu, 11 Feb 2021 21:22:42 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id f5sm13364239wmf.15.2021.02.11.21.22.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Feb 2021 21:22:41 -0800 (PST)
Subject: Re: [PATCH v4 net-next 00/21] nvme-tcp receive offloads
To: Randy Dunlap <rdunlap@infradead.org>, Boris Pismenny
 <borisp@mellanox.com>, dsahern@gmail.com, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210211211044.32701-1-borisp@mellanox.com>
 <76c93e83-be63-f7ed-a096-1408e9525331@infradead.org>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <153bbd21-4704-b28c-d418-8c091cef7348@gmail.com>
Date: Fri, 12 Feb 2021 07:22:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <76c93e83-be63-f7ed-a096-1408e9525331@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_002244_373182_6480E668 
X-CRM114-Status: GOOD (  10.85  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/02/2021 23:32, Randy Dunlap wrote:
> 
> Hi,
> Did vger.kernel.org eat patch 21/21?
> 
> and does that patch contain the Documentation updates?
> 
> thanks.
> 

It seems the error was on my end, thanks for raising this, I've resent
that patch now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
