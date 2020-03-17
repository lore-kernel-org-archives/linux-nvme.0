Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E9C5ACD6
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:32:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A1F20714
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sIpwc7F9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A1F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lJP2WgfRBVzppu/++0N1afUzIYoiumiU1lIQzDI2QQ4=; b=sIpwc7F9YujDFb
	J9qlEgQ4ykaSSgG4IPISj+mZWgUub9/3g8iMyl0s/mTeHk1997wAXcuN0Vxa0qzW4t2EE5akyOPmA
	vr/nHnORJQlGpTj/5xvDb5w2PucHSn0YNacAyglFK0y7EJrGXXYuvXQPEtn/PTGIjn4k7s8zZvUAe
	Z4kafMvY+uLeA/jobnvaRMeBxnaRAU1oayeDRhUocTXjiCXLIzkhzEyhVEm8sGrWAn9gdk6vmKLUp
	8IVSEk7/XT45Pc5sTyZZPn8v4ci261hJ0ilcF9PLkfx9SDic1oFAeL8f+APfjyMOXyhxPkwKfa8gq
	PrEFvyI0LIpQKfpe6pTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEIst-0001Zd-1k; Tue, 17 Mar 2020 20:32:19 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEIsq-0001ZD-KN
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 20:32:18 +0000
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 02HKVvAw008625;
 Tue, 17 Mar 2020 13:31:58 -0700
Date: Wed, 18 Mar 2020 02:01:57 +0530
From: Krishnamraju Eraparaju <krishna2@chelsio.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
Message-ID: <20200317203152.GA14946@chelsio.com>
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
 <20200316162008.GA7001@chelsio.com> <20200317124533.GB12316@lst.de>
 <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
 <70b13212-faa6-d634-8beb-55ba39891d7f@grimberg.me>
 <20200317191743.GA22065@chelsio.com>
 <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <38f79fb7-841a-9faa-e1f8-2de4b9f21118@grimberg.me>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_133216_679573_BC3BB48F 
X-CRM114-Status: GOOD (  17.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-rdma@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
 Nirranjan Kirubaharan <nirranjan@chelsio.com>, linux-nvme@lists.infradead.org,
 Bernard Metzler <BMT@zurich.ibm.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tuesday, March 03/17/20, 2020 at 12:33:44 -0700, Sagi Grimberg wrote:
> 
> >>>>>For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
> >>>>that
> >>>>>is a good idea as pretty much all RDMA block drivers rely on the
> >>>>>DMA behavior above.  The answer is to bounce buffer the data in
> >>>>>SoftiWARP / SoftRoCE.
> >>>>
> >>>>We already do, see nvme_alloc_ns.
> >>>>
> >>>>
> >>>
> >>>Krishna was getting the issue when testing TCP/NVMeF with -G
> >>>during connect. That enables data digest and STABLE_WRITES
> >>>I think. So to me it seems we don't get stable pages, but
> >>>pages which are touched after handover to the provider.
> >>
> >>Non of the transports modifies the data at any point, both will
> >>scan it to compute crc. So surely this is coming from the fs,
> >>Krishna does this happen with xfs as well?
> >Yes, but rare(took ~15min to recreate), whereas with ext3/4
> >its almost immediate. Here is the error log for NVMe/TCP with xfs.
> 
> Thanks Krishna,
> 
> I assume that this makes the issue go away?
> --
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 11e10fe1760f..cc93e1949b2c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -889,7 +889,7 @@ static int nvme_tcp_try_send_data(struct
> nvme_tcp_request *req)
>                         flags |= MSG_MORE;
> 
>                 /* can't zcopy slab pages */
> -               if (unlikely(PageSlab(page))) {
> +               if (unlikely(PageSlab(page)) || queue->data_digest) {
>                         ret = sock_no_sendpage(queue->sock, page,
> offset, len,
>                                         flags);
>                 } else {
> --

Unfortunately, issue is still occuring with this patch also.

Looks like the integrity of the data buffer right after the CRC
computation(data digest) is what causing this issue, despite the
buffer being sent via sendpage or no_sendpage.

Thanks,
Krishna.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
