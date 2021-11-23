Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40B4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 15:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D/dy8OhCtC1d6J8VVurNIRzi/99E1+Pozni8Dgf0Lyw=; b=bXJYgF9wY3rXrGBvOHtcZ4Pktr
	MPDJBDgmwoUVuF8liuPda6/0lmpL0PsoTcOn8gcrtpGd5Jnb+qdrLSltfKfTaItJSE7QoPebgcTBM
	41wFq0472vmQoWeYqUCyNe2gY5A3b08nvfNl/qrjBV8CNQm8gVgJRoMlb+TBnjKQZDpNGBWoXZ/LN
	YpVsarOhmrqcI0sYebkuii52jSCbT/+uog41/h3WCsZT/YJyCWLm1gOKuy8P0R81fGFEqNz1nt9Zj
	sAKWuKbjAoUBVG36gu75/1tF8kas7QGrNiJCsVlpKXS4/Vchj/A2vNG07FtwIC8tl14crvXOPYtpU
	8+ERISAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpXvJ-002laE-NP; Tue, 23 Nov 2021 15:41:33 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpXvG-002lZP-P2
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 15:41:32 +0000
Received: from localhost (varun.asicdesigners.com [10.193.191.31])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1ANFfIof011781;
 Tue, 23 Nov 2021 07:41:19 -0800
Date: Tue, 23 Nov 2021 21:11:18 +0530
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Message-ID: <20211123154117.GA1714@chelsio.com>
References: <1637665162-3609-1-git-send-email-varun@chelsio.com>
 <3b3a65a7-0885-0dc9-e78f-ac8a8c04a646@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b3a65a7-0885-0dc9-e78f-ac8a8c04a646@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_074130_848252_309146B5 
X-CRM114-Status: GOOD (  11.62  )
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

On Tue, Nov 23, 2021 at 02:58:05PM +0200, Sagi Grimberg wrote:
> >@@ -633,14 +640,19 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
> >  		return -EPROTO;
> >  	}
> >-	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
> >+	if (unlikely(r2t_offset < req->data_sent)) {
> >  		dev_err(queue->ctrl->ctrl.device,
> >  			"req %d unexpected r2t offset %u (expected %zu)\n",
> >-			rq->tag, le32_to_cpu(pdu->r2t_offset), req->data_sent);
> >+			rq->tag, r2t_offset, req->data_sent);
> >  		return -EPROTO;
> >  	}
> >-	nvme_tcp_setup_h2c_data_pdu(req, pdu);
> >+	req->pdu_len = 0;
> 
> Why do you need to set this here? it is set in the initial command
> execution...

This is needed for multiple R2T case.

