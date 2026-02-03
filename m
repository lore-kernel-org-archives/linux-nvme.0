Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7936EE87834
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 14:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bEL43MhGa4sMuZXohHqUo8HZ6KYOBL8kkEKhb9cT3hs=; b=XrN8npS3w291uExaxRuLCKHFZ5
	hfoilzvrKiX9WcWGLOoc2UerqwmRATtxT2LJSsKXs/XP27mMSPhu/wlYVEFo1YpUaz1+CurnDqUWF
	If4o4tedyVy6nsXuFw8V4wbZO+3iRE+13a5uE29wHTwsKXKjlWDnnO0dF6DiuPak8JBgu2t2n8QJ4
	w331yyYSPocmnLFLcFPk2G62InI2YrFua7NXNCYQE5rkUMWBYR0dq7XymW+CvNq1UrlktgYlg6nxR
	gDOinhBipiei6ZsjoB6ipqjMeuLpjpdcf71xywHmgm2YRxtW9ukdyjpSokfEDbT98WEJKiCXYetc+
	9CAkJq+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnH2N-00000006j7q-17Fn;
	Tue, 03 Feb 2026 14:05:51 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnH2L-00000006j7R-1o9E
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 14:05:50 +0000
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61371huo256087
	for <linux-nvme@lists.infradead.org>; Tue, 3 Feb 2026 14:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bEL43MhGa4sMuZXohHqUo8HZ6KYOBL8kkEKhb9cT3hs=; b=gJYFjyZZAYvlqt3l
	sDDpBNvz8JZKEzjcS+WwCZ7uyeUjRFC49dXPysrJw/IHCxRiz6FC4ymZYEl01/p1
	icS+ta3L+ajJ0sz4x0WornJOdSC5EPM7voHsfYJOPSwMZKqZnE9UyC9d5gt1O/bv
	O07DTn/VDydsi/jCkmNVnY7AGvHwcAMOIUEA/TfKAGrNbw4OzjbR/LP0aA2yww2U
	pDFUT6Sc9HHpIYxCZ/zBh0mABti19bQ3L4iKTc/nv1ssJxCciBAG08rA5xPFmjox
	hTQmkX3FxAYYuUpmCyManYay62ZoEeHmoLx5uGeVXGlc3RMYU1NANVEdUm7qr4vA
	lEFsMw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0km9wn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 14:05:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a7d7b87977so54106665ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Feb 2026 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770127548; x=1770732348; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEL43MhGa4sMuZXohHqUo8HZ6KYOBL8kkEKhb9cT3hs=;
        b=O4NPS5d6cxoMRx+LrtuqcE7Y0tlL8ure9XciYgOvjEb6AA6arzWLS5eHF+8S7jeAT0
         eJT9BYeazjpSLoCLWlCPO8T/XzOtcHGgHd1ZiwyCnHt5NaevUhUU3j70NwGVX9quoOEp
         W+fnZiXVxfWX7/t9xOonMiptKeFyzketj57V4a6Dj3UYKfcYa3/qpIDML5kIp+ep3bTJ
         pMQ0lgrRPXX/Ikn51bwNXr2f33Ack5JWW7bSP1+sXe9h/QeCl9JNKAp3MebWrmCEc+Pf
         4xJhT1IGZDB4D4gkhByKhU75aziDPeeQmSk5ehILbf0Xer6XbSmQoTGIy1RLqMcF7LL1
         +3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770127548; x=1770732348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEL43MhGa4sMuZXohHqUo8HZ6KYOBL8kkEKhb9cT3hs=;
        b=aws9SXFXVUJM5MSzpml2HpCPW/yiqiYz+4V3Q9ERoZbMBH8QnNPCu2DNttKzq3l+3Y
         W6SYpO0QyJS1SFsVnQV2EQLOmk4/x24yqQCsO3rB3gQggxsz3vLJ1CpKMK3QMziaL0Mx
         1XEuzPOItj9DVp9nRqlat3cURSW2lbL14fCMZOwF2t3aSPohQkPcpktOtEUluwrEfn7w
         kayzExrmijj3/Gd5GhGWqJodXzqo+aju5MWtxuV6jkShJOtX9AfFSB2SGLjTyu6xcokK
         LkDq0EnLlzNR+NS6885vDcBVkkLC5cPvA1vMVOHQUIDKi20ty6bFNpwolHqJjtMEJKtw
         IfDg==
X-Forwarded-Encrypted: i=1; AJvYcCVvwiIowkDtEuQrXNvW66V0u9ypoBgWfwJSY6sAj3jfRHCINZ8RHVL1m1izCXV2CxxeM249XQsg/jOd@lists.infradead.org
X-Gm-Message-State: AOJu0YwQndG7AHmASA/M6ZnFrZl71CjcOYgnqZO7+SwuByuw07Xo90SQ
	EG0ZdmgVlv1v2uxw4qCZSZ9ESk8VuTK84BX2IOc4QY1bVoYqdC2lShqEN12C2K6HtMjSUoMU0Am
	OgZ/eo9n8Yp3/zD9fJq34NOYItpON6eYMDpIhPAAkJUesZyWxUvxLg1uMa4RAepDYKbL8/w==
X-Gm-Gg: AZuq6aK/UzSRKS3QXsqHP60tX/ejMRxpeaNmrC+FTJp/98Ch8T+3Hkxwcy12tzXuaX2
	8oUmwcUcV0p5Zq5FLU2An/zyiFVaJBc+ZCwo0hbgW8DlGP4ottr4mH7Ogkvcs/zr4bDhXXFFs/f
	+FAV1ikVEI2jtxBX6f1RHX4qAm1BvT7hJgvw0yPK051KDjB+95wQZRPmxQVWs72ynbHIGzApzhl
	VEnK6gnytyzLxWyEjn8lSCYmgvUbLFjvCj/nGfRDI5ZoGySejeZVoEyznk6NN69M/B9g2B1neSd
	smLeF5c8x6WOsj7/1IFypmw33Ril8t+6O/pJtepOGXWxc19PlbomY94PLUfchdINn6PfCAlx+Di
	HU5fJjd6LPnn6cOvDmHujQus1H3UqfjkccGY3lnZqFIXRLUQgCjk=
X-Received: by 2002:a17:902:ce8e:b0:2a7:3dbe:353d with SMTP id d9443c01a7336-2a8d81a0da6mr159708245ad.53.1770127547694;
        Tue, 03 Feb 2026 06:05:47 -0800 (PST)
X-Received: by 2002:a17:902:ce8e:b0:2a7:3dbe:353d with SMTP id d9443c01a7336-2a8d81a0da6mr159707915ad.53.1770127547086;
        Tue, 03 Feb 2026 06:05:47 -0800 (PST)
Received: from [10.217.216.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a8b47f4717sm171421055ad.18.2026.02.03.06.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:05:46 -0800 (PST)
Message-ID: <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
Date: Tue, 3 Feb 2026 19:35:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
Content-Language: en-US
From: Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>
In-Reply-To: <20260203052756.GA15839@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Reqdyltv c=1 sm=1 tr=0 ts=698200bc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=zVLJcoG1pTuyLsMQ7wEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDExMiBTYWx0ZWRfXxFkpqztZUWmB
 uzeS5XufqT2jnP+6dlQTFR3cuMe96vSPKCUHDo7ap1jYVIOGelG8G2P89tM16wsYAuSZVfRpagf
 C0kHOXDjNzvflg8PH08qVEiYJkvHtQBtY/BurA09dTbHj97d+ziuHBwbXH/ZlsAzlkcRJUhuzXP
 Q0lPQdJWDFpTWmX30D9hVjdYqDMGPuoEefgI9Vy52wLimIALbBAryYcfVz/W5lacw6M9LRp6cJx
 X80kZBLLraMORzd9FLtswSCUr0rHLDx+y6qpEB9S+nV/527ITTF27W9+rCM0ZAfXd2ex78cPhGH
 MpCexq7BpCqkIB1kbWPe1llmcFAhx+O+c83U56O06a+o+gTvQvMTHiwbLt/Udx8vp6B9pIORCvQ
 utlFxBXNW2wHREAKa1++yKpz91Sm/t1+cYUNUX0Nii4Tquz7gRJxkuilfvPNPTlJVEN/qznRiKq
 5RqIKfC9YBpHN89Y9tA==
X-Proofpoint-GUID: vJqEwBIorj5U5B0p98TD24cCmT-246_H
X-Proofpoint-ORIG-GUID: vJqEwBIorj5U5B0p98TD24cCmT-246_H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_04,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_060549_481466_CA919A19 
X-CRM114-Status: GOOD (  23.14  )
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



On 2/3/2026 10:57 AM, Christoph Hellwig wrote:
> On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
>> In the case where this iteration caused dma_need_unmap() to toggle to
>> true, this is the iteration that allocates the dma_vecs, and it
>> initializes the first entry to this iter. But the next lines proceed to
>> the save this iter in the next index, so it's doubly accounted for and
>> will get unmapped twice in the completion.
> 
> Yeah.
> 
>> Also, if the allocation fails, we should set iter->status to
>> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
>> Otherwise, the caller will think the request is badly formed if you
>> return false from here without setting iter->status.
>>
>> Here's my quick take. Boot tested with swiotlb enabled, but haven't
>> tried to test the changing dma_need_unmap() scenario.
> 
> Looks much better.  Cosmetic nits below.
> 
> Pradeep, can you test this with your setup?
Sure, testing has started, and I will share the findings soon.
Also, I did not pick up the initialization of dma_vecs during testing.

> 
>> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
>> +		return nvme_pci_prp_save_mapping(iter, req);
> 
>> +	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev))
>> +		if (!nvme_pci_prp_save_mapping(iter, req))
>> +			return iter->status;
> 
> I'd move the dma_use_iova / dma_need_unmap checks into
> nvme_pci_prp_save_mapping to simplify this a bit more.
> 
>>   
>>   	/*
>>   	 * PRP1 always points to the start of the DMA transfers.
>> @@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request *req)
>>   	iod->nr_descriptors = 0;
>>   	iod->total_len = 0;
>>   	iod->meta_total_len = 0;
>> +	iod->nr_dma_vecs = 0;
>> +	iod->dma_vecs = NULL;
> 
> I don't think we need the dma_vecs initialization here, as everything
> is keyed off nr_dma_vecs.


