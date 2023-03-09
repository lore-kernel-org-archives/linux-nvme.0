Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7667C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4DnOrK6eluIY3csFfRpB7iVzEAaVZe/zURRAiYA2H0=; b=dJ2p5quu63Oshg6bP6GOPrT3Hd
	catkPKzlKQn/1IwRj0AobpScgqZo78dN82QwS3gll7/Mje1QkB5epMD8I5/SbSNtU6gmgsdSI51oQ
	JlJ03y455z4I/qocbZY5vpaX8kvXCBWxjZD9fZgSdNFpdbURURIF2lUZ/o7ZsIk811LFCDmWqveNG
	6/W/RY1+IDV434yn0+VNSHztqGP75DLyp23FE5I6hSjI1aPEUwbeF8VKrNZ5Vp0U+Wq3hP0c/03qI
	inCFsjbE3oNV1ETrRIRn9Krf0QvqKtZw2Uqstg8ETQ/211M1ClcUSX6/aGh5zmbiOiQtmuxlitkXT
	AwDsY7AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCS1-008lP2-KE; Thu, 09 Mar 2023 09:20:41 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paCRy-008lNQ-MT
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 09:20:39 +0000
Received: by mail-wm1-f53.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso787879wmo.0
        for <linux-nvme@lists.infradead.org>; Thu, 09 Mar 2023 01:20:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678353635;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4DnOrK6eluIY3csFfRpB7iVzEAaVZe/zURRAiYA2H0=;
        b=qJcjvFOC2j1d8Lvewr6KeWhNHmm1itCtycVT+q7S04q5+1BYRo1yuFF/99PEzvK+RG
         h7JQnD/q2vj4c7QCkIyJuOlhPVFoxwrvO4Y32s01L1kVqKlAC3Ka+DY/4fepMlQ8eCEA
         ePdatUN7Xu8eHk7K3Ut8tcJeeDaKOW0JAH6WnEQMc8nPIl96QV25RVzjwtpvONYLuxp6
         NE2bsDLZATT8y4xTomYmtZ1rij1s63RkzqQrdTSHp8iUw/v9uRbmNp42SJPgQpEy0Kg+
         89Xs4gdczHIZ7hectHcPfV67ZHPPuOPik9hGoYX2tUEj2nn5ndI25KQ1QmDfhz60ouiu
         mmwA==
X-Gm-Message-State: AO0yUKUuInHqYGyrNtmpzu+VImFTg2IC0Mbl2jTHEDXNM6nocAPWEOnS
	gDzYrMv2pedWrCnscgdP3bU=
X-Google-Smtp-Source: AK7set8O87BBg+d2mUeI1CxhxmCi92kGzMzTqUzavkVL5P8z3TFNd0uw7xpCE22oHD/Ia+FYkGWwDQ==
X-Received: by 2002:a05:600c:3ac5:b0:3e7:534a:694e with SMTP id d5-20020a05600c3ac500b003e7534a694emr1500950wms.3.1678353634959;
        Thu, 09 Mar 2023 01:20:34 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d20-20020a1c7314000000b003e11ad0750csm1874514wmb.47.2023.03.09.01.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:20:34 -0800 (PST)
Message-ID: <538393e2-3435-7e93-d688-d77f45552286@grimberg.me>
Date: Thu, 9 Mar 2023 11:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] MAINTAINERS: repair malformed T: entries in NVM EXPRESS
 DRIVERS
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308144132.13368-1-lukas.bulwahn@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230308144132.13368-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_012038_758999_ED7DA6E2 
X-CRM114-Status: GOOD (  10.34  )
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


> The T: entries shall be composed of a SCM tree type (git, hg, quilt, stgit
> or topgit) and location.
> 
> Add the SCM tree type to the T: entry, and reorder the file entries in
> alphabetical order.
> 
> Fixes: b508fc354f6d ("nvme: update maintainers information")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

