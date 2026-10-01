Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BC4CA5FB3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2026 11:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0AhsE8IW3qyWAltrvsy3OyzZOIRvdjH421SFwSJ83U=; b=KdQbFelCWr7zG9jXqxH0mQ0JAc
	/l+YJhoOl8MAyb1VqReI9vi+CADTOPswXdKt5J04R7d6tJ/pPR+sfD9mRQYYXqb76OMS7ZNXRknBQ
	Pz2xeW9fIxNzYwfJBzJuqINKk+CoGo0x8gLNHpnQVFDZWC0LjWsidxY6OmRcuS0JXCz6M3J958NzW
	6TyBHWePgTdIH++rgMUEq3lkfXlFeyB/Q0QDDbqbtIyoSeRhMQpnjowQpSBGYcJfSJF9q1nlIu1ho
	5JGXtIf8N4G+ziMhwDSoQM8aGsbqVOJ/6WaA8gve53S3PoutsSa6Ug4aBqV7K/ZKraFEnTM31KG6Q
	7Nka4hhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCFBY-00000008exZ-1N8X;
	Thu, 01 Oct 2026 11:42:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCFBV-00000008ewm-1HTq
	for linux-nvme@lists.infradead.org;
	Thu, 01 Oct 2026 11:42:46 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175UO94040706;
	Thu, 1 Oct 2026 11:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u0AhsE
	8IW3qyWAltrvsy3OyzZOIRvdjH421SFwSJ83U=; b=hAVj0kNRydXM2Pj14As4C6
	A95mMKJp1lfiIYh7ON4s+O3uUtjrV8be/1vNSTHv3vkpCfCz6DFWJOGezqWcpj22
	V/40yqZdUVHAICptmJOY8PHAtNtNb8YQfnWSmdcNd7CfFI7tkJHm5TwJosO8TO6w
	/nRtLw3MgNS3vT8ZKT3CekKN0uFKGP4Xqe2Qf4mp2NGs0kqaAvD/3buG25ne4EHK
	Px/ruWI+rHhz+wPhc+gqN4lk1UZrxFzvw7LcZXZe7MSG+dqyf6lhrrbujAUKG7iT
	NAoszW6gIj1m34+eRUbXMF5DnMNlB0hMAECVWZy5++zkEfh+RQbUY/HvPqxAse9A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehrdn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:42:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BUsTN561208;
	Thu, 1 Oct 2026 11:42:35 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8tt8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:42:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691Bfn3W66716024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:41:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1951358058;
	Thu,  1 Oct 2026 11:42:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A78E58057;
	Thu,  1 Oct 2026 11:42:31 +0000 (GMT)
Received: from [9.61.28.159] (unknown [9.61.28.159])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 11:42:31 +0000 (GMT)
Message-ID: <04909105-bcbd-4b89-af41-ad761aaa9af2@linux.ibm.com>
Date: Thu, 1 Oct 2026 17:12:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet: defer setting ns->enabled to false in
 nvmet_ns_disable()
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        gjoyce@linux.ibm.com
References: <20260918162736.802665-1-nilay@linux.ibm.com>
 <20260918162736.802665-2-nilay@linux.ibm.com> <ar30Q5H1fuyFtDwM@shinmob>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ar30Q5H1fuyFtDwM@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe472b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=FLMVk1Nlp5jPE6tgMn8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX9W8SIsxc9/8s
 MUbJrN6KkiORGJ8y22JAhR9CU+d74iF7tYaqq5qqJTOefzq2Df7uRPjKSUpT5Lfqwr36zuYt00b
 Q6H9ybf8zy7LLGPTvMl1RYvSUpIFE4c=
X-Proofpoint-ORIG-GUID: JW86kF-goOx435uhQmqMNUJ3cgiYBij-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX1NFeDa+LcUW0
 3MYzh03NN75sYxKur2Im9MJLSkA1aqWtMRB3W4okEL9eGLzMW2Ex/6vHzzSTqWHjwtGguyYe4BO
 SZJ9urWC23rmfaRCifHoT0VLzoYxLC2ZKdMOJlQtwjapmszFE/KXnGEAS1K8k7z4SGG+lCYrWRB
 W/LxhkiUnf1JWeoy8+41Jr4YSqtsmCWH745QVrTmWDOSonLXfjxz5+ezr24kCZuC4LwM2P5Cann
 NeOjxWEtC/lTKmMF8vXnKwp9sV4SOfiBGS3xxrZHm8oTjO7p7Jr9jfo/SVe0l86F5H81qkcg1Da
 10oKdJSjgY6pAjxU9WDF6cXNKuV5TmEgh5tD4kyg+X6DAISJYEkFFtp1vxP5+F5rM1DS0ZC1/zI
 Xswt9CCiHtlQ2qyIEYVsQ1s9M37aSILhHhLM4HWXnbMjTK5NYEJrcSamL5NzwwUwqyby9Bzvtkh
 84fYmrBfUMSC08uATpw==
X-Proofpoint-GUID: JW86kF-goOx435uhQmqMNUJ3cgiYBij-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261001_044245_467952_619A8300 
X-CRM114-Status: GOOD (  28.17  )
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

On 10/1/26 11:25 AM, Shin'ichiro Kawasaki wrote:
> On Sep 18, 2026 / 21:57, Nilay Shroff wrote:
>> nvmet_ns_disable() currently clears ns->enabled before draining
>> in-flight I/O references. This allows namespace configuration to be
>> changed while existing I/O requests can still hold a reference to the
>> namespace.
>>
>> This can race with configuration of namespace attributes such as the
>> device path, UUID, NGUID etc. These attributes can be accessed by I/O
>> requests without holding subsys->lock and must not be modified while
>> such requests are still using the namespace.
>>
>> In nvmet_ns_disable(), keep ns->enabled set while existing namespace
>> references are being drained, so namespace configuration remains blocked
>> until all in-flight I/O has completed. Set ns->enabled to false only
>> after the namespace references have been drained and the namespace
>> device has been disabled.
>>
>> Introduce the NVMET_NS_IO_LIVE flag, which is set after the namespace
>> is successfully enabled in nvmet_ns_enable(). When nvmet_ns_disable()
>> starts, clear NVMET_NS_IO_LIVE so that the I/O path stops admitting new
>> I/O once the flag is cleared. Using test_and_clear_bit() in
>> nvmet_ns_disable() also prevents concurrent callers from starting a
>> second disable operation.
>>
>> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
> Recent blktests-ci trial runs for nvme-7.3 branch reported failure of nvme/052
> [*]. It is required to repeat the test case 3 to 20 times to recreate the
> failure on my test system. I bisected and find this patch is the trigger of the
> failure.
> 
> Nilay, may I ask you to take a look in the failure? I'm not sure if this should
> be addressed in kernel side of blktests side.

Thanks for the report! I looked into the failure and I think I found the root cause.
I couldn't reproduce it on my system, but I see there is a narrow race window that can
potentially trigger the observed failure.

I don't think this is a new race introduced by this patch. However, the changes in this
patch may have altered the timing enough to make the race easier to trigger.

In nvmet_ns_enable(), we currently queue the asynchronous namespace-change event
before setting ns->enabled and the corresponding NVMET_NS_ENABLED xarray mark.
Therefore, if the asynchronous namespace-change event is received and processed
by the host before the namespace is fully enabled on the target, the host may not
find the namespace while scanning the active namespace list.

To close this race, I think we should send the namespace-change notification only
after the namespace has been fully enabled in nvmet_ns_enable(). In particular,
we can move nvmet_ns_changed() after setting ns->enabled, the NVMET_NS_ENABLED
xarray mark, and NVMET_NS_IO_LIVE.

Could you please try the following change on your test system and let me know if
it fixes the failure? If this resolves the issue, I'll send a formal patch:

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8eea0a504308..da98e5cae7f6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -626,11 +626,11 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
         if (ret)
                 goto out_pr_exit;

-       nvmet_ns_changed(subsys, ns->nsid);
         ns->enabled = true;
         xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
         nvmet_debugfs_ns_setup(ns);
         set_bit(NVMET_NS_IO_LIVE, &ns->flags);
+       nvmet_ns_changed(subsys, ns->nsid);
         ret = 0;
  out_unlock:
         mutex_unlock(&subsys->lock);


