Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D15C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rynAV4P+NVUKLw3avs/iw9RXJmMjEbBmsJBjKqEhIqM=; b=PigZ215R3Xqy3TdVqA6KCEs3lw
	9f2RGpDxX8KBibDX8LQlPXktUPlzfAnfecCmHT/WLpG3w7cKEcUSYtFY3M2P4S2aZymX/py2VDIOn
	kzSSeurk7mz+5xH4dXPU672wPnYISsyb9nQ3XWSkG36zxEWbfhRjXji3WzlmoOn3ERZ3KYgvmZhGj
	QK7PljTNS3yOthZhLnEPBbCgFSLGfe+iC748WPS4xfcrOOejXSf3g9Zr7OR+vwJ91LuY1uL3ttc5r
	izZ+ckQhfNd3ougwZW/HBt0SmrlsDN+chJOKfKYypGyS/Kw5VgDzxvwuB2JvIIn4gjB8o0SdQ+GMG
	RJ4yEg5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odakk-00HLMv-Ly; Wed, 28 Sep 2022 17:21:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odake-00HLKo-CW
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:21:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E2AF161CD3;
	Wed, 28 Sep 2022 17:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46AEC433C1;
	Wed, 28 Sep 2022 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664385699;
	bh=Gh8JBu9ekJh+guGICOUVBvfibb4f98H406PvbjrNkxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oU56C1dVgR60xakiQaroLH9r4jyC4YqUg+2KqP0DtxNM565PA7PgG10D6VOSm0kXn
	 7tLYxOqwlvjbZb9E0SAVgV4iF7B+M2PXiO8t1/UfYAQ8+Gdvbk0r/yHWIJqmjnHHS3
	 7ph3W0Elx2Pctc/SCwBHLr+0wHf4FUedQYKH6F4Zj08ZAta0CBfwZxOwNUa5KOI7i4
	 bDsJaNd5diVE8pWsLNFG0voHTgoZjWSvWbUnXiouPQtU0m5lTqzqDh1sFqAHaLMn22
	 rg9L2bn/keZ6Y/bnwIPJlEJ6kTuxlpBAZReaO7M+SQeAeFzMJlWzbrSVA+TweGEnAU
	 Wx5CD/E1/Hexw==
Date: Wed, 28 Sep 2022 11:21:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Yogev Cohen <yogev@lightbitslabs.com>
Subject: Re: [PATCH] nvme-multipath: fix possible hang in live ns resize with
 ANA access
Message-ID: <YzSCoDP2PO7jIRLT@kbusch-mbp.dhcp.thefacebook.com>
References: <20220928135816.132213-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928135816.132213-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_102140_514751_5CF6B234 
X-CRM114-Status: GOOD (  11.24  )
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

On Wed, Sep 28, 2022 at 04:58:16PM +0300, Sagi Grimberg wrote:
> @@ -172,16 +172,18 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
>  void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
>  {
>  	struct nvme_ns_head *head = ns->head;
> +	struct nvme_ns *n;
>  	sector_t capacity = get_capacity(head->disk);
>  	int node;

Cosmetic nit, the new declaration ought to be below the capacity line for
reverse-xmas tree goodness.

