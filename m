Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C7CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=pzhQuCo2zlinm3IlZzvaexI8wl
	8NgyN8Q9BrZgfevqQkQiClthsKYGVwdgzfURe7xaccpJBPYCZUrSZGg++SwPYiVjLiOOghp2CTOLz
	jr//wQtirQrc5HUhx+lptOZx5WLsvBAw/Ky5EUFyOqlO+bQDLkpqdfM0YgzaXHNASXrQYRrwGk+IT
	rMrDXefA55T+vuw9z6GbyL3N8neYO87SXUcSpM9V6hpg569cNRGysb3wK8qscWnAzMb5IEhQoKN15
	7NaOZVWvncJNEXmrszkjXg+fCPjA8pYOt9khLtvaOItSQIkHGOEw2qHqq8di8vhl9clfnkbWvwx0v
	zmOaA3Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7dF-00G5at-H0; Mon, 22 Nov 2021 11:37:09 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6UL-00FpXk-6N
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:23:54 +0000
Received: by mail-wm1-f54.google.com with SMTP id o29so14772530wms.2
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 02:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=szwsh8WcJgfX42b0JoEgogrw1X5GT/mCRiXXkVWk3jdmpaqAQrG3ubXt2n9F40vK+a
 SfMj5E/CidEWq0OqWbCzDjFvg+noCrj9DzjJH6LzDtAJVENFzZiXrRue+1OfTuk/0v+x
 vCtc+CkG7kWW8FYZ/92XFGm+oIv9VnhlctqlkWcY9dr4CYEGlqcFYF5XwB1v0IRYNvSe
 FdN4ilK5S73PLyo1OdamcDIW7a7ZsabPV96rGqjw+wyK5uAtsAb9y1HxNzDPZ8zIH7Op
 CYhrbfGkkY5p9NncoXe87QOYkK5U2JDGWI5CjeWIIFWpXhN9P+/UaNfOkfBqM8DWARAR
 MxWA==
X-Gm-Message-State: AOAM533nPsu71zwkvG0pN0DGZ9jZWysUZWudVS68PkGzokLF7A4SHIZx
 HomHy1tFF6S1d2kwzh5SP7Z52ojhuEE=
X-Google-Smtp-Source: ABdhPJyIAaoR4Sf3cKvdAfkYeoSGrXkkLeI53xtt0ekDj7OZoulY2gjch5AcBY/G7qFr1UYS87WieQ==
X-Received: by 2002:a05:600c:4f14:: with SMTP id
 l20mr26927315wmq.164.1637576631401; 
 Mon, 22 Nov 2021 02:23:51 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g6sm11313881wmq.36.2021.11.22.02.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 02:23:51 -0800 (PST)
Subject: Re: [PATCH] nvmet-tcp: fix incomplete data digest send
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1637575721-3055-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <64702d68-4b66-37be-19ba-f687263c243c@grimberg.me>
Date: Mon, 22 Nov 2021 12:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637575721-3055-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_022353_269765_A20F2354 
X-CRM114-Status: UNSURE (   8.05  )
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

