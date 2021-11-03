Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4DFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:30:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D3F6054F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 00:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54D3F6054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9EXiRlTvOf8HpPFhCQggQGFyNRd1f3nfHkBOqTK8wEA=; b=RJn89+x48VjZcTBzxQpZ4M4fij
	CyiLIrHl/E7B9IGTKQgh9Y5730YCstaVNzrTJsjKsuRdARWZr24hgEe1hddOMMG9oFp69Jnq0y0Kz
	99kXflDGB/4MLr9NByoqqVOP4tHwrLSFz5sWLuf8eWwgxMEcDNWHaxBH2yYCyCvRhmXBecWaxzMB5
	tWN2TfXZ6yj6ut24VpbZ/2CQfUUt4jSf2fOmba+L0+kb5uLl6uYxh4ETCTr0jCMttG3LNmhlPx0UO
	DJL1cNa2HkNFec5wXh9pHXtLwPSLjUtpl4zxcxdPk396fthNWqVtkAEhy+7NnjysgRdpoz13F5mV6
	w3f5PEVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mi4AY-003dq5-PX; Wed, 03 Nov 2021 00:30:22 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mi4AW-003doT-Ku
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 00:30:21 +0000
Received: by mail-pf1-x42d.google.com with SMTP id t38so578909pfg.12
 for <linux-nvme@lists.infradead.org>; Tue, 02 Nov 2021 17:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=9EXiRlTvOf8HpPFhCQggQGFyNRd1f3nfHkBOqTK8wEA=;
 b=J+EtYkEjVQy26qXzKqUbqcsL0aBV6+QWZE3SKC/zkUGZM4EcKrPQCSuBTLt/yFzqbw
 gClqUDrSGNyNiNzap05jtkpO70o3X15Tc6w5pdfwrcZ4gSKDIej4ILJ0VMC8J/rYZc24
 c2gSpbLGGzwI2M8rEUB1cHPrtrh48dXmfrWtQ1EM8wE3EkXFFkbww2oJwhMOjd51gAAh
 tQwVwjehF0YThpRk7zl0ICOcm6XUip++M/aU+kih6Hhy0H2EdkEp5o4oOOVyrcjwpSm1
 JFmjXcB9USPzLjlGbM6tBMN77wlSDY0g+idh3vb9FVA/xcU6LSYKITJd19iPbpxfr3y4
 0vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=9EXiRlTvOf8HpPFhCQggQGFyNRd1f3nfHkBOqTK8wEA=;
 b=nkGdH/7nUwMmo4dEaNJI8SHAOU+vhqp6OHyTXPYQ/fVaoXOCzqQP0A5BY5vBI/EaHn
 yjYdV25950J3i6vqufymZAvwgMHGd438F9NWNDkEQDg115P7Z2OtRGtwgMv+aZPYynbV
 NojDCLcqlUU4yHvhURvi24K6xvhU75bssfQoT0Of6Nbbdp467JmyiIrzC77Csr8fGHwO
 ysoxA/vu3yu/IWaafc6uFUreT0rBAqsiMVtPoVwB0ujOg7JFoNuVWzV+jfJNQ1ZQ8xln
 WGcZOVdJU1yBdcwdAksw4+R535AhJ4n89liOR2pPhAkjqz9CFPFQu80QzorGZORUT4+I
 wjnQ==
X-Gm-Message-State: AOAM532NrAMNr0n2y5JCXcLPv7XtTluPEh0yiLCsh7/SI3vE0OcEd67I
 bErbyBMZiRDnbuD9LEnE+tE=
X-Google-Smtp-Source: ABdhPJzToXodXJjfhGkH1sa+BzrdXsVE6SQJaDo+9DEGzW+oJlao16xbgzDvY3ZJHlKrWGd+nFBrGA==
X-Received: by 2002:a62:8886:0:b0:480:915f:71fa with SMTP id
 l128-20020a628886000000b00480915f71famr25567514pfd.55.1635899418574; 
 Tue, 02 Nov 2021 17:30:18 -0700 (PDT)
Received: from [10.69.44.239] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a10sm212941pgw.25.2021.11.02.17.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Nov 2021 17:30:18 -0700 (PDT)
Message-ID: <b82a5463-d63e-020f-b976-3b7f4888969e@gmail.com>
Date: Tue, 2 Nov 2021 17:30:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 10/10] nvme-fabrics: set common attributes during
 nvmf_init_ctrl
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, kbusch@kernel.org, sagi@grimberg.me
Cc: chaitanyak@nvidia.com, israelr@nvidia.com, oren@nvidia.com, hare@suse.de
References: <20211020103844.7533-1-mgurtovoy@nvidia.com>
 <20211020103844.7533-11-mgurtovoy@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211020103844.7533-11-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211102_173020_724542_048196BA 
X-CRM114-Status: UNSURE (   9.86  )
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

On 10/20/2021 3:38 AM, Max Gurtovoy wrote:
> Move common logic for setting opts, queue_count, sqsize and kato from
> RDMA/TCP drivers to the fabrics driver.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/fabrics.c |  8 +++++++-
>   drivers/nvme/host/fabrics.h |  2 +-
>   drivers/nvme/host/rdma.c    | 10 ++--------
>   drivers/nvme/host/tcp.c     |  8 +-------
>   4 files changed, 11 insertions(+), 17 deletions(-)
> 

Looks reasonable and something for FC to consider.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

