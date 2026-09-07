Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD01C79F9E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/TSTbStenYNmkwzCBdUyEcXtY08ZuCRAcrpLdm4VEyo=; b=uAXYBGezeHCKOnTK1+mlyQiBxM
	no+Rtjt1vCXukBduzJ5o7O+00ib4Cwrr02iBsMQab+kswNIConoaIDRRC8oHnoquVofSnBr016Tp8
	PRcCxYZBvxI7/Jh+auqW4XPtUi7jhnwVKeQtMebbT3UHBaX+96VFGSGZjHEcz44KqCUhSwpSSkLT0
	ZiSUhRp6d2niCY4KdWfHftZE0o4PnVCxbdzpQaUzMEekagVP0dmOCK46J08f0h/B6wz086hTmasrY
	F9RqW+ekUPUas98zMN+/mM9LWtxawwBQY4NrO5zbNw36V4UWAhQ262Vif38XZOEdl3fEZXyvak+lW
	vRpnNuxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3ZCX-00000006udS-0G74;
	Mon, 07 Sep 2026 13:15:57 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3ZCU-00000006ucl-1UED
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 13:15:55 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687B1jSZ1785414;
	Mon, 7 Sep 2026 13:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/TSTbS
	tenYNmkwzCBdUyEcXtY08ZuCRAcrpLdm4VEyo=; b=DMzCv+HpwRBeJpqhDoT6it
	Fn0eRgR8rou/3ugAEwl3/4WYTC3g+vbAKovO1ul1JhHbO56BZbKcRGKe6q+XigdK
	aUzCAjNVB3a7ltBZWlrZC4IBYHv8pOmElbuHJhwOsO05W95TqZEU3uFD4Ug1JeDv
	06KS9FskVrItUuG91ZfoeBx1vvGijDNIxw+CQJ3/NO0Mc6GnrJfGh4tkqp7ILnTx
	vdoEwvBW52AUFi2/Mrg0jvtAjB/sR5uYdZxZZwgO/ki4s6GT+fW/DutZts+/ue1j
	msYrk6PMYLTAKqk1KLIXdb2LcTzAEXTbI3TyWgcCtBgAnVOfv9/2U4hdbhde7zCA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf3rwcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 13:15:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687DBHwK005937;
	Mon, 7 Sep 2026 13:15:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdq68f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 13:15:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687DFS7B54919454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 13:15:28 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6213558058;
	Mon,  7 Sep 2026 13:15:28 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C17B58057;
	Mon,  7 Sep 2026 13:15:25 +0000 (GMT)
Received: from [9.61.43.34] (unknown [9.61.43.34])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 13:15:24 +0000 (GMT)
Message-ID: <84112f53-5c05-46ca-97d0-550565fb941c@linux.ibm.com>
Date: Mon, 7 Sep 2026 18:45:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail
 queued I/O
To: Krishna Iyer <kiyer@crusoe.ai>, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        sj@kernel.org, saravanand@crusoe.ai
References: <20260904032605.65758-1-kiyer@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260904032605.65758-1-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -bPbKPZ8cYf-JRgV45mmzLgyg_w4bRzT
X-Proofpoint-GUID: -bPbKPZ8cYf-JRgV45mmzLgyg_w4bRzT
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6a9eb8f1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=i89cb_tVjrOSbL2ZDJYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfX/nxdTPEzqAqo
 CcJkBd97I0lszyQsW1XiGE/2rzFBobmcrRZ6IODzIKYVa4hgzzti4hKVFUkY01jTPzBcnrAtsLc
 T/c/37Hg8g65KoF5Mj/DnC0NkQFFjSz0uP0ae4+Vy1lkKt9fJE4t22Qnoz5WErXEZO8CdBEyF3Y
 SRpjBFoUcAiM8IsOqQry38iRgmROtapsEJAppKQquW2snjECbt1RX/CyjXQC2sYNrMByjNi+DJD
 raeYm4veIJeq9Loq8LRdYEqzehMvniQG5THGLzCbpXz3/eLTk5SThawUCHUlTi05NKligU5FmBt
 vG8SFxa3SPMSU/uNr+YezXtUTN537GljIbQkAMRdkJcoSwcIIxaTXIhUK2GfTUBUQISY5b1aEC3
 8PCszz4klnqiMsw6xSprKXwq7sovnZ4hm4okuWZCGufsMMBhdVe+Ty6hwoGaLzloXXWYJqtQ55R
 7rIBaAgtCq1asHbSGkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0NCBTYWx0ZWRfX6dwgYqdtMByv
 oBWXj8FKpQNyQC0DS1CNZVsfgxbquxBdvizutXrCTgfOHEvFW0QiC7cSwA8dLxTuJQC3EDAYVO7
 d2Br+Uwg3VtKaOI3j5V+glABBKLJ3YE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_061554_410918_1254B325 
X-CRM114-Status: GOOD (  43.42  )
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

On 9/4/26 8:56 AM, Krishna Iyer wrote:
> When all paths to a multipath namespace are down, I/O is held on the
> head requeue list until a path returns. With ctrl_loss_tmo=-1 the
> controllers reconnect forever, so during a long fabric outage the I/O
> is held indefinitely and any process waiting on it sleeps in D state
> until the fabric heals or the host is rebooted. We hit this on
> virtualization hosts, where a SIGKILLed VM process cannot exit because
> it is still draining I/O to an unreachable NVMe/TCP target.
> 
> There is currently no way to fail this I/O without tearing something
> down. Deleting the controller (or letting ctrl_loss_tmo expire) works
> but takes every namespace on the controller with it and requires a
> manual reconnect afterwards. fast_io_fail_tmo only arms on the
> RESETTING -> CONNECTING transition, so it cannot be set once the
> outage has started. delayed_removal_secs only matters after all
> controllers are gone, which never happens with ctrl_loss_tmo=-1.
> dm-multipath has had "dmsetup message <dev> 0 fail_if_no_path" for
> this for decades; nvme multipath has no equivalent.
> 
> Add a fail_io_now attribute on the ns-head disk. Writing a true value
> sets NVME_NSHEAD_FAIL_IO_NOW, synchronizes SRCU so submitters see it,
> and kicks the requeue work. nvme_available_path() treats the flag as
> no path available, so the existing bio_io_error() branch fails the
> parked and any newly arriving I/O, for that namespace only. Controller
> state is not touched: reconnect attempts continue and other namespaces
> on the controller keep queueing. The flag is cleared in
> nvme_mpath_set_live() when a path comes back, like
> NVME_CTRL_FAILFAST_EXPIRED.
> 
> Locking, SRCU usage and sysfs visibility follow the neighboring
> delayed_removal_secs attribute; input parsing follows
> io_passthru_err_log_enabled (kstrtobool, shows on/off). Validated on
> real hardware with a 6.17 backport of this change.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
> ---
> Testing notes: the 6.17 backport was exercised on a virtualization
> host with a two-path NVMe/TCP namespace connected with
> ctrl_loss_tmo=-1. With both target portals firewalled off and a
> SIGKILLed VM process stuck in D state on the parked I/O, the process
> stayed unreapable for over six minutes; delayed_removal_secs=60,
> armed before the outage, never triggered since the controllers were
> CONNECTING throughout. Writing fail_io_now released the process in
> about two seconds, the reconnect loop was undisturbed, and once the
> firewall was removed the paths came back live and the attribute read
> back off on its own. A namespace on a second subsystem kept the
> default queueing behavior throughout. This posting is compile-tested
> (including W=1) on nvme-next.
> 
>   drivers/nvme/host/multipath.c | 62 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  2 ++
>   drivers/nvme/host/sysfs.c     |  4 ++-
>   3 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index fc6800a9f7f9..a026bdfb9d7f 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -482,6 +482,15 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
>   		return false;
>   
> +	/*
> +	 * The user requested any I/O queued or arriving while no path is
> +	 * usable to be failed immediately (e.g. to release I/O held for a
> +	 * fabric that retries reconnection indefinitely). The flag is
> +	 * cleared when a path becomes live again.
> +	 */
> +	if (test_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags))
> +		return false;
> +
Does the intention here is to force I/O to fail irrespective of the
controller state, or the intention here's to fail I/O only when no
usable path exist? If it's latter then I believe this is not the right
place to enforce this policy as since this check makes nvme_available_path()
return false unconditionally when NVME_NSHEAD_FAIL_IO_NOW is set, without
considering whether a usable path exists.

>   	list_for_each_entry_srcu(ns, &head->list, siblings,
>   				 srcu_read_lock_held(&head->srcu)) {
>   		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
> @@ -780,6 +789,12 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
>   	if (!head->disk)
>   		return;
>   
> +	/*
> +	 * A path is usable again, restore the default queue-if-no-path
> +	 * behavior in case fail_io_now was set during a fabric outage.
> +	 */
> +	clear_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags);
> +
>   	/*
>   	 * test_and_set_bit() is used because it is protecting against two nvme
>   	 * paths simultaneously calling device_add_disk() on the same namespace
> @@ -1168,6 +1183,53 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
>   
>   DEVICE_ATTR_RW(delayed_removal_secs);
>   
> +static ssize_t fail_io_now_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +
> +	return sysfs_emit(buf, test_bit(NVME_NSHEAD_FAIL_IO_NOW,
> +			&head->flags) ? "on\n" : "off\n");
> +}
> +
> +static ssize_t fail_io_now_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&head->subsys->lock);
> +	if (enable)
> +		set_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags);
> +	else
> +		clear_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags);
> +	mutex_unlock(&head->subsys->lock);
> +
> +	/*
> +	 * Ensure that update to NVME_NSHEAD_FAIL_IO_NOW is seen
> +	 * by its reader.
> +	 */
> +	synchronize_srcu(&head->srcu);
> +
> +	/*
> +	 * Kick the requeue list so already-queued I/O re-evaluates path
> +	 * availability and fails immediately.
> +	 */
> +	if (enable)
> +		kblockd_schedule_work(&head->requeue_work);
> +
> +	return count;
> +}
> +
> +DEVICE_ATTR_RW(fail_io_now);
> +
>   static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>   		struct nvme_ana_group_desc *desc, void *data)
>   {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index eeabc72863d8..ca93a8934123 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -566,6 +566,7 @@ struct nvme_ns_head {
>   	unsigned int		delayed_removal_secs;
>   #define NVME_NSHEAD_DISK_LIVE		0
>   #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
> +#define NVME_NSHEAD_FAIL_IO_NOW		2
>   	struct nvme_ns __rcu	*current_path[];
>   #endif
>   };
> @@ -1067,6 +1068,7 @@ extern struct device_attribute dev_attr_ana_state;
>   extern struct device_attribute dev_attr_queue_depth;
>   extern struct device_attribute dev_attr_numa_nodes;
>   extern struct device_attribute dev_attr_delayed_removal_secs;
> +extern struct device_attribute dev_attr_fail_io_now;
>   extern struct device_attribute subsys_attr_iopolicy;
>   
>   static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 93513c17ad5f..c154cc78c290 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -261,6 +261,7 @@ static struct attribute *nvme_ns_attrs[] = {
>   	&dev_attr_queue_depth.attr,
>   	&dev_attr_numa_nodes.attr,
>   	&dev_attr_delayed_removal_secs.attr,
> +	&dev_attr_fail_io_now.attr,
>   #endif
>   	&dev_attr_io_passthru_err_log_enabled.attr,
>   	NULL,
> @@ -297,7 +298,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
>   		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
>   			return 0;
>   	}
> -	if (a == &dev_attr_delayed_removal_secs.attr) {
> +	if (a == &dev_attr_delayed_removal_secs.attr ||
> +	    a == &dev_attr_fail_io_now.attr) {

This attribute should be only exposed for fabric controller.
It looks this is being exported for non-fabric controller
as well. Moreover, I like attribute fail_if_no_path better
than fail_io_now, since it describes the actual policy being
enabled: when no usable path exists, fail I/O instead of
queueing it.

>   		struct gendisk *disk = dev_to_disk(dev);
>   
>   		if (!nvme_disk_is_ns_head(disk))
> 
> base-commit: 011e0880d366be065d273c22ad1638934748d3e0

This patch appears to be based off older kernel branch. Please
rebase it against the nvme-7.3 branch.

Thanks,
--Nilay


