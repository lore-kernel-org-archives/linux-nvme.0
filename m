Return-Path: <SRS0=jIqL=PN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C06C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 07:21:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE0A260724
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 07:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE0A260724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hSzklK57AoABHuaOpS4+dDI6d2+9ts3pkvota0sJ30E=; b=wlRVFEVtZBvgDkVpoiIG6nFqhN
	AhUcA+hfIoeD9rrROrVduy650hX2X9tmMiUp53vb913svsMZcSc1V76fYNEFamsRPa+Cj3Hq1CcB1
	8tDOyy+3S5oM7dwey5ehvCCt5X1mcaK7iM6TJiAxlBU76JV+LS8FoMqoFyzKkrhLI0Zgp3I+vwrCp
	Cy0CiK2bEA1QcBmsXHzWq2iyHFUTbB7AJlZdq64R9Q3U9QAhONo6pxF/qK3pW9Y6kqh11EIWihF8c
	IfdCa7HJFaIBQ/dcz6TKL6ghhV5iys+8QDnWYbMSyIt8lLFJUO3aeeLcyfUjpsq/8TVkyCx2JHcaN
	b4yJcesQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1meuIk-00FaYa-EO; Mon, 25 Oct 2021 07:21:46 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1meuFu-00FZQ6-Ma
 for linux-nvme@lists.infradead.org; Mon, 25 Oct 2021 07:18:51 +0000
Received: by mail-wm1-f42.google.com with SMTP id y78so4426133wmc.0
 for <linux-nvme@lists.infradead.org>; Mon, 25 Oct 2021 00:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hSzklK57AoABHuaOpS4+dDI6d2+9ts3pkvota0sJ30E=;
 b=q3vXW663gWFkTxAeB6dcIpcR8fJGwiAskpKBTGHPTm69ye4/siv3JtVw1xhMEfXuB3
 cAKAOZ1rQtL6wRXqxY9BGB7zdTDtnOfsTMqpGReephamEt2oxuP2CabkdsKBS2l9GbVp
 ybJCZbHhueQV8/LCgy+lNXDktDLzJ3oOMdSm4oF7GxTM98W1WojMUKa7jxtOdn33MAV4
 yED0IxQ7+plPxdu0SpTwytyBiWl7cD5aUtVuScs+XBSRcwUN8RkdEX9JgC1eAkrH76nt
 sLw98UEo69rxKhxBJtlpazH9dbJNQl4xRqvJPpg1AlCbvEftwrbBkDNj80S28IxQiugL
 LtAA==
X-Gm-Message-State: AOAM531FCmHiSFBlPwXkjWHI5Alr+QKQwCLnIJk6rvzxo7C2Doc2Qs+w
 iMSetSdt4oF8CX+/i6ccUtU=
X-Google-Smtp-Source: ABdhPJy768LF0q6jQS1tKF9ptH98NOtok+0zG1lrPOQ2Jx/XK13suws9arq34AAbEibyt+c6YVr/cg==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr18371938wmc.117.1635146319331; 
 Mon, 25 Oct 2021 00:18:39 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id q1sm7894200wmj.20.2021.10.25.00.18.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 00:18:38 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: Fix H2CData PDU send accounting (again)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20211024074331.546635-1-sagi@grimberg.me>
Message-ID: <f50b529f-d2c5-d654-4e3e-2977ce6d80e2@grimberg.me>
Date: Mon, 25 Oct 2021 10:18:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211024074331.546635-1-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_001850_790595_636B57E8 
X-CRM114-Status: GOOD (  14.76  )
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


> We should not access request members after the last send, even to
> determine if indeed it was the last data payload send. The reason is
> that a completion could have arrived and trigger a new execution of the
> request which overridden these members. This was fixed by commit
> 825619b09ad3 ("nvme-tcp: fix possible use-after-completion").
> 
> Commit e371af033c56 broke that assumption again to address cases where
> multiple r2t pdus are sent per request. To fix it, we need to record the
> request data_sent and data_len and after the payload network send we
> reference these counters to determine weather we should advance the
> request iterator.

Keith, can I get a reviewed/tested tag here?

