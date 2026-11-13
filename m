Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F2606A31C
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Nov 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hrH9e55y;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LgJEwduZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vnPUCBKwIWA26aZCBOtJ9v7CjuBXKwsSzIlks5QqAS8=; b=hrH9e55y4fFBet
	ukByIcq3qdRyGCGLVnqFvQKw0YGyg0YYH8uguBo/yPOODn1gnageUzSrBNPRatvF38UfIy0L1Osy3
	7ZBvCiv+udk5odRaXicWuV8FSGbgawQ0j2BwvGyZC7sJx3P1T/ncJ4feepOY2RlF3CA/kMwQ1/rIe
	2tPRsXXfJ9qf4ZroV3RvtcOGWH7xw7CaBxQDMZtwLv5gCyDpkUZWL0pzNi447vl9hU/wnLzkCE4pm
	+PUXySg+W8ZGmx7487sFzHeO1lvTAakNHdEOcoKNNdyV7GjpSuFtaOAqJBH6Mu8qcdoGIPSeuNpW2
	3qbjuhT3bcWku2kRpFFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRn3a-0000000CADG-3RuI;
	Fri, 13 Nov 2026 08:54:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRn3Y-0000000CACE-0bjq
	for linux-nvme@lists.infradead.org;
	Fri, 13 Nov 2026 08:54:50 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8jGJA1153728;
	Fri, 13 Nov 2026 08:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vnPUCB
	KwIWA26aZCBOtJ9v7CjuBXKwsSzIlks5QqAS8=; b=LgJEwduZgXhQ3E8lg5q/mH
	ws3Yz0aTRjg++MkoHiod2+z6mYSp3fhuVklytJzsRUJgGVSRyLfvFZgggoSWjd4s
	kApUZbvjhd+OuxUmi1FMfN+WiI2AoxoQQxDCqTsOpW+xf+RBueRbi5g8tui3//9P
	/Oui+NlDbHmUg7ePmFYM5K1r6EtVLDmYiFZUF6aMcLQZWRMD2mNHSGcarrQpOKNs
	3NxoZikWgYXXZXdkPg71sTD+I3cgEjzlSGnZ+P/r+7SZ2/3Z+/HMz1O0X70banNs
	xQChudNDHLLaP1ICJj/0wZll9TVfDweNstvBP8uAS0v/NQfy5PMe+CwcjHqFPv+g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdghedw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 08:54:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8Z6W4911795;
	Fri, 13 Nov 2026 08:54:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd521rep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 08:54:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AD8sUZN23462556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 08:54:30 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C701D58058;
	Fri, 13 Nov 2026 08:54:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6EEE58057;
	Fri, 13 Nov 2026 08:54:27 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 08:54:27 +0000 (GMT)
Message-ID: <6aeb363b-1c03-47e1-9a14-f0a788da8abb@linux.ibm.com>
Date: Fri, 13 Nov 2026 14:24:26 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: Bart Van Assche <bvanassche@acm.org>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
 <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
 <e9f42390-9115-40b2-b0a5-df17c53ce38b@linux.ibm.com>
 <6708de12-ed0d-4101-9328-d08864e677a5@acm.org>
 <e31029f5-c022-4fc9-be94-d1faadfb327e@linux.ibm.com>
 <849733b4-9790-49fd-9585-25b137eeebf4@acm.org>
 <13905077-d09f-424e-b04b-cb1a961323c0@linux.ibm.com>
 <3ed27af9-52d7-4090-b962-cbc54ff07185@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3ed27af9-52d7-4090-b962-cbc54ff07185@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af6d048 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=N54-gffFAAAA:8 a=h-1I0Ujs0ITHK01v6rMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX8Jqh81t+GuIb
 2lCwZ6NbT+ikDN0TgJBwcb7bPWz3AzKaFBYJI7M3XvJlRk14F6n2TxseI8txLSZ/ZLVGIAz9YtB
 OEmIjI3l3V3pULKWKJD5SzOS88uX3i+zcji/u/kiXz6m/7OvWf3KtYc7G9UF6hI+WZxMVY7PCDi
 4ovRN95IC+H75H+aACcRktzP6H8HzkuNogizdg4TnQr6yuFomUxkEksmxrv3l66sQtCFUk1xELx
 2lsCqzE2FvGF2nazWSIPe/0uOLQeV3F8aMdarILMy0/XI9CUivyw2vnDT3jyt91XWNmvDwRsi7u
 4D9cRvHWjPREQGZ495XKmWJOlEQERymj/Di6hOOBJy3XqbK7MQ9VYNh8ZOd0rxxuC1+I88xGe4N
 CMTFjyCxwuJXfjVe4arat/HL35+A9rY3AdW4rRCnkS5Px/w47bfUF5jumuVSaYFIQOtngZGwtx9
 7Xo2LqLIEepjnLSXeeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfXxtpjpV9gS87A
 H/Jy7XXO33PzTNIVheswXcTmhTTnQjHFfmKGqoqvv8fCgQUA8AuF6vjWX7ZfXb5AlWlxGV2pfvp
 AWtbPdKNWKSoA1F2E7EHrH4yElfmkE0=
X-Proofpoint-GUID: YNgj3nWQcrWa_AeURzil1itbxIn42Eb4
X-Proofpoint-ORIG-GUID: LJwMz1o3gVrGNrHGwgHIkE5LccBtn7v0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_005448_955747_EBB6D549 
X-CRM114-Status: GOOD (  17.19  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 11:05 PM, Bart Van Assche wrote:
> On 11/12/26 1:04 AM, Nilay Shroff wrote:
>> And yes, adding the lockdep assertion resolves the compilation error.
>> As I see now (frankly I was not aware about this earlier), lockdep
>> internally assumes the required capability, which allows Clang's context
>> analyzer to satisfy the corresponding lock annotation.
>>
>> So as you suggested, for complex call paths involving multiple locks,
>> where the same lock may be accessed through different expressions, I'll
>> use the appropriate lockdep_assert_held() assertions instead of explicitly
>> adding __assume_ctx_lock() annotations as far as possible.
> 
> Thanks!
> 
> Something that you may want to know is that I'm proposing to remove __assume_ctx_lock() again from lockdep_assert_held() and to introduce
> a new macro lockdep_assume_ctx_held(). So far no agreement has been
> reached about these changes. See also "[PATCH v2 00/14] Stop
> lockdep_assert_held*() from assuming lock ownership"
> (https://lore.kernel.org/lkml/cover.1794250850.git.bvanassche@acm.org/).
> 
Okay, nice! I had a quick look through the series. Since there hasn't been a
consensus yet on introducing the new lockdep macros, lockdep_assume_ctx_held()
and lockdep_assume_shared_ctx_held(), I'll continue using lockdep_assert_held()
instead of explicitly adding __assume_ctx_lock() annotations wherever possible.

If your proposed series is accepted, I can update the assertions accordingly.
I think this would be a reasonable approach for now. Based on this, I'll re-spin
my patchset incorporating your suggestions. Please let me know. in case, you
have any concerns with this approach.

Thanks,
--Nilay

