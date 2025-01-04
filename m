Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D307E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 00:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D+n3QEmeRfRYM23xSEzJP15ZH0somRZNJRx2eiFF6O8=; b=z/julXkX4c9FSry1o4qr+J6DCD
	V2ca/omR2I4qNKlhkuL3Jv0/2xTn3rENc0GIZ+pQWWlRLfi4L72admKgWSqQq6/rimOOExGpQwxDx
	oMIiIz6wh1U0usr/MWHmYnZhe7Ilk5jp6tn7nf/4S10OP2G3xLBT1x+VrK3DJK/0A3j1tcjwGy/F2
	i3CJgvMnCbbXLz1gLNbRlI4PmCH6duPKroczaNEoxqMofQ348pedq3tkjkxL5f1jSCm0m2OZ7Uuiq
	Z170LrjebfvhbhMRl5eLuheTLoQRZVICs9selNq65bH+xhs3spx6yX+vS5ZlMjw92qA2DmiIA7GA1
	szRNl4AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTsKS-0000000EH7F-0nhL;
	Sat, 04 Jan 2025 00:47:48 +0000
Received: from out-173.mta0.migadu.com ([2001:41d0:1004:224b::ad])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTsKO-0000000EH6J-3WfD
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 00:47:46 +0000
Message-ID: <906201cc-2d16-4c34-9443-737b53a8a07f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735951659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+n3QEmeRfRYM23xSEzJP15ZH0somRZNJRx2eiFF6O8=;
	b=SOuEypC3LA+C/nZaQZz/rmfGZiSB0532CA884XVFpOxhEXGv9uTy75Pw1R0cWirbkbaG9+
	7rcSgODLQc5TYieLQ/f6QWJQ+HScL7gu6GraJG5601n89SG0Gb3k3sfv2vJouCnDmLyBLL
	VUkIwvK6sz+F6WmbNm8BHiPWRGpTPj8=
Date: Sat, 4 Jan 2025 01:47:36 +0100
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Improving Block Layer Tracepoints for
 Next-Generation Backup Systems
To: Vishnu ks <ksvishnu56@gmail.com>, lsf-pc@lists.linux-foundation.org
Cc: linux-block@vger.kernel.org, bpf@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CAJHDoJac2Qa6QjhDFi7YZf0D05=Svc13ZQyX=92KsM7pkkVbJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_164745_341139_AB0F8024 
X-CRM114-Status: GOOD (  15.27  )
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

在 2025/1/1 7:34, Vishnu ks 写道:
> Dear Community,
> 
> I would like to propose a discussion topic regarding the enhancement
> of block layer tracepoints, which could fundamentally transform how
> backup and recovery systems operate on Linux.
> 
> Current Scenario:
> 
> - I'm developing a continuous data protection system using eBPF to
> monitor block request completions

I am interested in this "eBPF to monitor block request". Will this eBPF 
make difference on the performance of the whole system? And how to use 
eBPF to implement this feature? Hope to join the meeting to listen to 
this topic.

Best Regards,

Zhu Yanjun

> - The system aims to achieve reliable live data replication for block devices
> Current tracepoints present challenges in capturing the complete
> lifecycle of write operations
> 
> Potential Impact:
> 
> - Transform Linux Backup Systems:
> - Enable true continuous data protection at block level
> - Eliminate backup windows by capturing changes in real-time
> - Reduce recovery point objectives (RPO) to near-zero
> - Allow point-in-time recovery at block granularity
> 
> Current Technical Limitations:
> 
> - Inconsistent visibility into write operation completion
> - Gaps between write operations and actual data flushes
> - Potential missing instrumentation points
> - Challenges in ensuring data consistency across replicated volumes
> 
> Proposed Improvements:
> 
> - Additional tracepoints for better write operation visibility
> - Optimal placement of existing tracepoints
> - New instrumentation points for reliable block-level monitoring
> 
> Implementation Considerations:
> 
> - Performance impact of additional tracepoints
> - Integration with existing block layer infrastructure
> - Compatibility with various storage backends
> - Requirements for consistent backup state
> 
> These improvements could revolutionize how we approach backup and
> recovery on Linux systems:
> 
> - Move from periodic snapshots to continuous data protection
> - Enable more granular recovery options
> - Reduce system overhead during backup operations
> - Improve reliability of backup systems
> - Enhance disaster recovery capabilities
> 
> This discussion would benefit both the block layer and BPF
> communities, as well as the broader Linux ecosystem, particularly
> enterprises requiring robust backup and recovery solutions.
> 
> Looking forward to the community's thoughts and feedback.
> 
> Best regards,


