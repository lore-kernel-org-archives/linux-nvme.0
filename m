Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2132BC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 19:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yf+Eg/1/1QwbTM8y1Td+PBjfwL/t5v0t2urz6oIApD0=; b=stDvDdnRKIxVUfAiWmub6zvU7/
	1v+UN88t7tTgM1gvl0da/GNDTeitSaoqsaHen4xzn9lhFnJaIG/catZ8KwP29/ITxWMQcIK5GEfIp
	P/Dxxfut3ghHYj5yMBFhX5aI49Y80sFoTe7xJKsPhdWY6GDxyAENYTXNs8gkM6fP5JcRkn7cUE3e2
	ZMqiJk8RL1SCV9ZiVIJXQI7sNF0iscX1aLTglUQjVwuL9V2u9finA2RGTqEqPxtOKTre2C1nKphRT
	lrvvyFiyRwWN9b5eJSkdSulJzGLlQ+hgVao+NOVIDDYXdX3I0UiQraMfd7JPJattPUKXV+KivxjEu
	zGfruEpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppa4N-008sW2-1d;
	Thu, 20 Apr 2023 19:35:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppa4K-008sVc-2a
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 19:35:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3176964871;
	Thu, 20 Apr 2023 19:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189C6C433D2;
	Thu, 20 Apr 2023 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682019347;
	bh=aO6dBpJyque3slR/AAgJ75ejWLliBtuYx15tbIy4XD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qDxHmXOBCMY2YqfCeuMBpTKcOTyPpxyuklgPLT69AfSazfruIj5tpHxaKVCY2AEmB
	 smkE7FXYWjgWZ4zISOL2EoXlBmcgubTfkEGYsI4oPWI/wrCh/1+LW08LisuoPDfi+Q
	 PCYN+hwXGbBpZLKVpymwJbo5yBtGV0IJNPm5ZC81Uds+DvUD62ZGrAWg7w1VGo1fXl
	 tle4vafdrBDReUUF1eQ6OFln+YecaVS+phZUqu4W6wpN61agD3ZPMIo6oXyqhSwCyX
	 nfU4y3pQ8LY8e2pyYQRat6GJ+mJSq2Zqum2VDpgDRvW8i2jbLZ3yUwVNWJh75rBSt5
	 radrT59Fp2JZQ==
Date: Thu, 20 Apr 2023 13:35:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Igor Rybak <igor@media-clone.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ezra Kohavi <ezra@media-clone.com>
Subject: Re: read-only flag
Message-ID: <ZEGUDBDCFtSswIvf@kbusch-mbp.dhcp.thefacebook.com>
References: <BN8PR15MB28040020497BA4D8375B643184639@BN8PR15MB2804.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR15MB28040020497BA4D8375B643184639@BN8PR15MB2804.namprd15.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_123548_872759_A5A1B838 
X-CRM114-Status: GOOD (  12.04  )
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

On Thu, Apr 20, 2023 at 07:25:09PM +0000, Igor Rybak wrote:
> Hi,
> 
> If I set the read-only flag on a block device like "sudo blockdev -setro /dev/nvme0n1", I can still erase the drive with "nvme format /dev/nvme0n1". 
> Is this normal? Where do you think the read-only flag should be handled?

'format' is an admin command utilizing the admin queue, which is not tied to
the block device. If you're seeking a way to prevent accidently formatting a
namespace that you've marked 'read-only', I don't think any such method exists.

