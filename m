Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF81CEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 06:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFqzsb8uGReDkFf8qaRy2Px60pQu6qvTKxR4NKdNPW0=; b=3TyyOD4q3cIRO/rLnVAtAFuqgX
	ONjXtGq3Z5Y9kNocK2VfuJFzbaq5/XFDs1/A8Gd3xk2VGvC+Vs0C3Ex9SbJqNHDtEeyDiAfhPNA/I
	9LFQTqtt52VUgIMQDCRhyJOY+isLUUuhhIimjPd2hg/EI8ip5doxyeowlYqDCjRmX2/Ilz8sijBBb
	XNBq3R9Zf8+QNf+i67sDKkTLLlE8/rC65yiiUgXWbhdrOyjwwMjXDllEM9cbfcHJJI6AWIEv+/mCw
	9wcipgKNJItSX7TGht1X6yNKAxz58d1eJIr+wsJN3lQS2jJKkisH6IO6NHytBS+D8+8dO46rbAi3z
	RWLvdG3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM0PS-005aaq-00;
	Wed, 19 Jul 2023 06:11:38 +0000
Received: from desiato.infradead.org ([90.155.92.199])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM0PH-005aYH-1n
	for linux-nvme@bombadil.infradead.org;
	Wed, 19 Jul 2023 06:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sFqzsb8uGReDkFf8qaRy2Px60pQu6qvTKxR4NKdNPW0=; b=CRNO3rpT9fAxa7st3r0P0xR4Qt
	xGhBM6H0wa5FPqG4wFW8CZ1s8ykPmzdpSLWNUuCxko2K9FZ/XqWeliqPDzoLVsmFwxa2Rh6tm9qOj
	GDFvm1GvTfsoS+QQkePkHAiOLn6/sFvrZzTuo3TaIWtqCbutR43F2QU057zidUuGbUJAzNGcga249
	WvUH1ifXk7dHRux6haJ7a4xuhxgb4f2QpVhgwSg/lOlZssbKlkVTWwN5E6l7vJeTmzkgwI5HRpq4W
	aylSlTGUyNuzx/R0Li6r+kCoy7vsvpuacAhgWTAuFcfWQxEW1Esytfp2RWL7LWt7tKZcDH8nNA4Bq
	8sesvXOQ==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qLpv7-00BvPc-2b
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jul 2023 18:59:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BFDCD616A6;
	Tue, 18 Jul 2023 18:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157DBC433C7;
	Tue, 18 Jul 2023 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689706762;
	bh=XfUR3bmNgBsO2KU4d/1fcEto6Y85MNBj5coGiduXoU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dkuqskzXE9YKa74nfeH/NR/dAjv1VqwlS1rfVXTMwEmvAHO1cF22gL4B8hWvroXsP
	 UHrzjTgsOcS7HLnvJ2TXDZ8Z3O3Eok2A2zlfs5slvbmFPVhoYO7qF5FOdLLPErU++4
	 rWxzPdXS6O7dAcJ81ZP6akY6akWujiOOkU55r6ZA8cqC0pwDfogHyQz9F+TTRRNE0X
	 A5jONEYdPoLqJL23k0fR43IZUguLaZquhNh9nY3QV+0d5bGFVYceDg8EV4zyg2Wi+N
	 t7wmpEzSRUmf6VzVXMn8Nl3BYU3bP5KQMV6LPYrrG8s6MytTu5X/UprAb6ELxczHnR
	 msNjnRjlvjlEQ==
Date: Tue, 18 Jul 2023 11:59:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "open list:NETWORKING [GENERAL]"
 <netdev@vger.kernel.org>
Subject: Re: nvme-tls and TCP window full
Message-ID: <20230718115921.4de52fd6@kernel.org>
In-Reply-To: <a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
	<49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
	<ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
	<a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
	<6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
	<1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
	<9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
	<a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230718_195938_072542_A83B9D18 
X-CRM114-Status: GOOD (  10.25  )
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

On Thu, 13 Jul 2023 12:16:13 +0200 Hannes Reinecke wrote:
> >> And my reading seems that the current in-kernel TLS implementation 
> >> assumes TCP as the underlying transport anyway, so no harm done.
> >> Jakub?  
> > 
> > While it is correct that the assumption for tcp only, I think the
> > right thing to do would be to store the original read_sock and call
> > that...  
> 
> Ah, sure. Or that.

Yup, sorry for late reply, read_sock could also be replaced by BPF 
or some other thing, even if it's always TCP "at the bottom".

