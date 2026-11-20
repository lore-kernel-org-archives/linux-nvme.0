Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A3606A330
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ekgue15o;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TfMruWe8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MBIG+cH50SC/XI9GRr24wIYTEsvXHcPRF7vwZX+zhRc=; b=Ekgue15oO0xI7K
	Vn+Ym7tn5Anvz3KqaLapUIZ47OSabsN8R3y4O3ut33AMLK2fsNgA/19lP4biFX5ye0A7EsoCbPuKP
	/9uJrP57CW2FIag5kk7cNuiu64tGB/CSyaOBNTwDGnRwIkXyL+kIOycTBYdIJ9HcNfd9k0HiB4kz3
	NrMQJhFaGYEJH2hfVIU6IQHY8Xx5r5aHasynZhqB2FCVWpvRzrYpRyDn16hA/S8uLB8gFkzkkOX+o
	mra/T9Y+bBf0Ht+8B/5lT/eWGkBRzSzeHsn51iNSDpoYgqRFM4/mmrJfsvHJOcKFXsxHz8XTfkXrJ
	LrahcwfckFyyvyNs0zqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSX8-0000000FjJk-15wr;
	Fri, 20 Nov 2026 17:36:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUSWz-0000000FjHJ-2VbL
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 17:36:20 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEuTFR1754959;
	Fri, 20 Nov 2026 17:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MBIG+c
	H50SC/XI9GRr24wIYTEsvXHcPRF7vwZX+zhRc=; b=TfMruWe83lvAhJS6sUxaFa
	cRMdDHsPLkbMv7+cArmwdAZ+ib02A6v69FUcvGaVlJpHIqloGaVnzbYD++cxBWiq
	E7Wt1ANaudixtN0Vvu4yh44GHb+ADigL1hT7+Ys7lsYsfIs/aUQUaO7m010nHdyJ
	KZi6X26c+NZb5JQPIx0+7KrYBhjEEWkhmBvThkMrPC1x1a/TSBifT9HJl9DJ9Wk7
	tV0ezkDzilNPwUPsmjW2O8UE7WZIVvxmq7hwADuHiDoIr1K28Gy93GopIyqi41vy
	47Aavb2tWdmqX49FjgUie32MnkuViI5GlqUnaP/7x1eyQIvKBA3ptMvtUs2KBYGw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105s22by-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 17:35:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEo0Mq1313896;
	Fri, 20 Nov 2026 17:35:51 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j2q5nh4tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 17:35:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AKHZo1L3080706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 17:35:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09DB58055;
	Fri, 20 Nov 2026 17:35:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64A3E58043;
	Fri, 20 Nov 2026 17:35:48 +0000 (GMT)
Received: from [9.61.150.232] (unknown [9.61.150.232])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 17:35:48 +0000 (GMT)
Message-ID: <70f1a219-05cd-44c5-9d34-b30b00539a93@linux.ibm.com>
Date: Fri, 20 Nov 2026 23:05:46 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] nvme-multipath: keep a large delayed_removal_secs
 from wrapping around
To: Qiliang Yuan <qiliang.yuan@linux.dev>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261119-bug-nvme-mpath-set-live-srcu-v6-0-da85b18b274b@linux.dev>
 <20261119-bug-nvme-mpath-set-live-srcu-v6-1-da85b18b274b@linux.dev>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261119-bug-nvme-mpath-set-live-srcu-v6-1-da85b18b274b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1SmBlhJnzNhH5fF6zGWveu-GdHaFFe5u
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6b0084f7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=46_-i4G4P8Mb9RBiHV4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OSBTYWx0ZWRfX991gpPG0Dr0Q
 KqJPg7Udlv38obae9oHV72bDr3j6JFV2MTOlfWw7f8iOEZTOrMqMOELg0EXe0AsGNkoixpOGPEW
 R0eplEOR4KAhBMy0JNA9X3bKzzdzLiM=
X-Proofpoint-ORIG-GUID: 1SmBlhJnzNhH5fF6zGWveu-GdHaFFe5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OSBTYWx0ZWRfXzv7QLDSYE3JC
 O7DL/wclV4Rh7RoenEo8jITWcOify9Oi+BHUVNO19MqM6PkpxCieiGvq1CO6iEi2u2nLWBI1HSv
 drI5RL/JxzUlarWMDX6j91uGLmdMzBCpb7pwLvz+j9wU2gLezVBTekEGiehMsAh+mlKRk6J12bS
 bir2nLNzwAz4SICsexrH2c0/Sx6m5bXH+2XYVWY4TJ8xM7a8Y/ODF5CU0M3aLyHLmKpDpRkgbrk
 LHumQucsJj2i9EpTE0ONncZHWC+jyBwiEE3pBni34K4rLA2Xud69QsX7MNwtog+G8i7jCaitNLz
 AJ1fDNSR0C3LnkB00e3N7lG0nSthpLpmonHCqkA+6VOQUlRVU6KV1oSIhuCP4aVseS8qGk5a/Ik
 7pPW5KEXyq+UzXDkFlfQXFmC1KN3Fe8uLEyhm9J34EIUVZ93l0nzZn0PYLBR2bvWuDRrk2JMzug
 ypBUCI24qYLnDqhGhpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_093616_353674_D6A1BB20 
X-CRM114-Status: GOOD (  15.15  )
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
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 6:55 AM, Qiliang Yuan wrote:
> nvme_mpath_remove_disk() delays the removal of a namespace head that
> lost its last path by delayed_removal_secs, which it converts to
> jiffies as delayed_removal_secs * HZ.
> 
> delayed_removal_secs is an unsigned int, so the product is computed in
> 32 bits and wraps around for values above UINT_MAX / HZ. With HZ=1000,
> 4294968 seconds turns into a delay of 704 jiffies, and the head goes
> away in under a second instead of after about 50 days.
> 
> Compute the delay in 64 bits and cap it at MAX_JIFFY_OFFSET.
> 
> With delayed_removal_secs set to 4294968 at HZ=1000, removing the last
> path deletes the head after (mean of two runs, min-max in parentheses;
> "> 10000" means it was still there 10 s later):
> 
>    before (ms)     after (ms)
>    858 (856-860)   > 10000
> 
> Fixes: 62188639ec160 ("nvme-multipath: introduce delayed removal of the multipath head node")
> Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

