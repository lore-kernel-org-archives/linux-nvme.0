Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EFDC3DA64
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 07:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KTm95tSB4EIVW6oc69ri6UXWlXFR3I0/IZFpduIfOq8=; b=c2E8BXV22kW8ZW7phX/3Xu1qpy
	SKcSmAmBa2tKxAZQvEMd7v4vttucKrogmndAvIam4Bkk2PtUMY/yCEE6hwiXGv5K4DMSHPBUzU44/
	4nGir874Kv5NsUF9gB9V1guehQLGMx0xhTur4YIgrCI3mU8kRK9q6TEwbkrAaRmB3I3cBsqlGhTee
	Lme73FUc3tznfL5GCdC0rRF6aW4j9/8ZmgPMId62LsXjMOnIOtlzS7LJB3RkPgabKqGs9vSSZ7WBM
	2j3cBaaGpVHFMSqxnm1Bn7+BHQDOajrueikazvUyCsHrhER4p5UEhNW6VoewbTPjvjO0vW0rp377P
	LfebMWrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ3Oi-000000003DP-2BYp;
	Wed, 31 Jul 2024 07:05:20 +0000
Received: from m15.mail.163.com ([45.254.50.220])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ3O4-000000002yQ-3fAL
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 07:04:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=KTm95
	tSB4EIVW6oc69ri6UXWlXFR3I0/IZFpduIfOq8=; b=aCZ3bIuaVEAaSIMrDd6+k
	8om68qu8hUh/+MOVWyiflNV3L/6yTUv9jwoYJN8b3EnctehkjgMV4mHq0KK16ree
	v9Vy9Yk1CW1Id4b6IGHqO/P3E/RS13oN3uzRp4rmTIPD437/FpDLWT0dBrqswqMp
	WtljbbZuRPAeTKhxROYZ6E=
Received: from localhost.localdomain (unknown [139.227.195.24])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wC3fyb24almN152FA--.15610S2;
	Wed, 31 Jul 2024 15:04:23 +0800 (CST)
From: Ping Gan <jacky_gam_2001@163.com>
To: sagi@grimberg.me,
	hare@suse.de,
	hch@lst.de
Cc: ping.gan@dell.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
Date: Wed, 31 Jul 2024 15:03:25 +0800
Message-Id: <20240731070326.76090-1-jacky_gam_2001@163.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
References: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3fyb24almN152FA--.15610S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3ArWkWFW3tryxWw18WFyUZFb_yoW7tr48pF
	WrAa4UtFZrCFW3G39rWFyIkr17Ca1xXw15X3W8uryjkryYvFy3ArWvyw43X3Z2gr10g34U
	ZFWDXrs0ya9Iqa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7HUkUUUUU=
X-Originating-IP: [139.227.195.24]
X-CM-SenderInfo: 5mdfy55bjdzsisqqiqqrwthudrp/1tbiKBwtKWXAmjsqGAABsH
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_000441_464784_96B5FA1F 
X-CRM114-Status: GOOD (  16.14  )
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

> On 26/07/2024 5:34, Ping Gan wrote:
>>> On 19/07/2024 12:19, Ping Gan wrote:
>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>> high
>>>> workload on the system(eg: kubernetes), the competition between the
>>>> bounded kworker and other workload is very radical. To decrease the
>>>> resource race of OS among them, this patchset will switch to
>>>> unbounded
>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>> get some performance improvement. And this patchset bases on
>>>> previous
>>>> discussion from below session.
>>>>
>>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>>> Hold your horses.
>>>
>>> This cannot be just switched without a thorough testing and actual
>>> justification/proof of
>>> a benefit beyond just a narrow use-case brought initially by Ping
>>> Gan.
>>>
>>> If the ask is to universally use an unbound workqueue, please
>>> provide
>>> detailed
>>> benchmarking convincing us that this makes sense.
>> So you think we should not do a radical change for the narrow usecase
>> but
>> keep the parameter to enable it in previous version patch, right?
>
> What I'm saying is that if you want to change the default, please
> provide
> justification in the form of benchmarks that support the change. This
> benchmarks should include both throughput, iops and latency
> measurements
> and without the cpu-set constraints you presented originally.

We tested it on our testbed which has 4 numa 96 cores, 190GB memory
and 24 nvme disks, it seems unbound_wq has pretty improvment.  The 
creating target test script is below:

#!/bin/bash
if [ "$#" -ne 3 ] ; then
echo "$0 addr_trtype(tcp/rdma) target_IP target_port"
exit -1
fi
addr_trtype=$1
target_IP=$2
target_port=$3
# there are 24 nvme disks on the testbed
disk_list=(nvme0n1 nvme1n1 nvme2n1 nvme3n1 nvme4n1 nvme5n1 nvme6n1
nvme7n1 nvme8n1 nvme9n1 nvme10n1 nvme11n1 nvme12n1 nvme13n1 nvme14n1
nvme15n1 nvme16n1 nvme17n1 nvme18n1 nvme19n1 nvme20n1 nvme21n1 nvme22n1
nvme23n1)
# create target with multiple disks
create_target_multi_disks() {
        local nqn_name=$1
        local svr_ip=$2
        local svr_port=$3
        local i
        local blk_dev
        local blk_dev_idx=0
        local port_idx=25
        echo "create target: $nqn_name $svr_ip $svr_port"
        mkdir /sys/kernel/config/nvmet/subsystems/${nqn_name}
        echo 1
>/sys/kernel/config/nvmet/subsystems/${nqn_name}/attr_allow_any_host
        for((i=0;i<${#disk_list[@]};i++)); do
                blk_dev_idx=$((${blk_dev_idx}+1))
                blk_dev=/dev/${disk_list[$i]}
                mkdir
/sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}
                echo  ${blk_dev} >
/sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/device_path
                echo 1 >
/sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/enable
        done
        mkdir /sys/kernel/config/nvmet/ports/${port_idx}
        echo ${addr_trtype}
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_trtype
        echo ipv4
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_adrfam
        echo ${svr_ip}
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_traddr
        echo ${svr_port}
>/sys/kernel/config/nvmet/ports/${port_idx}/addr_trsvcid
        ln -s /sys/kernel/config/nvmet/subsystems/${nqn_name}/
/sys/kernel/config/nvmet/ports/${port_idx}/subsystems/${nqn_name}
}
nvmetcli clear
nqn_name="testnqn_25"
mkdir /sys/kernel/config/nvmet/hosts/hostnqn
create_target_multi_disks ${nqn_name} ${target_IP} ${target_port}

And the simulation of high workload program is below:

#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <pthread.h>
#include <sched.h>
#define THREAD_NUM  (85)
#define MALLOC_SIZE (104857600)
void *loopcostcpu(void *args)
{
        sleep(1);
        int *core_id = (int *)args;
        cpu_set_t cpuset;
        CPU_ZERO(&cpuset);
        CPU_SET(*core_id, &cpuset);
        sched_setaffinity(0, sizeof(cpuset), &cpuset);
        nice(-20);
        long *pt = malloc(MALLOC_SIZE*sizeof(long));
        if (!pt) {
                printf("error malloc\n");
                return;
        }
        long i = 0;
        while (1) {
                for (i = 0; i < MALLOC_SIZE; i++) {
                        pt[i] = i;
                }
                //sleep 10ms
                usleep(10000);
        }
        return;
}
int main(int argc, char *argv[])
{
        pthread_t tid[THREAD_NUM];
        int core_id[THREAD_NUM];
        int result, i, j = 1;
        for (i = 0; i < THREAD_NUM; i++) {
                core_id[i] = j;
                j++;
                result = pthread_create(&tid[i], NULL, loopcostcpu,
									(void*)
&core_id[i]);
                if (result) {
                        printf("create thread %d failure\n", i);
                }
        }
        while(1)
                sleep(5);
        return 0;
}

When running above program on target testbed, and we reserved 8
cores(88-95) for nvmet target io threads(both rdma and tcp), then we
used spdk perf(V20.04) as initiator to create 8 IO queues and per
queue has 32 queue depths and 1M randrw io size on another testbed 
to verify it. 
TCP's test command shown below:
./spdk_perf_tcp -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
1048576 -M 50 -r 'trtype:TCP adrfam:IPv4 traddr:169.254.2.104
trsvcid:4444'
RDMA's test command shown below:
./spkd_perf_rdma -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
1048576 -M 50 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.2.104
trsvcid:4444'
And we got below test results:
TCP's unbound_wq:  IOPS:4585.64, BW:4585.64 MiB/s, Avglat:167515.56us
TCP's bound_wq:    IOPS:3588.40, BW:3588.40 MiB/s, Avglat:214088.55us
RDMA's unbound_wq: IOPS:6421.47, BW:6421.47 MiB/s, Avglat:119605.17us
RDMA's bound_wq:   IOPS:5919.94, BW:5919.94 MiB/s, Avglat:129744.70us

It seems using unbound_wq to decreasing competition of CPU between 
target IO worker thread and other high workload does make sense.

Thanks,
Ping



