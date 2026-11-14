Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B15606A334
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YyKBO3i+;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=baKFKu6G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-ID:Content-Type:
	MIME-Version:References:In-Reply-To:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=; b=YyKBO3i+0QVVAf5Qvp1tq4HEQt
	3oW4Cu5/BOpr1mvfa6pOQJlkzcN4DMv2ERaXXk+yVKzAdwpLqE5imptRc+wseXqEZ94rW7tvYC+KL
	Opva0R5R8ErKYaRzdDF4e0fRp6mH/yY+uINZn1cI1o/7/B3tSsAI8764mOYPZZXtzkQ/PvHFUXBeI
	uFzXN21RykRZh1PUFp/NJIKPOJTBfDI6nMqkQO4NsucjBaf4zmlj05WeG4zjnDLyHIwSBislkdPds
	/V39OObSoxtUf1iWvS/HylKxuk8PJYO6vrn0TkBKqPOHZNTSoDXlb2x6rKA7eQQFwoyQrxlam+98e
	rmdKbS6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSw0q-00000002R0o-0wdx;
	Mon, 16 Nov 2026 12:40:44 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSK0b-0000000Ghxc-3eAX
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 20:05:59 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8b5e5e64494so1463743b3a.1
        for <linux-nvme@lists.infradead.org>; Sat, 14 Nov 2026 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686756; x=1795291556; darn=lists.infradead.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=baKFKu6GRECXz3yWBeIua6jq2zwnwxEO+n2mXrbVK1o8BMiBXSj+8adeoWsstGNypU
         vHLStgrJb5wf2DEu9Ds/fSYjQ61eXAEHAna9sSE/qloxa8XulWwLJ+PreOQeL+cpJAGZ
         DOwhmaF2S9iuzIje3PPo4UqqeveEEinYYxDjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686756; x=1795291556;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SncZUWGrBOxT9WurRufkDIe8hGFcWm37DANGybHY+fQ=;
        b=FzupJxefOaWdCYu+FSP14wdtrMAEhEqI3LojTQr0h5HRlq8jBAopR9dLWGqrH1UPxa
         4U/CdiAfitfVzgpMYpZUDiTNZqDIVElm5Yf1zF13tOB4T5tKewlvGZQmPzpYV0Eb8zOO
         A0ChHrfSKUAazxxO/Svuv3e5VrZygdrf1+jjo2sNHuFNBW+jcWEl0J+pZNd+cv8OTTVB
         N5fWaKjy4+YipiKK8EFDzg30dJOvxITUkXP/ahUVVg2JTf84Vt9fH/aFH5FABMxLNHHF
         KHayQSRPKsdkArDnBeLLz5Ik/O+ydOmNBz3O9WQODIM7AKH0pazHjkP0/ZGDnNLVvD2/
         h1aA==
X-Forwarded-Encrypted: i=1; AL+hErGgq5EdVKKLkJtRoBWJSbLE79x5DU0NXClrjutQ0e/Ut1N/hdLvzpuuK8RqCeunWi61GBA0o5Dr2H8E@lists.infradead.org
X-Gm-Message-State: APuU4Z/k3qHwXnZimtGsBX5MFh583DwYxfOWCXwwCc7Jy0coaUBuMEvz
	i9DUz92hUiNIpsBk6a1IOi3oDFFlUuLXRVLWsNg24BianPZIYX8XPIb2u+LDZbI/mzE=
X-Gm-Gg: AYBFou2qdkAHeprjyUja1KXeDBOnPjR541qLrMa9hnsLxp4tbzJKeYJcqH6awBQVc1J
	1cNr2xBTY962/3JzXtljovKP10xOufBcNYmOSiUEd+ZnrxFY8PpXJzIIA8yRANRTGMW/QC4thD6
	esTa7KtFXiRrTENGjIP4V4hhl4MC+4UmFzv7NmHqiFfYrJY7B/hbulBeqVUDj3/vcI1JbVEM89p
	nUmpvs49zOoX1tfw45jl9/QI5AA/DSpT75IvYkBN5OuLTf6RfFgXbE44uphuTHaTAgE8s/MRZe8
	8nW9iNcz0yvel9yXgFBTtkafT6jRiDgCTJQSH6p1z/8T5q5xCcR/KpFEQ3DErKJ7ZsZq3brx7+W
	0j7Qg2jE9FKGyoaTa+NfvpkMatiQzjSOyBg1xNWnFx6Ta6cnYCH9MVa0qNj+byfnaMqpZ/vkt3X
	xryVnUQZyqWU6U/UsV46CRnURoGcrn2tVnkA7JtujECHn8X33JfUbm7a66Pbgq0JLswvhPRg8mW
	pQFS5k8wMplAmRM3kz2g6kiJp6kg4/+slwOvcCdXSfyQyukUyut7PTF5eBjlJ1rfcntwHEgvhe6
	leSm3yQMulTMNBC5X+K2lsZkpQwtQMww4m4ym11Sc821BAXGJU3ftOEoNjlg5N3lZjoZOJQru4y
	7F2kaIZ2Foebb8ppHyhNEbz0BlMAMVnqzKGs78bMXkc9/Dcs+f+SNW+51HYxCh5Zv55+7032uMd
	TxlTQG06s9q9wV0YZCmluHCKANhywXssTWSGrDHUS+A89vPUhatkW9bX8y
X-Received: by 2002:a05:6a21:748b:b0:3e3:37ff:3795 with SMTP id adf61e73a8af0-3f7a4dbfbbfmr5517650637.7.1794686756009;
        Sat, 14 Nov 2026 12:05:56 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm2271197b3a.13.2026.11.14.12.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:54 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:50 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org, Alexander Mikhalitsyn <alex@amutable.com>,
	Breno Leitao <leitao@debian.org>, Casey Schaufler <casey@schaufler-ca.com>,
	Chuck Lever <cel@kernel.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RFC v2 00/42] fs: don't use pseudo filesystem files as
	storage
In-Reply-To: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120550.0c9e73aa12a3072c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_120557_916438_37A9CB35 
X-CRM114-Status: UNSURE (   6.37  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Mon, 16 Nov 2026 04:40:40 -0800
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

Patches 1-11, 13-16, 18-26, 28, 31, 32, 34-37 and 39-42 look good to me,
so for those please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>

I've also tested 5, 6, 34-37, 41 and 42. The selftests all pass with the
series applied, and a uid 0 without capabilities can no longer change
/sys/kernel/reboot/mode through a loop device. So for those, please also
feel free to add:

Tested-by: Chris Down <chris@chrisdown.name>

I've replied separately to 17 and 33.

Thanks!

Chris

