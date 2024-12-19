Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5403AE77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 10:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T98mqp2bW2iDbPQ1pjYih/rvPbjnw2C5T7MaMia1oug=; b=oUdt39Rn4qdiFG0TygrBLYkHrW
	0cQwtz+plwxR0GKZIB+h/wRad/HS8yWj3q7+z3dvqzrc3QG4FvV/UoXVivHa8c/a2FGp83v1Z0osy
	eo7eAbS8KYzKZ5rgG2byNglBtBh2yiXquLFjq5dLlJhzHRg34ABR45xL5hnLIzNk6C1GGHGW1IUJF
	uDvPytU9LMcCJDeSRoZYJXX6XgcVvB8SwLhAutNxbgFHILNydx7wlxsfDeQJesTBxRl7XKydSgggV
	VckC231t2i8TK1as4ELW5lGG/mGmBwj9+5k1Bj9k8ZheBxGb7gnsvlvzrumR4wWCRBMO77aUnV0fN
	sLgeVizw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tODSs-00000001VHW-0kn6;
	Thu, 19 Dec 2024 10:09:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tODSq-00000001VGk-2uZx
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 10:09:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734602942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T98mqp2bW2iDbPQ1pjYih/rvPbjnw2C5T7MaMia1oug=;
	b=XVOeWAZeQDZvLOGUIZg8gP+LaHl4CCmLozl2WoL98OmOKp19QoWX1frVh+Qb9Tp8rIwNc8
	lmiIhIjEKHXbZnUArbokYHnhc09kuHObMWr5/zLJIx+AycgDh0k/e56Olze7GYIwh+eDbr
	tMXX+ABD5OK4lxN5uIs4CS/mZKiM3OI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-mjAlrQdxP5aHQrlEi4BYdA-1; Thu, 19 Dec 2024 05:09:01 -0500
X-MC-Unique: mjAlrQdxP5aHQrlEi4BYdA-1
X-Mimecast-MFC-AGG-ID: mjAlrQdxP5aHQrlEi4BYdA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43631d8d9c7so3463725e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Dec 2024 02:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734602940; x=1735207740;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T98mqp2bW2iDbPQ1pjYih/rvPbjnw2C5T7MaMia1oug=;
        b=h7ptPvXrCvgcC1eeDLK6TM3XsGz22iudigxNTFKhuG1if8Pjb/DYSiisl3ivXustcH
         IcH5KQIJmjhF1PZZgvk4iUgoAHtLv4wCi0fMQ0Ko4U6LoCt12K2mCg9CWzGDVd9vPwpz
         c4/a8O+k1WDJKz/cTcHKxqHQrHjlXsN0ShlZlBsZCt2XKBV/6jaRPwxhc+fWUTbKyMgf
         aVtgXAgfezHSSI0ROSebtHSYNWBXHD3j5CV4W2Ud94Q2uaBZbNRe41FkvS0+dAjX0Ar1
         FkJR/vXGBEry9kTuInJzszTlTdbEzqufrM6/lCna1Z5iXJYRa6bcQKAeIBNM9y0ELyWn
         82Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXyvYsHckrXX6N2cEjcT5XU1kGhvklNXRQEn7/C491VrPZUVnq8xu4XUEQfWrib6WCoBa+z+y4b6YQ4@lists.infradead.org
X-Gm-Message-State: AOJu0YzUQ4XVRvh+Yd/0ihsvxjION5O1RHrXr6qQiQxul36IOsIHQgwL
	CeunE4YxkvM0bm9q7UKQNFPmsZKW5eCpM+9Jscj4RowctpvRLkFx58ChGkzypNEUZPYAEpV3VAQ
	pkJUBVdhaAqhrHqY5Uth+QqGpS8Yx9ThCQ5Fn1yUMxwgiHHtTtc8LjbEyrBYTBAYZ
X-Gm-Gg: ASbGnctomgb0q0hbGdqp1YU1dydMmMJ6QWvp3oz3k0YZShx0wIXYzwaRVQ+OWnIerce
	Zu0twq5Nx4ACYWpwRj9In1/YA4Gt3XpT3CdgHIRXymdAFACuXmsEyYNJjLp/W0NSZZWSG9qBPgk
	EMtFdmOV/GA6BF+PBocdfYGwJ9VwRMQsmBUOFzFQEEKXFBn/vZq8cntxqHMMywl+XzdviLCpbc2
	6x5Dt68/OGRCjrDaF1o+ZKrnlx/2FOS8gBcCwHwFFLvbtpe7GjqkT2SWvpGvQ1Ad0OOlMr7a1e+
	YktFyrSWIQ==
X-Received: by 2002:a05:600c:6b6d:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-4365c77510bmr22352295e9.7.1734602940188;
        Thu, 19 Dec 2024 02:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGirXoXRQE0r5vB0TfkeqRe7MfB/RkGpoRNVbjNqtlwjyADuUYTSVPC9u5W6B0bBw1vsjY5kg==
X-Received: by 2002:a05:600c:6b6d:b0:436:51ff:25de with SMTP id 5b1f17b1804b1-4365c77510bmr22351795e9.7.1734602939835;
        Thu, 19 Dec 2024 02:08:59 -0800 (PST)
Received: from [192.168.88.24] (146-241-54-197.dyn.eolo.it. [146.241.54.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2d2sm1189392f8f.71.2024.12.19.02.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:08:59 -0800 (PST)
Message-ID: <badf281c-cccd-41be-9cd7-bf6637c981f0@redhat.com>
Date: Thu, 19 Dec 2024 11:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: core: Convert inet_addr_is_any() to
 sockaddr_storage
To: Kees Cook <kees@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Simon Horman <horms@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Mike Christie
 <michael.christie@oracle.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Maurizio Lombardi <mlombard@redhat.com>,
 Dmitry Bogdanov <d.bogdanov@yadro.com>,
 Mingzhe Zou <mingzhe.zou@easystack.cn>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, netdev@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20241217203447.it.588-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241217203447.it.588-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SgFMpPaqMMyb7WRFXD9oYwMLOWH5v78nQ9lvvHHanvk_1734602940
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_020904_813611_05B5AAF6 
X-CRM114-Status: GOOD (  10.51  )
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

On 12/17/24 21:34, Kees Cook wrote:
> All the callers of inet_addr_is_any() have a sockaddr_storage-backed
> sockaddr. Avoid casts and switch prototype to the actual object being
> used.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>

It looks like the target tree is the networking one. If so, could you
please re-submit including 'net-next' into the subj, so this goes trough
our CI?

Thanks!

Paolo


