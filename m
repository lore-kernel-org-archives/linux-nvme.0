Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAC1606A328
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SRcPeutY;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=ZRYIfVu3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=39gK+a8D3PLdfajH6qYcSlCJPVlME+ibj0o5GjMZDos=; b=SRcPeutYteQmZ1
	s+7ExK0pF+5PYSa4VNhsaYuIHct8TyE6q+GooRIJ9buyAX31MPSpMY0yfciXkoyXGVDx8ms2Lj3If
	2sMk9W6yTciDVjMS2Iv0zSMJtKhYGTp1rrZYiXm4c9MezBP1puDoM5GwBW93cF51l1+oQrDyqeQKn
	8Hut5NPOpR34djEZENjQkaX+iLvs30oitIqrDDjXBof4JPFKnqr62UcbnEELh0hrGvFrZeY5Q7W7f
	JN6Up5HNhsjbav99Uij0abuVnjnZpijNpMrRgaxG+bwfNB1dvJggGd3+WE6d36SC17uoTM3rB/ilh
	sI9hVana4bv8yWCkk4BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVvT-00000004dNw-0Yd0;
	Wed, 04 Nov 2026 08:00:55 +0000
Received: from mail-dl1-x1235.google.com ([2607:f8b0:4864:20::1235])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOVvQ-00000004dNN-2Cdi
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 08:00:53 +0000
Received: by mail-dl1-x1235.google.com with SMTP id a92af1059eb24-1b244fb7fffso640447c88.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 00:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793779251; x=1794384051; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=39gK+a8D3PLdfajH6qYcSlCJPVlME+ibj0o5GjMZDos=;
        b=ZRYIfVu32zkGT8+kL5RlfH4eyDL/8fXFiPZwjqMzuEP9tyDd+5iWLxHVya8XzgkjeG
         QBkLU9K0IHmqb6jHoj6a/C6sl1wYgNN0c1e9bGMXwI6CbunSOhyC8WuOGdf4P9/gtH7T
         IFRdFW+GO6P0zgqbROfBYtKxbUn19FEc5XaZlKZAVMSllDEQG3nE6S6q6K89p2oWe7Cp
         H5/u1aEnHy+5GAjhmnHsKjylTWFP+EUji81Wax+V6qb+n/FFOb0xXNU+HUibECoaq6ks
         /x2oVJnGigclB7dBh4r0lfe0GdWZ4gLz1yQ1FUU6/LKI66WGZ8TY4ganWkGPrKs9nQP2
         KWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779251; x=1794384051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=39gK+a8D3PLdfajH6qYcSlCJPVlME+ibj0o5GjMZDos=;
        b=Kq/CWVlcTIfVNN8pihF7Zk/S9159o3rP9C6i9ffTLghVSl7QvdUY527kzwnmBVeEDq
         XZjLrf2XZ86+agZExhk56f5l2sERunhxIqsFwpPbrsL4CNARRrXXXBSDBFjJrZmvnZ8w
         kLFnwOBt0KDGCNtdj+PwFcJdXZqMYcDVnxlRWICYKppP37eu1RnKAMMjzAUaliWJ0JOx
         t+l/8+Ds8tR1yuJoVRvs0kOIWQox94HKu07LM7ETm5YcqZgqPetoV+rKQA7TjYRLYNZ4
         Kqs8pb0ltJRv+GTTjqSd0HwINak0d1QkPYnyRUr6croMFqaL9hOrCXl0OLflBODGEY92
         URsw==
X-Forwarded-Encrypted: i=1; AKwUvBwnAUw0kjrKKArSOgpBZcX+wwVVls8zIZn6cK3eUUAmqLpDjx4NhiilgSJ5SjXi5d0BZviV+jBKUocQ@lists.infradead.org
X-Gm-Message-State: APuU4Z+mz6Jx8cQD7/sGTI67ny4fbevpULALOsDvqwRM1SfNT7xUvftF
	IU2kme8ThJh7t8GWJ29k47Fo8rZBwffuefFRh0ZIh+V6+T+VOqW1ky2s6U3eU9Ji6aA=
X-Gm-Gg: AYBFou1nn8M+PfswKLW+0Y2fgMmojDNNVtMtt8jFb9JTq+CCLw8eNTPE0Fh8rqemTSm
	QCg79xE/M0i+n2yiQva5UeLiYCKd06qMbeR5AAamEz9sKbDQptuoQBq9YC/8Y6wl/x4nhns4btG
	G6p3XXIikQT39AcRgZB6xqVjRbeejIy6Yau/S2dNvHN/NqxRTpLJWz1uuk2AuwrhKAjiTcfl7Je
	bp9+A9N7c6rER0rrvaAS0NY6qLa07qDU2jmXxxG8E/X31ncGlTLdesVCBlzX4+M/5PJZbS8GHw8
	WwJFSfksrlZ8aGyFivyOpHbincfARb3zy/lov/M70bo2H9wyAoFtoFURmhC+J7YYsfbvf0iEuLg
	qV+c7JTqgG9eR2E6ZJCMvsUisoj2JAVF1Sg5RR0KBnLKq/2+Rrhugk8Itcf+kDyqOKP6zzcm14r
	mSokJiC6RF9mTE3kEvcHZc6Or+RN8ZtY1ydzxeWZ6INqVfG2qaqf94DQJ0T2Ysu4aBdiVl1SXsb
	LYIBwNPKiAxGu1CfhPnPOSA+z367kU35NULMf0DU0rYj7xYemV0TrG/5Terx879qTgofcKkjNGs
	lSOd2HxpIalFIt9W1+tGfJabKYicTlGYT0yH6H3rvUmi6uQCzbpY4DoTRJsvpXL9KXxcIshD5Q=
	=
X-Received: by 2002:a05:701b:4583:20b0:1b2:4871:b1f7 with SMTP id a92af1059eb24-1b24871b239mr1578681c88.39.1793779250836;
        Wed, 04 Nov 2026 00:00:50 -0800 (PST)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([71.202.170.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c772fdsm6175875c88.22.2026.11.04.00.00.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 00:00:50 -0800 (PST)
From: Saravanan D <saravanand@crusoe.ai>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Saravanan D <saravanand@crusoe.ai>,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai
Subject: Re: [PATCH v6 1/2] nvme: add per-queue sysfs directories
Date: Wed,  4 Nov 2026 00:00:25 -0800
Message-ID: <20261104080035.95142-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <10c9db86-4313-4a1e-bec1-e4eb9ae32ef0@linux.ibm.com>
References: <20261023230426.6425-1-saravanand@crusoe.ai> <20261023230426.6425-2-saravanand@crusoe.ai> <10c9db86-4313-4a1e-bec1-e4eb9ae32ef0@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_000052_580029_A8ED69AE 
X-CRM114-Status: GOOD (  10.09  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 7:46 AM, Nilay Shroff wrote:
>> +	/* transports remove their queue directories before this point */
>> +	if (ctrl->queues_kobj) {
>> +		kobject_del(ctrl->queues_kobj);
>> +		kobject_put(ctrl->queues_kobj);
>> +		ctrl->queues_kobj = NULL;
>> +	}
>
> Can we have a helper something like nvme_queue_dir_destroy()
> and then call it here?

Sure, in v7 I will add nvme_queue_dir_destroy() next to
nvme_queue_dir_create() in sysfs.c and call it from
nvme_uninit_ctrl().

Thanks,
Saravanan D.

