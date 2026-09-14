Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64777C88E72
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=akLsKezpLBlOewzmJAX8BgiJSmw+yiko8wWPkOP6Hks=; b=e6zZRS8pD/brzDnpfHDJgnl7cd
	A0hA4ptNipAJcJXFaf3hdbWv1t5d4K3xrIAfR8uMgoAt8DZE5sAHIn0pbXFnA1QEKStGtqDOkJec3
	CVg/boyAlgKcNtA+0msnB2yGfewcwlXlDOsk4y7UA/UXOqXPX0AS+y+eAbvFW3cGWs8+uIW2UJIwx
	sSSsQlCJQYsWdIP4g+bHEru1ZrFjUKKLfF0imqYBfJJ/rTPVsYAPR0b6SlOQvQRRHpoZhZqZcHYP6
	tz+GzfGeBEe+xS2oBsQSdN6aQYOT/5MlwswsiuCdNKN78GVLBnDCWFprm6lnpvJTuXWiTPduW+y5N
	fR+sbPYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6A9c-00000004MRY-2iA9;
	Mon, 14 Sep 2026 17:07:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6A9a-00000004MR0-0FXP
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 17:07:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68EFw07g607811;
	Mon, 14 Sep 2026 17:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=akLsKe
	zpLBlOewzmJAX8BgiJSmw+yiko8wWPkOP6Hks=; b=tq636Yr4/8TmiIRDTLwtTf
	N//j+MDUUs55mgfL97zObdNYhgganttbI4vJ/mis9fBykypslUWVcxaJKPxdKvXt
	aHxxh7vm6dUd7K7xcdigalGSRz9VaQbqTImmEKWEFxoBBjpqjhIH672knOA73qfO
	lYDXQtZXSwCv5bmtUUDpb5W2cyHk3PdqgH0XZnIbf5xbuyks9nmpQTs2YGMwqIgn
	WlxRWX+wAT7a7X0UI+t8mSfADtEC779J81jPL1/SV3EqYlF8RpC94tNMVTdE7hj1
	r1Q3Qw3Xr7RnuA4QNqgcpKKrm+VozzcOmZt+6l426XDNNNBO6la29AMGMgnKUhUw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq2tnt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 17:07:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68EGbIVe2386846;
	Mon, 14 Sep 2026 17:07:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnk9j71bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 17:07:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68EH7L1j31261284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 17:07:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E6415805D;
	Mon, 14 Sep 2026 17:07:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D27B558043;
	Mon, 14 Sep 2026 17:07:17 +0000 (GMT)
Received: from [9.61.162.129] (unknown [9.61.162.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 17:07:17 +0000 (GMT)
Message-ID: <1f41ad0d-89b3-498f-8617-6579dc796d54@linux.ibm.com>
Date: Mon, 14 Sep 2026 22:37:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] nvme-tcp: do not use dynamic lockdep key for socket
 instances
To: Eric Dumazet <edumazet@google.com>
Cc: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@opensource.wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
 <8284b88f-542c-425c-88ec-0486a6393fd1@linux.ibm.com>
 <CANn89i+nzpN0B=yYqYSBxE7VES2CGxinROeeHoFMOZSXJqFz7Q@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANn89i+nzpN0B=yYqYSBxE7VES2CGxinROeeHoFMOZSXJqFz7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfX6uqYiD2DRtDi
 +LKaCB7it+cmDIJLTvWhIp5nMOKkqwgT4wjCZ0JEdexL262emk5zMpUWn0dwRRagF4DRH/HciNK
 pem+Q7mnI16yfxLRvBRJmv0ZX+w/ExnvMdCb0ZBPomRETTBTf4eWkRraLK8aQiYgRQBuzUqOyfA
 5FuulcRc1qs6M+4TUM5Ir8lxncU5bb2rOOJl9td/Xj+fPeUfQJESvr/s2uA9FqcEBGDgTxwPBwq
 jkZ1c788cTfkDf9JubzuYiS3pgB3NmI1gVlkqSxhA+nc7R0Bk6au0Euju7xXeM89sb220yI9yQJ
 4sY3Iyc5yZXouqMaDFTcfCjou1ii/SSP388vxNfDnR/xK5/hJjh+Mn1jBHwsnLf6q2KHJHXpPfg
 JKkBeZz2k4VEtG/mdqlkox3dMqeglvvVJjh2kYyiQzVoXB//8bmqb5W5ojQNb2/by1HPgmRlFFC
 SCqLnyfIpeZfXLkuB6g==
X-Proofpoint-GUID: 589Yx_O4uXwcdA2nm3fwYwRtFgxc2aw1
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa829ca cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JF9118EUAAAA:8 a=UteDf4YdbbQrRDRr3PoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: SCDarP64dxK6drh-Gk0-AlsxShpyoXkL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI0MSBTYWx0ZWRfX33OZOR3MtI7f
 XZqcMkyzzW/iyL5PTGh8NbIn+s/4cJVLVYxgEXP9cOV6IQqWk2PbUAdGolIaPr5RX3dfow8ODDe
 yCQCgbZTciXntQ3lvxnTi3356ROlRG0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140241
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_100738_109794_D940536A 
X-CRM114-Status: GOOD (  41.82  )
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

On 9/14/26 8:28 PM, Eric Dumazet wrote:
> On Mon, Sep 14, 2026 at 7:48 AM Nilay Shroff <nilay@linux.ibm.com> wrote:
>>
>> On 9/14/26 1:18 PM, Shin'ichiro Kawasaki wrote:
>>> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>
>>> Keith and the maintainers, please consider this series for upstream.
>>> The commit 19bdb70c77d3 tried to avoid a lockdep WARN issue, but it
>>> was imperfect. With Eric's help, I propose this series as a better
>>> solution.
>>>
>>> Eric, FYI, I prepared the second patch with your authorship and your
>>> SoB tag. Thanks for the fix idea.
>>>
>>>
>>> Commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep keys per
>>> socket instance") introduced the dynamic lockdep key to avoid a lockdep
>>> WARN. However, it had a bug in lockdep key lifetime management and
>>> caused another WARN [1]. The first patch in this series reverts the
>>> commit to avoid the WARN.
>>>
>>> Reverting 19bdb70c77d3 re-exposes two lockdep WARNs that it had
>>> suppressed. The first one was observed with the blktests test case
>>> nvme/005, which was caused by the lock chain below:
>>>
>>>     set->srcu -> sk_lock -> cpu_hotplug_lock -> fs_reclaim -> q_usage_counter -> elevator_lock -> set->srcu
>>>
>>> This WARN needs no patch in this series: it is already cut by the merged
>>> commit 0ba6912f7e97 by Eric in the v7.3-rc2 tag, which removes the
>>> "sk_lock -> cpu_hotplug_lock" dependency. This series therefore depends
>>> on that commit being present.
>>>
>>> The second WARN was observed with the blktests test case nvme/062, which
>>> was caused by the dependency newly added for TLS support. The second
>>> patch in this series delays the socket reclassification timing to cut
>>> the dependency.
>>>
>>> With this series applied on v7.3-rc2, nvme/005 and nvme/062 pass with no
>>> lockdep splat.
>>>
>> I have just reviewed both the patch in the series and both looks good to me.
>>
>> I also looked at Eric's commits 18666c73afe9 ("tcp: use GFP_ATOMIC in
>> tcp_send_active_reset()") and 0ba6912f7e97 ("Revert once: don't use a work
>> queue to reset sleepable static key"). Both look good to me.
>>
>> However, reverting commit 19bdb70c77d3 ("nvme-tcp: lockdep: use dynamic lockdep
>> keys per socket instance") means that lockdep will no longer be able to distinguish
>> between the socket locks of different nvme-tcp queues. This could unnecessarily
>> create dependency chains between socket locks belonging to different queues,
>> even though those sockets are independent in practice.
> 
> This is not a problem, and there is no need for a per-flow lockdep class.
> 
> Lockdep tracks lock _classes_, not lock instances, by design. All TCP
> sockets in the kernel share "slock-AF_INET"/"sk_lock-AF_INET", and a busy
> machine has millions of them. If lockdep needed a class per socket to
> produce useful reports, networking would have been unusable with
> CONFIG_LOCKDEP=y for the last twenty years.
> 
> Per-instance keys are only warranted when two locks of the same class are
> held at the same time, in a well-defined order. nvme-tcp never holds one
> queue's sk_lock while acquiring another queue's sk_lock, so there is
> nothing to disambiguate. And if such a nesting were ever introduced, the
> right annotation is a lockdep subclass (nested annotation), not a
> dynamically registered key per object.
> 
> Note also that per-instance keys do not make lockdep smarter, they make it
> blind: they remove the ability to detect a real AB/BA between two nvme-tcp
> sockets. Silencing a class of reports before any false positive has been
> demonstrated is the wrong trade.
> 
> The only distinction that has ever been needed here is "in-kernel nvme-tcp
> socket" vs "user socket", which is exactly what 841aee4d75f1 ("nvme-tcp:
> lockdep: annotate in-kernel sockets") provides with static keys. Patch 1
> restores that, and patch 2 moves the reclassification after the TLS
> handshake so tlshd's dependencies are not pulled in.
> 
>>
>> So, while Eric's two commits above should address the lockdep splat reported by
>> blktests nvme/005 (as well as syzbot reported warning), IMO we should still teach
>> lockdep that sockets belonging to different nvme-tcp queues have different lock
>> classes. This would prevent lockdep from constructing dependency chains between
>> unrelated socket instances.
>>
>> I agree with Eric's initial assessment that the lifetime of the nvme-tcp queue and
>> the lifetime of the lockdep key associated with its socket need to be tracked separately.
>> Based on that, perhaps we should consider introducing a separate object to track the
>> socket lockdep key lifetime (separate from nvme-tcp queue object), similar to what
>> Shin'ichiro proposed here:
>> https://lore.kernel.org/lkml/ao2QHIDrGeYjltX9@shinhome/
> 
> I would rather not. My point back then was that 19bdb70c77d3 was buggy
> because sockets outlive the nvme-tcp queue: __fput_sync() does not
> guarantee sk destruction (in-flight packets, TIME_WAIT, RCU-deferred
> sk_free()). The conclusion I draw from that is "do not tie a lockdep key to
> this lifetime at all", not "add a refcounted object whose only purpose is
> to hold a debug-only key".
> 
> Such an object would add allocation, refcounting and teardown paths in
> nvme-tcp that exist only for CONFIG_DEBUG_LOCK_ALLOC=y builds, i.e. code
> that 99% of users never execute and that nobody will keep correct. We
> already have one bug from exactly this, plus the syzbot report. Adding
> more machinery around it is how we get the third one.
> 
> It is also not free at runtime: lockdep has a finite key space
> (MAX_LOCKDEP_KEYS), and lockdep_register_key()/lockdep_unregister_key() are
> heavy operations (graph lock, chain hash zapping, RCU). nvme-tcp creates
> one queue per CPU per controller and re-creates all of them on every
> reconnect. Churning two keys per queue per reconnect is not something we
> should do for a debug feature.
> 
> No other kernel socket user (sunrpc, ceph, rds, iscsi, drbd, ...) does
> this. nvme-tcp should not be the exception.
> 
Makes sense... Thanks for the explanation!

--Nilay


