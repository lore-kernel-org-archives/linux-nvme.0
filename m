Return-Path: <SRS0=oQz2=O3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD7CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Oct 2021 08:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0436161076
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Oct 2021 08:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0436161076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=iAKLegQ1z29fhZVsRelFX4bSCe
	DSW8NAgaBbbmYQOXMkrHDXXWKHvf+XpQQ61oA5KicYNCp5/ynEhU3tfH3uuo7ns2aI4WsH6uG4a7c
	nv3g7Fkdzy8a8tgUIxoOyShDM++5WnTy1vW91u8xshtTq039Hhras4SCzgZ6wGTkQrBC2VAByGPCM
	IU4h4H2YxSwnWG+Ka8f26QiwYe1HbLmyJuEEJP9MnMUkt/tWacN5I3h8MFlukG90Vx3gghDowe1o8
	oCNIbJBiZ4mKQpVVrsmCzFn6juVpxN6AYkmL7Y7dSOAnN/daihxob/9lm3Z/RA+JCmVgfBtvN3oya
	R6zYt5zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYOOO-00GUyT-J9; Thu, 07 Oct 2021 08:04:40 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYOOM-00GUxb-56
 for linux-nvme@lists.infradead.org; Thu, 07 Oct 2021 08:04:39 +0000
Received: by mail-ed1-f50.google.com with SMTP id x7so19112403edd.6
 for <linux-nvme@lists.infradead.org>; Thu, 07 Oct 2021 01:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=mMvRNkX9KZjI0xjkeDmFA680LIQNv5qh0mnDzrWzG1UbuWzGwlOLEcrw4do+57ZW1V
 m6HxJgdX5S9Mt+ANM15zdyXPxphlJbQIp4HbzCOaPDwkbuel37rWtDlnbUtM+K3sCsdJ
 uBeS2/53MbwxV9F2P31abwRtT7oDueGNKL7xHpQQ1rwcj5+Yz9pxp8oBqpzpfspA30Jr
 8KxxEMt70Do3uQ4R4E9ZWD6lShdGsvOtUtkzaq4RiqTdfpFi+G73Tcpx5gssy22mKKmE
 HwkZeLZn3kCBI4u2w863wxfeLSVA4592k3LQtf6xMihDViWPD8BJZ8hDTS+/5cmAGoLi
 chYw==
X-Gm-Message-State: AOAM532CdQY54FI+I8tvQdf7jOhO4vCyukwO/hZIPIzyIthYssN+p1av
 L4C9ERSJM2sExLkJJkRtk58=
X-Google-Smtp-Source: ABdhPJyXUyhpFJqAiB3qb6xNP+ODLu7rM0WLRgDeGUxa+z4RbuFsB2EmiAFSJthzJbOcm++fk+00HQ==
X-Received: by 2002:a17:906:4cc1:: with SMTP id
 q1mr3700090ejt.415.1633593875867; 
 Thu, 07 Oct 2021 01:04:35 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id z16sm818556edb.16.2021.10.07.01.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Oct 2021 01:04:35 -0700 (PDT)
Subject: Re: [PATCH] nvme-pci: Fix abort command id
To: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, hch@lst.de
References: <20211007065436.629383-1-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <173def42-2505-b788-93ed-1c5869f83a26@grimberg.me>
Date: Thu, 7 Oct 2021 11:04:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007065436.629383-1-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211007_010438_232072_FD596A82 
X-CRM114-Status: UNSURE (   8.36  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
