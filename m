Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25048C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:15:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97636610E9
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 19:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97636610E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8sgEh4BIpsScwKQ5D5vGGhBTeyL8Wu13uiC/68v9QBc=; b=Lx0Ro/ORsFjxmQ1Fm6plP9RW0
	lub9zLdPNXEukXAWO0KRxx9ytVDsMMBby+Vjd2FBsSW0+Umfk/xfnLEw52s33/zKf+/xHIUOznc1Q
	o54MWYAeTZFXl2FMBZWAI07huOP4rCswHnjP+tXDvOQ+zPWWn2T1u0XHb844MQLtfM3cR5G1k+7UK
	5LyBb7L4f7cbpuX26iRXOzR+tGcEoCrXzNuE51QE3vgDgDsMMxmLHwfL2JSNaJiI+vW469v0XaY3m
	ZSDGOMJalmYm/9zMycITZ0tyQncOSuYFgDriG1pN0oMO8py0aMWGjqKb2JqY2moeVNcMaVr7bT3Bn
	f/y6AX30g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1le0VN-00Grzr-6J; Tue, 04 May 2021 19:14:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le0VK-00GrzK-R4
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 19:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=bVBDVdB1qj2cXrmWH4dHd0riPOT7NYosEC6HNaM1zRU=; b=tyxE5It8nv2ANzm5aE7YX+U0v6
 vpNzOGUh5N7rAKdiDbmSl0IBWbIMUH8/CZGiCs2SAbBBbk2u3x27hoMTYIz0v20Pkxg+tvvXttjNV
 v+ku5kyr20AlDCxW53jEpb2iqqUYfFJcmprQOMiGCQUN4cKSfB9Ug0KK5GhVT73i06IoKFU6ro9y6
 6KPa/Bdp8iPeYL6lppl55lSE9/a6sPfzvIRhogfM0D2YiVQlpn2eD3tYECC/YZrApvSOu4O9VnzH+
 LUFyeE0AYpNT6Ni30wd+mQCOwXJhMZ3yyB+2VEKlKdgF9ADuOiKdLsQpZYYYJWEbFuBQRsR6LNjkU
 PM5pyHug==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1le0VI-004D5N-9P
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 19:14:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B4B6610E9;
 Tue,  4 May 2021 19:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620155683;
 bh=tOuZueQeCWyLq3J034Tbxqw8h0NnFOp4XG5Pbs+g8c0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Xt+aeHjJb7gvqoHNv1i5zycJVd2aqFKefCp95a0WYk1FINjDlwnjFGEtfb00a3Fhg
 Btnbxx1STiaU2A7Gg0Sa1fdCG7Pr8O1rHpGgUFk9HBvSk55fbMMRXhIvTShRUIZbU8
 RSnY1IhYI2A7fzenETgppVTXVtSJz0juNyy4ZelSId0gJkisXPl7BJrUPsMOMtUa49
 BWetsG9ZBRSsaifLbGfjdxTT56ZiLswiTAbgLMhEyKGSh+jde7t1H/RsNC37uFyCUF
 yH9tLQX8A3UGHlM833kA3lQfLIi02ZqGZcjxP0ZHIH1IgRW7Az82+uAPnFHH+OQ7Hf
 pI53r3xcbWGzA==
Date: Tue, 4 May 2021 12:14:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: Re: nvme tcp receive errors
Message-ID: <20210504191441.GA911866@dhcp-10-100-145-180.wdc.com>
References: <20210427181236.GA631001@dhcp-10-100-145-180.wdc.com>
 <686a7cdc-a9a8-3700-3805-90d07db39707@grimberg.me>
 <d27ccec0-7b2c-790c-3192-96c6e2aeee0c@grimberg.me>
 <20210503142848.GB910137@dhcp-10-100-145-180.wdc.com>
 <8932c0f7-1d9d-90a0-dd9d-32ba43d03d76@grimberg.me>
 <bd69eafa-9f1d-4cdf-f1b5-8b71ffd78917@grimberg.me>
 <20210503194404.GA910455@dhcp-10-100-145-180.wdc.com>
 <ba05ff5a-b6bd-b6e4-a96b-fb9ee4e01f66@grimberg.me>
 <20210504143633.GC910455@dhcp-10-100-145-180.wdc.com>
 <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <76a715f5-6a37-8535-3fbe-1aa0f3a54dbc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_121444_396403_CF17E48F 
X-CRM114-Status: GOOD (  31.58  )
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

On Tue, May 04, 2021 at 11:15:28AM -0700, Sagi Grimberg wrote:
> > > > > > I've looked again at the code, and I'm not convinced that the patch
> > > > > > is needed at all anymore, I'm now surprised that it actually changed
> > > > > > anything (disregarding data digest).
> > > > > > 
> > > > > > The driver does not track the received bytes by definition, it relies
> > > > > > on the controller to send it a completion, or set the success flag in
> > > > > > the _last_ c2hdata pdu. Does your target set
> > > > > > NVME_TCP_F_DATA_SUCCESS on any of the c2hdata pdus?
> > > > > 
> > > > > Perhaps you can also run this patch instead?
> > > > 
> > > > Thanks, will give this a shot.
> > > 
> > > Still would be beneficial to look at the traces and check if
> > > the success flag happens to be set. If this flag is set, the
> > > driver _will_ complete the request without checking the bytes
> > > received thus far (similar to how pci and rdma don't and can't
> > > check dma byte count).
> > 
> > I realized this patch is the same as one you'd sent earlier. We hit the
> > BUG_ON(), and then proceeded to use your follow-up patch, which appeared
> > to fix the data receive problem, but introduced data digest problems.
> > 
> > So, are you saying that hitting this BUG_ON means that the driver has
> > observed the completion out-of-order from the expected data?
> 
> If you hit the BUG_ON it means that the host spotted a c2hdata
> PDU that has the success flag set before all the request data
> was received:
> --
> @@ -759,6 +761,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue
> *queue, struct sk_buff *skb,
>                         queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>                 } else {
>                         if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> +                               BUG_ON(req->data_received != req->data_len);
>                                 nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>                                 queue->nr_cqe++;
>                         }
> --

I apologize for the confusion. There is a subtle difference in your most
recent patch request vs. the previous one: the BUG_ON() is within the
DATA_SUCCESS section, and we hadn't actually run with that. We did hit
the BUG_ON() in the first version, and looking at it now, I suspect you
intended to put it in this new location.

We'll retest, but I don't think we'll hit the BUG: none of the headers
have the DATA_SUCCESS flag set in the tcp dumps I've seen.

And also I see your point about how the original patch shouldn't be
needed at all, and I also don't see why it could have changed the
observation without data digest.

Thank you for your patience on this issue. I will get back to you with
more info after circling back with the test group.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
