Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C56C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xSU3tESKQ3v7CZvjbpPc2qUgExJMwoJaElvoyYVymwo=; b=V02qDGjAPyvHvUPcyZ64LwNCwL
	wlLNvpvHKqHR9EqGDOxGQBLqzDOl8xFOp3FNUpus5MUhKLlj9o45ALC5qJLGD/syBJMt/bjm81c7Z
	Tr1iSHQBFgOB8OWV+x3PHSGv/NIR99+uWYoUS/uf6T68vtYNrR3yPF/sGpcCAhlVXD0WHm81MEeE4
	ANAa4j63T9sutatDzKv/n8Ghbh25WV9oLaEhxpdbCvmg9dOO/WroVDsrFWu3zgiB4xno+AQfB5jI3
	4e+/+Wf0xOomn32zbNXeor5GA6790VVp2+2o8Mo6CeNUfCn6MZEn5PIz1Fdj+eiz9grhspnK/lAhX
	RIk047tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1cKG-00GrNo-9G; Wed, 15 Jun 2022 23:21:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1cFT-00GoqT-Gj
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 23:16:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 77807619D9;
	Wed, 15 Jun 2022 23:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9671CC3411B;
	Wed, 15 Jun 2022 23:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655334990;
	bh=uJDAbRhUne1VpqgJp+NbX5hEuKEciyjlBdAFfwtPGyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1NrWr1wISPVX/Oc4CuOXXqOue8/yTb1uDlXZVqvC1gCx3LEOdyqg/jzqTONTGkv1
	 6ba4fWrvAbOBz8CQgEoWNN08NDunGqT3za13pdPvxlx6zhUsl8gVHPgNIzAKsxkKWU
	 oA+QUSZrp6ZIBv4ycORBTnqBPAjJFw/ibbuaXWLwAX5M95Ka+90fPu6xyD6z4z64PA
	 XTZQt4TNzczMZc+UfjrliYduQNquqZ/XMujw2gojUTVv3264OOYlkD4VM6IxbfXT7r
	 Dpb4f8E5ZAOx3VM4rCE6BPN+lVxcDreWjTbtvZj6TdUCczRtdXWHDVk3eqA6s4Go4C
	 TvXyGlN3C0N4g==
Date: Wed, 15 Jun 2022 17:16:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"mstowe@redhat.com" <mstowe@redhat.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <YqpoSp2F+Shqvk/u@kbusch-mbp.dhcp.thefacebook.com>
References: <20220614040044.rypyclhqfv5w4xy7@shindev>
 <20220615194727.GA1022614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615194727.GA1022614@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_161631_675254_A5B58A81 
X-CRM114-Status: GOOD (  19.62  )
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

On Wed, Jun 15, 2022 at 02:47:27PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> > 
> > Yeah, this WARN is confusing for us then it would be valuable to
> > test by blktests not to repeat it. One point I wonder is: which test
> > group the test case will it fall in? The nvme group could be the
> > group to add, probably.
> > 
> > Another point I wonder is other kernel test suite than blktests.
> > Don't we have more appropriate test suite to check PCI device
> > rescan/remove race ? Such a test sounds more like a PCI bus
> > sub-system test than block/storage test.
> 
> I'm not aware of such a test, but it would be nice to have one.
> 
> Can you share your qemu config so I can reproduce this locally?
> 
> Thanks for finding and reporting this!

Hi Bjorn,

This ought to be reproducible with any pci device that can be removed. Since we
initially observed with nvme, you can try with such a device. A quick way to
get one appearing in qemu is to add parameters:

        -drive id=n,if=none,file=null-co://,format=raw \
	-device nvme,serial=foobar,drive=n

