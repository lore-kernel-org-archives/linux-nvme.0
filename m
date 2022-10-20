Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE1CC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SyO494wCUmFewuU2KAAQdpYIMm
	PaNbeljde5KqpVMcuYEwLVNYdSxdw9c2bbS3jSr5O98zMPu62U7BsNBGaPq7XS8MIcGuwpwVkMbIT
	KIUdoPFSHXeIIZhyx1dwe5YIZEp2NS2QQjIsrYyFOfig6iETj5G08CMSWmM7RAaZWwzMnzAYraFWv
	+LCKCEZtWe1yJejqd/BkJ/Jle8V3BYG8bat1jHToQNZllwtOTMGX552NzQNVsHd0r2jGPbIHkeuLM
	ULKivNzL3t9TfyDuhc1KfsJ3xnqfLTw2hJNTOwK6WzIAH6LsWjRDLM3Dr/oOhY8ZYEIh4A84gWF/3
	+qVcFyng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVky-00FZqe-Nj; Thu, 20 Oct 2022 13:38:45 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVWs-00FQ3B-AX
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:24:11 +0000
Received: by mail-wr1-f41.google.com with SMTP id i9so1246771wrv.5
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=D368AwNl5NORSEwqEg/j/TQREdBI/E2QGPWzHaQkceqqvVXuASlOC0IC5YqTPBfvB8
         1DDnwo2hLc9oW/YifbpMpgCSpWUoNWLE7VvME/1pT0gy2LticiHkt0art0HhWOV8UcCX
         u7O/0SD9IdFlo6qWD6QDcyuapaKtWUa7HDsUjfkbBAEkOD8OsJzHkeMOV1VDBv0qGcns
         9chmAELRX2djSBLC0zY5SwgEEUg7dQk33Bja5lVT7KJ/unAm8LWBLytl1Q+bYXTJ/JYK
         A0rr/NG4iQ+buSpGPGphEfA5s3OGDf7dpZ8L8Lk796/Vq4HMNXQW/qIUAjpYuDhCe+Tw
         jz1w==
X-Gm-Message-State: ACrzQf31Htxd6e6hFMZU4fj/ZbOefvtoS0G8Qf3TcQ+8KusteNqZEbv9
	K2QNJ9IJFXtdBLa9c1RJoHY=
X-Google-Smtp-Source: AMsMyM6vCHLOWdD5kqeG88pAa+uEXrOEs4c+aTaQ5X1pHElL6Ce80NDJ8CsQt4gbVe3hukUiqMentw==
X-Received: by 2002:a05:6000:1842:b0:22e:7bbf:c75 with SMTP id c2-20020a056000184200b0022e7bbf0c75mr8643659wri.547.1666272248520;
        Thu, 20 Oct 2022 06:24:08 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x8-20020a5d6508000000b00228dff8d975sm16482207wru.109.2022.10.20.06.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:24:07 -0700 (PDT)
Message-ID: <813712d8-af9e-3b44-55be-e6496310e8f5@grimberg.me>
Date: Thu, 20 Oct 2022 16:24:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_062410_408214_1FB88F8D 
X-CRM114-Status: UNSURE (   6.93  )
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

