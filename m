Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F68C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 16:24:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBD761452
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 16:24:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CBD761452
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=A+xaVVJ1dtBPBRCLGZr66FoEuT
	RLrnZZkz3Nuos+7PVFria0Ec/LB+AVqcPQ1M8C6wDJKE0R0qS51TwfL2iHUCdw5jHi5nXak+bixJ9
	U4BInjAhK8rvNzufxVDpL7q2hojX9pMK38TUM5mekWmr/LsvR4A1gTREJl3VQ4Rtq9iGvtI8XqBJw
	HL/WOzJNcnu7qaderFH81xS1LxNk1iaFoLRDL9nKe0ZmnK8ydSmsPZLsqMyf+F9z+AHXqRDLntYrm
	ejDC+GzZq6Nik4BsMJQZt3D1kmyl4lhA503Ia0SqXBlVX0DxMdyu1jmJT0oMPFAtJwpOS5XbRsPHU
	6nwMwqIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn1FU-002JyB-7F; Tue, 16 Nov 2021 16:23:56 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn1FR-002Jxe-TH
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 16:23:55 +0000
Received: by mail-wm1-f41.google.com with SMTP id 133so17559731wme.0
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 08:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=fY9MWG9MJLjNYriXLArkpLuk/ark75L9PsrpdNg336yt3HsyE1j4JJTNJu9S1wq+fJ
 lG+3ne+eSdkRp/qR3fLBTYYlNrBJj+08jticapOCRcmZSuYD625PJvsN8YdJggMhcMy4
 zRi1D7j4fnNz/FKvNicZ8UbxwXRHVRVlWy1h5JdbRJLU8HqaD9VUGOqtG+EjVYrOW8Wg
 xDIikx7+iblTYnXLxkHTG7gFUMzT6YLklWLKEVVaTq7+J9GbcgX63NOiIRC51Tc2B74p
 rRUvjcmI8QrsEM6rg7XUxFrooaIueNifZHa1cY3zP/psjhw0B6TlNvZTqvb8QtL2AOYc
 OsXg==
X-Gm-Message-State: AOAM5316NuH6tr8j0y488nFdgjGtfaEowXPYjDFuo+zaCxZUMI32qxef
 mjJamFB/anIbjKF3F84Rj4g=
X-Google-Smtp-Source: ABdhPJxfVTyB8IJ6IZPow9Qd4wOn88WaXJsqhMzZxyTG4PlzM4ShRUUSD6rAc56zbTYNfbJm+F21kw==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr9464322wmi.61.1637079831629; 
 Tue, 16 Nov 2021 08:23:51 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n8sm17706284wrp.95.2021.11.16.08.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 08:23:51 -0800 (PST)
Subject: Re: [PATCH V3 2/3] nvmet-tcp: add an helper to free the cmd buffers
To: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, chaitanya.kulkarni@wdc.com
References: <20211116154920.87279-1-mlombard@redhat.com>
 <20211116154920.87279-3-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dd4d7f9b-676c-a610-14ab-9444db645681@grimberg.me>
Date: Tue, 16 Nov 2021 18:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116154920.87279-3-mlombard@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_082353_977493_C09DAA8A 
X-CRM114-Status: UNSURE (   8.57  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

