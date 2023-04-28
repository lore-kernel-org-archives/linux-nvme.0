Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DA4C77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UF1Ua2hzLjpAgiULPhU9Pgc4cxLltgBBtMhvZFerIk4=; b=3mTDj4IiJ7syunjwtqpCm+zwr5
	Yqvay7zymrAyyfqJVr5aTc2eza/uISn+2X+bHw545nitfoauKa0kZ5Af3BBUXIdlLBKuiLshhtTcZ
	mzEPi2X+UhJ+OfbMeuKUfXRrU8m6bcANGuCPlMlIJTookjuYClyaZpVJT3QGxX3I2ABMjJ0GofXKM
	xa+Xs0gE2RKBFMFIn3+v0URWP504Uk4ZirMxSUYWu89q7aVqMxIMea9jY2DOu9oYx5RqfXKPZJjqQ
	jEU2yPqWNXvqUTJHSQxElaRv+gT66I+10LDnmzgZsMGYbNV5IMsDFw9pbbLqbrgMswzCK90wYTod/
	HPo52bJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psUMC-00BhCj-2i;
	Fri, 28 Apr 2023 20:06:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psUM7-00BhCL-0u
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 20:06:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7F51B60A75;
	Fri, 28 Apr 2023 20:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A353CC433D2;
	Fri, 28 Apr 2023 20:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682712369;
	bh=PTdpjj7bLUo5MXR1zJMOebETFdhX7xtJk/Ofy6NRSQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaN/7UpOoeAAfOHdKTH3Lm6+9BSqwRssWp0FY1QYlxAka+c1bJ2wBPSU+3/Zvr38S
	 nPjm2ofRwVqk/SuNbZ/7xEhkfcFUwVhuLCZZEItIWqqRGcSNKnengsTvqnehrnR/Br
	 uu+NicuPnIMPNkCZqtokMY1zHHqsm872uC4CBuH5B59JLBVCHIVgMRJ2U/FTp6akYw
	 o+lcqBRj88yn/WZzCyx2vCm3yzLJNpZXI+E1boOmc8sXSywANR5QED1G90bPX2u8zP
	 PKG6tb+oo4rKeVmUOqlp4YNtffbl+5YdYSvy2UUd+vNHvoO9sUaNgZzBlH9Q8MtHP4
	 I23hDUScjyAhw==
Date: Fri, 28 Apr 2023 14:06:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wang Yicheng <wangyicheng1209@gmail.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Seeking for help with NVMe arbitration questions
Message-ID: <ZEwnL0hSTVJWoMTN@kbusch-mbp.dhcp.thefacebook.com>
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com>
 <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
 <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com>
 <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
 <ZErr8OV5JRpUityQ@kbusch-mbp.dhcp.thefacebook.com>
 <CAPiksxOu2W62bP9fFuHvxjACz+cvxH58fEkoFvALKFdHax3Tcw@mail.gmail.com>
 <ZEvpoiDVFuOs8wyw@kbusch-mbp.dhcp.thefacebook.com>
 <CAPiksxMs00uLcOxxxKXUPpJEgCCEHDVx3JVKbe2AivHCJ553wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPiksxMs00uLcOxxxKXUPpJEgCCEHDVx3JVKbe2AivHCJ553wA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_130611_373322_D22013F3 
X-CRM114-Status: GOOD (  10.86  )
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

On Fri, Apr 28, 2023 at 11:18:03AM -0700, Wang Yicheng wrote:
> 
> Then this confuses me with the motivations of introducing different
> queue types. Doesn't it aim for providing some sort of prioritization?

Having a separate read queue ensures that reads won't get starved for
a command resource by a write intensive workload. AFAIK, it's not a very
common option to enable.

The poll queues are intended for latency senstive applications.  I
don't think it will be as reliable if you are running concurrently
with interrupt driven workloads: the interrupts will just preempt
the polling threads.

