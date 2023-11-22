Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516EFC61D9B
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 16:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FzjHwJd4VAOu40MKlnpvliehQSMY8+511qOeNztlm+8=; b=WpWH25H7ZRaPpsYm7kmvQv9cuv
	ag3qT9pb1jKzs5ku4HSiim/oIezst3LAfXyaNsNiDkO0CqpejQybKCGufNrroGLCUyD27N3gbSOWJ
	JF/kZ+Og8mfpqYK3eMzYPN4dEhBJB1OeaI5vINCQVx4YHo6urBmuBtti/MjNEFx+ACZH7Nw7068hj
	jKn4tJdupkXhbM4VzF/JdX6DiPLZdH3I/qIm1N9TxlBafaEsVV7jJg+oEC5kVAe9LbjZKGTOdvmXV
	2FSfCQgw4dpYYxWl5R1LLaF58oJe4HdRounZUzMlZyJDGN+fP6PrdHcH4IMrrpkmOqMgbuMhIl0As
	8QA6kcmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5q7x-002TPF-0p;
	Wed, 22 Nov 2023 16:31:01 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5q7o-002TLs-2o
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 16:30:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E4653CE211D;
	Wed, 22 Nov 2023 16:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888CFC433C7;
	Wed, 22 Nov 2023 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700670649;
	bh=21UmIhTfVBhVa/ERcRohCDVJ6CbvehJirYtrDJwrykI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tB4jv9yiVZu3u4evLipJPevj3nxtTuSCIWmk/1KI1KQx3Hz99zGBU2FsE5QD4pFbs
	 ZJLEfwZK2lSA1o7+fOiaQNinD4VRckeJFMJaWQQxEvyPMnuJlc2tXd3k7wuxWmFw/R
	 efAupHK4YuT/UGIdGV7nuHBNS3HxkWdpMrOcutYcU7IJt4QFgHiwHsMWQpiZgGmaGy
	 uXEueGStYQQ85PSYWe/OGca2JzDdrLAIpaYzqWo6VyxFj7FUrLj6+5a9IJ7SwD194H
	 j0LBCB3XXggGO/ZH47yvXkdmVjCfj22FSJcQ/rfYFBuDnzCM83IDsBR3h0LeZGyS5h
	 2aHafytRXd3gw==
Date: Wed, 22 Nov 2023 09:30:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: Ewan Milne <emilne@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: check for valid data from from nvme_identify_ns()
 before using it
Message-ID: <ZV4st9iwMgJSC01Q@kbusch-mbp.dhcp.thefacebook.com>
References: <20231110163721.15292-1-emilne@redhat.com>
 <CAGtn9rmMLQfsocZvWJnnekRxfL2_s3oDYcUNTy3M0c2d8UYYfg@mail.gmail.com>
 <CAGtn9rkynCF1De25--d39D0o2Eh2QV4aDLOxaRYrw2m1ouu_4g@mail.gmail.com>
 <ZVzzW0P6CtataBLK@kbusch-mbp>
 <CAFL455kC=UuTV=sAxDYNPj9X4y=ex2ND41VXv6Wv0KLWfNcm3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFL455kC=UuTV=sAxDYNPj9X4y=ex2ND41VXv6Wv0KLWfNcm3w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_083053_086839_2112C1C7 
X-CRM114-Status: UNSURE (   9.42  )
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

On Wed, Nov 22, 2023 at 08:45:02AM +0100, Maurizio Lombardi wrote:
> 'ut 21. 11. 2023 v 19:14 odes'ilatel Keith Busch <kbusch@kernel.org> napsal:
> > The concept sounds good, though you are leaking 'id' in the new error case.
> >
> 
> We have the same problem in the nvme_ns_info_from_identify() function.

Indeed you are correct. Would you like to send the patch for it? This
patch will also need a v2 to incorporate the same.

