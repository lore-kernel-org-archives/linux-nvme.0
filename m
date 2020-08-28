Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108EC433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:43:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DC42073A
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EqRNOWLO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSkbwE/s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DC42073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Subject:In-Reply-To:Message-ID:To:From:
	Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	 bh=sDV08K4mQs4XQUmKlo1iLwa6pOGXmhsFnnaUU44ApAY=; b=EqRNOWLO494iheOlPgXDGdcHy
	IiimEzBhMWsumTz4YtJJvS5gQA1x2lM5wM02bNkVjCAGD/TFKFLpPW3M7lSUhuqHUEVxzCl5NQ72+
	vP2jcQvDK66ny9doFNRtkCu3s+2zakZRQ7sXLI6Xf5o/S2ObPTP8IE2t+S10i+U6Akbuon5Uc9kYU
	vHLF4efzsBuZPw0y49KD6ffSavSMBiSXwI28SOYU5wFBeD2mLu27y2eSXLk0YRYEtosnWVIq6MRFv
	KtkQ4ovfW03opouhfVJsfdSDMTRMiJ3vdmfgcvhue4bs1o6l+jHh3Kh1UCEUjQpzbPUxQzFSkH2ca
	5pwH7OCYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBWEf-00083w-9z; Fri, 28 Aug 2020 04:43:33 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBWEb-00083V-Cw
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 04:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598589807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to; 
 bh=GJtXt6NHwPL//ONLaVMTIy8pBclDmWlfx+pDNWsCPm4=;
 b=RSkbwE/snkPL3h/6M6WXpYWb+YgU3x4u24HbMCsC7PyZYVLluWKMkwpYCedyD9cGflydq9
 kDekSyzybGCxZv6SvpvrWbKrojOGehjAB6mZfjvCD+KUshgRMBjrAQ8XNHqpJOzs+L5lsw
 mPToVuIVPFYJDBE1jen9dv50GHtdfJc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-CzVRzl4XPC-Xo-66bTR7tA-1; Fri, 28 Aug 2020 00:43:07 -0400
X-MC-Unique: CzVRzl4XPC-Xo-66bTR7tA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7880C1005E5D;
 Fri, 28 Aug 2020 04:43:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D83D5C1C2;
 Fri, 28 Aug 2020 04:43:05 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com
 (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id C976D180B655;
 Fri, 28 Aug 2020 04:43:04 +0000 (UTC)
Date: Fri, 28 Aug 2020 00:43:04 -0400 (EDT)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Message-ID: <769167569.38843663.1598589784057.JavaMail.zimbra@redhat.com>
In-Reply-To: <169507736.38843516.1598588995705.JavaMail.zimbra@redhat.com>
Subject: [bug report] stress reset_controller operation on NVMe/IB lead OOM
 from 5.8-rc1
MIME-Version: 1.0
X-Originating-IP: [10.68.5.41, 10.4.195.8]
Thread-Topic: stress reset_controller operation on NVMe/IB lead OOM from
 5.8-rc1
Thread-Index: 14ZHr9v2O3p1n/eBnFPmqFvWV5hAmA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
X-Bad-Reply: In-Reply-To but no 'Re:' in Subject.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello

From 5.8-rc1 stress reset_controller operation will lead system OOM on both target/host side.
This issue cannot be reproduced on v5.7 and still can be reproduced on v5.9-rc1, let me know if you need more info, thanks.

Environment:
mlx5 MT27700 CX-4

host side OOM log:

[ 5252.613519] sysrq: Show Memory 
[ 5252.616948] Mem-Info: 
[ 5252.619500] active_anon:593 inactive_anon:26681 isolated_anon:0 
[ 5252.619500]  active_file:104695 inactive_file:121897 isolated_file:0 
[ 5252.619500]  unevictable:0 dirty:84 writeback:0 
[ 5252.619500]  slab_reclaimable:48156 slab_unreclaimable:167295 
[ 5252.619500]  mapped:23363 shmem:5491 pagetables:1642 bounce:0 
[ 5252.619500]  free:31851096 free_pcp:13235 free_cma:0 
[ 5252.658539] Node 0 active_anon:396kB inactive_anon:88424kB active_file:154204kB inactive_file:390732kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:80316kB dirty:104kB writeback:0kB shmem:12452kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 18432kB writeback_tmp:0kB kernel_stack:6000kB all_unreclaimable? no 
[ 5252.691536] Node 1 active_anon:1976kB inactive_anon:18300kB active_file:264576kB inactive_file:96856kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:13136kB dirty:232kB writeback:0kB shmem:9512kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 4096kB writeback_tmp:0kB kernel_stack:4368kB all_unreclaimable? no 
[ 5252.724534] Node 0 DMA free:11264kB min:8kB low:20kB high:32kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15984kB managed:15360kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB 
[ 5252.755204] lowmem_reserve[]: 0 1756 64173 64173 64173 
[ 5252.761421] Node 0 DMA32 free:1914020kB min:1228kB low:3024kB high:4820kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:1985352kB managed:1919816kB mlocked:0kB pagetables:0kB bounce:0kB free_pcp:1676kB local_pcp:0kB free_cma:0kB 
[ 5252.794066] lowmem_reserve[]: 0 0 62417 62417 62417 
[ 5252.800066] Node 0 Normal free:60243144kB min:43704kB low:107616kB high:171528kB reserved_highatomic:0KB active_anon:396kB inactive_anon:88424kB active_file:154204kB inactive_file:390732kB unevictable:0kB writepending:104kB present:65011712kB managed:63923716kB mlocked:0kB pagetables:5820kB bounce:0kB free_pcp:34332kB local_pcp:508kB free_cma:0kB 
[ 5252.836139] lowmem_reserve[]: 0 0 0 0 0 
[ 5252.841056] Node 1 Normal free:65215060kB min:45164kB low:111216kB high:177268kB reserved_highatomic:0KB active_anon:1976kB inactive_anon:18300kB active_file:264576kB inactive_file:96856kB unevictable:0kB writepending:232kB present:67108864kB managed:66055224kB mlocked:0kB pagetables:748kB bounce:0kB free_pcp:17020kB local_pcp:0kB free_cma:0kB 
[ 5252.877193] lowmem_reserve[]: 0 0 0 0 0 
[ 5252.882190] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 2*4096kB (M) = 11264kB 
[ 5252.896698] Node 0 DMA32: 1*4kB (M) 2*8kB (UM) 1*16kB (M) 4*32kB (UM) 2*64kB (M) 1*128kB (M) 1*256kB (M) 3*512kB (M) 1*1024kB (M) 3*2048kB (M) 465*4096kB (M) = 1914020kB 
[ 5252.915180] Node 0 Normal: 1328*4kB (ME) 2088*8kB (UME) 1242*16kB (UME) 764*32kB (UME) 824*64kB (UME) 921*128kB (UME) 641*256kB (UME) 637*512kB (UME) 386*1024kB (UME) 184*2048kB (UME) 14338*4096kB (UME) = 60227744kB 
[ 5252.938220] Node 1 Normal: 4517*4kB (UME) 2404*8kB (UME) 2118*16kB (UME) 1574*32kB (UME) 1740*64kB (UME) 1027*128kB (UME) 699*256kB (UME) 344*512kB (UME) 116*1024kB (UME) 12*2048kB (UM) 15711*4096kB (M) = 65215060kB 
[ 5252.961349] 232083 total pagecache pages 
[ 5252.966622] 0 pages in swap cache 
[ 5252.971225] Swap cache stats: add 0, delete 0, find 0/0 
[ 5252.977971] Free swap  = 4194300kB 
[ 5252.982684] Total swap = 4194300kB 
[ 5252.987397] 33530478 pages RAM 
[ 5252.991724] 0 pages HighMem/MovableOnly 
[ 5252.996910] 551949 pages reserved 
[ 5253.001501] 0 pages hwpoisoned 
[ 5260.137103] sysrq: Show State 
[ 5260.152632] Sched Debug Version: v0.11, 5.9.0-rc1 #1 
[ 5260.159070] ktime                                   : 5260097.881278 
[ 5260.167062] sched_clk                               : 5260207.491223 
[ 5260.175044] cpu_clk                                 : 5260152.631652 
[ 5260.183020] jiffies                                 : 4299927331 
[ 5260.190603] sched_clock_stable()                    : 1 
[ 5260.197307] sysctl_sched 
[ 5260.200994]   .sysctl_sched_latency                    : 24.000000 
[ 5260.208746]   .sysctl_sched_min_granularity            : 10.000000 
[ 5260.216478]   .sysctl_sched_wakeup_granularity         : 15.000000 
[ 5260.224190]   .sysctl_sched_child_runs_first           : 0 
[ 5260.231105]   .sysctl_sched_features                   : 4156219 
[ 5260.238586]   .sysctl_sched_tunable_scaling            : 1 (logarithmic) 
[ 5260.246828] cpu#0, 2597.006 MHz 
[ 5260.251070]   .nr_running                    : 0 
[ 5260.256945]   .nr_switches                   : 20296569 
[ 5260.263480]   .nr_uninterruptible            : -226 
[ 5260.269622]   .next_balance                  : 4299.927413 
[ 5260.276425]   .curr->pid                     : 0 
[ 5260.282240]   .clock                         : 5260282.011818 
[ 5260.289295]   .clock_task                    : 5183498.488782 
[ 5260.296344]   .avg_idle                      : 1000000 
[ 5260.302695]   .max_idle_balance_cost         : 500000 
[ 5260.308923] cfs_rq[0]:/ 
[ 5260.312221]   .exec_clock                    : 0.000000 
[ 5260.318615]   .MIN_vruntime                  : 0.000001 
[ 5260.324991]   .min_vruntime                  : 7105366.124637 
[ 5260.331929]   .max_vruntime                  : 0.000001 
[ 5260.338264]   .spread                        : 0.000000 
[ 5260.344586]   .spread0                       : 0.000000 
[ 5260.350887]   .nr_spread_over                : 0 
[ 5260.356488]   .nr_running                    : 0 
[ 5260.362066]   .load                          : 0 
[ 5260.367625]   .load_avg                      : 0 
[ 5260.373159]   .runnable_avg                  : 0 
[ 5260.378673]   .util_avg                      : 0 
[ 5260.384167]   .util_est_enqueued             : 0 
[ 5260.389639]   .removed.load_avg              : 0 
[ 5260.395099]   .removed.util_avg              : 0 
[ 5260.400552]   .removed.runnable_avg          : 0 
[ 5260.405998]   .tg_load_avg_contrib           : 0 
[ 5260.411441]   .tg_load_avg                   : 0 
[ 5260.416885]   .throttled                     : 0 
[ 5260.422326]   .throttle_count                : 0 
[ 5260.427759] rt_rq[0]:/ 
[ 5260.430668]   .rt_nr_running                 : 0 
[ 5260.436103]   .rt_nr_migratory               : 0 
[ 5260.441534]   .rt_throttled                  : 0 
[ 5260.446959]   .rt_time                       : 0.000000 
[ 5260.453058]   .rt_runtime                    : 950.000000 
[ 5260.459351] dl_rq[0]: 
[ 5260.462145]   .dl_nr_running                 : 0 
[ 5260.467564]   .dl_nr_migratory               : 0 
[ 5260.472977]   .dl_bw->bw                     : 996147 
[ 5260.478877]   .dl_bw->total_bw               : 0 
[ 5260.484284] runnable tasks: 
[ 5260.487652]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5260.500166] ------------------------------------------------------------------------------------------------------------- 
[ 5260.512694]  I          rcu_gp     3         7.951420         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5260.526029]  I      rcu_par_gp     4         9.951419         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5260.539388]  I    kworker/0:0H     6     46989.408914        14   100         0.000000         0.053378         0.000000 0 0 / 
[ 5260.552790]  I    mm_percpu_wq    10        17.519071         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5260.566226]  S     ksoftirqd/0    11   7105354.125409    228105   120         0.000000       156.994733         0.000000 0 0 / 
[ 5260.579708]  S     migration/0    13        23.519068      1433     0         0.000000       241.049955         0.000000 0 0 / 
[ 5260.593233]  S         cpuhp/0    14     25197.481879        21   120         0.000000         2.364238         0.000000 0 0 / 
[ 5260.606800]  I       writeback   261      2144.429702         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5260.620404]  S      khugepaged   265   7105356.865201      1032   139         0.000000        53.862678         0.000000 0 0 / 
[ 5260.634058]  I     kworker/0:3   587   7105357.960001     72034   120         0.000000      2179.962279         0.000000 0 0 / 
[ 5260.647775]  I   iscsi_destroy  1317     25242.391998         2   100         0.000000         0.008170         0.000000 0 0 / 
[ 5260.661540]  I        ipoib_wq  1361     25266.412386         2   100         0.000000         0.007185         0.000000 0 0 / 
[ 5260.675357]  S         rpcbind  1637         0.097666       186   120         0.000000        17.329473         0.000000 0 0 /autogroup-55 
[ 5260.690387]  S           gmain  1695        10.982284         1   120         0.000000         0.030869         0.000000 0 0 /autogroup-60 
[ 5260.705463]  S            rngd  1747      4496.748674        43   120         0.000000      4497.811856         0.000000 0 1747 /autogroup-67 
[ 5260.720878]  I           mlx5e  2998     46781.635849         2   100         0.000000         0.010496         0.000000 0 0 / 
[ 5260.734882]  I    kworker/0:1H  3202   7105354.124910   3227117   100         0.000000     14516.748990         0.000000 0 0 / 
[ 5260.748948]  I  kworker/u80:10 39113   7105358.682819   1642258   120         0.000000      5621.182976         0.000000 0 0 / 
[ 5260.763071]  I     kworker/0:0 40025   7104180.314027         2   120         0.000000         0.004800         0.000000 0 0 / 
[ 5260.777247]  I  kworker/u80:11 41824   7105304.250144    575658   120         0.000000      2010.917588         0.000000 0 0 / 
[ 5260.791478]  D         main.sh 42365       541.827765         1   120         0.000000         0.448746         0.000000 0 0 /autogroup-159 
[ 5260.807028] cpu#1, 2597.006 MHz 
[ 5260.811318]   .nr_running                    : 0 
[ 5260.817260]   .nr_switches                   : 25391074 
[ 5260.823882]   .nr_uninterruptible            : -8544 
[ 5260.830204]   .next_balance                  : 4299.927574 
[ 5260.837093]   .curr->pid                     : 0 
[ 5260.842991]   .clock                         : 5260664.019398 
[ 5260.850146]   .clock_task                    : 5255706.211923 
[ 5260.857294]   .avg_idle                      : 1000000 
[ 5260.863751]   .max_idle_balance_cost         : 500000 
[ 5260.870100] rt_rq[1]:/ 
[ 5260.873423]   .rt_nr_running                 : 0 
[ 5260.879263]   .rt_nr_migratory               : 0 
[ 5260.885089]   .rt_throttled                  : 0 
[ 5260.890900]   .rt_time                       : 0.000000 
[ 5260.897378]   .rt_runtime                    : 950.000000 
[ 5260.904037] dl_rq[1]: 
[ 5260.907190]   .dl_nr_running                 : 0 
[ 5260.912958]   .dl_nr_migratory               : 0 
[ 5260.918711]   .dl_bw->bw                     : 996147 
[ 5260.924940]   .dl_bw->total_bw               : 0 
[ 5260.930673] runnable tasks: 
[ 5260.934352]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5260.947164] ------------------------------------------------------------------------------------------------------------- 
[ 5260.959980]  S         cpuhp/1    15     23246.902604        23   120         0.000000         1.271565         0.000000 1 0 / 
[ 5260.973856]  S     migration/1    16         0.000000      1419     0         0.000000       423.028148         0.000000 1 0 / 
[ 5260.987729]  S     ksoftirqd/1    17   6292750.693740      7538   120         0.000000        41.737667         0.000000 1 0 / 
[ 5261.001607]  I    kworker/1:0H    19     20424.691103        10   100         0.000000         0.018369         0.000000 1 0 / 
[ 5261.015495]  I   kworker/u85:0   433     46622.708184        11   100         0.000000         0.025386         0.000000 1 0 / 
[ 5261.029391]  I     kworker/1:2  1066   6294409.755054      3030   120         0.000000        10.759046         0.000000 1 0 / 
[ 5261.043289]  I    kworker/1:1H  1180   6294409.750517   3469645   100         0.000000     13999.096425         0.000000 1 0 / 
[ 5261.057196]  I      mkey_cache  1307     23299.751394         2   100         0.000000         0.007704         0.000000 1 0 / 
[ 5261.071097]  S            rngd  1748      4497.333631         9   120         0.000000      4498.388854         0.000000 1 0 /autogroup-67 
[ 5261.086152]  S          agetty  3161        -1.004318        16   120         0.000000        11.662340         0.000000 1 0 /autogroup-93 
[ 5261.101197]  I         nvme-wq 26994     51942.907066         2   100         0.000000         0.006701         0.000000 1 0 / 
[ 5261.115064]  I     kworker/1:0 29565    177894.003253         2   120         0.000000         0.005475         0.000000 1 0 / 
[ 5261.128955] cpu#2, 2597.006 MHz 
[ 5261.133042]   .nr_running                    : 0 
[ 5261.138776]   .nr_switches                   : 21080743 
[ 5261.145196]   .nr_uninterruptible            : 2667 
[ 5261.151225]   .next_balance                  : 4299.928004 
[ 5261.157937]   .curr->pid                     : 0 
[ 5261.163678]   .clock                         : 5261162.023018 
[ 5261.170682]   .clock_task                    : 5195286.429686 
[ 5261.177684]   .avg_idle                      : 1000000 
[ 5261.184008]   .max_idle_balance_cost         : 500000 
[ 5261.190234] rt_rq[2]:/ 
[ 5261.193446]   .rt_nr_running                 : 0 
[ 5261.199185]   .rt_nr_migratory               : 0 
[ 5261.204924]   .rt_throttled                  : 0 
[ 5261.210661]   .rt_time                       : 0.000000 
[ 5261.217077]   .rt_runtime                    : 950.000000 
[ 5261.223687] dl_rq[2]: 
[ 5261.226799]   .dl_nr_running                 : 0 
[ 5261.232535]   .dl_nr_migratory               : 0 
[ 5261.238272]   .dl_bw->bw                     : 996147 
[ 5261.244493]   .dl_bw->total_bw               : 0 
[ 5261.250227] runnable tasks: 
[ 5261.253911]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5261.266721] ------------------------------------------------------------------------------------------------------------- 
[ 5261.279532]  S         cpuhp/2    21     32200.383962        21   120         0.000000         0.263233         0.000000 0 0 / 
[ 5261.293401]  S     migration/2    22       109.795636      1435     0         0.000000       424.468119         0.000000 0 0 / 
[ 5261.307272]  S     ksoftirqd/2    23   6769689.016195    104509   120         0.000000        83.015607         0.000000 0 0 / 
[ 5261.321135]  I    kworker/2:0H    25     53640.182548        15   100         0.000000         0.039386         0.000000 0 0 / 
[ 5261.335012]  I  blkcg_punt_bio   324        42.046122         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5261.348886]  I         xprtiod  1556     32406.651748         2   100         0.000000         0.007031         0.000000 0 0 / 
[ 5261.362746]  S     dbus-daemon  1737        10.960246         1   120         0.000000         0.008831         0.000000 0 0 /autogroup-63 
[ 5261.377764]  S            rngd  1749      4487.542950         9   120         0.000000      4488.596578         0.000000 0 0 /autogroup-67 
[ 5261.392779]  I        ipoib_wq  2416     52499.515793         2   100         0.000000         0.007847         0.000000 0 0 / 
[ 5261.406628]  I           mlx5e  2664     52983.580259         2   100         0.000000         0.008291         0.000000 0 0 / 
[ 5261.420475]  I           mlx5e  2748     53027.584472         2   100         0.000000         0.011512         0.000000 0 0 / 
[ 5261.434319]  I    kworker/2:1H  3203   6769689.016268   3179734   100         0.000000     13890.766574         0.000000 0 0 / 
[ 5261.448179]  I     kworker/2:2  3614   6769689.028462    209178   120         0.000000       389.391365         0.000000 0 0 / 
[ 5261.462089]  I     kworker/2:0 31188   6760007.563914         3   120         0.000000         0.004273         0.000000 0 0 / 
[ 5261.476057] cpu#3, 2597.006 MHz 
[ 5261.480173]   .nr_running                    : 0 
[ 5261.485953]   .nr_switches                   : 26624647 
[ 5261.492413]   .nr_uninterruptible            : -2726 
[ 5261.498580]   .next_balance                  : 4299.927574 
[ 5261.505333]   .curr->pid                     : 0 
[ 5261.511111]   .clock                         : 5260422.017389 
[ 5261.518153]   .clock_task                    : 5257071.881209 
[ 5261.525197]   .avg_idle                      : 1000000 
[ 5261.531563]   .max_idle_balance_cost         : 500000 
[ 5261.537835] rt_rq[3]:/ 
[ 5261.541083]   .rt_nr_running                 : 0 
[ 5261.546863]   .rt_nr_migratory               : 0 
[ 5261.552640]   .rt_throttled                  : 0 
[ 5261.558418]   .rt_time                       : 0.000000 
[ 5261.564878]   .rt_runtime                    : 950.000000 
[ 5261.571531] dl_rq[3]: 
[ 5261.574688]   .dl_nr_running                 : 0 
[ 5261.580455]   .dl_nr_migratory               : 0 
[ 5261.586205]   .dl_bw->bw                     : 996147 
[ 5261.592422]   .dl_bw->total_bw               : 0 
[ 5261.598143] runnable tasks: 
[ 5261.601811]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5261.614612] ------------------------------------------------------------------------------------------------------------- 
[ 5261.627419]  S         cpuhp/3    26     24700.720455        21   120         0.000000         0.297604         0.000000 1 0 / 
[ 5261.641275]  S     migration/3    27       137.795649      1402     0         0.000000       425.496288         0.000000 1 0 / 
[ 5261.655132]  S     ksoftirqd/3    28   6353424.433000      1071   120         0.000000         5.137376         0.000000 1 0 / 
[ 5261.668994]  I    kworker/3:0H    30     46449.267185        15   100         0.000000         0.028569         0.000000 1 0 / 
[ 5261.682862]  S         kswapd1   372        72.005579         4   120         0.000000         0.012923         0.000000 1 0 / 
[ 5261.696727]  I    xfs-cil/dm-0   920     20118.544932         2   100         0.000000         0.005790         0.000000 1 0 / 
[ 5261.710593]  S            rngd  1750      4495.720774         9   120         0.000000      4496.774606         0.000000 1 0 /autogroup-67 
[ 5261.725626]  I    kworker/3:1H  3204   6354427.686565   3652850   100         0.000000     13664.409755         0.000000 1 0 / 
[ 5261.739505]  I     kworker/3:3 29568   6354435.968314      1466   120         0.000000         5.146438         0.000000 1 0 / 
[ 5261.753391]  I     kworker/3:0 35612   6342225.608841         2   120         0.000000         0.004850         0.000000 1 0 / 
[ 5261.767281] cpu#4, 2597.006 MHz 
[ 5261.771341]   .nr_running                    : 0 
[ 5261.777052]   .nr_switches                   : 21257147 
[ 5261.783430]   .nr_uninterruptible            : 2316 
[ 5261.789418]   .next_balance                  : 4299.928008 
[ 5261.796088]   .curr->pid                     : 0 
[ 5261.801787]   .clock                         : 5260852.106121 
[ 5261.808749]   .clock_task                    : 5199137.057317 
[ 5261.815710]   .avg_idle                      : 1000000 
[ 5261.821983]   .max_idle_balance_cost         : 500000 
[ 5261.828167] rt_rq[4]:/ 
[ 5261.831339]   .rt_nr_running                 : 0 
[ 5261.837023]   .rt_nr_migratory               : 0 
[ 5261.842714]   .rt_throttled                  : 0 
[ 5261.848401]   .rt_time                       : 0.000000 
[ 5261.854769]   .rt_runtime                    : 950.000000 
[ 5261.861333] dl_rq[4]: 
[ 5261.864402]   .dl_nr_running                 : 0 
[ 5261.870095]   .dl_nr_migratory               : 0 
[ 5261.875787]   .dl_bw->bw                     : 996147 
[ 5261.881956]   .dl_bw->total_bw               : 0 
[ 5261.887644] runnable tasks: 
[ 5261.891294]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5261.904088] ------------------------------------------------------------------------------------------------------------- 
[ 5261.916902]  S         cpuhp/4    31      6958.670877        21   120         0.000000         0.337893         0.000000 0 0 / 
[ 5261.930798]  S     migration/4    32       168.795643      1443     0         0.000000       427.797986         0.000000 0 0 / 
[ 5261.944666]  S     ksoftirqd/4    33   6602109.670942     89135   120         0.000000        84.438140         0.000000 0 0 / 
[ 5261.958541]  I    kworker/4:0H    35      2935.341541        10   100         0.000000         0.016878         0.000000 0 0 / 
[ 5261.972419]  I     kworker/4:2   258   6264094.499953    192641   120         0.000000       720.646542         0.000000 0 0 / 
[ 5261.986297]  S      khungtaskd   259   6602054.134712        44   120         0.000000         2.998738         0.000000 0 0 / 
[ 5262.000180]  S      oom_reaper   260        80.454548         2   120         0.000000         0.000000         0.000000 0 0 / 
[ 5262.014068]  S         kswapd0   371       177.528815         3   120         0.000000         0.013388         0.000000 0 0 / 
[ 5262.027949]  S   irq/25-aerdrv   375         0.000000         3    49         0.000000         0.012139         0.000000 0 0 / 
[ 5262.041830]  I   kworker/u80:2   713   6602054.057385   2942839   120         0.000000     10427.698361         0.000000 0 0 / 
[ 5262.055708]  I mlx5_cmd_0000:0   759      2544.511223         2   100         0.000000         0.007061         0.000000 0 0 / 
[ 5262.069586]  I    kworker/4:1H  1008   6602109.671022   3324380   100         0.000000     14733.898422         0.000000 0 0 / 
[ 5262.083481]  S       JS Helper  1767        10.999896         4   120         0.000000         0.048479         0.000000 0 0 /autogroup-64 
[ 5262.098582]  S        gssproxy  1803        10.961025         1   120         0.000000         0.009610         0.000000 0 0 /autogroup-79 
[ 5262.113720]  I        ipoib_wq  1854      7692.997305         2   100         0.000000         0.007114         0.000000 0 0 / 
[ 5262.127719]  I        ipoib_wq  1860      7705.003620         2   100         0.000000         0.007531         0.000000 0 0 / 
[ 5262.141767]  I        ipoib_wq  2333      8176.200848         2   100         0.000000         0.008130         0.000000 0 0 / 
[ 5262.155851]  I        ipoib_wq  2665      8925.312144         2   100         0.000000         0.007238         0.000000 0 0 / 
[ 5262.169979]  I mlx5_ib_page_fa  3271      9858.281336         2   100         0.000000         0.007818         0.000000 0 0 / 
[ 5262.184155]  I         ib_mad1  3272      9870.287447         2   100         0.000000         0.006795         0.000000 0 0 / 
[ 5262.198377]  I     kworker/4:1 29575   6602121.670942     91619   120         0.000000       203.260945         0.000000 0 0 / 
[ 5262.212648]  S          opensm 38054        59.522638        38   120         0.000000         0.526434         0.000000 0 0 /autogroup-160 
[ 5262.228228]  S          opensm 38070        59.519403        39   120         0.000000         0.523720         0.000000 0 0 /autogroup-160 
[ 5262.243836]  S          opensm 38076        59.522440        39   120         0.000000         0.426349         0.000000 0 0 /autogroup-160 
[ 5262.259420]  S          opensm 38083        59.521236        39   120         0.000000         0.520229         0.000000 0 0 /autogroup-160 
[ 5262.274994]  S          opensm 38091        71.506039        37   120         0.000000         0.535195         0.000000 0 0 /autogroup-160 
[ 5262.290574] cpu#5, 2597.006 MHz 
[ 5262.294855]   .nr_running                    : 0 
[ 5262.300780]   .nr_switches                   : 24410356 
[ 5262.307373]   .nr_uninterruptible            : -2876 
[ 5262.313665]   .next_balance                  : 4299.928128 
[ 5262.320527]   .curr->pid                     : 0 
[ 5262.326407]   .clock                         : 5261907.028194 
[ 5262.333539]   .clock_task                    : 5258584.201690 
[ 5262.340660]   .avg_idle                      : 1000000 
[ 5262.347091]   .max_idle_balance_cost         : 500000 
[ 5262.353415] cfs_rq[5]:/ 
[ 5262.356805]   .exec_clock                    : 0.000000 
[ 5262.363295]   .MIN_vruntime                  : 0.000001 
[ 5262.369780]   .min_vruntime                  : 6454529.360023 
[ 5262.376836]   .max_vruntime                  : 0.000001 
[ 5262.383292]   .spread                        : 0.000000 
[ 5262.389739]   .spread0                       : -650836.764614 
[ 5262.396755]   .nr_spread_over                : 0 
[ 5262.402495]   .nr_running                    : 0 
[ 5262.408221]   .load                          : 0 
[ 5262.413933]   .load_avg                      : 0 
[ 5262.419633]   .runnable_avg                  : 0 
[ 5262.425323]   .util_avg                      : 0 
[ 5262.431001]   .util_est_enqueued             : 0 
[ 5262.436665]   .removed.load_avg              : 0 
[ 5262.442319]   .removed.util_avg              : 0 
[ 5262.447958]   .removed.runnable_avg          : 0 
[ 5262.453587]   .tg_load_avg_contrib           : 0 
[ 5262.459206]   .tg_load_avg                   : 0 
[ 5262.464811]   .throttled                     : 0 
[ 5262.470402]   .throttle_count                : 0 
[ 5262.475983] rt_rq[5]:/ 
[ 5262.479024]   .rt_nr_running                 : 0 
[ 5262.484580]   .rt_nr_migratory               : 0 
[ 5262.490124]   .rt_throttled                  : 0 
[ 5262.495657]   .rt_time                       : 0.000000 
[ 5262.501856]   .rt_runtime                    : 950.000000 
[ 5262.508235] dl_rq[5]: 
[ 5262.511107]   .dl_nr_running                 : 0 
[ 5262.516594]   .dl_nr_migratory               : 0 
[ 5262.522068]   .dl_bw->bw                     : 996147 
[ 5262.528017]   .dl_bw->total_bw               : 0 
[ 5262.533470] runnable tasks: 
[ 5262.536873]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5262.549411] ------------------------------------------------------------------------------------------------------------- 
[ 5262.561957]  S         cpuhp/5    36      5107.221719        21   120         0.000000         0.280252         0.000000 1 0 / 
[ 5262.575297]  S     migration/5    37       210.795651      1396     0         0.000000       427.442909         0.000000 1 0 / 
[ 5262.588668]  S     ksoftirqd/5    38   6453304.729126       902   120         0.000000        27.774014         0.000000 1 0 / 
[ 5262.602086]  I    kworker/5:0H    40      7501.135091        15   100         0.000000         0.032378         0.000000 1 0 / 
[ 5262.615549]  I         mlx5_fc   715       737.999033         2   100         0.000000         0.005550         0.000000 1 0 / 
[ 5262.629045]  I    mlx5_hv_vhca   738       750.003386         2   100         0.000000         0.005323         0.000000 1 0 / 
[ 5262.642582]  I     mlx5_esw_wq   752       762.015445         2   100         0.000000         0.004978         0.000000 1 0 / 
[ 5262.656154]  I           mlx5e   766       786.024687         2   100         0.000000         0.006441         0.000000 1 0 / 
[ 5262.669771]  I         ib_mad1  1314      5134.417537         2   100         0.000000         0.007399         0.000000 1 0 / 
[ 5262.683428]  I   kworker/u80:7  1351   6454529.360023   2168661   120         0.000000      7623.381910         0.000000 1 0 / 
[ 5262.697136]  I           mlx5e  1356      5168.779322         2   100         0.000000         0.006036         0.000000 1 0 / 
[ 5262.710893]  I           mlx5e  1853      5391.505635         2   100         0.000000         0.008153         0.000000 1 0 / 
[ 5262.724700]  I           mlx5e  2498      6241.251448         2   100         0.000000         0.008350         0.000000 1 0 / 
[ 5262.738552]  I    kworker/5:1H  3205   6454482.205450   3577645   100         0.000000     13639.618280         0.000000 1 0 / 
[ 5262.752462]  I     kworker/5:0 35735   6447205.947755        36   120         0.000000         0.428595         0.000000 1 0 / 
[ 5262.766425]  I     kworker/5:1 36504   6454517.041368      1455   120         0.000000         3.478829         0.000000 1 0 / 
[ 5262.780455] cpu#6, 2597.006 MHz 
[ 5262.784617]   .nr_running                    : 0 
[ 5262.790433]   .nr_switches                   : 18167113 
[ 5262.796929]   .nr_uninterruptible            : 1735 
[ 5262.803038]   .next_balance                  : 4299.929954 
[ 5262.809831]   .curr->pid                     : 1032 
[ 5262.815947]   .clock                         : 5262815.946060 
[ 5262.823037]   .clock_task                    : 5193999.329734 
[ 5262.830125]   .avg_idle                      : 1000000 
[ 5262.836533]   .max_idle_balance_cost         : 500000 
[ 5262.842849] cfs_rq[6]:/autogroup-29 
[ 5262.847411]   .exec_clock                    : 0.000000 
[ 5262.853921]   .MIN_vruntime                  : 0.000001 
[ 5262.860421]   .min_vruntime                  : 182.650202 
[ 5262.867109]   .max_vruntime                  : 0.000001 
[ 5262.873586]   .spread                        : 0.000000 
[ 5262.880043]   .spread0                       : -7105183.474435 
[ 5262.887172]   .nr_spread_over                : 0 
[ 5262.892920]   .nr_running                    : 0 
[ 5262.898663]   .load                          : 0 
[ 5262.904393]   .load_avg                      : 3 
[ 5262.910108]   .runnable_avg                  : 2 
[ 5262.915812]   .util_avg                      : 2 
[ 5262.921504]   .util_est_enqueued             : 0 
[ 5262.927183]   .removed.load_avg              : 0 
[ 5262.932851]   .removed.util_avg              : 0 
[ 5262.938507]   .removed.runnable_avg          : 0 
[ 5262.944150]   .tg_load_avg_contrib           : 1 
[ 5262.949783]   .tg_load_avg                   : 1 
[ 5262.955402]   .throttled                     : 0 
[ 5262.961009]   .throttle_count                : 0 
[ 5262.966606]   .se->exec_start                : 5194019.058077 
[ 5262.973449]   .se->vruntime                  : 6305928.145101 
[ 5262.980291]   .se->sum_exec_runtime          : 183.698778 
[ 5262.986734]   .se->load.weight               : 1048576 
[ 5262.992863]   .se->avg.load_avg              : 0 
[ 5262.998409]   .se->avg.util_avg              : 0 
[ 5263.003940]   .se->avg.runnable_avg          : 0 
[ 5263.009462] cfs_rq[6]:/ 
[ 5263.012546]   .exec_clock                    : 0.000000 
[ 5263.018730]   .MIN_vruntime                  : 0.000001 
[ 5263.024904]   .min_vruntime                  : 6305928.145101 
[ 5263.031648]   .max_vruntime                  : 0.000001 
[ 5263.037794]   .spread                        : 0.000000 
[ 5263.043925]   .spread0                       : -799437.979536 
[ 5263.050628]   .nr_spread_over                : 0 
[ 5263.056056]   .nr_running                    : 0 
[ 5263.061471]   .load                          : 0 
[ 5263.066872]   .load_avg                      : 0 
[ 5263.072280]   .runnable_avg                  : 0 
[ 5263.077687]   .util_avg                      : 0 
[ 5263.083090]   .util_est_enqueued             : 0 
[ 5263.088491]   .removed.load_avg              : 0 
[ 5263.093888]   .removed.util_avg              : 0 
[ 5263.099283]   .removed.runnable_avg          : 0 
[ 5263.104678]   .tg_load_avg_contrib           : 0 
[ 5263.110069]   .tg_load_avg                   : 0 
[ 5263.115458]   .throttled                     : 0 
[ 5263.120844]   .throttle_count                : 0 
[ 5263.126225] rt_rq[6]:/ 
[ 5263.129081]   .rt_nr_running                 : 0 
[ 5263.134463]   .rt_nr_migratory               : 0 
[ 5263.139845]   .rt_throttled                  : 0 
[ 5263.145227]   .rt_time                       : 0.000000 
[ 5263.151287]   .rt_runtime                    : 950.000000 
[ 5263.157540] dl_rq[6]: 
[ 5263.160297]   .dl_nr_running                 : 0 
[ 5263.165681]   .dl_nr_migratory               : 0 
[ 5263.171064]   .dl_bw->bw                     : 996147 
[ 5263.176934]   .dl_bw->total_bw               : 0 
[ 5263.182318] runnable tasks: 
[ 5263.185664]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5263.198155] ------------------------------------------------------------------------------------------------------------- 
[ 5263.210667]  S         cpuhp/6    41      4740.258615        21   120         0.000000         0.324923         0.000000 0 0 / 
[ 5263.223976]  S     migration/6    42       252.795637      1531     0         0.000000       429.706586         0.000000 0 0 / 
[ 5263.237333]  S     ksoftirqd/6    43   6305916.106620    131118   120         0.000000       413.730728         0.000000 0 0 / 
[ 5263.250746]  I    kworker/6:0H    45        46.015907         8   100         0.000000         0.026160         0.000000 0 0 / 
[ 5263.264201]  I     kintegrityd   322        60.022697         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5263.277680]  S   irq/26-aerdrv   376         0.000000         3    49         0.000000         0.008304         0.000000 0 0 / 
[ 5263.291216]  I      scsi_tmf_1   668        48.044765         2   100         0.000000         0.006530         0.000000 0 0 / 
[ 5263.304789]  S       scsi_eh_2   669        48.105500        27   120         0.000000         0.063697         0.000000 0 0 / 
[ 5263.318404]  I      scsi_tmf_3   672        48.048427         2   100         0.000000         0.005351         0.000000 0 0 / 
[ 5263.332064]  S       scsi_eh_4   677        46.075272        25   120         0.000000         0.079373         0.000000 0 0 / 
[ 5263.345764]  I      scsi_tmf_4   678        48.050636         2   100         0.000000         0.005788         0.000000 0 0 / 
[ 5263.359508]  S       scsi_eh_5   679        48.100964        25   120         0.000000         0.053247         0.000000 0 0 / 
[ 5263.373302]  I      scsi_tmf_5   680        48.055024         2   100         0.000000         0.005408         0.000000 0 0 / 
[ 5263.387145]  S       scsi_eh_6   681        48.104145        25   120         0.000000         0.051974         0.000000 0 0 / 
[ 5263.401034]  I      scsi_tmf_6   682        48.059207         2   100         0.000000         0.005011         0.000000 0 0 / 
[ 5263.414969]  S       scsi_eh_7   683        48.107169        25   120         0.000000         0.050863         0.000000 0 0 / 
[ 5263.428949]  I      scsi_tmf_7   684        48.062748         2   100         0.000000         0.005278         0.000000 0 0 / 
[ 5263.442977]  S       scsi_eh_8   685        48.114398        25   120         0.000000         0.054668         0.000000 0 0 / 
[ 5263.457049]  I      scsi_tmf_8   686        48.066063         2   100         0.000000         0.005107         0.000000 0 0 / 
[ 5263.471165]  S       scsi_eh_9   687        48.119682        25   120         0.000000         0.056415         0.000000 0 0 / 
[ 5263.485325]  I      scsi_tmf_9   688        48.069806         2   100         0.000000         0.006368         0.000000 0 0 / 
[ 5263.499527]  I    kworker/6:1H   709   6305744.446366   2524593   100         0.000000     11188.223091         0.000000 0 0 / 
[ 5263.513782]  I mlx5_health0000   717        58.018764         2   100         0.000000         0.007900         0.000000 0 0 / 
[ 5263.528076]  I mlx5_page_alloc   718        58.021108         2   100         0.000000         0.006298         0.000000 0 0 / 
[ 5263.542349]  I mlx5_health0000   747        58.025319         2   100         0.000000         0.008385         0.000000 0 0 / 
[ 5263.556620]  S systemd-journal  1032       182.665899      3214   120         0.000000       865.014933         0.000000 0 0 /autogroup-29 
[ 5263.572061]  I           mlx5e  1363      4774.038855         2   100         0.000000         0.005486         0.000000 0 0 / 
[ 5263.586330]  S       rhsmcertd  1760         0.574011         4   120         0.000000         0.639697         0.000000 0 0 /autogroup-76 
[ 5263.601752]  S        gssproxy  1804        10.958569         1   120         0.000000         0.007154         0.000000 0 0 /autogroup-79 
[ 5263.617181]  S        sssd_nss  1835        18.200941     11370   120         0.000000       320.293999         0.000000 0 0 /autogroup-66 
[ 5263.632613]  I           mlx5e  1859      5272.588174         2   100         0.000000         0.008441         0.000000 0 0 / 
[ 5263.646878]  I           mlx5e  2101      5450.798689         2   100         0.000000         0.006932         0.000000 0 0 / 
[ 5263.661142]  I        ipoib_wq  2582      6362.332433         2   100         0.000000         0.006184         0.000000 0 0 / 
[ 5263.675406]  I           mlx5e  2831      6768.520003         2   100         0.000000         0.008947         0.000000 0 0 / 
[ 5263.689669]  I           mlx5e  2915      6905.408343         2   100         0.000000         0.008106         0.000000 0 0 / 
[ 5263.703934]  S          opensm 38116        96.423961      1819   120         0.000000        17.531666         0.000000 0 0 /autogroup-160 
[ 5263.719459]  I     kworker/6:2 38327   6304781.473399     29586   120         0.000000        39.919859         0.000000 0 0 / 
[ 5263.733729]  I     kworker/6:0 40992   6305916.106620     25963   120         0.000000        35.726607         0.000000 0 0 / 
[ 5263.748018] cpu#7, 2597.006 MHz 
[ 5263.752293]   .nr_running                    : 0 
[ 5263.758213]   .nr_switches                   : 24137971 
[ 5263.764801]   .nr_uninterruptible            : -2593 
[ 5263.771087]   .next_balance                  : 4299.929064 
[ 5263.777949]   .curr->pid                     : 0 
[ 5263.783830]   .clock                         : 5263663.041399 
[ 5263.790965]   .clock_task                    : 5260327.054443 
[ 5263.798090]   .avg_idle                      : 1000000 
[ 5263.804525]   .max_idle_balance_cost         : 500000 
[ 5263.810856] rt_rq[7]:/ 
[ 5263.814160]   .rt_nr_running                 : 0 
[ 5263.819977]   .rt_nr_migratory               : 0 
[ 5263.825785]   .rt_throttled                  : 0 
[ 5263.831576]   .rt_time                       : 0.000000 
[ 5263.838032]   .rt_runtime                    : 950.000000 
[ 5263.844672] dl_rq[7]: 
[ 5263.847804]   .dl_nr_running                 : 0 
[ 5263.853548]   .dl_nr_migratory               : 0 
[ 5263.859270]   .dl_bw->bw                     : 996147 
[ 5263.865474]   .dl_bw->total_bw               : 0 
[ 5263.871182] runnable tasks: 
[ 5263.874835]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5263.887620] ------------------------------------------------------------------------------------------------------------- 
[ 5263.900415]  S         cpuhp/7    46      7954.937737        21   120         0.000000         0.567787         0.000000 1 0 / 
[ 5263.914252]  S     migration/7    47       294.795645      1389     0         0.000000       194.118126         0.000000 1 0 / 
[ 5263.928093]  S     ksoftirqd/7    48   6376830.070486       905   120         0.000000         9.686279         0.000000 1 0 / 
[ 5263.941939]  I    kworker/7:0H    50     18932.461571        15   100         0.000000         0.032762         0.000000 1 0 / 
[ 5263.955789]  S rcu_tasks_rude_   253        62.584873         2   120         0.000000         0.000000         0.000000 1 0 / 
[ 5263.969643]  I     kworker/7:1   284   6377183.405149      2762   120         0.000000         9.841001         0.000000 1 0 / 
[ 5263.983499]  I mlx5_cmd_0000:0   719      4133.701436         2   100         0.000000         0.005272         0.000000 1 0 / 
[ 5263.997369]  I mlx5_page_alloc   748      4145.705784         2   100         0.000000         0.005083         0.000000 1 0 / 
[ 5264.011246]  I mlx5_page_alloc   758      4157.710129         2   100         0.000000         0.005013         0.000000 1 0 / 
[ 5264.025128]  I      mlx5e_arfs   767      4169.715250         2   100         0.000000         0.005821         0.000000 1 0 / 
[ 5264.039010]  I   xfs-conv/dm-2  1342      8003.152438         2   100         0.000000         0.006384         0.000000 1 0 / 
[ 5264.052886]  S            rngd  1691      1510.133418        32   120         0.000000      1514.627849         0.000000 1 0 /autogroup-67 
[ 5264.067932]  I    kworker/7:1H  3206   6377176.753763   3515589   100         0.000000     13000.211986         0.000000 1 0 / 
[ 5264.081861]  I     kworker/7:2  3620     19005.652607         2   120         0.000000         0.005943         0.000000 1 0 / 
[ 5264.095837]  S          opensm 38118        10.962868         1   120         0.000000         0.011451         0.000000 1 0 /autogroup-160 
[ 5264.111119] cpu#8, 2597.006 MHz 
[ 5264.115271]   .nr_running                    : 0 
[ 5264.121075]   .nr_switches                   : 22015978 
[ 5264.127560]   .nr_uninterruptible            : 1896 
[ 5264.133654]   .next_balance                  : 4299.931283 
[ 5264.140430]   .curr->pid                     : 0 
[ 5264.146239]   .clock                         : 5264146.038914 
[ 5264.153311]   .clock_task                    : 5190431.575860 
[ 5264.160383]   .avg_idle                      : 875760 
[ 5264.166680]   .max_idle_balance_cost         : 500000 
[ 5264.172969] cfs_rq[8]:/autogroup-86 
[ 5264.177515]   .exec_clock                    : 0.000000 
[ 5264.184009]   .MIN_vruntime                  : 0.000001 
[ 5264.190503]   .min_vruntime                  : 176.126170 
[ 5264.197190]   .max_vruntime                  : 0.000001 
[ 5264.203680]   .spread                        : 0.000000 
[ 5264.210160]   .spread0                       : -7105189.998467 
[ 5264.217302]   .nr_spread_over                : 0 
[ 5264.223068]   .nr_running                    : 0 
[ 5264.228823]   .load                          : 0 
[ 5264.234562]   .load_avg                      : 5 
[ 5264.240288]   .runnable_avg                  : 4 
[ 5264.246002]   .util_avg                      : 4 
[ 5264.251703]   .util_est_enqueued             : 0 
[ 5264.257389]   .removed.load_avg              : 0 
[ 5264.263066]   .removed.util_avg              : 0 
[ 5264.268726]   .removed.runnable_avg          : 0 
[ 5264.274377]   .tg_load_avg_contrib           : 2 
[ 5264.280014]   .tg_load_avg                   : 2 
[ 5264.285637]   .throttled                     : 0 
[ 5264.291247]   .throttle_count                : 0 
[ 5264.296842]   .se->exec_start                : 5190393.502565 
[ 5264.303691]   .se->vruntime                  : 6495868.264793 
[ 5264.310530]   .se->sum_exec_runtime          : 177.174746 
[ 5264.316970]   .se->load.weight               : 776722 
[ 5264.323011]   .se->avg.load_avg              : 0 
[ 5264.328556]   .se->avg.util_avg              : 0 
[ 5264.334085]   .se->avg.runnable_avg          : 0 
[ 5264.339604] cfs_rq[8]:/ 
[ 5264.342673]   .exec_clock                    : 0.000000 
[ 5264.348852]   .MIN_vruntime                  : 0.000001 
[ 5264.355017]   .min_vruntime                  : 6495868.264793 
[ 5264.361752]   .max_vruntime                  : 0.000001 
[ 5264.367892]   .spread                        : 0.000000 
[ 5264.374018]   .spread0                       : -609497.859844 
[ 5264.380714]   .nr_spread_over                : 0 
[ 5264.386138]   .nr_running                    : 0 
[ 5264.391551]   .load                          : 0 
[ 5264.396962]   .load_avg                      : 0 
[ 5264.402369]   .runnable_avg                  : 0 
[ 5264.407774]   .util_avg                      : 0 
[ 5264.413178]   .util_est_enqueued             : 0 
[ 5264.418579]   .removed.load_avg              : 0 
[ 5264.423978]   .removed.util_avg              : 0 
[ 5264.429374]   .removed.runnable_avg          : 0 
[ 5264.434768]   .tg_load_avg_contrib           : 0 
[ 5264.440159]   .tg_load_avg                   : 0 
[ 5264.445548]   .throttled                     : 0 
[ 5264.450934]   .throttle_count                : 0 
[ 5264.456314] rt_rq[8]:/ 
[ 5264.459161]   .rt_nr_running                 : 0 
[ 5264.464544]   .rt_nr_migratory               : 0 
[ 5264.469924]   .rt_throttled                  : 0 
[ 5264.475305]   .rt_time                       : 0.000000 
[ 5264.481356]   .rt_runtime                    : 950.000000 
[ 5264.487607] dl_rq[8]: 
[ 5264.490363]   .dl_nr_running                 : 0 
[ 5264.495746]   .dl_nr_migratory               : 0 
[ 5264.501129]   .dl_bw->bw                     : 996147 
[ 5264.506999]   .dl_bw->total_bw               : 0 
[ 5264.512382] runnable tasks: 
[ 5264.515727]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5264.528218] ------------------------------------------------------------------------------------------------------------- 
[ 5264.540730]  S         cpuhp/8    51      4981.549108        21   120         0.000000         0.672059         0.000000 0 0 / 
[ 5264.554037]  S     migration/8    52       342.795628      1510     0         0.000000       432.278454         0.000000 0 0 / 
[ 5264.567394]  S     ksoftirqd/8    53   6495853.185419    161745   120         0.000000       432.671985         0.000000 0 0 / 
[ 5264.580804]  I    kworker/8:0H    55      5012.471356        13   100         0.000000         0.030120         0.000000 0 0 / 
[ 5264.594251]  S            ksmd   264        60.935125         2   125         0.000000         0.000000         0.000000 0 0 / 
[ 5264.607735]  I     kworker/8:1   267   6495853.185419    265802   120         0.000000       601.720787         0.000000 0 0 / 
[ 5264.621275]  S   irq/27-aerdrv   377         0.000000         3    49         0.000000         0.008020         0.000000 0 0 / 
[ 5264.634858]  I      scsi_tmf_2   670        88.137247         2   100         0.000000         0.006446         0.000000 0 0 / 
[ 5264.648484]  S       scsi_eh_3   671       105.739864        27   120         0.000000         0.067406         0.000000 0 0 / 
[ 5264.662153]  I mlx5_health0000   699       117.677208         2   100         0.000000         0.006105         0.000000 0 0 / 
[ 5264.675870]  I    kworker/8:1H  1354   6495640.963823   2551172   100         0.000000     11229.844470         0.000000 0 0 / 
[ 5264.689643]  S       JS Helper  1770        23.027813         4   120         0.000000         0.044146         0.000000 0 0 /autogroup-64 
[ 5264.704633]  S         sssd_be  1814        10.633776      1528   120         0.000000        88.707118         0.000000 0 0 /autogroup-66 
[ 5264.719665]  I           mlx5e  2245      5655.979146         2   100         0.000000         0.008177         0.000000 0 0 / 
[ 5264.733585]  I        ipoib_wq  2749      6524.429666         2   100         0.000000         0.007682         0.000000 0 0 / 
[ 5264.747550]  I        ipoib_wq  2916      6782.549545         2   100         0.000000         0.008277         0.000000 0 0 / 
[ 5264.761562]  S    in:imjournal  3164       176.378748      6306   120         0.000000       449.569228         0.000000 0 0 /autogroup-86 
[ 5264.776797]  I     kworker/8:2 30599   6493558.130694      8580   120         0.000000        21.771534         0.000000 0 0 / 
[ 5264.790919]  I   kworker/u84:1 41402   6495853.185559     30599   100         0.000000       134.280631         0.000000 0 0 / 
[ 5264.805108] cpu#9, 2597.006 MHz 
[ 5264.809349]   .nr_running                    : 0 
[ 5264.815243]   .nr_switches                   : 26903442 
[ 5264.821815]   .nr_uninterruptible            : -2208 
[ 5264.828100]   .next_balance                  : 4299.927574 
[ 5264.834969]   .curr->pid                     : 0 
[ 5264.840868]   .clock                         : 5264662.048874 
[ 5264.848031]   .clock_task                    : 5261277.122607 
[ 5264.855183]   .avg_idle                      : 1000000 
[ 5264.861628]   .max_idle_balance_cost         : 500000 
[ 5264.867970] rt_rq[9]:/ 
[ 5264.871276]   .rt_nr_running                 : 0 
[ 5264.877108]   .rt_nr_migratory               : 0 
[ 5264.882924]   .rt_throttled                  : 0 
[ 5264.888727]   .rt_time                       : 0.000000 
[ 5264.895196]   .rt_runtime                    : 950.000000 
[ 5264.901848] dl_rq[9]: 
[ 5264.904983]   .dl_nr_running                 : 0 
[ 5264.910740]   .dl_nr_migratory               : 0 
[ 5264.916488]   .dl_bw->bw                     : 996147 
[ 5264.922709]   .dl_bw->total_bw               : 0 
[ 5264.928428] runnable tasks: 
[ 5264.932097]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5264.944901] ------------------------------------------------------------------------------------------------------------- 
[ 5264.957713]  S         cpuhp/9    56      8634.986293        21   120         0.000000         0.428564         0.000000 1 0 / 
[ 5264.971585]  S     migration/9    57       398.795632      1392     0         0.000000       202.597393         0.000000 1 0 / 
[ 5264.985458]  S     ksoftirqd/9    58   6392212.695030       545   120         0.000000        15.208334         0.000000 1 0 / 
[ 5264.999329]  I    kworker/9:0H    60      4746.526894        10   100         0.000000         0.040499         0.000000 1 0 / 
[ 5265.013188]  I     kworker/9:1   336     17120.313412       859   120         0.000000         3.349233         0.000000 1 0 / 
[ 5265.027061]  I    kworker/9:1H  1166   6392634.608451   3615828   100         0.000000     13352.852990         0.000000 1 0 / 
[ 5265.040945]  I           mlx5e  2332     10178.638587         2   100         0.000000         0.008946         0.000000 1 0 / 
[ 5265.054834]  I     kworker/9:3 21203   6392634.651246      2356   120         0.000000         6.264051         0.000000 1 0 / 
[ 5265.068739] cpu#10, 2597.006 MHz 
[ 5265.072916]   .nr_running                    : 0 
[ 5265.078636]   .nr_switches                   : 30709438 
[ 5265.085024]   .nr_uninterruptible            : 1645 
[ 5265.091012]   .next_balance                  : 4299.931652 
[ 5265.097668]   .curr->pid                     : 0 
[ 5265.103342]   .clock                         : 5264500.049438 
[ 5265.110265]   .clock_task                    : 5204524.277213 
[ 5265.117187]   .avg_idle                      : 1000000 
[ 5265.123429]   .max_idle_balance_cost         : 500000 
[ 5265.129577] rt_rq[10]:/ 
[ 5265.132805]   .rt_nr_running                 : 0 
[ 5265.138457]   .rt_nr_migratory               : 0 
[ 5265.144108]   .rt_throttled                  : 0 
[ 5265.149757]   .rt_time                       : 0.000000 
[ 5265.156086]   .rt_runtime                    : 950.000000 
[ 5265.162607] dl_rq[10]: 
[ 5265.165718]   .dl_nr_running                 : 0 
[ 5265.171363]   .dl_nr_migratory               : 0 
[ 5265.177006]   .dl_bw->bw                     : 996147 
[ 5265.183138]   .dl_bw->total_bw               : 0 
[ 5265.188782] runnable tasks: 
[ 5265.192386]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5265.205136] ------------------------------------------------------------------------------------------------------------- 
[ 5265.217904]  S        cpuhp/10    61      4333.340857        21   120         0.000000         0.208360         0.000000 0 0 / 
[ 5265.231713]  S    migration/10    62         0.000000      1493     0         0.000000       433.995708         0.000000 0 0 / 
[ 5265.245577]  S    ksoftirqd/10    63   6448088.324013    503340   120         0.000000        82.847438         0.000000 0 0 / 
[ 5265.259479]  I   kworker/10:0H    65      6756.224526        15   100         0.000000         0.037259         0.000000 0 0 / 
[ 5265.273365]  S       kdevtmpfs   251   6444667.433775       277   120         0.000000         3.845666         0.000000 0 0 / 
[ 5265.287246]  S   irq/28-pciehp   378         0.000000         3    49         0.000000         0.007407         0.000000 0 0 / 
[ 5265.301127]  S    xfsaild/sda1  1381      7045.172940         8   120         0.000000         0.054629         0.000000 0 0 / 
[ 5265.315002]  S       JS Helper  1763         0.766443         4   120         0.000000         0.088291         0.000000 0 0 /autogroup-64 
[ 5265.330039]  I        ipoib_wq  2102      4755.876665         2   100         0.000000         0.006264         0.000000 0 0 / 
[ 5265.343904]  I        ipoib_wq  2246      4913.781782         2   100         0.000000         0.006687         0.000000 0 0 / 
[ 5265.357760]  I  kworker/u80:14  3142   6448242.831749   2908161   120         0.000000     10037.712301         0.000000 0 0 / 
[ 5265.371626]  I   kworker/10:1H  3207   6448221.310842   3491711   100         0.000000     13888.369643         0.000000 0 0 / 
[ 5265.385511]  I    kworker/10:3 30641   6447921.714812     18154   120         0.000000        62.366081         0.000000 0 0 / 
[ 5265.399446]  I    kworker/10:0 41742   6447921.692065         5   120         0.000000         0.016408         0.000000 0 0 / 
[ 5265.413425]  I    kworker/10:1 42131   6448230.850963       647   120         0.000000         2.117985         0.000000 0 0 / 
[ 5265.427456] cpu#11, 2597.006 MHz 
[ 5265.431714]   .nr_running                    : 0 
[ 5265.437528]   .nr_switches                   : 25689688 
[ 5265.444012]   .nr_uninterruptible            : -2524 
[ 5265.450213]   .next_balance                  : 4299.932116 
[ 5265.456999]   .curr->pid                     : 0 
[ 5265.462815]   .clock                         : 5264964.048568 
[ 5265.469896]   .clock_task                    : 5261781.826831 
[ 5265.476978]   .avg_idle                      : 1000000 
[ 5265.483381]   .max_idle_balance_cost         : 500000 
[ 5265.489679] cfs_rq[11]:/ 
[ 5265.493164]   .exec_clock                    : 0.000000 
[ 5265.499664]   .MIN_vruntime                  : 0.000001 
[ 5265.506163]   .min_vruntime                  : 6144956.276314 
[ 5265.513246]   .max_vruntime                  : 0.000001 
[ 5265.519735]   .spread                        : 0.000000 
[ 5265.526223]   .spread0                       : -960409.848323 
[ 5265.533275]   .nr_spread_over                : 0 
[ 5265.539049]   .nr_running                    : 0 
[ 5265.544810]   .load                          : 0 
[ 5265.550550]   .load_avg                      : 0 
[ 5265.556285]   .runnable_avg                  : 0 
[ 5265.562005]   .util_avg                      : 0 
[ 5265.567710]   .util_est_enqueued             : 0 
[ 5265.573402]   .removed.load_avg              : 0 
[ 5265.579074]   .removed.util_avg              : 0 
[ 5265.584741]   .removed.runnable_avg          : 0 
[ 5265.590393]   .tg_load_avg_contrib           : 0 
[ 5265.596034]   .tg_load_avg                   : 0 
[ 5265.601664]   .throttled                     : 0 
[ 5265.607282]   .throttle_count                : 0 
[ 5265.612887] rt_rq[11]:/ 
[ 5265.616042]   .rt_nr_running                 : 0 
[ 5265.621618]   .rt_nr_migratory               : 0 
[ 5265.627190]   .rt_throttled                  : 0 
[ 5265.632751]   .rt_time                       : 0.000000 
[ 5265.638980]   .rt_runtime                    : 950.000000 
[ 5265.645392] dl_rq[11]: 
[ 5265.648389]   .dl_nr_running                 : 0 
[ 5265.653898]   .dl_nr_migratory               : 0 
[ 5265.659392]   .dl_bw->bw                     : 996147 
[ 5265.665358]   .dl_bw->total_bw               : 0 
[ 5265.670824] runnable tasks: 
[ 5265.674235]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5265.686779] ------------------------------------------------------------------------------------------------------------- 
[ 5265.699330]  S        cpuhp/11    66      7086.767554        21   120         0.000000         0.203353         0.000000 1 0 / 
[ 5265.712676]  S    migration/11    67       510.799211      1395     0         0.000000       434.581832         0.000000 1 0 / 
[ 5265.726049]  S    ksoftirqd/11    68   6144064.980091      1764   120         0.000000        20.628759         0.000000 1 0 / 
[ 5265.739469]  I   kworker/11:0H    70      9410.134991        15   100         0.000000         0.055187         0.000000 1 0 / 
[ 5265.752922]  I    kworker/11:1   337   6137223.339101      1426   120         0.000000         7.882517         0.000000 1 0 / 
[ 5265.766430]  I     mlx5_events   710       990.869478         2   100         0.000000         0.006027         0.000000 1 0 / 
[ 5265.779980]  I   kworker/u80:4   744   6144956.276314   2601097   120         0.000000      8971.076533         0.000000 1 0 / 
[ 5265.793575]  S   systemd-udevd  1074      1378.094646      9141   120         0.000000      5835.855991         0.000000 1 0 /autogroup-44 
[ 5265.808393]  I   kworker/11:1H  3140   6144943.726618   3665192   100         0.000000     13441.497109         0.000000 1 0 / 
[ 5265.822103]  I    kworker/11:3 37507   6144943.731040      1487   120         0.000000         2.892305         0.000000 1 0 / 
[ 5265.835871] cpu#12, 2597.006 MHz 
[ 5265.839988]   .nr_running                    : 0 
[ 5265.845674]   .nr_switches                   : 24009025 
[ 5265.852042]   .nr_uninterruptible            : 3270 
[ 5265.858025]   .next_balance                  : 4299.932996 
[ 5265.864691]   .curr->pid                     : 0 
[ 5265.870387]   .clock                         : 5265858.027345 
[ 5265.877349]   .clock_task                    : 5207373.089592 
[ 5265.884314]   .avg_idle                      : 1000000 
[ 5265.890600]   .max_idle_balance_cost         : 500000 
[ 5265.896790] cfs_rq[12]:/autogroup-86 
[ 5265.901329]   .exec_clock                    : 0.000000 
[ 5265.907716]   .MIN_vruntime                  : 0.000001 
[ 5265.914107]   .min_vruntime                  : 87.017546 
[ 5265.920592]   .max_vruntime                  : 0.000001 
[ 5265.926979]   .spread                        : 0.000000 
[ 5265.933367]   .spread0                       : -7105279.107091 
[ 5265.940436]   .nr_spread_over                : 0 
[ 5265.946147]   .nr_running                    : 0 
[ 5265.951857]   .load                          : 0 
[ 5265.957564]   .load_avg                      : 0 
[ 5265.963268]   .runnable_avg                  : 0 
[ 5265.968972]   .util_avg                      : 0 
[ 5265.974676]   .util_est_enqueued             : 0 
[ 5265.980377]   .removed.load_avg              : 0 
[ 5265.986079]   .removed.util_avg              : 0 
[ 5265.991766]   .removed.runnable_avg          : 0 
[ 5265.997437]   .tg_load_avg_contrib           : 0 
[ 5266.003086]   .tg_load_avg                   : 0 
[ 5266.008725]   .throttled                     : 0 
[ 5266.014351]   .throttle_count                : 0 
[ 5266.019962]   .se->exec_start                : 5207248.848258 
[ 5266.026828]   .se->vruntime                  : 6660895.080223 
[ 5266.033681]   .se->sum_exec_runtime          : 88.066122 
[ 5266.040038]   .se->load.weight               : 2 
[ 5266.045609]   .se->avg.load_avg              : 0 
[ 5266.051158]   .se->avg.util_avg              : 0 
[ 5266.056701]   .se->avg.runnable_avg          : 0 
[ 5266.062232] cfs_rq[12]:/ 
[ 5266.065420]   .exec_clock                    : 0.000000 
[ 5266.071608]   .MIN_vruntime                  : 0.000001 
[ 5266.077782]   .min_vruntime                  : 6660895.080223 
[ 5266.084526]   .max_vruntime                  : 0.000001 
[ 5266.090673]   .spread                        : 0.000000 
[ 5266.096805]   .spread0                       : -444471.044414 
[ 5266.103505]   .nr_spread_over                : 0 
[ 5266.108930]   .nr_running                    : 0 
[ 5266.114342]   .load                          : 0 
[ 5266.119750]   .load_avg                      : 0 
[ 5266.125153]   .runnable_avg                  : 0 
[ 5266.130557]   .util_avg                      : 0 
[ 5266.135957]   .util_est_enqueued             : 0 
[ 5266.141354]   .removed.load_avg              : 0 
[ 5266.146749]   .removed.util_avg              : 0 
[ 5266.152141]   .removed.runnable_avg          : 0 
[ 5266.157532]   .tg_load_avg_contrib           : 0 
[ 5266.162921]   .tg_load_avg                   : 0 
[ 5266.168299]   .throttled                     : 0 
[ 5266.173681]   .throttle_count                : 0 
[ 5266.179059] rt_rq[12]:/ 
[ 5266.182006]   .rt_nr_running                 : 0 
[ 5266.187385]   .rt_nr_migratory               : 0 
[ 5266.192762]   .rt_throttled                  : 0 
[ 5266.198140]   .rt_time                       : 0.000000 
[ 5266.204199]   .rt_runtime                    : 950.000000 
[ 5266.210448] dl_rq[12]: 
[ 5266.213300]   .dl_nr_running                 : 0 
[ 5266.218679]   .dl_nr_migratory               : 0 
[ 5266.224060]   .dl_bw->bw                     : 996147 
[ 5266.229928]   .dl_bw->total_bw               : 0 
[ 5266.235310] runnable tasks: 
[ 5266.238653]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5266.251134] ------------------------------------------------------------------------------------------------------------- 
[ 5266.263645]  S        cpuhp/12    71      2592.511665        21   120         0.000000         0.276748         0.000000 0 0 / 
[ 5266.276949]  S    migration/12    72       566.799690      1403     0         0.000000       435.369331         0.000000 0 0 / 
[ 5266.290302]  S    ksoftirqd/12    73   6660883.080223    102648   120         0.000000        97.206802         0.000000 0 0 / 
[ 5266.303713]  I   kworker/12:0H    75       312.658709         8   100         0.000000         0.023400         0.000000 0 0 / 
[ 5266.317163]  S   irq/29-aerdrv   379         0.000000         3    49         0.000000         0.008212         0.000000 0 0 / 
[ 5266.330650]  I mlx5_cmd_0000:0   701        90.315506         2   100         0.000000         0.008315         0.000000 0 0 / 
[ 5266.344190]  I   kworker/12:1H   896   6660762.087767   3974917   100         0.000000     16832.337630         0.000000 0 0 / 
[ 5266.357781]  I xfs-reclaim/sda  1346      2624.139356         2   100         0.000000         0.007204         0.000000 0 0 / 
[ 5266.371421]  I xfs-eofblocks/d  1349      2624.141338         2   100         0.000000         0.006084         0.000000 0 0 / 
[ 5266.385114]  S   rs:main Q:Reg  3165        87.580525     21630   120         0.000000       169.828596         0.000000 0 0 /autogroup-86 
[ 5266.400021]  S            pool 37727      3991.410062      2488   120         0.000000       161.311027         0.000000 0 0 /autogroup-96 
[ 5266.414977]  I    kworker/12:3 30431   6660883.085115     20901   120         0.000000        81.659726         0.000000 0 0 / 
[ 5266.428825]  S          opensm 38057       -12.358543        39   120         0.000000         0.521004         0.000000 0 0 /autogroup-160 
[ 5266.443987]  I    kworker/12:1 40627   6659692.097973         4   120         0.000000         0.004534         0.000000 0 0 / 
[ 5266.457947] cpu#13, 2597.006 MHz 
[ 5266.462172]   .nr_running                    : 0 
[ 5266.467953]   .nr_switches                   : 24590887 
[ 5266.474416]   .nr_uninterruptible            : -2418 
[ 5266.480591]   .next_balance                  : 4299.932996 
[ 5266.487345]   .curr->pid                     : 0 
[ 5266.493138]   .clock                         : 5265864.695833 
[ 5266.500195]   .clock_task                    : 5262532.235365 
[ 5266.507244]   .avg_idle                      : 1000000 
[ 5266.513624]   .max_idle_balance_cost         : 500000 
[ 5266.519909] cfs_rq[13]:/ 
[ 5266.523375]   .exec_clock                    : 0.000000 
[ 5266.529851]   .MIN_vruntime                  : 0.000001 
[ 5266.536325]   .min_vruntime                  : 6270237.192594 
[ 5266.543384]   .max_vruntime                  : 0.000001 
[ 5266.549860]   .spread                        : 0.000000 
[ 5266.556336]   .spread0                       : -835128.932043 
[ 5266.563392]   .nr_spread_over                : 0 
[ 5266.569179]   .nr_running                    : 0 
[ 5266.574944]   .load                          : 0 
[ 5266.580692]   .load_avg                      : 0 
[ 5266.586425]   .runnable_avg                  : 0 
[ 5266.592146]   .util_avg                      : 0 
[ 5266.597852]   .util_est_enqueued             : 0 
[ 5266.603547]   .removed.load_avg              : 0 
[ 5266.609226]   .removed.util_avg              : 0 
[ 5266.614892]   .removed.runnable_avg          : 0 
[ 5266.620537]   .tg_load_avg_contrib           : 0 
[ 5266.626181]   .tg_load_avg                   : 0 
[ 5266.631811]   .throttled                     : 0 
[ 5266.637427]   .throttle_count                : 0 
[ 5266.643032] rt_rq[13]:/ 
[ 5266.646192]   .rt_nr_running                 : 0 
[ 5266.651769]   .rt_nr_migratory               : 0 
[ 5266.657331]   .rt_throttled                  : 0 
[ 5266.662880]   .rt_time                       : 0.000000 
[ 5266.669096]   .rt_runtime                    : 950.000000 
[ 5266.675494] dl_rq[13]: 
[ 5266.678481]   .dl_nr_running                 : 0 
[ 5266.683982]   .dl_nr_migratory               : 0 
[ 5266.689468]   .dl_bw->bw                     : 996147 
[ 5266.695430]   .dl_bw->total_bw               : 0 
[ 5266.700891] runnable tasks: 
[ 5266.704300]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5266.716844] ------------------------------------------------------------------------------------------------------------- 
[ 5266.729396]  S        cpuhp/13    76      8909.469997        21   120         0.000000         0.218885         0.000000 1 0 / 
[ 5266.742732]  S    migration/13    77       622.799701      1404     0         0.000000       203.989039         0.000000 1 0 / 
[ 5266.756106]  S    ksoftirqd/13    78   6269283.081533       786   120         0.000000         9.750811         0.000000 1 0 / 
[ 5266.769524]  I   kworker/13:0H    80      4766.592797        10   100         0.000000         0.023554         0.000000 1 0 / 
[ 5266.782985]  I           netns   252        61.909256         2   100         0.000000         0.000000         0.000000 1 0 / 
[ 5266.796484]  I         ata_sff   657       562.865717         2   100         0.000000         0.009231         0.000000 1 0 / 
[ 5266.810018]  I    mlx5_hv_vhca   754      4192.469911         2   100         0.000000         0.005884         0.000000 1 0 / 
[ 5266.823588]  I     mlx5_lag_mp   769      4204.475085         2   100         0.000000         0.005864         0.000000 1 0 / 
[ 5266.837203]  I   kworker/13:1H  1167   6270224.277197   3625131   100         0.000000     13490.271759         0.000000 1 0 / 
[ 5266.850875]  I xfs-eofblocks/s  1348      8958.837067         2   100         0.000000         0.005075         0.000000 1 0 / 
[ 5266.864596]  S          auditd  1638         0.943392       418   116         0.000000        15.995436         0.000000 1 0 /autogroup-56 
[ 5266.879531]  I    kworker/13:3  3196   6270224.281500      2529   120         0.000000         9.059836         0.000000 1 0 / 
[ 5266.893357]  I    kworker/13:2 38133   6263864.362531         3   120         0.000000         0.009926         0.000000 1 0 / 
[ 5266.907235]  I   kworker/u80:6 41358   6270237.318052   1033931   120         0.000000      3568.065171         0.000000 1 0 / 
[ 5266.921180] cpu#14, 2597.006 MHz 
[ 5266.925399]   .nr_running                    : 0 
[ 5266.931177]   .nr_switches                   : 22424235 
[ 5266.937634]   .nr_uninterruptible            : 3697 
[ 5266.943697]   .next_balance                  : 4299.934020 
[ 5266.950455]   .curr->pid                     : 0 
[ 5266.956231]   .clock                         : 5266868.097466 
[ 5266.963283]   .clock_task                    : 5207952.438354 
[ 5266.970335]   .avg_idle                      : 1000000 
[ 5266.976709]   .max_idle_balance_cost         : 500000 
[ 5266.982990] rt_rq[14]:/ 
[ 5266.986354]   .rt_nr_running                 : 0 
[ 5266.992143]   .rt_nr_migratory               : 0 
[ 5266.997931]   .rt_throttled                  : 0 
[ 5267.003709]   .rt_time                       : 0.000000 
[ 5267.010177]   .rt_runtime                    : 950.000000 
[ 5267.016840] dl_rq[14]: 
[ 5267.020101]   .dl_nr_running                 : 0 
[ 5267.025877]   .dl_nr_migratory               : 0 
[ 5267.031634]   .dl_bw->bw                     : 996147 
[ 5267.037861]   .dl_bw->total_bw               : 0 
[ 5267.043588] runnable tasks: 
[ 5267.047264]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5267.060073] ------------------------------------------------------------------------------------------------------------- 
[ 5267.072892]  S        cpuhp/14    81      4521.454206        21   120         0.000000         0.232438         0.000000 0 0 / 
[ 5267.086769]  S    migration/14    82       678.799675      1399     0         0.000000       437.656922         0.000000 0 0 / 
[ 5267.100647]  S    ksoftirqd/14    83   6823126.177910    144159   120         0.000000        56.152384         0.000000 0 0 / 
[ 5267.114536]  I   kworker/14:0H    85      7083.338555        15   100         0.000000         0.038992         0.000000 0 0 / 
[ 5267.128434]  S   irq/30-aerdrv   380         0.000000         3    49         0.000000         0.007164         0.000000 0 0 / 
[ 5267.142334]  S  NetworkManager  1688       978.022167    155668   120         0.000000      2986.968532         0.000000 0 0 /autogroup-65 
[ 5267.157401]  I   kworker/14:1H  3208   6823126.177983   3422225   100         0.000000     14771.122042         0.000000 0 0 / 
[ 5267.171302]  S      restraintd  3621       487.827668     14910   120         0.000000      2847.345884         0.000000 0 0 /autogroup-96 
[ 5267.186375]  I    kworker/14:2 29574   6823126.369098    106197   120         0.000000       221.161625         0.000000 0 0 / 
[ 5267.200292]  I    kworker/14:3 29829   6822647.822027     13511   120         0.000000        40.922886         0.000000 0 0 / 
[ 5267.214211]  S          opensm 38087       -12.358718        36   120         0.000000         0.525127         0.000000 0 0 /autogroup-160 
[ 5267.229398] cpu#15, 2597.006 MHz 
[ 5267.233580]   .nr_running                    : 0 
[ 5267.239316]   .nr_switches                   : 23936296 
[ 5267.245731]   .nr_uninterruptible            : -2288 
[ 5267.251856]   .next_balance                  : 4299.927626 
[ 5267.258564]   .curr->pid                     : 0 
[ 5267.264303]   .clock                         : 5264254.047799 
[ 5267.271303]   .clock_task                    : 5261045.304051 
[ 5267.278301]   .avg_idle                      : 1000000 
[ 5267.284619]   .max_idle_balance_cost         : 500000 
[ 5267.290843] rt_rq[15]:/ 
[ 5267.294147]   .rt_nr_running                 : 0 
[ 5267.299875]   .rt_nr_migratory               : 0 
[ 5267.305603]   .rt_throttled                  : 0 
[ 5267.311330]   .rt_time                       : 0.000000 
[ 5267.317729]   .rt_runtime                    : 950.000000 
[ 5267.324331] dl_rq[15]: 
[ 5267.327534]   .dl_nr_running                 : 0 
[ 5267.333262]   .dl_nr_migratory               : 0 
[ 5267.338987]   .dl_bw->bw                     : 996147 
[ 5267.345202]   .dl_bw->total_bw               : 0 
[ 5267.350930] runnable tasks: 
[ 5267.354620]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5267.367450] ------------------------------------------------------------------------------------------------------------- 
[ 5267.380290]  S        cpuhp/15    86      4502.807473        21   120         0.000000         0.229457         0.000000 1 0 / 
[ 5267.394196]  S    migration/15    87       734.799681      1395     0         0.000000       438.694915         0.000000 1 0 / 
[ 5267.408096]  S    ksoftirqd/15    88   6191281.067365      1360   120         0.000000         7.893743         0.000000 1 0 / 
[ 5267.421996]  I   kworker/15:0H    90      6871.364554        15   100         0.000000         0.032601         0.000000 1 0 / 
[ 5267.435897]  I    kworker/15:1   340      7248.626412       282   120         0.000000         1.073693         0.000000 1 0 / 
[ 5267.449802]  S    xfsaild/dm-2  1353      7147.735819        16   120         0.000000         0.075664         0.000000 1 0 / 
[ 5267.463696]  I           mlx5e  2581      5817.223290         2   100         0.000000         0.008518         0.000000 1 0 / 
[ 5267.477583]  I   kworker/15:1H  3209   6191385.515744   3618818   100         0.000000     13321.636924         0.000000 1 0 / 
[ 5267.491467]  I    kworker/15:2 21119   6191385.766422      2697   120         0.000000        10.779613         0.000000 1 0 / 
[ 5267.505367] cpu#16, 2597.006 MHz 
[ 5267.509538]   .nr_running                    : 0 
[ 5267.515250]   .nr_switches                   : 20627527 
[ 5267.521629]   .nr_uninterruptible            : 3548 
[ 5267.527604]   .next_balance                  : 4299.934679 
[ 5267.534260]   .curr->pid                     : 0 
[ 5267.539942]   .clock                         : 5267539.064540 
[ 5267.546886]   .clock_task                    : 5217061.559600 
[ 5267.553822]   .avg_idle                      : 1000000 
[ 5267.560079]   .max_idle_balance_cost         : 500000 
[ 5267.566247] rt_rq[16]:/ 
[ 5267.569496]   .rt_nr_running                 : 0 
[ 5267.575171]   .rt_nr_migratory               : 0 
[ 5267.580837]   .rt_throttled                  : 0 
[ 5267.586509]   .rt_time                       : 0.000000 
[ 5267.592859]   .rt_runtime                    : 950.000000 
[ 5267.599401] dl_rq[16]: 
[ 5267.602542]   .dl_nr_running                 : 0 
[ 5267.608212]   .dl_nr_migratory               : 0 
[ 5267.613881]   .dl_bw->bw                     : 996147 
[ 5267.620038]   .dl_bw->total_bw               : 0 
[ 5267.625709] runnable tasks: 
[ 5267.629338]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5267.642102] ------------------------------------------------------------------------------------------------------------- 
[ 5267.654898]  S        cpuhp/16    91      1687.800884        21   120         0.000000         0.269181         0.000000 0 0 / 
[ 5267.668766]  S    migration/16    92       790.799664      1398     0         0.000000       439.510562         0.000000 0 0 / 
[ 5267.682668]  S    ksoftirqd/16    93   6523815.608562     99744   120         0.000000        46.598782         0.000000 0 0 / 
[ 5267.696556]  I   kworker/16:0H    95      5044.275006        15   100         0.000000         0.040825         0.000000 0 0 / 
[ 5267.710440]  I     edac-poller   327        59.839301         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5267.724321]  S   irq/31-aerdrv   381         0.000000         3    49         0.000000         0.008409         0.000000 0 0 / 
[ 5267.738195]  I   kworker/u83:0   431      5056.301708        11   100         0.000000         0.022381         0.000000 0 0 / 
[ 5267.752072]  S    xfsaild/dm-0   924   6523817.019077    100697   120         0.000000        82.822535         0.000000 0 0 / 
[ 5267.765952]  I   xfs-conv/sda1  1343      1713.800737         2   100         0.000000         0.007433         0.000000 0 0 / 
[ 5267.779835]  I          rpciod  1555      1823.543876         2   100         0.000000         0.010493         0.000000 0 0 / 
[ 5267.793717]  S           gdbus  1738        68.718681      5095   120         0.000000       113.363991         0.000000 0 0 /autogroup-65 
[ 5267.808753]  I   kworker/16:1H  3210   6523815.608619   2912161   100         0.000000     12767.388750         0.000000 0 0 / 
[ 5267.822632]  I    kworker/16:1 29559   6523737.600562    113714   120         0.000000       225.121771         0.000000 0 0 / 
[ 5267.836563]  I    kworker/16:2 30631   6523817.373922     20083   120         0.000000        77.097391         0.000000 0 0 / 
[ 5267.850544]  S      runtest.sh 37859       267.993325         3   120         0.000000         1.614181         0.000000 0 0 /autogroup-159 
[ 5267.865829]  S          opensm 38055       -11.937458        38   120         0.000000         0.523679         0.000000 0 0 /autogroup-160 
[ 5267.881165] cpu#17, 2597.006 MHz 
[ 5267.885443]   .nr_running                    : 3 
[ 5267.891272]   .nr_switches                   : 24306459 
[ 5267.897783]   .nr_uninterruptible            : -2086 
[ 5267.904005]   .next_balance                  : 4299.935157 
[ 5267.910815]   .curr->pid                     : 42342 
[ 5267.917043]   .clock                         : 5267917.040902 
[ 5267.924136]   .clock_task                    : 5264841.397129 
[ 5267.931236]   .avg_idle                      : 1000000 
[ 5267.937648]   .max_idle_balance_cost         : 500000 
[ 5267.943976] cfs_rq[17]:/autogroup-168 
[ 5267.948748]   .exec_clock                    : 0.000000 
[ 5267.955271]   .MIN_vruntime                  : 0.000001 
[ 5267.961794]   .min_vruntime                  : 7807.361749 
[ 5267.968597]   .max_vruntime                  : 0.000001 
[ 5267.975089]   .spread                        : 0.000000 
[ 5267.981552]   .spread0                       : -7097558.762888 
[ 5267.988693]   .nr_spread_over                : 0 
[ 5267.994466]   .nr_running                    : 1 
[ 5268.000224]   .load                          : 1048576 
[ 5268.006555]   .load_avg                      : 1023 
[ 5268.012579]   .runnable_avg                  : 1023 
[ 5268.018592]   .util_avg                      : 1023 
[ 5268.024590]   .util_est_enqueued             : 0 
[ 5268.030285]   .removed.load_avg              : 0 
[ 5268.035972]   .removed.util_avg              : 0 
[ 5268.041642]   .removed.runnable_avg          : 0 
[ 5268.047301]   .tg_load_avg_contrib           : 1024 
[ 5268.053243]   .tg_load_avg                   : 1024 
[ 5268.059169]   .throttled                     : 0 
[ 5268.064789]   .throttle_count                : 0 
[ 5268.070395]   .se->exec_start                : 5264861.224747 
[ 5268.077254]   .se->vruntime                  : 6179935.779704 
[ 5268.084104]   .se->sum_exec_runtime          : 7808.410325 
[ 5268.090653]   .se->load.weight               : 1048576 
[ 5268.096806]   .se->avg.load_avg              : 1023 
[ 5268.102655]   .se->avg.util_avg              : 1023 
[ 5268.108492]   .se->avg.runnable_avg          : 1023 
[ 5268.114312] cfs_rq[17]:/ 
[ 5268.117496]   .exec_clock                    : 0.000000 
[ 5268.123682]   .MIN_vruntime                  : 6172127.274196 
[ 5268.130436]   .min_vruntime                  : 6172139.258807 
[ 5268.137177]   .max_vruntime                  : 6172127.274196 
[ 5268.143905]   .spread                        : 0.000000 
[ 5268.150031]   .spread0                       : -933226.865830 
[ 5268.156735]   .nr_spread_over                : 0 
[ 5268.162167]   .nr_running                    : 2 
[ 5268.167580]   .load                          : 2097152 
[ 5268.173581]   .load_avg                      : 2047 
[ 5268.179289]   .runnable_avg                  : 2047 
[ 5268.184996]   .util_avg                      : 1023 
[ 5268.190701]   .util_est_enqueued             : 42 
[ 5268.196202]   .removed.load_avg              : 0 
[ 5268.201612]   .removed.util_avg              : 0 
[ 5268.207019]   .removed.runnable_avg          : 0 
[ 5268.212424]   .tg_load_avg_contrib           : 0 
[ 5268.217829]   .tg_load_avg                   : 0 
[ 5268.223231]   .throttled                     : 0 
[ 5268.228630]   .throttle_count                : 0 
[ 5268.234023] rt_rq[17]:/ 
[ 5268.236989]   .rt_nr_running                 : 0 
[ 5268.242385]   .rt_nr_migratory               : 0 
[ 5268.247779]   .rt_throttled                  : 0 
[ 5268.253172]   .rt_time                       : 0.000000 
[ 5268.259246]   .rt_runtime                    : 950.000000 
[ 5268.265511] dl_rq[17]: 
[ 5268.268378]   .dl_nr_running                 : 0 
[ 5268.273771]   .dl_nr_migratory               : 0 
[ 5268.279165]   .dl_bw->bw                     : 996147 
[ 5268.285043]   .dl_bw->total_bw               : 0 
[ 5268.290439] runnable tasks: 
[ 5268.293793]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5268.306292] ------------------------------------------------------------------------------------------------------------- 
[ 5268.318817]  S        cpuhp/17    96      8512.066597        21   120         0.000000         0.201315         0.000000 1 0 / 
[ 5268.332145]  R    migration/17    97       846.799672      1390     0         0.000000       206.575117         0.000000 1 0 / 
[ 5268.345519]  S    ksoftirqd/17    98   6171819.996728       411   120         0.000000         5.019786         0.000000 1 0 / 
[ 5268.358945]  I    kworker/17:0    99        38.054864        21   120         0.000000         0.017181         0.000000 1 0 / 
[ 5268.372411]  I   kworker/17:0H   100     10769.635570        15   100         0.000000         0.031119         0.000000 1 0 / 
[ 5268.385918]  S         kauditd   254   6170289.041149       412   120         0.000000         2.437844         0.000000 1 0 / 
[ 5268.399477]  R    kworker/17:1   342   6172127.274196      2636   120         0.000000         8.473123         0.000000 1 0 / 
[ 5268.413075]  I    xfs-cil/dm-2  1345      8564.312200         2   100         0.000000         0.005973         0.000000 1 0 / 
[ 5268.426724]  I   kworker/17:1H  3211   6172127.068729   3588217   100         0.000000     13585.509114         0.000000 1 0 / 
[ 5268.440431]  I   kworker/u82:0 40990   6171820.111560   1055699   120         0.000000      2451.121884         0.000000 1 0 / 
[ 5268.454189] >R      20_sysinfo 42342      7807.361749        35   120         0.000000      8204.512438         0.000000 1 0 /autogroup-168 
[ 5268.469264] cpu#18, 2597.006 MHz 
[ 5268.473416]   .nr_running                    : 0 
[ 5268.479128]   .nr_switches                   : 20701742 
[ 5268.485520]   .nr_uninterruptible            : 2704 
[ 5268.491524]   .next_balance                  : 4299.934980 
[ 5268.498209]   .curr->pid                     : 0 
[ 5268.503927]   .clock                         : 5268299.075358 
[ 5268.510911]   .clock_task                    : 5213146.961373 
[ 5268.517896]   .avg_idle                      : 1000000 
[ 5268.524204]   .max_idle_balance_cost         : 500000 
[ 5268.530418] rt_rq[18]:/ 
[ 5268.533716]   .rt_nr_running                 : 0 
[ 5268.539441]   .rt_nr_migratory               : 0 
[ 5268.545166]   .rt_throttled                  : 0 
[ 5268.550889]   .rt_time                       : 0.000000 
[ 5268.557293]   .rt_runtime                    : 950.000000 
[ 5268.563891] dl_rq[18]: 
[ 5268.567092]   .dl_nr_running                 : 0 
[ 5268.572818]   .dl_nr_migratory               : 0 
[ 5268.578544]   .dl_bw->bw                     : 996147 
[ 5268.584756]   .dl_bw->total_bw               : 0 
[ 5268.590479] runnable tasks: 
[ 5268.594164]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5268.606993] ------------------------------------------------------------------------------------------------------------- 
[ 5268.619832]  S        cpuhp/18   101      2331.224665        21   120         0.000000         0.291814         0.000000 0 0 / 
[ 5268.633734]  S    migration/18   102       902.799654      1423     0         0.000000       443.555752         0.000000 0 0 / 
[ 5268.647632]  S    ksoftirqd/18   103   6591340.030430     78145   120         0.000000        58.535229         0.000000 0 0 / 
[ 5268.661531]  I   kworker/18:0H   105       483.592462        10   100         0.000000         0.020291         0.000000 0 0 / 
[ 5268.675436]  I         kblockd   323        62.025247         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5268.689334]  S       watchdogd   328         0.000000         2    49         0.000000         0.002168         0.000000 0 0 / 
[ 5268.703227]  I   kworker/18:1H  1010   6591340.030501   3089800   100         0.000000     13388.700315         0.000000 0 0 / 
[ 5268.717128]  S     dbus-daemon  1684         2.500458      5868   120         0.000000       711.841894         0.000000 0 0 /autogroup-63 
[ 5268.732195]  S            sssd  1690        47.002770      1179   120         0.000000        68.528219         0.000000 0 0 /autogroup-66 
[ 5268.747257]  I    kworker/18:1 29824   6259471.101511     25437   120         0.000000        54.204480         0.000000 0 0 / 
[ 5268.761144]  I    kworker/18:2 30645   6591340.126778      9205   120         0.000000        41.874427         0.000000 0 0 / 
[ 5268.775027]  S          opensm 38066        83.251274        37   120         0.000000         0.520234         0.000000 0 0 /autogroup-160 
[ 5268.790178]  S          opensm 38081        83.517546        37   120         0.000000         0.537827         0.000000 0 0 /autogroup-160 
[ 5268.805364]  S          opensm 38094        94.983104         1   120         0.000000         0.003475         0.000000 0 0 /autogroup-160 
[ 5268.820588]  S     run_plugins 42300        13.242276        23   120         0.000000        15.016390         0.000000 0 0 /autogroup-168 
[ 5268.835858] cpu#19, 2597.006 MHz 
[ 5268.840106]   .nr_running                    : 0 
[ 5268.845907]   .nr_switches                   : 23766485 
[ 5268.852388]   .nr_uninterruptible            : -2049 
[ 5268.858575]   .next_balance                  : 4299.936004 
[ 5268.865347]   .curr->pid                     : 0 
[ 5268.871152]   .clock                         : 5268868.082855 
[ 5268.878222]   .clock_task                    : 5265602.395197 
[ 5268.885290]   .avg_idle                      : 1000000 
[ 5268.891681]   .max_idle_balance_cost         : 500000 
[ 5268.897972] cfs_rq[19]:/ 
[ 5268.901447]   .exec_clock                    : 0.000000 
[ 5268.907936]   .MIN_vruntime                  : 0.000001 
[ 5268.914422]   .min_vruntime                  : 6335283.969779 
[ 5268.921492]   .max_vruntime                  : 0.000001 
[ 5268.927978]   .spread                        : 0.000000 
[ 5268.934453]   .spread0                       : -770082.154858 
[ 5268.941491]   .nr_spread_over                : 0 
[ 5268.947252]   .nr_running                    : 0 
[ 5268.952998]   .load                          : 0 
[ 5268.958732]   .load_avg                      : 0 
[ 5268.964450]   .runnable_avg                  : 0 
[ 5268.970146]   .util_avg                      : 0 
[ 5268.975838]   .util_est_enqueued             : 0 
[ 5268.981516]   .removed.load_avg              : 0 
[ 5268.987181]   .removed.util_avg              : 0 
[ 5268.992835]   .removed.runnable_avg          : 0 
[ 5268.998478]   .tg_load_avg_contrib           : 0 
[ 5269.004110]   .tg_load_avg                   : 0 
[ 5269.009730]   .throttled                     : 0 
[ 5269.015336]   .throttle_count                : 0 
[ 5269.020917] rt_rq[19]:/ 
[ 5269.024065]   .rt_nr_running                 : 0 
[ 5269.029631]   .rt_nr_migratory               : 0 
[ 5269.035183]   .rt_throttled                  : 0 
[ 5269.040723]   .rt_time                       : 0.000000 
[ 5269.046932]   .rt_runtime                    : 950.000000 
[ 5269.053321] dl_rq[19]: 
[ 5269.056296]   .dl_nr_running                 : 0 
[ 5269.061786]   .dl_nr_migratory               : 0 
[ 5269.067263]   .dl_bw->bw                     : 996147 
[ 5269.073216]   .dl_bw->total_bw               : 0 
[ 5269.078673] runnable tasks: 
[ 5269.082078]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5269.094618] ------------------------------------------------------------------------------------------------------------- 
[ 5269.107169]  S        cpuhp/19   106      5651.207154        21   120         0.000000         0.344423         0.000000 1 0 / 
[ 5269.120514]  S    migration/19   107       958.799656      1392     0         0.000000       443.351331         0.000000 1 0 / 
[ 5269.133888]  S    ksoftirqd/19   108   6334588.903288       286   120         0.000000         3.864068         0.000000 1 0 / 
[ 5269.147308]  I   kworker/19:0H   110      8183.045028        15   100         0.000000         0.030811         0.000000 1 0 / 
[ 5269.160772]  S      kcompactd1   263   6335272.033295     10457   120         0.000000        12.649707         0.000000 1 0 / 
[ 5269.174272]  I    kworker/19:1   344      8161.645185       116   120         0.000000         0.530769         0.000000 1 0 / 
[ 5269.187830]  S        rdma-ndd  1312         0.988248        27   120         0.000000         4.955332         0.000000 1 0 /autogroup-49 
[ 5269.202585]  I    xfs-cil/sda1  1344      5713.126858         2   100         0.000000         0.005135         0.000000 1 0 / 
[ 5269.216221]  I    kworker/19:3  3088   6335269.394101      1963   120         0.000000         6.401053         0.000000 1 0 / 
[ 5269.229897]  I  kworker/u80:12  3139   6335284.033080   2420131   120         0.000000      8419.622949         0.000000 1 0 / 
[ 5269.243635]  I   kworker/19:1H  3212   6335269.389817   3539336   100         0.000000     13287.238104         0.000000 1 0 / 
[ 5269.257439]  I  kworker/u80:13 41978   6335269.398646    147499   120         0.000000       505.538249         0.000000 1 0 / 
[ 5269.271317] cpu#20, 2597.006 MHz 
[ 5269.275498]   .nr_running                    : 0 
[ 5269.281239]   .nr_switches                   : 25815236 
[ 5269.287661]   .nr_uninterruptible            : 2931 
[ 5269.293697]   .next_balance                  : 4299.927536 
[ 5269.300418]   .curr->pid                     : 0 
[ 5269.306167]   .clock                         : 5268261.079087 
[ 5269.313181]   .clock_task                    : 5206599.575678 
[ 5269.320197]   .avg_idle                      : 1000000 
[ 5269.326538]   .max_idle_balance_cost         : 500000 
[ 5269.332783] rt_rq[20]:/ 
[ 5269.336111]   .rt_nr_running                 : 0 
[ 5269.341868]   .rt_nr_migratory               : 0 
[ 5269.347625]   .rt_throttled                  : 0 
[ 5269.353381]   .rt_time                       : 0.000000 
[ 5269.359817]   .rt_runtime                    : 950.000000 
[ 5269.366443] dl_rq[20]: 
[ 5269.369672]   .dl_nr_running                 : 0 
[ 5269.375429]   .dl_nr_migratory               : 0 
[ 5269.381185]   .dl_bw->bw                     : 996147 
[ 5269.387426]   .dl_bw->total_bw               : 0 
[ 5269.393181] runnable tasks: 
[ 5269.396883]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5269.409713] ------------------------------------------------------------------------------------------------------------- 
[ 5269.422545]  S        cpuhp/20   111      4441.474392        21   120         0.000000         0.243224         0.000000 0 0 / 
[ 5269.436451]  S    migration/20   112      1014.800755      1389     0         0.000000       444.183050         0.000000 0 0 / 
[ 5269.450357]  S    ksoftirqd/20   113   6750245.533051    841239   120         0.000000        53.179387         0.000000 0 0 / 
[ 5269.464258]  I   kworker/20:0H   115      4465.419427        15   100         0.000000         0.034448         0.000000 0 0 / 
[ 5269.478170]  I          kaluad   384        69.078826         2   100         0.000000         0.006032         0.000000 0 0 / 
[ 5269.492076]  I   kworker/20:1H  1382   6750245.529433   3580871   100         0.000000     14764.211866         0.000000 0 0 / 
[ 5269.505982]  I    kworker/20:1 30643   6750246.956231     10085   120         0.000000        43.958324         0.000000 0 0 / 
[ 5269.519903]  S          opensm 38117         0.962631         4   120         0.000000         0.313681         0.000000 0 0 /autogroup-160 
[ 5269.535083]  I    kworker/20:0 41392   6750245.491800         4   120         0.000000         0.015819         0.000000 0 0 / 
[ 5269.548994]  I    kworker/20:2 42148   6750257.481657         2   120         0.000000         0.004302         0.000000 0 0 / 
[ 5269.562903] cpu#21, 2597.006 MHz 
[ 5269.567079]   .nr_running                    : 0 
[ 5269.572800]   .nr_switches                   : 22915727 
[ 5269.579185]   .nr_uninterruptible            : -1722 
[ 5269.585277]   .next_balance                  : 4299.936719 
[ 5269.591953]   .curr->pid                     : 0 
[ 5269.597660]   .clock                         : 5269567.118797 
[ 5269.604631]   .clock_task                    : 5266345.516216 
[ 5269.611598]   .avg_idle                      : 1000000 
[ 5269.617885]   .max_idle_balance_cost         : 500000 
[ 5269.624078] rt_rq[21]:/ 
[ 5269.627352]   .rt_nr_running                 : 0 
[ 5269.633052]   .rt_nr_migratory               : 0 
[ 5269.638749]   .rt_throttled                  : 0 
[ 5269.644443]   .rt_time                       : 0.000000 
[ 5269.650817]   .rt_runtime                    : 950.000000 
[ 5269.657386] dl_rq[21]: 
[ 5269.660555]   .dl_nr_running                 : 0 
[ 5269.666253]   .dl_nr_migratory               : 0 
[ 5269.671949]   .dl_bw->bw                     : 996147 
[ 5269.678128]   .dl_bw->total_bw               : 0 
[ 5269.683823] runnable tasks: 
[ 5269.687478]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5269.700278] ------------------------------------------------------------------------------------------------------------- 
[ 5269.713099]  S        cpuhp/21   116      5464.657089        21   120         0.000000         0.209357         0.000000 1 0 / 
[ 5269.727006]  S    migration/21   117         0.000000      1374     0         0.000000       446.238899         0.000000 1 0 / 
[ 5269.740891]  S    ksoftirqd/21   118   6122789.029991       187   120         0.000000         4.895311         0.000000 1 0 / 
[ 5269.754773]  I    kworker/21:0   119        38.187528        21   120         0.000000         0.017506         0.000000 1 0 / 
[ 5269.768652]  I   kworker/21:0H   120      7611.593672        15   100         0.000000         0.032044         0.000000 1 0 / 
[ 5269.782529]  I    kworker/21:1   345   6123602.485708      1628   120         0.000000         6.143300         0.000000 1 0 / 
[ 5269.796409]  I   xfs-conv/dm-0   919      1187.853743         2   100         0.000000         0.005798         0.000000 1 0 / 
[ 5269.810295]  I xfs-reclaim/dm-  1347      5538.225620         2   100         0.000000         0.006115         0.000000 1 0 / 
[ 5269.824171]  I   kworker/u80:9  2914   6123603.649099   3655404   120         0.000000     12746.850719         0.000000 1 0 / 
[ 5269.838052]  I   kworker/21:1H  3214   6123602.485763   3392528   100         0.000000     13885.954172         0.000000 1 0 / 
[ 5269.851951]  S          opensm 38050        12.217024      2240   120         0.000000        17.188129         0.000000 1 0 /autogroup-160 
[ 5269.867121] cpu#22, 2597.006 MHz 
[ 5269.871297]   .nr_running                    : 0 
[ 5269.877027]   .nr_switches                   : 20664976 
[ 5269.883436]   .nr_uninterruptible            : 3892 
[ 5269.889457]   .next_balance                  : 4299.936911 
[ 5269.896160]   .curr->pid                     : 0 
[ 5269.901891]   .clock                         : 5269892.086329 
[ 5269.908886]   .clock_task                    : 5214841.078424 
[ 5269.915878]   .avg_idle                      : 1000000 
[ 5269.922191]   .max_idle_balance_cost         : 500000 
[ 5269.928408] cfs_rq[22]:/ 
[ 5269.931804]   .exec_clock                    : 0.000000 
[ 5269.938210]   .MIN_vruntime                  : 0.000001 
[ 5269.944614]   .min_vruntime                  : 6788484.430766 
[ 5269.951604]   .max_vruntime                  : 0.000001 
[ 5269.958011]   .spread                        : 0.000000 
[ 5269.964418]   .spread0                       : -316881.693871 
[ 5269.971410]   .nr_spread_over                : 0 
[ 5269.977137]   .nr_running                    : 0 
[ 5269.982863]   .load                          : 0 
[ 5269.988588]   .load_avg                      : 0 
[ 5269.994310]   .runnable_avg                  : 0 
[ 5270.000031]   .util_avg                      : 0 
[ 5270.005753]   .util_est_enqueued             : 0 
[ 5270.011463]   .removed.load_avg              : 0 
[ 5270.017144]   .removed.util_avg              : 0 
[ 5270.022812]   .removed.runnable_avg          : 0 
[ 5270.028470]   .tg_load_avg_contrib           : 0 
[ 5270.034107]   .tg_load_avg                   : 0 
[ 5270.039740]   .throttled                     : 0 
[ 5270.045360]   .throttle_count                : 0 
[ 5270.050965] rt_rq[22]:/ 
[ 5270.054130]   .rt_nr_running                 : 0 
[ 5270.059714]   .rt_nr_migratory               : 0 
[ 5270.065282]   .rt_throttled                  : 0 
[ 5270.070839]   .rt_time                       : 0.000000 
[ 5270.077061]   .rt_runtime                    : 950.000000 
[ 5270.083465] dl_rq[22]: 
[ 5270.086460]   .dl_nr_running                 : 0 
[ 5270.091970]   .dl_nr_migratory               : 0 
[ 5270.097466]   .dl_bw->bw                     : 996147 
[ 5270.103435]   .dl_bw->total_bw               : 0 
[ 5270.108903] runnable tasks: 
[ 5270.112317]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5270.124862] ------------------------------------------------------------------------------------------------------------- 
[ 5270.137404]  S        cpuhp/22   121      2043.585612        21   120         0.000000         0.181657         0.000000 0 0 / 
[ 5270.150748]  S    migration/22   122      1126.808487      1363     0         0.000000       446.583632         0.000000 0 0 / 
[ 5270.164124]  S    ksoftirqd/22   123   6788197.793579     88236   120         0.000000        31.955869         0.000000 0 0 / 
[ 5270.177551]  I   kworker/22:0H   125      2217.356896        15   100         0.000000         0.040928         0.000000 0 0 / 
[ 5270.191022]  S      kcompactd0   262   6788472.447787     10458   120         0.000000        13.635585         0.000000 0 0 / 
[ 5270.204536]  I   ipv6_addrconf   385        73.394785         2   100         0.000000         0.006017         0.000000 0 0 / 
[ 5270.218095]  I    kworker/22:2   962   6788376.282886    203240   120         0.000000       399.548344         0.000000 0 0 / 
[ 5270.231699]  I   kworker/22:1H  1598   6788471.488911   3308108   100         0.000000     14386.726023         0.000000 0 0 / 
[ 5270.245359]  I        ipoib_wq  2499      3026.838895         2   100         0.000000         0.008406         0.000000 0 0 / 
[ 5270.259067]  I    kworker/22:4 30636   6788472.436774     12916   120         0.000000        53.046464         0.000000 0 0 / 
[ 5270.272823]  S rhts-run-simple 37860       629.425042        10   120         0.000000         3.113553         0.000000 0 0 /autogroup-159 
[ 5270.287904] cpu#23, 2597.006 MHz 
[ 5270.292059]   .nr_running                    : 0 
[ 5270.297772]   .nr_switches                   : 22829006 
[ 5270.304166]   .nr_uninterruptible            : -1730 
[ 5270.310271]   .next_balance                  : 4299.936719 
[ 5270.316963]   .curr->pid                     : 0 
[ 5270.322684]   .clock                         : 5269567.120477 
[ 5270.329673]   .clock_task                    : 5266431.068082 
[ 5270.336662]   .avg_idle                      : 1000000 
[ 5270.342972]   .max_idle_balance_cost         : 500000 
[ 5270.349190] rt_rq[23]:/ 
[ 5270.352491]   .rt_nr_running                 : 0 
[ 5270.358220]   .rt_nr_migratory               : 0 
[ 5270.363948]   .rt_throttled                  : 0 
[ 5270.369678]   .rt_time                       : 0.000000 
[ 5270.376088]   .rt_runtime                    : 950.000000 
[ 5270.382690] dl_rq[23]: 
[ 5270.385894]   .dl_nr_running                 : 0 
[ 5270.391622]   .dl_nr_migratory               : 0 
[ 5270.397351]   .dl_bw->bw                     : 996147 
[ 5270.403566]   .dl_bw->total_bw               : 0 
[ 5270.409296] runnable tasks: 
[ 5270.412984]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5270.425817] ------------------------------------------------------------------------------------------------------------- 
[ 5270.438658]  S        cpuhp/23   126      5236.820290        21   120         0.000000         0.298515         0.000000 1 0 / 
[ 5270.452566]  S    migration/23   127      1182.809065      1358     0         0.000000       448.539319         0.000000 1 0 / 
[ 5270.466468]  S    ksoftirqd/23   128   6178799.532506       473   120         0.000000         3.698574         0.000000 1 0 / 
[ 5270.480370]  I   kworker/23:0H   130      7361.436062        15   100         0.000000         0.033225         0.000000 1 0 / 
[ 5270.494270]  I    kworker/23:1   347   6177503.579119      1871   120         0.000000         7.219290         0.000000 1 0 / 
[ 5270.508176]  I  ib-comp-unb-wq  1259      5262.689936         2   100         0.000000         0.006399         0.000000 1 0 / 
[ 5270.522076]  I mlx5_ib_page_fa  1308      5274.696272         2   100         0.000000         0.007230         0.000000 1 0 / 
[ 5270.535977]  I    xfs-log/dm-2  1352      5297.702731         2   100         0.000000         0.006620         0.000000 1 0 / 
[ 5270.549873]  S        rsyslogd  3149         3.295825        28   120         0.000000         4.744327         0.000000 1 0 /autogroup-86 
[ 5270.564913]  I   kworker/23:1H  3213   6178952.625708   3532215   100         0.000000     13465.708196         0.000000 1 0 / 
[ 5270.578804]  S          opensm 38051         9.025183       725   120         0.000000         7.948110         0.000000 1 0 /autogroup-160 
[ 5270.593952]  I    kworker/23:3 41513   6178952.625662       320   120         0.000000         0.425352         0.000000 1 0 / 
[ 5270.607850] cpu#24, 2597.006 MHz 
[ 5270.612041]   .nr_running                    : 0 
[ 5270.617787]   .nr_switches                   : 20408794 
[ 5270.624214]   .nr_uninterruptible            : 2527 
[ 5270.630250]   .next_balance                  : 4299.927565 
[ 5270.636958]   .curr->pid                     : 0 
[ 5270.642705]   .clock                         : 5270093.088969 
[ 5270.649716]   .clock_task                    : 5205470.943867 
[ 5270.656724]   .avg_idle                      : 1000000 
[ 5270.663056]   .max_idle_balance_cost         : 500000 
[ 5270.669287] cfs_rq[24]:/autogroup-65 
[ 5270.673864]   .exec_clock                    : 0.000000 
[ 5270.680293]   .MIN_vruntime                  : 0.000001 
[ 5270.686721]   .min_vruntime                  : 81.248945 
[ 5270.693247]   .max_vruntime                  : 0.000001 
[ 5270.699673]   .spread                        : 0.000000 
[ 5270.706098]   .spread0                       : -7105284.875692 
[ 5270.713203]   .nr_spread_over                : 0 
[ 5270.718952]   .nr_running                    : 0 
[ 5270.724698]   .load                          : 0 
[ 5270.730445]   .load_avg                      : 0 
[ 5270.736188]   .runnable_avg                  : 0 
[ 5270.741918]   .util_avg                      : 0 
[ 5270.747627]   .util_est_enqueued             : 0 
[ 5270.753310]   .removed.load_avg              : 0 
[ 5270.758990]   .removed.util_avg              : 0 
[ 5270.764654]   .removed.runnable_avg          : 0 
[ 5270.770306]   .tg_load_avg_contrib           : 0 
[ 5270.775944]   .tg_load_avg                   : 0 
[ 5270.781567]   .throttled                     : 0 
[ 5270.787179]   .throttle_count                : 0 
[ 5270.792777]   .se->exec_start                : 5205437.327808 
[ 5270.799627]   .se->vruntime                  : 6693649.580526 
[ 5270.806466]   .se->sum_exec_runtime          : 87.978588 
[ 5270.812810]   .se->load.weight               : 2 
[ 5270.818367]   .se->avg.load_avg              : 0 
[ 5270.823911]   .se->avg.util_avg              : 0 
[ 5270.829438]   .se->avg.runnable_avg          : 0 
[ 5270.834946] cfs_rq[24]:/ 
[ 5270.838121]   .exec_clock                    : 0.000000 
[ 5270.844298]   .MIN_vruntime                  : 0.000001 
[ 5270.850465]   .min_vruntime                  : 6693661.525246 
[ 5270.857198]   .max_vruntime                  : 0.000001 
[ 5270.863334]   .spread                        : 0.000000 
[ 5270.869461]   .spread0                       : -411704.599391 
[ 5270.876157]   .nr_spread_over                : 0 
[ 5270.881582]   .nr_running                    : 0 
[ 5270.886992]   .load                          : 0 
[ 5270.892399]   .load_avg                      : 0 
[ 5270.897802]   .runnable_avg                  : 0 
[ 5270.903203]   .util_avg                      : 0 
[ 5270.908601]   .util_est_enqueued             : 0 
[ 5270.913996]   .removed.load_avg              : 0 
[ 5270.919391]   .removed.util_avg              : 0 
[ 5270.924782]   .removed.runnable_avg          : 0 
[ 5270.930171]   .tg_load_avg_contrib           : 0 
[ 5270.935561]   .tg_load_avg                   : 0 
[ 5270.940947]   .throttled                     : 0 
[ 5270.946329]   .throttle_count                : 0 
[ 5270.951705] rt_rq[24]:/ 
[ 5270.954654]   .rt_nr_running                 : 0 
[ 5270.960034]   .rt_nr_migratory               : 0 
[ 5270.965410]   .rt_throttled                  : 0 
[ 5270.970787]   .rt_time                       : 0.000000 
[ 5270.976844]   .rt_runtime                    : 950.000000 
[ 5270.983091] dl_rq[24]: 
[ 5270.985941]   .dl_nr_running                 : 0 
[ 5270.991319]   .dl_nr_migratory               : 0 
[ 5270.996698]   .dl_bw->bw                     : 996147 
[ 5271.002564]   .dl_bw->total_bw               : 0 
[ 5271.007947] runnable tasks: 
[ 5271.011290]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5271.023770] ------------------------------------------------------------------------------------------------------------- 
[ 5271.036282]  S        cpuhp/24   131      4813.672746        21   120         0.000000         0.163317         0.000000 0 0 / 
[ 5271.049585]  S    migration/24   132      1238.809046      1388     0         0.000000       449.930079         0.000000 0 0 / 
[ 5271.062941]  S    ksoftirqd/24   133   6693649.525246    149650   120         0.000000        75.677386         0.000000 0 0 / 
[ 5271.076352]  I   kworker/24:0H   135      6902.095471        15   100         0.000000         0.042405         0.000000 0 0 / 
[ 5271.089809]  I      tpm_dev_wq   325        86.711704         2   100         0.000000         0.001931         0.000000 0 0 / 
[ 5271.103307]  I    xfs-log/sda1  1380      4881.050272         2   100         0.000000         0.007458         0.000000 0 0 / 
[ 5271.116854]  S           gmain  1736        81.248945      1313   120         0.000000        23.608983         0.000000 0 0 /autogroup-65 
[ 5271.131608]  I   kworker/24:1H  3216   6693645.602394   3172092   100         0.000000     14106.419509         0.000000 0 0 / 
[ 5271.145248]  I    kworker/24:1 29579   6693649.546851     83083   120         0.000000       179.084860         0.000000 0 0 / 
[ 5271.158944]  I    kworker/24:0 30630   6693274.908398      8414   120         0.000000        26.304364         0.000000 0 0 / 
[ 5271.172693]  S rhts-run-simple 37866        23.842227         3   120         0.000000         0.437809         0.000000 0 0 /autogroup-159 
[ 5271.187754]  S          opensm 38058       -12.099699        40   120         0.000000         0.531662         0.000000 0 0 /autogroup-160 
[ 5271.202880] cpu#25, 2597.006 MHz 
[ 5271.207056]   .nr_running                    : 0 
[ 5271.212786]   .nr_switches                   : 22482053 
[ 5271.219198]   .nr_uninterruptible            : -1032 
[ 5271.225323]   .next_balance                  : 4299.936719 
[ 5271.232034]   .curr->pid                     : 0 
[ 5271.237774]   .clock                         : 5269567.122051 
[ 5271.244780]   .clock_task                    : 5266491.047579 
[ 5271.251788]   .avg_idle                      : 1000000 
[ 5271.258118]   .max_idle_balance_cost         : 500000 
[ 5271.264352] rt_rq[25]:/ 
[ 5271.267668]   .rt_nr_running                 : 0 
[ 5271.273414]   .rt_nr_migratory               : 0 
[ 5271.279159]   .rt_throttled                  : 0 
[ 5271.284904]   .rt_time                       : 0.000000 
[ 5271.291330]   .rt_runtime                    : 950.000000 
[ 5271.297947] dl_rq[25]: 
[ 5271.301165]   .dl_nr_running                 : 0 
[ 5271.306911]   .dl_nr_migratory               : 0 
[ 5271.312655]   .dl_bw->bw                     : 996147 
[ 5271.318876]   .dl_bw->total_bw               : 0 
[ 5271.324619] runnable tasks: 
[ 5271.328311]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5271.341130] ------------------------------------------------------------------------------------------------------------- 
[ 5271.353953]  S        cpuhp/25   136      5063.376459        21   120         0.000000         0.159232         0.000000 1 0 / 
[ 5271.367840]  S    migration/25   137      1294.809053      1363     0         0.000000       450.667191         0.000000 1 0 / 
[ 5271.381725]  S    ksoftirqd/25   138   6428473.796226       247   120         0.000000         3.724532         0.000000 1 0 / 
[ 5271.395607]  I   kworker/25:0H   140      9429.374046        15   100         0.000000         0.030147         0.000000 1 0 / 
[ 5271.409494]  I    kworker/25:1   350   6429275.439719      1905   120         0.000000       208.767156         0.000000 1 0 / 
[ 5271.423388]  I    kworker/25:2   496      9429.374596        17   120         0.000000         0.042757         0.000000 1 0 / 
[ 5271.437285]  I xfs-reclaim/dm-   921       653.413008         2   100         0.000000         0.006542         0.000000 1 0 / 
[ 5271.451175]  I    xfs-buf/sda1  1341      5113.192342         2   100         0.000000         0.007411         0.000000 1 0 / 
[ 5271.465065]  I   kworker/25:1H  3215   6429269.297449   3524647   100         0.000000     13367.132347         0.000000 1 0 / 
[ 5271.478953]  I   nvme-reset-wq 26995     11206.102207         2   100         0.000000         0.006571         0.000000 1 0 / 
[ 5271.492850] cpu#26, 2597.006 MHz 
[ 5271.497022]   .nr_running                    : 0 
[ 5271.502740]   .nr_switches                   : 24298525 
[ 5271.509129]   .nr_uninterruptible            : 1445 
[ 5271.515118]   .next_balance                  : 4299.938665 
[ 5271.521798]   .curr->pid                     : 0 
[ 5271.527499]   .clock                         : 5271527.098214 
[ 5271.534472]   .clock_task                    : 5217094.660501 
[ 5271.541441]   .avg_idle                      : 1000000 
[ 5271.547730]   .max_idle_balance_cost         : 500000 
[ 5271.553925] cfs_rq[26]:/ 
[ 5271.557298]   .exec_clock                    : 0.000000 
[ 5271.563683]   .MIN_vruntime                  : 0.000001 
[ 5271.570067]   .min_vruntime                  : 6431931.529168 
[ 5271.577030]   .max_vruntime                  : 0.000001 
[ 5271.583410]   .spread                        : 0.000000 
[ 5271.589791]   .spread0                       : -673434.595469 
[ 5271.596758]   .nr_spread_over                : 0 
[ 5271.602462]   .nr_running                    : 0 
[ 5271.608168]   .load                          : 0 
[ 5271.613870]   .load_avg                      : 0 
[ 5271.619568]   .runnable_avg                  : 0 
[ 5271.625265]   .util_avg                      : 0 
[ 5271.630962]   .util_est_enqueued             : 0 
[ 5271.636658]   .removed.load_avg              : 0 
[ 5271.642352]   .removed.util_avg              : 0 
[ 5271.648034]   .removed.runnable_avg          : 0 
[ 5271.653696]   .tg_load_avg_contrib           : 0 
[ 5271.659339]   .tg_load_avg                   : 0 
[ 5271.664970]   .throttled                     : 0 
[ 5271.670587]   .throttle_count                : 0 
[ 5271.676193] rt_rq[26]:/ 
[ 5271.679356]   .rt_nr_running                 : 0 
[ 5271.684935]   .rt_nr_migratory               : 0 
[ 5271.690492]   .rt_throttled                  : 0 
[ 5271.696046]   .rt_time                       : 0.000000 
[ 5271.702266]   .rt_runtime                    : 950.000000 
[ 5271.708667] dl_rq[26]: 
[ 5271.711656]   .dl_nr_running                 : 0 
[ 5271.717151]   .dl_nr_migratory               : 0 
[ 5271.722643]   .dl_bw->bw                     : 996147 
[ 5271.728609]   .dl_bw->total_bw               : 0 
[ 5271.734076] runnable tasks: 
[ 5271.737492]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5271.750038] ------------------------------------------------------------------------------------------------------------- 
[ 5271.762587]  I       rcu_sched    12   6431931.559473    874811   120         0.000000      2054.988432         0.000000 0 0 / 
[ 5271.775938]  S        cpuhp/26   141      5958.074561        21   120         0.000000         0.167249         0.000000 0 0 / 
[ 5271.789316]  S    migration/26   142      1350.809036      1401     0         0.000000       451.291755         0.000000 0 0 / 
[ 5271.802736]  S    ksoftirqd/26   143   6431916.076020     94115   120         0.000000       196.669921         0.000000 0 0 / 
[ 5271.816202]  I   kworker/26:0H   145      7567.209480        15   100         0.000000         0.039368         0.000000 0 0 / 
[ 5271.829718]  I    kworker/26:1   352   6431918.748968    217497   120         0.000000       397.132980         0.000000 0 0 / 
[ 5271.843285]  I      srp_remove  1616      6136.979707         2   100         0.000000         0.006730         0.000000 0 0 / 
[ 5271.856889]  I        ipoib_wq  2999      7451.033771         2   100         0.000000         0.008361         0.000000 0 0 / 
[ 5271.870536]  I   kworker/26:1H  3217   6431914.948873   3687784   100         0.000000     15788.156225         0.000000 0 0 / 
[ 5271.884237]  I    kworker/26:0 29828   6341056.470899     13087   120         0.000000        31.329000         0.000000 0 0 / 
[ 5271.897992]  S          opensm 38136        10.433707      1391   120         0.000000        20.753187         0.000000 0 0 /autogroup-160 
[ 5271.913069] cpu#27, 2597.006 MHz 
[ 5271.917221]   .nr_running                    : 0 
[ 5271.922931]   .nr_switches                   : 23158807 
[ 5271.929321]   .nr_uninterruptible            : -1434 
[ 5271.935422]   .next_balance                  : 4299.938980 
[ 5271.942108]   .curr->pid                     : 0 
[ 5271.947827]   .clock                         : 5271832.104414 
[ 5271.954810]   .clock_task                    : 5268733.919631 
[ 5271.961794]   .avg_idle                      : 1000000 
[ 5271.968102]   .max_idle_balance_cost         : 500000 
[ 5271.974314] cfs_rq[27]:/ 
[ 5271.977708]   .exec_clock                    : 0.000000 
[ 5271.984115]   .MIN_vruntime                  : 0.000001 
[ 5271.990521]   .min_vruntime                  : 6238855.680097 
[ 5271.997512]   .max_vruntime                  : 0.000001 
[ 5272.003921]   .spread                        : 0.000000 
[ 5272.010330]   .spread0                       : -866510.444540 
[ 5272.017321]   .nr_spread_over                : 0 
[ 5272.023051]   .nr_running                    : 0 
[ 5272.028778]   .load                          : 0 
[ 5272.034505]   .load_avg                      : 0 
[ 5272.040229]   .runnable_avg                  : 0 
[ 5272.045953]   .util_avg                      : 0 
[ 5272.051674]   .util_est_enqueued             : 0 
[ 5272.057382]   .removed.load_avg              : 0 
[ 5272.063073]   .removed.util_avg              : 0 
[ 5272.068745]   .removed.runnable_avg          : 0 
[ 5272.074400]   .tg_load_avg_contrib           : 0 
[ 5272.080047]   .tg_load_avg                   : 0 
[ 5272.085680]   .throttled                     : 0 
[ 5272.091299]   .throttle_count                : 0 
[ 5272.096906] rt_rq[27]:/ 
[ 5272.100070]   .rt_nr_running                 : 0 
[ 5272.105641]   .rt_nr_migratory               : 0 
[ 5272.111198]   .rt_throttled                  : 0 
[ 5272.116750]   .rt_time                       : 0.000000 
[ 5272.122968]   .rt_runtime                    : 950.000000 
[ 5272.129368] dl_rq[27]: 
[ 5272.132349]   .dl_nr_running                 : 0 
[ 5272.137845]   .dl_nr_migratory               : 0 
[ 5272.143337]   .dl_bw->bw                     : 996147 
[ 5272.149305]   .dl_bw->total_bw               : 0 
[ 5272.154770] runnable tasks: 
[ 5272.158180]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5272.170723] ------------------------------------------------------------------------------------------------------------- 
[ 5272.183273]  S        cpuhp/27   146      4877.602105        21   120         0.000000         0.207962         0.000000 1 0 / 
[ 5272.196618]  S    migration/27   147      1406.809045      1379     0         0.000000       453.057496         0.000000 1 0 / 
[ 5272.209991]  S    ksoftirqd/27   148   6237922.431723       725   120         0.000000         9.199820         0.000000 1 0 / 
[ 5272.223414]  I   kworker/27:0H   150      8319.478748        15   100         0.000000         0.024799         0.000000 1 0 / 
[ 5272.236880]  I    kworker/27:1   351   6238843.648318      2743   120         0.000000        11.366136         0.000000 1 0 / 
[ 5272.250394]  I xfs-eofblocks/d   922      1431.075605         2   100         0.000000         0.005640         0.000000 1 0 / 
[ 5272.263952]  I        iscsi_eh  1316      5146.901210         2   100         0.000000         0.006854         0.000000 1 0 / 
[ 5272.277538]  I    kworker/27:2  1647      8307.029059         5   120         0.000000         0.012788         0.000000 1 0 / 
[ 5272.291181]  I   kworker/27:1H  3218   6238843.680141   3603868   100         0.000000     13352.932006         0.000000 1 0 / 
[ 5272.304877]  I   kworker/u80:0 41701   6238845.905047    427587   120         0.000000      1455.782565         0.000000 1 0 / 
[ 5272.318636] cpu#28, 2597.006 MHz 
[ 5272.322751]   .nr_running                    : 0 
[ 5272.328424]   .nr_switches                   : 22587448 
[ 5272.334788]   .nr_uninterruptible            : 1236 
[ 5272.340766]   .next_balance                  : 4299.934152 
[ 5272.347428]   .curr->pid                     : 0 
[ 5272.353121]   .clock                         : 5272288.104569 
[ 5272.360077]   .clock_task                    : 5225295.301865 
[ 5272.367035]   .avg_idle                      : 1000000 
[ 5272.373317]   .max_idle_balance_cost         : 500000 
[ 5272.379502] cfs_rq[28]:/ 
[ 5272.382870]   .exec_clock                    : 0.000000 
[ 5272.389251]   .MIN_vruntime                  : 0.000001 
[ 5272.395635]   .min_vruntime                  : 6647875.243197 
[ 5272.402602]   .max_vruntime                  : 0.000001 
[ 5272.408984]   .spread                        : 0.000000 
[ 5272.415367]   .spread0                       : -457490.881440 
[ 5272.422334]   .nr_spread_over                : 0 
[ 5272.428040]   .nr_running                    : 0 
[ 5272.433747]   .load                          : 0 
[ 5272.439450]   .load_avg                      : 0 
[ 5272.445151]   .runnable_avg                  : 0 
[ 5272.450851]   .util_avg                      : 0 
[ 5272.456552]   .util_est_enqueued             : 0 
[ 5272.462250]   .removed.load_avg              : 0 
[ 5272.467948]   .removed.util_avg              : 0 
[ 5272.473631]   .removed.runnable_avg          : 0 
[ 5272.479295]   .tg_load_avg_contrib           : 0 
[ 5272.484942]   .tg_load_avg                   : 0 
[ 5272.490577]   .throttled                     : 0 
[ 5272.496196]   .throttle_count                : 0 
[ 5272.501802] rt_rq[28]:/ 
[ 5272.504967]   .rt_nr_running                 : 0 
[ 5272.510550]   .rt_nr_migratory               : 0 
[ 5272.516119]   .rt_throttled                  : 0 
[ 5272.521676]   .rt_time                       : 0.000000 
[ 5272.527899]   .rt_runtime                    : 950.000000 
[ 5272.534301] dl_rq[28]: 
[ 5272.537293]   .dl_nr_running                 : 0 
[ 5272.542800]   .dl_nr_migratory               : 0 
[ 5272.548295]   .dl_bw->bw                     : 996147 
[ 5272.554266]   .dl_bw->total_bw               : 0 
[ 5272.559737] runnable tasks: 
[ 5272.563157]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5272.575708] ------------------------------------------------------------------------------------------------------------- 
[ 5272.588267]  S        cpuhp/28   151      5072.392421        21   120         0.000000         0.157602         0.000000 0 0 / 
[ 5272.601616]  S    migration/28   152      1462.809026      1402     0         0.000000       454.702461         0.000000 0 0 / 
[ 5272.614991]  S    ksoftirqd/28   153   6647863.243197     36512   120         0.000000        74.083903         0.000000 0 0 / 
[ 5272.628416]  I   kworker/28:0H   155      1011.740624        10   100         0.000000         0.020395         0.000000 0 0 / 
[ 5272.641885]  I        kthrotld   374       327.315905         2   100         0.000000         0.005459         0.000000 0 0 / 
[ 5272.655390]  I    zswap-shrink   426       508.649331         2   100         0.000000         0.005266         0.000000 0 0 / 
[ 5272.668940]  I   kworker/28:1H   926   6647863.244651   3801421   100         0.000000     16046.858473         0.000000 0 0 / 
[ 5272.682527]  I        ipoib_wq  1448      5257.174286         2   100         0.000000         0.007465         0.000000 0 0 / 
[ 5272.696166]  I target_completi  1624      5299.631168         2   100         0.000000         0.005982         0.000000 0 0 / 
[ 5272.709854]  S         chronyd  1693         0.544923       597   120         0.000000        23.191152         0.000000 0 0 /autogroup-68 
[ 5272.724750]  S           tuned  2244      1079.497536         3   120         0.000000         0.585297         0.000000 0 0 /autogroup-72 
[ 5272.739688]  S        gssproxy  1806        10.957992         1   120         0.000000         0.006577         0.000000 0 0 /autogroup-79 
[ 5272.754667]  I        ipoib_wq  2832      6685.550227         2   100         0.000000         0.007685         0.000000 0 0 / 
[ 5272.768537]  S          agetty  3162         0.403851        11   120         0.000000        32.709873         0.000000 0 0 /autogroup-92 
[ 5272.783618]  S        (sd-pam)  3168        24.882087         1   120         0.000000         0.138556         0.000000 0 0 /autogroup-89 
[ 5272.798745]  S            sshd 15745        11.891582        40   120         0.000000        12.225450         0.000000 0 0 /autogroup-103 
[ 5272.814014]  I    kworker/28:1 29207   6647863.329245     92854   120         0.000000       194.323185         0.000000 0 0 / 
[ 5272.828078]  I    kworker/28:0 30629   6297677.425443      3355   120         0.000000         9.090029         0.000000 0 0 / 
[ 5272.842193]  S   opensm-launch 38049        11.177021         1   120         0.000000         0.225605         0.000000 0 0 /autogroup-160 
[ 5272.857624]  S          opensm 38052        83.638945        37   120         0.000000         0.549517         0.000000 0 0 /autogroup-160 
[ 5272.873097]  S          opensm 38059        83.883510        38   120         0.000000         0.595037         0.000000 0 0 /autogroup-160 
[ 5272.888611]  S          opensm 38060        83.763508        39   120         0.000000         0.600121         0.000000 0 0 /autogroup-160 
[ 5272.904165]  S          opensm 38061        95.529771        37   120         0.000000         0.727988         0.000000 0 0 /autogroup-160 
[ 5272.919750]  S          opensm 38063        83.575184        37   120         0.000000         0.489337         0.000000 0 0 /autogroup-160 
[ 5272.935309]  S          opensm 38064        83.816570        38   120         0.000000         0.563127         0.000000 0 0 /autogroup-160 
[ 5272.950858]  S          opensm 38065        83.559583        38   120         0.000000         0.515777         0.000000 0 0 /autogroup-160 
[ 5272.966398]  S          opensm 38067        83.545801        38   120         0.000000         0.467021         0.000000 0 0 /autogroup-160 
[ 5272.981929]  S          opensm 38068        83.570999        38   120         0.000000         0.802037         0.000000 0 0 /autogroup-160 
[ 5272.997456]  S          opensm 38071        83.601756        39   120         0.000000         0.561315         0.000000 0 0 /autogroup-160 
[ 5273.012980]  S          opensm 38073        83.640249        38   120         0.000000         0.548855         0.000000 0 0 /autogroup-160 
[ 5273.028499]  S          opensm 38075        83.762063        39   120         0.000000         0.614263         0.000000 0 0 /autogroup-160 
[ 5273.044006]  S          opensm 38078        83.696386        39   120         0.000000         0.490779         0.000000 0 0 /autogroup-160 
[ 5273.059507]  S          opensm 38080        83.549661        37   120         0.000000         0.464532         0.000000 0 0 /autogroup-160 
[ 5273.075002]  S          opensm 38082        83.598940        37   120         0.000000         0.538256         0.000000 0 0 /autogroup-160 
[ 5273.090497]  S          opensm 38084        83.677753        37   120         0.000000         0.462838         0.000000 0 0 /autogroup-160 
[ 5273.105983]  S          opensm 38085        95.281629        38   120         0.000000         0.539791         0.000000 0 0 /autogroup-160 
[ 5273.121479]  S          opensm 38088        95.379960        38   120         0.000000         0.602985         0.000000 0 0 /autogroup-160 
[ 5273.136974]  S          opensm 38089        83.557934        38   120         0.000000         0.534102         0.000000 0 0 /autogroup-160 
[ 5273.152468]  S          opensm 38090        83.614788        36   120         0.000000         0.512598         0.000000 0 0 /autogroup-160 
[ 5273.167962]  S          opensm 38092        95.501895        38   120         0.000000         0.468685         0.000000 0 0 /autogroup-160 
[ 5273.183452]  S          opensm 38093        95.491443        36   120         0.000000         0.467944         0.000000 0 0 /autogroup-160 
[ 5273.198933]  I   kworker/u81:3 41058   6647863.800617   1676817   120         0.000000      3524.339471         0.000000 0 0 / 
[ 5273.213164] cpu#29, 2597.006 MHz 
[ 5273.217506]   .nr_running                    : 0 
[ 5273.223395]   .nr_switches                   : 23694731 
[ 5273.229953]   .nr_uninterruptible            : -880 
[ 5273.236113]   .next_balance                  : 4299.930112 
[ 5273.242947]   .curr->pid                     : 0 
[ 5273.248799]   .clock                         : 5272852.111684 
[ 5273.255904]   .clock_task                    : 5269699.401885 
[ 5273.263001]   .avg_idle                      : 1000000 
[ 5273.269408]   .max_idle_balance_cost         : 500000 
[ 5273.275708] cfs_rq[29]:/ 
[ 5273.279178]   .exec_clock                    : 0.000000 
[ 5273.285650]   .MIN_vruntime                  : 0.000001 
[ 5273.292111]   .min_vruntime                  : 6308260.697853 
[ 5273.299146]   .max_vruntime                  : 0.000001 
[ 5273.305586]   .spread                        : 0.000000 
[ 5273.312006]   .spread0                       : -797105.426784 
[ 5273.319007]   .nr_spread_over                : 0 
[ 5273.324737]   .nr_running                    : 0 
[ 5273.330456]   .load                          : 0 
[ 5273.336162]   .load_avg                      : 0 
[ 5273.341855]   .runnable_avg                  : 0 
[ 5273.347536]   .util_avg                      : 0 
[ 5273.353209]   .util_est_enqueued             : 0 
[ 5273.358867]   .removed.load_avg              : 0 
[ 5273.364517]   .removed.util_avg              : 0 
[ 5273.370152]   .removed.runnable_avg          : 0 
[ 5273.375775]   .tg_load_avg_contrib           : 0 
[ 5273.381381]   .tg_load_avg                   : 0 
[ 5273.386983]   .throttled                     : 0 
[ 5273.392572]   .throttle_count                : 0 
[ 5273.398152] rt_rq[29]:/ 
[ 5273.401291]   .rt_nr_running                 : 0 
[ 5273.406850]   .rt_nr_migratory               : 0 
[ 5273.412396]   .rt_throttled                  : 0 
[ 5273.417930]   .rt_time                       : 0.000000 
[ 5273.424135]   .rt_runtime                    : 950.000000 
[ 5273.430523] dl_rq[29]: 
[ 5273.433502]   .dl_nr_running                 : 0 
[ 5273.438996]   .dl_nr_migratory               : 0 
[ 5273.444478]   .dl_bw->bw                     : 996147 
[ 5273.450437]   .dl_bw->total_bw               : 0 
[ 5273.455899] runnable tasks: 
[ 5273.459310]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5273.471856] ------------------------------------------------------------------------------------------------------------- 
[ 5273.484412]  S        cpuhp/29   156      5400.744223        21   120         0.000000         0.203365         0.000000 1 0 / 
[ 5273.497755]  S    migration/29   157      1518.809032      1392     0         0.000000       455.496933         0.000000 1 0 / 
[ 5273.511127]  S    ksoftirqd/29   158   6307860.509416       965   120         0.000000        19.125890         0.000000 1 0 / 
[ 5273.524547]  I   kworker/29:0H   160      5657.521585        15   100         0.000000         0.030015         0.000000 1 0 / 
[ 5273.538015]  I        mlx5_lag   768       682.827065         2   100         0.000000         0.006034         0.000000 1 0 / 
[ 5273.551518]  I    xfs-log/dm-0   923       925.846651         2   100         0.000000         0.005302         0.000000 1 0 / 
[ 5273.565061]  I   kworker/29:1H  1642   6308246.803541   3667477   100         0.000000     13696.161602         0.000000 1 0 / 
[ 5273.578652]  S           gdbus  1762         0.777003       268   120         0.000000        18.150966         0.000000 1 0 /autogroup-64 
[ 5273.593455]  S  systemd-logind  1840         2.543211      8601   120         0.000000       427.412670         0.000000 1 0 /autogroup-81 
[ 5273.608305]  I   kworker/u80:8  2747   6308260.697853   2749214   120         0.000000      9419.592219         0.000000 1 0 / 
[ 5273.622045]  S         systemd  3157         9.682388      1239   120         0.000000       342.449623         0.000000 1 0 /autogroup-89 
[ 5273.637000]  I  nvme-delete-wq 26996     17989.049060         2   100         0.000000         0.006475         0.000000 1 0 / 
[ 5273.650847]  I    kworker/29:2 29849   6308246.839858      3831   120         0.000000        10.776208         0.000000 1 0 / 
[ 5273.664751]  I    kworker/29:0 38585   6302583.240438         2   120         0.000000         0.005266         0.000000 1 0 / 
[ 5273.678718] cpu#30, 2597.006 MHz 
[ 5273.682946]   .nr_running                    : 0 
[ 5273.688731]   .nr_switches                   : 20252647 
[ 5273.695198]   .nr_uninterruptible            : 2236 
[ 5273.701280]   .next_balance                  : 4299.927565 
[ 5273.708048]   .curr->pid                     : 0 
[ 5273.713843]   .clock                         : 5272272.105606 
[ 5273.720902]   .clock_task                    : 5211554.516202 
[ 5273.727962]   .avg_idle                      : 1000000 
[ 5273.734345]   .max_idle_balance_cost         : 500000 
[ 5273.740634] rt_rq[30]:/ 
[ 5273.744005]   .rt_nr_running                 : 0 
[ 5273.749804]   .rt_nr_migratory               : 0 
[ 5273.755599]   .rt_throttled                  : 0 
[ 5273.761394]   .rt_time                       : 0.000000 
[ 5273.767870]   .rt_runtime                    : 950.000000 
[ 5273.774541] dl_rq[30]: 
[ 5273.777809]   .dl_nr_running                 : 0 
[ 5273.783596]   .dl_nr_migratory               : 0 
[ 5273.789361]   .dl_bw->bw                     : 996147 
[ 5273.795595]   .dl_bw->total_bw               : 0 
[ 5273.801330] runnable tasks: 
[ 5273.805014]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5273.817830] ------------------------------------------------------------------------------------------------------------- 
[ 5273.830654]  S        cpuhp/30   161      3325.290807        21   120         0.000000         0.164144         0.000000 0 0 / 
[ 5273.844543]  S    migration/30   162         0.000000      1400     0         0.000000       456.051396         0.000000 0 0 / 
[ 5273.858433]  S    ksoftirqd/30   163   6358436.769674     96123   120         0.000000        85.660478         0.000000 0 0 / 
[ 5273.872330]  I   kworker/30:0H   165       546.360601        10   100         0.000000         0.045394         0.000000 0 0 / 
[ 5273.886229]  I              md   326        59.857298         2   100         0.000000         0.001648         0.000000 0 0 / 
[ 5273.900112]  I    kworker/30:1   331   6358582.905892    211735   120         0.000000       402.796191         0.000000 0 0 / 
[ 5273.914002]  S       scsi_eh_0   665       167.882477        30   120         0.000000         0.113067         0.000000 0 0 / 
[ 5273.927886]  I      scsi_tmf_0   666       129.068613         2   100         0.000000         0.006167         0.000000 0 0 / 
[ 5273.941757]  S       scsi_eh_1   667       167.863298        27   120         0.000000         0.063856         0.000000 0 0 / 
[ 5273.955628]  I mlx5_page_alloc   700       179.804260         2   100         0.000000         0.005873         0.000000 0 0 / 
[ 5273.969487]  I   kworker/30:1H   925   6358582.893257   3296142   100         0.000000     14451.644777         0.000000 0 0 / 
[ 5273.983359]  I        xcopy_wq  1625      3535.849043         2   100         0.000000         0.006241         0.000000 0 0 / 
[ 5273.997236]  S       JS Helper  1766        10.999231         4   120         0.000000         0.047814         0.000000 0 0 /autogroup-64 
[ 5274.012321]  S           gmain  3624      5969.547432        46   120         0.000000         1.189021         0.000000 0 0 /autogroup-96 
[ 5274.027442]  S            make 37831        13.232103        39   120         0.000000        14.988641         0.000000 0 0 /autogroup-159 
[ 5274.042692]  S          opensm 38069         3.384402        38   120         0.000000         0.561670         0.000000 0 0 /autogroup-160 
[ 5274.057979]  S          opensm 38072         3.335762        41   120         0.000000         0.510120         0.000000 0 0 /autogroup-160 
[ 5274.073293]  S          opensm 38074         3.325613        38   120         0.000000         0.473146         0.000000 0 0 /autogroup-160 
[ 5274.088643]  S          opensm 38086         3.282142        37   120         0.000000         0.505725         0.000000 0 0 /autogroup-160 
[ 5274.104049]  I    kworker/30:2 41791   6358582.963012      1069   120         0.000000         4.714844         0.000000 0 0 / 
[ 5274.118238]  I    kworker/30:0 42377   6358594.893957         2   120         0.000000         0.004688         0.000000 0 0 / 
[ 5274.132485] cpu#31, 2597.006 MHz 
[ 5274.136854]   .nr_running                    : 0 
[ 5274.142779]   .nr_switches                   : 21962664 
[ 5274.149384]   .nr_uninterruptible            : -1608 
[ 5274.155686]   .next_balance                  : 4299.927628 
[ 5274.162557]   .curr->pid                     : 0 
[ 5274.168436]   .clock                         : 5272273.108188 
[ 5274.175572]   .clock_task                    : 5269128.807798 
[ 5274.182695]   .avg_idle                      : 1000000 
[ 5274.189128]   .max_idle_balance_cost         : 500000 
[ 5274.195453] rt_rq[31]:/ 
[ 5274.198848]   .rt_nr_running                 : 0 
[ 5274.204659]   .rt_nr_migratory               : 0 
[ 5274.210456]   .rt_throttled                  : 0 
[ 5274.216244]   .rt_time                       : 0.000000 
[ 5274.222701]   .rt_runtime                    : 950.000000 
[ 5274.229340] dl_rq[31]: 
[ 5274.232566]   .dl_nr_running                 : 0 
[ 5274.238306]   .dl_nr_migratory               : 0 
[ 5274.244036]   .dl_bw->bw                     : 996147 
[ 5274.250241]   .dl_bw->total_bw               : 0 
[ 5274.255948] runnable tasks: 
[ 5274.259604]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5274.272384] ------------------------------------------------------------------------------------------------------------- 
[ 5274.285183]  S        cpuhp/31   166      3969.870611        21   120         0.000000         0.154061         0.000000 1 0 / 
[ 5274.299019]  S    migration/31   167      1630.814190      1375     0         0.000000       456.952777         0.000000 1 0 / 
[ 5274.312841]  S    ksoftirqd/31   168   6040491.099329       835   120         0.000000         6.779689         0.000000 1 0 / 
[ 5274.326677]  I    kworker/31:0   169        31.574529        21   120         0.000000         0.013605         0.000000 1 0 / 
[ 5274.340518]  I   kworker/31:0H   170      8168.620463        15   100         0.000000         0.029852         0.000000 1 0 / 
[ 5274.354364]  I   kworker/u82:9   231   6040491.389437   2608519   120         0.000000      6100.197987         0.000000 1 0 / 
[ 5274.368225]  I    kworker/31:1   354   6040514.286996      3063   120         0.000000       179.869853         0.000000 1 0 / 
[ 5274.382100]  I  mlx5_fw_tracer   753       591.580911         2   100         0.000000         0.005678         0.000000 1 0 / 
[ 5274.395981]  I     mlx5_events   760       603.585186         2   100         0.000000         0.005078         0.000000 1 0 / 
[ 5274.409870]  I        ib_mcast  1260      3998.945731         2   100         0.000000         0.006729         0.000000 1 0 / 
[ 5274.423762]  I   kworker/31:1H  3219   6040512.782011   3592977   100         0.000000     13443.464910         0.000000 1 0 / 
[ 5274.437665] cpu#32, 2597.006 MHz 
[ 5274.441839]   .nr_running                    : 0 
[ 5274.447570]   .nr_switches                   : 21354465 
[ 5274.453980]   .nr_uninterruptible            : 1856 
[ 5274.460001]   .next_balance                  : 4299.941608 
[ 5274.466704]   .curr->pid                     : 0 
[ 5274.472434]   .clock                         : 5274472.118196 
[ 5274.479426]   .clock_task                    : 5213834.146442 
[ 5274.486419]   .avg_idle                      : 1000000 
[ 5274.492733]   .max_idle_balance_cost         : 500000 
[ 5274.498950] rt_rq[32]:/ 
[ 5274.502247]   .rt_nr_running                 : 0 
[ 5274.507969]   .rt_nr_migratory               : 0 
[ 5274.513691]   .rt_throttled                  : 0 
[ 5274.519414]   .rt_time                       : 0.000000 
[ 5274.525817]   .rt_runtime                    : 950.000000 
[ 5274.532414] dl_rq[32]: 
[ 5274.535612]   .dl_nr_running                 : 0 
[ 5274.541327]   .dl_nr_migratory               : 0 
[ 5274.547048]   .dl_bw->bw                     : 996147 
[ 5274.553258]   .dl_bw->total_bw               : 0 
[ 5274.558980] runnable tasks: 
[ 5274.562662]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5274.575489] ------------------------------------------------------------------------------------------------------------- 
[ 5274.588324]  S        kthreadd     2   6472010.296322       754   120         0.000000        15.641747         0.000000 0 0 / 
[ 5274.602224]  S        cpuhp/32   171      2266.867719        21   120         0.000000         0.154640         0.000000 0 0 / 
[ 5274.616114]  S    migration/32   172      1686.814164      1390     0         0.000000       458.637143         0.000000 0 0 / 
[ 5274.630001]  S    ksoftirqd/32   173   6472003.893858    227280   120         0.000000        39.763701         0.000000 0 0 / 
[ 5274.643892]  I   kworker/32:0H   175       963.734123        10   100         0.000000         0.018008         0.000000 0 0 / 
[ 5274.657788]  I acpi_thermal_pm   382       194.073229         2   100         0.000000         0.005981         0.000000 0 0 / 
[ 5274.671683]  I   kworker/32:1H  1009   6472010.079769   2799270   100         0.000000     12787.712157         0.000000 0 0 / 
[ 5274.685576]  S      irqbalance  1681       561.868081       537   120         0.000000       922.051823         0.000000 0 0 /autogroup-60 
[ 5274.700633]  S       JS Helper  1769        23.270128         4   120         0.000000         0.075305         0.000000 0 0 /autogroup-64 
[ 5274.715689]  S         polkitd  1801        35.331883         4   120         0.000000         0.061764         0.000000 0 0 /autogroup-64 
[ 5274.730743]  I           mlx5e  2328      3142.003021         2   100         0.000000         0.007898         0.000000 0 0 / 
[ 5274.744625]  S          opensm 38056        11.499955        39   120         0.000000         0.514343         0.000000 0 0 /autogroup-160 
[ 5274.759763]  S          opensm 38077        11.520553        40   120         0.000000         0.551766         0.000000 0 0 /autogroup-160 
[ 5274.774937]  S          opensm 38079        23.470398        38   120         0.000000         0.513388         0.000000 0 0 /autogroup-160 
[ 5274.790150]  I   kworker/u81:2 39602   6472022.089124   5092296   120         0.000000     11173.835264         0.000000 0 0 / 
[ 5274.804145]  S         anacron 40358         2.259908         7   120         0.000000         3.473817         0.000000 0 0 /autogroup-164 
[ 5274.819449]  I    kworker/32:1 41443   6471835.681112         5   120         0.000000         0.015914         0.000000 0 0 / 
[ 5274.833529]  I    kworker/32:2 41921   6472010.128224       615   120         0.000000         3.653706         0.000000 0 0 / 
[ 5274.847667] cpu#33, 2597.006 MHz 
[ 5274.851982]   .nr_running                    : 0 
[ 5274.857854]   .nr_switches                   : 23744861 
[ 5274.864407]   .nr_uninterruptible            : -1022 
[ 5274.870668]   .next_balance                  : 4299.927628 
[ 5274.877511]   .curr->pid                     : 0 
[ 5274.883379]   .clock                         : 5272275.107949 
[ 5274.890519]   .clock_task                    : 5268967.075169 
[ 5274.897661]   .avg_idle                      : 1000000 
[ 5274.904122]   .max_idle_balance_cost         : 500000 
[ 5274.910479] rt_rq[33]:/ 
[ 5274.913898]   .rt_nr_running                 : 0 
[ 5274.919726]   .rt_nr_migratory               : 0 
[ 5274.925544]   .rt_throttled                  : 0 
[ 5274.931349]   .rt_time                       : 0.000000 
[ 5274.937822]   .rt_runtime                    : 950.000000 
[ 5274.944476] dl_rq[33]: 
[ 5274.947718]   .dl_nr_running                 : 0 
[ 5274.953475]   .dl_nr_migratory               : 0 
[ 5274.959218]   .dl_bw->bw                     : 996147 
[ 5274.965433]   .dl_bw->total_bw               : 0 
[ 5274.971150] runnable tasks: 
[ 5274.974816]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5274.987617] ------------------------------------------------------------------------------------------------------------- 
[ 5275.000422]  S        cpuhp/33   176      5140.018498        21   120         0.000000         0.161773         0.000000 1 0 / 
[ 5275.014270]  S    migration/33   177      1742.814167      1378     0         0.000000       459.651720         0.000000 1 0 / 
[ 5275.028119]  S    ksoftirqd/33   178   6269845.097925       870   120         0.000000         7.743683         0.000000 1 0 / 
[ 5275.041977]  I   kworker/33:0H   180       753.307582        10   100         0.000000         0.014347         0.000000 1 0 / 
[ 5275.055841]  I    kworker/33:1   355   6271132.174463      3268   120         0.000000        98.526858         0.000000 1 0 / 
[ 5275.069715]  I  mlx5_fw_tracer   711       460.304400         2   100         0.000000         0.006339         0.000000 1 0 / 
[ 5275.083596]  I     mlx5_events   736       472.313518         2   100         0.000000         0.005858         0.000000 1 0 / 
[ 5275.097480]  I     mlx5_esw_wq   761       496.326155         2   100         0.000000         0.004879         0.000000 1 0 / 
[ 5275.111365]  I   kworker/33:1H  1027   6271132.174761   3542066   100         0.000000     13454.513954         0.000000 1 0 / 
[ 5275.125247]  I        kdmflush  1213      4346.126832         2   100         0.000000         0.007381         0.000000 1 0 / 
[ 5275.139135]  S          auditd  1639         4.119611        39   116         0.000000         0.622760         0.000000 1 0 /autogroup-56 
[ 5275.154175]  I    kworker/33:0 37506   6264219.009081         2   120         0.000000         0.006511         0.000000 1 0 / 
[ 5275.168071] cpu#34, 2597.006 MHz 
[ 5275.172257]   .nr_running                    : 0 
[ 5275.178000]   .nr_switches                   : 34296236 
[ 5275.184425]   .nr_uninterruptible            : 864 
[ 5275.190362]   .next_balance                  : 4299.942341 
[ 5275.197077]   .curr->pid                     : 0 
[ 5275.202820]   .clock                         : 5275202.123339 
[ 5275.209827]   .clock_task                    : 5179282.044268 
[ 5275.216835]   .avg_idle                      : 1000000 
[ 5275.223163]   .max_idle_balance_cost         : 500000 
[ 5275.229393] rt_rq[34]:/ 
[ 5275.232703]   .rt_nr_running                 : 0 
[ 5275.238446]   .rt_nr_migratory               : 0 
[ 5275.244185]   .rt_throttled                  : 0 
[ 5275.249924]   .rt_time                       : 0.000000 
[ 5275.256344]   .rt_runtime                    : 950.000000 
[ 5275.262954] dl_rq[34]: 
[ 5275.266166]   .dl_nr_running                 : 0 
[ 5275.271905]   .dl_nr_migratory               : 0 
[ 5275.277645]   .dl_bw->bw                     : 996147 
[ 5275.283870]   .dl_bw->total_bw               : 0 
[ 5275.289607] runnable tasks: 
[ 5275.293293]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5275.306107] ------------------------------------------------------------------------------------------------------------- 
[ 5275.318914]  S        cpuhp/34   181      4919.749946        21   120         0.000000         0.168467         0.000000 0 0 / 
[ 5275.332787]  S    migration/34   182      1798.814141      1392     0         0.000000       460.879978         0.000000 0 0 / 
[ 5275.346659]  S    ksoftirqd/34   183   6768647.803604     72535   120         0.000000        77.961777         0.000000 0 0 / 
[ 5275.360533]  I   kworker/34:0H   185      1058.379413        10   100         0.000000         0.025807         0.000000 0 0 / 
[ 5275.374410]  I          cryptd   276        60.968543         2   100         0.000000         0.000000         0.000000 0 0 / 
[ 5275.388280]  I   kworker/34:1H  1155   6768715.205976   2975125   100         0.000000     13098.869677         0.000000 0 0 / 
[ 5275.402146]  S         polkitd  1686        23.705704       383   120         0.000000        37.737646         0.000000 0 0 /autogroup-64 
[ 5275.417189]  S       JS Helper  1764        11.004987         4   120         0.000000         0.053570         0.000000 0 0 /autogroup-64 
[ 5275.432218]  S        gssproxy  1796         1.319037         9   120         0.000000         2.522462         0.000000 0 0 /autogroup-79 
[ 5275.447240]  I        ipoib_wq  2329      5727.312527         2   100         0.000000         0.008334         0.000000 0 0 / 
[ 5275.461097]  I           mlx5e  2415      6241.331462         2   100         0.000000         0.010149         0.000000 0 0 / 
[ 5275.474953]  I   kworker/u84:2  3136   6765223.404441     52688   100         0.000000       532.258500         0.000000 0 0 / 
[ 5275.488824]  I    kworker/34:1 30640   6768780.756135     20381   120         0.000000        41.659395         0.000000 0 0 / 
[ 5275.502745]  D   kworker/u81:1 38181   6768780.739983   4347198   120         0.000000      9238.458174         0.000000 0 0 / 
[ 5275.516715]  I    kworker/34:2 41325   6764785.147355         2   120         0.000000         0.004335         0.000000 0 0 / 
[ 5275.530739] cpu#35, 2597.006 MHz 
[ 5275.534994]   .nr_running                    : 0 
[ 5275.540804]   .nr_switches                   : 23863895 
[ 5275.547293]   .nr_uninterruptible            : -1295 
[ 5275.553488]   .next_balance                  : 4299.927628 
[ 5275.560268]   .curr->pid                     : 0 
[ 5275.566080]   .clock                         : 5272277.109993 
[ 5275.573159]   .clock_task                    : 5268912.425289 
[ 5275.580238]   .avg_idle                      : 1000000 
[ 5275.586639]   .max_idle_balance_cost         : 500000 
[ 5275.592943] rt_rq[35]:/ 
[ 5275.596329]   .rt_nr_running                 : 0 
[ 5275.602143]   .rt_nr_migratory               : 0 
[ 5275.607957]   .rt_throttled                  : 0 
[ 5275.613769]   .rt_time                       : 0.000000 
[ 5275.620262]   .rt_runtime                    : 950.000000 
[ 5275.626938] dl_rq[35]: 
[ 5275.630195]   .dl_nr_running                 : 0 
[ 5275.635962]   .dl_nr_migratory               : 0 
[ 5275.641716]   .dl_bw->bw                     : 996147 
[ 5275.647946]   .dl_bw->total_bw               : 0 
[ 5275.653676] runnable tasks: 
[ 5275.657351]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5275.670158] ------------------------------------------------------------------------------------------------------------- 
[ 5275.682975]  S        cpuhp/35   186      7593.051960        21   120         0.000000         0.158136         0.000000 1 0 / 
[ 5275.696851]  S    migration/35   187      1854.814143      1423     0         0.000000       462.229020         0.000000 1 0 / 
[ 5275.710731]  S    ksoftirqd/35   188   6127645.503543       886   120         0.000000         7.321866         0.000000 1 0 / 
[ 5275.724604]  I   kworker/35:0H   190     10022.132908        15   100         0.000000         0.027478         0.000000 1 0 / 
[ 5275.738485]  I    kworker/35:1   357     17261.852682      1372   120         0.000000         6.001586         0.000000 1 0 / 
[ 5275.752373]  I    mlx5_hv_vhca   712      2797.127015         2   100         0.000000         0.005632         0.000000 1 0 / 
[ 5275.766265]  I  mlx5_fw_tracer   737      2809.131240         2   100         0.000000         0.004905         0.000000 1 0 / 
[ 5275.780162]  I     mlx5_events   751      2821.136047         2   100         0.000000         0.005481         0.000000 1 0 / 
[ 5275.794061]  I  mlx5_fw_tracer   762      2833.140656         2   100         0.000000         0.005312         0.000000 1 0 / 
[ 5275.807949]  I           mlx5e   770      2845.145753         2   100         0.000000         0.005735         0.000000 1 0 / 
[ 5275.821827]  I        kdmflush   888      3142.749039         2   100         0.000000         0.006531         0.000000 1 0 / 
[ 5275.835692]  I        xfsalloc   915      3154.753319         2   100         0.000000         0.005277         0.000000 1 0 / 
[ 5275.849558]  I    xfs-buf/dm-2  1340      7642.150617         2   100         0.000000         0.006407         0.000000 1 0 / 
[ 5275.863466]  S           tuned  2080         7.191335      1053   120         0.000000       312.277362         0.000000 1 0 /autogroup-72 
[ 5275.878580]  I   kworker/35:1H  3220   6128273.410021   3628235   100         0.000000     13476.196564         0.000000 1 0 / 
[ 5275.892575]  I    kworker/35:0 28275   6128273.412899      2058   120         0.000000         7.371847         0.000000 1 0 / 
[ 5275.906634] cpu#36, 2597.006 MHz 
[ 5275.910904]   .nr_running                    : 0 
[ 5275.916725]   .nr_switches                   : 23943961 
[ 5275.923229]   .nr_uninterruptible            : 1305 
[ 5275.929347]   .next_balance                  : 4299.927565 
[ 5275.936148]   .curr->pid                     : 0 
[ 5275.941980]   .clock                         : 5275832.133274 
[ 5275.949077]   .clock_task                    : 5214085.647485 
[ 5275.956171]   .avg_idle                      : 1000000 
[ 5275.962584]   .max_idle_balance_cost         : 500000 
[ 5275.968902] cfs_rq[36]:/ 
[ 5275.972402]   .exec_clock                    : 0.000000 
[ 5275.978915]   .MIN_vruntime                  : 0.000001 
[ 5275.985428]   .min_vruntime                  : 6381638.832822 
[ 5275.992512]   .max_vruntime                  : 0.000001 
[ 5275.998995]   .spread                        : 0.000000 
[ 5276.005459]   .spread0                       : -723727.291815 
[ 5276.012494]   .nr_spread_over                : 0 
[ 5276.018256]   .nr_running                    : 0 
[ 5276.024005]   .load                          : 0 
[ 5276.029739]   .load_avg                      : 0 
[ 5276.035458]   .runnable_avg                  : 0 
[ 5276.041166]   .util_avg                      : 0 
[ 5276.046861]   .util_est_enqueued             : 0 
[ 5276.052543]   .removed.load_avg              : 0 
[ 5276.058213]   .removed.util_avg              : 0 
[ 5276.063867]   .removed.runnable_avg          : 0 
[ 5276.069508]   .tg_load_avg_contrib           : 0 
[ 5276.075137]   .tg_load_avg                   : 0 
[ 5276.080755]   .throttled                     : 0 
[ 5276.086359]   .throttle_count                : 0 
[ 5276.091952] rt_rq[36]:/ 
[ 5276.095104]   .rt_nr_running                 : 0 
[ 5276.100674]   .rt_nr_migratory               : 0 
[ 5276.106230]   .rt_throttled                  : 0 
[ 5276.111776]   .rt_time                       : 0.000000 
[ 5276.117990]   .rt_runtime                    : 950.000000 
[ 5276.124390] dl_rq[36]: 
[ 5276.127377]   .dl_nr_running                 : 0 
[ 5276.132881]   .dl_nr_migratory               : 0 
[ 5276.138372]   .dl_bw->bw                     : 996147 
[ 5276.144337]   .dl_bw->total_bw               : 0 
[ 5276.149806] runnable tasks: 
[ 5276.153223]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5276.165771] ------------------------------------------------------------------------------------------------------------- 
[ 5276.178325]  S        cpuhp/36   191      6221.443328        21   120         0.000000         0.524650         0.000000 0 0 / 
[ 5276.191671]  S    migration/36   192      1910.814125      1381     0         0.000000       462.137714         0.000000 0 0 / 
[ 5276.205047]  S    ksoftirqd/36   193   6381469.908103     92136   120         0.000000        67.022829         0.000000 0 0 / 
[ 5276.218472]  I   kworker/36:0H   195      1465.739227        10   100         0.000000         0.021733         0.000000 0 0 / 
[ 5276.231941]  I    kmpath_rdacd   383       121.486306         2   100         0.000000         0.006105         0.000000 0 0 / 
[ 5276.245453]  I   kworker/36:1H  1207   6381615.060649   2668493   100         0.000000     11553.091657         0.000000 0 0 / 
[ 5276.259015]  S       JS Helper  1765        10.996674         4   120         0.000000         0.045257         0.000000 0 0 /autogroup-64 
[ 5276.273780]  S           tuned  1752       170.705660       474   120         0.000000       172.129119         0.000000 0 0 /autogroup-72 
[ 5276.288589]  S        gssproxy  1805        10.957685         1   120         0.000000         0.006270         0.000000 0 0 /autogroup-79 
[ 5276.303440]  I  mlx5_bond_roce  3095      9828.165431         2   100         0.000000         0.006966         0.000000 0 0 / 
[ 5276.317171]  I    kworker/36:1 30644   6381626.729847      9298   120         0.000000        28.094478         0.000000 0 0 / 
[ 5276.330955]  I   kworker/u80:1 39668   6381628.176661   1585363   120         0.000000      5379.170449         0.000000 0 0 / 
[ 5276.344801]  I    kworker/36:2 41057   6378914.982084         2   120         0.000000         0.004438         0.000000 0 0 / 
[ 5276.358704]  S   10_bash_login 42253       562.963900        61   120         0.000000        22.010353         0.000000 0 0 /autogroup-96 
[ 5276.373837] cpu#37, 2597.006 MHz 
[ 5276.378066]   .nr_running                    : 0 
[ 5276.383854]   .nr_switches                   : 23769772 
[ 5276.390320]   .nr_uninterruptible            : -1304 
[ 5276.396499]   .next_balance                  : 4299.936717 
[ 5276.403266]   .curr->pid                     : 0 
[ 5276.409061]   .clock                         : 5276280.139400 
[ 5276.416111]   .clock_task                    : 5272970.420385 
[ 5276.423172]   .avg_idle                      : 1000000 
[ 5276.429555]   .max_idle_balance_cost         : 500000 
[ 5276.435844] rt_rq[37]:/ 
[ 5276.439214]   .rt_nr_running                 : 0 
[ 5276.445011]   .rt_nr_migratory               : 0 
[ 5276.450796]   .rt_throttled                  : 0 
[ 5276.456593]   .rt_time                       : 0.000000 
[ 5276.463067]   .rt_runtime                    : 950.000000 
[ 5276.469738] dl_rq[37]: 
[ 5276.473007]   .dl_nr_running                 : 0 
[ 5276.478793]   .dl_nr_migratory               : 0 
[ 5276.484559]   .dl_bw->bw                     : 996147 
[ 5276.490794]   .dl_bw->total_bw               : 0 
[ 5276.496530] runnable tasks: 
[ 5276.500214]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5276.513030] ------------------------------------------------------------------------------------------------------------- 
[ 5276.525858]  S        cpuhp/37   196      5708.012803        21   120         0.000000         0.155984         0.000000 1 0 / 
[ 5276.539746]  S    migration/37   197      1966.814129      1380     0         0.000000       463.473613         0.000000 1 0 / 
[ 5276.553624]  S    ksoftirqd/37   198   6039718.725017       892   120         0.000000         5.634040         0.000000 1 0 / 
[ 5276.567513]  I   kworker/37:0H   200      8090.558328        15   100         0.000000         0.030153         0.000000 1 0 / 
[ 5276.581398]  I    kworker/37:1   358     12117.381347      1080   120         0.000000         4.288198         0.000000 1 0 / 
[ 5276.595290]  I         mlx5_fc   745      1044.075542         2   100         0.000000         0.006277         0.000000 1 0 / 
[ 5276.609181]  I         mlx5_fc   755      1056.080424         2   100         0.000000         0.005637         0.000000 1 0 / 
[ 5276.623068]  I    mlx5_hv_vhca   763      1068.084471         2   100         0.000000         0.004691         0.000000 1 0 / 
[ 5276.636951]  I      mlx5e_arfs   771      1080.089030         2   100         0.000000         0.005269         0.000000 1 0 / 
[ 5276.650827]  I   xfs_mru_cache   916      1416.870777         3   100         0.000000         0.006396         0.000000 1 0 / 
[ 5276.664692]  I      ib-comp-wq  1258      5732.775588         2   100         0.000000         0.005584         0.000000 1 0 / 
[ 5276.678553]  I mlx5_ib_page_fa  1304      5744.787898         2   100         0.000000         0.008352         0.000000 1 0 / 
[ 5276.692425]  I   kworker/37:1H  3166   6040383.827122   3602965   100         0.000000     13457.018934         0.000000 1 0 / 
[ 5276.706345]  I    kworker/37:2 21174   6040383.827379      2683   120         0.000000         9.180121         0.000000 1 0 / 
[ 5276.720327] cpu#38, 2597.006 MHz 
[ 5276.724558]   .nr_running                    : 0 
[ 5276.730345]   .nr_switches                   : 25347774 
[ 5276.736802]   .nr_uninterruptible            : 1599 
[ 5276.742879]   .next_balance                  : 4299.943892 
[ 5276.749639]   .curr->pid                     : 0 
[ 5276.755424]   .clock                         : 5276755.134581 
[ 5276.762474]   .clock_task                    : 5221558.598153 
[ 5276.769527]   .avg_idle                      : 1000000 
[ 5276.775900]   .max_idle_balance_cost         : 500000 
[ 5276.782178] rt_rq[38]:/ 
[ 5276.785539]   .rt_nr_running                 : 0 
[ 5276.791325]   .rt_nr_migratory               : 0 
[ 5276.797112]   .rt_throttled                  : 0 
[ 5276.802897]   .rt_time                       : 0.000000 
[ 5276.809363]   .rt_runtime                    : 950.000000 
[ 5276.816022] dl_rq[38]: 
[ 5276.819282]   .dl_nr_running                 : 0 
[ 5276.825057]   .dl_nr_migratory               : 0 
[ 5276.830812]   .dl_bw->bw                     : 996147 
[ 5276.837036]   .dl_bw->total_bw               : 0 
[ 5276.842761] runnable tasks: 
[ 5276.846435]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5276.859244] ------------------------------------------------------------------------------------------------------------- 
[ 5276.872056]  S         systemd     1       510.904925      4777   120         0.000000      4643.661188         0.000000 0 0 /autogroup-1 
[ 5276.887000]  S        cpuhp/38   201      5434.478115        21   120         0.000000         0.217814         0.000000 0 0 / 
[ 5276.900868]  S    migration/38   202      2018.814118      1388     0         0.000000       465.152778         0.000000 0 0 / 
[ 5276.914737]  S    ksoftirqd/38   203   6661780.276023     52601   120         0.000000       196.270409         0.000000 0 0 / 
[ 5276.928613]  I   kworker/38:0H   205      3902.756235        10   100         0.000000         0.021252         0.000000 0 0 / 
[ 5276.942499]  I           kstrp   386        85.904307         2   100         0.000000         0.006046         0.000000 0 0 / 
[ 5276.956381]  I   kworker/38:1H  1164   6661754.511833   3749005   100         0.000000     16127.231353         0.000000 0 0 / 
[ 5276.970271]  I         rdma_cm  1359      5483.512415         2   100         0.000000         0.008355         0.000000 0 0 / 
[ 5276.984161]  S           gmain  1761        10.972745         2   120         0.000000         0.021330         0.000000 0 0 /autogroup-64 
[ 5276.999209]  S       JS Helper  1768        23.019076         4   120         0.000000         0.046338         0.000000 0 0 /autogroup-64 
[ 5277.014247]  S           tuned  2078        70.648566       324   120         0.000000       134.714894         0.000000 0 0 /autogroup-72 
[ 5277.029273]  S        gssproxy  1802        10.963044         1   120         0.000000         0.011629         0.000000 0 0 /autogroup-79 
[ 5277.044300]  I      mkey_cache  3278      9189.646333         2   100         0.000000         0.013603         0.000000 0 0 / 
[ 5277.058199]  S           crond  3618         0.791236       103   120         0.000000        97.681725         0.000000 0 0 /autogroup-95 
[ 5277.073301]  S     rstrnt-sync 21024      7523.592308       151   120         0.000000         7.992238         0.000000 0 0 /autogroup-102 
[ 5277.088542]  I    kworker/38:2 29576   6300596.933669    111622   120         0.000000       208.797024         0.000000 0 0 / 
[ 5277.102570]  I    kworker/38:0 30632   6661780.279458     16934   120         0.000000        52.364333         0.000000 0 0 / 
[ 5277.116646]  S         main.sh 37869       792.184325      3325   120         0.000000       644.950078         0.000000 0 0 /autogroup-159 
[ 5277.132035]  I   kworker/u80:3 39774   6661792.318690   2338047   120         0.000000      7979.915510         0.000000 0 0 / 
[ 5277.146228] cpu#39, 2597.006 MHz 
[ 5277.150571]   .nr_running                    : 0 
[ 5277.156467]   .nr_switches                   : 23049117 
[ 5277.163044]   .nr_uninterruptible            : -802 
[ 5277.169236]   .next_balance                  : 4299.944319 
[ 5277.176108]   .curr->pid                     : 0 
[ 5277.182011]   .clock                         : 5277181.137608 
[ 5277.189178]   .clock_task                    : 5273784.290133 
[ 5277.196334]   .avg_idle                      : 1000000 
[ 5277.202793]   .max_idle_balance_cost         : 500000 
[ 5277.209138] rt_rq[39]:/ 
[ 5277.212554]   .rt_nr_running                 : 0 
[ 5277.218389]   .rt_nr_migratory               : 0 
[ 5277.224212]   .rt_throttled                  : 0 
[ 5277.230021]   .rt_time                       : 0.000000 
[ 5277.236497]   .rt_runtime                    : 950.000000 
[ 5277.243154] dl_rq[39]: 
[ 5277.246397]   .dl_nr_running                 : 0 
[ 5277.252154]   .dl_nr_migratory               : 0 
[ 5277.257898]   .dl_bw->bw                     : 996147 
[ 5277.264119]   .dl_bw->total_bw               : 0 
[ 5277.269835] runnable tasks: 
[ 5277.273507]  S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep 
[ 5277.286309] ------------------------------------------------------------------------------------------------------------- 
[ 5277.299121]  S        cpuhp/39   206     13207.236910        21   120         0.000000         0.163906         0.000000 1 0 / 
[ 5277.312990]  S    migration/39   207      2074.814124      1366     0         0.000000       466.520973         0.000000 1 0 / 
[ 5277.326868]  S    ksoftirqd/39   208   6302296.709259      1249   120         0.000000         6.120283         0.000000 1 0 / 
[ 5277.340753]  I   kworker/39:0H   210      9246.372544        10   100         0.000000         0.015467         0.000000 1 0 / 
[ 5277.354646]  I    kworker/39:1   360   6302299.031241      3164   120         0.000000        11.621163         0.000000 1 0 / 
[ 5277.368547]  I mlx5_cmd_0000:0   749      8479.612209         2   100         0.000000         0.005124         0.000000 1 0 / 
[ 5277.382452]  I mlx5_health0000   757      8491.616414         2   100         0.000000         0.004864         0.000000 1 0 / 
[ 5277.396363]  I         mlx5_fc   764      8503.620433         2   100         0.000000         0.004673         0.000000 1 0 / 
[ 5277.410267]  I        kdmflush   879      8836.648884         2   100         0.000000         0.006254         0.000000 1 0 / 
[ 5277.424156]  I    xfs-buf/dm-0   918      8848.653349         2   100         0.000000         0.005067         0.000000 1 0 / 
[ 5277.438041]  I   kworker/39:1H  1179   6302292.704152   3595276   100         0.000000     13419.365715         0.000000 1 0 / 
[ 5277.451929]  I     ib_nl_sa_wq  1261     13232.578754         2   100         0.000000         0.006775         0.000000 1 0 / 
[ 5277.465818]  I         ib_mad1  1305     13244.586308         2   100         0.000000         0.008695         0.000000 1 0 / 
[ 5277.479747]  I      mkey_cache  1319     13256.591318         2   100         0.000000         0.005668         0.000000 1 0 / 
[ 5277.493720]  S           gmain 21025      6378.271719         1   120         0.000000         0.032885         0.000000 1 0 /autogroup-102 
[ 5277.508991]  I nvmet-buffered- 26990     20922.488174         2   100         0.000000         0.007804         0.000000 1 0 / 
[ 5277.523042]  I    kworker/39:0 29704    184004.912725         2   120         0.000000         0.005556         0.000000 1 0 / 
[ 5277.537139]  I   kworker/u82:1 41393   6301734.667346    310536   120         0.000000       717.400486         0.000000 1 0 / 
[ 5282.758891] sysrq: Show Blocked State 
[ 5287.648349] irq 3: Affinity broken due to vector space exhaustion. 
[ 5287.656934] irq 3: Affinity broken due to vector space exhaustion. 
[ 5287.658661] sda1: Can't mount, would change RO state 

Best Regards,
  Yi Zhang



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
