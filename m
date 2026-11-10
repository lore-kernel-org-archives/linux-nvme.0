Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9385A606A8A2
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3OsP2CdV;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zYX4PLfM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=; b=3OsP2CdVDE4xNm
	abqveWQMaQxHa5fHxMHCHe0bij0xCHQWpZFPzsW51Lon7cp3vpTR2OxUl8c4ow612wg4f721bNsHu
	8rkZMQ2bvhDgNyTR2bC2K8mdWJUFkMXeN8LXq3gjyuu6Ni6kED7TmGO0L/E1QSTga+QBw1W1LJGuX
	T3KcNaf0JMwe7oU+/fgNBDrG/B+RhJRReq3jgWlWz8bfHi/mcXTUjL8wswoIWBKF3U0qVR+MD1LT5
	5x/qyRZy4quq+OCzjCiokinSczrvoNLDWCxN7EqtKHfiUYHHFujOMNZNM859w3TX/tSbgawkomowZ
	m+dFp8KgkIZn/30c6mTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFi3-00000007lpy-2RRH;
	Wed, 11 Nov 2026 21:18:23 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnS2-00000004Joc-3hIZ
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 15:08:00 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso12775915ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Nov 2026 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=zYX4PLfMjuMPoceUu9orAPc1J6gCNMbLiS/JDi3BI1BlSenFNXHKf1Q0QclJKnnecD
         Kc5fVi7nID2AZdfa/+oa7gTMsF1a7mrCz3RL4zVrgKpc2z8RgmdvseGU3oWXWu4nwY1C
         TSf9pyfzKSr4/YtIDJWYnj6xE0cfiuvZ+Jdvh6R2PqKnVHvd2aTpFOIR2DRiNv189lAY
         mHVbJg0wvKQrXzAh4LLRMIsNX+7aXVvZQjmCEiGlv/jgt4/5P0M4BRpJmKcMLXWA68ID
         KcaTHEtJ1e/dEAD/QMhhvAblJchbKVScIu3lNjbn+McM/PmG5ubpIhf2wxz52wTYOalu
         GJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=Eb5r+1Y5bVjiMIJlB4X93k3zvXZlQQfKvXeqcw2WFBf/4FDiu6LV0cFdiQgZhXsY+k
         5I3usoz+OtNxauiD9NAValOBK8Ae/KxjyUfGEMBq2Za0edT0M8ZFr2TnT5bv7GCuIHvE
         /EM10QXalJE9WGb5B/tkIRVnEHEwvbfjNMQRF7dzj3V0FP9bde9hFuOYFWwFABt+hUDz
         4qqo6OfBmSKt3rMRcJJcYHjtl6Ou2uZjERbEEaZUoDuybhpQ/a3HMSy08MUtrrp2YT2g
         5AWIcsH2qer1KjCtDIxz5qx2WUHnqLDB38jkhqL6LMYUejpSdLivWtqyAgRHHiRI+qck
         y/Mg==
X-Forwarded-Encrypted: i=1; AL+hErEe6rLciS+P/eg60CtodddR2LnaNuSkNDkUN4k6LEp1mRG1BiaYcb84xEbO8mErGOYSLHF8vB/No4SF@lists.infradead.org
X-Gm-Message-State: APuU4Z/+GYWAjRopYYDGX4joQhB/3t6FBOOva/K2Nau3rmdQLYF3saPz
	e3D/7FqMmQZtwd2DtnU1RNE/M7dKmD5922zA1tpP2+THR5tN0fGqajzs
X-Gm-Gg: AYBFou15ytTC+mNB6fvbBbJ9hYVSNVACel4hh4eHuv7JxmZXHD2UmN1D69lujVj7PBO
	PgQ+xwknEfYLsDRs6ZERhDR+s/E5/OLa/yWiMZzW4D3vR26sdOdKvFTYdmyojFTY9mqTc9a+AcK
	6XbnIJOWJWsDIYskPCoMx/6Gx2RREAz8duei9bHKWCq2Qw20CBUdsCh4hQyBrwEvjU5Pv61ipt+
	PE6vt3Puwr0XaPvwnUUY9yXLc/CtdTdpgFaIa+wA7l/qEC8Py0XtMJ5UjuxOZutfIBPIWslyJiX
	1nrP9EhPVMpF3hPXIx2qvouxCovOnH4+hUSxFw0Zne/UCiWNWkvKbMxNfInk59O31a8Nyxjb4fo
	EJI6vwz8VUq7PTE7AmaHSMe7JHx4qd5iz0r3eOkffKb1Jv/nQQMZ+RFTivgYBp6ktk6SbHfu/G8
	dZIUU0qd7ZDiMmMB2DaBXlMo7jTigLcHafMcbnaqgvVEWe3rVNmse6YEOweSKnQ0w5xEVywFf/A
	hZS/ubZirwt/KQIEML8j2LArN3HHREQAZfZeBi/WXT8zAE7ISFCvN4/ynfqz9mbJj780Dec34FI
	LFptFEmEq1mJbKBSmj13tqPqXd49cJ3EDAUYQZiAD2ULRRSAoMW+Spps31HnsuGU0WMV2sVAV7L
	JcRskmjEh3Cg=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070758_946829_CB82FBFC 
X-CRM114-Status: GOOD (  17.84  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:02 -0800
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
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.

