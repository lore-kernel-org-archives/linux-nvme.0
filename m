Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E50C10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 11:51:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C6420640
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DrKUBcA2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C6420640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VGnVCli8ljhJwOItcrrEstyFozwFzVreGN7Bbfbetk0=; b=DrKUBcA2BNBpY8
	jyijk9i9bo1pKG61B317V+O92Hc+vLI/7mf/wVpJK33ScraqZ3HsJRTETxoPz3OngoVuNUEWZFwot
	iccbTxCPwjiiWn/T1TRzcJPJHOaLpUAn7EnJuKP/NaeSjUIeO8hj2bO/Mcn/HwK+UGjdJDKYP/qXl
	c4s6xtlLuoZvk5JvBy0gIx2dNfP5qsUHcit1zfvuSATALMWNwVs/WCupU9gZ3Wg0PkmgZI+oRz2MV
	sHu3MVaNrTsPE6VYz6rd08tpZyuGFesvb84QP34cljimVpqlfZiUPkDer4T06LlDV1UccDcfX7GyM
	Ikjz8wfURWvW7pZi6eSg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIWyG-0002Cf-HW; Thu, 10 Oct 2019 11:51:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIWyC-000262-LI
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 11:51:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 15CB568C65; Thu, 10 Oct 2019 13:50:55 +0200 (CEST)
Date: Thu, 10 Oct 2019 13:50:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v9 04/12] nvmet: make nvmet_copy_ns_identifier() non-static
Message-ID: <20191010115053.GB28921@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-5-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_045100_869177_CE236C2E 
X-CRM114-Status: UNSURE (   9.25  )
X-CRM114-Notice: Please train this message.
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
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 09, 2019 at 01:25:21PM -0600, Logan Gunthorpe wrote:
> This function will be needed by the upcoming passthru code.
> 
> Passthru will need an emulated version of identify_desclist which
> copies the eui64, uuid and nguid from the passed-thru controller into
> the request SGL.

I don't like the way this is handled.  We should avoid faking up
behavior not supported if this really is a passthrough interface.

For this particular case this means:

 1) report the vs field that the actual controller reports
 2) if that is below 1.2.1 bump it to that, but no further
    (and maybe print a warning)
 3) don't emulate the namespace descriptor CNS ever

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
