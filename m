From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 16:22:12 +0300
Subject: BUG at IP: blk_mq_get_request+0x23e/0x390 on 4.16.0-rc7
In-Reply-To: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
References: <10632862.17524551.1522402353418.JavaMail.zimbra@redhat.com>
Message-ID: <682acdbe-7624-14d6-36e0-e2dd4c6b771f@grimberg.me>



On 03/30/2018 12:32 PM, Yi Zhang wrote:
> Hello
> I got this kernel BUG on 4.16.0-rc7, here is the reproducer and log, let me know if you need more info, thanks.
> 
> Reproducer:
> 1. setup target
> #nvmetcli restore /etc/rdma.json
> 2. connect target on host
> #nvme connect-all -t rdma -a $IP -s 4420during my NVMeoF RDMA testing
> 3. do fio background on host
> #fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=180 -size=-group_reporting -name=mytest -numjobs=60 &
> 4. offline cpu on host
> #echo 0 > /sys/devices/system/cpu/cpu1/online
> #echo 0 > /sys/devices/system/cpu/cpu2/online
> #echo 0 > /sys/devices/system/cpu/cpu3/online
> 5. clear target
> #nvmetcli clear
> 6. restore target
> #nvmetcli restore /etc/rdma.json
> 7. check console log on host

Hi Yi,

Does this happen with this applied?
--
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 996167f1de18..b89da55e8aaa 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -35,6 +35,8 @@ int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
         const struct cpumask *mask;
         unsigned int queue, cpu;

+       goto fallback;
+
         for (queue = 0; queue < set->nr_hw_queues; queue++) {
                 mask = ib_get_vector_affinity(dev, first_vec + queue);
                 if (!mask)
--
