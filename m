Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1E8EB7ED8
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 04:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TSWe58RMRNZqDGNlk9PvpSGKM172nKbh76SiaqJAak8=; b=3wbp0GfVurvdLB8JDb1PddE4ll
	Pjc11GRi4aEvk41dToiKyPWqu+CRGaJK9cSm5vazBPNoBcqaTabA5o+vFmO7nuElSleWVLJjV54Tu
	QEy3hddD148AQSMMTavGi7GpUXlUp3v2AqbNF6kyUs0R5c7bPt4vPAgkwC/A+TS9ZGyoseL4fYpOd
	YZ/qh8huJ5tR8HaANQoyPoojnQSNYq0ktYg4Axvz2x0XBMgD0GOcl1ixdhvn/xUYd5M4TDIuxzByw
	V9jYp/NaR9rBqxxBp9W/Kg+WSmLICvX0kZdmFsxKh+8GDs0P6VYZNb1XX+Z7o5jceaBcE/Id3T/Bf
	o9G6jwrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy0Ln-00000000u3b-2aT7;
	Thu, 05 Mar 2026 04:30:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy0Lk-00000000u3F-2ftB
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 04:30:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7F0994096A;
	Thu,  5 Mar 2026 04:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CDBC116C6;
	Thu,  5 Mar 2026 04:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772685011;
	bh=sDLL6kdLLLH5WQ7xMSOZqNd8dwEuaVg6Hh8JLKgdj74=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZUMShbbqoby9u5IISgTeqFjl946q/mr9RwRks6xX4G0+/0f8DsySJIsW+EVX7AhkE
	 TMX+AYIiJY9rSx2G99uZzy/sHKioM3KFhKaqi5DfWg7qitbd59kZO9Jt5dXYybVTuI
	 eVonb+pEe0SKtkHW4Me1cRelNTfYth2WEf5V9vRY4r9sIfiNdUVAy2LowRC4iZUDmj
	 R2PzWReSe6idGrhSqDga1q+03N9w22/zaOzbz7okaUnvajmq3UEZdhTRm7eID1vkR1
	 O3OzNYhJTcxg6B6LQZZRobXoM0UTj1mRk3Bspdm6ndnFediHiQo9DJKhAqTyBTJMpF
	 aECdJuXGY4cgw==
Message-ID: <ffc23fb3bc82988608237be48a3eea7fdd3a4dd7.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
From: Geliang Tang <geliang@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>, lsf-pc@lists.linux-foundation.org, 
	linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>, Javier
 =?ISO-8859-1?Q?Gonz=E1lez?=
	 <javier.gonz@samsung.com>
Cc: mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau	 <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hannes
 Reinecke	 <hare@suse.de>
Date: Thu, 05 Mar 2026 12:30:06 +0800
In-Reply-To: <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
		 <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
	 <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_203012_749196_044420A0 
X-CRM114-Status: GOOD (  26.07  )
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

Hi Nilay, Ming,

Thank you again for your interest in NVMe over MPTCP.

On Thu, 2026-02-26 at 17:54 +0800, Geliang Tang wrote:
> Hi Nilay,
> 
> Thanks for your reply.
> 
> On Wed, 2026-02-25 at 20:37 +0530, Nilay Shroff wrote:
> > 
> > 
> > On 1/29/26 9:43 AM, Geliang Tang wrote:
> > > 3. Performance Benefits
> > > 
> > > This new feature has been evaluated in different environments:
> > > 
> > > I conducted 'NVMe over MPTCP' tests between two PCs, each
> > > equipped
> > > with
> > > two Gigabit NICs and directly connected via Ethernet cables.
> > > Using
> > > 'NVMe over TCP', the fio benchmark showed a speed of
> > > approximately
> > > 100
> > > MiB/s. In contrast, 'NVMe over MPTCP' achieved about 200 MiB/s
> > > with
> > > fio, doubling the throughput.
> > > 
> > > In a virtual machine test environment simulating four NICs on
> > > both
> > > sides, 'NVMe over MPTCP' delivered bandwidth up to four times
> > > that
> > > of
> > > standard TCP.
> > 
> > This is interesting. Did you try using an NVMe multipath iopolicy
> > other
> > than the default numa policy? Assuming both the host and target are
> > multihomed,
> > configuring round-robin or queue-depth may provide performance
> > comparable
> > to what you are seeing with MPTCP.
> > 
> > I think MPTCP shall distribute traffic using transport-level
> > metrics
> > such as
> > RTT, cwnd, and packet loss, whereas the NVMe multipath layer makes
> > decisions
> > based on ANA state, queue depth, and NUMA locality. In a setup with
> > multiple
> > active paths, switching the iopolicy from numa to round-robin or
> > queue-depth
> > could improve load distribution across controllers and thus improve
> > performance.
> > 
> > IMO, it would be useful to test with those policies and compare the
> > results
> > against the MPTCP setup.
> 
> Ming Lei also made a similar comment. In my experiments, I didn't set
> the multipath iopolicy, so I was using the default numa policy. In
> the
> follow-up, I'll adjust it to round-robin or queue-depth and rerun the
> experiments. I'll share the results in this email thread.

Based on your feedback, I have added iopolicy support to the NVMe over
MPTCP selftest script (see patch 8 in [1]). We can set the iopolicy to
round-robin like this:

 # ./mptcp_nvme.sh mptcp round-robin

This demonstrates that "NVMe over MPTCP" and "NVMe multipath" can work
simultaneously without conflict.

Using this test script, I compared three I/O policies: numa, round-
robin, and queue-depth. The results for fio were very similar. It's
possible that this test environment doesn't fully reflect the
differences in I/O policies. I will continue to follow up with further
tests.

Thanks,
-Geliang

[1]
NVME over MPTCP, v4
https://patchwork.kernel.org/project/mptcp/cover/cover.1772683110.git.tanggeliang@kylinos.cn/

> 
> Thanks,
> -Geliang
> 
> > 
> > Thanks,
> > --Nilay

