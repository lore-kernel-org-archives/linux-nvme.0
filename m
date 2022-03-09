Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50FCC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=iY6BNWmvAj/HeBaEiEZqElrJaD
	JYqpwyrfxbsuZ+mk86d6IVFjlKqEn9PawT2FAf8r3MLCaP5tuRxnTMSQmwzZLpLdoWV7V60pnyq2R
	kKTpylVad+66oI/ofxgxSl/Y47ZW/QJr0d6IfunPzCcLslwpPNowOdM+LjfDjkoN9KsnrIMG/tbqy
	3uV7ZZurQtd6Nd6htd6IsCYGmaouYwPlVkhgHQ74n7Kxms9odJ4e+Uw/1yLTB5alwL1NEa9zlTigf
	ELEG0y0oY1kWiBz9okL1iG6VuHI6uFx+UC1j57kSTQFYoWWjY0mB2kLlh6lGK7n1JAe0s3PwFvyhH
	SJYTtFSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS11z-00A4wY-5Q; Wed, 09 Mar 2022 18:27:27 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nS11x-00A4vr-VQ; Wed, 09 Mar 2022 18:27:25 +0000
Date: Wed, 9 Mar 2022 10:27:25 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chris Leech <cleech@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/1] nvme-tcp: lockdep: annotate in-kernel sockets
Message-ID: <YijxjZivd9VxHcF2@infradead.org>
References: <20220216022249.2856536-1-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216022249.2856536-1-cleech@redhat.com>
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

Thanks,

applied to nvme-5.18.

