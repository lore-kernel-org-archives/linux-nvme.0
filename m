Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E7ACA9EAF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 00:20:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C5421929
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 00:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hIFvyhGg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbY70g+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C5421929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PFrdanssNUki0xWmw6LobMYEwH2hiQdHj/U4RVwHSUs=; b=hIFvyhGgbaM7bq
	9fCCmGhyw1ITSnKGJoO6/nX1wxgGCzwqksjlX6KWxVGhS1hi+/Xz1SJU3dUqqvItrOJBIgJcnHeLp
	NVD1KvggoAgw38d8g132I/iOwExiJ3PVVPdZsVcsXkMyYuJJYrJ5ckJnces8SWdwkaNTAttBtTEwF
	KfSbxGl4uxecJ4+C/M635iSFDW3arifqDLEtUCwAtDl+gZno0jyGZbztqXwdqQYz5IvCq9sc/r8wP
	xgZ4ORNqTGVWo4tc3HQgQ/tZNib9KMpw5u0hgp125Qr4dyQ3XEWoyJPZYcTuf0M0I6k1BMO/wV2il
	5fQRM4ixacMIBCbp2ncg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNnKm-000710-BJ; Fri, 25 Oct 2019 00:20:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNnKi-0006o3-Ox
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 00:20:02 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CD63321929;
 Fri, 25 Oct 2019 00:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571962800;
 bh=kU/ViuSuZqTFjDVM7ycCIhIS9CF04caKOB2FC85DW9w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SbY70g+CqKPkR+o7LwNK+vfvD1RNsIOf5PQ1Xw+CIWDvhUEk/8qS3a/1Vrn7sT9yw
 0fbNkRyMfdkP+A/RCqm5FQznEgZ+SvgjnTA2bZwCSoU3/mBa5TkCk1zvVG2NURC5ut
 5OrgiT6PG5qCc5J48A6Vjyz9w0JJ4Tb04utB8HJw=
Date: Fri, 25 Oct 2019 09:19:57 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: fill discovery controller sn, fr and mn correctly
Message-ID: <20191025001957.GB28602@redsun51.ssa.fujisawa.hgst.com>
References: <20191024165558.28056-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191024165558.28056-1-sagi@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191024_172000_831851_AE0FA55B 
X-CRM114-Status: UNSURE (   7.24  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-5.5.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
