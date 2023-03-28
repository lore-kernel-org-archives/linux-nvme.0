Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64E5C76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 18:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wkcBiFMcVuY+SwojPU7SHfF5Txj1VYO1PXarJjsNcxo=; b=EM06fNOLHgjfPgYGNbh/qv0bBp
	Ri2TYkRCFHJEbV+h1RywBEqukite6t4bAQCYnfWjaoPkDCDy7oAUKv/dLgx+GTjvui/P9+dY2mlCH
	g1fNuz177FgXfZHUD9StwK+MjtLh6AMzBJhzyBleOz9eix9SO7LQ12erp8kyJ30WK45t7UgfbrifV
	7RAjZV1YQWYRABfga1+CIevP3pvd60yU7Owh1Y+tD4Hy/ekoSR5aZKKAFosIgDZOY9FLIn5P1vHof
	acmSZvvSjPo+NrOb71n5OMa9kqV5+v+JLkOddEQfcGrJi/aolV8K7KhKVQrc5kWfeb6W8x78lYDML
	aYqzxC4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phEAx-00FTgW-0P;
	Tue, 28 Mar 2023 18:36:07 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phEAu-00FTfY-1J
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 18:36:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 54B81B81E3B;
	Tue, 28 Mar 2023 18:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5D9C433D2;
	Tue, 28 Mar 2023 18:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680028561;
	bh=kc5R6nXTzPfvlU6LuPQ145KHQ64nhKzvpe4FksK4B/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epsmqNnLEaujUCalH3zBcrtfn6n+EgCpaox+2i0zCM1W/bzqKGUZ2ta041G1Jnff0
	 YVw4pvHnj1sA4eqhKRN3IHTZax6aOK7baDsoCgG4L0o3bmY/Czj+w/35zUDIIKqAqi
	 x96ogSCggPATRJa5RH8/UEST/O9UJ+NZsZhmOXc2VyJF2AK41Kx5+J5j8MdTKP/Dbn
	 6oZ9tKTRM3kcuBoZRT0Ms226kTzDPfIfmgCAqa5Ilnkr/gWXzmTMMVSrmPc0JA7bgG
	 BCJBtQjPR4DiZbqexkGZ4u4WQd0T0ckmr6PBpXPBAR4IRRlzE6QTa4eu5Zuy/+6pWm
	 8HTr2LpUpWneQ==
Date: Tue, 28 Mar 2023 12:35:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Message-ID: <ZCMzjVs26imnywgo@kbusch-mbp.dhcp.thefacebook.com>
References: <20230322101648.31514-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322101648.31514-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_113604_589400_5886410E 
X-CRM114-Status: GOOD (  10.38  )
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

On Wed, Mar 22, 2023 at 11:16:45AM +0100, Daniel Wagner wrote:
> Setup different queues, e.g. read and poll queues.

If you wanted to add a similar test for pci, you do it by echo'ing the desired
options to:

  /sys/modules/nvme/parameters/{poll_queues,write_queues}

Then do an 'nvme reset' on the target nvme pci device.

I'll just note that such a test will currently fail, and fixing that doesn't
look like fun. :)

