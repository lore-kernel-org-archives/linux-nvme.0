Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E212DC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2026 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zp4XNJg+0MyKurHI6Tj+ZlHtRoeIlJQ/mgYrUN7i0G8=; b=WM2DN5djapUzvlt79ZcmIrTYrD
	o14N95MHYHgXnAVxeEGKCW79v0HoT2aMT1T2AQdz5G7TxNHO6I+NNI4uwYNhX6t+KZ9M5XZGrgEfU
	35ILBfW7kw6swaOXhx6L90+LnBoJX6OzU/loGZh18Uj6SrnyjG4e/+hjB0/0UftZqX5pPd/htkSAC
	rf7G/kwEvGy02gkvB+fTBroJUhIJA3kjS0iHPdLdhug3yeRT2PLaBTL/xbCvDFBC5by1CGDJLFSMF
	mi9TTHG+1Hoz/TwOkFWjwxAG+Z6X5dBdiC0zNKC1IStKRoGTXUVeN6h7Z8VubNQ4J+9uRPlLxTKCI
	YEu4eiFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi68w-00000004Oo9-0oii;
	Fri, 10 Jul 2026 07:59:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wi68v-00000004Ono-0IEH
	for linux-nvme@bombadil.infradead.org;
	Fri, 10 Jul 2026 07:59:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Zp4XNJg+0MyKurHI6Tj+ZlHtRoeIlJQ/mgYrUN7i0G8=; b=hx59fFZFXh0opedCE0wCSWCI0t
	+dW1RvtKqnwnjNeSuTaBtjnfeWeNC1ksJGHR1/SRAnbonXnDFPbQMD1mT6wcsCGn4G66oX0gn2x9U
	e44vDehU+qfagQEltiodr3kcpWPvCVEaTFkFAqD5qFYv31rPKOQ21lye+lMZIfjpm8r5Y9HYqOgEp
	OBpQX1PZQ7zGg6mqBy5+KAjrDTCHXgqvr1RhIp1yDPemZZaMu8J953VHEAxZBLH2IUx4bkWafTuqB
	JBqBJiEQlWtrKIupiDV81ZtNk5JFIUrQS9XtaX7H6EFtB1PgFWcROsZUiN1nmBs/RnwCbjBxWmrjB
	KA2eu56g==;
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wi68r-00000009oXj-3CHO
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jul 2026 07:59:27 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7mJlY4024913;
	Fri, 10 Jul 2026 07:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zp4XNJ
	g+0MyKurHI6Tj+ZlHtRoeIlJQ/mgYrUN7i0G8=; b=dODFMp2m9hTVYPDaHTZjn9
	wZ8iqI9BiFhYYvl/vp50LR6ohqMBsa0d5oynhWc5bPRGz9bCF3gZ+DQO0854zz6Z
	Jk0nCPpykyCtzmsJorWSISJNX/c814RfQOAe95JngAindoVfYv7Siqn/nsglhE6l
	ROv+uVWt8lw6zTQs8ofMUuxxIQN7Zag7BlIkHRjhv+rAKps6hCRu5Y0YV9/yhAF+
	9E0gRUqOnqZhDFDN5p3xc0B1c5QpLxkz0lcy41mNhoxYIpcQaLnlqhS3Of5xjTs8
	xN2nCA7KUUtGuTfUFD/lDmBwd2s3zVCnkAEr/s+ibTMK2J3lYvwFu3GBtts/dnMA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke5w7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:59:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A7o8ji028528;
	Fri, 10 Jul 2026 07:58:59 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6ygpnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 07:58:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A7wxGG20579042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 07:58:59 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A3FF5805A;
	Fri, 10 Jul 2026 07:58:59 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4707A58051;
	Fri, 10 Jul 2026 07:58:55 +0000 (GMT)
Received: from [9.43.90.92] (unknown [9.43.90.92])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jul 2026 07:58:54 +0000 (GMT)
Message-ID: <134eb01a-71b7-4db4-86ca-c9dbfe2f188a@linux.ibm.com>
Date: Fri, 10 Jul 2026 13:28:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for
 nvme_subsystem::lock
To: Marco Elver <elver@google.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        gjoyce@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-8-nilay@linux.ibm.com>
 <20260626064335.GG10731@lst.de>
 <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com>
 <20260629124703.GB23417@lst.de>
 <CANpmjNMCg_Qo9MVz3n_-gu6wRZp+y2uuuzjAdk+a1b-1J4LeNA@mail.gmail.com>
 <20260709062014.GA17526@lst.de>
 <CANpmjNMzD6zyHZBybWNzSqcUC1-0WSLOT9Mb575aSb+eejyZjA@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CANpmjNMzD6zyHZBybWNzSqcUC1-0WSLOT9Mb575aSb+eejyZjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a50a644 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=40Os2SCroJJzJna2eC8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfXwGcaJNFAonL6
 UuHjOGIuKxYiW5dbTf4IcDhf/B5F9uKqTNdJYqFCA4N2XcUVjtxbK0hZSfOLDEoj6FHGYB/kBVg
 kFikNmgQei8L5OfqNerld99QM11oqO9huPF8YgEA3fYgIT9FyhHVxuz5PJgsXptKKxi8gsmPxjC
 GvL9AejtRj4uvyi4sAHinw1PvZKAqzLTDHv2NSobjc5K+b6tZikMZBciFhL+ez2m382nURvs5qa
 xhq3JcNp219MkTJONRU/jzRmnqXV6eXhJl2wPllflQWsIMg0Vb9/OVFKoGf82vd3Vr8w7s+nTze
 UEIG4GWzSMDqKsiwADu7OxToy6RmF9ZS9GDn/mVdUiWiqBia6OV5Qw/tPQ13L7MnGQkYL4JA1TP
 ut4MJpulakDQ6M1/+eO0nAMeh7pMJJxSI3tz44h/STWDIVqWhlTUkPtnhJtKTAZsnM6/w2n0vBf
 ZxbLlTnGJjT7OYF2IOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA3NCBTYWx0ZWRfX8qgw+gQQYaLA
 R/tftCGMsUCv1OiTwBfFZ5pqMjrUncfNnAU8kyInSCfIMrPKNM85TAg1/ADJJzo0wKzbQKajo3S
 ibA3YPgOjPv5NJai5EBRuUOjCkY1K3s=
X-Proofpoint-GUID: vhebDaZFHLuiGBN8AIZTEJhnaYOjYF7i
X-Proofpoint-ORIG-GUID: ZFGPfXrGfD1v-QTe-EvkKDWJ97shht_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_085926_190546_DAB63349 
X-CRM114-Status: GOOD (  24.29  )
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

On 7/9/26 12:54 PM, Marco Elver wrote:
> On Thu, 9 Jul 2026 at 08:20, Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Tue, Jun 30, 2026 at 01:12:55AM +0200, Marco Elver wrote:
>>> Initialization of guarded objects has gone through a few iterations,
>>
>> And all of them suck badly, with the current one being the worse.
>>
>>> so I don't want to open that can of worms again. I think the
>>> infrastructure we have now provides various options (the scoped guard
>>> machinery isn't the only way). You could just write:
>>>
>>> /* Initializes unpublished lock-guarded variables. */
>>> context_unsafe(
>>>      INIT_LIST_HEAD(&subsys->nsheads);
>>>      // ... other guarded var init in same block ...
>>> );
>>
>> Using all these silly context makes it total mess unfortunately.
> 
> The only option then is to just mark the whole function
> __context_unsafe(init). We can't have it both ways: analyze an init
> function but ignore lock-guarded accesses without annotations.
> 
> I'm out of ideas, because this is fundamentally unsolvable problem
> with what the C language gives us. The C language has no explicit
> constructors, and therefore our semantic intent cannot magically be
> communicated to the compiler without additional syntax; we need some
> way to mark things in C. My initial attempt of making it closer to
> magic:
> 
>      mutex_init(&x->mu);
>      x->var = 123;  // var is __guarded_by(&mu)
> 
> was rejected [1] on the grounds that we might want analysis in an init
> function after the context-lock-init. And that's reasonable if we
> favor safety over the minor inconvenience of marking initialization.
> __context_unsafe(init) is the option to not need to change the code
> but gets us no analysis in an init function whatsoever.
> 
> [1] https://lore.kernel.org/all/20260115005231.1211866-1-elver@google.com/
> 
> Aside, in the C++ world where constructors exist, Clang just disables
> the analysis completely in ctors to permit lock-guarded variable
> initialization. So __context_unsafe(init) attribute on a function is
> equivalent, given C has no ctors.

Okay it seems in that case there's no other choice left for C language, and
so I'd annotate init function using __context_unsafe.

Thanks,
--Nilay






