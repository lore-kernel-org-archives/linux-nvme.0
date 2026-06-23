Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62729CD98F0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DH7SIiBBp9IyAZhVnJb2DCMGQr/9RkPesME/wV44UhA=; b=4dQ5CaFBb9Q2dak6HrM13Bn2Ur
	uKrlpcqM2m3umZkG3XDzvMMOm5dNWC2+Ae55NdtCxFxD5JRsSyAkfVhoQrO+qb+K/XKo4vDe8caqM
	oYt9O+FtQRwdvLXovffov7JUi5A/MKKryZLniY2lA6GVDjWLDOGbaoUtHvrraE/EYbYODn+m9KuL/
	sCFe7uRHHy5a+Fc54S8c5F5hX9cKjAI05d64jav/xKCONf46yfYRYNPrytzK84JLLoB2lOmGTscRa
	3BQTYjJuz8y1v23cQCGPLN+Q9wTvkg3b+ZcpW5ptEWwgFd2q/1KkZDE3928ZFYQXt3cKQ649VLR2k
	PLrSRuIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbuRJ-00000005lRq-3iJn;
	Tue, 23 Jun 2026 06:16:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbuRG-00000005lR0-2rjE
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 06:16:51 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0mMkO351961;
	Tue, 23 Jun 2026 06:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DH7SIi
	BBp9IyAZhVnJb2DCMGQr/9RkPesME/wV44UhA=; b=st782uXcI3fXRIBnemPIue
	raLAJNerGC0AdKZFs89OdNRJQbJicDY7FHYYuxFRs3UcXG509QXSH+ivEOLVAjfe
	IZP/Mmr5qwuNMETlBx2fLzx+GbkQ2SYuERYfDzgaFx96bmM4bVADluYOdxCgTlTF
	gnKz8sq9Wlc+V4xhDYJBIsPeNSIgW4LBn3UGjD6dWcH4djQDGESfbx1EQXzhVIro
	oOkHb6lGkz5CiuqytnVRn4IhDzZkvKaeMBLRDCdjNjEGzzDkCvLjUuelO6snyRcj
	24B97hnFviJ3xGPwqvb3EbPL2ounzYYrzi74j+JJeoWKdys6dXw+tyePTN8Gy8UA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4cwxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 06:16:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N64fen007464;
	Tue, 23 Jun 2026 06:16:37 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw9y9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 06:16:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N6Gb9x26346134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 06:16:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 506C558052;
	Tue, 23 Jun 2026 06:16:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5183C58050;
	Tue, 23 Jun 2026 06:16:34 +0000 (GMT)
Received: from [9.43.75.139] (unknown [9.43.75.139])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 06:16:33 +0000 (GMT)
Message-ID: <47b1fee5-c7e8-4fd5-884f-80e651181407@linux.ibm.com>
Date: Tue, 23 Jun 2026 11:46:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: expose path_state via sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260622130318.2346995-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260622130318.2346995-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfXyvfVkT7bVKl1
 c72RtNL+T8acKbV4zRx22DFZxWZ4tgBWVHanfKeTJon0R0eFH+xIrmi7Em39w3ziZVfG+CXXzlw
 WgFQexjLEiZq7tiC5AUMc8jDH6cp7Ik=
X-Proofpoint-ORIG-GUID: Jn2JUmJuSZdJsIAZ9Rp5KKSa-eiVhyTo
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a24c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=fP0Swy4r6SKquNqiy-sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0NCBTYWx0ZWRfX1EPXLgpP4klb
 UC0oaMUh/liTU2/se3AnTOFa85YU3H1Q2sQsrAXfxIBz/mpv6B//rDgFJumaIZnbuZLaRN82BbT
 QqULKYwgbbmdMOllm9A6egZ//ZYlQyog8XzJSmb4QHLgeCbqYdWvbehdd3JNYiP+p3JqqfTTkGZ
 yhDCQD6otWOKKdud/Ym0QxpdelV4ORNi26c48ziesB05+jl7o4/vd4biESRvO6BDSHb5+8WnUW7
 F4KItFC4iFzM02ntADjkl4dfYnn3SyVipappxFD8JVhu6lhThfqzCAvPYKh1fErm4rsA0PH25qz
 Cd3kgJgaY1wVDSFbcc2RSX9BjxCow2bz6NTISyl9bO8qt4Mf8FGSupEVL0f6Vpu8KEGMK6IPWfm
 7yvVt1GnZk3NJ3oDuAbTHApXL+xlqswfa4yGTE1Cdj73CbJlP8XQWFT42f8ziZdwh+1QgucHvpn
 9heCpjaVG6J8Rx3kbwQ==
X-Proofpoint-GUID: 26D208IglbfBpuUALPWlAfV0QpFrl6zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_231650_737367_FF9AE75A 
X-CRM114-Status: GOOD (  28.63  )
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

On 6/22/26 6:33 PM, Guixin Liu wrote:
> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes whether
> the path is currently enabled or disabled with a specific reason.
> 
> The attribute reflects the result of nvme_path_is_disabled() checks:
>    - "enabled"                   : path is available for I/O
>    - "disabled (ctrl_down)"      : controller is not live/deleting
>    - "disabled (ana_pending)"    : ANA state change pending
>    - "disabled (ns_not_ready)"   : namespace is not ready
> 
> This gives userspace visibility into the multipath path selection state
> without requiring users to piece together controller state and namespace
> flags manually.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> v1->v2:
> - Show specific disabled reason instead of just "disabled":
>    "disabled (ctrl_down)", "disabled (ana_pending)",
>    "disabled (ns_not_ready)". (Nilay Shroff)
> 
>   drivers/nvme/host/multipath.c | 16 ++++++++++++++++
>   drivers/nvme/host/nvme.h      |  1 +
>   drivers/nvme/host/sysfs.c     |  4 +++-
>   3 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 81fff2f20d23..5e3847fd6632 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1210,6 +1210,22 @@ static ssize_t in_flight_bytes_show(struct device *dev,
>   }
>   DEVICE_ATTR_RO(in_flight_bytes);
>   
> +static ssize_t path_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
> +
> +	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
> +		return sysfs_emit(buf, "disabled (ctrl_down)\n");
> +	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
> +		return sysfs_emit(buf, "disabled (ana_pending)\n");
> +	if (!test_bit(NVME_NS_READY, &ns->flags))
> +		return sysfs_emit(buf, "disabled (ns_not_ready)\n");
> +	return sysfs_emit(buf, "enabled\n");
> +}
> +DEVICE_ATTR_RO(path_state);
> +

I'd prefer not to open-code the path disabled checks in the sysfs attribute.
Ideally, we could factor the logic into a helper that returns the path state
(or disabled reason), and have nvme_path_is_disabled() built on top of that.
This would keep the path selection logic and sysfs reporting in sync.

The concern with the current implementation is that it duplicates the checks
from nvme_path_is_disabled(). If someone updates the path disable criteria in
the future, we'd also need to remember to update path_state_show(). Having a
common helper would avoid that.

For instance, something like below:

enum nvme_path_state {
	NVME_PATH_ENABLED,
	NVME_PATH_DISABLED_CTRL_DOWN,
	NVME_PATH_DISABLED_ANA_PENDING,
	NVME_PATH_DISABLED_NS_NOT_READY,
};

static enum nvme_path_state nvme_path_get_state(struct nvme_ns *ns)
{
	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);

	/*
	 * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
	 * still be able to complete assuming that the controller is connected.
	 * Otherwise it will fail immediately and return to the requeue list.
	 */
	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
		return NVME_PATH_DISABLED_CTRL_DOWN;

	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
		return NVME_PATH_DISABLED_ANA_PENDING;

	if (!test_bit(NVME_NS_READY, &ns->flags))
		return NVME_PATH_DISABLED_NS_NOT_READY;

	return NVME_PATH_ENABLED;
}

static bool nvme_path_is_disabled(struct nvme_ns *ns)
{
         return nvme_path_get_state(ns) != NVME_PATH_ENABLED;
}

Now the existing callers can continue using nvme_path_is_disabled()
as is without any change. But for sysfs, we'd call nvme_path_get_state().
Then the sysfs would map enum nvme_path_state to strings and
use it for output.

static const char * const nvme_path_state_str[] = {
         [NVME_PATH_ENABLED] = "enabled",
         [NVME_PATH_DISABLED_CTRL_DOWN] = "disabled (ctrl_down)",
         [NVME_PATH_DISABLED_ANA_PENDING] = "disabled (ana_pending)",
         [NVME_PATH_DISABLED_NS_NOT_READY] = "disabled (ns_not_ready)",
};

...
return sysfs_emit(buf, "%s\n",
                   nvme_path_state_str[nvme_path_get_state(ns)]);

This way any future updates to the path disable logic would automatically
be reflected in the sysfs output as well.

Thanks,
--Nilay


