Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDE7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rxobdDFe7H48cWIc9kZYwY8LeoCUJYDbphL1kQLLxow=; b=cgYBYO2qaEpomxRjqW0Vl1zuJr
	ZUDFQSMOhHNfeCeq79XdX+mLtityxIRps9zC+H4tMp3Ewq7khuDLspUyKbIC8SNGxAWLJytjtXxgX
	dxunqTCBljB/pBIzsNbKbIm9fTC294Ge6bCjRUCrWIKMWKiT+z+2j3bQcVjuSSXj09PIJ3xI/yIW1
	Z7q/AZAVBXmHGgICaTK1pmlTnQcofGsaYD9kOhOl5g6oPje8XOoyDAf2ua0/7lnycWBQOLdyfPN4M
	bBVrdRfwLx+WrWNklfS8AFJW8almjia8lvTfFQwrSz+bb1dIsx6kxMGt3WXR8rpqIxOwStNHdKnG+
	xCdE67Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7nK-00G8wU-5k; Mon, 22 Nov 2021 11:47:34 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6p3-00Fu72-Pa
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:45:19 +0000
Received: by mail-wm1-f41.google.com with SMTP id i12so14842855wmq.4
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 02:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rxobdDFe7H48cWIc9kZYwY8LeoCUJYDbphL1kQLLxow=;
 b=ALR+cJ2COaSEBI5WEdurDRnZOkZiORRoppxQYKoztxyc3hNZszIHfwMCpINaTafiGg
 6dyXM3G18iOjVMwc2lHaG6lnCJCgetQiKAyjTJsAr9vyA4FHcv0GVGMJfy0VMvTNxm2U
 YF59Orz9YMh5hAvYmSNvyYq0vtludjqRYbPlrhw0YX7IoKqcI6OldeHYA/3hHJOGQwv1
 QmL7MWDw6hl/MY2QEu/zVv6RaRhkAKwd3wnZG2nm9kxLwaEngra6ThXIOod/bXdxh6Kw
 xfbwAaGUeieUfhUGLLX7eGBPqi4yKkNJdXuNn6orOKbqRagy188Qpu915o0HNjmkHgnF
 EnYQ==
X-Gm-Message-State: AOAM533aYjHXFSCXqsjVCLMgqtqnLfvK6hgxppVt8IbNOCdWPuSMdfAA
 j3g4wxuu2IYmnKny5veqDYXXMldnDmQ=
X-Google-Smtp-Source: ABdhPJw3NJ1gwaApHNIG/oakibszCztwJQhpV88Q11DUA1hmlVLvM4pPXPla3T64JSBtuIuw2RBWnQ==
X-Received: by 2002:a05:600c:4f55:: with SMTP id
 m21mr28912242wmq.68.1637577915529; 
 Mon, 22 Nov 2021 02:45:15 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k8sm8353840wrn.91.2021.11.22.02.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 02:45:15 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1637575953-3143-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <76c6cd6b-8846-a9c9-d0b7-00405fe63740@grimberg.me>
Date: Mon, 22 Nov 2021 12:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637575953-3143-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_024517_892501_5A08F4A4 
X-CRM114-Status: GOOD (  10.88  )
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


> @@ -2321,6 +2327,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>   	req->data_sent = 0;
>   	req->pdu_len = 0;
>   	req->pdu_sent = 0;
> +	req->h2cdata_left = 0;
> +	req->h2cdata_offset = 0;
> +	req->h2cdata_ttag = 0;

This doesn't hurt anything, but it also redundant AFAICT no? these are
only referenced in nvme_tcp_setup_h2c_data_pdu which is called from
nvme_tcp_handle_r2t, which is setting these right before the call...

