Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33D2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 14:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ck40GASmpYk0I2195PJyldBW9xgwNgpn7EO5BQMFfFE=; b=PgajXgmrs9epW/NVhg+OaPCEZb
	09GZEBNEGW3Q5x7YPmGaPmyGaEEvkWK8npbypFHrib0WzADLImtG7vn/IxBEL2mcHzNNr8jJ/qvo+
	m4o6K/4tFS2ESTLFC8anUzw6NNKXbGSQKzlEhfsaQhLYKu1qn6CeLqDxQR8g0LtMHxG/jTPIPl0An
	fGSpGrorH7/5GF5+lHVJzIAfw6Yg6V2cYuF+cpr2Lmri6HtYOyR1rB1rv3E1YCpPY4i8xW02lF/W9
	tWUA0bEeRI8mM3dzauAsXgL8oZhPqNfEFeird3Dl/ewfkVG9LIu9Dy5udFU3RlaYRftBTA6UWUyRU
	3Rw3KRcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neeCf-001SAV-Rb; Wed, 13 Apr 2022 14:42:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neeCc-001S8Z-Vr
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 14:42:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 18BC960C8B;
 Wed, 13 Apr 2022 14:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DC9C385A3;
 Wed, 13 Apr 2022 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649860957;
 bh=wt+96W4N6KEVP7yuy1JD6Ag1Rj4ASTnN/cfUZrfhoKo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NmiP9wNvu7ZmCyHERjhPJWXdgtxwqb75aA3Xa/46iJwirKmQBB9hYuJ/ytUeFBfJy
 G8vndEMXJG0hh2f5l6SjQ+CberLJ5lDx7xnDT1ERkfqWB0Z0GalZV/3WEdENFB0e9a
 9oWJS6/B+8+/SKbGgUzo9HkNvDe3BAGJiUWnjrH5OPSz58dHlaKtRzt7jlE7xrGJh4
 7TbmKE2gvxSSPho+tT2WWmYLJu4aBFoD/1CfqdvxFicbtAnfzSR52lcg2hUHaEDsWU
 I15aQWX0XtEYX9Z8+EN3yPWtEUV5IqrdxLLdH57p+Ph1SW51QvzD0kasecp4k3ycCe
 YG9OPVR8HqjzQ==
Date: Wed, 13 Apr 2022 08:42:34 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Luis Chamberlain <mcgrof@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, linux-nvme@lists.infradead.org
Subject: Re: quirk broken namespace identifiers v2
Message-ID: <YlbhWtQiheNpTSYt@kbusch-mbp.dhcp.thefacebook.com>
References: <20220413044905.376785-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413044905.376785-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220413_074239_096399_CDA0A820 
X-CRM114-Status: GOOD (  14.18  )
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

On Wed, Apr 13, 2022 at 06:49:02AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds a quirk to ignore namespace identifiers on controllers
> where they are completely broken and then quirks two controllers for it.
> 
> Changes since v1:
>  - validate namespace descriptor sizes even if ignoring them
>  - also handle another MAXIO controller with the same problem
>  - fix up a few commit messages

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

