Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A544C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 21:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F5MVs6oDUSRUAjgY4MiYH0TKMZs7mAVrQjBY9/ETDT8=; b=jOjmfJEYMTk1oSiz7oaliiM0ur
	pd1IdrfZGQp6V/UZkcvJAy7dUMYaxdh6gfshagv9JemNWbPW4iBQTHpnKmNBL6x6P5wSdr2nzQtAX
	B095QIgRhttL6M/szDdTwrTu/t22yKrRZNYGfm2LKxjWFMLRZ7LTypJqpBQ4JrpR3m5kQ0hlLIihN
	KNnlUJQ25151t1dz0bzi8Bf6kxQZNPyPLFR139Nzq71VQpvnXgjSKANz8/XlMRPieT5HBgR9rLYu0
	LIUPQQmmxFolUTwcxrBz9e6KWZHvbLIhyDNpmarPoqKCBt9TIVTVO+VtyLRubUEjZUMvTWPlrlLq5
	b3ZRDz9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcBbn-0000000CJGh-1KPJ;
	Mon, 19 Feb 2024 21:55:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcBbj-0000000CJFI-42kS
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 21:55:29 +0000
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41JLp205028931;
	Mon, 19 Feb 2024 21:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=mime-version : date :
 from : to : cc : subject : in-reply-to : references : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=F5MVs6oDUSRUAjgY4MiYH0TKMZs7mAVrQjBY9/ETDT8=;
 b=qAHMplMsD17V+PhWCznRBxJIcMl9qPJxo8ggRFVpOg9FyP3z51Bfm5EXKjvLnQtfRuHu
 XX4+gtiqjLJNK56hCoFs9//JINYN/zmZenYs5lBEZFxh9wwX2leUAYP+pym4cH8dd4de
 Tg5pQazX+mNE3rm4K05ScRM6hN4yoPdcux17rm+5DcJnaUAUYO2HctlM57mTHzw5ejsk
 OjxKcDGMiVGeZQadNZGSn3zfU8xB542w+uzBuarETQWWUAyrX3KxHN1PrM41qV99gRGS
 lmdin7+fHE+rmHnKf8Xl4WsqtU096/mnC2YgCFATk/TtVVQdYv9hMkuSpnfHIoNtZ5XM CA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wcepurnt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 21:55:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41JJbrYw009551;
	Mon, 19 Feb 2024 21:55:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84p46gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Feb 2024 21:55:19 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41JLtHop18809556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 21:55:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B1ED5805D;
	Mon, 19 Feb 2024 21:55:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCF0758056;
	Mon, 19 Feb 2024 21:55:16 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Feb 2024 21:55:16 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 19 Feb 2024 15:55:16 -0600
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Wenxiong <wenxiong@us.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: nvme native multipath question with two physical paths
In-Reply-To: <ZdOrzKNn-ryJ8v-i@kbusch-mbp>
References: <f5c8d980ffd12601d258c510b879f4d9@linux.ibm.com>
 <ZdOrzKNn-ryJ8v-i@kbusch-mbp>
Message-ID: <03df8d694cd982973c7c2c08f1d4379a@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kauz6cB0HLIJslmKSkCjKPC4I9CNazXa
X-Proofpoint-GUID: Kauz6cB0HLIJslmKSkCjKPC4I9CNazXa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_20,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 mlxlogscore=817 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_135528_128484_077BCE32 
X-CRM114-Status: GOOD (  19.79  )
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

On 2024-02-19 13:28, Keith Busch wrote:

> Nor should you see a /dev/nvme6n1 in this scenario. The mulitpath 
> device
> doesn't change names. It assumes the identifier from the subsystem. In
> your example, it uses subsystem '2' and will continue to use it no
> matter which controller instances are attach to it. This feature is why
> applications that have opened the /dev/nvme2n1 handle  don't need to do
> anything if the kernel experiences a path failover condition.
> 
> You should see the different paths in the hidden block hierarchy, which
> you can find in the sysfs directory. There should be an entry in your
> example at /sys/block/nvme2c6n1/. I am pretty sure  programs like
> 'iostat' can show how IO is distributed among all the paths of an nvme
> mulitpath device.

Hi Ketith,

Thanks for your detail explanation!
Wendy

