Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE94C38142
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 09:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ogpdgBZRkWg8j/ujNol7kbdwKp
	Hn2ebSkh07fRzKUsAGerABTw1HE1NZ610P1TVDNWMkPVxBgzGh3jou82dD9a3BjN8BgkMQ6OVdKc/
	JV8iWwJHQHnVfiLqOna+tDOpSvEsqDy7cWZ9Do8yZC11eZ6oTcTVZtMW8evoe0p5hD1l2oP6DgDb4
	x2QUUow4DwruJU4AVNtsTru/4fgl/shEIFSGfOP4HbauiNucMJeOdBBFP2v8W+qXTnKJhTQM+jDE+
	wjHkAPF2PAYW0s2HY0QMR9l7JRJQATN9w5tweMf9YRyIKi+ep8WJAwmDLI1LCDPW5WTcNFh+F0tbg
	wyoUlD4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJspP-00GSdd-W1; Mon, 23 Jan 2023 09:09:24 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJspO-00GSd9-0v
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 09:09:23 +0000
Received: by mail-wm1-f49.google.com with SMTP id j17so8456279wms.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 01:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=FPNu0I5amSFdB3CFBYLWoXWcr3Vo4DYoWXsUOUmWjYqyB/KPSGF8A/8WHZ/o9yXUOy
         WxxdilLRRZo6B+OWAwzwvOVwDafXGXg0sqjuSk8C8uWncLRhG9l4tNgmyY1aLU1mFecc
         DOLbhyi4y6Qd77VJ2meoy2G9OcM5U1N8CipwYI9s4uyW+Q/9t42MzzFuBJzSZXhA2ASe
         QXGd4ESvQWCEwWBiCaKCk9RYiD0SRCiXMN1MxDs0k+udkm7JkPTusynNGf3IqqTTjpyc
         4ecovYxQLqM7mhpMkYgaU/f6MWxL0Ry6o9LJTUhvb9lQKTE3UJxCchXWWGqOx2o80IYM
         NT5g==
X-Gm-Message-State: AFqh2krF5c2bevcMSr+84IG0jiB4y9Xt7TUxAkDciru8tUiAo/Hb+DWq
	RSELdC4N41+I2PigbFpfjR4=
X-Google-Smtp-Source: AMrXdXtXvfFYIvhMVFr4PMzRko1dRrWc0YCC3tr9D9pouG7MfIGCOmvnpg43qegDE35rqKhZk8sddQ==
X-Received: by 2002:a05:600c:4928:b0:3d2:2043:9cb7 with SMTP id f40-20020a05600c492800b003d220439cb7mr23216336wmp.5.1674464960394;
        Mon, 23 Jan 2023 01:09:20 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003c6bbe910fdsm12998879wmo.9.2023.01.23.01.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:09:20 -0800 (PST)
Message-ID: <b5d8df2d-4aae-c3bb-815f-68dbb0165536@grimberg.me>
Date: Mon, 23 Jan 2023 11:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-fc: Fix initialization order
Content-Language: en-US
To: Ross Lagerwall <ross.lagerwall@citrix.com>, linux-nvme@lists.infradead.org
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org
References: <20230120174354.3437046-1-ross.lagerwall@citrix.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230120174354.3437046-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_010922_088862_28813C67 
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

