Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5076C43327
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q1fDHdni7BTZ74wL5TnS6E4zTb6vQ0gQiXc2ZDs+4cI=; b=Ww1xFHpqT5FmmIz7ICaaoyQPps
	RkHf+sWqla5t0bYSL1wRPIYphYacpQseqLZGRSvl0BWLRRcHmSaYt5yVQAT3aS/K9Et9lYrU6KM2U
	A5wimSk5s0KhdHOeCmO5k/Acmi5B6p7HOV2bisIwEgdf18R0IoLo/A692L8vImHk+YB2392ONVjKE
	RP5kMZlrvwWwDA3dPGU6gJ4a8H42HptgcHaPx+Dt3tpFSagL9T7DQLdX97JXpQzZuPBLCLU9g+mdX
	fvIq+PkCn0/dsbokK0Zj6hKhXEVu6xhxy3lslr4TbCVemJY2awZma+TjsmVhnI6dcdPihCauo3zTt
	vT9VxOiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVAZ-0000000GXUm-3gCO;
	Tue, 30 Jun 2026 09:54:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVAV-0000000GXTl-4B7W
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 09:54:17 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9mu051843054;
	Tue, 30 Jun 2026 09:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q1fDHd
	ni7BTZ74wL5TnS6E4zTb6vQ0gQiXc2ZDs+4cI=; b=HnsTWr8k407G47hZtG1zFm
	2CVFYwyNfMHZUXweC7R1ETh2f9G4vemZ1mBVorgwB8aVnHyynt4unZ1kg1oKTEO8
	G87NCs/WPmxA4dPnFF8KRBUKaW6Dw7fDakbLW9rJR2VGb+9Eav6ZK+xosP5EDtWk
	HwRWNkiWTmM25GiQuaUQoMfMbpUwwC26AdL4BC48xHbQkRYyvTQ8DQqQU7pNH/Vz
	mJfVNvu9udQ0la6hgaEiPxqprANYtvVsmkmMg/0ZDv91dM62rfis4g7fZs3AUHEu
	ragDvwny+unfwJqpHsUtFjTo5YfJ/4uWizpyd8pwL0IfhKXzyYlLnYDg84/Ku7mA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfx02r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:54:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65U9ogS8026725;
	Tue, 30 Jun 2026 09:54:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh9fj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 09:54:00 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65U9rxMQ27984624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 09:53:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B44F58065;
	Tue, 30 Jun 2026 09:53:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49A255804B;
	Tue, 30 Jun 2026 09:53:56 +0000 (GMT)
Received: from [9.43.78.19] (unknown [9.43.78.19])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 09:53:55 +0000 (GMT)
Message-ID: <3d7fd5f4-26b1-42a6-89c5-961ca53c51b1@linux.ibm.com>
Date: Tue, 30 Jun 2026 15:23:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for
 nvme_subsystem::lock
To: Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-8-nilay@linux.ibm.com>
 <20260626064335.GG10731@lst.de>
 <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com>
 <20260629124703.GB23417@lst.de>
 <CANpmjNMCg_Qo9MVz3n_-gu6wRZp+y2uuuzjAdk+a1b-1J4LeNA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNMCg_Qo9MVz3n_-gu6wRZp+y2uuuzjAdk+a1b-1J4LeNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a439239 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=0mtnGOBys8VYx1yaTfMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfXy6gKIfsqYYx0
 Bl4l8paTI+DPgvSLiOqPRi8GNPbTId9I3OoSaU1HyCcPBKQhHFhp1piFHqX66rGilAbmMs2toyI
 cDs5EfyD0uAjbpQ125FvSwqOfiKQJzM=
X-Proofpoint-GUID: rYl_u7GcU5mW_8CCbmW5DLUVtqO4tRng
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfX4jpJFrbUTxGi
 s6wnSvCk/wFJk2QSIvZAbi77bFksvLeyZnDfRSoH3yo7GiKSigq3OvDBXMxaOFDo7wiFWj7Hus9
 lt/rqdycKGdfkGYyk+J7xpa09L7qtmRjikk8mNrxccqmImx5r9hmCJy9oeC77EUbogU72d+UNjp
 S+q4VBsJdMQfm7UEEfiHbSB094JK39oOwizL6M2UiI4khDgGwMBlZwSvkMpDgSMUo9SIh+cRGUt
 8UFaYZiPB32FwHHkAQjepavkkIg0m23c0REC5x+2ivygVgntLyCYtlkuecDDkMv4a3B8xy3bIO9
 E2J9F7691AsdumfXnYOEarK/NC4xKTslwpiiXo6JgKDr1zTMtU2yoyRcygsnUiKC5rU3kbznLq7
 8Wi+yCh4eOXFff6/yiIFrXk6sLtdk5GEbMWVoHhXXQNoM+yBAPXtEGjdiPtXmcCjG7xNTc6woLM
 YKnRFrTRs12A261EkvA==
X-Proofpoint-ORIG-GUID: w-eRV6Q1DuxrWGYutyz3Wr6v7mFJXoDU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_025416_045375_1E3306F3 
X-CRM114-Status: GOOD (  28.65  )
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

On 6/30/26 4:42 AM, Marco Elver wrote:
> On Mon, 29 Jun 2026 at 14:47, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Fri, Jun 26, 2026 at 08:09:52PM +0530, Nilay Shroff wrote:
>>>>
>>> yes correct, but this one is tricky as the list has to be inited
>>> with non-zero value. Another way to fix this is by adding
>>> context_unsafe wrapper around INIT_LIST_HEAD(). Again overuse of
>>> those unsafe wrappers hinders readability.
>>>
>>> Would it make sense to introduce a helper, e.g. INIT_LIST_HEAD_UNSAFE(),
>>> that simply wraps INIT_LIST_HEAD() with context_unsafe()? It would document
>>> that this should only be used in cases where the caller knows the object
>>> has not yet been published and therefore no concurrent access is possible,
>>> such as during object initialization.
>>
>> I'll leave that to Marco and other core people, but I think this
>> would be a lot better than the current version.
> 
> Initialization of guarded objects has gone through a few iterations,
> so I don't want to open that can of worms again. I think the
> infrastructure we have now provides various options (the scoped guard
> machinery isn't the only way). You could just write:
> 
> /* Initializes unpublished lock-guarded variables. */
> context_unsafe(
>      INIT_LIST_HEAD(&subsys->nsheads);
>      // ... other guarded var init in same block ...
> );
> 
> context_unsafe() has a statement expression inside, so you can have
> multiple statements in one context_unsafe() block.
> And leave the mutex_init() where it was if you don't like the scoped_guard().
> 
> Although here you just have 1 INIT_LIST_HEAD() that needs that
> treatment, so "context_unsafe(INIT_LIST_HEAD(...))" would do -- it's
> just 9 chars more vs INIT_LIST_HEAD_UNSAFE(). And as soon as you have
> several guarded variable initializations in a block, you can group
> them as above.
> 
> If you introduce INIT_LIST_HEAD_UNSAFE(), that'll create more ways to
> initialize guarded variables. I'm not against it if none of the other
> ways work for you, but expanding the API surface also incurs a
> complexity cost.
> 
> The simplest option is just adding __context_unsafe(init) as an
> attribute to these init functions, although I see they do more than
> just trivial initialization, so keeping context analysis enabled might
> catch real bugs.

Makes sense. I think grouping all unpublished guarded variable initializations
under a single context_unsafe(...) block is a better approach than wrapping
each initialization separately, which can quickly clutter the code.

In fact, there are a few initialization functions in the NVMe driver where
I annotated the entire function with __context_unsafe(). I agree it would be
better to narrow the scope and annotate only the unpublished guarded variable
initializations using a single context_unsafe(...) block.

I'll update the next revision of the patchset accordingly and gather feedback
on that approach. Let's see what others think.

Thanks,
--Nilay


