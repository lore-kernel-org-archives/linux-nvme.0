Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6346AC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:16:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64B365120
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 17:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64B365120
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cHvagoXVI4FtqplOnPVA1sseCRAgXrkY3UosHlzzbiY=; b=TL7JcTDz139H60RwsfZUlJWOh
	AQwiYu2P7TIVr3jrusOeaomqrozD4tXfyyF+m80ICx2TEziNU23W56s1PQuK5Nf9sabKzxDazbhtN
	iPPd/V/BuuE8SUEaeIBVDjMlDzRzV2GDqAIzNSZrGFVs7T3qxx+QCJOCHwURVaG5heohoJ2vMcaiP
	oFKQDMe5NyJzRTb4qsIBhAayYPtJH09wveTyMl1Q9vdd6Xf0E+iBk4bPb5pMtRLyzxEZnRaGqhHrF
	AxZyDGaV2l+IvF7+rHtSXZ85u0G1cGFmxIaZQsrYIRFHmyBd5CSWsb9DrZozF7ZMzNCBvFo28VW4U
	4493MoXQw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMDJ7-001OdT-IB; Tue, 16 Mar 2021 17:16:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMDJ3-001OcU-5b
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 17:16:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02AE165087;
 Tue, 16 Mar 2021 17:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615914991;
 bh=fdcmLeCKntdm771dazuCVoEbNhFZVVC6Ghj+TWf/STk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CCDR/xpjvR4QU7lzoqi/3tosKKyd7W5ENo4MsTOL1gmsrGkGvfcqH54Bqrc+7BRa4
 UwovXz7O2fLYr8Miki19T7vkIiAbntxwqnKYDzdL3ZtE/UIdKAMxZ7UkGJuQv0ESdl
 uGBDgVJB4qcjS0I6p30h2lTUj845V0AS+s7ipAKxfTiQebursMB0wDOxDB9K79szTg
 OnYtAEUft1o93r6faS0Hg+6qRYLpJyHsOdPQueRPPogT8QUmfhgd1cU/iLOZpOv4pL
 MQw8TKtTtXLbZ7l0tCY9ssBXsxJ+y9ddnccOEBSP0Euw2TwyBjSF4iJHO+0FJokpti
 kyW7XzEStEuwQ==
Date: Tue, 16 Mar 2021 10:16:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, chaitanya.kulkarni@wdc.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com,
 nj.shetty@samsung.com, selvakuma.s1@samsung.com
Subject: Re: [RFC PATCH v3 2/3] nvme: keep nvme_command instead of pointer to
 it
Message-ID: <20210316171628.GA4161119@dhcp-10-100-145-180.wdc.com>
References: <20210316140126.24900-1-joshi.k@samsung.com>
 <CGME20210316140236epcas5p4de087ee51a862402146fbbc621d4d4c6@epcas5p4.samsung.com>
 <20210316140126.24900-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210316140126.24900-3-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_171634_005461_4EEF6F91 
X-CRM114-Status: UNSURE (   9.65  )
X-CRM114-Notice: Please train this message.
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

On Tue, Mar 16, 2021 at 07:31:25PM +0530, Kanchan Joshi wrote:
> nvme_req structure originally contained a pointer to nvme_command.
> Change nvme_req structure to keep the command itself.
> This helps in avoiding hot-path memory-allocation for async-passthrough.

I have a slightly different take on how to handle pre-allocated
passthrough commands. Every transport except PCI already preallocates a
'struct nvme_command' within the pdu, so allocating another one looks
redundant. Also, it does consume quite a bit of memory for something
that is used only for the passthrough case.

I think we can solve both concerns by always using the PDU nvme_command
rather than have the transport drivers provide it. I just sent the patch
here if you can take a look. It tested fine on PCI and loop (haven't
tested any other transports).

 http://lists.infradead.org/pipermail/linux-nvme/2021-March/023711.html

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
