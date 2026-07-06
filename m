Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B4FC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZNwHp1WLvUb5u+QxIV8sWET71/YQVNBNKDMDCrQyGDM=; b=12MlGHNDs49TxreWr2dKS1hdmp
	iWBkDhr+WSkFDyCfL0OkheqxzxqK3xzYqVOZThRXgihqUx83a+4pOjx1BgMKDo0J7h61ssPKbKV7e
	ZwC2FRJaIcVj6y39N4yEnItyK93T3L973RIALw+RFCN52gkb8nbs5DodjfMaE9DW04vvoClbb5UVx
	6Jch0EHZKNij0ygB74pazh3oHaEHzsP7aCuCz7xA5z5N6Pac/Vqw460oY8LC8MubFGv4/9wabHxuo
	/AFfUVY6j1NNDAwi1gQJryNKGx93+JsStJ4cc9Jwef+XaGZvhfWt4XgSQYcVI4kj1iJ/7SE9QdmlX
	QPRowhow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7d-0000000CiUU-2Mkf;
	Mon, 06 Jul 2026 14:16:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7b-0000000CiRu-2b8j
	for linux-nvme@bombadil.infradead.org;
	Mon, 06 Jul 2026 14:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZNwHp1WLvUb5u+QxIV8sWET71/YQVNBNKDMDCrQyGDM=; b=Gsl751YGFIIIS70L78LkP124G0
	AtJBXc4NTcFIIj5dAkuePo3CFIBrKtZP8iAeFNcuCJSUB1Qi/jXrKFtCQn0MwPMb8hayu+Q8KZ6MQ
	3RoblA+/pDQkWAzNGOUaWi6v+0BRmiFASW0QX2HtJw31QlNIot79fkJ2Y+rdQMlh7fVPhGzWmpY2G
	KQfqGzQ7KmRIGGxw0TMOs6mHubzrLcT6len8jNlEHmYw/pTbWbLgkDqsOm03g9nnyC8KDr0dJbnTi
	Vt/Zs4bc/pa0GZ1oc3XRXcFLxJ6K9q/tju8yHzC3MDhxkALVtUF/Bp2oWK0g+wX5pUAsMZ1nrtPZx
	QDYA9BXg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wgk7X-00000006dnh-387r
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:30 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIQSH4094203;
	Mon, 6 Jul 2026 14:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZNwHp1WLvUb5u+QxI
	V8sWET71/YQVNBNKDMDCrQyGDM=; b=prH+B7IKt3Mf+AzqmBSeC7vE7+IOPmxbG
	5ga/kbx0hbvfBx3khImI3weW0xELdIlUq8QYWed+31xMWU3vI8zegWwXPKjgnd6u
	fcAU/Xg9L8NG+jcbTyk0bAVqntSwavCm4oKu7iigOXF+ZOYAPiY7a9XkycXDu5Pr
	82ZxlukywZwrpJa0GN6d7HG5+w3noPywa+hdhcTFrwRrIboZxu8VXnOOltNnQmRP
	/5MuETf8ZDSLVv+UbKS41AgkQezsh4MBgySxeWcEHjJ5x5rp9fQ1fRaHVQHRBg05
	GU/I03RejCjCl+5kObGrBc0iUSLeEHb0qaLCQ5Q75WQP+hgaGlklQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hsu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4kxN031373;
	Mon, 6 Jul 2026 14:16:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h5tk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EGBc014811482
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:11 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C30620043;
	Mon,  6 Jul 2026 14:16:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D866C20040;
	Mon,  6 Jul 2026 14:16:08 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 14/18] list: Permit context-unguarded access with list_empty_careful()
Date: Mon,  6 Jul 2026 19:44:16 +0530
Message-ID: <20260706141452.3008233-15-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zExdXhfxLOdQT3ZahkjvEZVbsUZbgkvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX5NWPkmFoGH36
 YXVctFggdQgTMiSh56FSUTUu8V3xrR4JBCA7lS5JvSAo4oBQjzQH8iE/Kx8m5gZwfTaqyDAUBr7
 IV7d/Wica/qsCXyE9cPIDTyqg0umftYO0Bj5NYkZ9fUWsULFEfGBK4yT+Y3qbrwdIgKhs+yKEXC
 nCNLK8gwnE4RAzCMp8kCYJnQR6mWN02brY7YbbaVJvtVNnaTje6l8einLaj3AgPbgnblSHigY45
 iy0N7rTpQ3rnPmub7xBd5v8UvC8cLzo4+ZqdLCqtiYMs9HS/eDmvb/TltKWvILbPImh36y/HoYi
 Q3f6vgUPgWprc55DsTOpN3VeTM+xLT405FKKtq1ycTGpJtMcF+dBAPCJC9hDAB/+8Taf2h8Wk6Q
 jf+XPIQZW1gdcAT6pV1wbUXHdIfPn492+WyM7DB1geTInL7CzLRpQrb/728CrflxR1qDuWaTmcn
 mR1YiasCxGQz2T8A2LQ==
X-Proofpoint-ORIG-GUID: UI6wjm6m7F984Ph73J_QMP7O5GC2w4Gy
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb8b0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8
 a=4at8UNLr3tDfbFC0C8MA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXzJeosjubft43
 rkP6NZx4jynuBKJ3J084UQXxHfN+858mX70KiF/vVwmU8LCn3WMCs/9VD7y/EYVIH+6w1iarMub
 Cxveo+WIalZennUIp/dSxHHvtXz1sTI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_151628_212066_261BF611 
X-CRM114-Status: GOOD (  13.81  )
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

From: Marco Elver <elver@google.com>

With Context Analysis (viz. Clang's Thread Safety Analysis), list_heads
that are __guarded_by(..) require holding the appropriate context lock
when accessing and manipulating them via the list API. Because Clang's
warning diagnostics do not perform inter-procedural analysis, this is
enforced by Clang with -Wthread-safety-pointer in the caller at the call
boundary; a warning is produced when passing a pointer to a guarded
variable without holding the appropriate context locks:

  warning: passing pointer to variable 'list' requires holding [...] [-Wthread-safety-pointer]
           if (list_empty(&ctrl->list))

An exception is list_empty_careful(), which is like list_empty(), except
that it is permitted to use without holding any context lock (carefully).

Mark list_empty_careful() __context_unsafe, which disables context
analysis within list_empty_careful(), but also suppresses warnings
generated in callers related to its pointer arguments.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/list.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/list.h b/include/linux/list.h
index f6f22c8b06f7..19212bfc3f6d 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -444,6 +444,7 @@ static inline void list_del_init_careful(struct list_head *entry)
  * if another CPU could re-list_add() it.
  */
 static inline int list_empty_careful(const struct list_head *head)
+	__context_unsafe(/* intentional lockless access to @head */)
 {
 	struct list_head *next = smp_load_acquire(&head->next);
 	return list_is_head(next, head) && (next == READ_ONCE(head->prev));
-- 
2.53.0


