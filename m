Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2F3606A33D
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2VQTGaVZ;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WQEpqa+x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xGUu4K6Hch737xk2AjXhVoXP8Oyq8YcHuX/+uNS+IWo=; b=2VQTGaVZiVNn+u
	OARQnalQsQLPsriVNCd+HhkDFmnt0/90VbZ+NH4sViRPBS3FbnMrUsoQUMw5xUYsvp2+PVWq6krD+
	02FAnuC40/exR8cnxqNDlUKrfVMg0VnD4MpjdEccza2/vwbI0AIL9chNm7rT6Ebl61TcqhY6J7Ows
	AiFwqFI7LEYdiXOu/RxuHNUfzwKeKpQ3j2GoruHaRB/swbsHgCP2zKHDLGVfhZ5JBbINg+NjWSscf
	/+Wxbo3DXXTD2/JYz+EmCVnQoOgjgbOm5VPWs8rzVYjcru8g8oSWlxcaAsAoD/yYEtrsdlFA+13jt
	yldTGjCFNJ1Zb1G8YKVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPDzX-0000000BO88-3Bdx;
	Fri, 06 Nov 2026 07:04:03 +0000
Received: from cmccmta4.chinamobile.com ([111.22.67.137])
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPDzU-0000000BO7c-2y6B
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 07:04:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=WQEpqa+x8PBVgdfNxTxarECdINI6l66IdnQ/D3kbeAoZKGAMV1tdU0saC6Rh3FyWNY1eqOf1YXKNa
	 hJdCdzqQLc2M7dty7K6cf2jvGeEpqX0wWHka5sAYzyyTDZYiVQQyV5kAIlOwJgqp31cI4+23C/rWox
	 xbecbow8hfLTfjCI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86aed7bddf60-4dda0;
	Fri, 06 Nov 2026 15:03:57 +0800 (CST)
X-RM-TRANSID: 2ee86aed7bddf60-4dda0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from cmss.chinamobile.com (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86aed7bdbeb1-1606d;
	Fri, 06 Nov 2026 15:03:57 +0800 (CST)
X-RM-TRANSID: 2ee86aed7bdbeb1-1606d
From: Yuehong Wu <wuyuehong@cmss.chinamobile.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Andrew Stellman <astellman@stellman-greene.com>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Maurizio Lombardi <mlombard@redhat.com>, Mohamed Khalfella <mkhalfella@purestorage.com>, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>, Randy Dunlap <rdunlap@infradead.org>, Aurelien Aptel <aaptel@nvidia.com>, Nilay Shroff <nilay@linux.ibm.com>, Jesse Taube <jtaubepe@redhat.com>, Rongzheng Wang <testwrzwrz@gmail.com>, Kees Cook <kees@kernel.org>, Rosen Penev <rosenp@gmail.com>, Guixin Liu <kanie@linux.alibaba.com>, Qing Zhang <diasyzhang@tencent.com>, Eric Biggers <ebiggers@kernel.org>, Julian Sun <sunjunchao@bytedance.com>, Yu Zhang <yuz08559@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: clamp the last ANA group index against the real array size
Date: Fri, 06 Nov 2026 15:03:55 +0800
Message-ID: <20261106-nvmet-ana-grpid-followup-1-yuehongwu@cmss.chinamobile.com>
In-Reply-To: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com>
References: <20261106-nvmet-ana-grpid-1-yuehongwu@cmss.chinamobile.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_230401_289952_576D2985 
X-CRM114-Status: GOOD (  11.77  )
X-Spam-Score: -2.4 (--)
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
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I missed that this was already reported: Andrew posted the same two-line
change on 2026-09-10

  https://lore.kernel.org/linux-nvme/20260910154849.66095-1-astellman@stellman-greene.com/

and Sagi asked in that thread whether it had been tested.  That patch
reasons the same way, and it also cites the spec wording for a valid ANA
group identifier (non-zero and <= ANAGRPMAX), which mine should have
quoted as well.

What I can add is the evidence that was asked for.  On
7.3.0-next-20261027, with two kernels built from the same tree that
differ only in these two lines and no instrumentation, the nvme-loop
transport shows: a group created as ports/1/ana_groups/128 is
absent from the ANA log page before the patch (ngrps=1) and present
after it (ngrps=2); 128 written to a namespace ana_grpid reads back as 0
before the patch and as 128 after it, with the namespace accounted to
group 128; and removing the group again adds a phantom group 128 (state
inaccessible, 0 namespaces) to the ANA log page only in the unpatched
kernel.  The exact steps are in the --- section of my patch.

Andrew's patch is against a September tree and no longer applies, which
is why I sent a rebased version.  If you would rather take his original,
I have no objection.




