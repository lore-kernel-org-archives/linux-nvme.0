Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA00C3DA64
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQ3fFs0zirKgueE/jg0W4+3mQDUKFrLvd69SWwZOho8=; b=iEqPRYRwTTny+ojEqBI8S3Nkw7
	/GvXDSb/+6hCOVw7jIj61PSX62KUzM/GP7si+BA8t3kDauniW312iCKnBQ0X0dAiJRJkyYrGb443o
	tNJ+dUGswp4YMiu+2rXAe1OKnFSzVKAt1XpCLbx49fFVfnAnGpo1ggu4pDLe5cunp4Kn5N2SONLjs
	v0FkdesMmVEqai7oAXs40/fHH768qhK2TKxsl7PLeA+d+6N2RWpTlUFdViW2Mi5LLNe3ZyZ6uAUt0
	e3fJ7l4FenmkMk87aFaX2tdXvmtZKmTN8npWv0IWgpKM62nulMVkim+jBnUQ2Nnr3gKSfX4nyA3mD
	IIatacRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saV7M-0000000CmrM-0CKP;
	Sun, 04 Aug 2024 06:53:24 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saV7G-0000000Cmqr-1b6h
	for linux-nvme@lists.infradead.org;
	Sun, 04 Aug 2024 06:53:20 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36841f56cf6so1199872f8f.3
        for <linux-nvme@lists.infradead.org>; Sat, 03 Aug 2024 23:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722754397; x=1723359197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ3fFs0zirKgueE/jg0W4+3mQDUKFrLvd69SWwZOho8=;
        b=RDL+u8WTqXYNmxwlDHF1U9eh2LP4DaOi24j2cZ2mykJogsoDVQd1eVlDf3491TR2/7
         QP9FOsDSO+fq7cDWlE/8FJ4ewwEDh6tQo5kNnpz1YL/QcWmZPTXl8kAr1N4IfbmNu4ad
         5LEWcolJOu4rBnu9ZnjVDY3cPp/tfoMsYhL92We8ldcO5ULAdLg4Sn3KnvjvewDUdGNc
         pPs7OrBVPUd5vKZSl7oGDi35jqnCu4chinJ38fe0VK58EJyv4O8rU3mMGPfRe/oTC/gS
         gSPrHlUzfbRrpPvcPc8i8hDyHSygqKnXvO1xHHZwcNGxn3U0Lb4MFwH/DXXZlDVVfPFs
         Dr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVyc5bGAQ19jQv/61l/3XtFncszyKIqBcI/pAV05AUkjLWagAWqtzXm7zjjp0LlWlyXncUit2bTA4M@lists.infradead.org
X-Gm-Message-State: AOJu0YwCEXKW822QO7SPljpwDraT9AY4P822sqKQ2+R7I0a0PUXm4Fmv
	0/udHq0Xq+nW5UxvYL/hwHjHspdTaEHDpd8PdWwb7ME9K3T//a//
X-Google-Smtp-Source: AGHT+IEMso4KTi2NOFueaIe44ywRC+jaeDCRkIzUDPdeLej2S6FDKEEGrzEg8ImsyWD/NQ172QxWlA==
X-Received: by 2002:a5d:47af:0:b0:35f:2929:8460 with SMTP id ffacd0b85a97d-36bbc0c82e6mr3501231f8f.3.1722754396351;
        Sat, 03 Aug 2024 23:53:16 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e0bcsm5991008f8f.30.2024.08.03.23.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 23:53:15 -0700 (PDT)
Message-ID: <d61a36d8-ed26-43e8-b960-58f458ba13e1@grimberg.me>
Date: Sun, 4 Aug 2024 09:53:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30/2] nvmet: use unbound_wq for RDMA and TCP by default
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de
Cc: ping.gan@dell.com, kch@nvidia.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <ae3047fc-bdeb-4b63-91ac-f4cc39434415@grimberg.me>
 <20240802033952.125753-1-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240802033952.125753-1-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240803_235318_467583_D79EA71D 
X-CRM114-Status: GOOD (  26.44  )
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




On 02/08/2024 6:39, Ping Gan wrote:
>> On 31/07/2024 10:03, Ping Gan wrote:
>>>> On 26/07/2024 5:34, Ping Gan wrote:
>>>>>> On 19/07/2024 12:19, Ping Gan wrote:
>>>>>>> When running nvmf on SMP platform, current nvme target's RDMA and
>>>>>>> TCP use bounded workqueue to handle IO, but when there is other
>>>>>>> high
>>>>>>> workload on the system(eg: kubernetes), the competition between
>>>>>>> the
>>>>>>> bounded kworker and other workload is very radical. To decrease
>>>>>>> the
>>>>>>> resource race of OS among them, this patchset will switch to
>>>>>>> unbounded
>>>>>>> workqueue for nvmet-rdma and nvmet-tcp; besides that, it can also
>>>>>>> get some performance improvement. And this patchset bases on
>>>>>>> previous
>>>>>>> discussion from below session.
>>>>>>>
>>>>>>> https://lore.kernel.org/lkml/20240719084953.8050-1-jacky_gam_2001@163.com/
>>>>>> Hold your horses.
>>>>>>
>>>>>> This cannot be just switched without a thorough testing and actual
>>>>>> justification/proof of
>>>>>> a benefit beyond just a narrow use-case brought initially by Ping
>>>>>> Gan.
>>>>>>
>>>>>> If the ask is to universally use an unbound workqueue, please
>>>>>> provide
>>>>>> detailed
>>>>>> benchmarking convincing us that this makes sense.
>>>>> So you think we should not do a radical change for the narrow
>>>>> usecase
>>>>> but
>>>>> keep the parameter to enable it in previous version patch, right?
>>>> What I'm saying is that if you want to change the default, please
>>>> provide
>>>> justification in the form of benchmarks that support the change.
>>>> This
>>>> benchmarks should include both throughput, iops and latency
>>>> measurements
>>>> and without the cpu-set constraints you presented originally.
>>> We tested it on our testbed which has 4 numa 96 cores, 190GB memory
>>> and 24 nvme disks, it seems unbound_wq has pretty improvment.  The
>>> creating target test script is below:
>>>
>>> #!/bin/bash
>>> if [ "$#" -ne 3 ] ; then
>>> echo "$0 addr_trtype(tcp/rdma) target_IP target_port"
>>> exit -1
>>> fi
>>> addr_trtype=$1
>>> target_IP=$2
>>> target_port=$3
>>> # there are 24 nvme disks on the testbed
>>> disk_list=(nvme0n1 nvme1n1 nvme2n1 nvme3n1 nvme4n1 nvme5n1 nvme6n1
>>> nvme7n1 nvme8n1 nvme9n1 nvme10n1 nvme11n1 nvme12n1 nvme13n1 nvme14n1
>>> nvme15n1 nvme16n1 nvme17n1 nvme18n1 nvme19n1 nvme20n1 nvme21n1
>>> nvme22n1
>>> nvme23n1)
>>> # create target with multiple disks
>>> create_target_multi_disks() {
>>>           local nqn_name=$1
>>>           local svr_ip=$2
>>>           local svr_port=$3
>>>           local i
>>>           local blk_dev
>>>           local blk_dev_idx=0
>>>           local port_idx=25
>>>           echo "create target: $nqn_name $svr_ip $svr_port"
>>>           mkdir /sys/kernel/config/nvmet/subsystems/${nqn_name}
>>>           echo 1
>>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/attr_allow_any_host
>>>           for((i=0;i<${#disk_list[@]};i++)); do
>>>                   blk_dev_idx=$((${blk_dev_idx}+1))
>>>                   blk_dev=/dev/${disk_list[$i]}
>>>                   mkdir
>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}
>>>                   echo  ${blk_dev} >
>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/device_path
>>>                   echo 1 >
>>> /sys/kernel/config/nvmet/subsystems/${nqn_name}/namespaces/${blk_dev_idx}/enable
>>>           done
>>>           mkdir /sys/kernel/config/nvmet/ports/${port_idx}
>>>           echo ${addr_trtype}
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trtype
>>>           echo ipv4
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_adrfam
>>>           echo ${svr_ip}
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_traddr
>>>           echo ${svr_port}
>>>> /sys/kernel/config/nvmet/ports/${port_idx}/addr_trsvcid
>>>           ln -s /sys/kernel/config/nvmet/subsystems/${nqn_name}/
>>> /sys/kernel/config/nvmet/ports/${port_idx}/subsystems/${nqn_name}
>>> }
>>> nvmetcli clear
>>> nqn_name="testnqn_25"
>>> mkdir /sys/kernel/config/nvmet/hosts/hostnqn
>>> create_target_multi_disks ${nqn_name} ${target_IP} ${target_port}
>>>
>>> And the simulation of high workload program is below:
>>>
>>> #define _GNU_SOURCE
>>> #include <stdio.h>
>>> #include <unistd.h>
>>> #include <string.h>
>>> #include <stdlib.h>
>>> #include <pthread.h>
>>> #include <sched.h>
>>> #define THREAD_NUM  (85)
>>> #define MALLOC_SIZE (104857600)
>>> void *loopcostcpu(void *args)
>>> {
>>>           sleep(1);
>>>           int *core_id = (int *)args;
>>>           cpu_set_t cpuset;
>>>           CPU_ZERO(&cpuset);
>>>           CPU_SET(*core_id, &cpuset);
>>>           sched_setaffinity(0, sizeof(cpuset), &cpuset);
>>>           nice(-20);
>>>           long *pt = malloc(MALLOC_SIZE*sizeof(long));
>>>           if (!pt) {
>>>                   printf("error malloc\n");
>>>                   return;
>>>           }
>>>           long i = 0;
>>>           while (1) {
>>>                   for (i = 0; i < MALLOC_SIZE; i++) {
>>>                           pt[i] = i;
>>>                   }
>>>                   //sleep 10ms
>>>                   usleep(10000);
>>>           }
>>>           return;
>>> }
>>> int main(int argc, char *argv[])
>>> {
>>>           pthread_t tid[THREAD_NUM];
>>>           int core_id[THREAD_NUM];
>>>           int result, i, j = 1;
>>>           for (i = 0; i < THREAD_NUM; i++) {
>>>                   core_id[i] = j;
>>>                   j++;
>>>                   result = pthread_create(&tid[i], NULL, loopcostcpu,
>>> 									(void*)
>>> &core_id[i]);
>>>                   if (result) {
>>>                           printf("create thread %d failure\n", i);
>>>                   }
>>>           }
>>>           while(1)
>>>                   sleep(5);
>>>           return 0;
>>> }
>>>
>>> When running above program on target testbed, and we reserved 8
>>> cores(88-95) for nvmet target io threads(both rdma and tcp), then we
>>> used spdk perf(V20.04) as initiator to create 8 IO queues and per
>>> queue has 32 queue depths and 1M randrw io size on another testbed
>>> to verify it.
>>> TCP's test command shown below:
>>> ./spdk_perf_tcp -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000
>>> -o
>>> 1048576 -M 50 -r 'trtype:TCP adrfam:IPv4 traddr:169.254.2.104
>>> trsvcid:4444'
>>> RDMA's test command shown below:
>>> ./spkd_perf_rdma -q 32 -S -P 8 -s 4096 -w randrw -t 300 -c 0xff00000
>>> -o
>>> 1048576 -M 50 -r 'trtype:RDMA adrfam:IPv4 traddr:169.254.2.104
>>> trsvcid:4444'
>>> And we got below test results:
>>> TCP's unbound_wq:  IOPS:4585.64, BW:4585.64 MiB/s, Avglat:167515.56us
>>> TCP's bound_wq:    IOPS:3588.40, BW:3588.40 MiB/s, Avglat:214088.55us
>>> RDMA's unbound_wq: IOPS:6421.47, BW:6421.47 MiB/s, Avglat:119605.17us
>>> RDMA's bound_wq:   IOPS:5919.94, BW:5919.94 MiB/s, Avglat:129744.70us
>>>
>>> It seems using unbound_wq to decreasing competition of CPU between
>>> target IO worker thread and other high workload does make sense.
>> It makes sense for the use case, I agree. What I was asking is to test
>> outside this use-case, where nvmet is used as a JBOF, and not
>> competing
>> with other intensive workloads. Does unbound workqueues damage
>> performance?
>> Back in 2016 it absolutely did.
>>
>> What I would also want to see is a test that addresses latency
>> sensitive
>> workloads, such
>> that the load is not high with large block size, but rather small
>> block
>> size, with medium/low
>> load and see what is the latency for the two options.
> We had done two group tests for unbound_wq and bound_wq; per group had
> 6 round tests which included TCP 1M IO size without other workload,
> TCP 4K IO size without other workload, TCP 4K IO size with medium
> workload(about 45% CPU cost and 25% memory cost), RDMA 1M IO size
> without other workload, RDMA 4K IO size without other workload,
> RDMA 4K IO size with medium workload. And every round test we used
> 8 IO queues, per queue had 32 queue depths and no CPU affinity with
> randrw disk to run 1 hour test and we got below results.
>
> TCP 1M bound_wq:   IOPS:8120.38, BW:8120.38 MiB/s, Avglat:94577.77us
> TCP 1M unbound_wq: IOPS:8236.16, BW:8236.16 MiB/s, Avglat:93248.18us
>
> TCP 4K bound_wq:   IOPS:1326767.00, BW:5182.68 MiB/s, Avglat:578.83us
> TCP 4K unbound_wq: IOPS:952239.52,  BW:3719.69 MiB/s, Avglat:806.49us
>
> TCP 4K with medium workload bound_wq:
>                     IOPS:944414.21, BW:3689.12 MiB/s, Avglat:813.18us
> TCP 4K with medium workload unbound_wq:
>                     IOPS:855103.18, BW:3340.25 MiB/s, Avglat:898.11us
>
> RDMA 1M bound_wq:  IOPS:10111.35, BW:10111.35 MiB/s, Avglat:75954.55us
> RDMA 1M unbound_wq:IOPS:10108.84, BW:10108.84 MiB/s, Avglat:75973.39us
>
> RDMA 4K bound_wq:  IOPS:2645207.01, BW:10332.84 MiB/s, Avglat:290.31us
> RDMA 4K unbound_wq:IOPS:2644785.78, BW:10331.19 MiB/s, Avglat:290.35us
>
> RDMA 4K with medium workload bound_wq:
>                     IOPS:2595758.58, BW:10139.68 MiB/s, Avglat:295.84us
> RDMA 4K with medium workload unbound_wq:
>                     IOPS:2551177.45, BW:9965.54 MiB/s, Avglat:301.01us
>
> It seems in TCP small block size case the unbound_wq has tremendous
> performance drop.

That is consistent with what I saw back in 2016.

>   So I think we should not radically change the default
> workqueue as unbounded but keep the previous patch with parameter to
> support the narrow case for performance improvement.

Interestingly though, rdma does not seem to have the same 
characteristics, although
I do expect that in *some* workloads the overhead is meaningful.

My position is that this change should be presented as a modparam. In 
the long run, I'd think
we want to introduce polling threads to nvmet and move the scheduling to 
it, but it is a larger project,
and when when that happens, I'd rather deprecate the modparam instead of 
introducing this change
that impacts performance in any meaningful way.

