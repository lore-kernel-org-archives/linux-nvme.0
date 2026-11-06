Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23821606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HzM5IIRz;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cKTjAYX/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XYkSzMYIydt3Y+S8BTocsci3nY465zGomY2KYWOeFgs=; b=HzM5IIRzFUUsw7
	pScHpSIP7T7NpgQr8SncIYTFWxZtRJb9sW3hUFxk7Z21M0OfcPNO5xgVy/eH0OCcrMINg+CeIdT4E
	qRRR1JHaMCf+WqdAkb4HjA2UdB2ZE4LLPEHXflWeArwg3PZKeVJJHPmwIIr+4cX3y3tdZwhK9xvm+
	E6zgoikVWF7UFi2nONO/COAaKr5jMWK6MCLhGGwDGQAvH23k/HveRHutNl7wk+OHnqYLPUmg6H50j
	j0OSpZ/d4Wqr7BjJwBNZ31EjoL6Mzfi1RNC3NikL7GpU9Yzc9QAQ6+IqPrbxev8wp/isUMr/dyc2x
	wAlGgiOJRe9EnbZPebBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPK3a-0000000CRvD-08mx;
	Fri, 06 Nov 2026 13:32:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPK3Y-0000000CRuj-13rA
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:32:37 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai3El2143073;
	Fri, 6 Nov 2026 13:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XYkSzM
	YIydt3Y+S8BTocsci3nY465zGomY2KYWOeFgs=; b=cKTjAYX/5kbYKrhzBvB87Y
	k/MeYqhWjFqhFPOwMeccjPE/LQVb/SgbSkTwTz7rQuz5avWnRmZHqIzfBAgBe2Ou
	E1fcLTsk9b2mLMqx+x4LD36EA0X6N5Wup6MOqr8U6JKFYRclQka23sxDsKyTBWlA
	Cj2o6cDyL0JsEt9zZ4uPn2JNKP1LUzlaeBuXdeYoNvbXQFOoILFKRg2jBHKrzNeD
	cw7NUle0XKPmgVQpdP5Z2DzFRhYzQeHdKGUddJSUsUI63VAb6DV+LeIxKuWKieQa
	GDq0w4grPOfFCXd0eMqZsv4LCzSMe0HqCUG1Op8hZJJWq9J2oGoOAq3/r922qYdQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r94dhg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:32:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AnoHa3260566;
	Fri, 6 Nov 2026 13:32:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v78u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:32:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DVIUF59244800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:31:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA8E158057;
	Fri,  6 Nov 2026 13:32:07 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CF8058058;
	Fri,  6 Nov 2026 13:32:05 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:32:04 +0000 (GMT)
Message-ID: <4c07f29e-350a-440e-8ea8-ba55b10e4abc@linux.ibm.com>
Date: Fri, 6 Nov 2026 19:02:02 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] nvmet: take subsys->lock in
 nvmet_subsys_attr_tbkas_store()
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-5-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106015842.3534898-5-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedd6da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=DxWCkRxFjw0fKevttyIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Hi0p_TD7ni13rOCweBzHRkkh3xTNPrK4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfXxqlXeMvpzuAq
 boLDBSnj6IfqrFnAyHVsdfOT+ZgmHRALxWKtfJsVsg/LWKKsmWltmSZ4pORlETsqscorEB4mleD
 mw6XAWFZOaWDexClc7tGIEq8HhaS0uHUgj/Cm+pE/f23bERYrHEFqu8XATtu09NbBPCWgWPF9rG
 vYvEC8jJhCwVInpQyO0b4ALYk6Kbg7Wxl0I+SOGd9arejMQ/EOaaLoRYe3yVrT4gy+ea7+r/gB/
 dCLZY2avb1yWt5LdD4akKmW/A338a2ChuV2Ui7ZYzVjFVrlkFLnZLvE5pN0MI4M9ZXZMkNVaDTf
 sO+imGYQs0x8vJvD7OMce/MtntzJYjkKQX0xY9p0alcy9nMuIWCmX4IAGXpJ+daSxOyYv5kI6HI
 wFkXpYuVuxHaJDKGyztawED8SMrHY7TL06Z5J7nI0aetaXouTO/eBz12k5xUapy81vmbxSMhtcc
 JM9NbhsvgtIMEXraYCA==
X-Proofpoint-GUID: 7sLJNuXmTjd1RyNgJiFrP_f_MFvp5aKN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX8YwyFEeAENAA
 fUBhH8Qvccoz1E2FOCsdNtmqKVqOeW6uRlWj0UBshoad02OW9KlXyZTeyHgmNXXotjSicNxZjSg
 Wt/hQUi5WplZ/9tcl6WkleyU5iP4plo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_053236_320661_12EF6A1B 
X-CRM114-Status: GOOD (  22.13  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/26 7:28 AM, Guixin Liu wrote:
> The tbkas store handler walks subsys->ctrls to force every controller
> to reconnect, but it holds only nvmet_config_sem for write.
> subsys->ctrls is protected by subsys->lock: nvmet_alloc_ctrl() adds an
> entry under subsys->lock, and nvmet_ctrl_free() removes it under
> subsys->lock with list_del() + kfree(). A concurrent controller
> teardown can therefore corrupt the walk.
> 
> This is the same bug fixed for nvmet_subsys_attr_qid_max_store() in
> commit 9f426f140511 ("nvmet: take subsys->lock while
> force-reconnecting in nvmet_subsys_attr_qid_max_store()"), which
> missed this second instance of the pattern. Take subsys->lock around
> the list_for_each_entry() loop. ->delete_ctrl() only queues
> asynchronous controller teardown, so it does not re-enter subsys->lock
> under the loop.
> 
> Fixes: e98e45e9465b ("nvmet: Add traffic based keep alive support to configfs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/configfs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index b3a5242d06f9..c17f2c8ab2df 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1466,8 +1466,10 @@ static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
>   	subsys->tbkas = tbkas;
>   
>   	/* Force reconnect */
> +	mutex_lock(&subsys->lock);
>   	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
>   		ctrl->ops->delete_ctrl(ctrl);
> +	mutex_unlock(&subsys->lock);
>   	up_write(&nvmet_config_sem);
>   
>   	return count;

Ah, I also came across the same issue while working on my Clang context
annotation series for NVMe target, which is still in my local queue and
that I'm planning to send upstream soon.
Glad you spotted it as well. I'll drop this fix from my local queue.

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>






