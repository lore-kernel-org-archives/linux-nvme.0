Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5338EC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29YldXHZZWIENyZLJKA3m9s10qkAwfthBjQ5H8hR+OE=; b=NqsGqBS3UsjxJ9WvLHgHQCQgIK
	RIv6DMaFLxaJbMMAcQNGTrdbmqbKPmwPDw2CdypudMk7kBpUfbE9XE87HwO4y+yxnSkXKghCWWGz9
	Vz1zcDOeUj0OV1KMEVvIMPxASzHjFAk9q2wXExJND7q2gMjbsFwavR7zHb64kh8qz9jey/6+MZYd/
	cd940EDRlbQOjGXu3FAnzlC4AeNyt6eZAv4QDuL8pzYxcRH3zE5w+JLO9Mg9xAszCdfl5/rWk7+Tt
	0KA7WRXwIWWvBNJPxlLc2bF0Uypg1ci92JnBcDohaM7NYtzObD2iLF+88x/bnDdjOZzZ5ixHJPDpg
	0XtL/0Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMSa-000000051ve-3Wfd;
	Wed, 26 Feb 2025 18:48:44 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnMSZ-000000051ub-1FFx
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:48:44 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-8553e7d9459so2613939f.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740595722; x=1741200522; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29YldXHZZWIENyZLJKA3m9s10qkAwfthBjQ5H8hR+OE=;
        b=EcuI7apyc1PYax9xxJ2i1nQ6KzSO/CePkxsKkEm3yqXGLzqe6o/vHARtgk7Ni7uFUx
         veOiFVz4wQq9y3Zo8t33uzJW7w5ctKZJzJwEim22Mm6TtYY6VdGkS+IC/9OFw27SaBb6
         1Jmk2EPUXf8LUCLLQd/uCSykzW8Tv4utl2d5UlnvkH+GBj3PU49Kf9si4c3BBxDxsomd
         Cu3uMTUko3cMCQc+nH8nntcu+jMlgSmcdyXQ7eMNzi9vfeRT20/7ivohzCaKqTV3/xdn
         O9KS1Pf269TFNIBd8DEHaUg8KGerfVdyah5+UWlhCVslKFy90PCZ0jnZ0HhABowbAZbG
         1X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740595722; x=1741200522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29YldXHZZWIENyZLJKA3m9s10qkAwfthBjQ5H8hR+OE=;
        b=xUfA2ATSkky8msw/414KIFDQXHc5jWIbP0nho19ijv5BRQCiB4EhVIn6sjqv3P2a7d
         XFUCCNsK1/QlivquFqEssph6qAVahvM7TrwBpAqJBcwxDItl4+Hmg70rW/tF8hjNSNd0
         tYtPOdN7BBWlYlnJHHxh5CvNxCHUOu+gI8Fi6X0bozHgay22YCugUnYynX1lxtcY7s2P
         i7BtC8BYTp+j4tx2KIRkuKqxwWuj/8E3Z5WzQ7djl5NHtcqAh34rPD8xPYHWf9UiFvgh
         CGfwws/M8/6MdR5dyvUDXJ14rIIpde8iPogzkzqORClfPHg6uL1t/zLCkKZaN0qsIw/A
         tTHg==
X-Forwarded-Encrypted: i=1; AJvYcCUEtv9lWerdz8HZvEUPvyoaLDzx13+nD0VxU1HWUDc78Epa+60zupc9PJTOG7BrqAzzhiHYGRrcNhBH@lists.infradead.org
X-Gm-Message-State: AOJu0YxHx2vod33tb2S4yTU/9kOpnma8TMOzv5Gj40FmkHQ8VX7tSJ5w
	phWaerWN7XJx4jo5NPBUzSsd58Hd7gr+IyDqqH8wFxCYdTZode9pC2mYseo8pLg=
X-Gm-Gg: ASbGncsTqkSH3wx3jg+5gi65Y61a+FHl8/HyrCgxm0NDTTx2R9Z4H1YY4buIYGelC8b
	UBFjMll69vcFjuQvZJk/2Zj3UKOqMPxGEec+hPJnpv7l/SQ6wV2q6oV7vGYMmgkDKyWUbI2rVHF
	NVUWVyetHXxJcPANSGUzDCUEgJuB0kmLkOw0E9UlALJVU4dsqv0JA/p+s0Xmkh/HxK5wtzVa3fw
	526UVt23tABhTJPvWGOD8EttFyUJq/5jd5yAmP8ZChUgdMeca7U42iB/2f7UQhDQenOi5RKdSc5
	Cf5U93PPWTQsPeNMga24dw==
X-Google-Smtp-Source: AGHT+IHf9KJaHriQv0Q3uxkEzFWxGYsTVqpO/qA/s9OvhP8CyXCH/BuNYJCZKyKUkYKaJLxbKZdjlg==
X-Received: by 2002:a05:6e02:1a6e:b0:3d3:d067:73ec with SMTP id e9e14a558f8ab-3d3d1f4ea2cmr38736525ab.11.1740595721727;
        Wed, 26 Feb 2025 10:48:41 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d3cffbaa16sm7134915ab.6.2025.02.26.10.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 10:48:41 -0800 (PST)
Message-ID: <e19190d0-fb60-45c0-aa3e-7d0b61e133ca@kernel.dk>
Date: Wed, 26 Feb 2025 11:48:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250226182102.2631321-7-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_104843_341779_93BA6AD8 
X-CRM114-Status: UNSURE (   8.70  )
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

On 2/26/25 11:21 AM, Keith Busch wrote:
> @@ -789,7 +856,7 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>  	}
>  done:
>  	if (ret) {
> -		kvfree(imu);
> +		io_free_imu(ctx, imu);
>  		if (node)
>  			io_put_rsrc_node(ctx, node);
>  		node = ERR_PTR(ret);

'imu' can be NULL here in the error path, which this is. That was fine
before with kvfree(), but it'll bomb now. Best fix is probably just to
check for non-NULL before calling io_free_imu(), as other paths should
be fine.

-- 
Jens Axboe

