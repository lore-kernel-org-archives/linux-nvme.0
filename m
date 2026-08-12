Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBE5C5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 03:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zBjkVcikH9DjlrVgaQK6r/ZXwct++QMD0bYk6fKV20=; b=BABCc2Y2wYkcMerpPQgnSb0xg0
	QimAeK4M23eLI+UwhTLqbuwGgFz5Mcmer2MbACWiHHMcBjypzg33+X7JmQhB3QY8O3Mhqj/5fSeDA
	B/Gwli5ESRvCJb1jihFQs60TGdVHztqi2FTOBl1lwvGuL0wy7OZv8yvNdy2wEGek9wzcpd4bSBBx+
	vdpi8cLtjoW1inyg1W9JRztkW+oGjaq/WSj9EGRD9uZ0gSnhoL9VP3HkcLgULWL6j6cZsjOKdElKU
	lt0IIHbIEs6XgudIsg6ZnfWPMnV6bEg7QlbDWXHBtzn3XOvn0prODXe1jBxPhkBWStkObvD05eCNj
	vu/qJAGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu086-0000000FNfl-3FKc;
	Wed, 12 Aug 2026 03:59:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu081-0000000FNfO-1W0t
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 03:59:46 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C31ZVI1185221;
	Wed, 12 Aug 2026 03:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6zBjkV
	cikH9DjlrVgaQK6r/ZXwct++QMD0bYk6fKV20=; b=TXBPjtEwGUgHmXZKNMjSdv
	/axyzS3xsL0lNHOSYNn+A9126KpF9BN2OeNyMLqz03H3/R32ncV5Tf3MXP++L1IX
	OtZbbljhpDduy1nXuadXXeCTlC3I1ExSSw1B/IfgSbuUdX8L7W+FgOVdimOreYfA
	4wE4IEYI+HmrZMJsosSdNxDXtGfpe8YONWLAdohcVqVfaidRaDd8Qf7hTO/tKc5M
	5NKXIuTaxtfi1toizAp8x+wU/EqpwWfZZ8HyyupqMDtvfYcQRPvx4+xv08FW5eUl
	rsl9Q3PXZXWWq+QIhf9dTx1MRg2SfsqKzLC6/Hl6+CrOmvB7OHN5hDrpeZQbUvGg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23s971-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 03:59:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C3uXxu014806;
	Wed, 12 Aug 2026 03:59:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy45fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 03:59:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C3xctO33751672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 03:59:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6DA65805D;
	Wed, 12 Aug 2026 03:59:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3501258043;
	Wed, 12 Aug 2026 03:59:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 03:59:38 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 22:59:37 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, gjoyce@linux.ibm.com, wenxiong@us.ibm.com
Subject: Re: [PATCH] nvme: Add module reference counting for multipath nvme
 device
In-Reply-To: <anuK7GONhd3scxb-@kbusch-mbp>
References: <20260810235034.544797-1-wenxiong@linux.ibm.com>
 <ant0I66BcAugTyGX@kbusch-mbp>
 <07ba01ec9c9f54da7cf7b3b4096f1e7e@linux.ibm.com>
 <anuK7GONhd3scxb-@kbusch-mbp>
Message-ID: <809963f2edc80f2bbd05b8599f092d18@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7befad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=9lPjST5oYK36hZEwjD0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDAyNSBTYWx0ZWRfX6pjYcecMGbjN
 6l7z4KguI9RaJOtN0y1GxMFenHVG62OaWPS7WgJMgN9ergpKjeOsXE3VoMkmytQpgLp6cxQAkwf
 b8QxzqRa2VpmauToL7aimonMZqYUAEdzc43YeF4HE9O4TdwxM+okfy6SpeFd8BWSpiJUbVxtUfa
 +OQMCC/VVHXFDdS5baZCFMa5a0/41iz111VfRS3hLdj475s4sYCCmYVnyimBzT2h6MB5PsF/9k0
 XU+v2PsGXSaIjujdT/q7vZKY7QgPP3+28gnrzHTrcqgVoPbiRrJq5v4uB+1i7KdbfIpSDAw9FsB
 peNxcY0IU4nssfC0sGJbENJpnHwmAb4zIYPCS90kS1/6EYL/IL4xpeMQ6gK3qqMhTxPAFgFRvWh
 SL+X7Aph08JO7MJtTcU9XojXM9ZoLKQxGjKhIzNG1+ooII8sL45k3SA+iGph1GSRTz0N5504JtD
 p9torFdpJ4+MeaSw4qQ==
X-Proofpoint-ORIG-GUID: TlDuoalyKUyhcB76vU5pv0V2pog8Qm5G
X-Proofpoint-GUID: TlDuoalyKUyhcB76vU5pv0V2pog8Qm5G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDAyNSBTYWx0ZWRfX/ssqNTxHQf3y
 8+h8WAvEW378Gteozs8IVogRjnKYmL48mX27ZdOioIyiNWYbUN/jJAQEkr+yzaUGTxpZc/dp4xC
 gRF16Rpu9eHeSaTT48bNQn/DBTqFWJs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_205945_545660_CA455CE0 
X-CRM114-Status: GOOD (  16.69  )
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

On 2026-08-11 15:49, Keith Busch wrote:

> Let's say one path is rdma and the other is tcp. At the time you open,
> the RDMA is the current optimal path, so you take a reference on the
> nvme-rdma module. But while using this multipath device, the RDMA
> connection is lost, so we failover to the TCP path. When you close the
> multipath device, you find the TCP path, and then drop a reference on
> the nvme-tcp module, leaking the RDMA reference, and underflowing TCP.

Thanks for explaining this!

> Just a note, unlike I initially thought, nvme_mpath_remove_disk() is 
> not
> the mirror teardown function to nvme_mpath_add_disk(), so the path's
> module reference put will have to be somewhere else, like
> nvme_mpath_remove_sysfs_link().

Thanks! I can regenerate the patch as v2 and test it soon.
Can I add module reference get in nvme_mpath_add_sysfs_link() instead of 
nvme_mpath_add_disk()?

Thanks,
Wendy


