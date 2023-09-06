Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E84EB8FAF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aQaspwZSJJtM21g2OzLESdFPFokqz840JkpUacOMhE=; b=x1YzZcZU1+Bp5syqyT390Mtzq0
	ymdszAKOVCj57Ic+PvY/VCvApKX1baO9yU31QvflMAHbYjkyqDdmyY15+GYIN18Zd1EIz8swKNKaH
	cfYMiB0tFUe6OG26IzbBRV3ZLSrtC/P+TidXnNi+a9D920WVZ50ug4uPhtcCn6rJlNY5tMCBTNKrZ
	AgzAnPADEMe75mL62IuipSC91654X4pQ/4da4twejmzdGBxS8WNpwGQKQWCXdUqdEJr+8A39y3kRV
	nsFdh4kmlCpq5jWKJRB3EVGsRu+g5rwuZC2zftOsw4IMIoqOjR/Pkp6QdwMvgm8OyYr/zHGXKhxIt
	Xn6QUusA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdoDQ-007nOF-0R;
	Wed, 06 Sep 2023 08:48:48 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdoDM-007nN0-3D
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 08:48:46 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3868bebT009412
	for <linux-nvme@lists.infradead.org>; Wed, 6 Sep 2023 04:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=2aQaspwZSJJtM21g2OzLESdFPFokqz840JkpUacOMhE=;
 b=l6LE/Y672aPC0JaYvEw4IfGs2Z1KmCb9TZ6BKEU4zq8QTHSXFjSAq1UxV3wVt8AT0gV7
 N2/NVYyKEgmiHUmWekg1lB/KlTqffDk4bWh1Ze31zunPU+tPl+KQpz8OLsoMSszZcDTQ
 wCDbiDSZJedAFNqoP10TDNMBFomzzBhWd4DlW3LIw2gWRy/TdEoYUL849Ol+u7MDSREd
 Uj5jjgHGww8DSwZEkJMlvIqgF63EEVcx30onjojdT82AQ4SocMuf/Zb7O3U1/dkrMBQV
 9eL0vBjFRxBPbTBa1X/Tp5YmV47hrq2HIswhh+uMqmTtHgnNvoFVrs9fGjmcU33hv5fM qQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3sv06whf2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 06 Sep 2023 04:48:43 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3867lPnp034604
	for <linux-nvme@lists.infradead.org>; Wed, 6 Sep 2023 04:48:42 -0400
Received: from esaploutpc106.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3svjjq6h2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 06 Sep 2023 04:48:42 -0400
X-LoopCount0: from 10.227.212.77
X-PREM-Routing: D-Outbound
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="218921149"
Received: from unknown (HELO drmcyc-pawel-baldysiak-1-00.cec.lab.emc.com) ([10.227.212.77])
  by esaploutpc106.us.dell.com with ESMTP; 06 Sep 2023 08:48:41 +0000
From: Pawel Baldysiak <pawel.baldysiak@dell.com>
To: hare@suse.de
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
Date: Wed,  6 Sep 2023 04:48:40 -0400
Message-Id: <20230906084840.3710977-1-pawel.baldysiak@dell.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_01,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 spamscore=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=958 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309060073
X-Proofpoint-ORIG-GUID: owkiKpLcEcQwWix0hIz-L2VtCv7LgH_H
X-Proofpoint-GUID: owkiKpLcEcQwWix0hIz-L2VtCv7LgH_H
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=945 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_014845_126806_B99E2990 
X-CRM114-Status: GOOD (  14.72  )
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

Hi Hannes,

I'm testing v15 patchset in extensive way and observing that it is not stable.
I'm running it on two connected machines - one is used as a host, second as target.
Once connected I'm running I/Os with dd.
Eventually I got I/O timeouts from nvme layer on host, 
causing connect/disconnect loops and I/O hung.
Does not matter if the workload is reads or writes.

Second test is connect/disconnect loops.
On disconnect I've got ocasional delays due to nvme commands timeouts.
The disconnect happens eventually, but first it need to hit timeout.

It is not happening if TLS is disable.

Are you performing similar tests on you setup? Are you observing the same?

Thanks
Pawel Baldysiak

