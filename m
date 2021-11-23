Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D933C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/lzv0y9ANKx7zgTZMJT9oOFutOBfG8ojLv2WwEXroI=; b=wDxkFw75s96bnMSgGxpxzt5N+r
	8wJ2wyOEMnTWZL6dM33K3aqzKsHQQEQvn+KlOx5B+KvMXa4CvzIAzEo2VyEQR3M7la70zcoCSLS3C
	yE7nAE0p/x0oY3MfSRrRhUtrL4UkJlk1ytLYOmr7PoqULjfU801TxsP7EtxrCFY8byhFJ44hNkCIo
	H0taM6ljY962XKUwHMDaCzyJ01Pj8RCzFaWvefZCT/DQd3X/RXlvpiH/Yu23QRwidmfi7PQl9fkCX
	X2a+Ov7cWZI2MJdogjyG2VObBoFOqfxhi5JHWN8mdncJyKEk5gbLtY8ADAiENgG5/cChfPJFy1wcQ
	Wth1a2hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpRFX-001JNB-3f; Tue, 23 Nov 2021 08:33:59 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpRFU-001JMX-6n
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 08:33:57 +0000
Received: from localhost (varun.asicdesigners.com [10.193.191.31])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1AN8XoHx011028;
 Tue, 23 Nov 2021 00:33:51 -0800
Date: Tue, 23 Nov 2021 14:03:49 +0530
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Message-ID: <20211123083346.GA1704@chelsio.com>
References: <1637576743-3341-1-git-send-email-varun@chelsio.com>
 <f6e46674-5856-1f0d-045c-6ced393bda70@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e46674-5856-1f0d-045c-6ced393bda70@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_003356_281059_AD4CBAA3 
X-CRM114-Status: GOOD (  16.30  )
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

On Mon, Nov 22, 2021 at 12:35:11PM +0200, Sagi Grimberg wrote:
> >@@ -933,6 +934,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
> >  {
> >  	struct nvme_tcp_queue *queue = req->queue;
> >  	int req_data_len = req->data_len;
> >+	u32 h2cdata_left = req->h2cdata_left;
> 
> No need for the local variable, the reference only happens when the
> pdu data transfer is completed.

As this function also executes for inline data it is possible that completion
gets processed and request gets allocated for new cmd before
if (req->h2cdata_left) check, nvme_tcp_setup_cmd_pdu() will set
req->h2cdata_left to 0 so it will work but it does not look correct
to me. IMO we should use local variable here.

> 
> >  	while (true) {
> >  		struct page *page = nvme_tcp_req_cur_page(req);
> >@@ -977,7 +979,13 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
> >  				req->state = NVME_TCP_SEND_DDGST;
> >  				req->offset = 0;
> >  			} else {
> >-				nvme_tcp_done_send_req(queue);
> >+				if (h2cdata_left) {
> >+					nvme_tcp_setup_h2c_data_pdu(req);
> >+					req->state = NVME_TCP_SEND_H2C_PDU;
> >+					req->offset = 0;
> 
> >@@ -1028,16 +1036,21 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
> >  {
> >  	struct nvme_tcp_queue *queue = req->queue;
> >  	struct nvme_tcp_data_pdu *pdu = req->pdu;
> >+	struct page *page = virt_to_page(pdu);
> >+	size_t offset = offset_in_page(pdu) + req->offset;
> >  	u8 hdgst = nvme_tcp_hdgst_len(queue);
> >  	int len = sizeof(*pdu) - req->offset + hdgst;
> >+	int flags = MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST;
> >  	int ret;
> 
> Not sure the local variables are needed, but OK, I'm fine with that.

I will remove these local variables in next patch.

> >@@ -1057,6 +1070,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
> >  {
> >  	struct nvme_tcp_queue *queue = req->queue;
> >  	size_t offset = req->offset;
> >+	u32 h2cdata_left = req->h2cdata_left;
> 
> No need for local variable.

Same explanation as above for local variable. 

