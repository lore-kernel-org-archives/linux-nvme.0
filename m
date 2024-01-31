Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B74CC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bST86C1JrsS0xSzjYSBT2rQOSPmwNfUqZGcJ/iSiVV0=; b=NXfprL3nzY6q+9jHUnIOk5no2L
	ny9Ui26R6rl3ATP9+g51Oyltphn7p+YEuQNI66caPqlWZNR+33ISpj79UY/NBBpKsPAFC5Fpowo3s
	3hvIU9lhhR73/D8W8nC71yXAQftKVh+f/fWxOW+mkzQLKwdFOZd3SJj+B39w7jMyiJ9NkjAVQ/gXM
	5qWAgoeVFOZXl+AMLvvw5Atx3Frt0NF2CvGhVqW5e1uyQ2awgYLPufs2e4sAHlUBoT9VDnTwun2DU
	onLKfiSZFuft3A7IuRReSI5rXa+1/l0rObADkn++or6y9v+t2cj00Yx2kGEicHDth+/ihVDGCom9/
	KBevKCQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV44Y-00000001ed5-3Xwc;
	Wed, 31 Jan 2024 06:27:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV44W-00000001ebd-1yES
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:27:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEFDA68B05; Wed, 31 Jan 2024 07:27:41 +0100 (CET)
Date: Wed, 31 Jan 2024 07:27:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/12] nvmet-fc: hold reference on hostport match
Message-ID: <20240131062741.GE16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-7-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-7-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222744_704546_C9DB4304 
X-CRM114-Status: GOOD (  14.29  )
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

On Tue, Jan 30, 2024 at 10:49:32AM +0100, Daniel Wagner wrote:
> The hostport data structure is shared between the association, this why
> we keep track of the users via a refcount. So we should not decrement
> the refcount on a match and free the hostport several times.
> 
> Reported by KASAN.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

