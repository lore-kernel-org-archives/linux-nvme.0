Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A9CC3F2CD
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 17:23:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF0320722
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 17:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERv9viiK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF0320722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lwTPX44ZVRGmGr22jdcjdytCfgHzCH2I9K5Y2YiLt0A=; b=ERv9viiKTHpdss
	X8zfqIxi8b+bvsGBOZocYNlsLj73PsTM+C2aQsR/o/Q1p06sFChegsY3ZXkxmhEdrokjK30epsD0h
	RpmyIOYeVycQho0zFpxLw9rG/twL8pf3fAGsR3tuTlBxWtj51ybSeq2WoQZdgk5SbxZhqk1dNPbhl
	YfkliK5oBJqMh7Rz4+t4QZ8h506/5+QjmVLM+AIKeA6GTvUKgjVxdHSSgVrBABZjTO9axRUxsUe4t
	uKhO0CfwS3VsRXRcPVDk8RLfW67wvATfqBUfFpxRnGrzj+ye3/DQE/4Mmf5MfsA2ccY1hOr5pNLuH
	e29FQO6Q9cmld5SB85Cw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGQnN-00088y-7Q; Mon, 23 Mar 2020 17:23:25 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGQnK-00088T-Bg
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 17:23:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CBDA568BEB; Mon, 23 Mar 2020 18:23:19 +0100 (CET)
Date: Mon, 23 Mar 2020 18:23:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 3/6] nvme: Fix ctrl use-after-free during sysfs deletion
Message-ID: <20200323172319.GA31449@lst.de>
References: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
 <1584899989-14623-4-git-send-email-israelr@mellanox.com>
 <20200323073200.GB30302@lst.de>
 <61aa8efb-67ab-e5a5-8802-61bf30ffa994@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61aa8efb-67ab-e5a5-8802-61bf30ffa994@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_102322_546685_8899999E 
X-CRM114-Status: UNSURE (   7.89  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 23, 2020 at 06:10:23PM +0200, Israel Rukshin wrote:
> There are double calls to nvme_put_ctrl() at the error flows at rdma, tcp, 
> fc and loop.
>
> I will remove those at the next patch.
>
> Is that OK?

Yes.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
