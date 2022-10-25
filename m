Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2517AC67871
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 02:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZOAdYQH6QqiCu58wDzX9mib+PSej/7CCxnocgHOoqfU=; b=F1HnzBWaefY2WbtDLst2QIikRA
	kNP0iRraqMvIhP3UgFHfc0Kt9xMyCS6dQSs4bnRHYAht2Smo2T3n+sxuDSzMgl6QmL1LDwv9XDff4
	4bay9VwcADP758QcensQZgncXoGRcvQccPYesRCtvbR2SAnuQVpXdYplD3N6ZU0zLRoJ6CLp2wH4C
	kY+cf7sstPjJBza7q4qcA1jkxJ+hjX1g9RITKJGEDqFQJtN2SgamSTgFpJUWj0NzYRCHycqovbA64
	Dhg5rKdl4sS00+OiuLMjbLMkjyUcOl0MCcCLxlV+LrET6KYfyyzXjM06U0XF6wuRH2nffEdnhKRtd
	JXGsKioA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on9ek-003bcL-EB; Tue, 25 Oct 2022 02:27:06 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on9ee-003bbW-IK
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 02:27:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 07BCAB818C4;
	Tue, 25 Oct 2022 02:26:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76943C433C1;
	Tue, 25 Oct 2022 02:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666664817;
	bh=MzGXpW+OUvz0OauoWn2mGgBcab2t4I7E7RFrvazm0nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nb8CTpDffPVFy83212c7pa9wcAmboiy0gNkFhDU0QJMu6VIowotuSCnBD9D8DWRzw
	 sOtbaxAae42hQCg73FFi9BlHUZbfBmOPSwY/18gNCEAP+JjlKcHEbtvewttqRSIFsX
	 Q/1A1pdXHvFaKyundSlWmi6Oy5DzxEvnXb0EIxVUlP1GM3r2DV5ZwRzIl7S975zfqp
	 MJEJdtMGdx9hTKzVU05sYfffsMFSwOOF+VMn0KNvl/frW7fJddLgkihdHthAfGgu9l
	 CjL+wBLdKgrUdlc18cw41nwxLkncCWJdSnVc/vE13PXPKTFWxW1dns+R1RZQNADRhR
	 Bir/81bnjpLlQ==
Date: Mon, 24 Oct 2022 20:26:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [External] : Re: way to unbind a bad nvme device/controller
 without powering off system
Message-ID: <Y1dJbgKZUU9z/7Ok@kbusch-mbp.dhcp.thefacebook.com>
References: <1de825e1-912d-6848-763f-c1836ce90d20@oracle.com>
 <Y1cTbOinkQZvpzY0@kbusch-mbp.dhcp.thefacebook.com>
 <13888912-24a4-870a-cc93-4192a69ce9ca@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13888912-24a4-870a-cc93-4192a69ce9ca@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_192700_767625_D8950C3C 
X-CRM114-Status: GOOD (  18.28  )
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

On Mon, Oct 24, 2022 at 08:02:33PM -0400, James Puthukattukaran wrote:
> On 10/24/22 18:36, Keith Busch wrote:
> 
> > 
> > Generally, the default timeout is really long. If you have a broken
> > controller, it could take several minutes before the driver unblocks
> > forward progress to unbind.
> One concern is that the reset controller flow attempts to reinitialze the controller and this will cause problems if the controller is bad. Would it make sense to have a sysfs "remove_controller" interface that simply goes through and does a nvme_dev_disable() with the assumption that the controller is dead? Will the nvme_kill_queues() in nvme_dev_disadble() unwedge any potential nvme reset thread that is blocked and thus allow the nvme_remove() flow to complete?
> thanks

In your log snippet, there's this line:

  kernel:warning: [10416608.580157] nvme nvme3: I/O 209 QID 1 timeout, disable controller

The next action the driver takes after logging that is to drain any
outstanding IO through a forced reset, and all subsequent tasks *should*
be unblocked after that completes to allow the unbinding, so I don't
think adding any new sysfs knobs is going to help if it's not already
succeeding.

The only other thing that looks odd is that one of your stuck tasks is a
user passthrough command, but that should have also been cleared out by
the reset. Do you know what command that process is sending? I'll need
to double check your kernel version to see if there's anything missing
in that driver to ensure the unbinding succeeds. 

