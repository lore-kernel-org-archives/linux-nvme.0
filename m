Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84138C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ee/pkg1W0dXeWBxF9qK9onLVbtdwOOQ/j/VwCRaThl0=; b=DU0Fcob35TZwZgX87yswc63FQd
	7rEhyLnSSLGXK2MfP1sqS3075DKkYmCDJfLV21tqpBJaTu5kuOV97W+V9gqdWku/a6qOXUEnr5Pj4
	u0xY0enFJeOnJ8l8JFL/WyrVx5srrdJefW2h4uxyL8FHS/jG2y+leKVPMOFegaHjBa0bDR82JHA/E
	8T987dnC2xopz1RTs+PngABvkyM9/GTuOBVCHV9fG8/r7YNlgymYbJLBLZZ5XiYxt1TBhElHQgfRN
	e2dH4bzrkinqb9gWWtVdN1KNPP4/qST/CJzZzVO/G3tOZuuvBvtjf0Wf8xN6Rtzjv3qJH6FdsjULN
	U86422pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqFlS-00Bn1V-7i; Wed, 02 Nov 2022 15:34:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqFku-00Bmxp-Pg
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 15:34:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9698B61A14;
	Wed,  2 Nov 2022 15:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F1FC433C1;
	Wed,  2 Nov 2022 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667403254;
	bh=E5TCZJsM2E89lMvZDIcf5pHQ7r49L8L6/O9Tm2CHPCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prtgsAhajS9tYqUra2M7XzEbxd9e0sEnEHfMUkEhhDpgTWjwLzcPYweGSoeA3w6Oc
	 ZO8tudP3GowTvzRNFrMMyekEMtHo764QpButPXJIqfBMuEfe7W9QkY6XEZMVNzDpTZ
	 LdIvpWmHDiead/S8N3TFs7PQqk1PXo5Bn8xt2qUcIZoM4fUa5S5/g9N/tlK/Hj/pYU
	 MOFsueRFAuy//YPq/IX+WLWN870n1tacY+yl7NO0/z0sCOPwRpv7Tb5OJm47nhHvS1
	 5Rv4daUaB54W9p6q7jcPZ6NsVXyrtw17SHNrhMfYvkq0IdZYq5BtXoc3RNlb3F8uPz
	 met1V6LTpEMRg==
Date: Wed, 2 Nov 2022 09:34:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Binarus <lists@binarus.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvme-format: protection information enabled although metadata
 size is 0
Message-ID: <Y2KN8wHy5l9HxOgW@kbusch-mbp.dhcp.thefacebook.com>
References: <b9ca7931-0384-d0e1-92b5-c2ffbadc195f@binarus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9ca7931-0384-d0e1-92b5-c2ffbadc195f@binarus.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_083416_912626_4BF6B282 
X-CRM114-Status: GOOD (  14.31  )
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

On Mon, Oct 31, 2022 at 10:27:34AM +0100, Binarus wrote:
> Dear all,
> 
> after having read the subjects of the posts in October, I am afraid that a
> dumb newbie question like the following may be inappropriate here. But due
> to the lack of other options (tried other Q & A sites without success), I'll
> be brave ... Having said this:
> 
> On a machine with Debian Bullseye and nvme-cli 1.12, I have formatted an
> Intel DC P3700 the following way:
> 
>   nvme format /dev/nvme0 -l 3 -i 1 -f

You correctly surmised that the device is behaving out-of-compliance
with the specification. The device should have returned an "Invalid
Format" error since, as you found, this is the error to return when
"enabling protection information when there are not sufficient metadata
resources".

You're unlikely to find a fix for this EOL device, though. It's just a
firmware bug that you should avoid.

