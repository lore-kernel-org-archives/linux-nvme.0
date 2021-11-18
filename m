Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0190C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:29:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C2EF600D4
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C2EF600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ls78WJGPK/nxUb/DHaq80rWh1ICoUPJnnbYva+kFeM=; b=BH9y0h7IvYJ43joIaP9d9zhSGq
	ITgHhvqheweRrVEjA27Wg0VADYsLuWQu67+6jHg2jORxhI8El8vHeN1d5toK3lRWuyP16cKd18Vtd
	IhjIUqKhZx9XK1RXajaOdQZPSBhf5gXMHwPiNGMfCV3pSrOoCIMW7V38z7nnV+ec1oXs26mcTv3Oj
	0zYg1iw71s5Medl8k7wJ+RHSXD8gbl+pSzx681Z9aXJGzeJjKCx/01IVscqTFZvOuokb1F0Be1iqz
	fw3nQyqanC1FmFtyggNDlSk4ZhdmMkX8qUX/2Et2Ud9Ooi581knYdOpASijfiq/UktzsHxqSKjKbt
	KkpQiN3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mncnN-007CNf-0U; Thu, 18 Nov 2021 08:29:25 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mncnJ-007CNJ-2S
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 08:29:22 +0000
Received: from localhost (varun.asicdesigners.com [10.193.191.26])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1AI8SrdH029679;
 Thu, 18 Nov 2021 00:28:53 -0800
Date: Thu, 18 Nov 2021 13:58:52 +0530
From: Varun Prakash <varun@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: hch@lst.de, kbusch@kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Message-ID: <20211118082849.GA1697@chelsio.com>
References: <1635337439-4311-1-git-send-email-varun@chelsio.com>
 <57fe4578-d8be-8c05-4f52-ece4b3f4cabb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57fe4578-d8be-8c05-4f52-ece4b3f4cabb@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_002921_179905_DAC67F2B 
X-CRM114-Status: GOOD (  12.59  )
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

On Wed, Nov 17, 2021 at 11:01:52AM +0200, Sagi Grimberg wrote:
> >  		}
> >@@ -1022,14 +1056,26 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
> >  	struct nvme_tcp_data_pdu *pdu = req->pdu;
> >  	u8 hdgst = nvme_tcp_hdgst_len(queue);
> >  	int len = sizeof(*pdu) - req->offset + hdgst;
> >+	int flags = MSG_DONTWAIT | MSG_MORE;
> >  	int ret;
> >  	if (queue->hdr_digest && !req->offset)
> >  		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
> >-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> >-			offset_in_page(pdu) + req->offset, len,
> >-			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> >+	if (req->rem_r2t_len) {
> >+		struct msghdr msg = { .msg_flags = flags };
> >+		struct kvec iov = {
> >+			.iov_base = (u8 *)pdu + req->offset,
> >+			.iov_len = len
> >+		};
> >+
> >+		ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
> >+	} else {
> >+		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> >+				      offset_in_page(pdu) + req->offset, len,
> >+				      flags | MSG_SENDPAGE_NOTLAST);
> >+	}
> 
> Why is this needed? Seems out-of-place to me...

As per my understanding kernel_sendpage() does zero copy TX, return
from kernel_sendpage() does not guarantee that buffer is transmitted
or DMA read by NIC. Is this not correct?

If driver reuses same buffer for next H2CData PDU header it can
corrupt previous H2CData PDU header.

I will send v2 with other suggested changes.

