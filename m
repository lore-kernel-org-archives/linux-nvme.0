Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB025606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZK1P10fW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBollQMK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Xn3AbwEHXU3sQNg1nNqXcaifYswIT1oFNQRvMaw2t3k=; b=ZK1P10fW1vxqtt
	LF1Lg45m/X7Pin4QwCdPUB1XlW6OMgEBln+K4lim1X2aU284vsbGExSLpyrbh3MzH1/ofJDGb1JxQ
	g3XmqNcIJ00LQOi3LRQ7xvMcIrSeMzxQPlXLDRF8i38uNC3Y1B+R7rexK+iB1PrjIG4GtjMim3RAy
	xYQJEM8+t/p9Tne7SahobKrM2iLTmH/OApGy3sToMIVJQCYS8Yex8gS6agK7j0amF7yUkI7puVfIk
	MtxZTmDDQHbkB86pPaydLtO4XuccYfTKOLDKNkZ5K3pZ3oZ9deZgGYYeISMa4ByFTRBdS0m5GtTSc
	OFLJCDxKa00Mr9712hVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWcfK-0000000DxuN-10ow;
	Thu, 26 Nov 2026 16:49:46 +0000
Received: from mail-yx1-xb141.google.com ([2607:f8b0:4864:20::b141])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWcfH-0000000Dxtz-3RlQ
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 16:49:45 +0000
Received: by mail-yx1-xb141.google.com with SMTP id 956f58d0204a3-67583c777abso7496922d50.1
        for <linux-nvme@lists.infradead.org>; Thu, 26 Nov 2026 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795711782; x=1796316582; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xn3AbwEHXU3sQNg1nNqXcaifYswIT1oFNQRvMaw2t3k=;
        b=XBollQMKbweUcnbCsAzg41RKoXw8juDDj+qNSlNkur2ZRWv+1XUZZmlLbgJd/Osg8v
         V+ROices2FYGFrDAbHv0zjQPS30fmTkG0/FC69/sEFuZM2yK301sFBUU/HKMDY4Sgg9k
         HpLHRSBNyQMpdqTeUybDk/DjEyR/hkbgmuFKGdbUwE38jnHEhiPoBjVsocFrWJPpPdcl
         pqvM/UrAUm6bMrqsKqPjqsyU0k+lXCiJTzLUm8eG0+TCt/GoK4zvWM5IPRSZ6gLPgoWs
         Io58T1XFEi96A79Nc/Pwfged3Bl1oCyakXer+U1uxnsNsvpIZs747ap8jA80ETymzGCM
         fnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795711782; x=1796316582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xn3AbwEHXU3sQNg1nNqXcaifYswIT1oFNQRvMaw2t3k=;
        b=J5rROScjlllu9lUZytuSeoQOV/WZhsZWOefZUqutl5AKoBkHRYj0ZuXkC9HMXdpLB3
         v7//VkOATVSrckqb7Js4zq6JWo7HvtPZEclHGW2Y+cLg4j+0UIKMnQkn1DGVbsKhyc6g
         LMB1LwhnU5/09XBt6a2JfSc7Ta8SE4ceMZBWCH4oswL4rO3agf/xGGN3J7gW6gzPQQ1X
         pR6Yv/RhNiztQHcFoEw/6ZGt8tGZk6ffydpSLxe0u66Mp7faiZiBzJsswMCp5deOsSwa
         djqAw4L+2Y+oGenc5hbor2XmjWQD7gzWPTb9kj2+Jc9bLYzzA1Wm3rRmz0ANbzBYNJJ8
         kObw==
X-Gm-Message-State: APuU4Z8nD5MsvdRuUKIiTCaNs0c2PiXIpd7TcnZlAIhhoiWu2m+VLgMe
	Wdb6kgVOUz58Z5+HiTYKyVm7br8QPwcsRsZOlsbHqvH7tfNgOP4YFiV6
X-Gm-Gg: AZFdTZflR/eWXI6gKDmClXonibHOgjHJ+GXM99XgSjUgnuNHOI2aA1kMakSx3ea1wr1
	g3m+Q/Cjo2DMdu1cjgE9XuI0rgBTCmtPl1LA0866xfzWXxgPSknFWZFcmHslOu/t4U6lllNkVHJ
	Dge9Xh3DBE6XgUVKYHUn7CB4iYgjh+MgAgn3IflTQGSrVWwyDtUoGO5h+Do6BFvI+mEWRcaEq5u
	wCuh4rKA8YrvlOrr5syT3f0tS4aQ6zDaNQAJ4ro9th7XyPlMI6MXlVGWq/GXFyaW7zVAmmlzImX
	DSZ/mDuNIGnt9ZguPfzsNMTksWXknAbGd4v543wNxbe9E38nx2vMaN2wgsqy9G3uHO5xtzFENd0
	VFtwxZ84/De4193+Z1fsP+lsDlpMBPX0jauv4dxfpxzDR/PStIU6Dhe1ZbkvSuZZpfGUck4ge+A
	YlxRkJmRz19vG9y+V3dn0abq4cYnh5Ol69Jstl25RJ2wj85bY3wLuGlxYVaF/6TbOUQac2D2Q5E
	+gxyP4vhU0FOYUGVRZTa1Yy5MQrSsr3cvfSiPyBa0dC9Z115P486azSBP/Ik5abLU/Cc0YR3ZZH
	Skce0wxEWvShoklm66Gh1oM/5wLkwgLHuaHU
X-Received: by 2002:a53:ac93:0:b0:679:b8fe:a6f6 with SMTP id 956f58d0204a3-67dec48f5cemr8552044d50.33.1795711782318;
        Thu, 26 Nov 2026 08:49:42 -0800 (PST)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df330bfb1sm10473400d50.6.2026.11.26.08.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 08:49:42 -0800 (PST)
Message-ID: <45f16f1a-66f7-4300-bffb-3d279b6c4bfb@gmail.com>
Date: Thu, 26 Nov 2026 11:49:40 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/14] nvme-auth: link pre-provisioned keys into .nvme
 keyring
To: sashiko-reviews@lists.linux.dev, Hannes Reinecke <hare@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
 <sashiko-outbox-235710@kernel.org>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <sashiko-outbox-235710@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_084943_874238_9B4A4DB6 
X-CRM114-Status: GOOD (  13.73  )
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



On 11/26/26 09:30, sashiko-bot@kernel.org wrote:
> [Severity: High]
> Does nvme_keyring_unlink() remove a pre-provisioned key that originally
> lived in the .nvme keyring or is shared across multiple controllers?

Hi Hannes,

I can confirm this one with a test. nvme-keysd adds the dhchap keys to
the .nvme keyring. After the first disconnect, or a failed connect,
the keys are gone from the keyring, and the next connect fails.

I think the kernel should not add keys to a keyring or remove them.
A pre-provisioned key is either in the keyring or it is not. If it is
not, the connect fails, and it is up to the user or the key manager to
fix that. While a controller uses the key, the reference it holds
(ctrl->host_key) keeps the key alive. So I do not think
nvme_keyring_link() and nvme_keyring_unlink() are needed for
pre-provisioned keys.

Otherwise the design works for nvme-keysd: each authentication reads
the key again, so a key the key manager updates in place reaches the
next authentication.

I will re-run the test on v8.

Thanks,
Martin

