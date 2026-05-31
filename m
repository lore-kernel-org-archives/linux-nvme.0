Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77069CD6E52
	for <linux-nvme@archiver.kernel.org>; Sun, 31 May 2026 15:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o4vQx0bV155pHWBIvJOUhbaD/1Mdd4XN5wjoNKa3mrQ=; b=KFEcrqxwvb/qiOVGyPuvQ7d1Bb
	38TpNoIkhwA8wHfMikwfobB7PgBhgnsctsRBtk0UGKh+h0avBkXGHBaQn3c9L9Ui/oH7I/mGCcZNS
	Sn8JnVdaah40+i2X75XDgpwq5YuwTOxqvT1O/a5Pd5v3iZO83jwfWj5SYjew/mGDDwZ384ttvlkBB
	Wijl6eZnSj8vUjsGKKF8QszrFfKM7KluQRds+0vcJDDLlMs/raj+rQcMQbuFcZGSdHVSEb6f89p26
	AmOn5NRujSFhsnhr2VeWIiBqDC+OAaDe1wrAfezj5Cbpj6FezlaDXf1TLVZMwHu32wxgH5gQeube3
	0MEq8bqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wThgP-00000009fbU-2rQD;
	Sun, 31 May 2026 15:02:33 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wThgM-00000009fb7-486L
	for linux-nvme@lists.infradead.org;
	Sun, 31 May 2026 15:02:32 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V7NKKQ922540;
	Sun, 31 May 2026 15:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o4vQx0
	bV155pHWBIvJOUhbaD/1Mdd4XN5wjoNKa3mrQ=; b=YcKQzaBtJrG+EXnuvKmt8t
	83WUUPS04ns2lIQfmI2irZucZLFkUTyp+CNQdB5Jo1ypseGDog+CP2Q8Dp49gVK6
	VBxc/HxYL6zydbg+bUyK58lOxNuwLuRRPzGLmmHcUr9sg4sHHFzVPzYh3d2JRFkr
	iBmHz2iti043BeJ36jYglH23/aoW/bvTwdl0tycK+2bFgO9CE033JV4cIvNvzlNN
	bs12+HF55lRfgsFEqFBktn5GzqFdkuRR6EiooAsF5S6O0Bd0fXyDurVA+i4+E0GC
	CFxPA10qGljflruY6AvRH7bJuI+ms3BR+c5O4IbfTZ6N5E8QPmDvW0ApDCI/KGMQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4mw4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:01:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VEs5TL027570;
	Sun, 31 May 2026 15:01:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jt3wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:01:39 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VF1cJ920906660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 15:01:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91DC158055;
	Sun, 31 May 2026 15:01:38 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 985975804B;
	Sun, 31 May 2026 15:01:29 +0000 (GMT)
Received: from [9.43.126.202] (unknown [9.43.126.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 15:01:29 +0000 (GMT)
Message-ID: <60f02eb4-0779-4948-9cdf-c3202c1845d3@linux.ibm.com>
Date: Sun, 31 May 2026 20:31:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] nvmet-tcp: implement mptcp listen socket ops
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        John Meneghini <jmeneghi@redhat.com>,
        Randy Jennings
 <randyj@purestorage.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, Hui Zhu <zhuhui@kylinos.cn>,
        Gang Yan <yangang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
 <94d8286242b894e8bc9a9a3391c4d3db778f96c0.1779934709.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <94d8286242b894e8bc9a9a3391c4d3db778f96c0.1779934709.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: c8Ye7L-Aok1GhtIhOj6hof8odDneICrI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE1OSBTYWx0ZWRfX1DUpCQlYymqI
 DTEzlaASDrl251KE66amI/H2+4zYMmuGzFMQZLpWfZSr5POYELdB3Tc7fWnHkx+s3uVXSLcda1Y
 XOwKxdAUD5WDQ8b8im2wsM5CZHtzMZo7wpBvyOw1rkLC9o158VvJWs9NY76IGTS4InfYbgd2U1Z
 8oCr3oIT+ra9gruy5Lm8FQWeMxwtR29UrrzOaPjrm+X6Wrs1F0r9cld/NwOR0PzG2c+ZWVw/A5g
 vKK0DCS/Kbm8xFjNeZwVedF6WaqoGBLpQjUoAUeJLwsKawSGNKQCxj+GuMaNTqcGaaALXW3fKXp
 +BvNN4jR56w7P6yuWby8lxMK2V6iNihxlervOa+DIzQSiGasmGzjLvcBNAvdVbf0qBAtN5U2s2H
 ZhlNgoS1XxKsCxnIuP98wKaINhqVmv2pH9mPIQMjulPcllqcfIE+ema+8/oPAGgxMbAIpVT7hmX
 q8ElLU9XwkfHbPurffg==
X-Proofpoint-ORIG-GUID: izyVfQ-n9Gy4Sn2MaUchGig0_ZjOxhRS
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1c4d55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=WTJdmG3rAAAA:8 a=VnNF1IyMAAAA:8 a=qRBToSlAEBA1CvdqRM0A:9 a=QEXdDO2ut3YA:10
 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310159
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_080231_035157_7EC284F4 
X-CRM114-Status: GOOD (  15.91  )
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

On 5/28/26 8:40 AM, Geliang Tang wrote:
> From: Geliang Tang<tanggeliang@kylinos.cn>
> 
> An MPTCP-specific version of struct nvmet_tcp_proto_ops is implemented
> for listen sockets. It is assigned to port->proto_ops when the transport
> type is MPTCP.
> 
> Dedicated MPTCP helpers are introduced for setting listen socket options.
> The set_nodelay and set_priority helpers set the values on all existing
> subflows using mptcp_for_each_subflow(). The set_reuseaddr helper only
> applies to the first subflow. The values are then synchronized to other
> newly created subflows in sync_socket_options().
> 
> Cc: Hannes Reinecke<hare@suse.de>
> Cc: John Meneghini<jmeneghi@redhat.com>
> Cc: Randy Jennings<randyj@purestorage.com>
> Cc: Nilay Shroff<nilay@linux.ibm.com>
> Co-developed-by: zhenwei pi<zhenwei.pi@linux.dev>
> Signed-off-by: zhenwei pi<zhenwei.pi@linux.dev>
> Co-developed-by: Hui Zhu<zhuhui@kylinos.cn>
> Signed-off-by: Hui Zhu<zhuhui@kylinos.cn>
> Co-developed-by: Gang Yan<yangang@kylinos.cn>
> Signed-off-by: Gang Yan<yangang@kylinos.cn>
> Signed-off-by: Geliang Tang<tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/target/tcp.c | 13 ++++++++++++
>   include/net/mptcp.h       |  8 ++++++++
>   net/mptcp/sockopt.c       | 42 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 63 insertions(+)

Again same comment as earlier, split this into two patches.
One patch for net/ implementation where we define and export
mptcp helpers and another patch specific to nvme/ implementation
which consume those helpers.

Thanks,
--Nilay

