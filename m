Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE64606D802
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=H6ca6YvP;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rxxbmmxp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=F8pFZttgkMUuGwTbPVUzTKwXNXUEksLNie+O1XNgO4I=; b=H6ca6YvPnd0AlkwtdtblrR88kY
	ydDyzMp8RgSQeIbFUPdbHnlinA/arGLaYAv5GB7qtMprVD/dkXoE5Q90aZ8Ugm+q96h7+0XjQp1GS
	ZJT3INBR3nsBf1cUnXimzwVcPJgLg88Oom2JtSqRjzB0Ki/hYDeiilME8NF580b8XeX9kzQfhBRRm
	m840SePAzcIZjzwZMSNaB6+WZbRA+RJE4jf9ZpXGxPHnMQw1d9q4W5zhq6OR8fYhrXLnePRwnmSCH
	xFHNCUa9zg8rdrttFBT4Mj/t2ka6rtdi2KM1pWckddnJgtEcODZFLC4ddD/CS3BO8a4BWzz0hUEAF
	9lrRzY/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkeV-00000007GdC-2l12;
	Wed, 04 Nov 2026 23:44:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOkeU-00000007Gcz-2t9L
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 23:44:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id BE0E260267;
	Wed,  4 Nov 2026 23:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F0CE11F000C1;
	Wed,  4 Nov 2026 23:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835861;
	bh=F8pFZttgkMUuGwTbPVUzTKwXNXUEksLNie+O1XNgO4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RxxbmmxpjVIzMW01FPySsPhSedoUdkvXkNVYNw2LjEQSB4230rP/pH6QHcVVcaFnM
	 GGJlGkS9wYfmh3GkPEZU52ueQxF7T8qSarKL4Xv9XG+cEFNP665Q6RkrD4lOkVotMg
	 KCmCekah4H0UwZT9drIQrS/aVAreAL2B03D0TTuWaGevSLnKIj8TRfg3gbBHQkuqx3
	 I4gRrozFzbeM3vOcCFpJTo6qBKHjrwml3gEplWLTScBqbKJoCDwg47toI8smquqVpQ
	 o6HcdEr/L6XScw7ZbIx/pAs50q+fchbS0dpS1gcZ06VJZKioEipIiYB9hd6EpmwETo
	 cf9JFiQL2xXtw==
Date: Thu, 5 Nov 2026 01:44:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org, stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Hannes Reinecke <hare@kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: (subset) [RFC PATCH v2 02/11] nvme-keyring: Add a missing
 key_put() call to nvme_tls_key_lookup()
Message-ID: <auvDUbg2pr42d4-y@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
 <179382463580.3441171.16018709754015712565.b4-ty@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179382463580.3441171.16018709754015712565.b4-ty@kernel.org>
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

On Wed, Nov 04, 2026 at 12:37:15PM -0800, Keith Busch wrote:
> 
> On Tue, 3 Nov 2026 05:02:07 +0200, Jarkko Sakkinen wrote:
> > Call key_put() before returning -EKEYREVOKED, as the reference count gets
> > incremented by key_lookup().
> > 
> > 
> 
> Applied, thanks!

Thank you and apologies for all this noise.

I'll send standalone patch next time if/when this happens.

> 
> [02/11] nvme-keyring: Add a missing key_put() call to nvme_tls_key_lookup()
>         commit: 404a8f6caa63822c1d2a45adbf07fd9c0567a7ef
> 
> Best regards,
> -- 
> Keith Busch <kbusch@kernel.org>
> 


Br, Jarkko

