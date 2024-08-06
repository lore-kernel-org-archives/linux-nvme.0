Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FFDC3DA64
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fnljiPMonWWbweo0m4Z1Xday1MSSs7eKM9xDnzNZ2EI=; b=J8HNXLX15U93FVvkW0aNP68r8S
	bpgCadnQJCOGRvoxLR74cletNbHppyi/y2KLf7zLJ4drxJ7dOpA36nIjehtKRVRa3iisjemv4tbzp
	+EZ/vj0uHN5Q6Z+me+EY/RGzykp4hYzfGpo9MnGvIcyA6FbFyO3A175RmDx+VA5v4kSuykmTAY8EU
	JaIEUkPZV/TrJzMgjywzvKPUpQuFbG8LtpLpPgCd96aQl39fTlUXREV1LrrqftP9DvLayqdSCeYsA
	T2bS8EXDl3n40Lxlr4+3+NUOrn4PDUUAfpaNrabLJvN2yLo3kl2P0P7p0fVgt9GLxmLApGkqsFxZ+
	enK8Z/cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbH86-00000001BQp-0LUy;
	Tue, 06 Aug 2024 10:09:22 +0000
Received: from m16.mail.163.com ([220.197.31.2])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbH82-00000001BPw-0O8I
	for linux-nvme@lists.infradead.org;
	Tue, 06 Aug 2024 10:09:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fnlji
	PMonWWbweo0m4Z1Xday1MSSs7eKM9xDnzNZ2EI=; b=ddQfw/FpjnRCtlC4ELraW
	q6gzH/9WOlIWTmMdl5aSDX5fgXw3CEV7zh2LTRGBQf01Dtzb44GnOof1c7I+Z0AU
	mooiV5Lotr0HsjxCXFRGhuPmIcoUN6+YkrhGJ9yK/IJjPOGF9XeuEh6a3rK3q/Cw
	sO6yE5xamCzvPLjr/yUG30=
Received: from localhost.localdomain (unknown [183.192.129.173])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wAXBK869rFman0MCQ--.20620S2;
	Tue, 06 Aug 2024 18:08:59 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re :[PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default 
Date: Tue,  6 Aug 2024 18:08:02 +0800
Message-Id: <20240806100803.33050-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <d61a36d8-ed26-43e8-b960-58f458ba13e1@grimberg.me>
References: <d61a36d8-ed26-43e8-b960-58f458ba13e1@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXBK869rFman0MCQ--.20620S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Zr4xWFW3uFWkuFW8Aw13urg_yoWDXFykpF
	WFyF1jyFsrAry3Gw4j9F9xKF1jya17Xr15XF18GryUGr909Fyayr40yF45ua4DWr1kW34j
	vrWDJrnIvw1kta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4lk3UUUUU=
X-Originating-IP: [183.192.129.173]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiEB0zKWXAmVBKxAAAs1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240806_030918_483864_7CBCAB51 
X-CRM114-Status: GOOD (  24.32  )
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


> On 02/08/2024 6:39, Ping Gan wrote:
>>> On 31/07/2024 10:03, Ping Gan wrote:
>>>>> On 26/07/2024 5:34, Ping Gan wrote:
>>>>>>> On 19/07/2024 12:19, Ping Gan wrote:
>>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA
>>>>>>>> and
>>>>>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>>>>>> high
>>>>>>>> workload on the system(eg: kubernetes), the competition between
>>>>>>>> the
>>>>>>>> bounded kworker and other workload is very radical. To decrease
>>>>>>>> the
>>>>>>>> resource race of OS among them, this patchset will switch to
>>>>>>>> unbounded
>>>>>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can
>>>>>>>> also
>>>>>>>> get some performance improvement. And this patchset bases on
>>>>>>>> previous
>>>>>>>> discussion from below session.
>>>>>>>>
>>>>>>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>>>>>>> Hold your horses.
>>>>>>>
>>>>>>> This cannot be just switched without a thorough testing and
>>>>>>> actual
>>>>>>> justification/proof of
>>>>>>> a benefit beyond just a narrow use-case brought initially by
>>>>>>> Ping
>>>>>>> Gan.
>>>>>>>
>>>>>>> If the ask is to universally use an unbound workqueue, please
>>>>>>> provide
>>>>>>> detailed
>>>>>>> benchmarking convincing us that this makes sense.
>>>>>> So you think we should not do a radical change for the narrow
>>>>>> usecase
>>>>>> but
>>>>>> keep the parameter to enable it in previous version patch, right?
>>>>> What I'm saying is that if you want to change the default, please
>>>>> provide
>>>>> justification in the form of benchmarks that support the change.
>>>>> This
>>>>> benchmarks should include both throughput, iops and latency
>>>>> measurements
>>>>> and without the cpu-set constraints you presented originally.
>>>> We tested it on our testbed which has 4 numa 96 cores, 190GB memory
>>>> and 24 nvme disks, it seems unbound_wq has pretty improvment.  The
>>>> creating target test script is below:
>>>>
>>>> #!/bin/bash
>>>> if [ "$#" -ne 3 ] ; then
>>>> echo "$0 addr_trtype(tcp/rdma) target_IP target_port"
>>>> exit -1
>>>> fi
>>>> addr_trtype=$1
>>>> target_IP=$2
>>>> target_port=$3
>>>> # there are 24 nvme disks on the testbed
>>>> disk_list=(nvme0n1 nvme1n1 nvme2n1 nvme3n1 nvme4n1 nvme5n1 nvme6n1
>>>> nvme7n1 nvme8n1 nvme9n1 nvme10n1 nvme11n1 nvme12n1 nvme13n1
>>>> nvme14n1
>>>> nvme15n1 nvme16n1 nvme17n1 nvme18n1 nvme19n1 nvme20n1 nvme21n1
>>>> nvme22n1
>>>> nvme23n1)
>>>> # create target with multiple disks
>>>> create_target_multi_disks() {
>>>>           local nqn_name=$1
>>>>           local svr_ip=$2
>>>>           local svr_port=$3
>>>>           local i
>>>>           local blk_dev
>>>>           local blk_dev_idx=0
>>>>           local port_idx=25
>>>>           echo "create target: $nqn_name $svr_ip $svr_port"
>>>>           mkdir /sys/kernel/config/nvmet/subsystems/${nqn_name}
>>>>           echo 1
>>>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/attr_allow_any_host
>>>>           for((i=0;i<${#disk_list[@]};i++)); do
>>>>                   blk_dev_idx=$((${blk_dev_idx}+1))
>>>>                   blk_dev=/dev/${disk_list[$i]}
>>>>                   mkdir
>>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}
>>>>                   echo  ${blk_dev} >
>>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/device_path
>>>>                   echo 1 >
>>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/enable
>>>>           done
>>>>           mkdir /sys/kernel/config/nvmet/ports/${port_idx}
>>>>           echo ${addr_trtype}
>>>> > /sys/kernel/config/nvmet/ports/${port_idx}/addr_trtype
>>>>           echo ipv4
>>>> > /sys/kernel/config/nvmet/ports/${port_idx}/addr_adrfam
>>>>           echo ${svr_ip}
>>>> > /sys/kernel/config/nvmet/ports/${port_idx}/addr_traddr
>>>>           echo ${svr_port}
>>>> > /sys/kernel/config/nvmet/ports/${port_idx}/addr_trsvcid
>>>>           ln -s /sys/kernel/config/nvmet/subsystems/${nqn_name}/
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/subsystems/${nqn_name}
>>>> }
>>>> nvmetcli clear
>>>> nqn_name="testnqn_25"
>>>> mkdir /sys/kernel/config/nvmet/hosts/hostnqn
>>>> create_target_multi_disks ${nqn_name} ${target_IP} ${target_port}
>>>>
>>>> And the simulation of high workload program is below:
>>>>
>>>> #define _GNU_SOURCE
>>>> #include <stdio.h>
>>>> #include <unistd.h>
>>>> #include <string.h>
>>>> #include <stdlib.h>
>>>> #include <pthread.h>
>>>> #include <sched.h>
>>>> #define THREAD_NUM  (85)
>>>> #define MALLOC_SIZE (104857600)
>>>> void *loopcostcpu(void *args)
>>>> {
>>>>           sleep(1);
>>>>           int *core_id = (int *)args;
>>>>           cpu_set_t cpuset;
>>>>           CPU_ZERO(&cpuset);
>>>>           CPU_SET(*core_id, &cpuset);
>>>>           sched_setaffinity(0, sizeof(cpuset), &cpuset);
>>>>           nice(-20);
>>>>           long *pt = malloc(MALLOC_SIZE*sizeof(long));
>>>>           if (!pt) {
>>>>                   printf("error malloc\n");
>>>>                   return;
>>>>           }
>>>>           long i = 0;
>>>>           while (1) {
>>>>                   for (i = 0; i < MALLOC_SIZE; i++) {
>>>>                           pt[i] = i;
>>>>                   }
>>>>                   //sleep 10ms
>>>>                   usleep(10000);
>>>>           }
>>>>           return;
>>>> }
>>>> int main(int argc, char *argv[])
>>>> {
>>>>           pthread_t tid[THREAD_NUM];
>>>>           int core_id[THREAD_NUM];
>>>>           int result, i, j = 1;
>>>>           for (i = 0; i < THREAD_NUM; i++) {
>>>>                   core_id[i] = j;
>>>>                   j++;
>>>>                   result = pthread_create(&tid[i], NULL,
>>>>                   loopcostcpu,
>>>> 									(void*)
>>>> &core_id[i]);
>>>>                   if (result) {
>>>>                           printf("create thread %d failure\n", i);
>>>>                   }
>>>>           }
>>>>           while(1)
>>>>                   sleep(5);
>>>>           return 0;
>>>> }
>>>>
>>>> When running above program on target testbed, and we reserved 8
>>>> cores(88-95) for nvmet target io threads(both rdma and tcp), then
>>>> we
>>>> used spdk perf(V20.04) as initiator to create 8 IO queues and per
>>>> queue has 32 queue depths and 1M randrw io size on another testbed
>>>> to verify it.
>>>> TCP's test command shown below:
>>>> ./spdk_perf_tcp -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000
>>>> -o
>>>> 1048576 -M 50 -r 'trtype:TCP adrfam:IPv4 traddr:169.254.2.104
>>>> trsvcid:4444'
>>>> RDMA's test command shown below:
>>>> ./spkd_perf_rdma -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c
>>>> 0xff00000
>>>> -o
>>>> 1048576 -M 50 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.2.104
>>>> trsvcid:4444'
>>>> And we got below test results:
>>>> TCP's unbound_wq:  IOPS:4585.64, BW:4585.64 MiB/s,
>>>> Avglat:167515.56us
>>>> TCP's bound_wq:    IOPS:3588.40, BW:3588.40 MiB/s,
>>>> Avglat:214088.55us
>>>> RDMA's unbound_wq: IOPS:6421.47, BW:6421.47 MiB/s,
>>>> Avglat:119605.17us
>>>> RDMA's bound_wq:   IOPS:5919.94, BW:5919.94 MiB/s,
>>>> Avglat:129744.70us
>>>>
>>>> It seems using unbound_wq to decreasing competition of CPU between
>>>> target IO worker thread and other high workload does make sense.
>>> It makes sense for the use case, I agree. What I was asking is to
>>> test
>>> outside this use-case, where nvmet is used as a JBOF, and not
>>> competing
>>> with other intensive workloads. Does unbound workqueues damage
>>> performance?
>>> Back in 2016 it absolutely did.
>>>
>>> What I would also want to see is a test that addresses latency
>>> sensitive
>>> workloads, such
>>> that the load is not high with large block size, but rather small
>>> block
>>> size, with medium/low
>>> load and see what is the latency for the two options.
>> We had done two group tests for unbound_wq and bound_wq; per group
>> had
>> 6 round tests which included TCP 1M IO size without other workload,
>> TCP 4K IO size without other workload, TCP 4K IO size with medium
>> workload(about 45% CPU cost and 25% memory cost), RDMA 1M IO size
>> without other workload, RDMA 4K IO size without other workload,
>> RDMA 4K IO size with medium workload. And every round test we used
>> 8 IO queues, per queue had 32 queue depths and no CPU affinity with
>> randrw disk to run 1 hour test and we got below results.
>>
>> TCP 1M bound_wq:   IOPS:8120.38, BW:8120.38 MiB/s, Avglat:94577.77us
>> TCP 1M unbound_wq: IOPS:8236.16, BW:8236.16 MiB/s, Avglat:93248.18us
>>
>> TCP 4K bound_wq:   IOPS:1326767.00, BW:5182.68 MiB/s, Avglat:578.83us
>> TCP 4K unbound_wq: IOPS:952239.52,  BW:3719.69 MiB/s, Avglat:806.49us
>>
>> TCP 4K with medium workload bound_wq:
>>                     IOPS:944414.21, BW:3689.12 MiB/s, Avglat:813.18us
>> TCP 4K with medium workload unbound_wq:
>>                     IOPS:855103.18, BW:3340.25 MiB/s, Avglat:898.11us
>>
>> RDMA 1M bound_wq:  IOPS:10111.35, BW:10111.35 MiB/s,
>> Avglat:75954.55us
>> RDMA 1M unbound_wq:IOPS:10108.84, BW:10108.84 MiB/s,
>> Avglat:75973.39us
>>
>> RDMA 4K bound_wq:  IOPS:2645207.01, BW:10332.84 MiB/s,
>> Avglat:290.31us
>> RDMA 4K unbound_wq:IOPS:2644785.78, BW:10331.19 MiB/s,
>> Avglat:290.35us
>>
>> RDMA 4K with medium workload bound_wq:
>>                     IOPS:2595758.58, BW:10139.68 MiB/s,
>>                     Avglat:295.84us
>> RDMA 4K with medium workload unbound_wq:
>>                     IOPS:2551177.45, BW:9965.54 MiB/s,
>>                     Avglat:301.01us
>>
>> It seems in TCP small block size case the unbound_wq has tremendous
>> performance drop.
>
> That is consistent with what I saw back in 2016.
>
>>   So I think we should not radically change the default
>> workqueue as unbounded but keep the previous patch with parameter to
>> support the narrow case for performance improvement.
>
> Interestingly though, rdma does not seem to have the same 
> characteristics, although
> I do expect that in *some* workloads the overhead is meaningful.
>
> My position is that this change should be presented as a modparam. In 
> the long run, I'd think
> we want to introduce polling threads to nvmet and move the scheduling
> to 
> it, but it is a larger project,
> and when when that happens, I'd rather deprecate the modparam instead
> of 
> introducing this change
> that impacts performance in any meaningful way.

Yes, agree with you. And introducing polling thread for nvmet is a long 
journey to go. Except generalizing sqthreads of io_uring, maybe polling
queue to bio should be also considered.


Thanks,
Ping



