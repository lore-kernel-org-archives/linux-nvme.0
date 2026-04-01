Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7663E107638D
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 17:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ay3iF+IOIXyQ8Y5GyamWOg2dop1zP3uPJAWOZ58oQh4=; b=nqDVqs5YLTqHzOl++nuVCs+pkn
	0R2rZAj9Ijjli/12D547yCyPoQPT3RAGxSQ4E2O6H4ZAYeB8IuZWVrOtw9bz/0xcJj1BqhujlImcg
	G86MbSo5NUTfig9gqUFqfoooJS/DyoBlH3yCVMuJJvy+yCeF0JRVBw+AFDBhy8DclpGv1MlZbgTTa
	cv7Onwn6CpLyryFE4fjMRIN/LfzF5wANOa4CvCXyqzeI6FnWeNbqLPip5SQPJ/XYpIZ/1Ihw4UahA
	dDw5TdC+NDLZ8sQmrH1IUr6mKbjg8xv2CeY31uw3qbHWueJzMNM81YXmcXQeqbAckYv0/wKCxG+2U
	HT4B4Viw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7zbN-0000000FsXI-2sAB;
	Wed, 01 Apr 2026 17:43:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7zbL-0000000FsX6-3nji
	for linux-nvme@bombadil.infradead.org;
	Wed, 01 Apr 2026 17:43:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ay3iF+IOIXyQ8Y5GyamWOg2dop1zP3uPJAWOZ58oQh4=; b=WhfvQY0Dwo6QEhHuse4NaPkqHC
	/Veif+ZGiHyAWXGCI4IAfEHq5SCwOnd9uYKu5AzBZmxsfIsPLGtBCO5xleBB8W+5p1j1TRZPxxUSE
	8bARmnApnGkqfia3GRCsD1V9flggjcMznYMcJyDWpfIJnAxtaWMPz2CPN4KRamwEtHRazK5DR0+MW
	+ad3ZdpHMV4gPcPIPKcDl065zdxkOtsJWPVsZjlqWgIlkScpCyA++MDXV+vj55OHdN8x5ycn7lMro
	KM2qyPZ2cguCq2bTyft1g+qrucgJI7hfPhZu2l5fMlTAXxXo8WXnb6BL4X3zaFfBpSVYMOs4+KDSn
	ZAcby+iA==;
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7zbH-0000000126P-29ne
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 17:43:34 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2b243198058so6785ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 01 Apr 2026 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775065409; x=1775670209; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay3iF+IOIXyQ8Y5GyamWOg2dop1zP3uPJAWOZ58oQh4=;
        b=eCBPtKuuMJ6qzuHWGZ0cg8FrpjbwaU9g2KvcsdQjuwNxA6iQjhfpGyhnjJ2j90212H
         41L9W18eH6KNFNRAuT/Znc/ib5lnbDa7HAOykBpjn+uHugPvQtR/gyGOeutvYzd2zzgp
         dVJgyEwKGo3TaIwXHWAoyZqgdzzycGe/6TogsxUFr+Wgl8Ci7FDJrvNUvYnqUUwzDf4v
         Z/QpnGWW5r6/r19Q6O1+NM8aCUZoGO5zR7HzABEOCUwOfdc7Yl7WTFQNMK6WFUAI8fV3
         1FBATTkRDjNNZwRiWCf+ugl1OSnegjpq3x2+EPAZdg9Iq6fIEy7Q90fXrMF1yDE+cSwR
         WjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775065409; x=1775670209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay3iF+IOIXyQ8Y5GyamWOg2dop1zP3uPJAWOZ58oQh4=;
        b=T7y89gTQ6RfJlUw/sdGAJuQ9+8BbYsPcVMHdqiq1TTHBCnf+jhXtQCLxTM8XXZfgKR
         pJZ2r+/xHc/Y+ct/+nY3MdLIgGRAvVQtdrY9kHmMtavEGS1V1mDvWKIZYijpWItqXPl+
         RLPb5SkAmQQ6KKadiqrGsdpxUsp4WkA9DvUdttRRMbqOgZ14kz8szufjDkU031bUdRaD
         etSDe0ZCiTlfGh0+hfdg0YCrBgajOe/MsxAwS1TO7YE7E+IIw6j54V59H2j904ACPoG8
         QXtja8r2neGSnyWuItsmrOFNsBAZO0I6gel1iJ6t0aV+tza38liTffcN2Io2znBLmZLH
         qSOA==
X-Forwarded-Encrypted: i=1; AJvYcCU8fx+lPeAVe4bZXhdKVPtYqhf8nWz03C79FdDTyzos9Qh/GQUPymAd5Uux8+hYlZz+22N+53U86AUe@lists.infradead.org
X-Gm-Message-State: AOJu0YwQa5cGlhdRMsq70B5LgcJXyt32zetUTUKGBRYEKWCCryUnVD6J
	92FwGbdpPqBeTe0dufAvFsYVRSgtE4TRiOT2IIQSPOXhUOsd0grhYNcwwQ+A8RLoyQ==
X-Gm-Gg: ATEYQzzVCM2973C4bMOnUH3BOst0ILKOrLzUNu8zgyEaBrwvc8SxaT9+U/2ORc2oqQG
	wrJi6Wl3kI9hmfpundS5h8/Vr5Qad1wtbSKWE11zgsns2ATeWJ+9VYaFMofdytTIy7nt2JMDEEJ
	VVXXSCSUy7/JEUKa60cj/zOxcoFvoGE+qUBXHDmE4wwd5sJaPBKy559g8SGKt/RwIrYnh1ZEur/
	O0xTOiuwLQ6ydSf+RejuPuIU4AYjCij6bCblqYi0ELPJeUmpKBQdNDoRtah4cYkQSUSDa/8bEiu
	3cfN5I8paqMhUiiA01OTqGW754M2d3L6qRITyt/DKDOI9bri4AOLV3pEnJ3xiq7Zta1RcoDb8RT
	tcT0DO/eF2wk0rh4vdQicazMe9eXUMRvjffIfz2OAHCl2i2BUxGa1WytcRS86lTUTJGZJNDlCLX
	t6ZrIlO6589rbRiNacgBI7vG57qh7A/X9hzf7qId1R+IDgIRokBByVOADe8g==
X-Received: by 2002:a17:903:285:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2b27610acd4mr80455ad.21.1775065408798;
        Wed, 01 Apr 2026 10:43:28 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a1e9csm3922085ad.55.2026.04.01.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:43:27 -0700 (PDT)
Date: Wed, 1 Apr 2026 17:43:22 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Shivaji Kant <shivajikant@google.com>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: enable PCI P2PDMA support for RDMA transport
Message-ID: <ac1ZOgnpSjxo51WK@google.com>
References: <20260401103441.1229964-1-shivajikant@google.com>
 <20260401141706.GA22165@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401141706.GA22165@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_184332_916946_72FDEC5A 
X-CRM114-Status: GOOD (  27.31  )
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

On Wed, Apr 01, 2026 at 04:17:06PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 01, 2026 at 10:34:41AM +0000, Shivaji Kant wrote:
> > Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> > RDMA controller supports it.
> > 
> > blk_stack_limits() currently filters out this feature bit because it is
> > absent from BLK_FEAT_INHERIT_MASK. Manually re-assert the capability
> > in nvme_update_ns_info() after the stacking operation.
> 
> This is really two different features/fixes and should be two patches.
> Note that Chaitanya also has an outstanding patch about p2p on multipath,
> so please work with him.
> 

Ack. 
Shivaji, I believe this [1] is the patch Christoph's referring to.

> > Hardware reachability remains enforced by late-stage distance checks
> > during DMA mapping.
> 
> I don't know what this is supposed to mean.  Callers need to check the
> reachability first before submitting P2P I/O.
> 
> > +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> > +{
> > +	struct nvme_rdma_ctrl *r_ctrl = to_rdma_ctrl(ctrl);
> > +	bool supported = false;
> > +
> > +	if (r_ctrl && r_ctrl->device)
> 
> to_rdma_ctrl is a wrapper around container_of, so r_ctrl can't be
> NULL for a non-NULL ctrl.  ->device also should not NULL because it
> is set up before namespaces are probed.
> 
> > +		supported = ib_dma_pci_p2p_dma_supported(r_ctrl->device->dev);
> > +
> > +	dev_dbg(ctrl->device, "PCI P2PDMA support result: %s\n",
> > +			supported ? "PASSED" : "FAILED (HW/Driver restriction)");
> 
> Overly long line, and screaming isn't really something we do in our
> messages.  We also don't do that debug message in PCI, so please just
> drop it.  IF you think this is important enough add a tracepoint in the
> core code in a separate patch.
> 

+1, we should drop the log and add a TP if necessary.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/

