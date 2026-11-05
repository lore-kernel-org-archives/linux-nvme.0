Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8E1606A33E
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r1HRb7yq;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oPxhrOZe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=; b=r1HRb7yqofFRzE
	KWbi914hKxwjrhQ8MFWem1bL4SN4r2NM1bTHc5calxLY1eyOq6j2cHNfGrci3MKOuT7rWk540YdfB
	VMfQwI+m/VY6pYfM/JstWT+GjqiT81xWCS3awkY2c6Q9joKyusyfGbAkjJ/8haLqK22WV7o4d1TGv
	SgP7GCuXEVvOr3VIFxF6R8gOO+fQCaiIPOXwCCfyxw/zrK9PR/+f7pGFAtTi5h56nWcMMjPn4iB+n
	GUECGTGt0lCXTt8X8ZzsT96DYT7ThmuUmV7nYhX/JR1goQSG3EbcEuZgVKIm1K2XArEUoGwmShAPo
	E1jgpW+nN5P+XYoajz5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmEx-00000007Tks-44bM;
	Thu, 05 Nov 2026 01:26:07 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOmEs-00000007Tho-42vQ
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 01:26:05 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-1a3c08d6928so2047853c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 17:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793841962; x=1794446762; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
        b=oPxhrOZee5+xQkrM/d9txT9k43+xJqevCPdfEIDS/Mq9cuDFVewzMZ+PqwyUF90JrV
         +0/4zXued6JB8swbzzUOGGMnew/jwHnKTTO/s3HqlhdOz30o6G0WUmvTOIxYt17RJLBp
         zoUFohB9d0wIKJv41XoS1mcugZL9zKu+kd24GMaknWbb200qk+KwQOwHqEwpfa1DmTf0
         txdQ1eP77thUJjT3B1roi8dAVYDrPLH9mgqOkRiXG1A+L8z9JdFArLM7qcRmT1TPiF3Q
         Ob6/W8EgceBVWp62jATWVg2ZeLjLerQYp5h9rg3OaH/bHK3Iza/Uqebruu0oiEjM6Yk7
         aIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793841962; x=1794446762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wJmfnRvLC1EfEtRsVvAyQqePX9S5Xn9AJOFw7AAvahE=;
        b=qGWsV+fiYX2bBLhBeiF1Kd6tYOn2yjWZqhrs7luCfyS01UOy0IMi0H7axW7Cc4kEbf
         zj7W35ACG20DvB2rjIqpu5Mx1UiHCvGclLjDfBEoZJ1azCM/Auco/uuDuqsDQmxGPQtP
         q50n3AzOkv53W5WRBuVR83rB+mReYaJOT2VhUGbncpqJ/BoodKO1M3e6ns5xzTEyUU9t
         2+taSvIh5Ra1oRBV/rJZc9pleZLTnIdsTMAA94h8RgF7kA82P0NS1L6IaL5sz7/jdqZE
         tUb6OfGfqVMsZBsc5ceKxULY4DGIlKOkU2MouGhD3mLiPtTM+vfXgyflCBVNXQ5Eb+3V
         876A==
X-Forwarded-Encrypted: i=1; AKwUvBxuk8VKOD7tRYEZPdfFkyXYBMgGPBmNynr+qPsZb8bNLVqOkgMpyI1ZQzwQPbEkCEVPUjEeBwQ29Bh7@lists.infradead.org
X-Gm-Message-State: APuU4Z8JYhb4sc0Om5v8K25065HLPvXrdQrYUnEr0CDUrZBWfN4zzO0s
	kcQHGgdF5Ja5xAWPnQtRcHbtpgpD8rWkQ8cn8n2iIrwGJkpRWKyVahN5
X-Gm-Gg: AYBFou2wK0PYA8O8k/9fBhQ3Ru478O4YxMeEwGqbhlCmAmFaN0/UHku7+qprRY0jm/D
	2710Z1JDFdVBHZcLIfPEGLIiPE3jNvBIdCUpj6wKYbXdEeAo/wixwqM++lGejOA/uiG06ip3Tc1
	isFliOSL1W5vCODjXoHhg2mRAav8xtdMK0DGsafapfeJT6BT9x4KZqhjjE6vBYb/GH8zJzEnQ5n
	JJfOMVkJUBTbKS4Smx61DWnqWWSiWgvg9GsPNjM2NDeDEInYllCPvJeEJGS5VQESG9pQSIfgWEk
	EgTlDr+En5WHHiYsp6MSxImWCJ66LBarfJls1eiWf0NbxSj+kP4aECLD/A7GAk6sISCsoePPfrN
	Ga/h4cA6FChdGYCGHVXHkv6IpbD4+hy5P7I+yAcDikif41snJSWEIL2VEKK0oXjfX4FcLWtfSUQ
	jPu5QCJTYrc++oBnpxmA/TDjU6O4Ke7OtLRaSCYHvzq14fwUa0Hf6HawzwekjrD/Td3gDz8Ia/x
	EQOURsx+AosjpoZWdJf9RiHYtvEEHddOZVi8AOgD3CWnH7kfrVd/5fuFcXjN2AtC0ds4Bxvr43U
	eOh6Y8PVN3zKRmsiKyAn
X-Received: by 2002:a05:7023:d0b:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1ac5de53bbdmr27814824c88.41.1793841961963;
        Wed, 04 Nov 2026 17:26:01 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245b8822fsm13868493c88.2.2026.11.04.17.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 17:26:01 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	=?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] srcu: Add list_splice_init_srcu()
Date: Wed,  4 Nov 2026 20:25:56 -0500
Message-ID: <20261105012556.634691-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
References: <20261104-bug-nvme-remove-ns-srcu-v2-0-feb64ecb96ca@gmail.com> <20261104-bug-nvme-remove-ns-srcu-v2-1-feb64ecb96ca@gmail.com> <9f8c94ff-29e3-4ea5-b9ec-b04b2bc21b1c@paulmck-laptop>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_172603_020819_224BDCE2 
X-CRM114-Status: GOOD (  15.84  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:14:12AM -0800, Paul E. McKenney wrote:
> I am not inalterably opposed to adding a list_splice_init_srcu(),
> especially if quite a few more users show up, but here is what I was
> expecting people to do:
>
> 	static void synchronize_my_srcu(void)
> 	{
> 		synchronize_srcu(&my_srcu);
> 	}
>
> 	...
>
> 	list_splice_init_rcu(l, h, synchronize_my_srcu);
>
> We need at least six uses of the above idiom to break even on the line
> of code required for introducing a list_splice_init_srcu().

Christoph, as Paul would rather not add a helper for a single user, and
the idiom above doesn't fit nvme's per-controller srcu_struct, would you
be fine with taking v1, which open-codes the splice in
nvme_remove_namespaces()?

  https://lore.kernel.org/r/20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com

It fixes a crash and is meant for stable: a reader in nvme_wait_freeze()
can walk onto the on-stack list head and use stack memory as a struct
nvme_ns, which KASAN reports as a stack-out-of-bounds read, followed by
a page fault. A shared helper can follow if more SRCU users of
list_splice_init_rcu() show up.

Thanks,
Qiliang

