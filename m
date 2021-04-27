Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E244C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 18:13:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC20610A5
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 18:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC20610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tmpEjmQaJIpuvIhSHhrxxZa0sGK3H/JVa6q4yPBYp9I=; b=FL6vChP2NxPN0wu0Ix+IIzs0t
	h1g4Epzl+elPTamAtNzaxSQLN5I9k20OVmjLE0BP1bsUMyNelEYaPpVRXmdMqwg4WtlMA2C30zzbS
	sCdPM1okxrbl+C+v+zvqhkypUnfGDdP3c+L/zWNPXxspAcRajbPr2ZFVrm3zV8PYzmShF2+xp/yqf
	o02h3qKNBjgYFSaI2yy7Dgvc2pDVTeNLeH9u35GzBCc3pgOCMzPE77ZUfCxo8ihJvOOkUXOh8tel7
	SvntbZLgzz7xnfkTxXKrO1nEY78Q6CoPmOZGQA/oeScFsijuAcbRRXeBHNFR8Rh5igdRjsJ2n6BkZ
	B+C5A7t4A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbSCY-0022Dy-C7; Tue, 27 Apr 2021 18:12:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbSCS-0022DW-HH
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 18:12:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=64DK5KZYlVWqlFFPhWlOGr3sqX1BMoWrxrsmNnatm1g=; b=cUc1bhnBulg3+k22eYVrb5KzmQ
 LV5gipV8K/mSRjgJrdOpEg0YgYf+FWjYJ8shFL90x1pd4LZ7UNNQn4fD8guAmniX+hUS86XyfpKAc
 MR8tGD7qUgDI5QGh9yy7wbRmAjYx8mZI8rZz5a6E6g84DGupCwH8bJn5hADJGQ+e5QmW6DLrwMnDl
 nHk/MycQDmP8oA+EGnFNWg89pvmn4ns7MCNJsD2xYvVxUBA6ITWQVuQWlMnsINNAwmUmSdCuKgpsS
 ORzlgTpA78mtvkCZbzt1Un5VtZXtE52bvOpZOinAO8RtvXdgaqwn57PsGNsWGSdQSW1Wj2gGh5Z4r
 71xnUmMg==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbSCP-00GuXx-5G
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 18:12:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60E2361153;
 Tue, 27 Apr 2021 18:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619547160;
 bh=ecAymcp9Qxsm1cHZ8bajFoxU9KVyYDHzjzjt8zTHgZ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V0oxuT0zbN9QgWbe9prT5L5leZDiiIsn8OGt8tg2i8zOxf7E5eGsK2QDeE3EmLzjH
 5231gsgJxMBrfOEpIYWSDGaN6dZcXfNqXwN9UDFV/pQVTdfnCDKm0DU17/DbF7m5Lo
 uYIWpvtFnpehX/6JEkrQMMlUb/boYznhg3gU+BSm97w2o2oMzvC50Aa7ypcMZfrmXv
 kBb+T6eMjy9c20VpUdpHG8ltIL4e1+LjqBuDWF512JazAC2Ovk/k58oYTdHbcrCsk3
 xM2/YwSRh5uB2/OaEHgaVbkb9CrJw34yAFcxp+HkDlEzrrFt3erU5x2Odcuo69njqo
 +vuR6kVltWUyg==
Date: Tue, 27 Apr 2021 11:12:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
References: <0976ff40-751e-cb95-429a-04ffa229ebf0@grimberg.me>
 <20210331204958.GD23886@redsun51.ssa.fujisawa.hgst.com>
 <20210402171141.GA1944994@dhcp-10-100-145-180.wdc.com>
 <53a11feb-bc49-d384-3b7b-481a0dfc70e6@grimberg.me>
 <20210405143702.GA20598@redsun51.ssa.fujisawa.hgst.com>
 <300c9e90-9bd6-abc8-c67a-fa92e119e4a7@grimberg.me>
 <20210414002946.GA2448507@dhcp-10-100-145-180.wdc.com>
 <5bc917c8-4e4c-7bfa-7cfa-24858993a042@grimberg.me>
 <20210426153137.GD12593@redsun51.ssa.fujisawa.hgst.com>
 <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f247f9e2-6724-0feb-b40c-08ada848d290@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_111241_250241_A65E81E9 
X-CRM114-Status: GOOD (  19.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 26, 2021 at 08:10:38PM -0700, Sagi Grimberg wrote:
> 
> > This patch is successful for clearing up the observed "no space" issues
> > observed during read tests.
> > 
> > There are still some issues with write tests that look a bit different.
> > I'll get more details on that for you today,
> 
> sure.
> 
> > but it's probably okay if
> > you want to make a formal patch for the receive data side.
> 
> What should I put on the Reported-by: and Tested-by: tags?

This report and testing was done courtesy of

  Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>

Before you submit a patch, though, we did additional testing with data
digest enabled and observe a regression with the following error:

  nvme nvme0: queue 0: data digest flag is cleared

From looking at the patch, the following part looks a bit suspicious:

> @@ -776,19 +776,20 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> 		req->data_recvd += recv_len;
> 	}
> 
> -	if (!queue->data_remaining) {
> +	if (!queue->data_remaining)
> +		nvme_tcp_init_recv_ctx(queue);

The code had previously called nvme_tcp_init_recv_ctx() only if
queue->data_digest wasn't set, but now it's called all the time. I see
that calling this function clears ddgst_remaining, so does that explain
the new errors?

> +	if (req->data_recvd == req->data_len) {
>  		if (queue->data_digest) {
>  			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
>  			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>  		} else {
> -			BUG_ON(req->data_recvd != req->data_len);
>  			req->cmd_state = NVME_TCP_CMD_DATA_DONE;
>  			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>  				req->cmd_state = NVME_TCP_CMD_DONE;
>  				nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>  				queue->nr_cqe++;
>  			}
> -			nvme_tcp_init_recv_ctx(queue);
>  		}
>  	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
