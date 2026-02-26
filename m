Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A6FC5913
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h4NGms2wEkRQdPEXXHfaEX2Je2BRCMN1n0KeLHfIQZ0=; b=AS1aLEBhl5dKUo/AJqHZ/z40IK
	RlovG0N8w1xLAHvck+g1DXw2kLBet4lGimqrX24HHzloPM94jEEYIWpfwSIcGu+PsIT47T5ZsF5pH
	pYoOc1v4eqe3563F8NzNmefqRlwSQ7ryW7FSOFkwqTJuCZixSc78WPueBgLWe1WFMT5Q34RGHfPgC
	PYDVB7mTFJl2GnsHcGUoqkS0jSYKmAozI+AlpLcphTit5OWOGkt0PhXhkX+6aJHhM7Hn4HZagMG2q
	i7T3MXtOWoFDQ++ct5b2gT9MDGFHUQRqxZOzhtHbXK+Zrv92E3o4X+H9zrWANAurzLpFo81OZlntI
	nLDwWTXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvY4r-00000005qWV-27gK;
	Thu, 26 Feb 2026 09:54:37 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvY4p-00000005qWB-2oPF
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 09:54:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 513E443DD9;
	Thu, 26 Feb 2026 09:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A698BC19422;
	Thu, 26 Feb 2026 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772099675;
	bh=YflxXBI6fKxopNaF1Fz3pgT4eJ0/VdR7f2V2GZ6OgH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ATNOf1FmNKADMbM3w7ObC1TZz/3ZxKRhEPzFrOnAbXn1Or3oSycXbhHsDmBhAfMTX
	 cRtCV1dJRDHfFdFxyFID7QK+wD7vvbqmypqrAHsRiI3LOHgPeewTrd+l9b91ZrySXw
	 T9iW78/0bHlVoMQyBvcTFGJRDkUsBdONp+YLhuhk5jt+cOfHbQD9YjS7musecMozOq
	 v0dJdjjGY/1SpHWuFM80xfNX28KUa5zsG7W4QA6qX8CT/RpeeBGbtD7QVShm53i7+Q
	 C8lGChbNndGKmBTYN28krvEX4tSaY8h7djC0aEz/yL2hczcdKSploEG6U9Nod6rtPj
	 ys7T51REGGq7w==
Message-ID: <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
From: Geliang Tang <geliang@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>, lsf-pc@lists.linux-foundation.org, 
	linux-nvme@lists.infradead.org
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau	 <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hannes
 Reinecke	 <hare@suse.de>
Date: Thu, 26 Feb 2026 17:54:29 +0800
In-Reply-To: <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
	 <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_015435_753475_0E82D990 
X-CRM114-Status: GOOD (  18.64  )
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

Hi Nilay,

Thanks for your reply.

On Wed, 2026-02-25 at 20:37 +0530, Nilay Shroff wrote:
> 
> 
> On 1/29/26 9:43 AM, Geliang Tang wrote:
> > 3. Performance Benefits
> > 
> > This new feature has been evaluated in different environments:
> > 
> > I conducted 'NVMe over MPTCP' tests between two PCs, each equipped
> > with
> > two Gigabit NICs and directly connected via Ethernet cables. Using
> > 'NVMe over TCP', the fio benchmark showed a speed of approximately
> > 100
> > MiB/s. In contrast, 'NVMe over MPTCP' achieved about 200 MiB/s with
> > fio, doubling the throughput.
> > 
> > In a virtual machine test environment simulating four NICs on both
> > sides, 'NVMe over MPTCP' delivered bandwidth up to four times that
> > of
> > standard TCP.
> 
> This is interesting. Did you try using an NVMe multipath iopolicy
> other
> than the default numa policy? Assuming both the host and target are
> multihomed,
> configuring round-robin or queue-depth may provide performance
> comparable
> to what you are seeing with MPTCP.
> 
> I think MPTCP shall distribute traffic using transport-level metrics
> such as
> RTT, cwnd, and packet loss, whereas the NVMe multipath layer makes
> decisions
> based on ANA state, queue depth, and NUMA locality. In a setup with
> multiple
> active paths, switching the iopolicy from numa to round-robin or
> queue-depth
> could improve load distribution across controllers and thus improve
> performance.
> 
> IMO, it would be useful to test with those policies and compare the
> results
> against the MPTCP setup.

Ming Lei also made a similar comment. In my experiments, I didn't set
the multipath iopolicy, so I was using the default numa policy. In the
follow-up, I'll adjust it to round-robin or queue-depth and rerun the
experiments. I'll share the results in this email thread.

Thanks,
-Geliang

> 
> Thanks,
> --Nilay

