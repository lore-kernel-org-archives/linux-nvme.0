Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB8CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1iqjeSrJ5Ef1hL1kwB6vEFpEssHo21dWGiIDk7NVsTI=; b=R2nJKoGj/5oxG5QKZqGiatsg8x
	zgyb9a6GO2Q6iNRiiP1qnpNgNkCIuxpGHHkouZLrwAR/5m7lGRs8pJT6kS8d1Oj9wzFeKymy4pYcx
	T5a+C39nhlXQIZmpzL2ph+oMPnZAlnsrqGeg9ZTBYln7ZfuY8beMzMDYrU8MgncXiDU8txfhovZ5n
	ovIQ5qPTZsRqkph2JlJ68PCwj4jan3Gi7vbW7a4DaGos0zOPhOzou3BecPZt5/NZ0SEMVuunONW8a
	z5y17Kilah6A7YZnkcYPzHUOxDnfTkV9ll2RUOrAycVWoKJrMhVxWPCosIflgvTpGdTXaCEG9GcJI
	KKfWf2bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF4X-00000004HG3-1PQU;
	Wed, 27 May 2026 14:17:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF4W-00000004HFm-00XJ
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:17:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E9F756053E;
	Wed, 27 May 2026 14:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D45C1F00A3F;
	Wed, 27 May 2026 14:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779891442;
	bh=1iqjeSrJ5Ef1hL1kwB6vEFpEssHo21dWGiIDk7NVsTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CRIwBvMIbjQjDIqWURw7sov4QbFYsSXI7Q6x+CC03ibtF+iq47f4ER8QX483k8xcz
	 ETB2yAlsVaKzl/lUF91sS+14oRhX6m650v6gm2D2DMMf3RfnDyS2cxlNOWkISnQKct
	 lchFOArKEfocGVR/5wako17kRz0eROw9siPqq6HKBeUlZea9t8nBmx42LLHNoG2Zdw
	 +XClHVWKkRqb7YIz+13ttbNkf/YYZ64NCcvKpjxq6wsWmuvoUpQEGFCIsftphQJL7i
	 mZ0g3NtY6KEApOmXMjaM97diwiyfgNRxBOgCPYaflDZh58NRWdm0NFcJnWnT3jYZ09
	 zwUNNwsKv9ycw==
Date: Wed, 27 May 2026 08:17:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: dwagner@suse.de, mkhalfella@purestorage.com, hare@kernel.org,
	hch@lst.de, mlombard@arkamax.eu, linux-nvme@lists.infradead.org,
	error27@gmail.com
Subject: Re: [PATCH V2] nvme-core: fix unsigned comparison warning in
 nvme_wait_freeze_timeout
Message-ID: <ahb88L_GJ5-7u88C@kbusch-mbp>
References: <20260521153716.548351-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521153716.548351-1-mlombard@redhat.com>
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

On Thu, May 21, 2026 at 05:37:16PM +0200, Maurizio Lombardi wrote:
> The timeout variable in nvme_wait_freeze_timeout() is an unsigned type.
> Checking if it is <= 0 triggers a compiler warning because an unsigned
> variable can never be negative.
> 
> Fix this warning by changing the type to long.

Thanks, applied to nvme-7.2.

