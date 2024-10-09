Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C23CEE354
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 21:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/aMd/ZkrC4glpwfd56CQ1YfX76E5mP68VqmFcjOdrvs=; b=cyENwvXaUbHNiEBOWUJAlIAQtS
	EW71W0uYDvuf76kRGoVQM8bRUryBFYFXqbfgIuYmn5Qik4MLFN3ZOA7fbAt0st8u8LA+yz7fCjLIP
	ieguxvox7P0vtJdLek1DbaOQV376h3yw5ijhTQkIOv4ccXkRBbYTSkY/cFoG08HPlJ0d9loqZg1cN
	6SHpGVpaqocK+1vWe2R1WhOPGXrdPyTnPiwqIJSkkbGFCRwLnHW2zaObGuSfi8GuUtsQvJpH0dM8/
	WPTehTUX7/NGOxTiaSz9HwpKlTu2X0P01PWRT3n8FMC9O8OqRZuvDGnZTCrC+Wbz8unYMW55FU7Ne
	ueEV8a1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sye2O-0000000AkPM-1CKw;
	Wed, 09 Oct 2024 21:16:04 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sycf7-0000000AX9W-1iug
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 19:47:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9F504A4295F;
	Wed,  9 Oct 2024 19:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3482AC4CEC3;
	Wed,  9 Oct 2024 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728503275;
	bh=Y7xFUQsKfe5QDI0mkx9tawFK6NuFfCSDGCwpnyEunhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SKwHpvcGew4r/XuFm6fHVR/9lz3rnzVEOEc0Rhd68RGXGrBtz5uueyti+BBF8QFhP
	 K++85rBW59Ucnx/K59teK5PFUjcnl94n0LLvJ730LEmaA4oA215FEFvvq8ASOv9JTd
	 ug0EkNmdJeAHecVY4G/xFYUAzhVStZy3m9lR/Hc9nFMu5/3hu+aY2b80wtrMdBK0iy
	 YEd0nt1QYh8y68/LgKWQr1cI4+uJ7vwHEwBblNoI73qgbmuXNOFduf4busKi7Wvxsu
	 GysIBpc2Eb379Vi1WnQQ8Kp9vE5SpsCtLBDMbZ2ejKmuI2Y9t6luRrwoP6T9rlJS4g
	 RVF3QqUkM8SRQ==
Date: Wed, 9 Oct 2024 13:47:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de, msuchanek@suse.de,
	jonathan.derrick@linux.dev, okozina@redhat.com, nilay@linux.ibm.com
Subject: Re: [PATCH v2 1/1] nvme: disable CC.CRIME (NVME_CC_CRIME)
Message-ID: <Zwbd6buiALj4qK2a@kbusch-mbp>
References: <20241007193324.5846-1-gjoyce@linux.ibm.com>
 <20241007193324.5846-2-gjoyce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007193324.5846-2-gjoyce@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_124757_534212_37FE4375 
X-CRM114-Status: UNSURE (   8.10  )
X-CRM114-Notice: Please train this message.
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

On Mon, Oct 07, 2024 at 02:33:24PM -0500, gjoyce@linux.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.ibm.com>
> 
> Disable NVME_CC_CRIME so that CSTS.RDY indicates that the media
> is ready and able to handle commands without returning
> NVME_SC_ADMIN_COMMAND_MEDIA_NOT_READY.

Thanks, applied to nvme-6.12.

