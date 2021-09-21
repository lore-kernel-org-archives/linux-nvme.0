Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FCFC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 20:42:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC15361156
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 20:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EC15361156
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LmVT061tL5vmw1fGc2aLnAmr9hoxmNiOdH5aMcPgKjk=; b=LCmPNois6HxIum
	EeRmZl5Ptq2fV3NWo+5VfX6vncxJdQjlHgcAZ/WBcl8FEK5He/Qppmk6eN3gZnp3/ZY1HT9vHsARx
	4ssLXkrf7KPp0W0BEOC1QbCmSy9OqU6uSk2mDLV1mY8aiyt8ehXNzc28Wb7CiKylGMAbYz1M4Bl2V
	FDU5wP8k/h5CowGJIOnD3ZgvfPNMTK6npJ6L36+oOftHdWyCyBm8h0dd8wItRNWDfDx4nexeh7QxF
	6dOorAxooBFsNe46xmZH2SIu+JUDemqiOeWVkzpSYekcvdWMKtWujyzN5zDIYaHg5jYr4C6dXuSJ3
	0rD1XS+wMMVik60dS4rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSmac-005j1m-QK; Tue, 21 Sep 2021 20:42:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSmaa-005j15-R2
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 20:42:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E76660FDA;
 Tue, 21 Sep 2021 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632256924;
 bh=s+yE6psxf3KkcTLQCC4Gza4D+cLOuX0rOBi/W7lBLec=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S2wd4d5Jyeyq70ACYHkzg3UpQYPgHJO4XjsDi5NLK1OqvQiFPvkFbyz2Eh0fRpkg6
 PQcRWK0l2sevpivciyZkTekCbPK871+tHAS2q9zFnKVe+SqO76GGlcbpjl/XY3swao
 TkExxZr4w0xEJA+fVB2nWI7bDMC/mMV78AcBw5ZKKwDuivC05mDNv34ph6w2/jGDCl
 1BaJP5JRde0qGol53Y6WYPyyMZNhurIYspHBel2uz8uF9GByIExBniMUZI32uKercu
 5eYP+JTFRBvS+dbdFDhtjzMao94YdiZ+ve1ycf1K9fZGaH0Uy30kIkCODzVBJ70lPt
 fFE4yjfj6ceLg==
Date: Tue, 21 Sep 2021 13:41:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH V2] fabrics: fix return value of hostnqn_read_file()
Message-ID: <20210921204159.GA110364@dhcp-10-100-145-180.wdc.com>
References: <20210916230312.84776-1-chaitanyak@nvidia.com>
 <9aad23dc-7000-7e6b-aad1-6e4bead982d2@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9aad23dc-7000-7e6b-aad1-6e4bead982d2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_134204_945510_8110BE3F 
X-CRM114-Status: UNSURE (   5.87  )
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

Applied, thank you.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
