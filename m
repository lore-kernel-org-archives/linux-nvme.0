Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B229C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sLDeLKPUoOShmf1w7pHGv7wy9rSrQDySNHUSOVnEJhk=; b=WllVa1SJAVDl1mYPnuOActX7tl
	261xzVdIGcAUNs/lBMHrsfIt2U1Ngv8YxZ+wSLyDUtS7iq2Kj+R91yJXABPefwi328SS+liRg4CSA
	yO2x4hyBoiUIOCjDZNQNl2KpV1qM3u8Rpl7aJ7OfXkqs3PRnOb1qTqXm5g5mQhNmKDEQ6YYsdjJ1i
	GOCT/akJKY+8GgaSpS7NYTyjwyWb6cpfqSDAC7fFRMXv/H+2g4QLhICp5YfWJDDx7dMpO2VcqSNcY
	ecAw2NNBHdA7HrDZPLNcJaUR/BWkCHBiSQxJT5LC73Njogpt7p3fUrfpZXQVI/AEy9+sMTO1sT+Qj
	cPdI4Mhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNLZ-00000005CLz-3xoY;
	Wed, 26 Feb 2025 19:45:33 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnNK2-00000005C1i-207t
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 19:43:59 +0000
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-852050432a8so7762539f.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 11:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740599037; x=1741203837; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sLDeLKPUoOShmf1w7pHGv7wy9rSrQDySNHUSOVnEJhk=;
        b=Sg8D9dlW9o8M8cMDSPS4yZFrTj38xpp806tMH1WUMWVo5hw7FpY46k3h2dEC0w1aXZ
         GdNcCYhmB0sUi1BOc/fRvXofvDRkLdib0MdOa0LMWeoXPgzYS9JEP8SgQX6TKN/ZUCnO
         9ATUUVsNNOXD7DWv4GXk66qkk5nR6byXo394MT2CzhLnRi5frQH4+KJirMYhd8g6qEAX
         Bvy1LLShJQ97YbIqgpGFysS+7J/GyKqLquzaNtn+OHc17RMfdByGX13p+TwnkCWW4bEz
         hirjiapevt24r56+0yU5mmRN+ByOinoD8jlU3vZroKVLdMKVRtfnOgHmY4ZyGuroB4Fz
         4Gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740599037; x=1741203837;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sLDeLKPUoOShmf1w7pHGv7wy9rSrQDySNHUSOVnEJhk=;
        b=gXUdlZy0CC55S1M9bGt+ux9pjcqiIqMKDbw9nheWrWLLnqbF3lYDr+coquwY8KbGue
         LXgkSxDXhR9y01+g+03lCFs9s37DQfAo7uj4TlMiovC/nLIeFbsM+VVc1O487/4taVUY
         8JaPs1Y+HsaKvxUn5a2Cz4doxYvSmTBmbwuTlYnoHGKRPiZ5ftvL6+3qJu86RnvYJJ/4
         f4YtAKZe9ANz/Q7nqV3SmxGzpX0ozdzaW9IAM3vpFPeJMXnzLFr71TAzbhehdT21FYhm
         W8JDUT4j2jTCjo2pVuJPQM03jxTEQ9O7N9y0CR1V3jl+3T8lXH0PEpkNNE3J9+S3qYPA
         0c3g==
X-Forwarded-Encrypted: i=1; AJvYcCXj9ZuwOwnwp2Ke935oFvfv+eMphZj90Xc3e77iNFEN5xH1EhRXFk9fmmIIJQNpEkx4eqDBPOBEZd0c@lists.infradead.org
X-Gm-Message-State: AOJu0Yxd5JlOZEVSJQag/bvdw+IWZKnGSuof/jDQhezG15Dsck4GTLYI
	b0mzwIywQb/WkEK7RfgZxrzHxcdbSydmQwBnUxPeK+OUyFYnROY4V3Se9I00zoY=
X-Gm-Gg: ASbGnctJh8KjiziCK+p1OHgBHldF1tF3ZvCJL9pa47G70NrE3XBtsNmFKIuwrFbJAgi
	5IcCv8+yMdJeQuYIEQ5NbPsct6epSV4B+xtEPamtahTjkCOTJu6aTlGrwdyvCoIAOh4fZ7j+Iqa
	Pz7afYClrdCCCZOhFpge6eIKXIKbU5awlPw0GKRPh9Eb0TnpmdwCM0u64l0VzDvMbZ++LVNOZy6
	4yKcvCl85y1iOW8AFHoCyZClYlJypcmbQgmYAK2r5/T7nFWt77rj1tuAXJq9EXg85NAiKyaIjBy
	J3pvJ3yFSG11s83WUjZBYA==
X-Google-Smtp-Source: AGHT+IEHXu4Adf4k7lWreSj75gITEDxxBueHs8E5ge9AqxuGDEfV9yiPcdGZf2s42AauL5pJO3vumQ==
X-Received: by 2002:a5e:8a0a:0:b0:856:290e:6399 with SMTP id ca18e2360f4ac-85870ec35fbmr60644539f.3.1740599037569;
        Wed, 26 Feb 2025 11:43:57 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-856209f8868sm86187539f.1.2025.02.26.11.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 11:43:56 -0800 (PST)
Message-ID: <e20b3f2f-9842-49a8-9f78-c469957e66f5@kernel.dk>
Date: Wed, 26 Feb 2025 12:43:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7 6/6] io_uring: cache nodes and mapped buffers
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@meta.com>, ming.lei@redhat.com,
 asml.silence@gmail.com, linux-block@vger.kernel.org, io-uring@vger.kernel.org
Cc: bernd@bsbernd.com, csander@purestorage.com,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20250226182102.2631321-1-kbusch@meta.com>
 <20250226182102.2631321-7-kbusch@meta.com>
 <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
Content-Language: en-US
In-Reply-To: <83b85824-ddef-475e-ba83-b311f1a7b98f@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_114358_705116_3402336C 
X-CRM114-Status: UNSURE (   4.81  )
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

Ignore this one, that was bogus. Trying to understand a crash in here.

-- 
Jens Axboe


