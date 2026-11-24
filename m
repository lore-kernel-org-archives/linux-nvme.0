Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB16606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=KuSElkey;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z8atbCBU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0L7WJQgcx2P9Iy3RWSJdXtSMcIIiqi2RystV/kGBxpo=; b=KuSElkeysmpO9z
	6yDeyOifq+OovwXvy9fs92E59ePxFenw9UV8uLTB6NZqIYCvZM5MPoJI1qyMU9xsfXZfpn0GBdNai
	8h8YKPM1guem2t1yVhki2fpF1mhrymUcZaA5D+NVJj/eM5RZ3F2pVUHwaxlp6gXFii5wKAi0Sl8nd
	PIlA1KSkyEZC4q/BEqdqv0nTj0VOSLhelqUrkzyDmVoZCXKbnH2JcDnCVYXRWVqZSQB7Qzwx9HaMQ
	6OxyuwfjMvtj3G8XR7mKU6jXsbYHtPuHvIQ6UUwOwA2/xVFB1S8Jh9N1DCSWFdWC8vUwGcjrWXObS
	AdyVaXqbVONjTGj87uQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVylU-00000007yFI-3OOt;
	Tue, 24 Nov 2026 22:13:28 +0000
Received: from mail-yx2-x01.google.com ([2607:f8b0:4864:41::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVylS-00000007yEO-2uvC
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 22:13:27 +0000
Received: by mail-yx2-x01.google.com with SMTP id 00721157ae682-8b521794242so7621807b3.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795558405; x=1796163205; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0L7WJQgcx2P9Iy3RWSJdXtSMcIIiqi2RystV/kGBxpo=;
        b=Z8atbCBUmcuZK3oIWC1jUJQefS5q22IX4z7wnW1mDc9Xh7hRxc/++5wC6Sb7xCbNY3
         npFed0ecZ7uAGA4azU+vLf/x5gp7rx4ifH+ZQOl460OW5+bvlPZgyu2quZ7HgDS8yJ/r
         pra6vkFXzP1RqHJSuujFC6kePQEuJ7PtktDpSpD9Zs6ssnjVwFPva57w4WO+uUUhypZs
         7uzJPr6Yl1VbfSaSbnqXgSgeNzFa7pUbsC/kB6oMPR0YOrzdLQ1gvxxf3As12EOOBh5Z
         T9+HwAU6fsHYdHbx6xc9So5gc6YJgZR2cEDrnspMMtsweBs1JyXmlINDQ6ZGh17tPrJ3
         qP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795558405; x=1796163205;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0L7WJQgcx2P9Iy3RWSJdXtSMcIIiqi2RystV/kGBxpo=;
        b=J3mo9f49N2cAWlCq1dL81R+T1f8Ix+q9N6l6rVuqgzodapZEQjcQH0q4lL+5RGq218
         yANDFHI2E44m9FHiL7KwmOFGzdcwEEX9OKkCfxpGBupzpp7c983PIokKk3FmoPN2H0Jp
         9bHNBwn/YbwcTs6wbqXZcTqN4+GbxzJW1zhiCu8X/PYe84GjCK3KplZxnWzmMRwYts+3
         MKbDmwpEDJXUhSkaXf0zhiQudAeKYTmAvWQLJhrgs0N4FDdgoopUeMkANUz3FRR8ek6C
         9S1diFQgTy3u66RzrDAiqqY3rAlmbhM2Ufwf2ZijzNZmuEG8slJ4JGMKb3Y9fEeQnQml
         JCKw==
X-Forwarded-Encrypted: i=1; AL+hErE+0UBfx9AFsfIWc/8udPVGb96iF6Ngmfb+GmLakYgEn1+49jBFNgsTsmJgz07dAtKmJeUDrb9sWwpW@lists.infradead.org
X-Gm-Message-State: APuU4Z+7bgt1LUGVKEq40AVAA09LVTMAQ2TBwAiLScMSTeNY0jZad+zC
	oax3QKhFYgZjYYBw4j2M8AKIFWSpJ0adDmGPj+zqYka1hC06vYWsaiDo
X-Gm-Gg: AZFdTZeMaZ7BCVrlQqWXNY6VCKeFQ7oEdcPJ+X3hHGALrqf9e9I3rtfxrc0p7kJvDgX
	fIdXXMSl1SwrzjHyUe97znX91KquvvhYO96RcdpbEPzaAMJ3KBQKLtFVX8VPOvWNUA+U5BRnk8O
	qALTNnLRwJxplySjGlhNDKRYnV50PJJriWaZBsdySkZdL7p3vLuH5rQk7PuCcPh8doXTUSDql/F
	zFscBzXOpaoql0bOKiVZkQentG9DzywS3wiSLBg95rEpWtQsGCSHVJnae78o0ZFyZgV5JrMu75L
	1KBLjRMGaCNBcGomQnAeP0pf3S4YeEba4v+YRoYpB2BYVNUlWOedIw7mncZtrMPf7+giXel5Lw9
	m4ftGRDbpm/EKJm9lW1jyK3R8hRiFLcMi/SE5DGLwm3NytCpBKkh1pM+gSViCygWLcBGNOi3HMD
	b0U8QdToBBfStL0rBKkXjKQMPDOkMvX4z7zm591syb/D+M6h+98bBX340JA1yL2pOP3S3oOeeqP
	ScAF66lrTZbJ5J/nQgFUAHrnGF7bGOc4SlWP/HDQG6l1DAI7+6k9+fdP+p6mHXLQ0EUzIy6t3Xn
	q6Fd6dRsROtteFkUKcV8sYedzW/QqM44/o+G
X-Received: by 2002:a05:690c:4b8f:b0:8b0:e10d:1975 with SMTP id 00721157ae682-8b520435695mr52461807b3.29.1795558405356;
        Tue, 24 Nov 2026 14:13:25 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028d89csm65560977b3.15.2026.11.24.14.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 14:13:24 -0800 (PST)
Message-ID: <c2163003-948c-49fa-815e-b1f91814a80a@gmail.com>
Date: Tue, 24 Nov 2026 17:13:24 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
To: Eric Biggers <ebiggers@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
 <20261124201152.GA2227373@google.com>
 <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>
 <20261124213222.GD2227373@google.com>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261124213222.GD2227373@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_141326_750850_F7061718 
X-CRM114-Status: GOOD (  12.11  )
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/24/26 16:32, Eric Biggers wrote:
> Even if you actually need runtime key rotation without touching
> configfs/sysfs (why, when nvme-keysd could just write those files
> itself?), this series doesn't actually implement that.

Correct, v6 does not implement it. That is what I am asking for.

Writing sysfs from nvme-keysd would give two mechanisms for the same
key: the keyring for the connect, and sysfs for every change after
that. One mechanism is enough.

It would also make nvme-keysd controller-aware. Today nvme-keysd adds
a key to the keyring and does not know which controllers use it. This
is by design. To write sysfs, it would have to track every controller
and know which key each one uses, also for controllers created later.

A lookup by description at each authentication avoids this. It is
also how NVMe/TCP TLS PSKs already work.

With a lookup at each authentication, the sysfs and configfs
attributes no longer need to carry secrets. For a key from the
keyring, they can hold the key description: a read returns it, and a
write sets the description used at the next authentication. The
secret then stays in the keyring, and changing it needs no write to
sysfs. Raw secrets given on connect keep the current behavior.

Martin


