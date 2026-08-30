Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D04C61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 20:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KmLzyV84dzWhrJJeEdTSWS26R8
	ZEaHEejxd8XnRJ8xo9TPE12Nsw/vYmzAnbhbBHwak1uPaQN0ZpVh5r13DU49Elc17YjbTXP1mAtRd
	zilvaMy/DPRn/d9rWGKwW4BnD6ExZ0L6RSvEb3KqgfGM24pJPIj/u/aE+VhofcyTgq2QsgmOQUfo5
	y1r1o0FoSfdZjQBf1OLvx+Zw6bWfomK9ubigwXf1p1MucMGFij33bioucW/2Nf3dpLMeitMkt87fw
	7cXEeF0tUhIpSnlYBZMErTT3hGPMKVynSqRnRhv4FSZqtwmE8ug42NWLFbVBhH9R86/QFsnpwTis8
	WI29I2qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mXD-000000085OW-3qX7;
	Sun, 30 Aug 2026 20:53:47 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0mXB-000000085O0-1HXU
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 20:53:46 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so26517915e9.1
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 13:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123222; x=1788728022;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Yo+m8ApX+tYXeyyix6IjfWFp/LPjHlj/guHKfAzDfx5XG5EIpyApc8WwnpxozmCOgp
         aeCfImi/VTT9m4iSialQsgHFqrhJXUkFB8/0z1i72vD5JEDdAtimYXEPe27PO+GPuEqe
         dJGYNDwt/Ymj7VNQHL2mxt9MketVnRgkIhC4hrWZSilHghMQwxbSvHofOpbZ4B937nXM
         qbiXxT2lLvvdUFkvg+4dgapZy3lVPG0udzSn0e6TYJOZRJ0DjEWml7i6vpLEbZCMx9LQ
         raItGp0mhNa8BboVCZLky8r7muUasE1MSOgQ0yvRBsjk9PCWFCGlmYcRn9CYvf8MFisq
         J1hA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3cUv3TukAB6jT41zFIUdMi8L3KvVInuA0FHhoFYPPYbffks+NEHyOWLh+IUE+jsLyCuVdQLjwh6Wj@lists.infradead.org
X-Gm-Message-State: AFuF++lIgyKP3G3/o4MzgZKQ01PSXJPxI3CjvTMLtobH0S6TBEkdotTr
	2D1FaqJfj8Ek6e//vLYcBzM2IFcw5YnxFyylQ8FEyiXv8ZaIOyhC0gl2ZKOJA5QH9+c=
X-Gm-Gg: AR+sD11BtdF8do4ziiiG6R1A50d0DCECSuJ3iDw+zCZ/p5tVnE6lbAv7UzvWayVwmc+
	qaOLjy953RnBZ7zCkLFzym+v8g5q8YIk/y2rSZ9+4r1Uzabg2Tq4k306nQPG2RPRM7l6w3sUMrO
	ytIOUBNHKkflsdqnR7dzAB3bfSmG8GQP20vb1gXLNSaJ2IP+qPpybW7Bl/PN6o6hNe5zdRW0DaT
	18MW18ypDCEPu15k8wjsi0W1ugcOK43JdwAJsmdhA9z3UY4kGrOjDRjRFo7KzGy/Jt/UgEDLVdJ
	dg+lsBfye1wUkvRCb11BsPZf1VY6qE+LZbSLVNGNF5yJE9uqS55NrFchfEKD8zF2uF9PdMiHXEw
	e2JH11xSRG4P0PcePImzioJlvVe+szMzJdTf9jW2pKqslAEd/seer9Qyjr0TAjVQgr/zLSS+gcW
	X0r+q9Yc0IU6rqN+YBO+0YiHHeje9INrx6eFyZnFfsV+GPTC5Y3HiEVHY7Qzu2PeN2bMmfTlDPf
	hsqR2Yc9BzZg16DEUapxQ==
X-Received: by 2002:a05:600c:1f8f:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49b91c44ec6mr295353325e9.11.1788123222310;
        Sun, 30 Aug 2026 13:53:42 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c9cf95sm179357275e9.1.2026.08.30.13.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 13:53:41 -0700 (PDT)
Message-ID: <e502dc95-d309-42d8-a154-6f9d1ef9a8ac@grimberg.me>
Date: Sun, 30 Aug 2026 23:53:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
To: Kazuki Hanai <hnkz.64@gmail.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kch@nvidia.com, axboe@kernel.dk,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260830131105.680566-1-hnkz.64@gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260830131105.680566-1-hnkz.64@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_135345_350881_686ED27C 
X-CRM114-Status: UNSURE (   4.33  )
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

