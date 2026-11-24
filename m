Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CED606A329
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 20:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=b9UXAzUk;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U15P/sIe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QlnDF8ulAZKGPu7aCBrq01jV/667L8OVxhejMMbVnbs=; b=b9UXAzUkZ1Q7q3
	Ffm6BmuLmuq8U61vbIQBdtLXlpELefOomfDyvdlooz6dggAtvZ3R0mhBqDfTLCcgK3+N+m0Awwv5y
	FREkYNJuUPC21etw2MQ8zBpZHrHsYnUeNeXDn7PP3tRVu/t1io7Cua8sLCfHVSXRrJ2jHMfb3apO9
	cbDXYN3A9VzArCfXsGunVzHKhuRpoi1fGHe8XPR95nl5g84YurS9oXaAqYhtZFH7xMYyNRIeS647Q
	LYUnr6wUgz/3AE6TzKNV7FSFymTXNMRXSccKk/p9N1SNmYbnqPebW5uqfx+Un4W8Wm5uB/lu16dh5
	6P5k8BGJcT2Y8U1lrNQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVxT1-00000007mhW-1oQt;
	Tue, 24 Nov 2026 20:50:19 +0000
Received: from mail-yx2-x00.google.com ([2607:f8b0:4864:41::])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVxSz-00000007mgv-2INS
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 20:50:19 +0000
Received: by mail-yx2-x00.google.com with SMTP id 00721157ae682-8b343763c6eso5852017b3.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553416; x=1796158216; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlnDF8ulAZKGPu7aCBrq01jV/667L8OVxhejMMbVnbs=;
        b=U15P/sIeQzEp7Efr6DxXAv5UCmvY4mxxkrTXnqhlkvoezR9MzxuLkyNBtHjbf5QG1p
         7D6qJ97FL79Au+14GlpJDC9SmEsMfRYc4/XeVViXlY/POVM2FCniy5lqlw3kPs90gEea
         +Rq2zIuUsbKwMTHZPMVA5w3rHT+0hNWjAgoWsDm4Nbx/p6HoKpltIsnTQwKUVgilGhrL
         QfQW2/M6F8i6J5v2zEcz+rkIvhm5iN4AKUpSxq0UABQM+5y1RMu1EMBhfI3uoOxRzj3c
         Ej5BoYWvUBLzmXU0H+uoohoSla6rwVIaHUxE67kGNHKFCYVQtg0etOo9XCuTX27VRNnn
         glgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553416; x=1796158216;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlnDF8ulAZKGPu7aCBrq01jV/667L8OVxhejMMbVnbs=;
        b=J6DpB96gKZtWr43uJQGtR1gbv9zfCmiuJVpHRjGkHRb8LrvAFBXdi6eIwrYd48mc8E
         FdfdKOFEm+ESi+KThzGoxEL/G5VvzRi/5kDcJWVa8mVX28q6u3rz6Vsjxi0NaIExdik9
         +Gg3U25nTS3f6ghrIWBE/vsf/sTlwM5w5eYDe4jOSZKyRgxCq0edgCZdGShkI5j6xR7A
         KIS4pIffoTH+iLXbG39sgOd2TMbedTgrlJZitr1o2SDG3E0T9rpEGqUnvMUmR/O0H30q
         LtqgQIXooO/6NauE+sZhNN6QaCzQY933XPaZuc7zV31hOxNxE+O3P67XwHbYh2zBi4Jb
         DUIg==
X-Forwarded-Encrypted: i=1; AL+hErGXvp3Vm6sT4HUhicZjcw6fxFwD2dBXbZiCOpNxRjDHPdSLE+ObA9ZoZl2W4idNVIZXUUuzupQSPCRK@lists.infradead.org
X-Gm-Message-State: APuU4Z9YMRTtjsykeyhGwMznt1/4lTVI87f9obLglDoI3Dzf+UO8CC/Y
	NHBwnlHPwXdLX/jWv23xATk+giTbbOeeyjV//PZ09bRW5XN8Y4Tv4t6+
X-Gm-Gg: AZFdTZcu3qyM99Yc43dOvc/CsnJbSOJCMk1AyPTFCg5iE10tq9xhdxbXv+6gyzckSU+
	MEr7BuPpnd6X9w42niHDqnyOmusO4Dje0NXj5wmZp64pyfkjfeRJyfGBSBoYGGqn5d9979XFYG+
	2FFjJo4uXt+ClZ54faQ4//mjdqGDcmz8IgLQ87XRh3zWZQ6sl6HNsUsiX/ykoNJOqEPhDqWKdzK
	xCqvuSEb6i2qXy3xwpdkGKUDXebjUjpfrOvwtxsRlxpUlBL+GAzpNXKAhSexSsqrzuXucyk+hwu
	MX7Vn4Xe4kSsZoMIvxkLMjOVkQrKHaGDgo+mhxf6Kv+knl17oIyA5LFstiaz28/R7PrG7ogRsRn
	UnE53bpvB6vyUz+8YWEzJRxAAI5y8RI1xGHSASOgMcJBwYLRDmg6MywuycFCjqbJQ4yt9bmbIII
	faWctbzbWLmoSj6bibUygpNwLwaF/obRc8vSQ1sHHDXcGPbqoy4E9VTs9OLW50pUgIHEFvmhnnN
	kW7aiSNp50whfNEtaFlKxEDBmL4zYwh+9jdJ9JyWRt3NW9kTgLfrM/Kk1yQKVUYrJzRyjlrLg06
	4v73kS5YNqZQgE03ow1F3nHitCHP651O9OBrx+DhHneJSp9kKENZmuhHXw==
X-Received: by 2002:a05:690c:d21:b0:8b3:7621:f695 with SMTP id 00721157ae682-8b5204e0571mr84581997b3.34.1795553415580;
        Tue, 24 Nov 2026 12:50:15 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52028c7f5sm64501607b3.12.2026.11.24.12.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 12:50:15 -0800 (PST)
Message-ID: <851e3fa5-ad88-4470-877f-e977bb1a6ad9@gmail.com>
Date: Tue, 24 Nov 2026 15:50:14 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] nvme-auth: switch to use the kernel keyring
To: Eric Biggers <ebiggers@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123212105.GA18468@google.com>
 <692e91cc-e2ea-47cc-926f-6639952fb195@suse.de>
 <20261124201152.GA2227373@google.com>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261124201152.GA2227373@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_125017_602620_C772AC88 
X-CRM114-Status: GOOD (  25.75  )
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



On 11/24/26 15:11, Eric Biggers wrote:
> Keys not being readable from userspace is one of the usual reasons
> people think they want to use the keyrings.  The cover letter should say
> what this series is actually trying to accomplish.  Currently, it only
> mentions making it so that keys no longer need to be specified on the
> command line.  But when stated like that, it's a userspace issue: if the
> nvme program doesn't accept keys on stdin like keyctl does, that's an
> issue in the nvme program, not the kernel.

The goal from the user side is that no DH-HMAC-CHAP secret appears on a
command line, in a connect string or in a configuration file. These end
up in shell scripts, config files and logs, where unprivileged users can
read them. With the keyring, the configuration only names the key.
nvme-keysd (in nvme-cli) imports the secrets into the keyring from
systemd credentials or from a KMS, and the connection passes only the
key description.

> It sounds like the idea is that the kernel would look up the 'struct
> key' by description again at runtime, such as on reset?  But this series
> doesn't actually do that.  The lookup just happens once, when the option
> or sysfs/configfs attribute is written to.  The key is not updatable
> either, so an external provider that rotates the key has to write to the
> attribute.  So there's no benefit to keeping the 'struct key' around
> after that write.

That is the part that does not work for a key provider. The secret
behind a key description can change at any time, and the new secret
must be used at the next authentication. This includes a controller
that is in a reconnect loop, which can last for a long time.

v6 looks up the key by description once, when the connect options are
parsed, and keeps it in opts->dhchap_key for the lifetime of the
controller. Every reconnect uses that same key. When nvme-keysd
replaces the key with add_key(), the controller keeps the old secret.
When the old key is revoked instead, the reconnect fails with -ENOKEY.

The same happens when an admin changes the secret on the storage
system. The host must use the new secret at the next reconnect,
otherwise every reconnect fails until someone writes the new secret to
the sysfs attribute or connects the controller again.

Copying the secret into 'struct nvme_dhchap_key' once has the same
problem. What the provider needs is a lookup by description at each
authentication, the way NVMe/TCP TLS without a pinned key already
works: nvme_tcp_alloc_admin_queue() calls nvme_tls_psk_default() at
each reconnect. That lookup runs in a kernel worker, which has no
process keyrings, so it also needs a fixed keyring: '.nvme', or the one
given with the 'keyring' option.

Martin

