Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD314C52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qBJ5nbSAfkss7Jmf0WGYAK+E54
	CqjLEgMb+aSaQFRKd0DBQmeXEYJ/E+9+c+9cLGPlUwCKbCVFA6i/DuDUfpX5EnwPCWk8C8DspmYUX
	aIBcZIfPyk3vD8a2kK8dG2rWO0kYDqmUG9TbpBtUfEkzU9/6l8dx7ZPAUBiDsYbuOQo5SqAGd6ALJ
	JVRVfswRSUnPCgLqqKrTv59CjGb45wXo0l/fHBeXifkZwGzUmP1Kc1bVjw8ANl6I3jcwuIfsmZhwX
	YxgBofG9c14w3Ai5qEjzaic5w/njLRykueOpfmWW+b3Snx/4viEgknWicRy4O20liybSYUju+4KP2
	s51ET+xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxU7-00000004n1j-1gqa;
	Tue, 13 Aug 2024 19:47:11 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdxU4-00000004n0o-2cNw
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 19:47:09 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4280921baa2so6885045e9.2
        for <linux-nvme@lists.infradead.org>; Tue, 13 Aug 2024 12:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723578426; x=1724183226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DdaSJCTX+cIyzenKld+oilaQpEf2HEI5CMswP/bBKCQpLHVoHKlAVIkeh3ahsXHvsV
         GsLrJU/g4NURlA7ZciQxUWYdUWsJO+x3NbYq8MBR2GBwvF1QWoN+PgkXk6jlWyIC1Dho
         S1ftes49JVUeidpfoD5WIM4mbBCDJQUd+i/xw2uKYv/Omp7XwkfK9kiopFsZs+l+SztE
         0KcyylnT0ytS/RdK8Prnhg3sPr+/e3KdOcHVEsbTv+yemsUOAbj90WTfRJyLYg3XCtA2
         0RrP/lzGX9xZ5r3TQhrTEw7TNXYiziOv2zjxwHtkCmOV2wVZffB060E+Bos2bUyYuHZ8
         B5jw==
X-Forwarded-Encrypted: i=1; AJvYcCWZH8pnOfnwkP12VbtysZ8fK5+REmOxztDzTuOQvfBP0mAZFy4nJvZtzz70uAKShjWSLuD9ulqZuQhA6l2ppUfBVioy77BogBn31SawSeI=
X-Gm-Message-State: AOJu0YxuEgkTy4Y96rs/LUrI2LVPIBZ3SnZJdwFhJLOEk9OUSeJuF4Tf
	xY80sJyYEPhSrI+atWi5q+YEew+WDtHwRTq9fBbYu7ru1PnTKOy0
X-Google-Smtp-Source: AGHT+IEOkM8UusNgFt3Ow+DJBfNIYzlBzvrLvR8A1vO6j2H2y+TrcvSIOkJamB8rdBfNFEXw4LvO6Q==
X-Received: by 2002:a05:600c:3b88:b0:425:73b8:cc5d with SMTP id 5b1f17b1804b1-429dd31fc89mr2093265e9.1.1723578425794;
        Tue, 13 Aug 2024 12:47:05 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.173.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429dea45445sm14165e9.6.2024.08.13.12.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:47:05 -0700 (PDT)
Message-ID: <a41d4e6e-84b5-4fd3-a220-4d9db859626d@grimberg.me>
Date: Tue, 13 Aug 2024 22:47:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] nvmet: add tls_concat and tls_key debugfs entries
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
References: <20240813111512.135634-1-hare@kernel.org>
 <20240813111512.135634-10-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240813111512.135634-10-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_124708_683268_D4C7393E 
X-CRM114-Status: UNSURE (   5.83  )
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

