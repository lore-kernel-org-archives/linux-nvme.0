Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE9DC3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jul 2024 07:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOBK1zJNwfmeMZXC2+EpO9wUpnyhnQvvJPepSNwqT3Q=; b=a2HKUgBf3YhIwld+AyEKhy5ZFT
	TJrSsonQxvV4OrsXxqRWFIw957a9y1jK8iY//eQ92wZShpMTa78KB3vkI4tWn8KeYS1fYjwtquTiJ
	swT82TcE+fVwDjvhUq4BdrU0cgoyu0pc4xAhGBUQQvGz8y/OzJcopXxTPB7ecOdIJI6h2XnQcN/JH
	lrtnYfKByxMSc3kLdLKAwKPISLHqx0hAoPBPEq74NUvIJ1ITz25Wj5gvRYI860duHSJ2581gWCTyc
	w7hVmUiHnWGVDCqgpQuCa6AwcVUg2/UK0hsLJSBvKM8DWWshgcQGg5tYtptZr0G2jba7awCmqr4t5
	2OKdWGjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ3sh-000000009yG-03pM;
	Wed, 31 Jul 2024 07:36:19 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ3sd-000000009xX-1ROy
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jul 2024 07:36:16 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3687f91b7cfso415583f8f.3
        for <linux-nvme@lists.infradead.org>; Wed, 31 Jul 2024 00:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722411373; x=1723016173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOBK1zJNwfmeMZXC2+EpO9wUpnyhnQvvJPepSNwqT3Q=;
        b=WusiW9jYfxyc2qRMxYSm4IHp0WANLk5JYYGmV+1eSnHnd7sI3Ck3QzCzG3OOYth90L
         4VSfPcKQcEQ1jfqyAgBsl2jYl8RMV3i4UCKGC+1gizXQt9Z5bI6kiLdmZRaGpgv6fj42
         G8I43hS761WgGyUTHYr6xZwBAhNgyb+zu+pDH2xngIks/iJCt7zg1JYS7Q8OhbaaMMWS
         oHbzZJcvzPgQ9EiXSBRE5Lp4wJkEHO+yG9rvtT2OfBRPBHeMTVB2Sc+EXMvIGMn+uwtT
         8E8XHraeIQ6J7CDN87AcRdGlxaNRSE0jEI8C6FNGPNspYymnN67JSYjGcCCHWv3iF5T3
         IqzA==
X-Forwarded-Encrypted: i=1; AJvYcCU5FXza0+c7Oz2jFH96PMEiRBZWo323010Oprudh1H4aDVZuICBGiV1KrSMj4hW+hZCsou9PRYnZSKX@lists.infradead.org
X-Gm-Message-State: AOJu0YwI/9uZAdn8Mc3eeExdatU0GiUo01CJI4PZ1IYBAaEEmMCZvV67
	LSF//rKDfn75AvJc7JJeUnNQetcDFUWWH+W3Fg4wGpzDI/0NlNDh
X-Google-Smtp-Source: AGHT+IF2cezuJo8yOeS138rccPai1NJ7yKJaEb65sPtEzO5RvWWH8dE9KvK1wlJMwvgPIXRWHa9KgQ==
X-Received: by 2002:a05:600c:4511:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-428053c0936mr86157575e9.0.1722411372784;
        Wed, 31 Jul 2024 00:36:12 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282baccccfsm10971445e9.29.2024.07.31.00.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 00:36:12 -0700 (PDT)
Message-ID: <ae3047fc-bdeb-4b63-91ac-f4cc39434415@grimberg.me>
Date: Wed, 31 Jul 2024 10:36:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de
Cc: ping.gan@dell.com, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <b3592bca-015f-451e-b689-8db820cbc7a6@grimberg.me>
 <20240731070326.76090-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240731070326.76090-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240731_003615_427025_F3AA44F6 
X-CRM114-Status: GOOD (  23.08  )
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




On 31/07/2024 10:03, Ping Gan wrote:
>> On 26/07/2024 5:34, Ping Gan wrote:
>>>> On 19/07/2024 12:19, Ping Gan wrote:
>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>>> high
>>>>> workload on the system(eg: kubernetes), the competition between the
>>>>> bounded kworker and other workload is very radical. To decrease the
>>>>> resource race of OS among them, this patchset will switch to
>>>>> unbounded
>>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>>> get some performance improvement. And this patchset bases on
>>>>> previous
>>>>> discussion from below session.
>>>>>
>>>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>>>> Hold your horses.
>>>>
>>>> This cannot be just switched without a thorough testing and actual
>>>> justification/proof of
>>>> a benefit beyond just a narrow use-case brought initially by Ping
>>>> Gan.
>>>>
>>>> If the ask is to universally use an unbound workqueue, please
>>>> provide
>>>> detailed
>>>> benchmarking convincing us that this makes sense.
>>> So you think we should not do a radical change for the narrow usecase
>>> but
>>> keep the parameter to enable it in previous version patch, right?
>> What I'm saying is that if you want to change the default, please
>> provide
>> justification in the form of benchmarks that support the change. This
>> benchmarks should include both throughput, iops and latency
>> measurements
>> and without the cpu-set constraints you presented originally.
> We tested it on our testbed which has 4 numa 96 cores, 190GB memory
> and 24 nvme disks, it seems unbound_wq has pretty improvment.  The
> creating target test script is below:
>
> #!/bin/bash
> if [ "$#" -ne 3 ] ; then
> echo "$0 addr_trtype(tcp/rdma) target_IP target_port"
> exit -1
> fi
> addr_trtype=$1
> target_IP=$2
> target_port=$3
> # there are 24 nvme disks on the testbed
> disk_list=(nvme0n1 nvme1n1 nvme2n1 nvme3n1 nvme4n1 nvme5n1 nvme6n1
> nvme7n1 nvme8n1 nvme9n1 nvme10n1 nvme11n1 nvme12n1 nvme13n1 nvme14n1
> nvme15n1 nvme16n1 nvme17n1 nvme18n1 nvme19n1 nvme20n1 nvme21n1 nvme22n1
> nvme23n1)
> # create target with multiple disks
> create_target_multi_disks() {
>          local nqn_name=$1
>          local svr_ip=$2
>          local svr_port=$3
>          local i
>          local blk_dev
>          local blk_dev_idx=0
>          local port_idx=25
>          echo "create target: $nqn_name $svr_ip $svr_port"
>          mkdir /sys/kernel/config/nvmet/subsystems/${nqn_name}
>          echo 1
>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/attr_allow_any_host
>          for((i=0;i<${#disk_list[@]};i++)); do
>                  blk_dev_idx=$((${blk_dev_idx}+1))
>                  blk_dev=/dev/${disk_list[$i]}
>                  mkdir
> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}
>                  echo  ${blk_dev} >
> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/device_path
>                  echo 1 >
> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/enable
>          done
>          mkdir /sys/kernel/config/nvmet/ports/${port_idx}
>          echo ${addr_trtype}
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trtype
>          echo ipv4
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_adrfam
>          echo ${svr_ip}
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_traddr
>          echo ${svr_port}
>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trsvcid
>          ln -s /sys/kernel/config/nvmet/subsystems/${nqn_name}/
> /sys/kernel/config/nvmet/ports/${port_idx}/subsystems/${nqn_name}
> }
> nvmetcli clear
> nqn_name="testnqn_25"
> mkdir /sys/kernel/config/nvmet/hosts/hostnqn
> create_target_multi_disks ${nqn_name} ${target_IP} ${target_port}
>
> And the simulation of high workload program is below:
>
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <unistd.h>
> #include <string.h>
> #include <stdlib.h>
> #include <pthread.h>
> #include <sched.h>
> #define THREAD_NUM  (85)
> #define MALLOC_SIZE (104857600)
> void *loopcostcpu(void *args)
> {
>          sleep(1);
>          int *core_id = (int *)args;
>          cpu_set_t cpuset;
>          CPU_ZERO(&cpuset);
>          CPU_SET(*core_id, &cpuset);
>          sched_setaffinity(0, sizeof(cpuset), &cpuset);
>          nice(-20);
>          long *pt = malloc(MALLOC_SIZE*sizeof(long));
>          if (!pt) {
>                  printf("error malloc\n");
>                  return;
>          }
>          long i = 0;
>          while (1) {
>                  for (i = 0; i < MALLOC_SIZE; i++) {
>                          pt[i] = i;
>                  }
>                  //sleep 10ms
>                  usleep(10000);
>          }
>          return;
> }
> int main(int argc, char *argv[])
> {
>          pthread_t tid[THREAD_NUM];
>          int core_id[THREAD_NUM];
>          int result, i, j = 1;
>          for (i = 0; i < THREAD_NUM; i++) {
>                  core_id[i] = j;
>                  j++;
>                  result = pthread_create(&tid[i], NULL, loopcostcpu,
> 									(void*)
> &core_id[i]);
>                  if (result) {
>                          printf("create thread %d failure\n", i);
>                  }
>          }
>          while(1)
>                  sleep(5);
>          return 0;
> }
>
> When running above program on target testbed, and we reserved 8
> cores(88-95) for nvmet target io threads(both rdma and tcp), then we
> used spdk perf(V20.04) as initiator to create 8 IO queues and per
> queue has 32 queue depths and 1M randrw io size on another testbed
> to verify it.
> TCP's test command shown below:
> ./spdk_perf_tcp -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
> 1048576 -M 50 -r 'trtype:TCP adrfam:IPv4 traddr:169.254.2.104
> trsvcid:4444'
> RDMA's test command shown below:
> ./spkd_perf_rdma -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000 -o
> 1048576 -M 50 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.2.104
> trsvcid:4444'
> And we got below test results:
> TCP's unbound_wq:  IOPS:4585.64, BW:4585.64 MiB/s, Avglat:167515.56us
> TCP's bound_wq:    IOPS:3588.40, BW:3588.40 MiB/s, Avglat:214088.55us
> RDMA's unbound_wq: IOPS:6421.47, BW:6421.47 MiB/s, Avglat:119605.17us
> RDMA's bound_wq:   IOPS:5919.94, BW:5919.94 MiB/s, Avglat:129744.70us
>
> It seems using unbound_wq to decreasing competition of CPU between
> target IO worker thread and other high workload does make sense.

It makes sense for the use case, I agree. What I was asking is to test
outside this use-case, where nvmet is used as a JBOF, and not competing
with other intensive workloads. Does unbound workqueues damage performance?
Back in 2016 it absolutely did.

What I would also want to see is a test that addresses latency sensitive 
workloads, such
that the load is not high with large block size, but rather small block 
size, with medium/low
load and see what is the latency for the two options.

