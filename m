Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76864EB64DD
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 08:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QNYlZ1f0ocZewGUSShPKknBUUbVLY9IZNtlSw/gRRbs=; b=IOLkIM7HA4L9UGUAax2roWJLDo
	tjmvgz0POpCu+rWjw6Q/23YEHEEcytR7NO4THR2XAbQSGHGkznMvAulosSB6ckM4D03AUmSHL9vKN
	HdO0Uw/zXZ+TiPDa9lesJwkCgvD7mcvNsQf7gzwS1CvGL+X4jpOspnSg/S2VS24KDhekwMSo4mxUq
	LoyjmVQv7wjNkTnvrROnsJK6Rvb/YaHo6pucv+We4CbHO4vyFXPwe1SZJjDyPgh8IkjlkPy6yLGyY
	92pyPmA9ol1yg8YGjE4pUAjfyqp5jJQlKucEd4JyaxyW7KmmQRFYxFZ0smowPc1Ki5eO3RyE/9OUp
	Pa5AnhDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMl3O-00DHoQ-0l;
	Fri, 21 Jul 2023 07:59:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMl3L-00DHo3-13
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 07:59:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7743061696;
	Fri, 21 Jul 2023 07:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA35CC433C8;
	Fri, 21 Jul 2023 07:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689926392;
	bh=QNYlZ1f0ocZewGUSShPKknBUUbVLY9IZNtlSw/gRRbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pi1LCaES2QZZMiTChKwAQzweun6VN2lW87eoRK4kPIWvytpGbXQp2HnNMdqoZsn+2
	 uFjlrz1m0NxAU1G5PoYrq1GdAznzMMMCnCXAY77eREAEAjdhW9FEB9hwD6eKL4XXrL
	 onF7rawB+vUtlrV3jBFzkPMV6t83VLd7EcPQS5XEMEoCpdN2ln+t5DcmbBJ2Mritaf
	 eLF+FV3TM+UdCcpN6cvAraO6F1t9oYXgCjNPKfbNwBiomUZQC5tt8L3VeuxUWAEVOK
	 kHAL3z4oAldDPapY88zbLNcZSHLMwKMAYoLgX34DXFj6I2u8Jsr9qPM6EOzvE0gPFI
	 aQfZb0qGi0s4A==
Date: Fri, 21 Jul 2023 09:59:47 +0200
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 0/3] nvme fabircs: fix io hang in error recovery vs.
 removal
Message-ID: <ZLo688QnHRbsAmbd@kbusch-mbp.dhcp.thefacebook.com>
References: <20230711094041.1819102-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711094041.1819102-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_005955_422847_C147ABBF 
X-CRM114-Status: UNSURE (   8.00  )
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

Series applied for nvme-6.5. Thanks!

