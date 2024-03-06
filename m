Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DEBC54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rHAdrEuObQpnvEX9h3DrGGAM2P4rW4PGKgvenW1gyoA=; b=dWRv4oPnj6fZcjc6J1r0e75N41
	yyG4FqsV0LFtjRr1wSp4nBOx0LdOEqb67eTQC+Jsw5V6xOtRuPdp354LJbk3kv6qq/8KqZRZ9RZcy
	cZHN5nmLFkW7FMUWOg76+pZw0rtWfprlaAjXDw9Gu+XijRwbKD3Eb1J9CkhsUA5lJP9hsogIDXV3b
	lnz3Ko/+LVR8Mmv2Irf8QPkOK50sOwkQxxiruXEk0j5uBMB1zereOKJoXHNGVoH3cIdbqvpO1pJTa
	IqHgVhDXAqDTz7JzTpAbWPmITkfNwkhHw7cXj78YmDlgdru5uJ+DzVuk7UCz9Lm71XIiO/xGEORQP
	cYkyvA0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rht3y-00000000l83-26KX;
	Wed, 06 Mar 2024 15:20:10 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rht3t-00000000l6i-2Fio
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 15:20:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9F8F2CE0B4B;
	Wed,  6 Mar 2024 15:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E73C43390;
	Wed,  6 Mar 2024 15:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709738402;
	bh=rHAdrEuObQpnvEX9h3DrGGAM2P4rW4PGKgvenW1gyoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LwjPXmX28r/xjWJMKwvRLdwyC+ePDbVuLDtsJF6g95+x9ZU5vbyulcCW13PaaFUZf
	 ulwpBx+jAMUstZSw0ZZd6TQgFCbMeGJeXOa2q6bQ15biV/e8NLNd0xfCAMtZbnf72n
	 6aFuxko8gVjNnTKxK8bBEbzRmEIJu1KzHbpDmROy3W0HFIgIDXqSghSanzxw3TzEBS
	 CeGg0FHw3zrRLPXzWtFV+zlC2/d7BcJHQtdL1aHxLvRVnMQrbHMPmCu38dmhjEKB5f
	 oL5gIoMXinHhRK9oiW+qQAQ+yjvnK24nz8gaCnsPuHs48IWOdzj6yCYbKuGKvBCOj0
	 fzSC8TEIPbhsQ==
Date: Wed, 6 Mar 2024 08:19:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: hch@lst.de, axboe@fb.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <ZeiJn6PIHVT4pYZD@kbusch-mbp>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zd4p_E8cPFpr1M--@kbusch-mbp>
 <4bc44911-afc2-4886-86cc-e0adb6be4457@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bc44911-afc2-4886-86cc-e0adb6be4457@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_072005_782832_FD823C5F 
X-CRM114-Status: UNSURE (   5.33  )
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

On Wed, Mar 06, 2024 at 04:50:10PM +0530, Nilay Shroff wrote:
> Hi Keith and Christoph,

Sorry for the delay, been very busy recently. I'll revisit this this
week.

