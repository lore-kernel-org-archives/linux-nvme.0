Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D64CEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Ub8xrXCJ7i5rH3Wo5e0L/AmX06
	Mi1STun2weayLARhocLu3G/oT1v34PkOXdEZ0+vejSQcmYAKhW6vAu4s/tDQ1LyK0jQcLxoVttdCA
	nmx61DosnZ8cfsQ0DfCA5m/FXZIs4EZbKD9VPPGSS7zv/5wdXUkmaLdAfqtQo3bq+wXrY7Xvdlotb
	AA55Gc/I+YUOxH7TPZuxukAd8S79ITojpbmojcEGAomO7yiLhu8EoIV7e26fLyi+fXo5HgcNwPyGr
	+xzNCWWml2YUw6nv9O/CRK6Mj4HPgfdic5gcVqdCDG1G6Bluy8ouzshKcMrB4HXMwiUlBZnhBAH3I
	RkcKKuHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5lU-007KZk-1K;
	Wed, 19 Jul 2023 11:54:44 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM5lS-007KYc-0x
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 11:54:43 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso11885125e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Jul 2023 04:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767679; x=1690372479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=QoqrTDoB1avJaMdqocIGFtAYO0OVe6u1WFcZxWa4I/QVQeFixbpv5+mowPUSfNSYTw
         JZEg/rvf4BDfY3tory7tlfxqk77HLl+0aEX8F2/XXR9fj8L1HarC74+SR1xzVjCABpom
         f8vyDMr3eJVoxmN3tedEvoqWyexoPmJ9oCfTijtfPYYbaMaTqDHZNYcIMYQ4FlJ4IQfY
         1WUlSNV/ficB1xxs5GiuzU9unz9HHu7gbLnK+wDIjmU/14fCe3quvqOIaYR22U0a33Y6
         uo4WSMcP1WGIkn1GPbX9ijZAy6PJMqL0DOfTx0posw5o8+6Qux8pnyNXSrW0rz36KK9l
         2uQg==
X-Gm-Message-State: ABy/qLa3vUS41Ip3v9MeR8h1mOEaVw+ENHwIR3AWUttWJdsTXYU5E0qL
	A84YLyXTK5eWIP9ynz622pQ=
X-Google-Smtp-Source: APBJJlFx8Nd2zlU9HdityaHbsCvPzRJ8CDYkz7ZT0B5SWlmZjncwynDWN9bPd9GX29OqJ7s1zk4sKw==
X-Received: by 2002:a05:600c:860f:b0:3fb:3dd9:89c with SMTP id ha15-20020a05600c860f00b003fb3dd9089cmr2154320wmb.0.1689767679449;
        Wed, 19 Jul 2023 04:54:39 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c028800b003fbc30825fbsm1498095wmk.39.2023.07.19.04.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:54:38 -0700 (PDT)
Message-ID: <9bbb2635-c4fd-884e-4cf4-0a01c3e29415@grimberg.me>
Date: Wed, 19 Jul 2023 14:54:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/6] net/tls: Use tcp_read_sock() instead of
 ops->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230719113836.68859-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_045442_342881_21C0897F 
X-CRM114-Status: UNSURE (   7.26  )
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

