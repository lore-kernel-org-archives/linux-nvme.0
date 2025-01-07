Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8F3E77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 18:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WV+TLZuDtrq0vN0L2SGNhb5nPcib4hM5tam8yfuu2ms=; b=T+UNF/pmCQOvV/CA/drEQOC3bl
	Fmnf+Hev/mUiHq/Uh9Adp67yQCBGGSOud/aKU/CSbL/BvCv3iV2tb1BtDKVSFo8chlB7iiKiuEQI7
	Rf0TlhQ3JMGEF/QEm38M7h2QpRx446i3I/YhCBckVgRZOrnm8SzzNwf5mrYW6EX/QD+fwnLrU94ui
	GtuZcBnQaC210KcBdRT14jxxYkrXh1SdAw9aP6j28bhTuKJGoYKHh6NoVgi7UlVjwf7abj4XGuTLN
	BrXpzN044kDJZwhHETBeW0DAnHgYAzZrjOuN5N54Ce+fUlkeiVXVbAjOlMdG4GiYC4V8kpp2tBcM3
	aL14EbTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVDzn-00000005xfr-00cH;
	Tue, 07 Jan 2025 18:08:03 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVDqS-00000005vzv-3kcm
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 17:58:26 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507ElJTT027462;
	Tue, 7 Jan 2025 17:58:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WV+TLZ
	uDtrq0vN0L2SGNhb5nPcib4hM5tam8yfuu2ms=; b=XTXK1PDWfRe2ml0glTtfRb
	OUU4sxcny5hpBhBRM+oFVlOyF9PVrk5FAz56WDVVj+n3krjbgWZzKx8vhgryAdfr
	LBWQW4eS16og/TueLOMC08LfvR0RBlT4XQ4ltdA8hs49g9lDqcPajQBVUD6W1+Sw
	2358ezzTorjMRnljFZ1jmNMA69A0EMEq3Y7qLNAscwpkVXoz0HksKtHZ71EMnq6E
	t9rlePeOCIRmtwFLhy3SjhAVvcyXzhTksapKwjpGfkvrjCi8s1fUMHOeJtmlvZdA
	zvYSm2fPV6prDVNGj8K4P+S7LB+QG+q3TmVNZ820S+b953mJgyIiuYLd9AqCHRYQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrjbqs1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 17:58:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507HF41Q015903;
	Tue, 7 Jan 2025 17:58:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43ygtkumpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 17:58:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507HwJn222217344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 17:58:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 943AF58052;
	Tue,  7 Jan 2025 17:58:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A443C5805E;
	Tue,  7 Jan 2025 17:58:16 +0000 (GMT)
Received: from [9.171.94.59] (unknown [9.171.94.59])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 17:58:16 +0000 (GMT)
Message-ID: <9875e768-1506-4ed1-8d02-3cf6e86d0c8d@linux.ibm.com>
Date: Tue, 7 Jan 2025 23:28:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] block: add a queue_limits_commit_update_frozen helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        nbd@other.debian.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-3-hch@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250107063120.1011593-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2jFm_4JPVrYZ5aZE8bzYB-U78GoWq2e2
X-Proofpoint-ORIG-GUID: 2jFm_4JPVrYZ5aZE8bzYB-U78GoWq2e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 adultscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=714 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_095824_944694_B0709CA5 
X-CRM114-Status: UNSURE (   7.71  )
X-CRM114-Notice: Please train this message.
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

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>




