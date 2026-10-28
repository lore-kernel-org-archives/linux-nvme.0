Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E004606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 10:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=deInuSvW;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=OdjIq085;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=itDTS8DA;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKjQBjk4;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=itDTS8DA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=t2VG8ghbsZ2ehmH3QK6+4qnOak7PHYZ/7p13exiaPw4=; b=deInuSvWtSznWWpgydFbl5JTBO
	2PDeoyxxU7FJeimvg6UK5/eSYHRlFk1LkZ6krdwzne0HH94e9TM0VpbISwSaMTV5Iv6lG4G7IH+Dy
	vAdDkLSxDNzvF68eM6sQ20u2EH0yVmrrTCx9AoJ1a8621V0ZwUsxRngaiLBIIC/68oDTQRbLh7fWa
	hK5gws+AsV8ULlfF8biB46rgjKqivwpmHYSI2Avjy+givePs8rD9Q/2T9mByRBpL+zk8JILTHemuV
	wApKEH9RtvDoB0PfNxi8gu12uYbZUUNvi2t1hJbtwHXcWi/ePWKj8ruoeU2XdrnHrqRCAPCSosJ5L
	jaGq4asA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM0u9-00000006lBI-0VBA;
	Wed, 28 Oct 2026 10:29:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM0u7-00000006lBB-15hz
	for linux-nvme@bombadil.infradead.org;
	Wed, 28 Oct 2026 10:29:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=t2VG8ghbsZ2ehmH3QK6+4qnOak7PHYZ/7p13exiaPw4=; b=OdjIq085bPsyevZRnhpxYC9COp
	9jXzXaRFlFP0Wq1VzMCJlooMm/11M5O98sn0i41loNcZJ8Gtf+r12E7t7+7BJUKL/Ola0D1alglAH
	xa40/EuVp2NZIMmi2uiuru1mD3krPqmxgnWmdf/HUMJQW1izn8uYl/FkKVVukDlHrjAzOaUfcLMgI
	HRliDG4GlgSBgCKDpsEwLhy1GDnMVNb9RfsvOxw+VimqNQ+Z0nIWtXG1Np6Z2v2svFbrzVaqRKC0Z
	DgT3JG6MvUnmkiB32xgqXNEyapLzsk/VpZ58/KQN+IopInn8eWCdNOW815wx4ZXTUvZtGJ9h5epP1
	rx4PGutA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM0u3-0000000Fsx3-26Hc
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 10:29:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793183337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2VG8ghbsZ2ehmH3QK6+4qnOak7PHYZ/7p13exiaPw4=;
	b=itDTS8DA3gWoPyafbE3AtCTSmEitKWMrTKtW+5FVv7fmrYn2Zk8erhlAWaPa78gr+4B0hZ
	k2FwUcfmHlYMcmL09yEzGE/mwdjKzCdwPLPefb9Ws8EagiJJCJoChkm56k5eruqCCAyhTI
	bvLwRMJx62ORTgC2lg6RK8YNSrIQlvc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793183344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2VG8ghbsZ2ehmH3QK6+4qnOak7PHYZ/7p13exiaPw4=;
	b=WKjQBjk4xDwmnevkIgjD9yVzsF+mcTjT4f33lFwCDPh0SK7cSOXC1swrcQtzCWgzxgdPFy
	Wb+++/f3fYBgpSmQxEj2wG9VKNMU/IKBRfaLGHoH/9XTKkbuYGUA03P2niRA112mMbKRHA
	q/GmFpuYjpiaB4aLmOdBpxu9lba9PB0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793183337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2VG8ghbsZ2ehmH3QK6+4qnOak7PHYZ/7p13exiaPw4=;
	b=itDTS8DA3gWoPyafbE3AtCTSmEitKWMrTKtW+5FVv7fmrYn2Zk8erhlAWaPa78gr+4B0hZ
	k2FwUcfmHlYMcmL09yEzGE/mwdjKzCdwPLPefb9Ws8EagiJJCJoChkm56k5eruqCCAyhTI
	bvLwRMJx62ORTgC2lg6RK8YNSrIQlvc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-0aQtWSHpOb2hD8VZTNTAEA-1; Wed,
 28 Oct 2026 06:28:52 -0400
X-MC-Unique: 0aQtWSHpOb2hD8VZTNTAEA-1
X-Mimecast-MFC-AGG-ID: 0aQtWSHpOb2hD8VZTNTAEA_1793183331
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C7C81955E8F;
	Wed, 28 Oct 2026 10:28:50 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA2BD1800444;
	Wed, 28 Oct 2026 10:28:45 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Seiji Nishikawa <snishika@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is held
Date: Wed, 28 Oct 2026 19:28:42 +0900
Message-ID: <20261028102842.2192925-1-snishika@redhat.com>
In-Reply-To: <20261023122351.977034-1-snishika@redhat.com>
References: <20261014064524.4015025-1-snishika@redhat.com> <526673b4-a090-47a4-9181-e30813a8cbe5@suse.de> <20261023122351.977034-1-snishika@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: zPinTeng_Lq0KowYXtlPDTGcjDUfGc4yB7sjR8pYa2M_1793183331
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_102907_867480_EF2AF0D1 
X-CRM114-Status: GOOD (  13.58  )
X-Spam-Score: 2.7 (++)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Keith,

A short follow-up on this patch.

The problem is a regression in v6.16 and later, and this is the minimal
fix for it. It applies cleanly on the current nvme-7.4 branch. On the
customer system, the unpatched kernel hung every time. With this patch,
there has been no hang since October 15. blktests nvme over tcp passes
with it, with the same results as without it.

Hannes suggested removing the direct send path instead. I agree with
that as a follow-up, and I will send it as a separate RFC patch for the
next merge window, as I wrote in my previous mail. I can only test it on
VMs, so the performance side needs testing by someone with a real
nvme-tcp setup. It is a bigger change and not something for stable.

Could this fix go into nvme-7.4, so that it can reach stable and the
distro kernels? Please let me know if anything is missing.

Thanks,
Seiji


