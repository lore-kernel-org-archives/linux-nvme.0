Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5F9C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9755iZc+qcLi2eqpV9mokXTePxbqV61F+p6upGThYSE=; b=O/RIyJ8YbIcdPCFzRQmryYShl8
	BLI8+1XvosYdPuSZ1tVEyNxTmJXcZV7NZDXbfa6fLzpZ2N4ZsiuR2TWbNdhwG3VIuTyZNXnoFikOc
	APkQ5avRp6MUMZmXIlLqcGue4sZhg3sfgZfG8a32Ky3bhppHQEI1pd9sVTPQEIFIOW8VjtDn2xHOj
	Q8iJWXDQyyu1/7SoJS0n/8a7JcgUDwjsg6zVFtB5cW0X3+xpbYMgjeau2daMQmWZJ2Vd26Ghmqnan
	w3H08MGy40fDB3Nv/Kp6uRHHGJXgXnQAw5zGZfAA5MjyQ6o6Z2fRI+Zvn3wAAoHWopeTuto5yutPG
	MfIA5lUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV46f-00000001fbu-0Kic;
	Wed, 31 Jan 2024 06:29:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV46d-00000001fb7-0Xag
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:29:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8C98168B05; Wed, 31 Jan 2024 07:29:52 +0100 (CET)
Date: Wed, 31 Jan 2024 07:29:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/12] nvmet-fc: use RCU list iterator for assoc_list
Message-ID: <20240131062952.GK16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-13-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-13-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222955_335423_CF3D3C9E 
X-CRM114-Status: UNSURE (   9.20  )
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

> +		list_for_each_entry_rcu(tmpassoc, &tgtport->assoc_list, a_list) {

please avoid the overly long line.

Also in general the (rcu)lock, list walk to find something, return
patterns tend to benefit from being factored into a little helper.
Not sure if that really fits here, though.


