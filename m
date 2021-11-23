Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D72DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=QZIDUbDzVTCf4ot/anfwAUl7hv
	IYm0DdWkMcdpJ0iRy2tzSrgmhXM5RkZqI+Ib7+BlHT045JEoL+jd1cDAkzHhjWXOfSxF6+vJ9u9y/
	xElMD0e5cLYo96KzIUueCodquEZG7Q5LLI5ZQDcZRWJNtbOqxhpM7iOyUZZuPnPNh8N2NNanRekx3
	P/utmSoifX5ymaUHVAbRRsa32/xrDpzkINC4x6ATKhiSty+rsY4Iat1uimmJqVt5de/w8QRkUEPoe
	58GsHPqBfPLinwaTxO/nLVyqQKOZKJPc4tMTESfenPakXbTPgBG6FVqSdQR9zpX3Inx3ViAyCITdx
	Gob2EQbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpVet-002JnM-Q5; Tue, 23 Nov 2021 13:16:27 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpVIm-002DIY-Ox
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 12:53:38 +0000
Received: by mail-wr1-f49.google.com with SMTP id u1so38765601wru.13
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 04:53:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=jJj/+tgrXO/lBdgzqyQOUhZv2YsOIxhxIgWICzQmaBxfSdz27gzz2ursZ6fKJxmUOm
 pjZ7XhaAH25LBcRbY5vYma9sPf5xcAZIol64lNpQAUeGognW2uF0oqk1IveNpv22lyRd
 8LOjEBWkt2zAhzCRTgO5Rmw/1mgVV2UcCWNc1vd5AqOOJPzgbPSfwcxJ9+LjyiFIbtVL
 YCKrAIgzxRZWdkQ8tN3daDRP6a8NwEA5w8x5cin5QYW9jDKaCd2QjXPVAn1QOsa1fihZ
 wgwbgZvRV/T0tSaJf8tdPTUxpwVbHNGOmlrxcRIm6GLnCKzEPPyECpNcJOpbOdv4vROT
 QHSw==
X-Gm-Message-State: AOAM533iUfdPNq1vDaMJqd6CTxlxXK2ixErW85EHG4dQPDyOb4eiY5qG
 7+f61XSu0rkeCtBVvmCKSPosxa8zAkQ=
X-Google-Smtp-Source: ABdhPJyDkBrPZ3v9Zt+DnyojN9mwgT/0qSuHr1EdYeV8KHkFbgVdphtkFbC6n3+KrHW96+MJ/OgcrA==
X-Received: by 2002:a5d:5988:: with SMTP id n8mr7011061wri.309.1637672013590; 
 Tue, 23 Nov 2021 04:53:33 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y15sm13484137wry.72.2021.11.23.04.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 04:53:32 -0800 (PST)
Subject: Re: [PATCH v2 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1637665136-3563-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <588bb01a-89a8-8b87-aba3-6055675ee7b3@grimberg.me>
Date: Tue, 23 Nov 2021 14:53:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637665136-3563-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_045336_861791_596BE6D2 
X-CRM114-Status: UNSURE (   8.58  )
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

