Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB420FF8860
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XbDi2z1s+YTXeAQt3bekRi5/9PNxi5YQWmpvK+hrgSo=; b=dKy4TxDOytLE4GfjaTnEJz7Tvu
	CB6pKxRdsezqPWt9l/0wIQ/HelWFSEi4dWkAOjViBflPr0sWUgCsKelP/GQyIBAHGxzogTfzFfACK
	gM4nBEwIebjC0lwWidEcsRBlcHxlLVIS4Omrdp5/dlvTSXxsQ3xKwHFhl5eySM/XusM3QYdy9dART
	MwVlT/6yKa4/buM/TNH1ovTIpb7yuZSD5N0eG11zsCFkfhAL/m+NtdLH+bfdn8GdaCqrUGmfPfA7w
	Kj/MFSX9JaUb8vc6UzPfkqDM1npwIr2nyrDQtvyePMr/91Gw5ReWKFAhCOIyS+k0cs/BwVDP7en/e
	Ez2TSUuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKbI-0000000Gq7a-0yrF;
	Mon, 27 Apr 2026 11:58:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKbF-0000000Gq73-1rx3
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 11:58:07 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8J9fk1892388;
	Mon, 27 Apr 2026 11:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XbDi2z
	1s+YTXeAQt3bekRi5/9PNxi5YQWmpvK+hrgSo=; b=rrEvh+Tf/JcAwteZRJxHKd
	9wGoACJxQRj0t20VF2GZR4p6l8rDA8zIALqEFPDjU3aQRCC92p6WJImYgEOTcxex
	l6aSPOd7T9eo2CcvjGQYGA355qx1O7nx8bAsuWcI5OS/4BgudY5Vx+lsrKm5NitH
	aggDHOH1NQxEI/1F9ivURnlYr/RRdi22aAxkT/kcxnixAN8VgICbOOFD2ixIdDaH
	jL0vH8NyGrAGTeCu7nECZdBGTYyKWVUL8z3AdfYIKMSG2yO7UdQxWjlinJY7nVNb
	DKbTujatU87m3PkXliCG4bNmy10TJjoBX7xBNhZUxPC8IdKIbIvBD7xHd+LggZfA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dqfbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 11:57:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RBriAA007250;
	Mon, 27 Apr 2026 11:57:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xq549j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 11:57:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RBvpN013632010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 11:57:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 441895805D;
	Mon, 27 Apr 2026 11:57:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA43758057;
	Mon, 27 Apr 2026 11:57:48 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 11:57:48 +0000 (GMT)
Message-ID: <7f4742bb-9e5a-41ff-b8fd-cb846ef64538@linux.ibm.com>
Date: Mon, 27 Apr 2026 17:27:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] nvme-tcp: optionally limit I/O queue count based
 on NIC queues
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <20260420115716.3071293-2-nilay@linux.ibm.com>
 <67c5a032-4ba6-4dbb-bc48-072d82c3fbd0@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <67c5a032-4ba6-4dbb-bc48-072d82c3fbd0@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 184Lh7k9myn_AicRiW4_fwzzU_xKpZoA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyNSBTYWx0ZWRfX3EttV0joGhfz
 SS6Qp3LqN+UTL7xvaU7uHlFg5DS/yQQQRzwoU6aZqH1rke2L7ZkxthOjjR8mP+6O0aId5iL1l96
 3l7U1sWgZGHT5LsWmojqczW266ZsNMbUyLKGKJnEcfcRVpKhqJmmy7oCTQzyL3y6t0oIbgDvfJp
 45HVEPAjIOqSoyPe9vgQQkwoqdoTKyZdr7DFAf/ccZ9+W1UB5s1CLnBfqg+c0HNTY2ynfBpqWN2
 b/vILaLMfOVOMY4IcaYFyMYVmH/0BHobniGX8qzucZcZAI68ETr1AqM+4ihARY8tF/qvvUSFUoO
 Ufgk5ga1rjKx7nY/MMlxkC6aBuDyFd2Yz0xP//NUR/SqSOfGvsW5GTYMAZDddtWERSOvIzUrNef
 rpzYJMPIMSDX/smA404tQyVy421nVxkIbNt3KeCXnuMRVu+xEJOzrx1kjTzcsa68YZmud0gf49d
 ReTEwxIH4ytjjSSK3mw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69ef4f41 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=wZFfM1RX0dFLWaceufAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 184Lh7k9myn_AicRiW4_fwzzU_xKpZoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_045805_670232_C26F9E7D 
X-CRM114-Status: GOOD (  45.92  )
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

On 4/25/26 3:40 AM, Sagi Grimberg wrote:
> 
> 
> On 20/04/2026 14:49, Nilay Shroff wrote:
>> NVMe-TCP currently provisions I/O queues primarily based on CPU
>> availability. On systems where the number of CPUs significantly exceeds
>> the number of NIC hardware queues, this can lead to multiple I/O queues
>> sharing the same NIC TX/RX queues, resulting in increased lock
>> contention, cacheline bouncing, and inter-processor interrupts (IPIs).
> 
> Yes, I agree it is very inefficient to create something like 192 queues in practice.
> Nevermind that this is pretty much never the case because real controllers
> will limit the number of IO queues to something much lower than that,
> in the majority of cases probably a handful or more.
> 
Yes, it may not always be possible (or meaningful) to have a 1:1 mapping
between NVMe/TCP I/O queues and the real controller’s internal queues.

The intent here is not to enforce such a mapping, but rather to improve
host-side locality. Even when the controller limits the number of I/O queues,
mismatch with NIC queue topology can still lead to multiple I/O workers
contending on the same TX/RX queues. This change tries to avoid such
over-subscription on the host side.

> Please note that this is very much in common with RDMA, so the
> patch series should probably address both.
> 
Yes agreed — the model in RDMA is more tightly coupled to hardware resources.
It probably makes sense to consider that separately, as the problem space is
simpler and the mapping is more direct.

>>
>> In such configurations, limiting the number of NVMe-TCP I/O queues to
>> the number of NIC hardware queues can improve performance by reducing
>> contention and improving locality. Aligning NVMe-TCP worker threads with
>> NIC queue topology may also help reduce tail latency.
> 
> As mentioned, from what I know, when using real nvmf arrays, the number of
> queues will usually be much lower than both the cpu count as well as the NIC hw
> queues.
> 
>>
>> Add a new transport option "match_hw_queues" to allow users to
>> optionally limit the number of NVMe-TCP I/O queues to the number of NIC
>> TX/RX queues. When enabled, the number of I/O queues is set to:
>>
>>      min(num_online_cpus, num_nic_queues)
>>
>> This behavior is opt-in and does not change existing defaults.
> 
> In my mind, there is no real reason for an opt-in. The opt-in should
> probably be if the user actually wants to use num_online_cpus() worth of queues (e.g. user explicitly asked for nr_io_queues).
>>
Yes that makes sense, but in certain complex typologies such as host
running inside QEMU or stacked network devices, it may not be possible
to find the real num of tx/rx queues exposed by real NIC cards. So for
such cased we may not want to alter the existing behavior and hence
I choose to support opt-in.

>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/fabrics.c |   4 ++
>>   drivers/nvme/host/fabrics.h |   3 +
>>   drivers/nvme/host/tcp.c     | 120 +++++++++++++++++++++++++++++++++++-
>>   3 files changed, 126 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index ac3d4f400601..62ae998825e1 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -709,6 +709,7 @@ static const match_table_t opt_tokens = {
>>       { NVMF_OPT_TLS,            "tls"            },
>>       { NVMF_OPT_CONCAT,        "concat"        },
>>   #endif
>> +    { NVMF_OPT_MATCH_HW_QUEUES,    "match_hw_queues"    },
>>       { NVMF_OPT_ERR,            NULL            }
>>   };
>> @@ -1064,6 +1065,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>>               }
>>               opts->concat = true;
>>               break;
>> +        case NVMF_OPT_MATCH_HW_QUEUES:
>> +            opts->match_hw_queues = true;
>> +            break;
>>           default:
>>               pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>>                   p);
>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>> index caf5503d0833..e8e3a2672832 100644
>> --- a/drivers/nvme/host/fabrics.h
>> +++ b/drivers/nvme/host/fabrics.h
>> @@ -67,6 +67,7 @@ enum {
>>       NVMF_OPT_KEYRING    = 1 << 26,
>>       NVMF_OPT_TLS_KEY    = 1 << 27,
>>       NVMF_OPT_CONCAT        = 1 << 28,
>> +    NVMF_OPT_MATCH_HW_QUEUES = 1 << 29,
>>   };
> 
> No need for the above in my mind.
> 
>>   /**
>> @@ -106,6 +107,7 @@ enum {
>>    * @disable_sqflow: disable controller sq flow control
>>    * @hdr_digest: generate/verify header digest (TCP)
>>    * @data_digest: generate/verify data digest (TCP)
>> + * @match_hw_queues: limit controller IO queue count based on NIC queues (TCP)
>>    * @nr_write_queues: number of queues for write I/O
>>    * @nr_poll_queues: number of queues for polling I/O
>>    * @tos: type of service
>> @@ -136,6 +138,7 @@ struct nvmf_ctrl_options {
>>       bool            disable_sqflow;
>>       bool            hdr_digest;
>>       bool            data_digest;
>> +    bool            match_hw_queues;
>>       unsigned int        nr_write_queues;
>>       unsigned int        nr_poll_queues;
>>       int            tos;
>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>> index 243dab830dc8..7102a7a54d78 100644
>> --- a/drivers/nvme/host/tcp.c
>> +++ b/drivers/nvme/host/tcp.c
>> @@ -16,6 +16,8 @@
>>   #include <net/tls.h>
>>   #include <net/tls_prot.h>
>>   #include <net/handshake.h>
>> +#include <net/ip6_route.h>
>> +#include <linux/in6.h>
>>   #include <linux/blk-mq.h>
>>   #include <net/busy_poll.h>
>>   #include <trace/events/sock.h>
>> @@ -1762,6 +1764,103 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>>       return ret;
>>   }
>> +static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl)
>> +{
>> +    struct net_device *dev = NULL;
>> +
>> +    if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
>> +        dev = dev_get_by_name(&init_net, ctrl->opts->host_iface);
>> +    else {
>> +        struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
>> +
>> +        if (tctrl->addr.ss_family == AF_INET) {
>> +            struct rtable *rt;
>> +            struct flowi4 fl4 = {};
>> +            struct sockaddr_in *addr =
>> +                    (struct sockaddr_in *)&tctrl->addr;
>> +
>> +            fl4.daddr = addr->sin_addr.s_addr;
>> +            if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
>> +                addr = (struct sockaddr_in *)&tctrl->src_addr;
>> +                fl4.saddr = addr->sin_addr.s_addr;
>> +            }
>> +            fl4.flowi4_proto = IPPROTO_TCP;
>> +
>> +            rt = ip_route_output_key(&init_net, &fl4);
>> +            if (IS_ERR(rt))
>> +                return NULL;
>> +
>> +            dev = dst_dev(&rt->dst);
>> +            /*
>> +             * Get reference to netdev as ip_rt_put() will
>> +             * release the netdev reference.
>> +             */
>> +            if (dev)
>> +                dev_hold(dev);
>> +
>> +            ip_rt_put(rt);
>> +
>> +        } else if (tctrl->addr.ss_family == AF_INET6) {
>> +            struct dst_entry *dst;
>> +            struct flowi6 fl6 = {};
>> +            struct sockaddr_in6 *addr6 =
>> +                    (struct sockaddr_in6 *)&tctrl->addr;
>> +
>> +            fl6.daddr = addr6->sin6_addr;
>> +            if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR) {
>> +                addr6 = (struct sockaddr_in6 *)&tctrl->src_addr;
>> +                fl6.saddr = addr6->sin6_addr;
>> +            }
>> +            fl6.flowi6_proto = IPPROTO_TCP;
>> +
>> +            dst = ip6_route_output(&init_net, NULL, &fl6);
>> +            if (dst->error) {
>> +                dst_release(dst);
>> +                return NULL;
>> +            }
>> +
>> +            dev = dst_dev(dst);
>> +            /*
>> +             * Get reference to netdev as dst_release() will
>> +             * release the netdev reference.
>> +             */
>> +            if (dev)
>> +                dev_hold(dev);
>> +
>> +            dst_release(dst);
>> +        }
>> +    }
> 
> This looks like a helper that should be outside of nvme-tcp.
> Nothing specific to it here. Something like dev_get_by_dstaddr()

Yeah, in another thread Christoph also had similar opinion. So I'd
add a helper under net/.

>> +
>> +    return dev;
>> +}
>> +
>> +static void nvme_tcp_put_netdev(struct net_device *dev)
>> +{
>> +    if (dev)
>> +        dev_put(dev);
>> +}
>> +
>> +/*
>> + * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
>> + * be determined.
>> + */
>> +static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
>> +{
>> +    struct net_device *dev;
>> +    int tx_queues, rx_queues;
>> +
>> +    dev = nvme_tcp_get_netdev(ctrl);
>> +    if (!dev)
>> +        return 0;
>> +
>> +    tx_queues = dev->real_num_tx_queues;
>> +    rx_queues = dev->real_num_rx_queues;
> 
> I can see various ways how this can get wrong with the variety of stacked network
> devices. For example for bonding, this can easily diverge with the slave devices
> queues (in theory at least). Also vlan/vxlan devices will also not represent the
> real hw queues iirc.
> 
> This is a good example of how nvme-tcp is different than the other drivers.
> It sits on top of an abstraction layer, which prevents it from "not getting it wrong".
> It may get it right *some* of the time, but it can also get it wrong...
> 
> Maybe an explicit optin is warranted here...
> I would not be against having this approach in case an explicit opt-in is passed
> by the user I suppose.
> 
Yes so this is the _real_ reason why I proposed opt-in.

> btw such an approach would be much more robust in nvme-rdma which
> does not see this set of abstractions.
> 
> One thing that I will comment in addition, is that nvme-tcp is likely to
> see *multiple* controllers (HA fundamentals for nvmf arrays), so I think that
> improving performance in this scenario would be much more impactful.

Hmm, yes really good point. This patch focuses on improving per-controller
locality, but I agree that coordinating resource usage across controllers
sharing the same NIC could provide additional benefits. This seems like a
natural next step, thanks for highlighting this. I will address this in
a separate patch, once current work is accepted.

Thanks,
--Nilay


