Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC850C32772
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Aug 2022 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ODgflHxLY7ifEtHuTknv/iIzuEnQVv7SFFqxPeVCr9o=; b=oYQwLF7Hxm7GNGtjNRWOiKFO9O
	xmPGJ71r4KPEZ9eCjKXGJ7Vi9D9JTZdWMcuz9VdGiq4UaV9PWV7gadowYGNrDyymh4Bq22OSIRjg8
	O3XzCwb+eY9b0m70UdDVl24oXMnqB3O2TOxiXJe/Hx6r+MoccIe1IR3bOQjt/o3tNZ2tmewD5EV2R
	zQ+Ze14y8kzZO03TpHhw/vF8Ja0rUPrvbLAp1O8rPLfmzwaRX4nvx6OV1uKFzw83z+jwSKWrDN7Gb
	vXhQDSbOLfyCGshuKd9IrGq229dBo1r3XEFYikXzf6BDh97qwManVJc2YdC+HvbKGxNmUIYEpxk8D
	7u2k3whw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQWWa-007DYP-HS; Tue, 23 Aug 2022 16:13:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQWWX-007DUn-9C
	for linux-nvme@lists.infradead.org; Tue, 23 Aug 2022 16:13:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DE2968AA6; Tue, 23 Aug 2022 18:12:55 +0200 (CEST)
Date: Tue, 23 Aug 2022 18:12:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Tal Lossos <tallossos@gmail.com>, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [bug report] nvme: NULL pointer dereference in nvmet_setup_auth
Message-ID: <20220823161255.GA21462@lst.de>
References: <CAO15rPn8MBD5+QX31xjFsccT_1bRSuYYm2P1cTWqTydZTkiH+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO15rPn8MBD5+QX31xjFsccT_1bRSuYYm2P1cTWqTydZTkiH+g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220823_091305_491375_6222BCF0 
X-CRM114-Status: GOOD (  14.72  )
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

On Tue, Aug 23, 2022 at 03:23:37PM +0300, Tal Lossos wrote:
> Hello,
> There is a NULL pointer dereference in nvmet_setup_auth() introduced
> in commit db1312dd95488b5e6ff362ff66fcf953a46b1821 causing a DoS.
> As of v6.0-rc2, in target/auth.c:196, if there is an error with
> ctrl->ctrl_key, it gets reassigned to NULL, and one line afterwards,
> it gets dereferenced in the call for pr_debug():

Hannes, can you look into this?

> 
> ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
>     host->dhchap_ctrl_key_hash);
> if (IS_ERR(ctrl->ctrl_key)) {
>     ret = PTR_ERR(ctrl->ctrl_key);
>     ctrl->ctrl_key = NULL;   <--- Assigning NULL
> }
> pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
> ctrl->ctrl_key->hash > 0 ?   <--- NULL pointer dereference
> nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
> (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
> 
> This bug occurs probably due to a missing goto statement (goto out_unlock).
> 
> Best Regards,
> Tal Lossos
---end quoted text---

