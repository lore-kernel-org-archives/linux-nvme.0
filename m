Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F9CC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IM3qGY7s7nTcHnz+jXp7FRb0bAunP/QE8eA19RDpMaE=; b=kLAdYSk2J4Whj9oDfOoFZHc9YL
	VpUgdIrcrCeHBDYm8ciGg1lm+dRCCc0hAjFc1OG/Co5CyPjcDhEDXVQKgmMvwYBO6iu6KhGm+stjB
	g6ApEQWeVyOKkDjdKCnDjiCrPynjfuEq+NOWTN7mLKG/AVFxXdEosFMkOtrzOAdZ6uxU5di2ApHeQ
	7h27IsG1bED22FesQmlfvY6TYe7C4kUKQ85AO0k8N9fw2NmLyIEYc4bSVkLTteYjsjSwBwT1EQB/V
	jHkDRxVcr8RQPAmJdlMvQkAiB5FtNLefmg4pD1eZiSGqZcwGslv23hNqJPtG+jvAfsLYgIDBvT4i6
	jPjym9Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTNfM-002mOi-Md; Sun, 13 Mar 2022 12:49:44 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTNfG-002mI8-GS
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 12:49:39 +0000
Received: by mail-wr1-x435.google.com with SMTP id e24so19806029wrc.10
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 05:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=IM3qGY7s7nTcHnz+jXp7FRb0bAunP/QE8eA19RDpMaE=;
 b=bg0Elp18gYLgQMpRdR87cxDeAiF5TyrTm8FZlQynkz1YigivjpeQrNSxk2eAEkrbZT
 O/J+UcD7v8uSxqTnButlI7yvnyjhOj7xxseKt3cb6r9zcmUMJwXqATkPKEPNFDR+GL5J
 cH/WOlOOnbGZ3ilzUsj6eogUTV0rfgB/5L27+Ezs1qbuv9c2OmNUbViKFzo1DkP6Mu+l
 1XOH8Kc1ZjKMjcB5y0VtKZLQWuYog0DmAxRhlvhKad6nNqFMCqy9787lVLypToWbJBN3
 G2wlaKZ1FJG620y1HdaG22VS+a0JdOYRQ1LEDgMX7iWM/8ptRDEQ5qkVRD1gJJ/0KnCO
 GQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=IM3qGY7s7nTcHnz+jXp7FRb0bAunP/QE8eA19RDpMaE=;
 b=E+zXp7bvXN5r6RMeP4Ldlmboqpv1g+FYBGBkdcf3IUAa+QP/uBfwVaoEqLtilz1YIE
 L/vV/fOMiy+BInBBQFDRB1w3LsQZu7+qLbDrf/qN79r7hQDyDNi+d6ZUSDhpqrTtaMju
 t/E48p5pdp+x6Zxj7OTP3NLRJ4fp/qtPqEIat8F1Rbm0QWsoN8TnfmuPc47y3Isr5wFt
 uimN6fC6sNjYR9wCZAwkd4hp+Op3nSPFsS3ejJY/E0BxEHJGWZ4Pv6nucCHLscG7LqCF
 av0lnIadxV3Mww9F1OE3JmUzjWIn0WlKhin16R8ykJA14aC0lXLGiF9BOjflSed8OBss
 SYHQ==
X-Gm-Message-State: AOAM532Ytw5qsO2+dY9jU2tWaz9WsYVmbJCaSlforzPlkWoAsj9AlGjL
 buxM0OUwHhyXUIUkjvHVbFfRwVb1VI4=
X-Google-Smtp-Source: ABdhPJxdFC7qcwTPCripqi4u2eDe6/6xd0W9a0NWytxnf5Cq1JMsMy5b8EGdVfwPMPCNcVT+PupzQg==
X-Received: by 2002:a5d:4a8f:0:b0:1f0:4af2:4e29 with SMTP id
 o15-20020a5d4a8f000000b001f04af24e29mr13412700wrq.519.1647175776220; 
 Sun, 13 Mar 2022 05:49:36 -0700 (PDT)
Received: from [192.168.0.59] (178-117-137-225.access.telenet.be.
 [178.117.137.225]) by smtp.gmail.com with ESMTPSA id
 7-20020a05600c228700b00389865c646dsm19479657wmf.14.2022.03.13.05.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 05:49:35 -0700 (PDT)
Message-ID: <a512e9b6-7ee1-4f4c-5c67-82315520bdf4@gmail.com>
Date: Sun, 13 Mar 2022 13:49:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
 <225dfcce-80dd-5b4f-5d9f-18c12107d4f4@grimberg.me>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <225dfcce-80dd-5b4f-5d9f-18c12107d4f4@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_054938_643065_5744390E 
X-CRM114-Status: UNSURE (   9.00  )
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

On 3/13/22 13:43, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Hi, thanks for the review.
This patch is actually superseded by a v3 patch submission I sent shortly after this one, since this contains a mistake and its solution is not optimal.
Sorry for the inconvenience.
Thanks

