Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEEDD2502F
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Jan 2026 09:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DzkjtoKrjv1m2dJZv34E0w1zhtTVXdLL7YhctfNiGQY=; b=DTNVipgqZi7kv5X2lSvEha1QHP
	bPcDNY5jmjmKnt+e7C9ymG8YDUihxq0xxoExSIXtXc41DgHyQf7w2FGNRIKISEG5TZtEZ22av5in4
	rakfrhmLurJZJJAUhQOnImBDzUKUrRxhcfSNNEUhAfM89HOi6qxmk/JH20HuJTvIfiVITwjHN8niK
	lr5uLoZqbSV2gbD3iAkTQovvnDoaYRQfwIDjyN9E6UGHVCmGHPV3/RVPYPZs5VGZ/tcH9/mnt1Orv
	ljC/x/zRNUWtzAs1rr1FW00Ad7ZGFCm6Z6MXZ8WTtjjxMoJdXK8c78ad0CwVYsSIstf4v31iOT45W
	L8b971/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1verq6-000000044G8-1Atr;
	Sun, 11 Jan 2026 09:34:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1verq4-000000044G1-16JT
	for linux-nvme@bombadil.infradead.org;
	Sun, 11 Jan 2026 09:34:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=DzkjtoKrjv1m2dJZv34E0w1zhtTVXdLL7YhctfNiGQY=; b=LMAAaMQgAg2pc7Jcr/C4RzeEV2
	d8s4qVEKAUE2hTIUjsjzJ8BeYRVW9dT06TWgxpHEfky9z2CmtSMUZIRTR6C5xNiG4lwGychxcw/oS
	tcYD1D7XPexF6aGqdtVd0FP8qU/ClmopFVGoZ/BmhGDKYa4pNumCiYSdh/shj60ksYzHcjE/fQVLB
	rgh7dDXD9z5uWsYgFONC04G4QEQd+wsqHcdTdjZzvwtNYdzbyGy5ATaFTEV6zplMv1vttNe0lUssa
	DpukSH7FtwIXywbRLp5fFHCtcODyy1Q2fY95MJxU8tWgJ7fddhZLMEzK1v++jI0UiOIk9dRbIkirQ
	vqkkMMCg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1verq0-0000000Gxs7-33CT
	for linux-nvme@lists.infradead.org;
	Sun, 11 Jan 2026 09:34:23 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60AAtXgt003748;
	Sun, 11 Jan 2026 09:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dzkjto
	Krjv1m2dJZv34E0w1zhtTVXdLL7YhctfNiGQY=; b=BkG6sJHNMvW44YaZRW9IwA
	am67Ph5u7tIO/npYpqa7P9r1hdGt8p07b4MtFDZxd6///kPFAIPLu/ZVKktMebNF
	nfomDlVgk6b1lCHfB1sK8ahLzjMkCBk9/XGidbfm2BYlvxs3zZTnSWncM8xo6Q8f
	CgkgLQWFsIhObq2zK5upwECxCczkPZ/KEgGLvvTGkyzbJBE+KukekoJeE3EpAedJ
	4IQL8+/6iTe0ICHHS2Oiy10Ue2wIw7WpDzIYu0RK0w3qBw6rFEB+5MMz/+QEQb6r
	3Z609waLbFdywEj/L8aarFVlwPASDcC5D72JHFZ3ViHOBNoZmbDyAyyjsn1Dwkpg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkeg43c56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jan 2026 09:33:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60B8Y5jY029743;
	Sun, 11 Jan 2026 09:33:54 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3aj914v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Jan 2026 09:33:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60B9XqNu12255756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Jan 2026 09:33:52 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DA565804E;
	Sun, 11 Jan 2026 09:33:52 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EAD75803F;
	Sun, 11 Jan 2026 09:33:46 +0000 (GMT)
Received: from [9.111.75.249] (unknown [9.111.75.249])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 11 Jan 2026 09:33:45 +0000 (GMT)
Message-ID: <833fd772-da6c-4f91-87e3-e13883f1815d@linux.ibm.com>
Date: Sun, 11 Jan 2026 15:03:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <wagi@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ewan Milne <emilne@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <8574c297-fc02-40d6-ba67-ab43e3d5e394@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <8574c297-fc02-40d6-ba67-ab43e3d5e394@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTExMDA4MyBTYWx0ZWRfXzWbR2P2rqSXp
 +YfnCWdNQAfyNc7hRlWteC9xBkMwJ7u9wR1NvAbM0qdBrq/+zfrKDf/m7MrbAApADHkku2wF9rI
 6V3ijwuppgCNKlecMOrkzvm+PEAKmFXm5K3f/DHJaOSe2M4eF85DMHr3kaF2HCLcNnfN4GgS/Ly
 zdEjGiN8zGDR2ioDYkSbco6tXw2QZrXcM0z/MZJrmCXS3DUeqtCOuQvsQ1XGwOzmkmajwARVl1z
 8MHosOyRUtqsovX17n9oan22ozpndbQFdUkkgmErXUfWPPwxfK8Ho0HVUVMrUAwnlj7ljw8/IMi
 UYGmKB5yHbvR93un8lM+bMuKFra8q51RHe/DntEZFNajJURhEl9/mSdcz1yWoT86O2WEMni5/GJ
 qCjHLMJvioICGp42LaAR1Dlts0+ctIJvSBV0F2sfbT0cd4xPOdVnQGofWv7sY8lQB6GnN5W5XBQ
 Jg244XD5t5X9NmT1bbg==
X-Proofpoint-ORIG-GUID: gotUgaBsAhywBiS7bIj_ZAu0ifDxhHhY
X-Authority-Analysis: v=2.4 cv=B/60EetM c=1 sm=1 tr=0 ts=69636e83 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=KNIaPvg0B0HtyHoiZVoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gotUgaBsAhywBiS7bIj_ZAu0ifDxhHhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-11_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601110083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_093421_403874_AC6DF320 
X-CRM114-Status: GOOD (  28.92  )
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



On 1/10/26 12:48 AM, John Meneghini wrote:
> Unfortunately, it has been discovered that this patch causes a serious regression on powerpc platforms.
> 
> If anyone has a powerpc platform with an NVMe/PCIe device installed, please run this simple test and see if it works.
> 
> # uname -av
> Linux rdma-cert-03-lp10.rdma.lab.eng.rdu2.redhat.com 6.19.0-rc4+ #1 SMP Wed Jan  7 21:42:54 EST 2026 ppc64le GNU/Linux
> 
> # nvme list-subsys /dev/nvme0n1
> nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
>                iopolicy=numa
> \
>  +- nvme0 pcie 0018:01:00.0 live optimized
> 
> # nvme subsystem-reset /dev/nvme0; nvme list-subsys /dev/nvme0n1; sleep 1; nvme list-subsys /dev/nvme0n1; nvme list-subsys /dev/nvme0n1;
> nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
>                iopolicy=numa
> \
>  +- nvme0 pcie 0018:01:00.0 resetting optimized
> [Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
> [Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
> [Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
> [Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
> [Wed Jan  7 21:59:51 2026] block nvme0n1: no usable path - requeuing I/O
> 
> # nvme list-subsys /dev/nvme0n1;
> 
> # nvme list-subsys /dev/nvme0n1;
> nvme-subsys0 - NQN=nqn.1994-11.com.samsung:nvme:PM1735:HHHL:S4WANA0R400032
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:1654a627-93b6-4650-ba90-f4dc7a2fd3ee
>                iopolicy=numa
> \
>  +- nvme0 pcie 0018:01:00.0 resetting optimized
> 
> At this point the machine is HUNG. It's stuck in the resetting state forever.
> 
> Because /dev/nvme0n1 is the root device, I need to power-cycle/reboot the host to recover.
> /John
> 
> On 2/14/25 3:02 AM, Daniel Wagner wrote:
>> The fabric transports and also the PCI transport are not entering the
>> LIVE state from NEW or RESETTING. This makes the state machine more
>> restrictive and allows to catch not supported state transitions, e.g.
>> directly switching from RESETTING to LIVE.
>>
>> Signed-off-by: Daniel Wagner <wagi@kernel.org>
>> ---
>>   drivers/nvme/host/core.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 818d4e49aab51c388af9a48bf9d466fea9cef51b..f028913e2e622ee348e88879c6e6b7e8f8a1cc82 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -564,8 +564,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>>       switch (new_state) {
>>       case NVME_CTRL_LIVE:
>>           switch (old_state) {
>> -        case NVME_CTRL_NEW:
>> -        case NVME_CTRL_RESETTING:
>>           case NVME_CTRL_CONNECTING:
>>               changed = true;
>>               fallthrough;
>>
> 
This was broken because with this commit d2fe192348f9 (“nvme: only allow entering LIVE
from CONNECTING state”) now we don't allow changing controller state from 
RESETTING -> LIVE. I saw we also had similar state change issue with firmware activation 
code which was fixed by explicitly transitioning the controller state through RESETTING ->
CONNECTING -> LIVE. We may employ the similar solution here for subsystem reset case as well. 

Currently, the NVMe PCIe subsystem reset code performs the following steps:

1. Sets the controller state to RESETTING
2. Writes the subsystem reset command to the NSSR register
3. Attempts to transition the controller state directly to LIVE

This effectively bypasses the CONNECTING state. The transition to LIVE is artificial but
intentional, since writing to the NSSR register causes the loss of communication with the
NVMe adapter and the controller must be marked LIVE so that any in-flight I/O at the time the
subsystem reset is issued, or an explicit MMIO read, can trigger EEH recovery and ultimately
restore communication link between the NVMe adapter and the system.

With the stricter state transition rules introduced by commit d2fe192348f9 (“nvme: only allow
entering LIVE from CONNECTING state”), the direct transition from RESETTING -> LIVE is no longer
permitted, rendering the current logic ineffective.

Taking a cue from the firmware activation fix, it seems reasonable to explicitly transition
the controller state through CONNECTING in the subsystem reset path as well. So how about making
the following change to fix this? 

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0e4caeab739c..3027bba232de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1532,7 +1532,10 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
        }
 
        writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
-       nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
+
+       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
+           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
+               goto unlock;
 
        /*
         * Read controller status to flush the previous write and trigger a

Thanks,
--Nilay

