Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC41C636CC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 14:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sYGnilO5SwJEidYpu7qqdlYK+I+tL31/gJY8Obcx5Oc=; b=s7IJ/mhLcMlU9KogaZXgm1uKcD
	6HGw8u4pLoAAlLBjDQ0/g2t2HxCS5YWIthBCvkLSnW3Qlh3Kb9rhX3cVmfMhkChbigmllyxbzajmx
	n6gt2sCr+dA0r0eZD7rzcx7QeP7I8rhiFCKzkXQALva0PRQmqk0p8J58wPQmKwxClxuSYxxsZoO4u
	V1rSp8n8w9sNpoVk70UvHZAgU5syHZBfTYRgQ2HpdBsEEb7UijNiWkEqZwbCuPWp3AqgoYa0zTyYg
	rvTSr5cp+fzRxYi2Z7lYYn1gaovyhs3tvgkqXXDiZWx18fXVSYt9BBXAwHn/vYgl4CBTXn2Q998Qn
	tp4GEC/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSfHe-00Adkq-2d; Thu, 16 Feb 2023 14:30:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSeGA-00AKJr-4T
	for linux-nvme@bombadil.infradead.org; Thu, 16 Feb 2023 13:25:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sYGnilO5SwJEidYpu7qqdlYK+I+tL31/gJY8Obcx5Oc=; b=Qj4JKcayrP/8DQCxKf5tTW6zNM
	cHind2lnedfewujfNc69F1P/1di2UoQSJMJ0gxd1HCr3B7Sj9rSg+A0pCyRxvM/ZV3o08+O35nj2u
	7q88JZoSzq4Tp2cO/qkyvMR4c84eKI/9yfb0Ml/f0IyZctQd5FwGtYRhxv1ada7fNZO7l9h5zHGm4
	VJPQ1dZpHyAsflGSxXa+6YowUUd/R9NAjYIw8o/U0SU9Kv/8hEE6g/jIewMe9gftgV/+lYXRWqFSG
	N6QD1o94byHPtazgJHpXiTQQdB8ZBwjjeRLi1F4TFA1frfGvicFgGX1M473Cx/WxXHjex1kQJQWXq
	TjrTeXtw==;
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pSeFM-00AIAn-12
	for linux-nvme@lists.infradead.org;
	Thu, 16 Feb 2023 13:25:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 362771FDA6;
	Thu, 16 Feb 2023 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1676553902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYGnilO5SwJEidYpu7qqdlYK+I+tL31/gJY8Obcx5Oc=;
	b=Fo12/VVAevbPlGRV8PM1E02Zo1xVIzYIHIwW9FQasVapFA7eb6Y5bppDqlwozy4/CfbG4O
	DUAs2tk19iQTL3aKJcLHu0xAUa8db3U5pT8NHowZ35RhloOqq6LDWjb6fTeGceuUAWCw4U
	W2Q+RHbSNo1d7Lh1miujE6XtjPL7ynw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1676553902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sYGnilO5SwJEidYpu7qqdlYK+I+tL31/gJY8Obcx5Oc=;
	b=WB6M+iuNrhzL6xax8F+0t6+cHwSISmyTFJOz+CXf00d/zNPXtskSHnDJj+tvmaxDvH5mL1
	ZpTOyi71bW0/bIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28BA113438;
	Thu, 16 Feb 2023 13:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id +CHmCa4u7mNSWwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 16 Feb 2023 13:25:02 +0000
Date: Thu, 16 Feb 2023 14:25:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: soltime@riseup.net
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230216132501.xtvqrdpugdwme7d2@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <20230213060850.GB13968@lst.de>
 <20230213101305.fgs6ke2jyhj3j7q6@carbon.lan>
 <a0526a5ef8a1f7bb199231609df7baef@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0526a5ef8a1f7bb199231609df7baef@riseup.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_132507_117131_30EFDDCE 
X-CRM114-Status: GOOD (  13.44  )
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

On Thu, Feb 16, 2023 at 07:10:00AM +0000, soltime@riseup.net wrote:
> Daniel Wagner писал(а) 2023-02-13 13:13:
> > On Mon, Feb 13, 2023 at 07:08:50AM +0100, Christoph Hellwig wrote:
> >> I've already applied a patch from Daniel Wagner for this device,
> >> but thanks for sending it in!
> > 
> > This patch also add NVME_QUIRK_IGNORE_DEV_SUBNQN. Is it necessary?
> Yes it is. I tried it without this flag and it doesnt work.

Could you share some logs? I can send an update on my previous patch as it
already merged into Jens' tree.

