Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D5606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Nov 2026 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=14zhHgCp;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8jlqTkN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=; b=14zhHgCpKc7aO1
	SpJNmW7T4DCKGQ79ISAXVjasKP5Nyk4FHSCn0FtxSO+z+h9D+dibcHO8fK3cUJn+LgTZyb6fysmyr
	uJq2imbBFEXA2tbY0jXoClmYucGkepyw1oNAiR1co8Az+h4ZlUPdpoVQ4X/Kx3KhCz7OiIx5QSLgI
	MqE6isxW/he5wf6DYoq+c+usAjE9IkwOyszP/R59rsEyc0e6K3FQPI9hHKRFJ6aYWh9s3gGESmjEd
	9xyFWAKlNihSw3ZQN94L0lC0NnsQday2UyECzHIMEuKUa9OwlPQJuRmfps9CK7jH/5ABsByXPYJ45
	dvX9gWElBdKdTM73M8cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWx3L-0000000GaPE-4AUE;
	Fri, 27 Nov 2026 14:35:55 +0000
Received: from mail-yx2-x02.google.com ([2607:f8b0:4864:41::2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWx34-0000000GaLF-0fae
	for linux-nvme@lists.infradead.org;
	Fri, 27 Nov 2026 14:35:55 +0000
Received: by mail-yx2-x02.google.com with SMTP id 00721157ae682-8b507dc8215so6875047b3.1
        for <linux-nvme@lists.infradead.org>; Fri, 27 Nov 2026 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795790137; x=1796394937; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
        b=b8jlqTkNQ07MtYJmTCYomII/W188naHKwRHOlap4y3Sx96z/oT/Zr+mC3FWEgjY+C8
         27glenCWIjchO8EItt6F56LOBOIf/trpkrUgpPfsbi6rZGx8WnukAvlHjkI/aT21156c
         lSXb40ZWsvAhIO6alD8Q7UHrvuFD5sRef3VIOPl+qFXGQg/XRNZ8pq4KFsanN6DmC49I
         JWcKozHTnmbigx23j8Z3XUtDcOisH/GTp5CqcuCyPr8HzXfMVt3vKu6RrQ9Z0OeZ85jI
         XLZKsyB10Hg+ETFClt/woiKBXlBWjAVJUKA2hL+o/yBXj1DjpjHImgnVSrQa6/XkPS/E
         aJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790137; x=1796394937;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7628Lpv1Ui4aF9FZsnI4m4y1Sp7QMbMmxqeVrU981Ws=;
        b=iFxdExlgJWMFyAJlEP6aDjJm4bMpU+g/g4216nkX4jfu2z+wyl8OjawAKXwihG0JLs
         q/1eI48lHOllp2MmwShURP6EjbfzyqNh/4ZAHl0///sRFVTVXw5O7Hgk9KHwqyqroBjq
         g8D3HeE9Ky/40Hoo1je+3Gg0PotJoMcRC53b14/Y5Ez9HD1apL+eK5KwqIIjOWdEERIm
         grOpeMMurevwzoQMHGjHLSfgSQ6w1W5HDGfCq8H5zseRE++HrTGadAzAMYvANSh9itOx
         u7iVSmtfXxO/bTs/hdBJTcv9j7YWQJpOekQWb0z0DDDp5oiJiNOIfezC1/WgYNQzU/OP
         2fig==
X-Gm-Message-State: APuU4Z8h5+5huG6zhu8kT73uIy/e6TCkPn+9xw7N2rdhwOZLYQfLOL4d
	2mKiWWmEhHD6GlrbvvzLOMx2S2tx6Me863rrRmOvlwbwOsyIxcekIVcb
X-Gm-Gg: AZFdTZdIW514dITbSOWSIaPpl7zeRuMmG5ApzN00uo59pWMK0jE0zUY7p9Jhr6xJZwY
	/akCxWYBzfgF4xMXKSKPkj9tfPjaM7rjzkwViEwzc6SRTuAPj3fXl6oR6Vrw/7XQV2pJiaIibx5
	yO2oUbCBo03+uxNpKYuostOaPauSpOUy4gbb8xH3yglRqI8/Xgu4kOiblm2rwvCVsdcIdPT1Ynt
	twxqTxysGFbvqV91UIVJbEWrtlSn4ncjjpoFTXYq2gJs3Gr7cqI0oKrKhY1QCoWW4tulXk8QUlM
	D6L6pRNIi0KaPGE18aotU4x1PLgMZHgyG6pNtHf4KdTBcBKVXvchQj9tRK8OQ3eHC8q0w2TguD0
	uwPt1r+S+u8D+cyRq1Ts5AG+Lt3voy3ZRM9vfcY5IGjZ+34nZ/rPA3K23QiLNdy1AtzKVu+PIbk
	QB6puIHIpXz0CU/qWW0cmzv9J1AtCL7xXKLlSLkq69LzVs7swo8HZRahuaKj8s64xuAykD9tTsg
	v/JiEpH9oNUa45IBolyM6B4oRyk5E63dqO96KYC9b7zJbHWNNcrRsN8pD56xOjMS1AsTnwVnEFK
	v1A4qzBsWcJ0Fz4PZevtYfeqXkkdvvmOVHvv7MLykBJGDLNgCKMxr9YFug==
X-Received: by 2002:a05:690c:c04:b0:8b4:c8c5:6b11 with SMTP id 00721157ae682-8b5204f087fmr129405847b3.36.1795790136722;
        Fri, 27 Nov 2026 06:35:36 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b59a06f3e9sm1537207b3.25.2026.11.27.06.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 06:35:36 -0800 (PST)
Message-ID: <17a445a0-16ef-452e-a174-5bb09940d3fc@gmail.com>
Date: Fri, 27 Nov 2026 09:35:35 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/14] nvme: allow to pass in key description as dhchap
 secret
To: Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, Eric Biggers <ebiggers@kernel.org>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261127_063549_333367_50BFA12B 
X-CRM114-Status: GOOD (  13.33  )
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
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/26/26 09:12, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
[ ... ]
> -     }
> +     } else
> +             count = sysfs_emit(buf, "%s\n", key->description);
>       up_read(&key->sem);

In my reply to the v6 cover letter (Nov 25), I asked that a read of
dhchap_secret returns the key serial. I would like to change that
request.

libnvme reads dhchap_secret and passes the value back on the next
connect. A serial in dhchap_secret would change what existing user
space gets from this attribute. Showing the description, as v7 does,
is fine there: the kernel accepts it on connect.

Could v8 add the serial as separate, read-only attributes instead,
kxchap_key_serial and kxchap_ctrl_key_serial ("%08x", like tls_key)?
NVMe Base 2.4 renamed DH-HMAC-CHAP to KX-HMAC-CHAP, so new attributes
could use the new name. libnvme can then use the serial, and it can
tell from the presence of the attribute whether the kernel supports
keyring keys. Today it cannot, because dhchap_secret= takes all forms.

[ ... ]
> diff --git a/drivers/nvme/target/configfs.c
b/drivers/nvme/target/configfs.c
[ ... ]
> +             } else
> +                     ret = scnprintf(page, PAGE_SIZE,
> +                                     "%s\n", key->description);
>               up_read(&key->sem);

The same for the nvmet configfs attributes dhchap_key and
dhchap_ctrl_key: keep them as they are, and add read-only
kxchap_key_serial and kxchap_ctrl_key_serial next to them.

Martin

