Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF09E87845
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g8tqW5Hq/w4yBZGsIGjLboSs0fMRtytJGNyqGY+7pxA=; b=1JLXk+G1hJF2pQ5KcHhSDORGEO
	Qp25aKWdqTdeBWVNo8ml120OlI4gVdvhctTn3WBQajhIe9b8WG6sMwM8/ZpH7YGA+q979/cAU/N70
	X8TSNqAjnnByP5isSBYNDAZKhLSODMauNbgmvchYTxyLwKo48UJ/HXeCzKVw0YI+cyJS0XFP1K9C1
	XMGYOKaA32CpC/H6w5O+f9Vt9rC1tRfbgWbAIeBXhUrQ2Zt2Hg71S8qRU0kh6g4wSL3G9RCSNnL+d
	Wq/qAMvmBzQ2zB0jV9i3H2oxuLfHeVTKSdilcQRVNDO3sqoRdPbs5xv280cWEcBHlx7Fpvau/RRqJ
	tpuNQbIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vndUy-00000008Z9s-3SDG;
	Wed, 04 Feb 2026 14:04:52 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vndUv-00000008Z8U-2FL6
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 14:04:50 +0000
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIcca2167612
	for <linux-nvme@lists.infradead.org>; Wed, 4 Feb 2026 14:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8tqW5Hq/w4yBZGsIGjLboSs0fMRtytJGNyqGY+7pxA=; b=pR28mkPE79srk/r0
	tc+k6GtbMrLxlIlRm2yZU+MYOLtltcGdlGgs95wbtyRwq93lvppI1oCF39Z+Z/jo
	A+TBXTguc/QlUyHHrZkvdfuwxcaUlFwADeica30sLwKEUeIvhwITtioLAtSL/Mrn
	AAqGwC65mhxoFIl9VvrrjxRsEgAQCyn/wFHeVJbnKqK82Qfr6kG0Ox/sCYLr8rpJ
	Eu856/1h364OIn/TsmbYDu+nACPGTmtyQmNEa4FtYMYRVIRCeakzFY43GV7Ta1oD
	vgnCS2XInV2Eb15Ww+yzeKlIo0UdAzhWeP+yId3Q7mQuZ7AMZgpQ7yJI86YuDXWL
	+aYrxQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c45nvgbf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Feb 2026 14:04:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-352e195f662so5847007a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 04 Feb 2026 06:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770213888; x=1770818688; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g8tqW5Hq/w4yBZGsIGjLboSs0fMRtytJGNyqGY+7pxA=;
        b=WtW5scf1FUOZCZjJiuhGaNu3wzxF9skB/ub6uj6k3svLsU0rVW+37K89Bc5vt/Fgyh
         U2TqeW4ZzbFAl4YLeqGwtyzDE4jy+FnRyFZ0PW4N9fJGocWlWv7djZl19p9nk6pP09n4
         mzwum2n8QIXwhflK68/5Bg/tMvJylvDuLHx0Pi8KIHqY6nb8J+8mm2hiCZSb+qkIhp7a
         OIS8G8sLWyf/4wNSPK7XNoLhHeT9jQyTBaWefPiQN/q0OS7PM6aT8bnPZxw2xUQ3SXfL
         OH+pV7ZgLP8CChZiHSsTU/N6YGpyVaocOhrCDBeSs50tjJ8M/5KOmnhgT7t6NgOhJMws
         AW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770213888; x=1770818688;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8tqW5Hq/w4yBZGsIGjLboSs0fMRtytJGNyqGY+7pxA=;
        b=N3XWt4lflWDlTG9vGhGSJBN6ts5b4CgCpO43rR/EswJs6P8hRkocQeDxh1ie72iGk0
         7agOwfFYxzA5MhInFTqaDM3aVvwaRF2Tt/RkzPaygI7XgMOUHLGmruo2YzDVr+SNJiS0
         +QWY+63OFZlWv0+tasLw7zDh+Jnxk+DyfQNv1m/CVtRbYWIfKUTnD13OxTv+t8SyaLfM
         gG1589ymssNKoOGazxPNT8bHEJU0IVFn7HtcShjfIeb6ADNS7RZPPMlsU1qmfr47LX8v
         suxQwhoSD3dn4UEwBdagdW91PNkJogScY9xS3g4fdp3/Bwf7/qTplwmcPwKRAEfCsQPG
         dFqw==
X-Forwarded-Encrypted: i=1; AJvYcCWWkT2PIXqsRJMrxP0pS7tf/ADmCAxCtj/jB25nKNugYM01r/zgEsAlCE1yr3+OizsIjXYD5Xtv7BmX@lists.infradead.org
X-Gm-Message-State: AOJu0Yxds95nF7OsQGbJgMw9bcoBaeLJhQdElKBeepT1G+2Xo+UVtT5+
	w1aHrkkT4aFVSAnq4swmEKDq2DtMVLD252NUuKoyWM6KEAvl25PltOz3TX1OaxTkDUNVBQZ/Imm
	tDU7RVzoFFRo8hpRVRgamd8UmEerdwZLY5wc5EA4r8+edSLEHLFObi7ToDMQ+DudqSQ2OBhG+ll
	ewYg==
X-Gm-Gg: AZuq6aLudXRyh1B0z4Y9qoekVHJTxorXjAJS0yD7pbc3yWsWB0CEW+O++lho9vDRKYZ
	xjMiIpsi2VNKphA1m8oVDjhvUfERpD76Qocqcv3YcK7BtgvcwCUh2cTHwCx88jSZydj8PXg0P8R
	4vKM/C4rMgI9wLFqcu0jWxfCMwMcOP35P1M6jKf7lmy6MmS4YyQ0+ivlcu7Su+iTcEb1bILljPI
	vStV0qXQAlUmP7dtV3JNcDFA6ItSbZNbfwnAso8dHN+p4phxuaJEVKyedHb+89M6PNdBqqHt4eW
	Yblf5cMqgY5pzLJ3/CmxW3gCtttVDUHlQBgZQCg17UkPKJrPJdWNWZqBf3o/So7owbSuJDQygsL
	rIITSqZB3uR7uh8GftBUmtOo/y38IpqqSCUrKo1PVyUOI+WIjUpI=
X-Received: by 2002:a17:90b:2e10:b0:343:87b1:285 with SMTP id 98e67ed59e1d1-354871a9119mr2601658a91.18.1770213887890;
        Wed, 04 Feb 2026 06:04:47 -0800 (PST)
X-Received: by 2002:a17:90b:2e10:b0:343:87b1:285 with SMTP id 98e67ed59e1d1-354871a9119mr2601622a91.18.1770213887347;
        Wed, 04 Feb 2026 06:04:47 -0800 (PST)
Received: from [10.217.216.105] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1b71cesm2524594b3a.19.2026.02.04.06.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 06:04:46 -0800 (PST)
Message-ID: <563080fc-e5b3-4ff3-9c27-74a167246544@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 19:34:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] nvme-pci: Fix NULL pointer dereference in
 nvme_pci_prp_iter_next
From: Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nitin.rawat@oss.qualcomm.com, Leon Romanovsky <leon@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <20260202143548.GA19313@lst.de>
 <dc34c246-d6ba-4c2e-8593-6fe32a616174@arm.com> <aYDbNC1z81D3lZ2r@kbusch-mbp>
 <20260202173624.GA32713@lst.de> <aYDz-BeIHMNUMiaF@kbusch-mbp>
 <20260203052756.GA15839@lst.de>
 <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <79034c4c-ba06-4961-b41b-a43e5f5946af@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEwNiBTYWx0ZWRfXwmkfpd1qzyyD
 YHUHuZyDX/Szt2lBhyJjxYc84lWZp0LzdYwVQgMfVjDrmo46KfmIvTEaj5S0kPMR23s/6GG/d5R
 j1YFd3REA/6+sBPjEYA90x3CEHmKpo2XpgSKAkZBNp2D6exNx2eOnXvVEkoa+K7F7m/gnpK3/3c
 COLOojSzEAfuLvnL6U0eG2QzfegKwdIjsWj1ePSYw8MmlSdXWCkhEK6n1HSMlxUNnWu5PAx3ikx
 dtDY+ZJrF82KfNkXGTd10fVZu1ci+TDcXaIrLC0e39lUR1nrgHT9Jon5jYVutxdBkrFpTnEJdxt
 ZgGt35evKZrjGm2+VOlwbVMcESHhTxdSFUuX9RG7KxiS1auScx7OajPjgy8DDm+XJpL6KAJRH+1
 pJJ17P4GXlY7O5nVYGKcUebFKC/q4ObdyHnq2SJOumVfQflJVeXnXo2xHbtYDvXLYZFL2kl0HdB
 PK0F9bQgEo6bZR6xIRg==
X-Authority-Analysis: v=2.4 cv=DLmCIiNb c=1 sm=1 tr=0 ts=69835200 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Gc0GUWPnaK2Fg8JTCy4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: O5F7CHamryR5NTPX6C_IkNxtqp8huVMz
X-Proofpoint-ORIG-GUID: O5F7CHamryR5NTPX6C_IkNxtqp8huVMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_060449_574908_D4A55DE5 
X-CRM114-Status: GOOD (  21.72  )
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



On 2/3/2026 7:35 PM, Pradeep Pragallapati wrote:
> 
> 
> On 2/3/2026 10:57 AM, Christoph Hellwig wrote:
>> On Mon, Feb 02, 2026 at 11:59:04AM -0700, Keith Busch wrote:
>>> In the case where this iteration caused dma_need_unmap() to toggle to
>>> true, this is the iteration that allocates the dma_vecs, and it
>>> initializes the first entry to this iter. But the next lines proceed to
>>> the save this iter in the next index, so it's doubly accounted for and
>>> will get unmapped twice in the completion.
>>
>> Yeah.
>>
>>> Also, if the allocation fails, we should set iter->status to
>>> BLK_STS_RESOURCE so the callers know why the iteration can't continue.
>>> Otherwise, the caller will think the request is badly formed if you
>>> return false from here without setting iter->status.
>>>
>>> Here's my quick take. Boot tested with swiotlb enabled, but haven't
>>> tried to test the changing dma_need_unmap() scenario.
>>
>> Looks much better.  Cosmetic nits below.
>>
>> Pradeep, can you test this with your setup?
> Sure, testing has started, and I will share the findings soon.
> Also, I did not pick up the initialization of dma_vecs during testing.

I ran testing for over 20 hours and did not observe the issue on my 
setup. It appears to be helping.
> 
>>
>>> +    if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev))
>>> +        return nvme_pci_prp_save_mapping(iter, req);
>>
>>> +    if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev- 
>>> >dev))
>>> +        if (!nvme_pci_prp_save_mapping(iter, req))
>>> +            return iter->status;
>>
>> I'd move the dma_use_iova / dma_need_unmap checks into
>> nvme_pci_prp_save_mapping to simplify this a bit more.
>>
>>>       /*
>>>        * PRP1 always points to the start of the DMA transfers.
>>> @@ -1218,6 +1231,8 @@ static blk_status_t nvme_prep_rq(struct request 
>>> *req)
>>>       iod->nr_descriptors = 0;
>>>       iod->total_len = 0;
>>>       iod->meta_total_len = 0;
>>> +    iod->nr_dma_vecs = 0;
>>> +    iod->dma_vecs = NULL;
>>
>> I don't think we need the dma_vecs initialization here, as everything
>> is keyed off nr_dma_vecs.
> 


