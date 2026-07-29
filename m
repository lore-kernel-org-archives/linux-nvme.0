Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7D0C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=; b=jnLRjnO+gJUjOODQwLi7TfXmQQ
	SGwPUq5K/U6VKVmWkn51bXPmr0hdetjIy+QAVgiXhDqXkxoy1icnDVvmwxf2tVUUM49E3FX67O9uc
	ltkmLUGQCaFLP2vczIRjhVA+amTvyH0g4iwkDTS5vGI1I2XbQoUHBurU3DxcPkY+XUksgOrza8kVI
	6ypSvEqzN9RsPTyADqGooCN48VejyeoS3tI3OT90p7T13QtPtwtxbaPBgVbBy4IbHTDrbBw+mz7RT
	KLKaqYywBXV0LkjdXyxKvPI8CK+gFW/XovTWmqOdnAqiq9ooZzx8v6maOJ37R9f8RB0NcX5hWsyEt
	KayXl7uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2Vf-00000007jAf-0pO4;
	Wed, 29 Jul 2026 11:31:39 +0000
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2So-00000007ioc-149b
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:28:43 +0000
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so109781366b.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 04:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785324520; x=1785929320; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
        b=ohzhluxzevx/eZZwKndgQpjSlD23aQbqKVpGmXFgUF+E+vVWBrsx+NB9hsCv70xBrU
         Floyd5UeccLSK5tvpOfVUo1XyFLIbmjyJUwoRoaBErvSs1Ic3FOa8rWgugEFxFaZwSDr
         jsfxR+dnUMiTEK828TcTmFtVKkHGrjx0POo4y6DqCR6Wg9UOFR0nrmbwbZI6tLi77cyZ
         We/soEKHK7VQARcbmZPHQFeAxHJFfWQ4etiwU3YIDMEqf/75mEPnzjqnzbp4X/VGE7OF
         8v7pE0/vG3glCMW/efd8uPYBrGF3w1qDND9Iyb+LVst1lkpk0sCBclBVkYyNatNAY4y3
         G/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785324520; x=1785929320;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDeRfN9blSLpZUyGDvy3JYR8gWm0jeyVXT2Ay7oVK6c=;
        b=TR1fMNM8NBhkzLMesfm3BEQyDvZ1sDiqoQg/2hOCTb0Y8vsQMIQydIgHKtjuOAuujF
         CiJc2MpBIL7BrAd0yHczU/NBtgjBx1A2hxivGX776QwnO+R23XmsVtIVmPgQJHlUFZav
         yI5ytSyTJFCYPv+Iap1glIsS1AJhMqKn1UpNF0ptOuw+g6+4yFNG5diAdABid7OwYhTT
         RO0omoDyl8EgQEfvcxcSYZYalrOEoC36NikJ0NIzZF2RJddPRB99Io4HvDhlhuVkdJcZ
         YnZyQOX4VYHHIdhOQVWoCsMvqb61rodPzit8OZfAFN/VlQGXTBo8fcsWYKcHhlftD8Lv
         ZHkQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjB0mljtnNq8ZU56DQ2bdaxyTS2ys7pxn6+5irBEd+gvrpdh1p6ZTrWsrfIuLi4pLEZi7ftAL9Uvqu@lists.infradead.org
X-Gm-Message-State: AOJu0YxJP0rSpmMhR0pwjUvSjB8XyllHJR+n3NNI5Hs6cSshIE1LtjJG
	4bESE6TmSlBmrejpnwK23NIJL2Hke/Rg1c3cTf+GuxzLskCBOt9vDVZ/
X-Gm-Gg: AR+sD11WUPsiEE38qqCy1CSXQ2oztpHM8CELW8FvxKRwG82Vxi+5U/F5wIOhFf366vK
	bvlSxYenWWCMNEUUJFpK1vsO77bAE9PvCpEJtTyLq46nIBbuxfPEiaz8mwHBwbSWVxeGlFcXyL9
	GCTp7P74wyTMBh9gUVwhk4LBAZUH8fQzC48GjYCuJYA9jk3F29+wmLpxkP64KSG5hMniILT7i0W
	mQPa8Luyn8NKz6NuTY6cYhuWhWGK6w2N+tkC0v/g+6eYvgai6tAA/chgF+DQ63KTly+kQrv/0l1
	xHQ1vq2/SqMxEWkfFvh6kSsHNHkw2EZ16hc0rUi8NvnSuJ+pieGH3Rel35hPPPinh2yWyAxrgv4
	eEwFrowTfrraC/qoXf6dRlTXslBEo0aY6S4yJvsAKkWTphCyNzaY/9vPmTvhdLoseBcnedYJ5ih
	4Gs/jAjpgQ1NHM+Ov4mF4Y5Q8Z7zqJ2YxASjwWbwRU1LOMU0XAdUs8QsguMNuz2nxdyhnz3yMfS
	g6SWLsDkUBHoEraAQNM6BbtujB73ecGoKtNnwIL17p1yrcabMczMZhKqC9NbUNPRJBSqRzUW3iY
	S7F9
X-Received: by 2002:a17:907:842:b0:c16:5b3f:52e0 with SMTP id a640c23a62f3a-c1f72147104mr346195966b.38.1785324520387;
        Wed, 29 Jul 2026 04:28:40 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83cea5f8sm100629666b.24.2026.07.29.04.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:28:39 -0700 (PDT)
Message-ID: <872e7a5e-011e-4415-98dc-96c9066b0614@gmail.com>
Date: Wed, 29 Jul 2026 12:28:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] Add dmabuf read/write via io_uring
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <20260729065421.GA9468@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065421.GA9468@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_042842_332071_18EEF736 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:31:38 -0700
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

On 7/29/26 07:54, Christoph Hellwig wrote:
> Might help to say this applies to Jens' for-next branch for those trying
> to apply the patches..

Ah yes, and there is a branch as well:
git: https://github.com/isilence/linux.git rw-dmabuf-v4
url: https://github.com/isilence/linux/tree/rw-dmabuf-v4

-- 
Pavel Begunkov


