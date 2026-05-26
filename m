Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F17CD5BD2
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzhHbQLqPxpkHuUuNKnAM9D6uFtNbONP+Q7veftd8Fw=; b=efbGOHDyw9b9hVeGDxCIIFeN+k
	bByE/MSazg/IMofoe8LL8mQu3c/PnMBXCCdCUZU5IEVEwcUU4rrC2FcoxT7rCAVAQuT6F7qD2zBd3
	RHtdeVnQyqfVWH+yIqpmt4/XToy9XFADDXTOTMw70Qb6PHTDEREcU5DmIxVQXtKRGjZ487BuvQeR1
	BN82AsZXe2ivm3rqslx0AHbFRmPE+VxVPvcQ5DAgqRXTC/sL9ikLEMXHwF3jKkBaMm2olkLYDMXrb
	xjxQwCx54fusyl9q/FmDs0AZUH1X4DBfebj7081YwOP+/lODKH3XWXZ6tsdiFSCAzs3U4j013rh8d
	T1JFHtvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRopi-00000001crz-2L3F;
	Tue, 26 May 2026 10:16:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRoph-00000001crl-0Yer
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 10:16:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 33AF260018;
	Tue, 26 May 2026 10:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7291F00A3A;
	Tue, 26 May 2026 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779790579;
	bh=zzhHbQLqPxpkHuUuNKnAM9D6uFtNbONP+Q7veftd8Fw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WNQSziTV2XK5H5j/e6AP9KZVyvzFXD9jqeSBNYrfHMrVqrgPZer3n/RmFY6NTR0ah
	 RvSyqbx+ovoJHcY6lQHj2T2n753FuvVt7YitIlKPiJjaNfKjpU6Ov70183+zq7QSCO
	 znL+PN9VO/iosjQXiiK9N6K28Ren5V5hSrPwuw6cHTEX8Zlg6OdbW5TuYBjWrV2grt
	 4u77rbYz279R2GSt26q/EOobA208Gm1MaYBDWw2bddSO0BCGTwdPinVGLFmn55/X1v
	 mcmj72UbJK6XVh3fDGUHchRSZQYxrDZapsJBix52eNbgCm6F4MPDSlIK3IEUFF8LJf
	 U5IqzauN3Hdug==
Message-ID: <673a22df98d260e7bac1a5057de092014b3525d5.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
From: Geliang Tang <geliang@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: mptcp@lists.linux.dev, linux-nvme@lists.infradead.org
Date: Tue, 26 May 2026 18:16:14 +0800
In-Reply-To: <f902be73f83291b732a8e33361bfcdb7e75a0afd.camel@kernel.org>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
			 <48e429f3-e29f-4eac-b4d3-3bf9e0d1c245@linux.ibm.com>
			 <ecb30d89b67b992bfc136186f18550f9fb974baa.camel@kernel.org>
			 <ffc23fb3bc82988608237be48a3eea7fdd3a4dd7.camel@kernel.org>
		 <6042b928aa8116d531c5e360ba19fa077af87bcc.camel@kernel.org>
	 <f902be73f83291b732a8e33361bfcdb7e75a0afd.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Off-list.

On Tue, 2026-05-19 at 15:31 +0800, Geliang Tang wrote:
> Hi,
> 
> The performance test results of MPTCP under several NVMe multipath
> settings are now ready.
> 
> On Wed, 2026-05-13 at 18:04 +0800, Geliang Tang wrote:
> > Hello everyone,
> > 
> > Thank you for your interest in NVMe over MPTCP. I have attached the
> > slides from the presentation to this email.
> > 
> > Please note that the demo in the slides only configured a single
> > NVMe
> > multipath. Subsequently, I will post the MPTCP performance test
> > results
> > under several NVMe multipaths here.
> 
> To test the performance of TCP and MPTCP under NVMe multipath, I
> added
> two more arguments, "path" and "loss", to the original NVMe MPTCP
> self
> test script. The latest code is available at [1].
> 
> The script now accepts the following four arguments:
> 
>   mptcp_nvme.sh [trtype] [path] [iopolicy] [loss]
> 
>   trtype   Transport type (tcp|mptcp) - default: mptcp
>   path     Number of multipath (1-4) - default: 1
>   iopolicy I/O policy (numa|round-robin|queue-depth) - default: numa
>   loss     Enable packet loss (0|1) - default: 0
> 
> The first argument is the transport type. The second argument,
> "path",
> specifies how many NVMe multipaths to create. The third argument is
> the
> I/O policy. The fourth argument controls whether the network
> environment is lossy. When set to 0, each NIC is rate-limited to 125
> MB/s (tc arguments: rate 1000mbit). When set to 1, in addition to the
> same rate limit of 125 MB/s, each NIC also experiences a 5 ms delay
> and
> 0.5% packet loss (tc arguments: rate 1000mbit delay 5ms loss 0.5%).
> 
> 
> First set of tests: lossless network, path=4, loss=0. The tc output
> is
> as follows:
> 
>   qdisc netem 8031: root refcnt 25 limit 1000 rate 1Gbit
> 			seed 1626193586047356330
> 
> Lossless network, comparison between TCP and MPTCP using the "numa"
> policy - MPTCP is four times faster than TCP:
> 
> # ./mptcp_nvme.sh tcp 4 numa 0
>    READ: bw=114MiB/s (119MB/s), 114MiB/s-114MiB/s (119MB/s-119MB/s),
> 			io=1200MiB (1259MB), run=10533-10533msec
>   WRITE: bw=114MiB/s (119MB/s), 114MiB/s-114MiB/s (119MB/s-119MB/s),
> 			io=1203MiB (1261MB), run=10570-10570msec
> 
> # ./mptcp_nvme.sh mptcp 4 numa 0
>    READ: bw=445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
> 			io=4512MiB (4731MB), run=10130-10130msec
>   WRITE: bw=443MiB/s (465MB/s), 443MiB/s-443MiB/s (465MB/s-465MB/s),
> 			io=4504MiB (4723MB), run=10158-10158msec
> 
> Lossless network, comparison between TCP and MPTCP using the "round-
> robin" policy - MPTCP and TCP show similar performance:
> 
> # ./mptcp_nvme.sh tcp 4 round-robin 0
>    READ: bw=456MiB/s (478MB/s), 456MiB/s-456MiB/s (478MB/s-478MB/s),
> 			io=4683MiB (4910MB), run=10278-10278msec
>   WRITE: bw=455MiB/s (477MB/s), 455MiB/s-455MiB/s (477MB/s-477MB/s),
> 			io=4660MiB (4887MB), run=10239-10239msec
> 
> # ./mptcp_nvme.sh mptcp 4 round-robin 0
>    READ: bw=446MiB/s (467MB/s), 446MiB/s-446MiB/s (467MB/s-467MB/s),
> 			io=4565MiB (4786MB), run=10239-10239msec
>   WRITE: bw=445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
> 			io=4575MiB (4797MB), run=10280-10280msec
> 
> Lossless network, comparison between TCP and MPTCP using the "queue-
> depth" policy - MPTCP and TCP show similar performance:
> 
> # ./mptcp_nvme.sh tcp 4 queue-depth 0
>    READ: bw=456MiB/s (478MB/s), 456MiB/s-456MiB/s (478MB/s-478MB/s),
> 			io=4632MiB (4857MB), run=10169-10169msec
>   WRITE: bw=455MiB/s (477MB/s), 455MiB/s-455MiB/s (477MB/s-477MB/s),
> 			io=4666MiB (4893MB), run=10250-10250msec
> 
> # ./mptcp_nvme.sh mptcp 4 queue-depth 0
>    READ: bw=446MiB/s (467MB/s), 446MiB/s-446MiB/s (467MB/s-467MB/s),
> 			io=4568MiB (4790MB), run=10249-10249msec
>   WRITE: bw=445MiB/s (467MB/s), 445MiB/s-445MiB/s (467MB/s-467MB/s),
> 			io=4563MiB (4784MB), run=10245-10245msec
> 
> 
> Second set of tests: lossy network, path=4, loss=1. The tc output is
> as
> follows:
> 
>   qdisc netem 8051: root refcnt 25 limit 1000 delay 5ms loss 0.5%
> 			rate 1Gbit seed 14946049878654165618
> 
> Lossy network, comparison between TCP and MPTCP using the "round-
> robin"
> policy - MPTCP is four times faster than TCP:
> 
> # ./mptcp_nvme.sh tcp 4 round-robin 1
>    READ: bw=106MiB/s (111MB/s), 106MiB/s-106MiB/s (111MB/s-111MB/s),
> 			io=1574MiB (1650MB), run=14906-14906msec
>   WRITE: bw=98.5MiB/s (103MB/s), 98.5MiB/s-98.5MiB/s (103MB/s-
> 103MB/s),
> 			io=1455MiB (1526MB), run=14770-14770msec
> 
> # ./mptcp_nvme.sh mptcp 4 round-robin 1
>    READ: bw=426MiB/s (447MB/s), 426MiB/s-426MiB/s (447MB/s-447MB/s),
> 			io=4533MiB (4753MB), run=10637-10637msec
>   WRITE: bw=428MiB/s (449MB/s), 428MiB/s-428MiB/s (449MB/s-449MB/s),
> 			io=4507MiB (4725MB), run=10522-10522msec
> 
> Lossy network, comparison between TCP and MPTCP using the "queue-
> depth"
> policy - MPTCP is four times faster than TCP:
> 
> # ./mptcp_nvme.sh tcp 4 queue-depth 1
>    READ: bw=168MiB/s (176MB/s), 168MiB/s-168MiB/s (176MB/s-176MB/s),
> 			io=2179MiB (2285MB), run=12965-12965msec
>   WRITE: bw=128MiB/s (134MB/s), 128MiB/s-128MiB/s (134MB/s-134MB/s),
> 			io=1590MiB (1667MB), run=12418-12418msec
> 
> # ./mptcp_nvme.sh mptcp 4 queue-depth 1
>    READ: bw=425MiB/s (445MB/s), 425MiB/s-425MiB/s (445MB/s-445MB/s),
> 			io=4536MiB (4756MB), run=10677-10677msec
>   WRITE: bw=414MiB/s (434MB/s), 414MiB/s-414MiB/s (434MB/s-434MB/s),
> 			io=4447MiB (4663MB), run=10733-10733msec
> 
> 
> Conclusion: MPTCP achieves bandwidth aggregation comparable to that
> of
> NVMe multipath while offering better resilience against network
> interference.
> 
> The full test results are in the attachment.

Thank you very much for your interest in NVMe MPTCP. During my
presentation, I mentioned that I would show you the performance test
results of MPTCP when configuring several NVMe multipath paths. I spent
some time updating the scripts, and here are the latest results. What
do you think of these results? Please give me some suggestions.

Thanks,
-Geliang

> 
> Thanks,
> -Geliang
> 
> [1]
> https://patchwork.kernel.org/project/mptcp/cover/cover.1779159524.git.tanggeliang@kylinos.cn/
> 
> > 
> > Thanks,
> > -Geliang
> > 
> > On Thu, 2026-03-05 at 12:30 +0800, Geliang Tang wrote:
> > > Hi Nilay, Ming,
> > > 
> > > Thank you again for your interest in NVMe over MPTCP.
> > > 
> > > On Thu, 2026-02-26 at 17:54 +0800, Geliang Tang wrote:
> > > > Hi Nilay,
> > > > 
> > > > Thanks for your reply.
> > > > 
> > > > On Wed, 2026-02-25 at 20:37 +0530, Nilay Shroff wrote:
> > > > > 
> > > > > 
> > > > > On 1/29/26 9:43 AM, Geliang Tang wrote:
> > > > > > 3. Performance Benefits
> > > > > > 
> > > > > > This new feature has been evaluated in different
> > > > > > environments:
> > > > > > 
> > > > > > I conducted 'NVMe over MPTCP' tests between two PCs, each
> > > > > > equipped
> > > > > > with
> > > > > > two Gigabit NICs and directly connected via Ethernet
> > > > > > cables.
> > > > > > Using
> > > > > > 'NVMe over TCP', the fio benchmark showed a speed of
> > > > > > approximately
> > > > > > 100
> > > > > > MiB/s. In contrast, 'NVMe over MPTCP' achieved about 200
> > > > > > MiB/s
> > > > > > with
> > > > > > fio, doubling the throughput.
> > > > > > 
> > > > > > In a virtual machine test environment simulating four NICs
> > > > > > on
> > > > > > both
> > > > > > sides, 'NVMe over MPTCP' delivered bandwidth up to four
> > > > > > times
> > > > > > that
> > > > > > of
> > > > > > standard TCP.
> > > > > 
> > > > > This is interesting. Did you try using an NVMe multipath
> > > > > iopolicy
> > > > > other
> > > > > than the default numa policy? Assuming both the host and
> > > > > target
> > > > > are
> > > > > multihomed,
> > > > > configuring round-robin or queue-depth may provide
> > > > > performance
> > > > > comparable
> > > > > to what you are seeing with MPTCP.
> > > > > 
> > > > > I think MPTCP shall distribute traffic using transport-level
> > > > > metrics
> > > > > such as
> > > > > RTT, cwnd, and packet loss, whereas the NVMe multipath layer
> > > > > makes
> > > > > decisions
> > > > > based on ANA state, queue depth, and NUMA locality. In a
> > > > > setup
> > > > > with
> > > > > multiple
> > > > > active paths, switching the iopolicy from numa to round-robin
> > > > > or
> > > > > queue-depth
> > > > > could improve load distribution across controllers and thus
> > > > > improve
> > > > > performance.
> > > > > 
> > > > > IMO, it would be useful to test with those policies and
> > > > > compare
> > > > > the
> > > > > results
> > > > > against the MPTCP setup.
> > > > 
> > > > Ming Lei also made a similar comment. In my experiments, I
> > > > didn't
> > > > set
> > > > the multipath iopolicy, so I was using the default numa policy.
> > > > In
> > > > the
> > > > follow-up, I'll adjust it to round-robin or queue-depth and
> > > > rerun
> > > > the
> > > > experiments. I'll share the results in this email thread.
> > > 
> > > Based on your feedback, I have added iopolicy support to the NVMe
> > > over
> > > MPTCP selftest script (see patch 8 in [1]). We can set the
> > > iopolicy
> > > to
> > > round-robin like this:
> > > 
> > >  # ./mptcp_nvme.sh mptcp round-robin
> > > 
> > > This demonstrates that "NVMe over MPTCP" and "NVMe multipath" can
> > > work
> > > simultaneously without conflict.
> > > 
> > > Using this test script, I compared three I/O policies: numa,
> > > round-
> > > robin, and queue-depth. The results for fio were very similar.
> > > It's
> > > possible that this test environment doesn't fully reflect the
> > > differences in I/O policies. I will continue to follow up with
> > > further
> > > tests.
> > > 
> > > Thanks,
> > > -Geliang
> > > 
> > > [1]
> > > NVME over MPTCP, v4
> > > https://patchwork.kernel.org/project/mptcp/cover/cover.1772683110.git.tanggeliang@kylinos.cn/
> > > 
> > > > 
> > > > Thanks,
> > > > -Geliang
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > --Nilay

