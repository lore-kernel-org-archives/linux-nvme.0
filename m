Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6B0C61DBD
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Aug 2026 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R29z3TiIvEvAeX1LttC8l8b3zAfZj29lmSmyL3PVOt4=; b=rEbQbhr9BF2LrNUzPF7fiH1eJN
	nPbrrWmcfwXUSHZ3PsFiithLN7RPEgRsDl60b5EudRZHfTgeg6qh10GxECjTIBoBfW5rocF/b43Ll
	eLLE56e1flWmMCgg0pwojmIqaoHc/QT3VgoEMc4+zIQNIEOm5d0A7QkczvDudBN9kAeTPVIXwtu05
	98cyO70WQiSRoab7d0XOnDAyKXoyFacONyRJ4+qGZyAK8ghZWIcRztl+HsJIBB4xn4Y/Z1heClFCF
	rtnSbY7Od42XX/VhYZwG2Ci3P51NdmWj1JD0ZkEKF5iV6YNwrdGvdL7Bv3LFDXp3ajOCMPNbIUGZ5
	euhJHObw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzGKY-00000002jQY-10KP;
	Wed, 26 Aug 2026 16:18:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzGKV-00000002jPO-24RK
	for linux-nvme@lists.infradead.org;
	Wed, 26 Aug 2026 16:18:24 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1cAd3084610;
	Wed, 26 Aug 2026 16:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R29z3T
	iIvEvAeX1LttC8l8b3zAfZj29lmSmyL3PVOt4=; b=Vt1cm/wr4QYBPyrC+jHupN
	xo6HYF/06CkP16LR3oPt7uL6gP7BkS4+UFjAyoFXI3GDyYaK2kPv+TGpI9MCYLqq
	+wQL9yrdWlksTVaD7R2NKoA+sIwslEzM5OxCskK8xbbCqbY71YNoKuAa1U9wz+9H
	SpOcEmra9KU8OQiUkbQuj0Po6NPH3J40y2n30qqGeY5FIQW0Rf8NQ6Nizz+opEaU
	ACEmaIaiuM8dI4W4pQIVlwibeYFuzIHcKcV6fv+x7mEbsAo6oa5qCj3we8KwisdN
	bgtYRGZwolusX9LtH3qUtWZIM6wtSGGSB4DOcflTn+0MSUJys1tWPXrSlqtOmZ8g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eqqw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 16:18:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGBHLo017574;
	Wed, 26 Aug 2026 16:18:19 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k2w1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 16:18:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QGIHwu5047272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 16:18:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E28B05805D;
	Wed, 26 Aug 2026 16:18:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F0F458056;
	Wed, 26 Aug 2026 16:18:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 16:18:16 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 11:18:16 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@linux.ibm.com,
        wenxiong@us.ibm.com
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
In-Reply-To: <d3cb6438-f1b6-4b46-9f96-56819052bc02@linux.ibm.com>
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <d3cb6438-f1b6-4b46-9f96-56819052bc02@linux.ibm.com>
Message-ID: <dc9af96205cfff939f96d7465a50eef1@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f11cc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ploPxCd_3tu-NVudjoYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzNCBTYWx0ZWRfXwBMmCbllE+lB
 HuS/nfCWnNYDYLwjZh4Z8SCcfMl8zTlCzRicgqNxpbc4i4rVWmpwPUN4ffjw9Bc0ljJ37Rw8k5Y
 MJIotIJMxThFwxclvQcRtSyvHjmI5x0=
X-Proofpoint-GUID: nIKCRrERL8KlQ1eQPp_NxxhQbnCt4RRU
X-Proofpoint-ORIG-GUID: nIKCRrERL8KlQ1eQPp_NxxhQbnCt4RRU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzNCBTYWx0ZWRfX4rAfDiZ6oWKP
 cXLl43g7/QaaHhzX8cIbXyHFZh7wDXcdtg/w9eAxtnZhtMVLB7dOc4jK3QVUmf6NcjbKL25J64v
 tRmO5RisHQZDxjbcMnmZfjnVSlvZoUjaBk81N4SPZDx1lStDZKWRiOj17SyrLyPfstCP+q6Igqn
 akHiU8sVJENegM5uTkYTyaH8D/ODtEzYEQXM0o6QAf2juD3bWgnuhlKqPI7haJVlY0zJnvhf6sn
 eCU1IhQl3nqiAeTZV6nW+KV3ekWqRQFHkwV+t9mzTwOkRTTjLL0MO1FA3A3LKalFVu6UF394OlC
 Yu8zUL3q6pkoEQLSBrGdZF1MVXPa4fRE4Lpf1pWsTTwHt5dNUkuCKDrSA//4Pb/Z5Ls1uxJ0Gw8
 OQG+PJV+beiWkgYcAgOJqFS+VhcXIla2qxqCYcIGIHGkTN7F2xskoCrc+5riwAcAiL4CT7yNq8q
 dSLPN2UY+xQvWqWYcLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260826_091823_657603_975808E8 
X-CRM114-Status: GOOD (  13.47  )
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

On 2026-08-26 07:40, Nilay Shroff wrote:

> Also, since a multipath head can have paths through different 
> transports
> , we should not take a reference only to the transport of one 
> namespace/path
> found through nvme_find_path(), as was done in v1. Instead, when 
> opening the
> head, take a module reference iterating through each controller 
> reachable
> from the corresponding NVMe subsystem. This ensures that every 
> transport
> that can service I/O for the active multipath namespace remains loaded 
> for
> the duration of its use.
> 
I will look into iterating though each controller/each namespace from 
nvme subsystem.

Thanks,
Wendy

