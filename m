Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01997C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=upZGxCKpLy+NJOU0yAW1ITVD/WxHnffxoE9JTaHsUH8=; b=xaz1yZghHZ1G1l4Suk7eydrcci
	e3C0zV844VKL2jxR8zUX7rhxjyNPHL/VBEhqlh6QJrKYSj2XO2f2+80eKNeEDiaOyohMTm8mnfATZ
	3pismGTA5mXbPO7Ljkq70CV37gmQpFYuroFkT0jv04wyY8RGEBFk3CXO23tjPOJ1Xu65SJ+iYJ6IV
	P+6KY0jC6MWcst0th+I4I8580hrGWR/TFIzmkD9v0m51Yycr3Agd/3E2eKuwpM5ColHWmnbuoXWdJ
	qXHps+4Nr66nbi4cbiCQCKqT7976dh7njG/M1mOr/jTpkZPI3GySKqb5qzs1Iy0uP6BZzMxlg4RPS
	mpKbyCig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX3pK-00EF1x-22; Wed, 23 Mar 2022 16:27:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nX3pI-00EF1n-OW; Wed, 23 Mar 2022 16:27:12 +0000
Date: Wed, 23 Mar 2022 09:27:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] dispersed namespaces revisited
Message-ID: <YjtKYETOnoI6/x4E@infradead.org>
References: <521666e9-9114-9c2d-c680-a52defb45f8a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <521666e9-9114-9c2d-c680-a52defb45f8a@suse.de>
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

Hi Hannes,

the answer is pretty simple:  dispersed namespaces are a bad idea and
will not be implemented in Linux, and this has been the stance since
this was first proposed.

If these vendors want Linux support they can already trivially
implement virtual subsystems and are highly encouraged to do so.
(the concept of domains actually makes it even simpler than in
the beginning).

