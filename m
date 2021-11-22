Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45363C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 14:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YDqS6FiVz+PUhurU7a/sQEr/QnCo3AMh0NDv4+1HLgo=; b=rV75Akkc2EnivjtjwB3nilR6DT
	zFInph97UgL5scG7w8O2EIRb/wxxf6mJ446ytqOPHbV7/0vdlRMlymoA1sIoAL/QcSGEyZ0geZT8N
	DR102OQqRo43E7ZxpwouEMTIJiQPxeqEYxtiCerVTiordONBGuhbyHeqRoTGIeXJoB2vrZslS+kRZ
	2t25OS9CjNfidq+b+GV6ni+4Rw/cj6mjOYpXrW4nnbiVWcip5RtzmQIKGNDLruw4RXvU69MXu/aMU
	n35tjsj7e4YsjijILbQrxHlZdoLAgdRB21ADJuqShhYmLvRUzez4NUQx3IeFN2lyKr1eA1ICvj2sZ
	oeE21wxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpAOz-00GscX-Le; Mon, 22 Nov 2021 14:34:37 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpAOw-00GsbE-JH
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 14:34:35 +0000
Received: from localhost (varun.asicdesigners.com [10.193.191.31])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1AMEYSLI009355;
 Mon, 22 Nov 2021 06:34:28 -0800
Date: Mon, 22 Nov 2021 20:04:27 +0530
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
Message-ID: <20211122143425.GA1716@chelsio.com>
References: <1637575953-3143-1-git-send-email-varun@chelsio.com>
 <76c6cd6b-8846-a9c9-d0b7-00405fe63740@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76c6cd6b-8846-a9c9-d0b7-00405fe63740@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_063434_682861_A40A0C83 
X-CRM114-Status: GOOD (  11.72  )
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

On Mon, Nov 22, 2021 at 12:45:14PM +0200, Sagi Grimberg wrote:
> 
> >@@ -2321,6 +2327,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
> >  	req->data_sent = 0;
> >  	req->pdu_len = 0;
> >  	req->pdu_sent = 0;
> >+	req->h2cdata_left = 0;
> >+	req->h2cdata_offset = 0;
> >+	req->h2cdata_ttag = 0;
> 
> This doesn't hurt anything, but it also redundant AFAICT no? these are
> only referenced in nvme_tcp_setup_h2c_data_pdu which is called from
> nvme_tcp_handle_r2t, which is setting these right before the call...

if (req->h2cdata_left) check will also execute for inline data, can it
have a garbage value if driver does not set it to 0?

We can remove h2cdata_offset and h2cdata_ttag as these will be used only for
h2cdata.

