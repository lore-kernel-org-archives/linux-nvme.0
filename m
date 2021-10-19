Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE273C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:28:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813AA60F02
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 12:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 813AA60F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AeJv62AFB5OWaSA9tX4NVguEMvt01zX7HrNJ3u8wEI=; b=Wl2TQBQcNd/Af1S/2JUwPn3KUs
	fbQVX9Ev4KMlzUWqwkzBUb5W9TLPVEItaEaRzl+HlT2QPLHNvFlB38PlWUNItp/8zns6rUxRMxYzY
	gBr2z2Kbg/IIKxp8tq+jSP3z3fa27Lc08/RB38G5BYzEG2wv2SfnhmrM89mvtbBCKV4Px5Iu6qtDc
	hfr+EZWzMbSPy012IZWafsEebJfRQrEuptpp8bkObWVK1V7J2+4jzm8SdOjhkZBCazvO2OnXVP0SL
	3sIqU1AwM+MuEmxMUrIK1hWY2QFYDxB4M0rL4Dqp4pJeN1vvGMaNOl+GROv2OjuFly0Opm96Px0Ds
	91aKtg4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcoDi-001BSs-7m; Tue, 19 Oct 2021 12:27:54 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mco4k-0017kn-Co
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 12:18:39 +0000
Received: by mail-wm1-f50.google.com with SMTP id g2so11714456wme.4
 for <linux-nvme@lists.infradead.org>; Tue, 19 Oct 2021 05:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1AeJv62AFB5OWaSA9tX4NVguEMvt01zX7HrNJ3u8wEI=;
 b=8OTjEwbsSrL6vPEzy1ndsR+Z8oO98aJKueGlbfj98b3zZCSFYFZ7w4QlEwNa41yFHn
 dKMeePngUX+e0prPF8hm3YppX29Vtp/YaaZnMrF0sfd5jFOVb+2ddPE3TCuOWfeqfgLp
 TVJw09G09oIeCJGSKYP7y1iDSveiyqblOhVczSem70z65JeWnQZtuNgZOEqSDa9EmhRK
 guLXBd8wxNCsynqYEEQ4NUPaGD3qh6v6Kqjgr5dsOJUSxRi9mu2bw06M3kYctszZRawl
 puzOpYSBUJ4+QQjIhyITdU5+diWPwzkxo6r01bU+63xVDVmV/oSDCk/WNtDlxli3V8r2
 EAeg==
X-Gm-Message-State: AOAM530FVZpvxWHKgOw19Ss+Ej+MPxy3Gw0azUEeBBONeXRC43gZ7+nR
 LyYOnDOLTCp5D8bA/ga6uuI=
X-Google-Smtp-Source: ABdhPJyzfFVEFW7Ke48n8PjX4lVC63udTIkd97BMKCdGUm4HYNUc4bYYaX/SnFYAjOtQsWRWdCSoug==
X-Received: by 2002:a05:600c:4fd1:: with SMTP id
 o17mr5748519wmq.110.1634645915593; 
 Tue, 19 Oct 2021 05:18:35 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n26sm416496wmi.16.2021.10.19.05.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 05:18:35 -0700 (PDT)
Subject: Re: [PATCH] nvmet_tcp: fix header digest verification
To: Amit Engel <amit.engel@dell.com>, linux-nvme@lists.infradead.org,
 hch@lst.de
References: <20211019113307.31852-1-amit.engel@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2f46c62b-a8c4-5d48-17c4-ac33dec8a318@grimberg.me>
Date: Tue, 19 Oct 2021 15:18:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019113307.31852-1-amit.engel@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211019_051838_488265_490EEF59 
X-CRM114-Status: GOOD (  20.22  )
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


> pass the correct length to nvmet_tcp_hdgst.
> when verify_hdgst, need to pass pdu header len.
> This fixes a wrong behaviour where
> header digest verification pass although digest is wrong

Amit, can you describe what you mean here?
what is wrong about the digest?

What is currently passed in len is queue->offset, which is
the temporary offset from the pdu, which is equal to hdr->hlen
because we verify the digest right after we finish reading the PDU
header.

> 
> Signed-off-by: Amit Engel <amit.engel@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 6eb0b3153477..954c27a94561 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -268,7 +268,7 @@ static int nvmet_tcp_verify_hdgst(struct nvmet_tcp_queue *queue,
>   	}
>   
>   	recv_digest = *(__le32 *)(pdu + hdr->hlen);
> -	nvmet_tcp_hdgst(queue->rcv_hash, pdu, len);
> +	nvmet_tcp_hdgst(queue->rcv_hash, pdu, hdr->hlen);

If at all, the caller should pass hdr->hlen and keep this generic.

