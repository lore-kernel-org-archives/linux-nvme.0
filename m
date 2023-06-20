Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F90EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pwJVTWFncSzjc+l1Yhd51dG6i5rhrUHMbknhWZyR0Uk=; b=CuH63Ocwi0EdcEDag/TCl/mmbj
	samdSBMSdlKe3rcJWrZJh4N+XfzCJrbm6y6QWWNSyKUFTTgq2vrcwlUs6P+20nVTJXdYr91Zwb1A7
	8zxnB6/e/4YJv1cvVG95vqoz0Gm0RhXY82tuEbyLYxvwajuDmvJ4eOs42yMnwnka/XTEsxYgBJlTu
	oss6HL0/J0Gd/tFoM5WCUfiprD+KrwIzc843f29yoESs0RYFgc1TSyJgwAVNEc0vSogz5kKgdSkOu
	CX+g2qrUapJPo0Mbce78vvfg0vQy/QyofblgGJKXUznBqRQ6jEIGMxyEaXXggp4DWwputfd5qHoIc
	KX6GOFbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBdXx-00Bi3I-1b;
	Tue, 20 Jun 2023 15:45:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBdXv-00Bi2n-1u
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 15:45:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B490A612D5;
	Tue, 20 Jun 2023 15:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B4EC433C0;
	Tue, 20 Jun 2023 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687275930;
	bh=s8n1RbX8XpcyLzcDko3oRAv8NtatDL7X3Gj4CRIxIvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbG22a0XdmXadxbVW6fNHk7an9XOS2sFUccUDFWBc8dE0hhAwBvsFL+k3tgXi9LyQ
	 octaPU6HWo4barZvoYJhBrOs5a+OX2hBC7Fl46K0Lf0o9Atu1UkfuElLZ9FViZpQ97
	 9JN7mEYAufvtYc8ne8EXq8ljsPP/aDGXYqnHi+0FvAlf9v7TCMxiQIW+pFQHQz+FhZ
	 UJ9ffRxkvAWO2AqLIZzjY2yanxVs7mvJSSMfD6T+goJEJN1B5mcRcyp7Qyl7aIM8Tu
	 W9s5LniZ7ILjNAgmn8euHXbi0aMIAV7TVaINmgtbcyNUvHd5wf1Xf+d0AYIDSVCBdy
	 sMFUw67NLeyCQ==
Date: Tue, 20 Jun 2023 09:45:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Message-ID: <ZJHJlrfysHJUQvXC@kbusch-mbp.dhcp.thefacebook.com>
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
 <ba5df67e-534d-6f79-6277-80c755ca7e94@nvidia.com>
 <3decbaf1-250b-9b73-70fd-4cb9a204c452@kernel.dk>
 <00537d0c-159c-a802-6ed8-209109a69660@nvidia.com>
 <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e74dedeb-8fb0-8abf-5b14-1aae8e1462d2@wanadoo.fr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_084531_690556_905A4A67 
X-CRM114-Status: GOOD (  10.08  )
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

On Mon, Jun 19, 2023 at 08:08:38PM +0200, Christophe JAILLET wrote:
> All my other nvmet patches have reached -next today, but this one seems to
> be missing.
> 
> So this is a gentle reminder, in case it got lost somewhere.

Oops, thanks for the catch. I'll queue this up for the next 6.5 pull
request.

